package com.pahana.controller;

import com.pahana.model.Bill;
import com.pahana.model.Customer;
import com.pahana.model.User;
import com.pahana.dao.BillDAO;
import com.pahana.dao.CustomerDAO;
import com.pahana.service.ReportService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BillPDFServlet extends HttpServlet {
    
    private BillDAO billDAO;
    private CustomerDAO customerDAO;
    private ReportService reportService;
    
    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
        customerDAO = new CustomerDAO();
        reportService = new ReportService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please login first");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bill ID required");
            return;
        }
        
        String billIdStr = pathInfo.substring(1);
        
        try {
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billDAO.getBillById(billId);
            
            if (bill == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
                return;
            }
            
            // Check if user has access to this bill
            User user = (User) session.getAttribute("user");
            String userRole = user.getRole();
            String userId = user.getId();
            String userEmail = user.getEmail();
            
            Customer customer = customerDAO.getCustomerById(bill.getCustomerId());
            if ("CUSTOMER".equals(userRole)) {
                boolean idMatch = userId.equals(bill.getCustomerId());
                boolean emailMatch = (customer != null && userEmail.equalsIgnoreCase(customer.getEmail()));
                if (!idMatch && !emailMatch) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                    return;
                }
            }
            
            // Generate PDF
            byte[] pdfBytes = reportService.generateBillPDF(bill, customer);
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=bill_" + bill.getBillNumber() + ".pdf");
            response.setContentLength(pdfBytes.length);
            
            response.getOutputStream().write(pdfBytes);
            response.getOutputStream().flush();
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid bill ID");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF: " + e.getMessage());
        }
    }
} 