# 📊 Pahana Smart Bill - Diagram Summary

## 🎯 Overview

This document provides a comprehensive overview of the Pahana Smart Bill system architecture through three key diagrams:

1. **Entity Relationship (ER) Diagram** - Database structure and relationships
2. **Class Diagram** - Object-oriented design and dependencies
3. **Sequence Diagrams** - System interactions and workflows

## 🗄️ Entity Relationship (ER) Diagram Analysis

### **Core Entities:**

#### **USERS Table**
- **Primary Key**: `id` (String)
- **Unique Key**: `username`
- **Key Fields**: 
  - `role` (ADMIN/EMPLOYEE/CUSTOMER)
  - `email` (for authentication)
  - `passwordHash` (SHA-256 encrypted)
- **Audit Fields**: `createdAt`, `lastLoginAt`

#### **CUSTOMERS Table**
- **Primary Key**: `id` (String) - Same as User ID for CUSTOMER role
- **Unique Key**: `account_number`
- **Business Logic**: 
  - `customer_type` (RESIDENTIAL/COMMERCIAL/INDUSTRIAL)
  - `consumption_tier` (LOW/MEDIUM/HIGH)
  - `unit_rate` (calculated based on type and tier)

#### **ITEMS Table**
- **Primary Key**: `id` (Auto-increment)
- **Unique Key**: `code`
- **Inventory Management**: 
  - `stock_quantity` (current inventory)
  - `reorder_level` (minimum stock threshold)
  - `category` (for classification)

#### **BILLS Table**
- **Primary Key**: `id` (Auto-increment)
- **Unique Key**: `bill_number`
- **Status Management**: 
  - `status` (DRAFT/PENDING/PAID/OVERDUE/CANCELLED)
  - `payment_method` (CASH/CARD/BANK_TRANSFER/CHECK)
- **Financial Fields**: `subtotal`, `tax_amount`, `total`

#### **BILL_ITEMS Table**
- **Primary Key**: `id` (Auto-increment)
- **Composite Key**: `(bill_id, item_id)` - Prevents duplicate items
- **Pricing**: `unit_price`, `total_price` (quantity × unit_price)

### **Key Relationships:**

1. **USERS ↔ CUSTOMERS**: 1:1 relationship (same ID for CUSTOMER role)
2. **USERS → ITEMS**: 1:many (created_by field)
3. **USERS → BILLS**: 1:many (user_id field - who created the bill)
4. **CUSTOMERS → BILLS**: 1:many (customer_id field)
5. **BILLS → BILL_ITEMS**: 1:many (bill_id field)
6. **ITEMS → BILL_ITEMS**: 1:many (item_id field)

## 🏗️ Class Diagram Analysis

### **Architecture Layers:**

#### **1. Model Layer (Entities)**
- **User**: Core user entity with authentication and role management
- **Customer**: Business entity with billing-specific attributes
- **Item**: Inventory entity with stock management
- **Bill**: Financial entity with status and payment tracking
- **BillItem**: Junction entity linking bills and items

#### **2. Data Access Layer (DAO)**
- **DBConnection**: Singleton database connection manager
- **UserDAO**: User CRUD operations
- **CustomerDAO**: Customer CRUD operations
- **ItemDAO**: Item CRUD operations with inventory management
- **BillDAO**: Bill CRUD operations with status filtering
- **BillItemDAO**: Bill-item relationship management

#### **3. Business Logic Layer (Service)**
- **UserService**: User registration, authentication, and management
- **CustomerService**: Customer business logic and billing calculations
- **InventoryService**: Stock management and bill creation workflows

#### **4. Presentation Layer (Controller)**
- **LoginServlet**: Authentication handling
- **RegisterServlet**: User registration
- **AdminDashboardServlet**: Admin dashboard statistics
- **CustomerDashboardServlet**: Customer dashboard with billing info
- **EmployeeDashboardServlet**: Employee dashboard
- **BillServlet**: Bill CRUD operations
- **ItemServlet**: Item CRUD operations
- **CustomerServlet**: Customer CRUD operations

