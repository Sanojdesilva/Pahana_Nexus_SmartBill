package com.pahana.controller;

import com.pahana.model.User;
import com.pahana.dao.BillDAO;
import com.pahana.dao.CustomerDAO;
import com.pahana.dao.ItemDAO;
import com.pahana.service.ReportService;
import java.io.IOException;
import java.util.List;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ReportServlet extends HttpServlet {
    
    private BillDAO billDAO;
    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;
    private ReportService reportService;
    
    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
        customerDAO = new CustomerDAO();
        itemDAO = new ItemDAO();
        reportService = new ReportService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String role = user.getRole();
        
        // Only ADMIN and EMPLOYEE can access reports
        if (!"ADMIN".equals(role) && !"EMPLOYEE".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Show reports dashboard
            showReportsDashboard(request, response);
        } else if (pathInfo.equals("/sales")) {
            // Sales report
            generateSalesReport(request, response);
        } else if (pathInfo.equals("/customers")) {
            // Customer report
            generateCustomerReport(request, response);
        } else if (pathInfo.equals("/inventory")) {
            // Inventory report
            generateInventoryReport(request, response);
        } else if (pathInfo.equals("/bills")) {
            // Bills report
            generateBillsReport(request, response);
        } else if (pathInfo.equals("/export")) {
            // Export report to PDF
            exportReportToPDF(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void showReportsDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get summary statistics for dashboard
            int totalBills = billDAO.getAllBills().size();
            int pendingBills = billDAO.getBillsByStatus("PENDING").size();
            int completedBills = billDAO.getBillsByStatus("COMPLETED").size();
            int totalCustomers = customerDAO.getAllCustomers().size();
            int activeCustomers = customerDAO.getActiveCustomers().size();
            int totalItems = itemDAO.getAllItems().size();
            int activeItems = itemDAO.getActiveItems().size();
            
            // Calculate total revenue
            double totalRevenue = billDAO.getAllBills().stream()
                .mapToDouble(bill -> bill.getTotal())
                .sum();
            
            request.setAttribute("totalBills", totalBills);
            request.setAttribute("pendingBills", pendingBills);
            request.setAttribute("completedBills", completedBills);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("activeCustomers", activeCustomers);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("activeItems", activeItems);
            request.setAttribute("totalRevenue", totalRevenue);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading report data: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/jsp/reports/dashboard.jsp").forward(request, response);
    }
    
    private void generateSalesReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String format = request.getParameter("format");
        
        try {
            List<com.pahana.model.Bill> bills;
            
            if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
                bills = reportService.getBillsByDateRange(startDate, endDate);
            } else {
                bills = billDAO.getAllBills();
            }
            
            double totalRevenue = bills.stream()
                .mapToDouble(bill -> bill.getTotal())
                .sum();
            
            double avgBillAmount = bills.isEmpty() ? 0 : totalRevenue / bills.size();
            
            request.setAttribute("bills", bills);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("avgBillAmount", avgBillAmount);
            request.setAttribute("totalBills", bills.size());
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            
            if ("pdf".equals(format)) {
                exportSalesReportToPDF(request, response, bills, totalRevenue, avgBillAmount);
            } else {
                request.getRequestDispatcher("/jsp/reports/sales.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating sales report: " + e.getMessage());
            request.getRequestDispatcher("/jsp/reports/sales.jsp").forward(request, response);
        }
    }
    
    private void generateCustomerReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String format = request.getParameter("format");
        
        try {
            List<com.pahana.model.Customer> customers = customerDAO.getAllCustomers();
            List<com.pahana.model.Customer> activeCustomers = customerDAO.getActiveCustomers();
            
            request.setAttribute("customers", customers);
            request.setAttribute("activeCustomers", activeCustomers);
            request.setAttribute("totalCustomers", customers.size());
            request.setAttribute("activeCustomerCount", activeCustomers.size());
            request.setAttribute("inactiveCustomerCount", customers.size() - activeCustomers.size());
            
            if ("pdf".equals(format)) {
                exportCustomerReportToPDF(request, response, customers, activeCustomers);
            } else {
                request.getRequestDispatcher("/jsp/reports/customers.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating customer report: " + e.getMessage());
            request.getRequestDispatcher("/jsp/reports/customers.jsp").forward(request, response);
        }
    }
    
    private void generateInventoryReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String format = request.getParameter("format");
        
        try {
            List<com.pahana.model.Item> items = itemDAO.getAllItems();
            List<com.pahana.model.Item> activeItems = itemDAO.getActiveItems();
            
            double totalValue = items.stream()
                .mapToDouble(item -> item.getPrice() * item.getStockQuantity())
                .sum();
            
            request.setAttribute("items", items);
            request.setAttribute("activeItems", activeItems);
            request.setAttribute("totalItems", items.size());
            request.setAttribute("activeItemCount", activeItems.size());
            request.setAttribute("totalValue", totalValue);
            
            if ("pdf".equals(format)) {
                exportInventoryReportToPDF(request, response, items, activeItems, totalValue);
            } else {
                request.getRequestDispatcher("/jsp/reports/inventory.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating inventory report: " + e.getMessage());
            request.getRequestDispatcher("/jsp/reports/inventory.jsp").forward(request, response);
        }
    }
    
    private void generateBillsReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String status = request.getParameter("status");
        String format = request.getParameter("format");
        
        try {
            List<com.pahana.model.Bill> bills;
            
            if (status != null && !status.isEmpty()) {
                bills = billDAO.getBillsByStatus(status);
            } else {
                bills = billDAO.getAllBills();
            }
            
            double totalAmount = bills.stream()
                .mapToDouble(bill -> bill.getTotal())
                .sum();
            
            request.setAttribute("bills", bills);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("totalBills", bills.size());
            request.setAttribute("status", status);
            
            if ("pdf".equals(format)) {
                exportBillsReportToPDF(request, response, bills, totalAmount);
            } else {
                request.getRequestDispatcher("/jsp/reports/bills.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating bills report: " + e.getMessage());
            request.getRequestDispatcher("/jsp/reports/bills.jsp").forward(request, response);
        }
    }
    
    private void exportReportToPDF(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("type");
        String format = request.getParameter("format");
        
        if (!"pdf".equals(format)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Only PDF export is supported");
            return;
        }
        
        try {
            byte[] pdfBytes = reportService.generatePDFReport(reportType, request);
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=" + reportType + "_report.pdf");
            response.setContentLength(pdfBytes.length);
            
            response.getOutputStream().write(pdfBytes);
            response.getOutputStream().flush();
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF: " + e.getMessage());
        }
    }
    
    private void exportSalesReportToPDF(HttpServletRequest request, HttpServletResponse response, 
            List<com.pahana.model.Bill> bills, double totalRevenue, double avgBillAmount) 
            throws ServletException, IOException {
        
        try {
            byte[] pdfBytes = reportService.generateSalesReportPDF(bills, totalRevenue, avgBillAmount);
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=sales_report.pdf");
            response.setContentLength(pdfBytes.length);
            
            response.getOutputStream().write(pdfBytes);
            response.getOutputStream().flush();
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF: " + e.getMessage());
        }
    }
    
    private void exportCustomerReportToPDF(HttpServletRequest request, HttpServletResponse response,
            List<com.pahana.model.Customer> customers, List<com.pahana.model.Customer> activeCustomers) 
            throws ServletException, IOException {
        
        try {
            byte[] pdfBytes = reportService.generateCustomerReportPDF(customers, activeCustomers);
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=customer_report.pdf");
            response.setContentLength(pdfBytes.length);
            
            response.getOutputStream().write(pdfBytes);
            response.getOutputStream().flush();
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF: " + e.getMessage());
        }
    }
    
    private void exportInventoryReportToPDF(HttpServletRequest request, HttpServletResponse response,
            List<com.pahana.model.Item> items, List<com.pahana.model.Item> activeItems, double totalValue) 
            throws ServletException, IOException {
        
        try {
            byte[] pdfBytes = reportService.generateInventoryReportPDF(items, activeItems, totalValue);
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=inventory_report.pdf");
            response.setContentLength(pdfBytes.length);
            
            response.getOutputStream().write(pdfBytes);
            response.getOutputStream().flush();
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF: " + e.getMessage());
        }
    }
    
    private void exportBillsReportToPDF(HttpServletRequest request, HttpServletResponse response,
            List<com.pahana.model.Bill> bills, double totalAmount) 
            throws ServletException, IOException {
        
        try {
            byte[] pdfBytes = reportService.generateBillsReportPDF(bills, totalAmount);
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=bills_report.pdf");
            response.setContentLength(pdfBytes.length);
            
            response.getOutputStream().write(pdfBytes);
            response.getOutputStream().flush();
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF: " + e.getMessage());
        }
    }
} 