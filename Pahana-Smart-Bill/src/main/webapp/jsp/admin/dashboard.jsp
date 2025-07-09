<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
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
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .stat-card h3 {
            color: #667eea;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        
        .stat-card p {
            color: #666;
            font-size: 0.9rem;
        }
        
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }
        
        .recent-section {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .recent-section h2 {
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }
        
        .recent-item {
            padding: 0.75rem 0;
            border-bottom: 1px solid #eee;
        }
        
        .recent-item:last-child {
            border-bottom: none;
        }
        
        .recent-item h4 {
            color: #333;
            margin-bottom: 0.25rem;
        }
        
        .recent-item p {
            color: #666;
            font-size: 0.9rem;
        }
        
        .nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .nav-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            text-decoration: none;
            color: #333;
            transition: transform 0.2s;
        }
        
        .nav-card:hover {
            transform: translateY(-2px);
        }
        
        .nav-card h3 {
            color: #667eea;
            margin-bottom: 0.5rem;
        }
        
        .nav-card p {
            color: #666;
            font-size: 0.9rem;
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
    </style>
    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
</head>
<body>
    <div class="header">
        <h1>Admin Dashboard</h1>
        <div class="user-info">
            <span>Welcome, ${sessionScope.username}</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <c:if test="${not empty message}">
            <div class="success">${message}</div>
        </c:if>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>${totalUsers}</h3>
                <p>Total Users</p>
            </div>
            <div class="stat-card">
                <h3>${activeUserCount}</h3>
                <p>Active Users</p>
            </div>
            <div class="stat-card">
                <h3>${totalCustomers}</h3>
                <p>Total Customers</p>
            </div>
            <div class="stat-card">
                <h3>${activeCustomerCount}</h3>
                <p>Active Customers</p>
            </div>
            <div class="stat-card">
                <h3>${totalItems}</h3>
                <p>Total Items</p>
            </div>
            <div class="stat-card">
                <h3>${activeItemCount}</h3>
                <p>Active Items</p>
            </div>
            <div class="stat-card">
                <h3>${totalBills}</h3>
                <p>Total Bills</p>
            </div>
            <div class="stat-card">
                <h3>$<fmt:formatNumber value="${totalRevenue}" type="number" minFractionDigits="2" maxFractionDigits="2"/></h3>
                <p>Total Revenue</p>
            </div>
        </div>
        
        <div class="content-grid">
            <div class="recent-section">
                <h2>Recent Bills</h2>
                <c:forEach var="bill" items="${recentBills}">
                    <div class="recent-item">
                        <h4>Bill #${bill.billNumber}</h4>
                        <p>Amount: $${bill.total} | Status: ${bill.status} | Date: ${bill.createdAt}</p>
                    </div>
                </c:forEach>
            </div>
            
            <div class="recent-section">
                <h2>Recent Customers</h2>
                <c:forEach var="customer" items="${recentCustomers}">
                    <div class="recent-item">
                        <h4>${customer.name}</h4>
                        <p>Account: ${customer.accountNumber} | Status: ${customer.active ? 'Active' : 'Inactive'}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <div class="nav-grid">
            <a href="${pageContext.request.contextPath}/customers/" class="nav-card">
                <h3>Manage Customers</h3>
                <p>Create, edit, and manage customer accounts</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/items/" class="nav-card">
                <h3>Manage Items</h3>
                <p>Manage inventory items and pricing</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/bills/" class="nav-card">
                <h3>Manage Bills</h3>
                <p>Create and manage billing records</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/reports/" class="nav-card">
                <h3>Generate Reports</h3>
                <p>Sales, customer, and inventory reports</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-card">
                <h3>User Management</h3>
                <p>Manage system users and permissions</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/settings" class="nav-card">
                <h3>System Settings</h3>
                <p>Configure system parameters</p>
            </a>
        </div>
    </div>
</body>
</html> 