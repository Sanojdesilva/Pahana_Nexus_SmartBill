package com.pahana.service;

import com.pahana.dao.CustomerDAO;
import com.pahana.model.Customer;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class CustomerService {
    
    private CustomerDAO customerDAO;
    
    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }
    
    public boolean createCustomer(String name, String email, String phone, String address, 
                                double unitRate) {
        
        // Validate input
        if (!isValidCustomerInput(name, email)) {
            return false;
        }
        
        // Generate customer ID and account number
        String customerId = generateCustomerId(name);
        String accountNumber = generateAccountNumber(customerId);
        
        // Create customer
        Customer customer = new Customer();
        customer.setId(customerId);
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customer.setActive(true);
        customer.setAccountNumber(accountNumber);
        customer.setUnitsConsumed(0);
        customer.setUnitRate(unitRate);
        customer.setCreatedAt(new Date());
        customer.setLastBillingDate(null);
        
        return customerDAO.createCustomer(customer);
    }
    
    public Customer getCustomerById(String id) {
        return customerDAO.getCustomerById(id);
    }
    
    public Customer getCustomerByAccountNumber(String accountNumber) {
        return customerDAO.getCustomerByAccountNumber(accountNumber);
    }
    
    public boolean updateCustomer(Customer customer) {
        if (!isValidCustomerInput(customer.getName(), customer.getEmail())) {
            return false;
        }
        return customerDAO.updateCustomer(customer);
    }
    
    public boolean deleteCustomer(String id) {
        return customerDAO.deleteCustomer(id);
    }
    
    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }
    
    public List<Customer> getActiveCustomers() {
        return customerDAO.getActiveCustomers();
    }
    
    public boolean toggleCustomerStatus(String id) {
        return customerDAO.toggleCustomerStatus(id);
    }
    
    public boolean updateCustomerUnits(String customerId, int unitsConsumed) {
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer != null) {
            customer.setUnitsConsumed(unitsConsumed);
            customer.setLastBillingDate(new Date());
            return customerDAO.updateCustomer(customer);
        }
        return false;
    }
    
    public double calculateBillAmount(String customerId) {
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer != null) {
            return customer.getUnitsConsumed() * customer.getUnitRate();
        }
        return 0.0;
    }
    
    public List<Customer> searchCustomers(String search, String status) {
        return customerDAO.searchCustomers(search, status);
    }
    
    // Bill search/filtering (should be in BillService if exists)
    public List<com.pahana.model.Bill> searchBills(String search, String status) {
        com.pahana.dao.BillDAO billDAO = new com.pahana.dao.BillDAO();
        return billDAO.searchBills(search, status);
    }
    
    private boolean isValidCustomerInput(String name, String email) {
        return name != null && !name.trim().isEmpty() &&
               email != null && email.contains("@");
    }
    
    private String generateCustomerId(String name) {
        Random random = new Random();
        int number = random.nextInt(1000) + 1;
        String[] nameParts = name.split(" ");
        String firstName = nameParts[0];
        String lastName = nameParts.length > 1 ? nameParts[nameParts.length - 1] : firstName;
        String firstLetter = lastName.substring(0, 1).toUpperCase();
        return "CUST" + number + firstName + firstLetter;
    }
    
    private String generateAccountNumber(String customerId) {
        Random random = new Random();
        int randomNumber = random.nextInt(10000) + 1000;
        return customerId + randomNumber;
    }
} 