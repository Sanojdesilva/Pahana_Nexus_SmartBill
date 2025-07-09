package com.pahana.controller;

import com.pahana.model.Bill;
import com.pahana.model.User;
import com.pahana.dao.BillDAO;
import com.pahana.dao.CustomerDAO;
import com.pahana.dao.ItemDAO;
import com.pahana.service.InventoryService;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Objects;
import com.pahana.dao.BillItemDAO;
import com.pahana.model.BillItem;

public class BillServlet extends HttpServlet {
    
    private BillDAO billDAO;
    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;
    private InventoryService inventoryService;
    
    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
        customerDAO = new CustomerDAO();
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
        
        // ADMIN, EMPLOYEE, and CUSTOMER can access bills (with different permissions)
        if (!"ADMIN".equals(role) && !"EMPLOYEE".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        String action = request.getParameter("action");
        String pathInfo = request.getPathInfo();
        
        // Handle different routes
        if ("new".equals(action) || "/new".equals(pathInfo)) {
            // Show create bill form
            showCreateForm(request, response);
            return;
        } else if ("view".equals(action) || "/view".equals(pathInfo)) {
            // Show bill details
            String billIdStr = request.getParameter("id");
            if (billIdStr != null) {
                int billId = Integer.parseInt(billIdStr);
                showBillDetails(request, response, billId, user);
                return;
            }
        } else if ("edit".equals(action)) {
            // Show edit bill form
            String billIdStr = request.getParameter("id");
            if (billIdStr != null) {
                int billId = Integer.parseInt(billIdStr);
                Bill editBill = billDAO.getBillById(billId);
                if (editBill != null) {
                    List<com.pahana.model.Customer> customers = customerDAO.getAllCustomers();
                    request.setAttribute("editBill", editBill);
                    request.setAttribute("customers", customers);
                    request.getRequestDispatcher("/jsp/bills/edit.jsp").forward(request, response);
                    return;
                }
            }
        }

        // Default: show bills list (handle /bills, /bills/, and /bills with no pathInfo)
        if (pathInfo == null || pathInfo.isEmpty() || "/".equals(pathInfo)) {
            List<com.pahana.model.Customer> customers = customerDAO.getAllCustomers();
            request.setAttribute("customers", customers);
            String search = request.getParameter("search");
            String statusFilter = request.getParameter("statusFilter");
            List<Bill> bills;
            if ((search != null && !search.trim().isEmpty()) || (statusFilter != null && !statusFilter.trim().isEmpty())) {
                bills = new com.pahana.service.CustomerService().searchBills(search, statusFilter);
            } else {
                bills = billDAO.getAllBills();
            }
            request.setAttribute("bills", bills);
            request.setAttribute("search", search);
            request.setAttribute("statusFilter", statusFilter);
            request.getRequestDispatcher("/jsp/bills/list.jsp").forward(request, response);
            return;
        }

        // If pathInfo doesn't match any known route, show 404
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
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
            String billIdStr = request.getParameter("id");
            if (billIdStr != null) {
                int billId = Integer.parseInt(billIdStr);
                billDAO.deleteBill(billId);
            }
        } else if ("create".equals(action)) {
            createBill(request, response, user);
            return;
        } else if ("update".equals(action)) {
            updateBill(request, response);
            return;
        } else if ("updateStatus".equals(action)) {
            updateBillStatus(request, response);
            return;
        }
        
