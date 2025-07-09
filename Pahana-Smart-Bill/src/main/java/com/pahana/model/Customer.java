package com.pahana.model;

import java.util.Date;

public class Customer {
    private String id;
    private String name;
    private String email;
    private String phone;
    private String address;
    private boolean isActive;
    private String accountNumber;
    private int unitsConsumed;
    private double unitRate;
    private String customerType; // RESIDENTIAL, COMMERCIAL, INDUSTRIAL
    private String consumptionTier; // LOW, MEDIUM, HIGH
    private Date createdAt;
    private Date lastBillingDate;

    public Customer() {}

    public Customer(String id, String name, String email, String phone, String address, boolean isActive, String accountNumber, int unitsConsumed, double unitRate, String customerType, String consumptionTier, Date createdAt, Date lastBillingDate) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.isActive = isActive;
        this.accountNumber = accountNumber;
        this.unitsConsumed = unitsConsumed;
        this.unitRate = unitRate;
        this.customerType = customerType;
        this.consumptionTier = consumptionTier;
        this.createdAt = createdAt;
        this.lastBillingDate = lastBillingDate;
    }

    // Getters and setters for all fields
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }
    public int getUnitsConsumed() { return unitsConsumed; }
    public void setUnitsConsumed(int unitsConsumed) { this.unitsConsumed = unitsConsumed; }
    public double getUnitRate() { return unitRate; }
    public void setUnitRate(double unitRate) { this.unitRate = unitRate; }
    public String getCustomerType() { return customerType; }
    public void setCustomerType(String customerType) { this.customerType = customerType; }
    public String getConsumptionTier() { return consumptionTier; }
    public void setConsumptionTier(String consumptionTier) { this.consumptionTier = consumptionTier; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public Date getLastBillingDate() { return lastBillingDate; }
    public void setLastBillingDate(Date lastBillingDate) { this.lastBillingDate = lastBillingDate; }
    
    // Method to calculate unit rate based on customer type and consumption tier
    public void calculateUnitRate() {
        double baseRate = 0.0;
        
        // Base rates by customer type
        switch (this.customerType != null ? this.customerType.toUpperCase() : "RESIDENTIAL") {
            case "RESIDENTIAL":
                baseRate = 0.12;
                break;
            case "COMMERCIAL":
                baseRate = 0.18;
                break;
            case "INDUSTRIAL":
                baseRate = 0.25;
                break;
            default:
                baseRate = 0.12;
        }
        
        // Apply consumption tier multiplier
        switch (this.consumptionTier != null ? this.consumptionTier.toUpperCase() : "LOW") {
            case "LOW":
                this.unitRate = baseRate * 0.9; // 10% discount for low consumption
                break;
            case "MEDIUM":
                this.unitRate = baseRate; // Standard rate
                break;
            case "HIGH":
                this.unitRate = baseRate * 1.15; // 15% premium for high consumption
                break;
            default:
                this.unitRate = baseRate;
        }
        
        // Round to 2 decimal places
        this.unitRate = Math.round(this.unitRate * 100.0) / 100.0;
    }
    
    // Method to generate account number
    public void generateAccountNumber() {
        if (this.accountNumber == null || this.accountNumber.isEmpty()) {
            String prefix = "ACC";
            String timestamp = String.valueOf(System.currentTimeMillis());
            String random = String.valueOf((int)(Math.random() * 1000));
            this.accountNumber = prefix + timestamp.substring(timestamp.length() - 6) + random;
        }
    }
} 