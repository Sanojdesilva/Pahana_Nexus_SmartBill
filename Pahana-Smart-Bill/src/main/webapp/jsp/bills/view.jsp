<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Details - Pahana Smart Bill</title>
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
            max-width: 900px;
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
        
        .btn-success {
            background: #28a745;
        }
        
        .btn-success:hover {
            background: #218838;
        }
        
        .btn-warning {
            background: #ffc107;
            color: #333;
        }
        
        .btn-warning:hover {
            background: #e0a800;
        }
        
        .bill-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .bill-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .bill-header h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        
        .bill-number {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        .bill-content {
            padding: 2rem;
        }
        
        .bill-section {
            margin-bottom: 2rem;
        }
        
        .bill-section h3 {
            color: #333;
            font-size: 1.3rem;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: bold;
            color: #666;
        }
        
        .info-value {
            font-weight: 500;
        }
        
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: bold;
            text-transform: uppercase;
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
        
        .amount {
            font-weight: bold;
            color: #28a745;
            font-size: 1.1rem;
        }
        
        .total-section {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 2rem;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .total-row:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.2rem;
            color: #28a745;
        }
        
        .notes-section {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
        }
        
        .notes-content {
            font-style: italic;
            color: #666;
            line-height: 1.6;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #eee;
        }
        
        .error {
            background: #fee;
            color: #c33;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #fcc;
        }
        
        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .nav-links {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Bill Details</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/customers/">Customers</a>
            <a href="${pageContext.request.contextPath}/bills/">Bills</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <div class="page-header">
            <h2>Bill Information</h2>
            <a href="${pageContext.request.contextPath}/bills" class="btn btn-secondary">Back to Bills</a>
        </div>
        
        <c:if test="${not empty bill}">
            <div class="bill-container">
                <div class="bill-header">
                    <h1>INVOICE</h1>
                    <div class="bill-number">Bill #${bill.billNumber}</div>
                </div>
                
                <div class="bill-content">
                    <div class="bill-section">
                        <h3>Customer Information</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">Customer Name:</span>
                                <span class="info-value">
                                    <c:forEach var="customer" items="${customers}">
                                        <c:if test="${customer.id == bill.customerId}">${customer.name}</c:if>
                                    </c:forEach>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Account Number:</span>
                                <span class="info-value">
                                    <c:forEach var="customer" items="${customers}">
                                        <c:if test="${customer.id == bill.customerId}">${customer.accountNumber}</c:if>
                                    </c:forEach>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Email:</span>
                                <span class="info-value">
                                    <c:forEach var="customer" items="${customers}">
                                        <c:if test="${customer.id == bill.customerId}">${customer.email}</c:if>
                                    </c:forEach>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Phone:</span>
                                <span class="info-value">
                                    <c:forEach var="customer" items="${customers}">
                                        <c:if test="${customer.id == bill.customerId}">${customer.phone}</c:if>
                                    </c:forEach>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="bill-section">
                        <h3>Bill Details</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">Bill Number:</span>
                                <span class="info-value">${bill.billNumber}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Status:</span>
                                <span class="info-value">
                                    <span class="status-badge status-${bill.status.toLowerCase()}">${bill.status}</span>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Created Date:</span>
                                <span class="info-value">${bill.createdAt}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Due Date:</span>
                                <span class="info-value">${bill.dueDate}</span>
                            </div>
                            <c:if test="${not empty bill.paidDate}">
                                <div class="info-item">
                                    <span class="info-label">Paid Date:</span>
                                    <span class="info-value">${bill.paidDate}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="bill-section">
                        <h3>Usage & Billing</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">Units Consumed:</span>
                                <span class="info-value">${bill.unitsConsumed} units</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Unit Rate:</span>
                                <span class="info-value">$${bill.unitRate} per unit</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="total-section">
                        <h3>Bill Summary</h3>
                        <div class="total-row">
                            <span>Subtotal:</span>
                            <span class="amount">$${bill.subtotal}</span>
                        </div>
                        <div class="total-row">
                            <span>Tax (15%):</span>
                            <span class="amount">$${bill.taxAmount}</span>
                        </div>
                        <div class="total-row">
                            <span>Total Amount:</span>
                            <span class="amount">$${bill.total}</span>
                        </div>
                    </div>
                    
                    <c:if test="${not empty bill.notes}">
                        <div class="notes-section">
                            <h3>Notes</h3>
                            <div class="notes-content">${bill.notes}</div>
                        </div>
                    </c:if>
                    
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/bills/pdf/${bill.id}" class="btn btn-success">Download PDF</a>
                        <a href="${pageContext.request.contextPath}/bills/?id=${bill.id}&action=edit" class="btn btn-warning">Edit Bill</a>
                        <a href="${pageContext.request.contextPath}/bills" class="btn btn-secondary">Back to Bills</a>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty bill}">
            <div class="bill-container">
                <div class="bill-content">
                    <div style="text-align: center; padding: 3rem;">
                        <h3>Bill Not Found</h3>
                        <p>The requested bill could not be found.</p>
                        <a href="${pageContext.request.contextPath}/bills" class="btn btn-secondary">Back to Bills</a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Add keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Ctrl/Cmd + P to download PDF
                if ((e.ctrlKey || e.metaKey) && e.key === 'p') {
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/bills/pdf?id=${bill.id}';
                }
                
                // Ctrl/Cmd + E to edit bill
                if ((e.ctrlKey || e.metaKey) && e.key === 'e') {
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/bills/?id=${bill.id}&action=edit';
                }
            });
        });
    </script>
</body>
</html> 