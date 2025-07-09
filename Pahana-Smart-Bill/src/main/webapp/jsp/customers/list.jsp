<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.model.Customer" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Customers - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
    <style>
        body {
            min-height: 100vh;
        }
        
        .header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            color: var(--text-white);
            padding: var(--spacing-md) var(--spacing-lg);
            box-shadow: var(--shadow-lg);
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header h1 {
            color: var(--text-white);
            margin-bottom: 0;
            font-size: 1.8rem;
        }
        
        .nav-links {
            display: flex;
            gap: var(--spacing-md);
        }
        
        .nav-links a {
            color: var(--text-white);
            text-decoration: none;
            padding: var(--spacing-xs) var(--spacing-sm);
            border-radius: var(--radius-sm);
            transition: background var(--transition-normal);
            font-weight: 500;
        }
        
        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.2);
            text-decoration: none;
            color: var(--text-white);
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-xl);
        }
        
        .page-header h2 {
            color: var(--text-dark);
            font-size: 1.8rem;
            margin-bottom: 0;
        }
        
        .search-bar {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            padding: var(--spacing-xl);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            margin-bottom: var(--spacing-xl);
            position: relative;
            overflow: hidden;
        }
        
        .search-bar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
        }
        
        .search-form {
            display: flex;
            gap: var(--spacing-lg);
            align-items: center;
        }
        
        .form-group {
            flex: 1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: var(--spacing-xs);
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: var(--spacing-sm);
            border: 2px solid #e5e7eb;
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: all var(--transition-normal);
            background: rgba(255, 255, 255, 0.9);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(44, 85, 48, 0.1);
            background: var(--bg-white);
        }
        
        .customers-table {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            width: 100%;
            position: relative;
            overflow: hidden;
        }
        
        .customers-table::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
        }
        
        .table-header {
            background: rgba(44, 85, 48, 0.05);
            padding: var(--spacing-lg);
            border-bottom: 1px solid var(--bg-overlay);
        }
        
        .table-header h2 {
            margin: 0;
            color: var(--text-dark);
            font-weight: 700;
        }
        
        .table-container {
            overflow-x: auto;
            overflow-y: visible;
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
            position: relative;
        }
        
        .table-container::-webkit-scrollbar {
            height: 8px;
        }
        
        .table-container::-webkit-scrollbar-track {
            background: rgba(44, 85, 48, 0.1);
            border-radius: 4px;
        }
        
        .table-container::-webkit-scrollbar-thumb {
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
            border-radius: 4px;
        }
        
        .table-container::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(90deg, var(--primary-dark), var(--primary-color));
        }
        
        table {
            width: 100%;
            min-width: 1200px;
            border-collapse: collapse;
            white-space: nowrap;
        }
        
        th, td {
            padding: var(--spacing-md);
            text-align: left;
            border-bottom: 1px solid var(--bg-overlay);
            white-space: nowrap;
        }
        
        th {
            background: rgba(44, 85, 48, 0.05);
            font-weight: 600;
            color: var(--text-dark);
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
        tr:hover {
            background: rgba(44, 85, 48, 0.02);
        }
        
        .status-badge {
            padding: var(--spacing-xs) var(--spacing-sm);
            border-radius: var(--radius-sm);
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-active {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .actions {
            display: flex;
            gap: var(--spacing-xs);
            flex-wrap: nowrap;
            min-width: 280px;
        }
        
        .actions .btn {
            padding: var(--spacing-xs) var(--spacing-sm);
            font-size: 0.8rem;
            white-space: nowrap;
            min-width: auto;
            flex-shrink: 0;
        }
        
        .actions .btn i {
            margin-right: var(--spacing-xs);
        }
        
        .error {
            background: #fee;
            color: #c33;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #fcc;
        }
        
        .success {
            background: #efe;
            color: #3c3;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #cfc;
        }
        
        /* Form Styles */
        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .form-header {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            border-left: 4px solid #667eea;
        }
        
        .form-header h3 {
            margin: 0;
            color: #333;
            font-size: 1.2rem;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #333;
        }
        
        .form-group input, 
        .form-group select, 
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus, 
        .form-group select:focus, 
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2);
        }
        
        .readonly {
            background: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
        }
        
        .required {
            color: #dc3545;
            font-weight: bold;
        }
        
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            padding-top: 1rem;
            border-top: 1px solid #eee;
            margin-top: 2rem;
        }
        
        .help-text {
            font-size: 0.85rem;
            color: #666;
            margin-top: 0.25rem;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .nav-links {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .actions {
                flex-direction: column;
                min-width: 200px;
            }
            
            .actions .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 1200px) {
            .table-container {
                overflow-x: auto;
            }
            
            table {
                min-width: 1200px;
            }
            
            .actions {
                min-width: 250px;
            }
        }
        
        @media (max-width: 1400px) {
            .table-container {
                overflow-x: auto;
            }
            
            table {
                min-width: 1200px;
            }
        }
    </style>
    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-users"></i> Manage Customers</h1>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/items/">
                    <i class="fas fa-boxes"></i> Items
                </a>
                <a href="${pageContext.request.contextPath}/customers/">
                    <i class="fas fa-users"></i> Customers
                </a>
                <a href="${pageContext.request.contextPath}/bills/">
                    <i class="fas fa-file-invoice"></i> Bills
                </a>
                <a href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${not empty message}">
            <div class="success">${message}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <div class="page-header">
            <h2>Customer Management</h2>
            <a href="${pageContext.request.contextPath}/customers/new" class="btn">Add New Customer</a>
        </div>
        
        <div class="search-bar">
            <form class="search-form" method="get" action="${pageContext.request.contextPath}/customers/">
                <div class="form-group">
                    <label for="search">Search Customers</label>
                    <input type="text" id="search" name="search" placeholder="Name, Email, or Account #" value="${param.search}">
                </div>
                <div class="form-group">
                    <label for="statusFilter">Status</label>
                    <select id="statusFilter" name="statusFilter">
                        <option value="">All Status</option>
                        <option value="ACTIVE" ${param.statusFilter == 'ACTIVE' ? 'selected' : ''}>Active</option>
                        <option value="INACTIVE" ${param.statusFilter == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <button type="submit" class="btn">Search</button>
                </div>
            </form>
        </div>
        
        <c:choose>
            <c:when test="${not empty editCustomer}">
                <div class="form-container">
                    <div class="form-header">
                        <h3>Edit Customer</h3>
                    </div>
                    
                    <form method="post" action="${pageContext.request.contextPath}/customers/">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="id" value="${editCustomer.id}" />
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>Customer ID</label>
                                <input type="text" value="${editCustomer.id}" class="readonly" readonly />
                                <div class="help-text">Auto-generated customer ID</div>
                            </div>
                            
                            <div class="form-group">
                                <label>Account Number</label>
                                <input type="text" value="${editCustomer.accountNumber}" class="readonly" readonly />
                                <div class="help-text">Auto-generated account number</div>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="name">Full Name <span class="required">*</span></label>
                                <input type="text" id="name" name="name" value="${editCustomer.name}" required 
                                       placeholder="Enter customer's full name" maxlength="100" />
                                <div class="help-text">Enter the customer's complete name</div>
                            </div>
                            
                            <div class="form-group">
                                <label for="email">Email Address <span class="required">*</span></label>
                                <input type="email" id="email" name="email" value="${editCustomer.email}" required 
                                       placeholder="customer@example.com" />
                                <div class="help-text">Enter a valid email address</div>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="text" id="phone" name="phone" value="${editCustomer.phone}" 
                                       placeholder="+1 (555) 123-4567" />
                                <div class="help-text">Enter contact phone number (optional)</div>
                            </div>
                            
                            <div class="form-group">
                                <label for="unitRate">Unit Rate <span class="required">*</span></label>
                                <input type="number" step="0.01" min="0" id="unitRate" name="unitRate" 
                                       value="${editCustomer.unitRate}" required placeholder="0.00" />
                                <div class="help-text">Enter the unit rate for billing calculations</div>
                            </div>
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="address">Address</label>
                            <input type="text" id="address" name="address" value="${editCustomer.address}" 
                                   placeholder="Enter complete address" />
                            <div class="help-text">Enter the customer's billing address (optional)</div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="isActive">Status</label>
                                <select id="isActive" name="isActive">
                                    <option value="true" ${editCustomer.active ? 'selected' : ''}>Active</option>
                                    <option value="false" ${!editCustomer.active ? 'selected' : ''}>Inactive</option>
                                </select>
                                <div class="help-text">Active customers can receive bills</div>
                            </div>
                            
                            <div class="form-group">
                                <label>Created Date</label>
                                <input type="text" value="${editCustomer.createdAt}" class="readonly" readonly />
                                <div class="help-text">Date when customer was created</div>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/customers/" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn">Update Customer</button>
                        </div>
                    </form>
                </div>
            </c:when>
            
            <c:otherwise>
                <div class="customers-table">
                    <div class="table-header">
                        <h2>All Customers (${customers.size()} customers)</h2>
                    </div>
                    
                    <div class="table-container">
                        <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Account #</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Unit Rate</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="customer" items="${customers}">
                                <tr>
                                    <td>${customer.id}</td>
                                    <td><strong>${customer.accountNumber}</strong></td>
                                    <td>${customer.name}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.phone}</td>
                                    <td>$${customer.unitRate}</td>
                                    <td>
                                        <span class="status-badge ${customer.active ? 'status-active' : 'status-inactive'}">
                                            ${customer.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>${customer.createdAt}</td>
                                    <td>
                                        <div class="actions">
                                            <form method="get" action="${pageContext.request.contextPath}/customers/" style="display:inline;">
                                                <input type="hidden" name="id" value="${customer.id}" />
                                                <input type="hidden" name="action" value="edit" />
                                                <button type="submit" class="btn btn-warning">
                                                    <i class="fas fa-edit"></i>Edit
                                                </button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/customers/" style="display:inline;">
                                                <input type="hidden" name="action" value="delete" />
                                                <input type="hidden" name="id" value="${customer.id}" />
                                                <button type="submit" class="btn btn-danger" 
                                                        onclick="return confirm('Are you sure you want to delete this customer? This action cannot be undone.');">
                                                    <i class="fas fa-trash"></i>Delete
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    </div>
                    
                    <c:if test="${empty customers}">
                        <div style="padding: 2rem; text-align: center; color: #666;">
                            <p>No customers found. <a href="${pageContext.request.contextPath}/customers/new">Add your first customer</a></p>
                        </div>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Format unit rate input
            const unitRateInput = document.getElementById('unitRate');
            if (unitRateInput) {
                unitRateInput.addEventListener('blur', function() {
                    if (this.value) {
                        this.value = parseFloat(this.value).toFixed(2);
                    }
                });
            }
            
            // Validate form before submit
            const form = document.querySelector('form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const name = document.getElementById('name')?.value.trim();
                    const email = document.getElementById('email')?.value.trim();
                    const unitRate = parseFloat(document.getElementById('unitRate')?.value);
                    
                    if (name && !name) {
                        e.preventDefault();
                        alert('Please enter the customer name.');
                        return;
                    }
                    
                    if (email && !email) {
                        e.preventDefault();
                        alert('Please enter a valid email address.');
                        return;
                    }
                    
                    if (unitRate && unitRate < 0) {
                        e.preventDefault();
                        alert('Unit rate cannot be negative.');
                        return;
                    }
                });
            }
        });
    </script>
</body>
</html> 