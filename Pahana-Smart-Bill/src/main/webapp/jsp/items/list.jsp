<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Items - Pahana Smart Bill</title>
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
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
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
        }
        
        .btn:hover {
            background: #5a6fd8;
        }
        
        .btn-danger {
            background: #dc3545;
        }
        
        .btn-danger:hover {
            background: #c82333;
        }
        
        .btn-warning {
            background: #ffc107;
            color: #333;
        }
        
        .btn-warning:hover {
            background: #e0a800;
        }
        
        .search-bar {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .search-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        
        .form-group {
            flex: 1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }
        
        .items-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .table-header {
            background: #f8f9fa;
            padding: 1rem;
            border-bottom: 1px solid #dee2e6;
        }
        
        .table-header h2 {
            margin: 0;
            color: #333;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        
        th {
            background: #f8f9fa;
            font-weight: bold;
        }
        
        tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 0.25rem 0.5rem;
            border-radius: 3px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }
        
        .actions {
            display: flex;
            gap: 0.5rem;
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
        <h1>Manage Items</h1>
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
        
        <c:if test="${not empty message}">
            <div class="success">${message}</div>
        </c:if>
        
        <div class="page-header">
            <h2>Inventory Items</h2>
            <a href="${pageContext.request.contextPath}/items/new" class="btn">Add New Item</a>
        </div>
        
        <div class="search-bar">
            <form class="search-form" method="GET" action="${pageContext.request.contextPath}/items/">
                <div class="form-group">
                    <label for="search">Search Items</label>
                    <input type="text" id="search" name="search" placeholder="Search by name, code, or category..." value="${param.search}">
                </div>
                <div class="form-group">
                    <label for="category">Category</label>
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
                    <label for="status">Status</label>
                    <select id="status" name="status">
                        <option value="">All Status</option>
                        <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <button type="submit" class="btn">Search</button>
                </div>
            </form>
        </div>
        
        <div class="items-table">
            <div class="table-header">
                <h2>Items List (${items.size()} items)</h2>
            </div>
            
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
                                    <a href="${pageContext.request.contextPath}/items/edit/${item.id}" class="btn btn-warning">Edit</a>
                                    <form method="POST" action="${pageContext.request.contextPath}/items/" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${item.id}">
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this item?')">Delete</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <c:if test="${empty items}">
                <div style="padding: 2rem; text-align: center; color: #666;">
                    <p>No items found. <a href="${pageContext.request.contextPath}/items/new">Add your first item</a></p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html> 