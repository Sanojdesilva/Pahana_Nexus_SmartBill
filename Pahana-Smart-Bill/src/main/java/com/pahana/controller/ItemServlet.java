package com.pahana.controller;

import com.pahana.model.Item;
import com.pahana.model.User;
import com.pahana.dao.ItemDAO;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ItemServlet extends HttpServlet {
    
    private ItemDAO itemDAO;
    
    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
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
        
        // Only ADMIN and EMPLOYEE can access items
        if (!"ADMIN".equals(role) && !"EMPLOYEE".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        // AJAX endpoint for active items as JSON
        if ("/api/active".equals(pathInfo)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            List<Item> items = itemDAO.getActiveItems();
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < items.size(); i++) {
                Item item = items.get(i);
                json.append("{")
                    .append("\"id\":\"").append(item.getId()).append("\",")
                    .append("\"code\":\"").append(item.getCode()).append("\",")
                    .append("\"name\":\"").append(item.getName()).append("\",")
                    .append("\"price\":").append(item.getPrice()).append(",")
                    .append("\"stockQuantity\":").append(item.getStockQuantity()).append(",")
                    .append("\"category\":\"").append(item.getCategory() == null ? "" : item.getCategory()).append("\"");
                json.append("}");
                if (i < items.size() - 1) json.append(",");
            }
            json.append("]");
            response.getWriter().write(json.toString());
            return;
        }
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all items
            listItems(request, response);
        } else if (pathInfo.equals("/new")) {
            // Show create form
            showCreateForm(request, response);
        } else if (pathInfo.matches("/edit/\\d+")) {
            // Show edit form
            String idStr = pathInfo.substring(6);
            showEditForm(request, response, Integer.parseInt(idStr));
        } else if (pathInfo.matches("/\\d+")) {
            // Show item details
            String idStr = pathInfo.substring(1);
            showItemDetails(request, response, Integer.parseInt(idStr));
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
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
        
        if ("create".equals(action)) {
            createItem(request, response);
        } else if ("update".equals(action)) {
            updateItem(request, response);
        } else if ("delete".equals(action)) {
            deleteItem(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void listItems(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Item> items = itemDAO.getAllItems();
            request.setAttribute("items", items);
            request.getRequestDispatcher("/jsp/items/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading items: " + e.getMessage());
            request.getRequestDispatcher("/jsp/items/list.jsp").forward(request, response);
        }
    }
    
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/items/create.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, int id) 
            throws ServletException, IOException {
        try {
            Item item = itemDAO.getItemById(id);
            if (item != null) {
                request.setAttribute("item", item);
                request.getRequestDispatcher("/jsp/items/edit.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Item not found");
                response.sendRedirect(request.getContextPath() + "/items/");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading item: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/items/");
        }
    }
    
    private void showItemDetails(HttpServletRequest request, HttpServletResponse response, int id) 
            throws ServletException, IOException {
        try {
            Item item = itemDAO.getItemById(id);
            if (item != null) {
                request.setAttribute("item", item);
                request.getRequestDispatcher("/jsp/items/details.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Item not found");
                response.sendRedirect(request.getContextPath() + "/items/");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading item: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/items/");
        }
    }
    
    private void createItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stockQuantity");
        
        // Validate input
        if (code == null || code.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            priceStr == null || priceStr.trim().isEmpty() ||
            stockQuantityStr == null || stockQuantityStr.trim().isEmpty()) {
            request.setAttribute("error", "All required fields must be filled");
            request.getRequestDispatcher("/jsp/items/create.jsp").forward(request, response);
            return;
        }
        
        try {
            double price = Double.parseDouble(priceStr);
            int stockQuantity = Integer.parseInt(stockQuantityStr);
            
            // Check if code already exists
            if (itemDAO.getItemByCode(code) != null) {
                request.setAttribute("error", "Item code already exists");
                request.getRequestDispatcher("/jsp/items/create.jsp").forward(request, response);
                return;
            }
            
            Item item = new Item();
            item.setCode(code);
            item.setName(name);
            item.setDescription(description);
            item.setCategory(category);
            item.setPrice(price);
            item.setStockQuantity(stockQuantity);
            item.setActive(true);
            item.setCreatedAt(new Date());
            item.setUpdatedAt(new Date());
            
            if (itemDAO.createItem(item)) {
                request.setAttribute("message", "Item created successfully");
                response.sendRedirect(request.getContextPath() + "/items/");
            } else {
                request.setAttribute("error", "Failed to create item");
                request.getRequestDispatcher("/jsp/items/create.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or stock quantity");
            request.getRequestDispatcher("/jsp/items/create.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error creating item: " + e.getMessage());
            request.getRequestDispatcher("/jsp/items/create.jsp").forward(request, response);
        }
    }
    
    private void updateItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stockQuantity");
        String isActiveStr = request.getParameter("active");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            double price = Double.parseDouble(priceStr);
            int stockQuantity = Integer.parseInt(stockQuantityStr);
            boolean isActive = "true".equals(isActiveStr);
            
            Item item = itemDAO.getItemById(id);
            if (item == null) {
                request.setAttribute("error", "Item not found");
                response.sendRedirect(request.getContextPath() + "/items/");
                return;
            }
            
            // Check if code already exists for different item
            Item existingItem = itemDAO.getItemByCode(code);
            if (existingItem != null && existingItem.getId() != id) {
                request.setAttribute("error", "Item code already exists");
                request.setAttribute("item", item);
                request.getRequestDispatcher("/jsp/items/edit.jsp").forward(request, response);
                return;
            }
            
            item.setCode(code);
            item.setName(name);
            item.setDescription(description);
            item.setCategory(category);
            item.setPrice(price);
            item.setStockQuantity(stockQuantity);
            item.setActive(isActive);
            item.setUpdatedAt(new Date());
            
            if (itemDAO.updateItem(item)) {
                request.setAttribute("message", "Item updated successfully");
                response.sendRedirect(request.getContextPath() + "/items/");
            } else {
                request.setAttribute("error", "Failed to update item");
                request.setAttribute("item", item);
                request.getRequestDispatcher("/jsp/items/edit.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or stock quantity");
            request.getRequestDispatcher("/jsp/items/edit.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error updating item: " + e.getMessage());
            request.getRequestDispatcher("/jsp/items/edit.jsp").forward(request, response);
        }
    }
    
    private void deleteItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            
            if (itemDAO.deleteItem(id)) {
                request.setAttribute("message", "Item deleted successfully");
            } else {
                request.setAttribute("error", "Failed to delete item");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid item ID");
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting item: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/items/");
    }
} 