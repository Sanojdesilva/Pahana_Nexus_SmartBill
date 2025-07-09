-- MySQL schema for Pahana - Smart Bill
-- Database: smartbill

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS smartbill;
USE smartbill;

CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    passwordHash VARCHAR(64) NOT NULL,
    email VARCHAR(100) NOT NULL,
    role ENUM('ADMIN','EMPLOYEE','CUSTOMER') NOT NULL,
    isActive BOOLEAN DEFAULT TRUE,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    createdAt DATETIME NOT NULL,
    lastLoginAt DATETIME
);

CREATE TABLE customers (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    account_number VARCHAR(100) UNIQUE NOT NULL,
    units_consumed INT DEFAULT 0,
    unit_rate DECIMAL(10,2) DEFAULT 0.00,
    customer_type ENUM('RESIDENTIAL', 'COMMERCIAL', 'INDUSTRIAL') DEFAULT 'RESIDENTIAL',
    consumption_tier ENUM('LOW', 'MEDIUM', 'HIGH') DEFAULT 'LOW',
    created_at DATETIME NOT NULL,
    last_billing_date DATETIME,
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    supplier_info VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    created_by VARCHAR(50),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    status ENUM('DRAFT', 'PENDING', 'PAID', 'OVERDUE', 'CANCELLED') DEFAULT 'DRAFT',
    total DECIMAL(10,2) DEFAULT 0.00,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    bill_number VARCHAR(100) UNIQUE NOT NULL,
    subtotal DECIMAL(10,2) DEFAULT 0.00,
    tax_amount DECIMAL(10,2) DEFAULT 0.00,
    tax_rate DECIMAL(5,2) DEFAULT 0.00,
    units_consumed INT DEFAULT 0,
    unit_rate DECIMAL(10,2) DEFAULT 0.00,
    due_date DATETIME,
    paid_date DATETIME,
    notes TEXT,
    payment_method ENUM('CASH', 'CARD', 'BANK_TRANSFER', 'CHECK') DEFAULT 'CASH',
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE bill_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES bills(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(id),
    UNIQUE KEY unique_bill_item (bill_id, item_id)
);

-- Create indexes for better performance
CREATE INDEX idx_customers_account_number ON customers(account_number);
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_items_code ON items(code);
CREATE INDEX idx_items_category ON items(category);
CREATE INDEX idx_bills_customer_id ON bills(customer_id);
CREATE INDEX idx_bills_status ON bills(status);
CREATE INDEX idx_bills_bill_number ON bills(bill_number);
CREATE INDEX idx_bill_items_bill_id ON bill_items(bill_id);
CREATE INDEX idx_bill_items_item_id ON bill_items(item_id);

-- Insert default data for testing
INSERT INTO users (id, username, passwordHash, email, role, isActive, firstName, lastName, createdAt) VALUES
('USR001', 'admin', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'admin@pahana.com', 'ADMIN', TRUE, 'Admin', 'User', NOW());

-- Insert sample items
INSERT INTO items (code, name, description, category, price, stock_quantity, reorder_level, is_active, created_at, created_by) VALUES
('ELEC001', 'Electricity Unit', 'Standard electricity consumption unit', 'ELECTRICITY', 0.15, 1000, 100, TRUE, NOW(), 'USR001'),
('WATER001', 'Water Unit', 'Standard water consumption unit', 'WATER', 0.08, 2000, 200, TRUE, NOW(), 'USR001'),
('GAS001', 'Gas Unit', 'Standard gas consumption unit', 'GAS', 0.12, 1500, 150, TRUE, NOW(), 'USR001'); 