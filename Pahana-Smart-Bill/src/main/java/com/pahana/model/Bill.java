package com.pahana.model;

import java.util.Date;

public class Bill {
    private int id;
    private String customerId;
    private String userId;
    private String status;
    private double total;
    private Date createdAt;
    private Date updatedAt;
    private String billNumber;
    private double subtotal;
    private double taxAmount;
    private double taxRate;
    private int unitsConsumed;
    private double unitRate;
    private Date dueDate;
    private Date paidDate;
    private String notes;
    private String paymentMethod;

    public Bill() {}

    public Bill(int id, String customerId, String userId, String status, double total, Date createdAt, Date updatedAt, String billNumber, double subtotal, double taxAmount, double taxRate, int unitsConsumed, double unitRate, Date dueDate, Date paidDate, String notes, String paymentMethod) {
        this.id = id;
        this.customerId = customerId;
        this.userId = userId;
        this.status = status;
        this.total = total;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.billNumber = billNumber;
        this.subtotal = subtotal;
        this.taxAmount = taxAmount;
        this.taxRate = taxRate;
        this.unitsConsumed = unitsConsumed;
        this.unitRate = unitRate;
        this.dueDate = dueDate;
        this.paidDate = paidDate;
        this.notes = notes;
        this.paymentMethod = paymentMethod;
    }

    // Getters and setters for all fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
    public String getBillNumber() { return billNumber; }
    public void setBillNumber(String billNumber) { this.billNumber = billNumber; }
    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
    public double getTaxAmount() { return taxAmount; }
    public void setTaxAmount(double taxAmount) { this.taxAmount = taxAmount; }
    public double getTaxRate() { return taxRate; }
    public void setTaxRate(double taxRate) { this.taxRate = taxRate; }
    public int getUnitsConsumed() { return unitsConsumed; }
    public void setUnitsConsumed(int unitsConsumed) { this.unitsConsumed = unitsConsumed; }
    public double getUnitRate() { return unitRate; }
    public void setUnitRate(double unitRate) { this.unitRate = unitRate; }
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
    public Date getPaidDate() { return paidDate; }
    public void setPaidDate(Date paidDate) { this.paidDate = paidDate; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
} 