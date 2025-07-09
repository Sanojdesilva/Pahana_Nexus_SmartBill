<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Items - Pahana Smart Bill</title>
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
        
        .search-bar {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            padding: var(--spacing-xl);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            margin-bottom: var(--spacing-xl);
            position: relative;
            overflow: hidden;
        }
        
        .search-bar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
        }
        
        .search-form {
            display: flex;
            gap: var(--spacing-lg);
            align-items: center;
        }
        
        .form-group {
            flex: 1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: var(--spacing-xs);
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: var(--spacing-sm);
            border: 2px solid #e5e7eb;
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: all var(--transition-normal);
            background: rgba(255, 255, 255, 0.9);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(44, 85, 48, 0.1);
            background: var(--bg-white);
        }
        
        .items-table {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            width: 100%;
            position: relative;
            overflow: hidden;
        }
        
        .items-table::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
        }
        
        .table-header {
            background: rgba(44, 85, 48, 0.05);
            padding: var(--spacing-lg);
            border-bottom: 1px solid var(--bg-overlay);
        }
        
        .table-header h2 {
            margin: 0;
            color: var(--text-dark);
            font-weight: 700;
        }
        
        .table-container {
            overflow-x: auto;
            overflow-y: visible;
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
            position: relative;
        }
        
        .table-container::-webkit-scrollbar {
            height: 8px;
        }
        
        .table-container::-webkit-scrollbar-track {
            background: rgba(44, 85, 48, 0.1);
            border-radius: 4px;
        }
        
        .table-container::-webkit-scrollbar-thumb {
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
            border-radius: 4px;
        }
        
        .table-container::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(90deg, var(--primary-dark), var(--primary-color));
        }
        
        table {
            width: 100%;
            min-width: 1000px;
            border-collapse: collapse;
            white-space: nowrap;
        }
        
        th, td {
            padding: var(--spacing-md);
            text-align: left;
            border-bottom: 1px solid var(--bg-overlay);
            white-space: nowrap;
        }
        
        th {
            background: rgba(44, 85, 48, 0.05);
            font-weight: 600;
            color: var(--text-dark);
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
        tr:hover {
            background: rgba(44, 85, 48, 0.02);
        }
        
        .status-badge {
            padding: var(--spacing-xs) var(--spacing-sm);
            border-radius: var(--radius-sm);
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-active {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .actions {
            display: flex;
            gap: var(--spacing-xs);
            flex-wrap: nowrap;
            min-width: 200px;
        }
        
        .actions .btn {
            padding: var(--spacing-xs) var(--spacing-sm);
            font-size: 0.8rem;
            white-space: nowrap;
            min-width: auto;
            flex-shrink: 0;
        }
        
        .actions .btn i {
            margin-right: var(--spacing-xs);
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
        <div class="header-content">
            <h1><i class="fas fa-boxes"></i> Manage Items</h1>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/items/"><i class="fas fa-boxes"></i> Items</a>
                <a href="${pageContext.request.contextPath}/customers/"><i class="fas fa-users"></i> Customers</a>
                <a href="${pageContext.request.contextPath}/bills/"><i class="fas fa-file-invoice"></i> Bills</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
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
        
        <div class="page-header">
            <h2><i class="fas fa-boxes"></i> Inventory Items</h2>
            <a href="${pageContext.request.contextPath}/items/new" class="btn"><i class="fas fa-plus"></i> Add New Item</a>
        </div>
        
        <div class="search-bar">
            <form class="search-form" method="GET" action="${pageContext.request.contextPath}/items/">
                <div class="form-group">
                    <label for="search"><i class="fas fa-search"></i> Search Items</label>
                    <input type="text" id="search" name="search" placeholder="Search by name, code, or category..." value="${param.search}">
                </div>
                <div class="form-group">
                    <label for="category"><i class="fas fa-tags"></i> Category</label>
                    <select id="category" name="category">
                        <option value="" ${param.category == '' ? 'selected' : ''}>All Categories</option>
                        <option value="FICTION" ${param.category == 'FICTION' ? 'selected' : ''}>Fiction</option>
                        <option value="NONFICTION" ${param.category == 'NONFICTION' ? 'selected' : ''}>Non-Fiction</option>
                        <option value="CHILDREN" ${param.category == 'CHILDREN' ? 'selected' : ''}>Children’s Books</option>
                        <option value="EDUCATIONAL" ${param.category == 'EDUCATIONAL' ? 'selected' : ''}>Educational</option>
                        <option value="STATIONERY" ${param.category == 'STATIONERY' ? 'selected' : ''}>Stationery</option>
                        <option value="MAGAZINES" ${param.category == 'MAGAZINES' ? 'selected' : ''}>Magazines</option>
                        <option value="COMICS" ${param.category == 'COMICS' ? 'selected' : ''}>Comics & Graphic Novels</option>
                        <option value="REFERENCE" ${param.category == 'REFERENCE' ? 'selected' : ''}>Reference</option>
                        <option value="ART" ${param.category == 'ART' ? 'selected' : ''}>Art & Photography</option>
                        <option value="SCIENCE" ${param.category == 'SCIENCE' ? 'selected' : ''}>Science & Technology</option>
                        <option value="RELIGION" ${param.category == 'RELIGION' ? 'selected' : ''}>Religion & Spirituality</option>
                        <option value="BIOGRAPHY" ${param.category == 'BIOGRAPHY' ? 'selected' : ''}>Biographies</option>
                        <option value="HISTORY" ${param.category == 'HISTORY' ? 'selected' : ''}>History</option>
                        <option value="MYSTERY" ${param.category == 'MYSTERY' ? 'selected' : ''}>Mystery & Thriller</option>
                        <option value="ROMANCE" ${param.category == 'ROMANCE' ? 'selected' : ''}>Romance</option>
                        <option value="FANTASY" ${param.category == 'FANTASY' ? 'selected' : ''}>Fantasy & Sci-Fi</option>
                        <option value="SELFHELP" ${param.category == 'SELFHELP' ? 'selected' : ''}>Self-Help</option>
                        <option value="BUSINESS" ${param.category == 'BUSINESS' ? 'selected' : ''}>Business & Economics</option>
                        <option value="OTHER" ${param.category == 'OTHER' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="status"><i class="fas fa-toggle-on"></i> Status</label>
                    <select id="status" name="status">
                        <option value="">All Status</option>
                        <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <button type="submit" class="btn"><i class="fas fa-search"></i> Search</button>
                </div>
            </form>
        </div>
        
        <div class="items-table">
            <div class="table-header">
                <h2>Items List (${items.size()} items)</h2>
            </div>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td>${item.code}</td>
                                <td>${item.name}</td>
                                <td>${item.category}</td>
                                <td>$${item.price}</td>
                                <td>${item.stockQuantity}</td>
                                <td>
                                    <span class="status-badge ${item.active ? 'status-active' : 'status-inactive'}">
                                        ${item.active ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <div class="actions">
                                        <a href="${pageContext.request.contextPath}/items/edit/${item.id}" class="btn btn-warning" title="Edit"><i class="fas fa-edit"></i></a>
                                        <form method="POST" action="${pageContext.request.contextPath}/items/" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${item.id}">
                                            <button type="submit" class="btn btn-danger" title="Delete" onclick="return confirm('Are you sure you want to delete this item?')"><i class="fas fa-trash-alt"></i></button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:if test="${empty items}">
                <div style="padding: 2rem; text-align: center; color: #666;">
                    <p>No items found. <a href="${pageContext.request.contextPath}/items/new">Add your first item</a></p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html> 