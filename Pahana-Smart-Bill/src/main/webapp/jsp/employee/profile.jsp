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
        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: var(--spacing-xl);
        }
        .profile-pic {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--primary-color);
            margin-bottom: 1rem;
        }
        .card {
            background: var(--bg-card);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--bg-overlay);
            margin-bottom: var(--spacing-xl);
            padding: var(--spacing-xl);
        }
        .table-header {
            background: rgba(44, 85, 48, 0.05);
            padding: var(--spacing-lg);
            border-bottom: 1px solid var(--bg-overlay);
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
        }
        .table-header h2, .table-header h3 {
            margin: 0;
            color: var(--text-dark);
            font-weight: 700;
        }
        .form-group {
            margin-bottom: var(--spacing-md);
        }
        .form-group label {
            display: block;
            margin-bottom: var(--spacing-xs);
            font-weight: 600;
            color: var(--text-dark);
        }
        .form-control {
            width: 100%;
            padding: var(--spacing-sm);
            border: 2px solid #e5e7eb;
            border-radius: var(--radius-md);
            font-size: 1rem;
            background: rgba(255,255,255,0.9);
            color: var(--text-dark);
            transition: all var(--transition-normal);
        }
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(44, 85, 48, 0.1);
            background: var(--bg-white);
        }
        .toggle-switch { position: relative; display: inline-block; width: 60px; height: 34px; }
        .toggle-switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 34px; }
        .slider:before { position: absolute; content: ""; height: 26px; width: 26px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%; }
        input:checked + .slider { background-color: var(--primary-color); }
        input:checked + .slider:before { transform: translateX(26px); }
        .toggle-group { display: flex; align-items: center; justify-content: space-between; margin-bottom: var(--spacing-md); }
        .toggle-label { font-weight: 600; color: var(--text-dark); }
        .color-picker { width: 50px; height: 50px; border: none; border-radius: 5px; cursor: pointer; }
        .show-hide { cursor: pointer; color: var(--primary-color); margin-left: 0.5rem; }
        .btn {
            padding: var(--spacing-sm) var(--spacing-lg);
            border: none;
            border-radius: var(--radius-md);
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-xs);
            font-size: 1rem;
            font-weight: 600;
            transition: all var(--transition-normal);
        }
        .btn-success { background: #28a745; color: white; }
        .btn-warning { background: #ffc107; color: black; }
        @media (max-width: 768px) {
            .nav-links { flex-direction: column; gap: 0.5rem; }
            .profile-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-user"></i> My Profile</h1>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/employee/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </div>
    <div class="container">
        <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>
        <form method="post" action="${pageContext.request.contextPath}/employee/profile" enctype="multipart/form-data">
            <div class="profile-grid">
                <!-- Profile Info -->
                <div class="card">
                    <div class="table-header"><h3>Profile Information</h3></div>
                    <div style="text-align:center;">
                        <img src="https://ui-avatars.com/api/?name=${employee.firstName}+${employee.lastName}&background=667eea&color=fff" class="profile-pic" alt="Profile Picture" />
                        <div style="margin-bottom:1rem;">
                            <input type="file" name="profilePic" accept="image/*" style="display:none;" id="profilePicInput" />
                            <button type="button" class="btn btn-warning" onclick="document.getElementById('profilePicInput').click()"><i class="fas fa-image"></i> Change Picture</button>
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
                    <div class="table-header"><h3>Security</h3></div>
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
                    <div class="table-header"><h3>Preferences</h3></div>
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
                    <div class="table-header"><h3>Notifications</h3></div>
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
                <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Save Changes</button>
            </div>
        </form>
    </div>
    <script src="https://kit.fontawesome.com/4b7c1b6e8b.js" crossorigin="anonymous"></script>
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