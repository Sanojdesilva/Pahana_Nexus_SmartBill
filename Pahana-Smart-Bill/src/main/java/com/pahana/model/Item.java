package com.pahana.model;

import java.util.Date;

public class Item {
    private int id;
    private String code;
    private String name;
    private String description;
    private String category;
    private double price;
    private int stockQuantity;
    private int reorderLevel;
    private String supplierInfo;
    private boolean isActive;
    private Date createdAt;
    private Date updatedAt;
    private String createdBy;

    public Item() {}

    public Item(int id, String code, String name, String description, String category, double price, int stockQuantity, int reorderLevel, String supplierInfo, boolean isActive, Date createdAt, Date updatedAt, String createdBy) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.description = description;
        this.category = category;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.reorderLevel = reorderLevel;
        this.supplierInfo = supplierInfo;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.createdBy = createdBy;
    }

    // Getters and setters for all fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }
    public int getReorderLevel() { return reorderLevel; }
    public void setReorderLevel(int reorderLevel) { this.reorderLevel = reorderLevel; }
    public String getSupplierInfo() { return supplierInfo; }
    public void setSupplierInfo(String supplierInfo) { this.supplierInfo = supplierInfo; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
    
    // Method to generate item code based on category and name
    public void generateItemCode() {
        if (this.code == null || this.code.isEmpty()) {
            String categoryPrefix = "";
            
            // Generate prefix based on category
            switch (this.category != null ? this.category.toUpperCase() : "OTHER") {
                case "ELECTRICITY":
                    categoryPrefix = "ELEC";
                    break;
                case "WATER":
                    categoryPrefix = "WATER";
                    break;
                case "GAS":
                    categoryPrefix = "GAS";
                    break;
                case "INTERNET":
                    categoryPrefix = "NET";
                    break;
                case "TELEPHONE":
                    categoryPrefix = "TEL";
                    break;
                default:
                    categoryPrefix = "ITEM";
            }
            
            // Generate code with timestamp and random number
            String timestamp = String.valueOf(System.currentTimeMillis());
            String random = String.valueOf((int)(Math.random() * 1000));
            this.code = categoryPrefix + timestamp.substring(timestamp.length() - 6) + random;
        }
    }
    
    // Method to check if stock is low
    public boolean isLowStock() {
        return this.stockQuantity <= this.reorderLevel;
    }
    
    // Method to update stock quantity
    public void updateStock(int quantity) {
        this.stockQuantity += quantity;
        if (this.stockQuantity < 0) {
            this.stockQuantity = 0;
        }
    }
    
    // Method to calculate total value of stock
    public double getStockValue() {
        return this.stockQuantity * this.price;
    }
} 