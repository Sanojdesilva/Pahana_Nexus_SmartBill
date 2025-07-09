package com.pahana.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.pahana.model.User;
import com.pahana.service.UserService;
import com.pahana.service.CustomerService;

public class AdminUserManagementServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
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
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            String userId = request.getParameter("id");
            if (userId != null) {
                User editUser = userService.getUserById(userId);
                request.setAttribute("editUser", editUser);
            }
        }
        String search = request.getParameter("search");
        String roleFilter = request.getParameter("roleFilter");
        List<User> users;
        if ((search != null && !search.trim().isEmpty()) || (roleFilter != null && !roleFilter.trim().isEmpty())) {
            users = userService.searchUsers(search, roleFilter);
        } else {
            users = userService.getAllUsers();
        }
        request.setAttribute("users", users);
        request.setAttribute("search", search);
        request.setAttribute("roleFilter", roleFilter);
        request.getRequestDispatcher("/jsp/admin/users.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String userId = request.getParameter("id");
            if (userId != null) {
                userService.deleteUser(userId);
            }
        } else if ("create".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String roleParam = request.getParameter("role");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            boolean created = userService.registerUser(username, password, email, roleParam, firstName, lastName, null, null);
            if (created) {
                request.setAttribute("message", "User created successfully.");
            } else {
                request.setAttribute("error", "Failed to create user. Username may already exist or input is invalid.");
            }
        } else if ("update".equals(action)) {
            String userId = request.getParameter("id");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String roleParam = request.getParameter("role");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            User editUser = userService.getUserById(userId);
            if (editUser != null) {
                editUser.setUsername(username);
                editUser.setEmail(email);
                editUser.setRole(roleParam);
                editUser.setFirstName(firstName);
                editUser.setLastName(lastName);
                userService.updateUser(editUser);
                // --- Customer creation logic ---
                if ("CUSTOMER".equals(roleParam)) {
                    CustomerService customerService = new CustomerService();
                    // Check if a customer with this email already exists
                    boolean exists = false;
                    for (com.pahana.model.Customer c : customerService.getAllCustomers()) {
                        if (c.getEmail() != null && c.getEmail().equalsIgnoreCase(email)) {
                            exists = true;
                            break;
                        }
                    }
                    if (!exists) {
                        // Create a new customer with default values for phone/address/unitRate
                        customerService.createCustomer(
                            firstName + " " + lastName,
                            email,
                            "",
                            "",
                            0.0
                        );
                    }
                }
                // --- End customer creation logic ---
                request.setAttribute("message", "User updated successfully.");
            } else {
                request.setAttribute("error", "User not found.");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
} 