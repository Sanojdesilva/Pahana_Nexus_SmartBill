package com.pahana.controller;

import com.pahana.dao.BillDAO;
import com.pahana.dao.CustomerDAO;
import com.pahana.model.Bill;
import com.pahana.model.Customer;
import com.pahana.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/customer/bills", "/customer/bills/"})
public class CustomerBillsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"CUSTOMER".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Find customer by email (since user and customer have the same email)
            CustomerDAO customerDAO = new CustomerDAO();
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
            
            BillDAO billDAO = new BillDAO();
            List<Bill> bills = billDAO.getBillsByCustomer(customer.getId());
            request.setAttribute("bills", bills);
            
            // Calculate summary statistics for the bills page
            int totalBills = bills.size();
            int pendingBills = (int) bills.stream()
                .filter(bill -> "PENDING".equals(bill.getStatus()))
                .count();
            int paidBills = (int) bills.stream()
                .filter(bill -> "PAID".equals(bill.getStatus()))
                .count();
            double totalOwed = bills.stream()
                .filter(bill -> "PENDING".equals(bill.getStatus()))
                .mapToDouble(bill -> bill.getTotal())
                .sum();
            
            request.setAttribute("totalBills", totalBills);
            request.setAttribute("pendingBills", pendingBills);
            request.setAttribute("paidBills", paidBills);
            request.setAttribute("totalOwed", totalOwed);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading bills: " + e.getMessage());
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/jsp/customer/bills.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 