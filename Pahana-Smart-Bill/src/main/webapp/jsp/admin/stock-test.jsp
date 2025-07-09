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
        body { min-height: 100vh; }
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
        .card {
            background: var(--bg-card);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            margin-bottom: var(--spacing-xl);
            padding: var(--spacing-xl);
        }
        .table-header {
            background: rgba(44, 85, 48, 0.05);
            padding: var(--spacing-lg);
            border-bottom: 1px solid var(--bg-overlay);
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
        }
        .table-header h2 {
            margin: 0;
            color: var(--text-dark);
            font-weight: 700;
        }
        .stock-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: var(--spacing-lg);
            margin: var(--spacing-lg) 0;
        }
        .item-card {
            border: 1px solid #ddd;
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            background: #f8f9fa;
            box-shadow: var(--shadow-sm);
        }
        .low-stock {
            border-color: #dc3545;
            background: #f8d7da;
        }
        .test-actions {
            margin: var(--spacing-lg) 0;
        }
        .btn {
            padding: var(--spacing-sm) var(--spacing-lg);
            border: none;
            border-radius: var(--radius-md);
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-xs);
            font-size: 1rem;
            font-weight: 600;
            transition: all var(--transition-normal);
        }
        .btn-primary { background: var(--primary-color); color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn-warning { background: #ffc107; color: black; }
        .btn-danger { background: #dc3545; color: white; }
        @media (max-width: 768px) {
            .nav-links { flex-direction: column; gap: 0.5rem; }
            .stock-info { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-warehouse"></i> Stock Management Test</h1>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/items/"><i class="fas fa-boxes"></i> Items</a>
                <a href="${pageContext.request.contextPath}/bills/"><i class="fas fa-file-invoice"></i> Bills</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="table-header"><h2>Current Stock Status</h2></div>
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
        <div class="card">
            <div class="table-header"><h2>Stock Management Features</h2></div>
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
                    <li>Go to <a href="${pageContext.request.contextPath}/bills/new" class="btn btn-primary"><i class="fas fa-plus"></i> Create Bill</a></li>
                    <li>Select items and quantities</li>
                    <li>Try to add more items than available stock - you'll see warnings</li>
                    <li>Create a bill - stock will be reduced</li>
                    <li>Cancel the bill - stock will be restored</li>
                </ol>
            </div>
        </div>
        <div class="card">
            <div class="table-header"><h2>Inventory Summary</h2></div>
            <div class="stock-info">
                <div class="item-card">
                    <h4>Total Items</h4>
                    <p style="font-size: 2em; color: #007bff;"><i class="fas fa-cubes"></i> ${totalItems}</p>
                </div>
                <div class="item-card">
                    <h4>Low Stock Items</h4>
                    <p style="font-size: 2em; color: #dc3545;"><i class="fas fa-exclamation-triangle"></i> ${lowStockCount}</p>
                </div>
                <div class="item-card">
                    <h4>Total Stock Value</h4>
                    <p style="font-size: 2em; color: #28a745;"><i class="fas fa-dollar-sign"></i> $${totalValue}</p>
                </div>
            </div>
        </div>
        <div class="test-actions">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/" class="btn btn-success"><i class="fas fa-boxes"></i> Manage Items</a>
            <a href="${pageContext.request.contextPath}/bills/" class="btn btn-warning"><i class="fas fa-file-invoice"></i> View Bills</a>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/4b7c1b6e8b.js" crossorigin="anonymous"></script>
</body>
</html> 