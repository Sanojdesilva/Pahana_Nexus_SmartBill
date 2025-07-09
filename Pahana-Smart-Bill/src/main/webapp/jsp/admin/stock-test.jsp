<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Management Test</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
    <style>
        .test-section {
            background: white;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .stock-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .item-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            background: #f8f9fa;
        }
        .low-stock {
            border-color: #dc3545;
            background: #f8d7da;
        }
        .test-actions {
            margin: 20px 0;
        }
        .btn {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary { background: #007bff; color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn-warning { background: #ffc107; color: black; }
        .btn-danger { background: #dc3545; color: white; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Stock Management Test</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/bills/">Bills</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="test-section">
            <h2>Current Stock Status</h2>
            <div class="stock-info">
                <c:forEach var="item" items="${items}">
                    <div class="item-card ${item.stockQuantity <= item.reorderLevel ? 'low-stock' : ''}">
                        <h4>${item.name}</h4>
                        <p><strong>Code:</strong> ${item.code}</p>
                        <p><strong>Stock:</strong> ${item.stockQuantity}</p>
                        <p><strong>Reorder Level:</strong> ${item.reorderLevel}</p>
                        <p><strong>Price:</strong> $${item.price}</p>
                        <p><strong>Status:</strong> ${item.active ? 'Active' : 'Inactive'}</p>
                        <c:if test="${item.stockQuantity <= item.reorderLevel}">
                            <p style="color: #dc3545; font-weight: bold;">⚠️ Low Stock Warning!</p>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <div class="test-section">
            <h2>Stock Management Features</h2>
            <div class="test-actions">
                <h3>✅ Implemented Features:</h3>
                <ul>
                    <li><strong>Stock Validation:</strong> When creating bills, the system checks if sufficient stock is available</li>
                    <li><strong>Stock Reduction:</strong> When items are added to bills, stock is automatically decremented</li>
                    <li><strong>Stock Restoration:</strong> When bills are cancelled, stock is automatically incremented</li>
                    <li><strong>Real-time Warnings:</strong> The bill creation form shows stock warnings in real-time</li>
                    <li><strong>Form Validation:</strong> Prevents bill submission when stock is insufficient</li>
                    <li><strong>Low Stock Monitoring:</strong> Items below reorder level are highlighted</li>
                </ul>
                
                <h3>🔧 How to Test:</h3>
                <ol>
                    <li>Go to <a href="${pageContext.request.contextPath}/bills/new" class="btn btn-primary">Create Bill</a></li>
                    <li>Select items and quantities</li>
                    <li>Try to add more items than available stock - you'll see warnings</li>
                    <li>Create a bill - stock will be reduced</li>
                    <li>Cancel the bill - stock will be restored</li>
                </ol>
            </div>
        </div>
        
        <div class="test-section">
            <h2>Inventory Summary</h2>
            <div class="stock-info">
                <div class="item-card">
                    <h4>Total Items</h4>
                    <p style="font-size: 2em; color: #007bff;">${totalItems}</p>
                </div>
                <div class="item-card">
                    <h4>Low Stock Items</h4>
                    <p style="font-size: 2em; color: #dc3545;">${lowStockCount}</p>
                </div>
                <div class="item-card">
                    <h4>Total Stock Value</h4>
                    <p style="font-size: 2em; color: #28a745;">$${totalValue}</p>
                </div>
            </div>
        </div>
        
        <div class="test-actions">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary">Back to Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/" class="btn btn-success">Manage Items</a>
            <a href="${pageContext.request.contextPath}/bills/" class="btn btn-warning">View Bills</a>
        </div>
    </div>
</body>
</html> 