package com.pahana.dao;

import com.pahana.model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    
    public boolean createCustomer(Customer customer) {
        String sql = "INSERT INTO customers (id, name, email, phone, address, is_active, account_number, units_consumed, unit_rate, customer_type, consumption_tier, created_at, last_billing_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Generate account number if not provided
            customer.generateAccountNumber();
            
            // Calculate unit rate based on customer type and consumption tier
            customer.calculateUnitRate();
            
            pstmt.setString(1, customer.getId());
            pstmt.setString(2, customer.getName());
            pstmt.setString(3, customer.getEmail());
            pstmt.setString(4, customer.getPhone());
            pstmt.setString(5, customer.getAddress());
            pstmt.setBoolean(6, customer.isActive());
            pstmt.setString(7, customer.getAccountNumber());
            pstmt.setInt(8, customer.getUnitsConsumed());
            pstmt.setDouble(9, customer.getUnitRate());
            pstmt.setString(10, customer.getCustomerType());
            pstmt.setString(11, customer.getConsumptionTier());
            pstmt.setTimestamp(12, new Timestamp(customer.getCreatedAt().getTime()));
            pstmt.setTimestamp(13, customer.getLastBillingDate() != null ? new Timestamp(customer.getLastBillingDate().getTime()) : null);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating customer: " + e.getMessage());
            return false;
        }
    }
    
    public Customer getCustomerById(String id) {
        String sql = "SELECT * FROM customers WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToCustomer(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by ID: " + e.getMessage());
        }
        return null;
    }
    
    public Customer getCustomerByAccountNumber(String accountNumber) {
        String sql = "SELECT * FROM customers WHERE account_number = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, accountNumber);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToCustomer(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by account number: " + e.getMessage());
        }
        return null;
    }
    
    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT * FROM customers WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToCustomer(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by email: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customers SET name=?, email=?, phone=?, address=?, is_active=?, units_consumed=?, unit_rate=?, customer_type=?, consumption_tier=?, last_billing_date=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Recalculate unit rate if customer type or consumption tier changed
            customer.calculateUnitRate();
            
            pstmt.setString(1, customer.getName());
            pstmt.setString(2, customer.getEmail());
            pstmt.setString(3, customer.getPhone());
            pstmt.setString(4, customer.getAddress());
            pstmt.setBoolean(5, customer.isActive());
            pstmt.setInt(6, customer.getUnitsConsumed());
            pstmt.setDouble(7, customer.getUnitRate());
            pstmt.setString(8, customer.getCustomerType());
            pstmt.setString(9, customer.getConsumptionTier());
            pstmt.setTimestamp(10, customer.getLastBillingDate() != null ? new Timestamp(customer.getLastBillingDate().getTime()) : null);
            pstmt.setString(11, customer.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating customer: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteCustomer(String id) {
        String sql = "DELETE FROM customers WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting customer: " + e.getMessage());
            return false;
        }
    }
    
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all customers: " + e.getMessage());
        }
        return customers;
    }
    
    public List<Customer> getActiveCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE is_active = true ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting active customers: " + e.getMessage());
        }
        return customers;
    }
    
    public boolean toggleCustomerStatus(String id) {
        String sql = "UPDATE customers SET is_active = NOT is_active WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error toggling customer status: " + e.getMessage());
            return false;
        }
    }
    
    public List<Customer> searchCustomers(String search, String status) {
        List<Customer> customers = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM customers WHERE 1=1");
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR email LIKE ? OR account_number LIKE ?)");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND is_active = ?");
        }
        sql.append(" ORDER BY created_at DESC");
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (search != null && !search.trim().isEmpty()) {
                pstmt.setString(idx++, "%" + search + "%");
                pstmt.setString(idx++, "%" + search + "%");
                pstmt.setString(idx++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                pstmt.setBoolean(idx++, "ACTIVE".equalsIgnoreCase(status));
            }
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching customers: " + e.getMessage());
        }
        return customers;
    }
    
    public List<Customer> getCustomersByDateRange(java.util.Date startDate, java.util.Date endDate) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE created_at >= ? AND created_at <= ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setTimestamp(1, new Timestamp(startDate.getTime()));
            pstmt.setTimestamp(2, new Timestamp(endDate.getTime()));
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting customers by date range: " + e.getMessage());
        }
        return customers;
    }
    
    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setId(rs.getString("id"));
        customer.setName(rs.getString("name"));
        customer.setEmail(rs.getString("email"));
        customer.setPhone(rs.getString("phone"));
        customer.setAddress(rs.getString("address"));
        customer.setActive(rs.getBoolean("is_active"));
        customer.setAccountNumber(rs.getString("account_number"));
        customer.setUnitsConsumed(rs.getInt("units_consumed"));
        customer.setUnitRate(rs.getDouble("unit_rate"));
        customer.setCustomerType(rs.getString("customer_type"));
        customer.setConsumptionTier(rs.getString("consumption_tier"));
        customer.setCreatedAt(rs.getTimestamp("created_at"));
        customer.setLastBillingDate(rs.getTimestamp("last_billing_date"));
        return customer;
    }
} 