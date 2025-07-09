package com.pahana.dao;

import com.pahana.model.Item;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    
    public boolean createItem(Item item) {
        String sql = "INSERT INTO items (code, name, description, category, price, stock_quantity, reorder_level, supplier_info, is_active, created_at, updated_at, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Generate item code if not provided
            item.generateItemCode();
            
            pstmt.setString(1, item.getCode());
            pstmt.setString(2, item.getName());
            pstmt.setString(3, item.getDescription());
            pstmt.setString(4, item.getCategory());
            pstmt.setDouble(5, item.getPrice());
            pstmt.setInt(6, item.getStockQuantity());
            pstmt.setInt(7, item.getReorderLevel());
            pstmt.setString(8, item.getSupplierInfo());
            pstmt.setBoolean(9, item.isActive());
            pstmt.setTimestamp(10, new Timestamp(item.getCreatedAt().getTime()));
            pstmt.setTimestamp(11, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(12, item.getCreatedBy());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating item: " + e.getMessage());
            return false;
        }
    }
    
    public Item getItemById(int id) {
        String sql = "SELECT * FROM items WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToItem(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting item by ID: " + e.getMessage());
        }
        return null;
    }
    
    public Item getItemByCode(String code) {
        String sql = "SELECT * FROM items WHERE code = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, code);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToItem(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting item by code: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET code=?, name=?, description=?, category=?, price=?, stock_quantity=?, reorder_level=?, supplier_info=?, is_active=?, updated_at=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, item.getCode());
            pstmt.setString(2, item.getName());
            pstmt.setString(3, item.getDescription());
            pstmt.setString(4, item.getCategory());
            pstmt.setDouble(5, item.getPrice());
            pstmt.setInt(6, item.getStockQuantity());
            pstmt.setInt(7, item.getReorderLevel());
            pstmt.setString(8, item.getSupplierInfo());
            pstmt.setBoolean(9, item.isActive());
            pstmt.setTimestamp(10, new Timestamp(System.currentTimeMillis()));
            pstmt.setInt(11, item.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating item: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteItem(int id) {
        String sql = "DELETE FROM items WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting item: " + e.getMessage());
            return false;
        }
    }
    
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all items: " + e.getMessage());
        }
        return items;
    }
    
    public List<Item> getActiveItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE is_active = true ORDER BY name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting active items: " + e.getMessage());
        }
        return items;
    }
    
    public List<Item> getItemsByCategory(String category) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE category = ? AND is_active = true ORDER BY name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting items by category: " + e.getMessage());
        }
        return items;
    }
    
    public List<Item> searchItems(String search) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE (name LIKE ? OR code LIKE ? OR description LIKE ?) ORDER BY name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + search + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching items: " + e.getMessage());
        }
        return items;
    }
    
    public boolean updateStockQuantity(int itemId, int quantity) {
        String sql = "UPDATE items SET stock_quantity = ?, updated_at = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, quantity);
            pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            pstmt.setInt(3, itemId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating stock quantity: " + e.getMessage());
            return false;
        }
    }
    
    public boolean reduceStock(int itemId, int quantity) {
        String sql = "UPDATE items SET stock_quantity = stock_quantity - ?, updated_at = ? WHERE id = ? AND stock_quantity >= ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, quantity);
            pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            pstmt.setInt(3, itemId);
            pstmt.setInt(4, quantity);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error reducing stock: " + e.getMessage());
            return false;
        }
    }
    
    public List<Item> getLowStockItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE stock_quantity <= reorder_level AND is_active = true ORDER BY stock_quantity";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting low stock items: " + e.getMessage());
        }
        return items;
    }
    
    public List<Item> getItemsByDateRange(java.util.Date startDate, java.util.Date endDate) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE created_at BETWEEN ? AND ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setTimestamp(1, new Timestamp(startDate.getTime()));
            pstmt.setTimestamp(2, new Timestamp(endDate.getTime()));
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting items by date range: " + e.getMessage());
        }
        return items;
    }
    
    private Item mapResultSetToItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setCode(rs.getString("code"));
        item.setName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setCategory(rs.getString("category"));
        item.setPrice(rs.getDouble("price"));
        item.setStockQuantity(rs.getInt("stock_quantity"));
        item.setReorderLevel(rs.getInt("reorder_level"));
        item.setSupplierInfo(rs.getString("supplier_info"));
        item.setActive(rs.getBoolean("is_active"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        item.setUpdatedAt(rs.getTimestamp("updated_at"));
        item.setCreatedBy(rs.getString("created_by"));
        return item;
    }
} 