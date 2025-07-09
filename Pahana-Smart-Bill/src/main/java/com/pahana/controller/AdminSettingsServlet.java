package com.pahana.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import com.pahana.model.User;

public class AdminSettingsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Handle theme API request
        String action = request.getParameter("action");
        if ("getTheme".equals(action)) {
            ServletContext context = getServletContext();
            Map<String, String> settings = (Map<String, String>) context.getAttribute("settings");
            if (settings == null) {
                settings = getDefaultSettings();
                context.setAttribute("settings", settings);
            }
            
            // Return only theme-related settings as JSON
            Map<String, String> themeSettings = new HashMap<>();
            themeSettings.put("darkMode", settings.get("darkMode"));
            themeSettings.put("theme", settings.get("theme"));
            themeSettings.put("primaryColor", settings.get("primaryColor"));
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            // Simple JSON conversion
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"darkMode\":\"").append(themeSettings.get("darkMode")).append("\",");
            json.append("\"theme\":\"").append(themeSettings.get("theme")).append("\",");
            json.append("\"primaryColor\":\"").append(themeSettings.get("primaryColor")).append("\"");
            json.append("}");
            
            response.getWriter().write(json.toString());
            return;
        }
        
        ServletContext context = getServletContext();
        Map<String, String> settings = (Map<String, String>) context.getAttribute("settings");
        if (settings == null) {
            settings = getDefaultSettings();
            context.setAttribute("settings", settings);
        }
        request.setAttribute("settings", settings);
        request.getRequestDispatcher("/jsp/admin/settings.jsp").forward(request, response);
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
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        ServletContext context = getServletContext();
        Map<String, String> settings = (Map<String, String>) context.getAttribute("settings");
        if (settings == null) {
            settings = new HashMap<>();
        }
        
        // General Settings
        settings.put("siteName", getParameterOrDefault(request, "siteName", "Pahana Smart Bill"));
        settings.put("supportEmail", getParameterOrDefault(request, "supportEmail", "support@example.com"));
        settings.put("timezone", getParameterOrDefault(request, "timezone", "UTC"));
        settings.put("currency", getParameterOrDefault(request, "currency", "USD"));
        
        // Appearance Settings
        settings.put("darkMode", request.getParameter("darkMode") != null ? "true" : "false");
        settings.put("primaryColor", getParameterOrDefault(request, "primaryColor", "#667eea"));
        settings.put("theme", getParameterOrDefault(request, "theme", "default"));
        
        // Notification Settings
        settings.put("emailNotifications", request.getParameter("emailNotifications") != null ? "true" : "false");
        settings.put("smsNotifications", request.getParameter("smsNotifications") != null ? "true" : "false");
        settings.put("pushNotifications", request.getParameter("pushNotifications") != null ? "true" : "false");
        settings.put("notificationEmail", getParameterOrDefault(request, "notificationEmail", "notifications@example.com"));
        
        // Security Settings
        settings.put("securityLevel", getParameterOrDefault(request, "securityLevel", "high"));
        settings.put("twoFactorAuth", request.getParameter("twoFactorAuth") != null ? "true" : "false");
        settings.put("sessionTimeout", request.getParameter("sessionTimeout") != null ? "true" : "false");
        settings.put("passwordPolicy", request.getParameter("passwordPolicy") != null ? "true" : "false");
        settings.put("maxLoginAttempts", getParameterOrDefault(request, "maxLoginAttempts", "5"));
        
        // Billing Settings
        settings.put("taxRate", getParameterOrDefault(request, "taxRate", "8.5"));
        settings.put("paymentTerms", getParameterOrDefault(request, "paymentTerms", "30"));
        settings.put("autoGenerateBills", request.getParameter("autoGenerateBills") != null ? "true" : "false");
        settings.put("latePaymentFees", request.getParameter("latePaymentFees") != null ? "true" : "false");
        settings.put("lateFeeRate", getParameterOrDefault(request, "lateFeeRate", "5.0"));
        
        // System Settings
        settings.put("backupFrequency", getParameterOrDefault(request, "backupFrequency", "daily"));
        settings.put("lastBackup", getParameterOrDefault(request, "lastBackup", "2024-01-15 14:30:00"));
        settings.put("nextBackup", getParameterOrDefault(request, "nextBackup", "2024-01-16 14:30:00"));
        settings.put("autoBackup", request.getParameter("autoBackup") != null ? "true" : "false");
        settings.put("maintenanceMode", request.getParameter("maintenanceMode") != null ? "true" : "false");
        settings.put("logLevel", getParameterOrDefault(request, "logLevel", "INFO"));
        
        context.setAttribute("settings", settings);
        request.setAttribute("settings", settings);
        request.setAttribute("message", "Settings updated successfully!");
        request.getRequestDispatcher("/jsp/admin/settings.jsp").forward(request, response);
    }
    
    private Map<String, String> getDefaultSettings() {
        Map<String, String> settings = new HashMap<>();
        
        // General Settings
        settings.put("siteName", "Pahana Smart Bill");
        settings.put("supportEmail", "support@example.com");
        settings.put("timezone", "UTC");
        settings.put("currency", "USD");
        
        // Appearance Settings
        settings.put("darkMode", "false");
        settings.put("primaryColor", "#667eea");
        settings.put("theme", "default");
        
        // Notification Settings
        settings.put("emailNotifications", "true");
        settings.put("smsNotifications", "false");
        settings.put("pushNotifications", "false");
        settings.put("notificationEmail", "notifications@example.com");
        
        // Security Settings
        settings.put("securityLevel", "high");
        settings.put("twoFactorAuth", "false");
        settings.put("sessionTimeout", "true");
        settings.put("passwordPolicy", "true");
        settings.put("maxLoginAttempts", "5");
        
        // Billing Settings
        settings.put("taxRate", "8.5");
        settings.put("paymentTerms", "30");
        settings.put("autoGenerateBills", "false");
        settings.put("latePaymentFees", "true");
        settings.put("lateFeeRate", "5.0");
        
        // System Settings
        settings.put("backupFrequency", "daily");
        settings.put("lastBackup", "2024-01-15 14:30:00");
        settings.put("nextBackup", "2024-01-16 14:30:00");
        settings.put("autoBackup", "true");
        settings.put("maintenanceMode", "false");
        settings.put("logLevel", "INFO");
        
        return settings;
    }
    
    private String getParameterOrDefault(HttpServletRequest request, String paramName, String defaultValue) {
        String value = request.getParameter(paramName);
        return value != null && !value.trim().isEmpty() ? value.trim() : defaultValue;
    }
} 