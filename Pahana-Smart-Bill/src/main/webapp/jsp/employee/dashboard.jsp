<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard - Pahana Smart Bill</title>
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
        
        .user-info {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
        }
        
        .user-info span {
            font-weight: 500;
        }
        
        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: var(--text-white);
            padding: var(--spacing-xs) var(--spacing-sm);
            border-radius: var(--radius-sm);
            text-decoration: none;
            transition: background var(--transition-normal);
            font-weight: 500;
        }
        
        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            text-decoration: none;
            color: var(--text-white);
        }
        
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: var(--spacing-xl);
        }
        
        .recent-section {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            padding: var(--spacing-xl);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            position: relative;
            overflow: hidden;
        }
        
        .recent-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
        }
        
        .recent-section h2 {
            color: var(--text-dark);
            margin-bottom: var(--spacing-lg);
            font-size: 1.5rem;
            font-weight: 700;
        }
        
        .recent-item {
            padding: var(--spacing-md) 0;
            border-bottom: 1px solid var(--bg-overlay);
            transition: all var(--transition-normal);
        }
        
        .recent-item:last-child {
            border-bottom: none;
        }
        
        .recent-item:hover {
            background: rgba(44, 85, 48, 0.02);
            margin: 0 calc(-1 * var(--spacing-md));
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
        }
        
        .recent-item h4 {
            color: var(--text-dark);
            margin-bottom: var(--spacing-xs);
            font-weight: 600;
        }
        
        .recent-item p {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 0;
        }
    </style>
    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-user-tie"></i> Employee Dashboard</h1>
            <div class="user-info">
                <span><i class="fas fa-user"></i> Welcome, ${sessionScope.username}</span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
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
                <h3>${pendingBillCount}</h3>
                <p>Pending Bills</p>
            </div>
            <div class="stat-card">
                <h3>${completedBillCount}</h3>
                <p>Completed Bills</p>
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
                <h2>Recent Items</h2>
                <c:forEach var="item" items="${recentItems}">
                    <div class="recent-item">
                        <h4>${item.name}</h4>
                        <p>Price: $${item.price} | Stock: ${item.stockQuantity} | Status: ${item.active ? 'Active' : 'Inactive'}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <div class="nav-grid">
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
                <p>Sales and inventory reports</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/employee/profile/" class="nav-card">
                <h3>My Profile</h3>
                <p>Update your profile information</p>
            </a>
        </div>
    </div>
</body>
</html> 