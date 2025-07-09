<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - Pahana Smart Bill</title>
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
        
        .bill-status {
            display: inline-block;
            padding: var(--spacing-xs) var(--spacing-sm);
            border-radius: var(--radius-sm);
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }
        
        .status-paid {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-overdue {
            background: #fee2e2;
            color: #991b1b;
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
        <div class="header-content">
            <h1><i class="fas fa-user-circle"></i> Customer Dashboard</h1>
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
                <h3>${totalBills}</h3>
                <p>Total Bills</p>
            </div>
            <div class="stat-card">
                <h3>${pendingBills}</h3>
                <p>Pending Bills</p>
            </div>
            <div class="stat-card">
                <h3>${paidBills}</h3>
                <p>Paid Bills</p>
            </div>
            <div class="stat-card">
                <h3>$${totalOwed}</h3>
                <p>Amount Owed</p>
            </div>
            <div class="stat-card">
                <h3>$${totalPaid}</h3>
                <p>Total Paid</p>
            </div>
        </div>
        
        <div class="content-grid">
            <div class="recent-section">
                <h2>Recent Bills</h2>
                <c:forEach var="bill" items="${recentBills}">
                    <div class="recent-item">
                        <h4>Bill #${bill.billNumber}</h4>
                        <p>
                            Amount: $${bill.total} | 
                            Status: <span class="bill-status status-${bill.status.toLowerCase()}">${bill.status}</span> | 
                            Date: ${bill.createdAt}
                        </p>
                    </div>
                </c:forEach>
            </div>
            
            <div class="recent-section">
                <h2>Payment Summary</h2>
                <div class="recent-item">
                    <h4>Current Balance</h4>
                    <p>$${totalOwed}</p>
                </div>
                <div class="recent-item">
                    <h4>Last Payment</h4>
                    <p>$${totalPaid}</p>
                </div>
                <div class="recent-item">
                    <h4>Payment Due</h4>
                    <p>${pendingBills > 0 ? 'Yes' : 'No'}</p>
                </div>
            </div>
        </div>
        
        <div class="nav-grid">
            <a href="${pageContext.request.contextPath}/customer/bills/" class="nav-card">
                <h3>View My Bills</h3>
                <p>View all your billing history</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/customer/profile/" class="nav-card">
                <h3>My Profile</h3>
                <p>Update your profile information</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/customer/payment/" class="nav-card">
                <h3>Make Payment</h3>
                <p>Pay your pending bills</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/customer/support/" class="nav-card">
                <h3>Support</h3>
                <p>Contact customer support</p>
            </a>
        </div>
    </div>
</body>
</html> 