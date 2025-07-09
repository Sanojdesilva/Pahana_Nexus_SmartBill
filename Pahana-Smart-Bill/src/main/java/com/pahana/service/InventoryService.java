package com.pahana.service;

import com.pahana.dao.BillDAO;
import com.pahana.dao.BillItemDAO;
import com.pahana.dao.CustomerDAO;
import com.pahana.dao.ItemDAO;
import com.pahana.model.Bill;
import com.pahana.model.BillItem;
import com.pahana.model.Customer;
import com.pahana.model.Item;

import java.util.Date;
import java.util.List;
import java.util.UUID;

public class InventoryService {
    
    private BillDAO billDAO;
    private BillItemDAO billItemDAO;
    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;
    
    public InventoryService() {
        this.billDAO = new BillDAO();
        this.billItemDAO = new BillItemDAO();
        this.customerDAO = new CustomerDAO();
        this.itemDAO = new ItemDAO();
    }
    
    /**
     * Create a new bill with items and update inventory
     */
    public boolean createBillWithItems(Bill bill, List<BillItem> billItems) {
        try {
            // Use the bill number that was already set in the servlet
            // bill.setBillNumber(generateBillNumber()); // Removed - bill number is already set
            
            // Calculate bill totals (if not already calculated)
            double subtotal = 0;
            for (BillItem item : billItems) {
                item.calculateTotalPrice();
                subtotal += item.getTotalPrice();
            }
            
            // Only set totals if not already set
            if (bill.getSubtotal() == 0) {
                bill.setSubtotal(subtotal);
                bill.setTaxAmount(subtotal * 0.15); // 15% tax
                bill.setTotal(subtotal + bill.getTaxAmount());
                bill.setTaxRate(15.0);
            }
            
            // Create the bill
            if (!billDAO.createBill(bill)) {
                return false;
            }
            
            // Get the created bill to get its ID
            Bill createdBill = billDAO.getBillByNumber(bill.getBillNumber());
            if (createdBill == null) {
                return false;
            }
            
            // Create bill items and update inventory
            for (BillItem billItem : billItems) {
                billItem.setBillId(createdBill.getId());
                
                // Create bill item
                if (!billItemDAO.createBillItem(billItem)) {
                    return false;
                }
                
                // Update item stock
                if (!updateItemStock(billItem.getItemId(), billItem.getQuantity())) {
                    return false;
                }
            }
            
            // Update customer's last billing date
            Customer customer = customerDAO.getCustomerById(bill.getCustomerId());
            if (customer != null) {
                customer.setLastBillingDate(new Date());
                customerDAO.updateCustomer(customer);
            }
            
            return true;
        } catch (Exception e) {
            System.err.println("Error creating bill with items: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Update item stock when sold (reduce stock)
     */
    public boolean updateItemStock(int itemId, int quantity) {
        try {
            Item item = itemDAO.getItemById(itemId);
            if (item == null) {
                return false;
            }
            
            // Check if enough stock is available
            if (item.getStockQuantity() < quantity) {
                return false;
            }
            
            // Reduce stock
            return itemDAO.reduceStock(itemId, quantity);
        } catch (Exception e) {
            System.err.println("Error updating item stock: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Restore item stock when bill is cancelled (increase stock)
     */
    public boolean restoreItemStock(int itemId, int quantity) {
        try {
            Item item = itemDAO.getItemById(itemId);
            if (item == null) {
                return false;
            }
            
            // Increase stock
            return itemDAO.increaseStock(itemId, quantity);
        } catch (Exception e) {
            System.err.println("Error restoring item stock: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get items with low stock
     */
    public List<Item> getLowStockItems() {
        return itemDAO.getLowStockItems();
    }
    
    /**
     * Check if item has sufficient stock
     */
    public boolean hasSufficientStock(int itemId, int quantity) {
        try {
            Item item = itemDAO.getItemById(itemId);
            return item != null && item.getStockQuantity() >= quantity;
        } catch (Exception e) {
            System.err.println("Error checking stock: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get item stock information
     */
    public Item getItemStockInfo(int itemId) {
        return itemDAO.getItemById(itemId);
    }
    
    /**
     * Generate unique bill number
     */
    private String generateBillNumber() {
        String timestamp = String.valueOf(System.currentTimeMillis());
        String random = String.valueOf((int)(Math.random() * 1000));
        return "BILL" + timestamp.substring(timestamp.length() - 8) + random;
    }
    
    /**
     * Process bill payment and update inventory
     */
    public boolean processBillPayment(int billId) {
        try {
            Bill bill = billDAO.getBillById(billId);
            if (bill == null) {
                return false;
            }
            
            // Update bill status to paid
            bill.setStatus("PAID");
            bill.setPaidDate(new Date());
            
            return billDAO.updateBill(bill);
        } catch (Exception e) {
            System.err.println("Error processing bill payment: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Cancel bill and restore inventory
     */
    public boolean cancelBill(int billId) {
        try {
            Bill bill = billDAO.getBillById(billId);
            if (bill == null) {
                return false;
            }
            
            // Get bill items
            List<BillItem> billItems = billItemDAO.getBillItemsByBillId(billId);
            
            // Restore inventory for each item
            for (BillItem billItem : billItems) {
                if (!restoreItemStock(billItem.getItemId(), billItem.getQuantity())) {
                    System.err.println("Failed to restore stock for item ID: " + billItem.getItemId());
                    return false;
                }
            }
            
            // Update bill status
            bill.setStatus("CANCELLED");
            return billDAO.updateBill(bill);
        } catch (Exception e) {
            System.err.println("Error cancelling bill: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get inventory summary
     */
    public InventorySummary getInventorySummary() {
        try {
            List<Item> allItems = itemDAO.getAllItems();
            List<Item> lowStockItems = itemDAO.getLowStockItems();
            
            double totalValue = 0;
            int totalItems = 0;
            int lowStockCount = 0;
            
            for (Item item : allItems) {
                if (item.isActive()) {
                    totalValue += item.getStockValue();
                    totalItems++;
                }
            }
            
            lowStockCount = lowStockItems.size();
            
            return new InventorySummary(totalItems, totalValue, lowStockCount);
        } catch (Exception e) {
            System.err.println("Error getting inventory summary: " + e.getMessage());
            return new InventorySummary(0, 0, 0);
        }
    }
    
    /**
     * Inner class for inventory summary
     */
    public static class InventorySummary {
        private int totalItems;
        private double totalValue;
        private int lowStockCount;
        
        public InventorySummary(int totalItems, double totalValue, int lowStockCount) {
            this.totalItems = totalItems;
            this.totalValue = totalValue;
            this.lowStockCount = lowStockCount;
        }
        
        public int getTotalItems() { return totalItems; }
        public double getTotalValue() { return totalValue; }
        public int getLowStockCount() { return lowStockCount; }
    }
} 