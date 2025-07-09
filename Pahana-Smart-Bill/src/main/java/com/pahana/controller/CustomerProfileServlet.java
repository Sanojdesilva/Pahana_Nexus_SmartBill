package com.pahana.controller;

import com.pahana.dao.CustomerDAO;
import com.pahana.model.Customer;
import com.pahana.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/customer/profile", "/customer/profile/"})
public class CustomerProfileServlet extends HttpServlet {
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
            
            // Pass both user and customer to JSP
            request.setAttribute("user", user);
            request.setAttribute("customer", customer);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading profile: " + e.getMessage());
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/jsp/customer/profile.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 