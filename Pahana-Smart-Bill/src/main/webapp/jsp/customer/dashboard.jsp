<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - Pahana Smart Bill</title>
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
        
        .warning {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
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
        
        .bill-status {
            display: inline-block;
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
        
        .status-overdue {
            background: #f8d7da;
            color: #721c24;
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
</head>
<body>
    <div class="header">
        <h1>Customer Dashboard</h1>
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