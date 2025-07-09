package com.pahana.controller;

import com.pahana.service.UserService;
import com.pahana.service.EmailUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegisterServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Only handle registration directly, no OTP
        handleRegistration(request, response);
    }
    
    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Validate input
        if (!validateRegistrationInput(username, password, confirmPassword, email, role, firstName, lastName)) {
            request.setAttribute("error", "Please fill all required fields correctly");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username already exists
        if (userService.getUserByUsername(username) != null) {
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Register user directly
        boolean success = userService.registerUser(username, password, email, role, firstName, lastName, phone, address);
        
        if (success) {
            request.setAttribute("message", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
    
    private boolean validateRegistrationInput(String username, String password, String confirmPassword, 
                                           String email, String role, String firstName, String lastName) {
        return username != null && !username.trim().isEmpty() &&
               password != null && password.length() >= 6 &&
               confirmPassword != null && !confirmPassword.trim().isEmpty() &&
               email != null && email.contains("@") &&
               role != null && (role.equals("ADMIN") || role.equals("EMPLOYEE") || role.equals("CUSTOMER")) &&
               firstName != null && !firstName.trim().isEmpty() &&
               lastName != null && !lastName.trim().isEmpty();
    }
} 