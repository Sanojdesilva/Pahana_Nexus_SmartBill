<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bills - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
    <style>
        .bills-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
        .bills-title { color: var(--primary-color); font-size: 1.8rem; font-weight: bold; }
        .search-filters { display: flex; gap: 1rem; align-items: center; flex-wrap: wrap; }
        .search-box { padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 5px; background: var(--input-bg); color: var(--text-color); }
        .filter-select { padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 5px; background: var(--input-bg); color: var(--text-color); }
        .btn { padding: 0.75rem 1.5rem; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; transition: all 0.3s; text-decoration: none; display: inline-block; }
        .btn-primary { background: var(--primary-color); color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        
        .bills-table { width: 100%; border-collapse: collapse; background: var(--card-bg); box-shadow: var(--shadow); border-radius: 10px; overflow: hidden; margin-bottom: 2rem; }
        .bills-table th, .bills-table td { padding: 1rem; text-align: left; }
        .bills-table th { background: var(--primary-color); color: #fff; font-weight: bold; }
        .bills-table tr:nth-child(even) { background: var(--table-alt-bg); }
        .bills-table tr:hover { background: var(--table-hover-bg); }
        .bills-table tr { border-bottom: 1px solid var(--border-color); }
        
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-paid { background: #d4edda; color: #155724; }
        .status-overdue { background: #f8d7da; color: #721c24; }
        .status-completed { background: #cce5ff; color: #004085; }
        
        .amount { font-weight: bold; color: var(--primary-color); }
        .bill-number { font-weight: bold; color: var(--text-color); }
        
        .empty-state { text-align: center; padding: 3rem; color: var(--text-muted); }
        .empty-state h3 { margin-bottom: 1rem; color: var(--text-color); }
        
        .summary-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin-bottom: 2rem; }
        .summary-card { background: var(--card-bg); padding: 1.5rem; border-radius: 10px; box-shadow: var(--shadow); text-align: center; }
        .summary-card h3 { color: var(--primary-color); font-size: 2rem; margin-bottom: 0.5rem; }
        .summary-card p { color: var(--text-muted); font-size: 0.9rem; }
        
        .pagination { display: flex; justify-content: center; gap: 0.5rem; margin-top: 2rem; }
        .page-btn { padding: 0.5rem 1rem; border: 1px solid var(--border-color); background: var(--card-bg); color: var(--text-color); border-radius: 5px; cursor: pointer; }
        .page-btn.active { background: var(--primary-color); color: white; border-color: var(--primary-color); }
        .page-btn:hover { background: var(--table-hover-bg); }
    </style>
</head>
<body>
    <div class="header">
        <h1>My Bills</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/profile">My Profile</a>
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
        
        <!-- Summary Cards -->
        <div class="summary-cards">
            <div class="summary-card">
                <h3>${totalBills != null ? totalBills : 0}</h3>
                <p>Total Bills</p>
            </div>
            <div class="summary-card">
                <h3>${pendingBills != null ? pendingBills : 0}</h3>
                <p>Pending Bills</p>
            </div>
            <div class="summary-card">
                <h3>${paidBills != null ? paidBills : 0}</h3>
                <p>Paid Bills</p>
            </div>
            <div class="summary-card">
                <h3><fmt:formatNumber value="${totalOwed != null ? totalOwed : 0}" type="currency" currencySymbol="$"/></h3>
                <p>Total Owed</p>
            </div>
        </div>
        
        <!-- Header with Search and Filters -->
        <div class="bills-header">
            <h2 class="bills-title">Billing History</h2>
            <div class="search-filters">
                <input type="text" id="searchInput" class="search-box" placeholder="Search bills..." onkeyup="filterBills()" />
                <select id="statusFilter" class="filter-select" onchange="filterBills()">
                    <option value="">All Status</option>
                    <option value="PENDING">Pending</option>
                    <option value="PAID">Paid</option>
                    <option value="OVERDUE">Overdue</option>
                    <option value="COMPLETED">Completed</option>
                </select>
                <select id="sortBy" class="filter-select" onchange="filterBills()">
                    <option value="date-desc">Date (Newest)</option>
                    <option value="date-asc">Date (Oldest)</option>
                    <option value="amount-desc">Amount (High to Low)</option>
                    <option value="amount-asc">Amount (Low to High)</option>
                </select>
            </div>
        </div>
        
        <!-- Bills Table -->
        <div class="table-container">
            <table class="bills-table" id="billsTable">
                <thead>
                    <tr>
                        <th>Bill #</th>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Due Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bill" items="${bills}">
                        <tr class="bill-row" data-status="${bill.status}" data-amount="${bill.total}">
                            <td class="bill-number">${bill.billNumber != null ? bill.billNumber : bill.id}</td>
                            <td><fmt:formatDate value="${bill.createdAt}" pattern="MMM dd, yyyy"/></td>
                            <td class="amount"><fmt:formatNumber value="${bill.total}" type="currency" currencySymbol="$"/></td>
                            <td>
                                <span class="status-badge status-${bill.status.toLowerCase()}">${bill.status}</span>
                            </td>
                            <td>
                                <c:if test="${bill.dueDate != null}">
                                    <fmt:formatDate value="${bill.dueDate}" pattern="MMM dd, yyyy"/>
                                </c:if>
                                <c:if test="${bill.dueDate == null}">
                                    -
                                </c:if>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/bills/pdf/${bill.id}" class="btn btn-success">Download PDF</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bills}">
                        <tr>
                            <td colspan="6" class="empty-state">
                                <h3>No bills found</h3>
                                <p>You don't have any bills yet. Check back later for new billing statements.</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <!-- Pagination -->
        <div class="pagination" id="pagination">
            <!-- Pagination will be generated by JavaScript -->
        </div>
    </div>
    
    <script>
        let currentPage = 1;
        const rowsPerPage = 10;
        let filteredRows = [];
        
        function filterBills() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const sortBy = document.getElementById('sortBy').value;
            
            const rows = document.querySelectorAll('.bill-row');
            filteredRows = [];
            
            rows.forEach(row => {
                const billNumber = row.querySelector('.bill-number').textContent.toLowerCase();
                const status = row.getAttribute('data-status');
                const amount = parseFloat(row.getAttribute('data-amount'));
                
                const matchesSearch = billNumber.includes(searchTerm);
                const matchesStatus = !statusFilter || status === statusFilter;
                
                if (matchesSearch && matchesStatus) {
                    filteredRows.push({ row, amount });
                }
                
                row.style.display = 'none';
            });
            
            // Sort filtered rows
            filteredRows.sort((a, b) => {
                switch(sortBy) {
                    case 'date-desc':
                        return 0; // Already sorted by date desc in server
                    case 'date-asc':
                        return 0; // Would need date attribute for proper sorting
                    case 'amount-desc':
                        return b.amount - a.amount;
                    case 'amount-asc':
                        return a.amount - b.amount;
                    default:
                        return 0;
                }
            });
            
            currentPage = 1;
            displayCurrentPage();
        }
        
        function displayCurrentPage() {
            const startIndex = (currentPage - 1) * rowsPerPage;
            const endIndex = startIndex + rowsPerPage;
            const pageRows = filteredRows.slice(startIndex, endIndex);
            
            pageRows.forEach(item => {
                item.row.style.display = '';
            });
            
            updatePagination();
        }
        
        function updatePagination() {
            const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
            const pagination = document.getElementById('pagination');
            pagination.innerHTML = '';
            
            if (totalPages <= 1) return;
            
            // Previous button
            if (currentPage > 1) {
                const prevBtn = document.createElement('button');
                prevBtn.className = 'page-btn';
                prevBtn.textContent = 'Previous';
                prevBtn.onclick = () => {
                    currentPage--;
                    displayCurrentPage();
                };
                pagination.appendChild(prevBtn);
            }
            
            // Page numbers
            for (let i = 1; i <= totalPages; i++) {
                const pageBtn = document.createElement('button');
                pageBtn.className = 'page-btn' + (i === currentPage ? ' active' : '');
                pageBtn.textContent = i;
                pageBtn.onclick = () => {
                    currentPage = i;
                    displayCurrentPage();
                };
                pagination.appendChild(pageBtn);
            }
            
            // Next button
            if (currentPage < totalPages) {
                const nextBtn = document.createElement('button');
                nextBtn.className = 'page-btn';
                nextBtn.textContent = 'Next';
                nextBtn.onclick = () => {
                    currentPage++;
                    displayCurrentPage();
                };
                pagination.appendChild(nextBtn);
            }
        }
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            filterBills();
        });
    </script>
</body>
</html> 