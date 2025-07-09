<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahana.model.User" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
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
        .users-table {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            width: 100%;
            position: relative;
            overflow: hidden;
        }
        .users-table::before {
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
        table {
            width: 100%;
            min-width: 1100px;
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
        tr:hover { background: #f8f9fa; }
        .status-badge { padding: 0.25rem 0.5rem; border-radius: 3px; font-size: 0.8rem; font-weight: bold; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }
        .actions { display: flex; gap: var(--spacing-xs); flex-wrap: nowrap; min-width: 200px; }
        .actions .btn { padding: var(--spacing-xs) var(--spacing-sm); font-size: 0.8rem; white-space: nowrap; min-width: auto; flex-shrink: 0; }
        .actions .btn i { margin-right: var(--spacing-xs); }
        .error { background: #fee; color: #c33; padding: 1rem; border-radius: 5px; margin-bottom: 1rem; border: 1px solid #fcc; }
        .success { background: #efe; color: #3c3; padding: 1rem; border-radius: 5px; margin-bottom: 1rem; border: 1px solid #cfc; }
        @media (max-width: 768px) {
            .nav-links { flex-direction: column; gap: 0.5rem; }
            .search-form { flex-direction: column; align-items: stretch; }
            .actions { flex-direction: column; min-width: 150px; }
            .actions .btn { width: 100%; justify-content: center; }
        }
        @media (max-width: 1200px) {
            .table-container { overflow-x: auto; }
            table { min-width: 900px; }
            .actions { min-width: 150px; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-users-cog"></i> User Management</h1>
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
        <c:if test="${not empty message}"><div class="success">${message}</div></c:if>
        <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
        <div class="page-header">
            <h2>User Management</h2>
            <a href="#" class="btn" id="showCreateUser"><i class="fas fa-user-plus"></i> Add New User</a>
        </div>
        <div class="search-bar">
            <form class="search-form" method="get" action="${pageContext.request.contextPath}/admin/users">
                <div class="form-group">
                    <label for="search">Search Users</label>
                    <input type="text" id="search" name="search" placeholder="Username or Email" value="${param.search}">
                </div>
                <div class="form-group">
                    <label for="roleFilter">Role</label>
                    <select id="roleFilter" name="roleFilter">
                        <option value="">All Roles</option>
                        <option value="ADMIN" ${param.roleFilter == 'ADMIN' ? 'selected' : ''}>Admin</option>
                        <option value="EMPLOYEE" ${param.roleFilter == 'EMPLOYEE' ? 'selected' : ''}>Employee</option>
                        <option value="CUSTOMER" ${param.roleFilter == 'CUSTOMER' ? 'selected' : ''}>Customer</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <button type="submit" class="btn"><i class="fas fa-search"></i> Search</button>
                </div>
            </form>
        </div>
        <c:if test="${not empty editUser}">
            <div class="form-container">
                <div class="form-header"><h3>Edit User</h3></div>
                <form method="post" action="${pageContext.request.contextPath}/admin/users">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" value="${editUser.id}" />
                    <div class="form-row">
                        <div class="form-group">
                            <label>ID</label>
                            <input type="text" value="${editUser.id}" class="readonly" readonly />
                        </div>
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" value="${editUser.username}" class="readonly" readonly />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="${editUser.email}" required />
                        </div>
                        <div class="form-group">
                            <label for="role">Role</label>
                            <select id="role" name="role" required>
                                <option value="ADMIN" ${editUser.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                <option value="EMPLOYEE" ${editUser.role == 'EMPLOYEE' ? 'selected' : ''}>Employee</option>
                                <option value="CUSTOMER" ${editUser.role == 'CUSTOMER' ? 'selected' : ''}>Customer</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="isActive">Status</label>
                            <select id="isActive" name="isActive">
                                <option value="true" ${editUser.active ? 'selected' : ''}>Active</option>
                                <option value="false" ${!editUser.active ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" value="${editUser.firstName}" required />
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" value="${editUser.lastName}" required />
                        </div>
                    </div>
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn">Update User</button>
                    </div>
                </form>
            </div>
        </c:if>
        <c:if test="${empty editUser}">
            <div class="form-container" id="createUserForm" style="display:none;">
                <div class="form-header"><h3>Add New User</h3></div>
                <form method="post" action="${pageContext.request.contextPath}/admin/users">
                    <input type="hidden" name="action" value="create" />
                    <div class="form-row">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" required />
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" required minlength="6" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required />
                        </div>
                        <div class="form-group">
                            <label for="role">Role</label>
                            <select id="role" name="role" required>
                                <option value="">Select Role</option>
                                <option value="ADMIN">Admin</option>
                                <option value="EMPLOYEE">Employee</option>
                                <option value="CUSTOMER">Customer</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="isActive">Status</label>
                            <select id="isActive" name="isActive">
                                <option value="true">Active</option>
                                <option value="false">Inactive</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" required />
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" required />
                        </div>
                    </div>
                    <div class="form-actions">
                        <a href="#" class="btn btn-secondary" id="cancelCreateUser">Cancel</a>
                        <button type="submit" class="btn">Add User</button>
                    </div>
                </form>
            </div>
        </c:if>
        <div class="users-table">
            <div class="table-header"><h2>All Users (${users.size()} users)</h2></div>
            <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td><span class="status-badge ${user.active ? 'status-active' : 'status-inactive'}">${user.active ? 'Active' : 'Inactive'}</span></td>
                            <td>${user.firstName}</td>
                            <td>${user.lastName}</td>
                            <td>
                                <div class="actions">
                                    <form method="get" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                        <input type="hidden" name="id" value="${user.id}" />
                                        <input type="hidden" name="action" value="edit" />
                                        <button type="submit" class="btn btn-warning"><i class="fas fa-edit"></i> Edit</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="id" value="${user.id}" />
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this user?');"><i class="fas fa-trash"></i> Delete</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
            <c:if test="${empty users}">
                <div style="padding: 2rem; text-align: center; color: #666;">
                    <p>No users found. <a href="#" id="showCreateUserInline">Add your first user</a></p>
                </div>
            </c:if>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/4b7c1b6e8b.js" crossorigin="anonymous"></script>
    <script>
        // Show/hide create user form
        document.addEventListener('DOMContentLoaded', function() {
            var showBtn = document.getElementById('showCreateUser');
            var showInline = document.getElementById('showCreateUserInline');
            var form = document.getElementById('createUserForm');
            var cancelBtn = document.getElementById('cancelCreateUser');
            if (showBtn && form) {
                showBtn.addEventListener('click', function(e) { e.preventDefault(); form.style.display = 'block'; window.scrollTo({top: form.offsetTop-40, behavior: 'smooth'}); });
            }
            if (showInline && form) {
                showInline.addEventListener('click', function(e) { e.preventDefault(); form.style.display = 'block'; window.scrollTo({top: form.offsetTop-40, behavior: 'smooth'}); });
            }
            if (cancelBtn && form) {
                cancelBtn.addEventListener('click', function(e) { e.preventDefault(); form.style.display = 'none'; });
            }
        });
    </script>
</body>
</html> 