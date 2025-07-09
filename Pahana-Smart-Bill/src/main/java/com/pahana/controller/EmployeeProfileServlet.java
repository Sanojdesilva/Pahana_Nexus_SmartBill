package com.pahana.controller;

import com.pahana.model.User;
import com.pahana.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/employee/profile", "/employee/profile/"})
public class EmployeeProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"EMPLOYEE".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.setAttribute("employee", user);
        request.getRequestDispatcher("/jsp/employee/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"EMPLOYEE".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        boolean updated = false;
        String error = null;
        try {
            UserDAO userDAO = new UserDAO();
            // Split name into first and last name
            if (name != null && !name.trim().isEmpty()) {
                String[] parts = name.trim().split(" ", 2);
                user.setFirstName(parts[0]);
                user.setLastName(parts.length > 1 ? parts[1] : "");
            }
            user.setEmail(email);
            if (password != null && !password.trim().isEmpty()) {
                user.setPasswordHash(password); // In real app, hash password!
            }
            updated = userDAO.updateUser(user);
            session.setAttribute("user", user);
        } catch (Exception e) {
            error = "Error updating profile: " + e.getMessage();
        }
        request.setAttribute("employee", user);
        if (updated) {
            request.setAttribute("message", "Profile updated successfully.");
        } else if (error != null) {
            request.setAttribute("error", error);
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }
        request.getRequestDispatcher("/jsp/employee/profile.jsp").forward(request, response);
    }
} 