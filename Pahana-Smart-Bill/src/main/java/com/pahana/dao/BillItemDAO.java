package com.pahana.dao;

import com.pahana.model.BillItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillItemDAO {
    
    public boolean createBillItem(BillItem billItem) {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price, created_at) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            billItem.calculateTotalPrice();
            pstmt.setInt(1, billItem.getBillId());
            pstmt.setInt(2, billItem.getItemId());
            pstmt.setInt(3, billItem.getQuantity());
            pstmt.setDouble(4, billItem.getUnitPrice());
            pstmt.setDouble(5, billItem.getTotalPrice());
            pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating bill item: " + e.getMessage());
            return false;
        }
    }
    
    public List<BillItem> getBillItemsByBillId(int billId) {
        List<BillItem> billItems = new ArrayList<>();
        String sql = "SELECT bi.*, i.name as item_name, i.code as item_code, i.category as item_category " +
                     "FROM bill_items bi " +
                     "JOIN items i ON bi.item_id = i.id " +
                     "WHERE bi.bill_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                billItems.add(mapResultSetToBillItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bill items by bill ID: " + e.getMessage());
        }
        return billItems;
    }
    
    public boolean updateBillItem(BillItem billItem) {
        String sql = "UPDATE bill_items SET quantity = ?, unit_price = ?, total_price = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Recalculate total price
            billItem.calculateTotalPrice();
            
            pstmt.setInt(1, billItem.getQuantity());
            pstmt.setDouble(2, billItem.getUnitPrice());
            pstmt.setDouble(3, billItem.getTotalPrice());
            pstmt.setInt(4, billItem.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating bill item: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBillItem(int id) {
        String sql = "DELETE FROM bill_items WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting bill item: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteAllBillItems(int billId) {
        String sql = "DELETE FROM bill_items WHERE bill_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting all bill items: " + e.getMessage());
            return false;
        }
    }
    
    public List<BillItem> getAllBillItems() {
        List<BillItem> billItems = new ArrayList<>();
        String sql = "SELECT bi.*, i.name as item_name, i.code as item_code, i.category as item_category " +
                     "FROM bill_items bi " +
                     "JOIN items i ON bi.item_id = i.id " +
                     "ORDER BY bi.bill_id, bi.created_at";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                billItems.add(mapResultSetToBillItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all bill items: " + e.getMessage());
        }
        return billItems;
    }
    
    // Method to get bill items with item details for a specific bill
    public List<BillItem> getBillItemsWithDetails(int billId) {
        List<BillItem> billItems = new ArrayList<>();
        String sql = "SELECT bi.*, i.name as item_name, i.code as item_code, i.category as item_category " +
                     "FROM bill_items bi " +
                     "JOIN items i ON bi.item_id = i.id " +
                     "WHERE bi.bill_id = ? " +
                     "ORDER BY bi.created_at";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                billItems.add(mapResultSetToBillItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting bill items with details: " + e.getMessage());
        }
        return billItems;
    }
    
    private BillItem mapResultSetToBillItem(ResultSet rs) throws SQLException {
        BillItem billItem = new BillItem();
        billItem.setId(rs.getInt("id"));
        billItem.setBillId(rs.getInt("bill_id"));
        billItem.setItemId(rs.getInt("item_id"));
        billItem.setQuantity(rs.getInt("quantity"));
        billItem.setUnitPrice(rs.getDouble("unit_price"));
        billItem.setTotalPrice(rs.getDouble("total_price"));
        billItem.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Set item details if available
        try {
            billItem.setItemName(rs.getString("item_name"));
            billItem.setItemCode(rs.getString("item_code"));
            billItem.setItemCategory(rs.getString("item_category"));
        } catch (SQLException e) {
            // Item details not available, skip
        }
        
        return billItem;
    }
} 