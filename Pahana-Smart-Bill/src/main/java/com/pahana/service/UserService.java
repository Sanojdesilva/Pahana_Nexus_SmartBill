package com.pahana.service;

import com.pahana.dao.UserDAO;
import com.pahana.model.User;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class UserService {
    
    private UserDAO userDAO;
    
    public UserService() {
        this.userDAO = new UserDAO();
    }
    
    public boolean registerUser(String username, String password, String email, String role, 
                              String firstName, String lastName, String phone, String address) {
        
        // Validate input
        if (!isValidInput(username, password, email, firstName, lastName)) {
            return false;
        }
        
        // Check if username already exists
        if (userDAO.getUserByUsername(username) != null) {
            return false;
        }
        
        // Generate user ID
        String userId = generateUserId(role, firstName, lastName);
        
        // Hash password
        String hashedPassword = PasswordUtil.hashPassword(password);
        
        // Create user
        User user = new User();
        user.setId(userId);
        user.setUsername(username);
        user.setPasswordHash(hashedPassword);
        user.setEmail(email);
        user.setRole(role);
        user.setActive(true);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setCreatedAt(new Date());
        user.setLastLoginAt(null);
        
        boolean userCreated = userDAO.createUser(user);
        
        // If user is created successfully and role is CUSTOMER, create customer record
        if (userCreated && "CUSTOMER".equals(role)) {
            try {
                com.pahana.service.CustomerService customerService = new com.pahana.service.CustomerService();
                customerService.createCustomer(
                    firstName + " " + lastName,
                    email,
                    phone != null ? phone : "",
                    address != null ? address : "",
                    0.0
                );
            } catch (Exception e) {
                // Log the error but don't fail the user creation
                System.err.println("Error creating customer record: " + e.getMessage());
            }
        }
        
        return userCreated;
    }
    
    public User loginUser(String username, String password) {
        User user = userDAO.getUserByUsername(username);
        
        if (user != null && user.isActive() && PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
            // Update last login
            userDAO.updateLastLogin(user.getId());
            return user;
        }
        
        return null;
    }
    
    public User getUserById(String id) {
        return userDAO.getUserById(id);
    }
    
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }
    
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }
    
    public boolean deleteUser(String id) {
        return userDAO.deleteUser(id);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public List<User> getUsersByRole(String role) {
        List<User> allUsers = userDAO.getAllUsers();
        return allUsers.stream()
                      .filter(user -> user.getRole().equals(role))
                      .collect(java.util.stream.Collectors.toList());
    }
    
    public boolean toggleUserStatus(String id) {
        User user = userDAO.getUserById(id);
        if (user != null) {
            user.setActive(!user.isActive());
            return userDAO.updateUser(user);
        }
        return false;
    }
    
    public List<User> searchUsers(String search, String role) {
        return userDAO.searchUsers(search, role);
    }
    
    private boolean isValidInput(String username, String password, String email, String firstName, String lastName) {
        return username != null && !username.trim().isEmpty() &&
               password != null && password.length() >= 6 &&
               email != null && email.contains("@") &&
               firstName != null && !firstName.trim().isEmpty() &&
               lastName != null && !lastName.trim().isEmpty();
    }
    
    private String generateUserId(String role, String firstName, String lastName) {
        Random random = new Random();
        int number = random.nextInt(1000) + 1;
        String firstLetter = lastName.substring(0, 1).toUpperCase();
        return role + number + firstName + firstLetter;
    }
    
    public String generateOTP() {
        Random random = new Random();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
    }
} 