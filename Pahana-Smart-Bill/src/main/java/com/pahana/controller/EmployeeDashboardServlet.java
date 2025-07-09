package com.pahana.controller;

import com.pahana.model.User;
import com.pahana.service.CustomerService;
import com.pahana.dao.ItemDAO;
import com.pahana.dao.BillDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EmployeeDashboardServlet extends HttpServlet {
    
    private CustomerService customerService;
    private ItemDAO itemDAO;
    private BillDAO billDAO;
    
    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
        itemDAO = new ItemDAO();
        billDAO = new BillDAO();
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
        if (!"EMPLOYEE".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get dashboard statistics for employee
        try {
            List<com.pahana.model.Customer> allCustomers = customerService.getAllCustomers();
            List<com.pahana.model.Customer> activeCustomers = customerService.getActiveCustomers();
            
            List<com.pahana.model.Item> allItems = itemDAO.getAllItems();
            List<com.pahana.model.Item> activeItems = itemDAO.getActiveItems();
            
            List<com.pahana.model.Bill> allBills = billDAO.getAllBills();
            List<com.pahana.model.Bill> pendingBills = billDAO.getBillsByStatus("PENDING");
            List<com.pahana.model.Bill> completedBills = billDAO.getBillsByStatus("COMPLETED");
            
            // Calculate statistics
            int totalCustomers = allCustomers.size();
            int activeCustomerCount = activeCustomers.size();
            int totalItems = allItems.size();
            int activeItemCount = activeItems.size();
            int totalBills = allBills.size();
            int pendingBillCount = pendingBills.size();
            int completedBillCount = completedBills.size();
            
            // Calculate total revenue
            double totalRevenue = allBills.stream()
                .mapToDouble(bill -> bill.getTotal())
                .sum();
            
            // Set attributes for JSP
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("activeCustomerCount", activeCustomerCount);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("activeItemCount", activeItemCount);
            request.setAttribute("totalBills", totalBills);
            request.setAttribute("pendingBillCount", pendingBillCount);
            request.setAttribute("completedBillCount", completedBillCount);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("recentBills", allBills.subList(0, Math.min(5, allBills.size())));
            request.setAttribute("recentItems", allItems.subList(0, Math.min(5, allItems.size())));
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/jsp/employee/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 