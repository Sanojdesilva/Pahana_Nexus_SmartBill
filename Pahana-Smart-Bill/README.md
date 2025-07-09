# Pahana - Smart Bill

A complete Java EE web application for smart billing management, built with pure Java EE (JSP, Servlets, JDBC, JavaBeans) following 3-tier architecture and MVC pattern.

## 🚀 Features

### Core Functionality
- **User Registration** with OTP Email Verification
- **Secure Login** with SHA-256 password hashing
- **Role-based Dashboards** (Admin, Employee, Customer)
- **Customer Management** (CRUD operations with role-based access)
- **Item Management** (Inventory control with full CRUD)
- **Bill Generation** and Management (with PDF export)
- **Comprehensive Reporting** (Sales, Customer, Inventory, Bills with PDF export)
- **PDF Generation** (Professional bills and reports)
- **Advanced Search & Filtering** (Date ranges, status filters)

### Technical Features
- **3-Tier Architecture**: Presentation (JSP), Business Logic (Services), Data Access (DAO)
- **MVC Pattern**: Clear separation of concerns
- **Input Validation**: Client and server-side validation
- **Error Handling**: Comprehensive exception handling
- **Security**: Password hashing, session management
- **Responsive Design**: Modern, mobile-friendly UI

## 🛠️ Tech Stack

- **Java EE**: Servlets, JSP, JavaBeans
- **Database**: MySQL with JDBC
- **Email**: JavaMail API for OTP
- **PDF**: iText library for report generation
- **Build Tool**: Maven
- **Server**: Apache Tomcat
- **IDE**: NetBeans 15 compatible

## 📁 Project Structure

```
Pahana-Smart-Bill/
├── src/
│   └── main/
│       ├── java/com/pahana/
│       │   ├── controller/     # Servlets (Controllers)
│       │   │   ├── LoginServlet.java
│       │   │   ├── RegisterServlet.java
│       │   │   ├── LogoutServlet.java
│       │   │   ├── AdminDashboardServlet.java
│       │   │   ├── EmployeeDashboardServlet.java
│       │   │   ├── CustomerDashboardServlet.java
│       │   │   ├── ItemServlet.java
│       │   │   ├── CustomerServlet.java
│       │   │   ├── BillServlet.java
│       │   │   ├── ReportServlet.java
│       │   │   └── BillPDFServlet.java
│       │   ├── model/          # JavaBeans (Entities)
│       │   │   ├── User.java
│       │   │   ├── Customer.java
│       │   │   ├── Item.java
│       │   │   ├── Bill.java
│       │   │   └── BillItem.java
│       │   ├── dao/            # Data Access Objects
│       │   │   ├── DBConnection.java
│       │   │   ├── UserDAO.java
│       │   │   ├── CustomerDAO.java
│       │   │   ├── ItemDAO.java
│       │   │   ├── BillDAO.java
│       │   │   └── BillItemDAO.java
│       │   └── service/        # Business Logic
│       │       ├── UserService.java
│       │       ├── CustomerService.java
│       │       ├── PasswordUtil.java
│       │       ├── EmailUtil.java
│       │       └── ReportService.java
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── jsp/            # JSP Pages
│           │   ├── login.jsp
│           │   ├── register.jsp
│           │   ├── verify_otp.jsp
│           │   ├── admin/
│           │   │   └── dashboard.jsp
│           │   ├── employee/
│           │   │   └── dashboard.jsp
│           │   ├── customer/
│           │   │   └── dashboard.jsp
│           │   ├── items/
│           │   │   └── list.jsp
│           │   ├── customers/
│           │   ├── bills/
│           │   └── reports/
│           │       └── dashboard.jsp
│           └── index.jsp
├── db/
│   └── schema.sql             # MySQL Database Schema
├── pom.xml                    # Maven Configuration
└── README.md
```

## 🗄️ Database Schema

