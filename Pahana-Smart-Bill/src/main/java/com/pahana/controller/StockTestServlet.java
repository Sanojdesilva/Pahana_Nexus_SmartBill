package com.pahana.controller;

import com.pahana.model.User;
import com.pahana.dao.ItemDAO;
import com.pahana.service.InventoryService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/stock-test")
public class StockTestServlet extends HttpServlet {
    
    private ItemDAO itemDAO;
    private InventoryService inventoryService;
    
    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
        inventoryService = new InventoryService();
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
        
        // Only ADMIN can access stock test
        if (!"ADMIN".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        try {
            // Get all items
            List<com.pahana.model.Item> items = itemDAO.getAllItems();
            request.setAttribute("items", items);
            
            // Get inventory summary
            InventoryService.InventorySummary summary = inventoryService.getInventorySummary();
            request.setAttribute("totalItems", summary.getTotalItems());
            request.setAttribute("lowStockCount", summary.getLowStockCount());
            request.setAttribute("totalValue", String.format("%.2f", summary.getTotalValue()));
            
            request.getRequestDispatcher("/jsp/admin/stock-test.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading stock test: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }
} 