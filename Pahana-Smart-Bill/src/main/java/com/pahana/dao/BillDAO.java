package com.pahana.dao;

import com.pahana.model.Bill;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {
    
    public boolean createBill(Bill bill) {
        String sql = "INSERT INTO bills (customer_id, user_id, status, total, created_at, updated_at, bill_number, subtotal, tax_amount, tax_rate, units_consumed, unit_rate, due_date, paid_date, notes, payment_method) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bill.getCustomerId());
            pstmt.setString(2, bill.getUserId());
            pstmt.setString(3, bill.getStatus());
            pstmt.setDouble(4, bill.getTotal());
            pstmt.setTimestamp(5, new Timestamp(bill.getCreatedAt().getTime()));
            pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(7, bill.getBillNumber());
            pstmt.setDouble(8, bill.getSubtotal());
            pstmt.setDouble(9, bill.getTaxAmount());
            pstmt.setDouble(10, bill.getTaxRate());
            pstmt.setInt(11, bill.getUnitsConsumed());
            pstmt.setDouble(12, bill.getUnitRate());
            pstmt.setTimestamp(13, bill.getDueDate() != null ? new Timestamp(bill.getDueDate().getTime()) : null);
            pstmt.setTimestamp(14, bill.getPaidDate() != null ? new Timestamp(bill.getPaidDate().getTime()) : null);
            pstmt.setString(15, bill.getNotes());
            pstmt.setString(16, bill.getPaymentMethod());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating bill: " + e.getMessage());
            return false;
        }
    }
    
    public Bill getBillById(int id) {
        String sql = "SELECT * FROM bills WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBill(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting bill by ID: " + e.getMessage());
        }
        return null;
    }
    
    public Bill getBillByNumber(String billNumber) {
        String sql = "SELECT * FROM bills WHERE bill_number = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, billNumber);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBill(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting bill by number: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateBill(Bill bill) {
        String sql = "UPDATE bills SET customer_id=?, user_id=?, status=?, total=?, updated_at=?, subtotal=?, tax_amount=?, tax_rate=?, units_consumed=?, unit_rate=?, due_date=?, paid_date=?, notes=?, payment_method=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bill.getCustomerId());
            pstmt.setString(2, bill.getUserId());
            pstmt.setString(3, bill.getStatus());
            pstmt.setDouble(4, bill.getTotal());
            pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            pstmt.setDouble(6, bill.getSubtotal());
            pstmt.setDouble(7, bill.getTaxAmount());
            pstmt.setDouble(8, bill.getTaxRate());
            pstmt.setInt(9, bill.getUnitsConsumed());
            pstmt.setDouble(10, bill.getUnitRate());
            pstmt.setTimestamp(11, bill.getDueDate() != null ? new Timestamp(bill.getDueDate().getTime()) : null);
            pstmt.setTimestamp(12, bill.getPaidDate() != null ? new Timestamp(bill.getPaidDate().getTime()) : null);
            pstmt.setString(13, bill.getNotes());
            pstmt.setString(14, bill.getPaymentMethod());
            pstmt.setInt(15, bill.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating bill: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBill(int id) {
        String sql = "DELETE FROM bills WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting bill: " + e.getMessage());
            return false;
        }
    }
    
    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                bills.add(mapResultSetToBill(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all bills: " + e.getMessage());
        }
        return bills;
    }
    
    public List<Bill> getBillsByCustomer(String customerId) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE customer_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, customerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                bills.add(mapResultSetToBill(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bills by customer: " + e.getMessage());
        }
        return bills;
    }
    
    public List<Bill> getBillsByStatus(String status) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE status = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                bills.add(mapResultSetToBill(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bills by status: " + e.getMessage());
        }
        return bills;
    }
    
    public boolean updateBillStatus(int billId, String status) {
        String sql = "UPDATE bills SET status = ?, updated_at = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            pstmt.setInt(3, billId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating bill status: " + e.getMessage());
            return false;
        }
    }
    
    public List<Bill> searchBills(String search, String status) {
        List<Bill> bills = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT b.* FROM bills b LEFT JOIN customers c ON b.customer_id = c.id WHERE 1=1");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (b.bill_number LIKE ? OR c.name LIKE ?)");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND b.status = ?");
        }
        sql.append(" ORDER BY b.created_at DESC");
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int idx = 1;
            if (search != null && !search.trim().isEmpty()) {
                pstmt.setString(idx++, "%" + search + "%");
                pstmt.setString(idx++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                pstmt.setString(idx++, status);
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                bills.add(mapResultSetToBill(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching bills: " + e.getMessage());
        }
        return bills;
    }
    
    public List<Bill> getBillsByDateRange(java.util.Date startDate, java.util.Date endDate) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE created_at BETWEEN ? AND ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setTimestamp(1, new Timestamp(startDate.getTime()));
            pstmt.setTimestamp(2, new Timestamp(endDate.getTime()));
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                bills.add(mapResultSetToBill(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bills by date range: " + e.getMessage());
        }
        return bills;
    }
    
    private Bill mapResultSetToBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setId(rs.getInt("id"));
        bill.setCustomerId(rs.getString("customer_id"));
        bill.setUserId(rs.getString("user_id"));
        bill.setStatus(rs.getString("status"));
        bill.setTotal(rs.getDouble("total"));
        bill.setCreatedAt(rs.getTimestamp("created_at"));
        bill.setUpdatedAt(rs.getTimestamp("updated_at"));
        bill.setBillNumber(rs.getString("bill_number"));
        bill.setSubtotal(rs.getDouble("subtotal"));
        bill.setTaxAmount(rs.getDouble("tax_amount"));
        bill.setTaxRate(rs.getDouble("tax_rate"));
        bill.setUnitsConsumed(rs.getInt("units_consumed"));
        bill.setUnitRate(rs.getDouble("unit_rate"));
        bill.setDueDate(rs.getTimestamp("due_date"));
        bill.setPaidDate(rs.getTimestamp("paid_date"));
        bill.setNotes(rs.getString("notes"));
        bill.setPaymentMethod(rs.getString("payment_method"));
        return bill;
    }
} 