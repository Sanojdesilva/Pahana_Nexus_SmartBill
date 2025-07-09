package com.pahana.controller;

import com.pahana.model.User;
import com.pahana.dao.BillDAO;
import com.pahana.dao.CustomerDAO;
import com.pahana.model.Customer;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CustomerDashboardServlet extends HttpServlet {
    
    private BillDAO billDAO;
    private CustomerDAO customerDAO;
    
    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
        customerDAO = new CustomerDAO();
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
        if (!"CUSTOMER".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get customer-specific data
        try {
            // Find customer by email (since user and customer have the same email)
            Customer customer = customerDAO.getCustomerByEmail(user.getEmail());
            
            if (customer == null) {
                // If no customer found, create one
                customer = new Customer();
                customer.setId(user.getId()); // Use user ID as customer ID
                customer.setName(user.getFirstName() + " " + user.getLastName());
                customer.setEmail(user.getEmail());
                customer.setPhone("");
                customer.setAddress("");
                customer.setActive(true);
                customer.setAccountNumber("ACC" + user.getId());
                customer.setUnitsConsumed(0);
                customer.setUnitRate(0.0);
                customer.setCreatedAt(user.getCreatedAt());
                customer.setLastBillingDate(null);
                
                customerDAO.createCustomer(customer);
            }
            
            String customerId = customer.getId();
            List<com.pahana.model.Bill> customerBills = billDAO.getBillsByCustomer(customerId);
            
            // Calculate customer statistics
            int totalBills = customerBills.size();
            int pendingBills = (int) customerBills.stream()
                .filter(bill -> "PENDING".equals(bill.getStatus()))
                .count();
            int paidBills = (int) customerBills.stream()
                .filter(bill -> "PAID".equals(bill.getStatus()))
                .count();
            
            // Calculate total amount owed
            double totalOwed = customerBills.stream()
                .filter(bill -> "PENDING".equals(bill.getStatus()))
                .mapToDouble(bill -> bill.getTotal())
                .sum();
            
            // Calculate total amount paid
            double totalPaid = customerBills.stream()
                .filter(bill -> "PAID".equals(bill.getStatus()))
                .mapToDouble(bill -> bill.getTotal())
                .sum();
            
            // Set attributes for JSP
            request.setAttribute("totalBills", totalBills);
            request.setAttribute("pendingBills", pendingBills);
            request.setAttribute("paidBills", paidBills);
            request.setAttribute("totalOwed", totalOwed);
            request.setAttribute("totalPaid", totalPaid);
            request.setAttribute("customerBills", customerBills);
            request.setAttribute("recentBills", customerBills.subList(0, Math.min(5, customerBills.size())));
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/jsp/customer/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 