        response.sendRedirect(request.getContextPath() + "/bills/");
    }
    
    private void listBills(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        List<Bill> bills = billDAO.getAllBills();
        request.setAttribute("bills", bills);
        request.getRequestDispatcher("/jsp/bills/list.jsp").forward(request, response);
    }
    
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<com.pahana.model.Customer> customers = customerDAO.getAllCustomers();
        List<com.pahana.model.Item> items = itemDAO.getActiveItems();
        request.setAttribute("customers", customers);
        request.setAttribute("items", items);
        request.getRequestDispatcher("/jsp/bills/create.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, int id) 
            throws ServletException, IOException {
        Bill bill = billDAO.getBillById(id);
        if (bill != null) {
            List<com.pahana.model.Customer> customers = customerDAO.getAllCustomers();
            List<com.pahana.model.Item> items = itemDAO.getActiveItems();
            request.setAttribute("bill", bill);
            request.setAttribute("customers", customers);
            request.setAttribute("items", items);
            request.getRequestDispatcher("/jsp/bills/edit.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void showBillDetails(HttpServletRequest request, HttpServletResponse response, int id, User user) 
            throws ServletException, IOException {
        Bill bill = billDAO.getBillById(id);
        if (bill != null) {
            // Get bill items with details
            BillItemDAO billItemDAO = new BillItemDAO();
            List<com.pahana.model.BillItem> billItems = billItemDAO.getBillItemsWithDetails(id);
            
            request.setAttribute("bill", bill);
            request.setAttribute("billItems", billItems);
            request.getRequestDispatcher("/jsp/bills/view.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void createBill(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        try {
            // Get bill items from request
            String[] itemIds = request.getParameterValues("itemIds[]");
            String[] quantities = request.getParameterValues("quantities[]");

            // Validation: must have at least one item and valid quantities
            if (itemIds == null || quantities == null || itemIds.length == 0 || quantities.length == 0) {
                request.setAttribute("error", "At least one bill item with a valid quantity is required.");
                showCreateForm(request, response);
                return;
            }

            // Validate stock availability before creating bill
            List<BillItem> billItems = new ArrayList<>();
            java.util.Set<Integer> uniqueItemIds = new java.util.HashSet<>();
            for (int i = 0; i < itemIds.length; i++) {
                if (itemIds[i] != null && !itemIds[i].trim().isEmpty()) {
                    Integer itemId = Integer.parseInt(itemIds[i]);
                    Integer qty = parseIntOrNull(quantities[i]);

                    // Check for duplicate item IDs
                    if (!uniqueItemIds.add(itemId)) {
                        request.setAttribute("error", "Duplicate items are not allowed in a single bill. Please remove duplicate items.");
                        showCreateForm(request, response);
                        return;
                    }

                    if (qty == null || qty <= 0) {
                        request.setAttribute("error", "All item quantities must be positive numbers.");
                        showCreateForm(request, response);
                        return;
                    }

                    // Check if sufficient stock is available
                    if (!inventoryService.hasSufficientStock(itemId, qty)) {
                        com.pahana.model.Item item = itemDAO.getItemById(itemId);
                        String itemName = item != null ? item.getName() : "Unknown";
                        request.setAttribute("error", "Insufficient stock for item: " + itemName + ". Available: " +
                            (item != null ? item.getStockQuantity() : 0) + ", Requested: " + qty);
                        showCreateForm(request, response);
                        return;
                    }

                    // Create bill item for later processing
                    BillItem billItem = new BillItem();
                    billItem.setItemId(itemId);
                    billItem.setQuantity(qty);
                    com.pahana.model.Item item = itemDAO.getItemById(itemId);
                    if (item != null) {
                        billItem.setUnitPrice(item.getPrice());
                        billItem.calculateTotalPrice();
                    }
                    billItems.add(billItem);
                }
            }

            // Create bill
            Bill bill = new Bill();
            bill.setCustomerId(request.getParameter("customerId"));
            bill.setStatus(request.getParameter("status"));
            bill.setUnitsConsumed(billItems.stream().mapToInt(BillItem::getQuantity).sum());
            bill.setUnitRate(0.0);
            bill.setDueDate(parseDateOrNull(request.getParameter("dueDate")));
            bill.setPaidDate(parseDateOrNull(request.getParameter("paidDate")));
            bill.setNotes(request.getParameter("notes"));
            bill.setCreatedAt(new Date());
            bill.setUserId(user.getId());
            bill.setBillNumber(generateBillNumber());

            // Calculate totals
            double subtotal = billItems.stream().mapToDouble(BillItem::getTotalPrice).sum();
            double taxAmount = subtotal * 0.15; // 15% tax
            double total = subtotal + taxAmount;

            bill.setSubtotal(subtotal);
            bill.setTaxAmount(taxAmount);
            bill.setTotal(total);

            // Use InventoryService to create bill with proper stock management
            if (inventoryService.createBillWithItems(bill, billItems)) {
                request.setAttribute("message", "Bill created successfully with stock updated");
                response.sendRedirect(request.getContextPath() + "/bills/");
            } else {
                request.setAttribute("error", "Failed to create bill. Please check stock availability.");
                showCreateForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error creating bill: " + e.getMessage());
            showCreateForm(request, response);
        }
    }
    
    private void updateBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String billIdStr = request.getParameter("id");
            if (billIdStr == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billDAO.getBillById(billId);
            
            if (bill == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            // Update bill fields
            bill.setCustomerId(request.getParameter("customerId"));
            bill.setStatus(request.getParameter("status"));
            bill.setUnitsConsumed(parseIntOrNull(request.getParameter("unitsConsumed")));
            bill.setUnitRate(parseDoubleOrNull(request.getParameter("unitRate")));
            bill.setDueDate(parseDateOrNull(request.getParameter("dueDate")));
            bill.setPaidDate(parseDateOrNull(request.getParameter("paidDate")));
            bill.setNotes(request.getParameter("notes"));
            
            // Recalculate totals
            double subtotal = (Objects.nonNull(bill.getUnitsConsumed()) && Objects.nonNull(bill.getUnitRate())) 
                ? bill.getUnitsConsumed() * bill.getUnitRate() : 0.0;
            double taxAmount = subtotal * 0.15; // 15% tax
            double total = subtotal + taxAmount;
            
            bill.setSubtotal(subtotal);
            bill.setTaxAmount(taxAmount);
            bill.setTotal(total);
            
            if (billDAO.updateBill(bill)) {
                request.setAttribute("message", "Bill updated successfully");
            } else {
                request.setAttribute("error", "Failed to update bill");
            }
            
            response.sendRedirect(request.getContextPath() + "/bills/");
        } catch (Exception e) {
            request.setAttribute("error", "Error updating bill: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/bills/");
        }
    }
    
    private void deleteBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String billIdStr = request.getParameter("id");
            if (billIdStr != null) {
                int billId = Integer.parseInt(billIdStr);
                
                // Get bill to check if it was already cancelled
                Bill bill = billDAO.getBillById(billId);
                if (bill != null && !"CANCELLED".equals(bill.getStatus())) {
                    // Restore stock before deleting (only if not already cancelled)
                    inventoryService.cancelBill(billId);
                }
                
                // Delete bill items first
                BillItemDAO billItemDAO = new BillItemDAO();
                billItemDAO.deleteAllBillItems(billId);
                
                // Delete bill
                if (billDAO.deleteBill(billId)) {
                    request.setAttribute("message", "Bill deleted successfully and stock restored");
                } else {
                    request.setAttribute("error", "Failed to delete bill");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting bill: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/bills/");
    }
    
    private void updateBillStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String billIdStr = request.getParameter("id");
            String status = request.getParameter("status");
            
            if (billIdStr != null && status != null) {
                int billId = Integer.parseInt(billIdStr);
                
                // Get current bill status before updating
                Bill currentBill = billDAO.getBillById(billId);
                if (currentBill == null) {
                    request.setAttribute("error", "Bill not found");
                    response.sendRedirect(request.getContextPath() + "/bills/");
                    return;
                }
                
                String previousStatus = currentBill.getStatus();
                
                // If status is being changed to CANCELLED, restore stock
                if ("CANCELLED".equals(status) && !"CANCELLED".equals(previousStatus)) {
                    if (inventoryService.cancelBill(billId)) {
                        request.setAttribute("message", "Bill cancelled successfully and stock restored");
                    } else {
                        request.setAttribute("error", "Failed to cancel bill and restore stock");
                    }
                } else {
                    // Regular status update
                    if (billDAO.updateBillStatus(billId, status)) {
                        request.setAttribute("message", "Bill status updated successfully");
                    } else {
                        request.setAttribute("error", "Failed to update bill status");
                    }
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error updating bill status: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/bills/");
    }
    
    private String generateBillNumber() {
        return "BILL-" + System.currentTimeMillis();
    }
    
    private Double parseDoubleOrNull(String value) {
        try {
            return value != null && !value.trim().isEmpty() ? Double.parseDouble(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    private Integer parseIntOrNull(String value) {
        try {
            return value != null && !value.trim().isEmpty() ? Integer.parseInt(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    private Date parseDateOrNull(String value) {
        try {
            return value != null && !value.trim().isEmpty() ? java.sql.Date.valueOf(value) : null;
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
} 