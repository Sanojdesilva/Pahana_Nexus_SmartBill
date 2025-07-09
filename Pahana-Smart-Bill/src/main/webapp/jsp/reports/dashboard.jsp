<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports Dashboard - Pahana Smart Bill</title>
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
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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
        
        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .report-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .report-card h3 {
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.3rem;
        }
        
        .report-card p {
            color: #666;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .btn-group {
            display: flex;
            gap: 1rem;
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
            font-size: 0.9rem;
        }
        
        .btn:hover {
            background: #5a6fd8;
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
        <h1>Reports Dashboard</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/customers/">Customers</a>
            <a href="${pageContext.request.contextPath}/bills/">Bills</a>
            <a href="${pageContext.request.contextPath}/reports/">Reports</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
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
                <h3>${completedBills}</h3>
                <p>Completed Bills</p>
            </div>
            <div class="stat-card">
                <h3>${totalCustomers}</h3>
                <p>Total Customers</p>
            </div>
            <div class="stat-card">
                <h3>${activeCustomers}</h3>
                <p>Active Customers</p>
            </div>
            <div class="stat-card">
                <h3>${totalItems}</h3>
                <p>Total Items</p>
            </div>
            <div class="stat-card">
                <h3>${activeItems}</h3>
                <p>Active Items</p>
            </div>
            <div class="stat-card">
                <h3>$<fmt:formatNumber value="${totalRevenue}" type="number" minFractionDigits="2" maxFractionDigits="2"/></h3>
                <p>Total Revenue</p>
            </div>
        </div>
        
        <div class="reports-grid">
            <div class="report-card">
                <h3>Sales Report</h3>
                <p>Generate comprehensive sales reports with revenue analysis, bill statistics, and date range filtering.</p>
                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/reports/sales?format=pdf" class="btn btn-success">Export PDF</a>
                </div>
            </div>
            
            <div class="report-card">
                <h3>Customer Report</h3>
                <p>Detailed customer analysis including active/inactive customers, contact information, and account status.</p>
                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/reports/customers?format=pdf" class="btn btn-success">Export PDF</a>
                </div>
            </div>
            
            <div class="report-card">
                <h3>Inventory Report</h3>
                <p>Complete inventory overview with stock levels, pricing information, and total inventory value.</p>
                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/reports/inventory?format=pdf" class="btn btn-success">Export PDF</a>
                </div>
            </div>
            
            <div class="report-card">
                <h3>Bills Report</h3>
                <p>Comprehensive billing report with payment status, amounts, and customer billing history.</p>
                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/reports/bills?format=pdf" class="btn btn-success">Export PDF</a>
                </div>
            </div>
        </div>
    </div>

<!-- Custom Report Modal Trigger -->
<div style="text-align:right; margin-bottom:1.5rem;">
    <button class="btn btn-success" id="openCustomReportModal">Create Custom Report</button>
</div>

<!-- Custom Report Modal -->
<div id="customReportModal" style="display:none; position:fixed; top:0; left:0; width:100vw; height:100vh; background:rgba(0,0,0,0.4); z-index:1000; align-items:center; justify-content:center;">
    <div style="background:white; border-radius:10px; max-width:500px; width:95%; margin:auto; padding:2rem; position:relative; box-shadow:0 4px 32px rgba(0,0,0,0.2);">
        <button id="closeCustomReportModal" style="position:absolute; top:1rem; right:1rem; background:none; border:none; font-size:1.5rem; cursor:pointer;">&times;</button>
        <h2 style="margin-bottom:1.5rem; color:#667eea;">Create Custom Report</h2>
        <form id="customReportForm" method="get" action="${pageContext.request.contextPath}/reports/custom">
            <div class="form-group">
                <label for="reportType">Report Type</label>
                <select id="reportType" name="reportType" required>
                    <option value="SALES">Sales Report</option>
                    <option value="CUSTOMER">Customer Report</option>
                    <option value="INVENTORY">Inventory Report</option>
                    <option value="AUDIT">Audit Report</option>
                </select>
            </div>
            <div class="form-group">
                <label for="period">Period</label>
                <select id="period" name="period" required>
                    <option value="WEEKLY">Weekly</option>
                    <option value="MONTHLY">Monthly</option>
                    <option value="YEARLY">Yearly</option>
                    <option value="CUSTOM">Custom Range</option>
                </select>
            </div>
            <div class="form-group" id="customDateRange" style="display:none;">
                <label>Custom Date Range</label>
                <div style="display:flex; gap:1rem;">
                    <input type="date" name="startDate" id="startDate" />
                    <input type="date" name="endDate" id="endDate" />
                </div>
            </div>
            <div class="form-group">
                <label for="format">Format</label>
                <select id="format" name="format" required>
                    <option value="PDF">PDF</option>
                    <option value="CSV">CSV</option>
                </select>
            </div>
            <div class="form-group">
                <label>Fields/Columns</label>
                <div id="fieldsContainer">
                    <!-- Dynamically populated checkboxes -->
                </div>
            </div>
            <div style="text-align:right; margin-top:2rem;">
                <button type="submit" class="btn btn-success">Generate & Download</button>
            </div>
        </form>
    </div>
</div>

<script>
// Modal open/close logic
const openBtn = document.getElementById('openCustomReportModal');
const modal = document.getElementById('customReportModal');
const closeBtn = document.getElementById('closeCustomReportModal');
if (openBtn && modal && closeBtn) {
    openBtn.onclick = () => { modal.style.display = 'flex'; };
    closeBtn.onclick = () => { modal.style.display = 'none'; };
    window.onclick = (e) => { if (e.target === modal) modal.style.display = 'none'; };
}
// Show/hide custom date range
const periodSelect = document.getElementById('period');
const customDateRange = document.getElementById('customDateRange');
if (periodSelect && customDateRange) {
    periodSelect.onchange = function() {
        customDateRange.style.display = (this.value === 'CUSTOM') ? 'block' : 'none';
    };
}
// Dynamic fields for each report type
const fieldsByType = {
    SALES: ['Bill Number', 'Customer', 'Amount', 'Status', 'Date'],
    CUSTOMER: ['Name', 'Email', 'Phone', 'Address', 'Status', 'Account Number', 'Created At'],
    INVENTORY: ['Item Code', 'Name', 'Category', 'Price', 'Stock', 'Status'],
    AUDIT: ['Action', 'User', 'Timestamp', 'Details']
};
const reportTypeSelect = document.getElementById('reportType');
const fieldsContainer = document.getElementById('fieldsContainer');
function renderFields(type) {
    fieldsContainer.innerHTML = '';
    (fieldsByType[type] || []).forEach(field => {
        const id = 'field_' + field.replace(/\s+/g, '_');
        fieldsContainer.innerHTML += `<label style='display:block; margin-bottom:0.5rem;'><input type='checkbox' name='fields' value='${field}' checked> ${field}</label>`;
    });
}
if (reportTypeSelect && fieldsContainer) {
    reportTypeSelect.onchange = function() { renderFields(this.value); };
    renderFields(reportTypeSelect.value);
}
</script>
</body>
</html> 