<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
    <style>
        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
        }
        .profile-pic {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--primary-color);
            margin-bottom: 1rem;
        }
        .toggle-switch { position: relative; display: inline-block; width: 60px; height: 34px; }
        .toggle-switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 34px; }
        .slider:before { position: absolute; content: ""; height: 26px; width: 26px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%; }
        input:checked + .slider { background-color: var(--primary-color); }
        input:checked + .slider:before { transform: translateX(26px); }
        .toggle-group { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1rem; }
        .toggle-label { font-weight: 600; color: var(--text-color); }
        .color-picker { width: 50px; height: 50px; border: none; border-radius: 5px; cursor: pointer; }
        .show-hide { cursor: pointer; color: var(--primary-color); margin-left: 0.5rem; }
    </style>
</head>
<body>
    <div class="header">
        <h1>My Profile</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/employee/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    <div class="container">
        <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>
        <form method="post" action="${pageContext.request.contextPath}/employee/profile" enctype="multipart/form-data">
            <div class="profile-grid">
                <!-- Profile Info -->
                <div class="card">
                    <h3>Profile Information</h3>
                    <div style="text-align:center;">
                        <img src="https://ui-avatars.com/api/?name=${employee.firstName}+${employee.lastName}&background=667eea&color=fff" class="profile-pic" alt="Profile Picture" />
                        <div style="margin-bottom:1rem;">
                            <input type="file" name="profilePic" accept="image/*" style="display:none;" id="profilePicInput" />
                            <button type="button" class="btn btn-warning" onclick="document.getElementById('profilePicInput').click()">Change Picture</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" id="name" name="name" class="form-control" value="${employee.firstName} ${employee.lastName}" required />
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" class="form-control" value="${employee.email}" required />
                    </div>
                </div>
                <!-- Security -->
                <div class="card">
                    <h3>Security</h3>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div style="display:flex;align-items:center;">
                            <input type="password" id="password" name="password" class="form-control" placeholder="Leave blank to keep current password" style="flex:1;" />
                            <span class="show-hide" onclick="togglePassword()">Show</span>
                        </div>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">Two-Factor Authentication</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="twoFactorAuth" disabled>
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                <!-- Preferences -->
                <div class="card">
                    <h3>Preferences</h3>
                    <div class="toggle-group">
                        <span class="toggle-label">Dark Mode</span>
                        <label class="toggle-switch">
                            <input type="checkbox" id="darkMode" name="darkMode">
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="primaryColor">Primary Color</label>
                        <input type="color" id="primaryColor" name="primaryColor" class="color-picker" value="#667eea" />
                    </div>
                    <div class="form-group">
                        <label for="theme">Theme</label>
                        <select id="theme" name="theme" class="form-control">
                            <option value="default">Default</option>
                            <option value="modern">Modern</option>
                            <option value="classic">Classic</option>
                            <option value="minimal">Minimal</option>
                        </select>
                    </div>
                </div>
                <!-- Notifications -->
                <div class="card">
                    <h3>Notifications</h3>
                    <div class="toggle-group">
                        <span class="toggle-label">Email Notifications</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="emailNotifications" checked disabled>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">SMS Notifications</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="smsNotifications" disabled>
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
            </div>
            <div style="text-align: center; margin-top: 2rem;">
                <button type="submit" class="btn btn-success">Save Changes</button>
            </div>
        </form>
    </div>
    <script>
        // Show/hide password
        function togglePassword() {
            const pwd = document.getElementById('password');
            const toggle = document.querySelector('.show-hide');
            if (pwd.type === 'password') {
                pwd.type = 'text';
                toggle.textContent = 'Hide';
            } else {
                pwd.type = 'password';
                toggle.textContent = 'Show';
            }
        }
        // Theme toggles
        const darkModeToggle = document.getElementById('darkMode');
        darkModeToggle.addEventListener('change', function() {
            if (this.checked) {
                window.themeManager.setTheme('dark');
                localStorage.setItem('theme', 'dark');
            } else {
                window.themeManager.setTheme('light');
                localStorage.setItem('theme', 'light');
            }
        });
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme === 'dark') {
            darkModeToggle.checked = true;
        }
        // Color picker
        const primaryColorPicker = document.getElementById('primaryColor');
        primaryColorPicker.addEventListener('change', function() {
            window.themeManager.setPrimaryColor(this.value);
        });
    </script>
</body>
</html> 