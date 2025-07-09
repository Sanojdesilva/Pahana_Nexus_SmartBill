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
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; color: #333; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { font-size: 1.5rem; }
        .nav-links { display: flex; gap: 1rem; }
        .nav-links a { color: white; text-decoration: none; padding: 0.5rem 1rem; border-radius: 5px; transition: background 0.3s; }
        .nav-links a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1200px; margin: 0 auto; padding: 2rem; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
        .page-header h2 { color: #333; font-size: 1.8rem; }
        .btn { background: #667eea; color: white; padding: 0.75rem 1.5rem; border: none; border-radius: 5px; text-decoration: none; display: inline-block; cursor: pointer; transition: background 0.3s; font-size: 1rem; }
        .btn:hover { background: #5a6fd8; }
        .btn-secondary { background: #6c757d; }
        .btn-secondary:hover { background: #5a6268; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .btn-warning { background: #ffc107; color: #333; }
        .btn-warning:hover { background: #e0a800; }
        .btn-float { position: fixed; bottom: 2rem; right: 2rem; z-index: 100; box-shadow: 0 2px 10px rgba(0,0,0,0.2); }
        .search-bar { background: white; padding: 1.5rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 2rem; }
        .search-form { display: flex; gap: 1rem; align-items: center; }
        .form-group { flex: 1; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 5px; font-size: 1rem; }
        .users-table { background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); overflow-x: auto; width: 100%; }
        .table-header { background: #f8f9fa; padding: 1rem; border-bottom: 1px solid #dee2e6; }
        .table-header h2 { margin: 0; color: #333; }
        table { width: 100%; min-width: 1100px; border-collapse: collapse; }
        th, td { padding: 1rem; text-align: left; border-bottom: 1px solid #dee2e6; }
        th { background: #f8f9fa; font-weight: bold; }
        tr:hover { background: #f8f9fa; }
        .status-badge { padding: 0.25rem 0.5rem; border-radius: 3px; font-size: 0.8rem; font-weight: bold; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }
        .actions { display: flex; gap: 0.5rem; }
        .error { background: #fee; color: #c33; padding: 1rem; border-radius: 5px; margin-bottom: 1rem; border: 1px solid #fcc; }
        .success { background: #efe; color: #3c3; padding: 1rem; border-radius: 5px; margin-bottom: 1rem; border: 1px solid #cfc; }
        .form-container { background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); padding: 2rem; margin-bottom: 2rem; }
        .form-header { background: #f8f9fa; padding: 1rem; border-radius: 5px; margin-bottom: 2rem; border-left: 4px solid #667eea; }
        .form-header h3 { margin: 0; color: #333; font-size: 1.2rem; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem; }
        .form-group.full-width { grid-column: 1 / -1; }
        .form-actions { display: flex; gap: 1rem; justify-content: flex-end; padding-top: 1rem; border-top: 1px solid #eee; margin-top: 2rem; }
        @media (max-width: 900px) { .users-table { overflow-x: auto; } table { min-width: 900px; } }
        @media (max-width: 768px) { .form-row { grid-template-columns: 1fr; } .form-actions { flex-direction: column; } .nav-links { flex-direction: column; gap: 0.5rem; } .search-form { flex-direction: column; align-items: stretch; } }
    </style>
</head>
<body>
    <div class="header">
        <h1>User Management</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/customers/">Customers</a>
            <a href="${pageContext.request.contextPath}/bills/">Bills</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    <div class="container">
        <c:if test="${not empty message}"><div class="success">${message}</div></c:if>
        <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
        <div class="page-header">
            <h2>User Management</h2>
            <a href="#" class="btn" id="showCreateUser">Add New User</a>
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
                    <button type="submit" class="btn">Search</button>
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
                                        <button type="submit" class="btn btn-warning">Edit</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="id" value="${user.id}" />
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this user?');">Delete</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty users}">
                <div style="padding: 2rem; text-align: center; color: #666;">
                    <p>No users found. <a href="#" id="showCreateUserInline">Add your first user</a></p>
                </div>
            </c:if>
        </div>
    </div>
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