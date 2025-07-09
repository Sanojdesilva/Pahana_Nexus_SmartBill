package com.pahana.service;

import com.pahana.model.Bill;
import com.pahana.model.Customer;
import com.pahana.model.Item;
import com.pahana.dao.BillDAO;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ReportService {
    
    private static final Font TITLE_FONT = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
    private static final Font HEADER_FONT = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
    private static final Font NORMAL_FONT = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL);
    private static final Font SMALL_FONT = new Font(Font.FontFamily.HELVETICA, 8, Font.NORMAL);
    
    public List<Bill> getBillsByDateRange(String startDate, String endDate) {
        // This would typically query the database with date filters
        // For now, return all bills
        return new BillDAO().getAllBills();
    }
    
    public byte[] generatePDFReport(String reportType, Object... params) throws Exception {
        switch (reportType.toLowerCase()) {
            case "sales":
                return generateSalesReportPDF((List<Bill>) params[0], (Double) params[1], (Double) params[2]);
            case "customers":
                return generateCustomerReportPDF((List<Customer>) params[0], (List<Customer>) params[1]);
            case "inventory":
                return generateInventoryReportPDF((List<Item>) params[0], (List<Item>) params[1], (Double) params[2]);
            case "bills":
                return generateBillsReportPDF((List<Bill>) params[0], (Double) params[1]);
            default:
                throw new IllegalArgumentException("Unknown report type: " + reportType);
        }
    }
    
    public byte[] generateSalesReportPDF(List<Bill> bills, double totalRevenue, double avgBillAmount) throws Exception {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        
        document.open();
        
        // Title
        Paragraph title = new Paragraph("Sales Report", TITLE_FONT);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));
        
        // Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Paragraph date = new Paragraph("Generated on: " + sdf.format(new Date()), SMALL_FONT);
        date.setAlignment(Element.ALIGN_RIGHT);
        document.add(date);
        document.add(new Paragraph(" "));
        
        // Summary
        PdfPTable summaryTable = new PdfPTable(2);
        summaryTable.setWidthPercentage(100);
        
        addSummaryRow(summaryTable, "Total Bills", String.valueOf(bills.size()));
        addSummaryRow(summaryTable, "Total Revenue", "$" + String.format("%.2f", totalRevenue));
        addSummaryRow(summaryTable, "Average Bill Amount", "$" + String.format("%.2f", avgBillAmount));
        
        document.add(summaryTable);
        document.add(new Paragraph(" "));
        
        // Bills table
        if (!bills.isEmpty()) {
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            
            // Headers
            table.addCell(new PdfPCell(new Phrase("Bill #", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Customer", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Amount", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Status", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Date", HEADER_FONT)));
            
            // Data
            for (Bill bill : bills) {
                table.addCell(new PdfPCell(new Phrase(bill.getBillNumber(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(bill.getCustomerId(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase("$" + String.format("%.2f", bill.getTotal()), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(bill.getStatus(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(bill.getCreatedAt().toString(), SMALL_FONT)));
            }
            
            document.add(table);
        }
        
        document.close();
        return baos.toByteArray();
    }
    
    public byte[] generateCustomerReportPDF(List<Customer> customers, List<Customer> activeCustomers) throws Exception {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        
        document.open();
        
        // Title
        Paragraph title = new Paragraph("Customer Report", TITLE_FONT);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));
        
        // Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Paragraph date = new Paragraph("Generated on: " + sdf.format(new Date()), SMALL_FONT);
        date.setAlignment(Element.ALIGN_RIGHT);
        document.add(date);
        document.add(new Paragraph(" "));
        
        // Summary
        PdfPTable summaryTable = new PdfPTable(2);
        summaryTable.setWidthPercentage(100);
        
        addSummaryRow(summaryTable, "Total Customers", String.valueOf(customers.size()));
        addSummaryRow(summaryTable, "Active Customers", String.valueOf(activeCustomers.size()));
        addSummaryRow(summaryTable, "Inactive Customers", String.valueOf(customers.size() - activeCustomers.size()));
        
        document.add(summaryTable);
        document.add(new Paragraph(" "));
        
        // Customers table
        if (!customers.isEmpty()) {
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            
            // Headers
            table.addCell(new PdfPCell(new Phrase("Account #", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Name", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Email", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Phone", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Status", HEADER_FONT)));
            
            // Data
            for (Customer customer : customers) {
                table.addCell(new PdfPCell(new Phrase(customer.getAccountNumber(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(customer.getName(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(customer.getEmail(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(customer.getPhone(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(customer.isActive() ? "Active" : "Inactive", NORMAL_FONT)));
            }
            
            document.add(table);
        }
        
        document.close();
        return baos.toByteArray();
    }
    
    public byte[] generateInventoryReportPDF(List<Item> items, List<Item> activeItems, double totalValue) throws Exception {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        
        document.open();
        
        // Title
        Paragraph title = new Paragraph("Inventory Report", TITLE_FONT);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));
        
        // Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Paragraph date = new Paragraph("Generated on: " + sdf.format(new Date()), SMALL_FONT);
        date.setAlignment(Element.ALIGN_RIGHT);
        document.add(date);
        document.add(new Paragraph(" "));
        
        // Summary
        PdfPTable summaryTable = new PdfPTable(2);
        summaryTable.setWidthPercentage(100);
        
        addSummaryRow(summaryTable, "Total Items", String.valueOf(items.size()));
        addSummaryRow(summaryTable, "Active Items", String.valueOf(activeItems.size()));
        addSummaryRow(summaryTable, "Total Inventory Value", "$" + String.format("%.2f", totalValue));
        
        document.add(summaryTable);
        document.add(new Paragraph(" "));
        
        // Items table
        if (!items.isEmpty()) {
            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);
            
            // Headers
            table.addCell(new PdfPCell(new Phrase("Code", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Name", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Category", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Price", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Stock", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Status", HEADER_FONT)));
            
            // Data
            for (Item item : items) {
                table.addCell(new PdfPCell(new Phrase(item.getCode(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(item.getName(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(item.getCategory(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase("$" + String.format("%.2f", item.getPrice()), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(String.valueOf(item.getStockQuantity()), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(item.isActive() ? "Active" : "Inactive", NORMAL_FONT)));
            }
            
            document.add(table);
        }
        
        document.close();
        return baos.toByteArray();
    }
    
    public byte[] generateBillsReportPDF(List<Bill> bills, double totalAmount) throws Exception {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        
        document.open();
        
        // Title
        Paragraph title = new Paragraph("Bills Report", TITLE_FONT);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));
        
        // Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Paragraph date = new Paragraph("Generated on: " + sdf.format(new Date()), SMALL_FONT);
        date.setAlignment(Element.ALIGN_RIGHT);
        document.add(date);
        document.add(new Paragraph(" "));
        
        // Summary
        PdfPTable summaryTable = new PdfPTable(2);
        summaryTable.setWidthPercentage(100);
        
        addSummaryRow(summaryTable, "Total Bills", String.valueOf(bills.size()));
        addSummaryRow(summaryTable, "Total Amount", "$" + String.format("%.2f", totalAmount));
        
        document.add(summaryTable);
        document.add(new Paragraph(" "));
        
        // Bills table
        if (!bills.isEmpty()) {
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            
            // Headers
            table.addCell(new PdfPCell(new Phrase("Bill #", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Customer", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Amount", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Status", HEADER_FONT)));
            table.addCell(new PdfPCell(new Phrase("Date", HEADER_FONT)));
            
            // Data
            for (Bill bill : bills) {
                table.addCell(new PdfPCell(new Phrase(bill.getBillNumber(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(bill.getCustomerId(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase("$" + String.format("%.2f", bill.getTotal()), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(bill.getStatus(), NORMAL_FONT)));
                table.addCell(new PdfPCell(new Phrase(bill.getCreatedAt().toString(), SMALL_FONT)));
            }
            
            document.add(table);
        }
        
        document.close();
        return baos.toByteArray();
    }
    
    private void addSummaryRow(PdfPTable table, String label, String value) {
        PdfPCell labelCell = new PdfPCell(new Phrase(label, HEADER_FONT));
        PdfPCell valueCell = new PdfPCell(new Phrase(value, NORMAL_FONT));
        
        labelCell.setBorder(Rectangle.NO_BORDER);
        valueCell.setBorder(Rectangle.NO_BORDER);
        
        table.addCell(labelCell);
        table.addCell(valueCell);
    }
    
    public byte[] generateBillPDF(Bill bill, Customer customer) throws Exception {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        
        document.open();
        
        // Header
        Paragraph title = new Paragraph("PAHANA SMART BILL", TITLE_FONT);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));
        
        // Bill Information
        PdfPTable billInfo = new PdfPTable(2);
        billInfo.setWidthPercentage(100);
        
        addSummaryRow(billInfo, "Bill Number:", bill.getBillNumber());
        addSummaryRow(billInfo, "Bill Date:", bill.getCreatedAt().toString());
        addSummaryRow(billInfo, "Status:", bill.getStatus());
        
        document.add(billInfo);
        document.add(new Paragraph(" "));
        
        // Customer Information
        Paragraph customerTitle = new Paragraph("Customer Information", HEADER_FONT);
        document.add(customerTitle);
        document.add(new Paragraph(" "));
        
        PdfPTable customerInfo = new PdfPTable(2);
        customerInfo.setWidthPercentage(100);
        
        addSummaryRow(customerInfo, "Name:", customer.getName());
        addSummaryRow(customerInfo, "Account Number:", customer.getAccountNumber());
        addSummaryRow(customerInfo, "Email:", customer.getEmail());
        addSummaryRow(customerInfo, "Phone:", customer.getPhone());
        addSummaryRow(customerInfo, "Address:", customer.getAddress());
        
        document.add(customerInfo);
        document.add(new Paragraph(" "));
        
        // Bill Details
        Paragraph detailsTitle = new Paragraph("Bill Details", HEADER_FONT);
        document.add(detailsTitle);
        document.add(new Paragraph(" "));
        
        PdfPTable billDetails = new PdfPTable(2);
        billDetails.setWidthPercentage(100);
        
        addSummaryRow(billDetails, "Units Consumed:", String.valueOf(bill.getUnitsConsumed()));
        addSummaryRow(billDetails, "Unit Rate:", "$" + String.format("%.2f", bill.getUnitRate()));
        addSummaryRow(billDetails, "Subtotal:", "$" + String.format("%.2f", bill.getSubtotal()));
        addSummaryRow(billDetails, "Tax Amount:", "$" + String.format("%.2f", bill.getTaxAmount()));
        addSummaryRow(billDetails, "Total Amount:", "$" + String.format("%.2f", bill.getTotal()));
        
        document.add(billDetails);
        document.add(new Paragraph(" "));
        
        // Notes
        if (bill.getNotes() != null && !bill.getNotes().isEmpty()) {
            Paragraph notesTitle = new Paragraph("Notes:", HEADER_FONT);
            document.add(notesTitle);
            document.add(new Paragraph(bill.getNotes(), NORMAL_FONT));
            document.add(new Paragraph(" "));
        }
        
        // Footer
        Paragraph footer = new Paragraph("Thank you for your business!", NORMAL_FONT);
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);
        
        document.close();
        return baos.toByteArray();
    }
} 