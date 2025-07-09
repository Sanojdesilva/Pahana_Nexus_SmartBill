package com.pahana.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import com.pahana.service.ReportService;
import com.pahana.dao.BillDAO;
import com.pahana.dao.CustomerDAO;
import com.pahana.dao.ItemDAO;
import com.pahana.model.Bill;
import com.pahana.model.Customer;
import com.pahana.model.Item;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;

@WebServlet("/reports/custom")
public class CustomReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to reports dashboard (modal is on dashboard)
        response.sendRedirect(request.getContextPath() + "/reports/dashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        String period = request.getParameter("period");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String format = request.getParameter("format");
        String[] fields = request.getParameterValues("fields");

        // Validate parameters (basic)
        if (reportType == null || format == null || fields == null || fields.length == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            return;
        }

        // Only implement CSV for now
        if (!"CSV".equalsIgnoreCase(format)) {
            response.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED, "Only CSV format is supported at this time.");
            return;
        }

        // Parse and calculate date range
        Date startDateObj = null;
        Date endDateObj = null;
        
        try {
            if (startDate != null && !startDate.trim().isEmpty() && endDate != null && !endDate.trim().isEmpty()) {
                // Use custom date range
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                startDateObj = sdf.parse(startDate);
                endDateObj = sdf.parse(endDate);
                // Set end date to end of day
                Calendar cal = Calendar.getInstance();
                cal.setTime(endDateObj);
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                endDateObj = cal.getTime();
            } else if (period != null && !period.trim().isEmpty()) {
                // Use predefined period
                Calendar cal = Calendar.getInstance();
                endDateObj = cal.getTime();
                
                switch (period.toLowerCase()) {
                    case "today":
                        startDateObj = cal.getTime();
                        break;
                    case "yesterday":
                        cal.add(Calendar.DAY_OF_MONTH, -1);
                        startDateObj = cal.getTime();
                        break;
                    case "this_week":
                        cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
                        startDateObj = cal.getTime();
                        break;
                    case "last_week":
                        cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
                        cal.add(Calendar.WEEK_OF_YEAR, -1);
                        startDateObj = cal.getTime();
                        cal.add(Calendar.WEEK_OF_YEAR, 1);
                        cal.add(Calendar.DAY_OF_WEEK, -1);
                        endDateObj = cal.getTime();
                        break;
                    case "this_month":
                        cal.set(Calendar.DAY_OF_MONTH, 1);
                        startDateObj = cal.getTime();
                        break;
                    case "last_month":
                        cal.set(Calendar.DAY_OF_MONTH, 1);
                        cal.add(Calendar.MONTH, -1);
                        startDateObj = cal.getTime();
                        cal.add(Calendar.MONTH, 1);
                        cal.add(Calendar.DAY_OF_MONTH, -1);
                        endDateObj = cal.getTime();
                        break;
                    case "this_year":
                        cal.set(Calendar.DAY_OF_YEAR, 1);
                        startDateObj = cal.getTime();
                        break;
                    case "last_year":
                        cal.set(Calendar.DAY_OF_YEAR, 1);
                        cal.add(Calendar.YEAR, -1);
                        startDateObj = cal.getTime();
                        cal.add(Calendar.YEAR, 1);
                        cal.add(Calendar.DAY_OF_YEAR, -1);
                        endDateObj = cal.getTime();
                        break;
                    default:
                        // No date filtering
                        startDateObj = null;
                        endDateObj = null;
                        break;
                }
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
            return;
        }

        String filename = reportType + "_report.csv";
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=" + filename);

        try (OutputStream out = response.getOutputStream()) {
            StringBuilder csv = new StringBuilder();
            // Write header
            csv.append(String.join(",", fields)).append("\n");

            if ("sales".equalsIgnoreCase(reportType)) {
                List<Bill> bills;
                if (startDateObj != null && endDateObj != null) {
                    bills = new BillDAO().getBillsByDateRange(startDateObj, endDateObj);
                } else {
                    bills = new BillDAO().getAllBills();
                }
                for (Bill bill : bills) {
                    List<String> row = new ArrayList<>();
                    for (String field : fields) {
                        switch (field) {
                            case "billNumber": row.add(bill.getBillNumber()); break;
                            case "customerId": row.add(bill.getCustomerId()); break;
                            case "userId": row.add(bill.getUserId()); break;
                            case "status": row.add(bill.getStatus()); break;
                            case "total": row.add(String.valueOf(bill.getTotal())); break;
                            case "createdAt": row.add(bill.getCreatedAt() != null ? bill.getCreatedAt().toString() : ""); break;
                            case "subtotal": row.add(String.valueOf(bill.getSubtotal())); break;
                            case "taxAmount": row.add(String.valueOf(bill.getTaxAmount())); break;
                            case "unitsConsumed": row.add(String.valueOf(bill.getUnitsConsumed())); break;
                            case "unitRate": row.add(String.valueOf(bill.getUnitRate())); break;
                            case "dueDate": row.add(bill.getDueDate() != null ? bill.getDueDate().toString() : ""); break;
                            case "paidDate": row.add(bill.getPaidDate() != null ? bill.getPaidDate().toString() : ""); break;
                            case "notes": row.add(bill.getNotes() != null ? bill.getNotes() : ""); break;
                            default: row.add(""); break;
                        }
                    }
                    csv.append(row.stream().map(s -> s.replace(",", " ")).collect(Collectors.joining(","))).append("\n");
                }
            } else if ("customers".equalsIgnoreCase(reportType)) {
                List<Customer> customers;
                if (startDateObj != null && endDateObj != null) {
                    customers = new CustomerDAO().getCustomersByDateRange(startDateObj, endDateObj);
                } else {
                    customers = new CustomerDAO().getAllCustomers();
                }
                for (Customer customer : customers) {
                    List<String> row = new ArrayList<>();
                    for (String field : fields) {
                        switch (field) {
                            case "id": row.add(customer.getId()); break;
                            case "name": row.add(customer.getName()); break;
                            case "email": row.add(customer.getEmail()); break;
                            case "phone": row.add(customer.getPhone()); break;
                            case "address": row.add(customer.getAddress()); break;
                            case "isActive": row.add(String.valueOf(customer.isActive())); break;
                            case "accountNumber": row.add(customer.getAccountNumber()); break;
                            case "unitsConsumed": row.add(String.valueOf(customer.getUnitsConsumed())); break;
                            case "unitRate": row.add(String.valueOf(customer.getUnitRate())); break;
                            case "createdAt": row.add(customer.getCreatedAt() != null ? customer.getCreatedAt().toString() : ""); break;
                            case "lastBillingDate": row.add(customer.getLastBillingDate() != null ? customer.getLastBillingDate().toString() : ""); break;
                            default: row.add(""); break;
                        }
                    }
                    csv.append(row.stream().map(s -> s.replace(",", " ")).collect(Collectors.joining(","))).append("\n");
                }
            } else if ("inventory".equalsIgnoreCase(reportType)) {
                List<Item> items;
                if (startDateObj != null && endDateObj != null) {
                    items = new ItemDAO().getItemsByDateRange(startDateObj, endDateObj);
                } else {
                    items = new ItemDAO().getAllItems();
                }
                for (Item item : items) {
                    List<String> row = new ArrayList<>();
                    for (String field : fields) {
                        switch (field) {
                            case "id": row.add(String.valueOf(item.getId())); break;
                            case "code": row.add(item.getCode()); break;
                            case "name": row.add(item.getName()); break;
                            case "description": row.add(item.getDescription()); break;
                            case "category": row.add(item.getCategory()); break;
                            case "price": row.add(String.valueOf(item.getPrice())); break;
                            case "stockQuantity": row.add(String.valueOf(item.getStockQuantity())); break;
                            case "isActive": row.add(String.valueOf(item.isActive())); break;
                            case "createdAt": row.add(item.getCreatedAt() != null ? item.getCreatedAt().toString() : ""); break;
                            case "updatedAt": row.add(item.getUpdatedAt() != null ? item.getUpdatedAt().toString() : ""); break;
                            default: row.add(""); break;
                        }
                    }
                    csv.append(row.stream().map(s -> s.replace(",", " ")).collect(Collectors.joining(","))).append("\n");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown report type");
                return;
            }
            out.write(csv.toString().getBytes());
            out.flush();
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating report: " + e.getMessage());
        }
    }
} 