### **Design Patterns Used:**

1. **DAO Pattern**: Data access abstraction
2. **Service Layer Pattern**: Business logic encapsulation
3. **MVC Pattern**: Separation of concerns
4. **Singleton Pattern**: Database connection
5. **Factory Pattern**: Object creation in services

## 🔄 Sequence Diagram Analysis

### **1. User Registration Flow**
**Purpose**: New user account creation with role-based customer setup
**Key Steps**:
- Input validation and duplicate username check
- Password hashing for security
- User record creation
- Automatic customer record creation for CUSTOMER role
- Success redirect to login

### **2. User Login Flow**
**Purpose**: Secure authentication with role-based routing
**Key Steps**:
- Credential validation
- Password verification using hash comparison
- Session creation with user attributes
- Role-based dashboard redirection
- Last login timestamp update

### **3. Bill Creation Flow**
**Purpose**: Complete bill generation with inventory updates
**Key Steps**:
- Customer and item validation
- Bill record creation
- Bill-item relationships creation
- Inventory stock reduction
- Success confirmation

### **4. Customer Dashboard Flow**
**Purpose**: Personalized customer view with billing statistics
**Key Steps**:
- Session authentication
- Customer record lookup/creation
- Bill retrieval and statistics calculation
- Dashboard data preparation

### **5. Admin Dashboard Flow**
**Purpose**: System-wide statistics and overview
**Key Steps**:
- Multi-entity data retrieval
- Statistical calculations
- Dashboard aggregation

### **6. PDF Generation Flow**
**Purpose**: Bill document generation with security checks
**Key Steps**:
- Permission validation
- Bill and customer data retrieval
- PDF document creation
- Secure file delivery

## 🔧 System Architecture Highlights

### **Security Features:**
- **Password Hashing**: SHA-256 encryption
- **Session Management**: Secure session handling
- **Role-Based Access**: Granular permission control
- **Input Validation**: Comprehensive data sanitization

### **Performance Optimizations:**
- **Database Indexes**: Optimized query performance
- **Connection Pooling**: Efficient database connections
- **Lazy Loading**: On-demand data retrieval
- **Caching**: Session-based data caching

### **Scalability Considerations:**
- **Modular Design**: Independent component architecture
- **Service Layer**: Business logic encapsulation
- **Database Normalization**: Efficient data storage
- **Stateless Design**: Session-based state management

### **Maintainability Features:**
- **Separation of Concerns**: Clear layer boundaries
- **Consistent Naming**: Standardized naming conventions
- **Error Handling**: Comprehensive exception management
- **Logging**: Detailed system logging

## 🎯 Key Business Rules

### **User Management:**
- Username must be unique
- Password minimum 6 characters
- Email validation required
- Role-based access control

### **Customer Management:**
- Customer ID same as User ID for CUSTOMER role
- Account number auto-generated
- Unit rate calculated based on type and tier
- Automatic customer creation for CUSTOMER users

### **Billing System:**
- Bill number auto-generated
- Status progression: DRAFT → PENDING → PAID
- Tax calculation based on subtotal
- Payment method tracking

### **Inventory Management:**
- Stock quantity tracking
- Reorder level monitoring
- Automatic stock reduction on bill creation
- Item categorization

## 🚀 Technology Stack

### **Backend:**
- **Java**: Core programming language
- **Servlets**: Web request handling
- **JSP**: View layer
- **MySQL**: Database management
- **Maven**: Build management

### **Frontend:**
- **HTML/CSS**: User interface
- **JavaScript**: Client-side interactions
- **Bootstrap**: Responsive design
- **Font Awesome**: Icons

### **Architecture:**
- **MVC Pattern**: Model-View-Controller
- **DAO Pattern**: Data Access Object
- **Service Layer**: Business logic
- **Session Management**: User state

This comprehensive system provides a robust, scalable, and maintainable billing management solution with clear separation of concerns and strong security measures. 