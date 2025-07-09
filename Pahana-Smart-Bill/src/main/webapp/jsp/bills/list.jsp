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
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h1 {
            font-size: 1.5rem;
        }
        
        .nav-links {
            display: flex;
            gap: 1rem;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background 0.3s;
        }
        
        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.2);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .page-header h2 {
            color: #333;
            font-size: 1.8rem;
        }
        
        .btn {
            background: #667eea;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
            transition: background 0.3s;
            font-size: 1rem;
        }
        
        .btn:hover {
            background: #5a6fd8;
        }
        
        .btn-secondary {
            background: #6c757d;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        .btn-danger {
            background: #dc3545;
        }
        
        .btn-danger:hover {
            background: #c82333;
        }
        
        .btn-warning {
            background: #ffc107;
            color: #333;
        }
        
        .btn-warning:hover {
            background: #e0a800;
        }
        
        .btn-success {
            background: #28a745;
        }
        
        .btn-success:hover {
            background: #218838;
        }
        
        .btn-info {
            background: #17a2b8;
        }
        
        .btn-info:hover {
            background: #138496;
        }
        
        .search-bar {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .search-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        
        .form-group {
            flex: 1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }
        
        .bills-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
            overflow-y: visible;
            width: 100%;
        }
        
        .table-header {
            background: #f8f9fa;
            padding: 1rem;
            border-bottom: 1px solid #dee2e6;
        }
        
        .table-header h2 {
            margin: 0;
            color: #333;
        }
        
        table {
            width: 100%;
            min-width: 1200px;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        
        th {
            background: #f8f9fa;
            font-weight: bold;
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
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .actions .btn {
            padding: 0.5rem 0.75rem;
            font-size: 0.85rem;
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
            }
        }

        @media (max-width: 900px) {
            .bills-table {
                overflow-x: auto;
            }
            table {
                min-width: 1200px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Manage Bills</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/customers/">Customers</a>
            <a href="${pageContext.request.contextPath}/bills/">Bills</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
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
                                    <a href="${pageContext.request.contextPath}/bills/view?id=${bill.id}" class="btn btn-info">View</a>
                                    <a href="${pageContext.request.contextPath}/bills/pdf/${bill.id}" class="btn btn-success">Download PDF</a>
                                    <form method="get" action="${pageContext.request.contextPath}/bills/" style="display:inline;">
                                        <input type="hidden" name="id" value="${bill.id}" />
                                        <input type="hidden" name="action" value="edit" />
                                        <button type="submit" class="btn btn-warning">Edit</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/bills/" style="display:inline;">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="id" value="${bill.id}" />
                                        <button type="submit" class="btn btn-danger" 
                                                onclick="return confirm('Are you sure you want to delete this bill? This action cannot be undone.');">
                                            Delete
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
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