### Tables
- **users**: User accounts with roles and authentication
- **customers**: Customer information and billing details
- **items**: Inventory items with pricing
- **bills**: Bill records with customer and item relationships
- **bill_items**: Many-to-many relationship between bills and items

## 🚀 Setup & Deployment

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat 9.x or 10.x
- MySQL 8.0 or higher
- Maven 3.6+
- NetBeans 15 (optional)

### 1. Database Setup

```sql
-- Create database
CREATE DATABASE smartbill;
USE smartbill;

-- Run the schema file
SOURCE db/schema.sql;
```

### 2. Configuration

#### Database Connection
Edit `src/main/java/com/pahana/dao/DBConnection.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/smartbill";
private static final String USERNAME = "root";
private static final String PASSWORD = "KD/BSCSD/19/04";
```

#### Email Configuration
Edit `src/main/java/com/pahana/service/EmailUtil.java`:
```java
private static final String EMAIL_FROM = "your-email@gmail.com";
private static final String EMAIL_PASSWORD = "your-app-password";
```

**Note**: For Gmail, use App Password instead of regular password.

### 3. Build & Deploy

#### Using Maven
```bash
# Navigate to project directory
cd Pahana-Smart-Bill

# Clean and build
mvn clean package

# Deploy WAR to Tomcat
cp target/Pahana-Smart-Bill.war $TOMCAT_HOME/webapps/
```

#### Using NetBeans
1. Open NetBeans 15
2. Open Project → Select `Pahana-Smart-Bill` folder
3. Configure Tomcat server in project properties
4. Run project (F6)

### 4. Access Application

- **URL**: `http://localhost:8080/Pahana-Smart-Bill/`
- **Default**: Auto-redirects to login page

## 👥 User Roles & Features

### ADMIN
- Manage all users (Create, Update, Delete, Toggle status)
- Manage customers and items
- Generate comprehensive reports
- Full system access

### EMPLOYEE
- Manage items (Create, Update, Delete)
- Create and manage bills
- Generate reports (excluding audit)
- Limited customer management

### CUSTOMER
- View personal bills
- Download bill PDFs
- View billing history
- Limited to own data

## 🔧 Development

### Adding New Features
1. **Model**: Create JavaBean in `model/` package
2. **DAO**: Create DAO class in `dao/` package
3. **Service**: Create service class in `service/` package
4. **Controller**: Create servlet in `controller/` package
5. **View**: Create JSP in `webapp/jsp/` directory

### Code Standards
- Follow Java naming conventions
- Use proper exception handling
- Implement input validation
- Add comprehensive comments
- Follow MVC pattern strictly

## 🛡️ Security Features

- **Password Hashing**: SHA-256 with salt
- **Session Management**: Secure session handling
- **Input Validation**: Client and server-side validation
- **SQL Injection Prevention**: Prepared statements
- **XSS Prevention**: Output encoding

## 📊 Reporting

### Available Reports
- **Sales Reports**: Daily, weekly, monthly, yearly
- **Customer Reports**: Registration, billing history
- **Inventory Reports**: Stock levels, item performance
- **Audit Reports**: User activity, system logs

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify MySQL is running
   - Check database credentials in `DBConnection.java`
   - Ensure database exists

2. **Email Not Sending**
   - Verify SMTP settings in `EmailUtil.java`
   - Check Gmail App Password configuration
   - Test with valid email credentials

3. **Build Errors**
   - Ensure Java 8+ is installed
   - Verify Maven is properly configured
   - Check all dependencies in `pom.xml`

4. **Deployment Issues**
   - Verify Tomcat is running
   - Check WAR file is in `webapps/` directory
   - Review Tomcat logs for errors

## 📝 License

This project is developed for educational purposes and follows Java EE best practices.

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Follow coding standards
4. Test thoroughly
5. Submit pull request

---

**Note**: This is a complete Java EE application following enterprise-level architecture patterns. All code is production-ready with proper error handling, security measures, and scalability considerations. 