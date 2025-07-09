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
        .card { background: var(--bg-card); border-radius: var(--radius-xl); box-shadow: var(--shadow-lg); border: 1px solid var(--bg-overlay); margin-bottom: var(--spacing-xl); padding: var(--spacing-xl); }
        .table-header { background: rgba(44, 85, 48, 0.05); padding: var(--spacing-lg); border-bottom: 1px solid var(--bg-overlay); border-radius: var(--radius-xl) var(--radius-xl) 0 0; }
        .table-header h2, .table-header h3 { margin: 0; color: var(--text-dark); font-weight: 700; }
        .summary-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: var(--spacing-lg); margin-bottom: var(--spacing-xl); }
        .summary-card { background: var(--bg-white); padding: var(--spacing-xl); border-radius: var(--radius-lg); box-shadow: var(--shadow-md); text-align: center; }
        .summary-card h3 { color: var(--primary-color); font-size: 2rem; margin-bottom: 0.5rem; }
        .summary-card p { color: var(--text-muted); font-size: 0.9rem; }
        .bills-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: var(--spacing-xl); }
        .bills-title { color: var(--primary-color); font-size: 1.8rem; font-weight: bold; }
        .search-filters { display: flex; gap: var(--spacing-lg); align-items: center; flex-wrap: wrap; }
        .search-box, .filter-select { padding: var(--spacing-sm); border: 2px solid #e5e7eb; border-radius: var(--radius-md); background: rgba(255,255,255,0.9); color: var(--text-dark); font-size: 1rem; }
        .btn { padding: var(--spacing-sm) var(--spacing-lg); border: none; border-radius: var(--radius-md); cursor: pointer; font-weight: 600; transition: all var(--transition-normal); text-decoration: none; display: inline-flex; align-items: center; gap: var(--spacing-xs); font-size: 1rem; }
        .btn-primary { background: var(--primary-color); color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        .table-container { background: var(--bg-card); border-radius: var(--radius-xl); box-shadow: var(--shadow-lg); border: 1px solid var(--bg-overlay); overflow-x: auto; margin-bottom: var(--spacing-xl); }
        .bills-table { width: 100%; border-collapse: collapse; background: transparent; }
        .bills-table th, .bills-table td { padding: var(--spacing-md); text-align: left; }
        .bills-table th { background: var(--primary-color); color: #fff; font-weight: bold; }
        .bills-table tr:nth-child(even) { background: var(--bg-white); }
        .bills-table tr:hover { background: var(--bg-secondary); }
        .bills-table tr { border-bottom: 1px solid var(--bg-overlay); }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-paid { background: #d4edda; color: #155724; }
        .status-overdue { background: #f8d7da; color: #721c24; }
        .status-completed { background: #cce5ff; color: #004085; }
        .amount { font-weight: bold; color: var(--primary-color); }
        .bill-number { font-weight: bold; color: var(--text-dark); }
        .empty-state { text-align: center; padding: var(--spacing-xl); color: var(--text-muted); }
        .empty-state h3 { margin-bottom: 1rem; color: var(--text-dark); }
        .pagination { display: flex; justify-content: center; gap: 0.5rem; margin-top: var(--spacing-xl); }
        .page-btn { padding: 0.5rem 1rem; border: 1px solid var(--bg-overlay); background: var(--bg-card); color: var(--text-dark); border-radius: var(--radius-md); cursor: pointer; }
        .page-btn.active { background: var(--primary-color); color: white; border-color: var(--primary-color); }
        .page-btn:hover { background: var(--bg-secondary); }
        @media (max-width: 768px) { .nav-links { flex-direction: column; gap: 0.5rem; } .bills-header, .search-filters { flex-direction: column; align-items: stretch; gap: var(--spacing-md); } .summary-cards { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-file-invoice"></i> My Bills</h1>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/customer/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/customer/profile"><i class="fas fa-user"></i> My Profile</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </div>
    <div class="container">
        <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
        <c:if test="${not empty message}"><div class="success">${message}</div></c:if>
        <div class="card">
            <div class="table-header"><h2>Billing Summary</h2></div>
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
        </div>
        <div class="card">
            <div class="table-header"><h2>Billing History</h2></div>
            <div class="bills-header">
                <h2 class="bills-title">Search & Filter</h2>
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
                                    <a href="${pageContext.request.contextPath}/bills/pdf/${bill.id}" class="btn btn-success"><i class="fas fa-download"></i> Download PDF</a>
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
            <div class="pagination" id="pagination">
                <!-- Pagination will be generated by JavaScript -->
            </div>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/4b7c1b6e8b.js" crossorigin="anonymous"></script>
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