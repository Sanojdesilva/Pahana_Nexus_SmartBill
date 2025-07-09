<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahana.model.Bill" %>
<%@ page import="com.pahana.model.Customer" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bills - Pahana Smart Bill</title>
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
        
        .bills-table {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            width: 100%;
            position: relative;
            overflow: hidden;
        }
        
        .bills-table::before {
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
            min-width: 1400px;
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
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 0.25rem 0.5rem;
            border-radius: 3px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-paid {
            background: #d4edda;
            color: #155724;
        }
        
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        
        .actions {
            display: flex;
            gap: var(--spacing-xs);
            flex-wrap: nowrap;
            min-width: 300px;
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
        
        .amount {
            font-weight: bold;
            color: #28a745;
        }
        
        .bill-number {
            font-weight: bold;
            color: #667eea;
        }
        
        .customer-name {
            font-weight: 500;
        }
        
        @media (max-width: 768px) {
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
                min-width: 1400px;
            }
            
            .actions {
                min-width: 280px;
            }
        }
        
        @media (max-width: 1400px) {
            .table-container {
                overflow-x: auto;
            }
            
            table {
                min-width: 1400px;
            }
        }
    </style>
    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-file-invoice"></i> Manage Bills</h1>
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
            <h2>Bill Management</h2>
            <a href="${pageContext.request.contextPath}/bills?action=new" class="btn">Create New Bill</a>
        </div>
        
        <div class="search-bar">
            <form class="search-form" method="get" action="${pageContext.request.contextPath}/bills">
                <div class="form-group">
                    <label for="search">Search Bills</label>
                    <input type="text" id="search" name="search" placeholder="Bill #, Customer Name, or Notes" value="${param.search}">
                </div>
                <div class="form-group">
                    <label for="statusFilter">Status</label>
                    <select id="statusFilter" name="statusFilter">
                        <option value="">All Status</option>
                        <option value="PENDING" ${param.statusFilter == 'PENDING' ? 'selected' : ''}>Pending</option>
                        <option value="PAID" ${param.statusFilter == 'PAID' ? 'selected' : ''}>Paid</option>
                        <option value="CANCELLED" ${param.statusFilter == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <button type="submit" class="btn">Search</button>
                </div>
            </form>
        </div>
        
        <div class="bills-table">
            <div class="table-header">
                <h2>All Bills (${bills.size()} bills)</h2>
            </div>
            
            <div class="table-container">
                <table>
                <thead>
                    <tr>
                        <th>Bill #</th>
                        <th>Customer</th>
                        <th>Status</th>
                        <th>Units</th>
                        <th>Rate</th>
                        <th>Subtotal</th>
                        <th>Tax</th>
                        <th>Total</th>
                        <th>Due Date</th>
                        <th>Created</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bill" items="${bills}">
                        <tr>
                            <td><span class="bill-number">${bill.billNumber}</span></td>
                            <td>
                                <span class="customer-name">
                                    <c:forEach var="customer" items="${customers}">
                                        <c:if test="${customer.id == bill.customerId}">${customer.name}</c:if>
                                    </c:forEach>
                                </span>
                            </td>
                            <td>
                                <span class="status-badge status-${bill.status.toLowerCase()}">
                                    ${bill.status}
                                </span>
                            </td>
                            <td>${bill.unitsConsumed}</td>
                            <td>$${bill.unitRate}</td>
                            <td class="amount">$${bill.subtotal}</td>
                            <td class="amount">$${bill.taxAmount}</td>
                            <td class="amount">$${bill.total}</td>
                            <td>${bill.dueDate}</td>
                            <td>${bill.createdAt}</td>
                            <td>
                                <div class="actions">
                                    <a href="${pageContext.request.contextPath}/bills/view?id=${bill.id}" class="btn btn-info">
                                        <i class="fas fa-eye"></i>View
                                    </a>
                                    <a href="${pageContext.request.contextPath}/bills/pdf/${bill.id}" class="btn btn-success">
                                        <i class="fas fa-download"></i>PDF
                                    </a>
                                    <form method="get" action="${pageContext.request.contextPath}/bills/" style="display:inline;">
                                        <input type="hidden" name="id" value="${bill.id}" />
                                        <input type="hidden" name="action" value="edit" />
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-edit"></i>Edit
                                        </button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/bills/" style="display:inline;">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="id" value="${bill.id}" />
                                        <button type="submit" class="btn btn-danger" 
                                                onclick="return confirm('Are you sure you want to delete this bill? This action cannot be undone.');">
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
            
            <c:if test="${empty bills}">
                <div style="padding: 2rem; text-align: center; color: #666;">
                    <p>No bills found. <a href="${pageContext.request.contextPath}/bills?action=new">Create your first bill</a></p>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-focus on search field
            const searchInput = document.getElementById('search');
            if (searchInput) {
                searchInput.focus();
            }
            
            // Add keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Ctrl/Cmd + N to create new bill
                if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/bills/new';
                }
            });
        });
    </script>
</body>
</html> 