package com.pahana.model;

import java.util.Date;

public class BillItem {
    private int id;
    private int billId;
    private int itemId;
    private int quantity;
    private double unitPrice;
    private double totalPrice;
    private Date createdAt;
    
    // Additional fields for item details (for display purposes)
    private String itemName;
    private String itemCode;
    private String itemCategory;

    public BillItem() {}

    public BillItem(int id, int billId, int itemId, int quantity, double unitPrice, double totalPrice, Date createdAt) {
        this.id = id;
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    // Additional getters and setters for display fields
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public String getItemCode() { return itemCode; }
    public void setItemCode(String itemCode) { this.itemCode = itemCode; }
    public String getItemCategory() { return itemCategory; }
    public void setItemCategory(String itemCategory) { this.itemCategory = itemCategory; }
    
    // Method to calculate total price
    public void calculateTotalPrice() {
        this.totalPrice = this.quantity * this.unitPrice;
        // Round to 2 decimal places
        this.totalPrice = Math.round(this.totalPrice * 100.0) / 100.0;
    }
    
    // Method to update quantity and recalculate total
    public void updateQuantity(int newQuantity) {
        this.quantity = newQuantity;
        calculateTotalPrice();
    }
    
    // Method to update unit price and recalculate total
    public void updateUnitPrice(double newUnitPrice) {
        this.unitPrice = newUnitPrice;
        calculateTotalPrice();
    }
} 