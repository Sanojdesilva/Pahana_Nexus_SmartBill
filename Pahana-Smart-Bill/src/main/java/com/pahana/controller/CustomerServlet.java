package com.pahana.controller;

import com.pahana.model.Customer;
import com.pahana.model.User;
import com.pahana.dao.CustomerDAO;
import com.pahana.service.CustomerService;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CustomerServlet extends HttpServlet {
    
    private CustomerDAO customerDAO;
    private CustomerService customerService;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        customerService = new CustomerService();
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
        
        // Only ADMIN and EMPLOYEE can access customer management
        if (!"ADMIN".equals(role) && !"EMPLOYEE".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        // Handle /customers/new route
        if ("/new".equals(pathInfo)) {
            showCreateForm(request, response);
            return;
        }
        
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            String customerId = request.getParameter("id");
            if (customerId != null) {
                Customer editCustomer = customerDAO.getCustomerById(customerId);
                request.setAttribute("editCustomer", editCustomer);
            }
        }
        String search = request.getParameter("search");
        String statusFilter = request.getParameter("statusFilter");
        List<Customer> customers;
        if ((search != null && !search.trim().isEmpty()) || (statusFilter != null && !statusFilter.trim().isEmpty())) {
            customers = customerService.searchCustomers(search, statusFilter);
        } else {
            customers = customerDAO.getAllCustomers();
        }
        request.setAttribute("customers", customers);
        request.setAttribute("search", search);
        request.setAttribute("statusFilter", statusFilter);
        request.getRequestDispatcher("/jsp/customers/list.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String role = user.getRole();
        
        if (!"ADMIN".equals(role) && !"EMPLOYEE".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            String customerId = request.getParameter("id");
            if (customerId != null) {
                customerDAO.deleteCustomer(customerId);
            }
        } else if ("create".equals(action)) {
            createCustomer(request, response);
            return;
        } else if ("update".equals(action)) {
            String customerId = request.getParameter("id");
            Customer customer = customerDAO.getCustomerById(customerId);
            if (customer != null) {
                customer.setName(request.getParameter("name"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));
                customer.setUnitRate(Double.parseDouble(request.getParameter("unitRate")));
                customer.setActive(Boolean.parseBoolean(request.getParameter("isActive")));
                customerDAO.updateCustomer(customer);
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/customers/");
    }
    
    private void listCustomers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Customer> customers = customerDAO.getAllCustomers();
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("/jsp/customers/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading customers: " + e.getMessage());
            request.getRequestDispatcher("/jsp/customers/list.jsp").forward(request, response);
        }
    }
    
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/customers/create.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, String id) 
            throws ServletException, IOException {
        try {
            Customer customer = customerDAO.getCustomerById(id);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/jsp/customers/edit.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Customer not found");
                response.sendRedirect(request.getContextPath() + "/customers/");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading customer: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/customers/");
        }
    }
    
    private void showCustomerDetails(HttpServletRequest request, HttpServletResponse response, String id) 
            throws ServletException, IOException {
        try {
            Customer customer = customerDAO.getCustomerById(id);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/jsp/customers/details.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Customer not found");
                response.sendRedirect(request.getContextPath() + "/customers/");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading customer: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/customers/");
        }
    }
    
    private void createCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String unitRateStr = request.getParameter("unitRate");
        String isActiveStr = request.getParameter("isActive");
        
        // Validate input
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            unitRateStr == null || unitRateStr.trim().isEmpty()) {
            request.setAttribute("error", "Name, email, and unit rate are required");
            // Preserve form data for better UX
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("unitRate", unitRateStr);
            request.setAttribute("isActive", isActiveStr);
            request.getRequestDispatcher("/jsp/customers/create.jsp").forward(request, response);
            return;
        }
        
        try {
            double unitRate = Double.parseDouble(unitRateStr);
            boolean isActive = Boolean.parseBoolean(isActiveStr);
            
            if (customerService.createCustomer(name, email, phone, address, unitRate)) {
                // Set status after creation
                List<Customer> customers = customerDAO.getAllCustomers();
                Customer created = customers.stream()
                    .filter(c -> c.getName().equals(name) && c.getEmail().equals(email))
                    .findFirst().orElse(null);
                if (created != null) {
                    created.setActive(isActive);
                    customerDAO.updateCustomer(created);
                }
                request.setAttribute("message", "Customer created successfully");
                response.sendRedirect(request.getContextPath() + "/customers/");
            } else {
                request.setAttribute("error", "Failed to create customer. Email might already exist.");
                // Preserve form data for better UX
                request.setAttribute("name", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("unitRate", unitRateStr);
                request.setAttribute("isActive", isActiveStr);
                request.getRequestDispatcher("/jsp/customers/create.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid unit rate. Please enter a valid number.");
            // Preserve form data for better UX
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("unitRate", unitRateStr);
            request.setAttribute("isActive", isActiveStr);
            request.getRequestDispatcher("/jsp/customers/create.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error creating customer: " + e.getMessage());
            // Preserve form data for better UX
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("unitRate", unitRateStr);
            request.setAttribute("isActive", isActiveStr);
            request.getRequestDispatcher("/jsp/customers/create.jsp").forward(request, response);
        }
    }
    
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String unitRateStr = request.getParameter("unitRate");
        String isActiveStr = request.getParameter("isActive");
        
        if (id == null || id.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            double unitRate = Double.parseDouble(unitRateStr);
            boolean isActive = "on".equals(isActiveStr);
            
            Customer customer = customerDAO.getCustomerById(id);
            if (customer == null) {
                request.setAttribute("error", "Customer not found");
                response.sendRedirect(request.getContextPath() + "/customers/");
                return;
            }
            
            customer.setName(name);
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setAddress(address);
            customer.setUnitRate(unitRate);
            customer.setActive(isActive);
            
            if (customerDAO.updateCustomer(customer)) {
                request.setAttribute("message", "Customer updated successfully");
                response.sendRedirect(request.getContextPath() + "/customers/");
            } else {
                request.setAttribute("error", "Failed to update customer");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/jsp/customers/edit.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid unit rate");
            request.getRequestDispatcher("/jsp/customers/edit.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error updating customer: " + e.getMessage());
            request.getRequestDispatcher("/jsp/customers/edit.jsp").forward(request, response);
        }
    }
    
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id == null || id.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            if (customerDAO.deleteCustomer(id)) {
                request.setAttribute("message", "Customer deleted successfully");
            } else {
                request.setAttribute("error", "Failed to delete customer");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting customer: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/customers/");
    }
    
    private void toggleCustomerStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id == null || id.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            if (customerDAO.toggleCustomerStatus(id)) {
                request.setAttribute("message", "Customer status updated successfully");
            } else {
                request.setAttribute("error", "Failed to update customer status");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error updating customer status: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/customers/");
    }
} 