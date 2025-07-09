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
        .profile-container { max-width: 1000px; margin: 0 auto; }
        .profile-header { text-align: center; margin-bottom: var(--spacing-xl); }
        .profile-pic { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 4px solid var(--primary-color); margin-bottom: 1rem; }
        .profile-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(340px, 1fr)); gap: var(--spacing-xl); margin-bottom: var(--spacing-xl); }
        .card { background: var(--bg-card); border-radius: var(--radius-xl); box-shadow: var(--shadow-lg); border: 1px solid var(--bg-overlay); margin-bottom: var(--spacing-xl); padding: var(--spacing-xl); }
        .table-header { background: rgba(44, 85, 48, 0.05); padding: var(--spacing-lg); border-bottom: 1px solid var(--bg-overlay); border-radius: var(--radius-xl) var(--radius-xl) 0 0; }
        .table-header h2, .table-header h3 { margin: 0; color: var(--text-dark); font-weight: 700; }
        .form-group { margin-bottom: var(--spacing-md); }
        .form-group label { display: block; margin-bottom: var(--spacing-xs); font-weight: 600; color: var(--text-dark); }
        .form-control { width: 100%; padding: var(--spacing-sm); border: 2px solid #e5e7eb; border-radius: var(--radius-md); font-size: 1rem; background: rgba(255,255,255,0.9); color: var(--text-dark); transition: all var(--transition-normal); }
        .form-control:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(44, 85, 48, 0.1); background: var(--bg-white); }
        .btn-group { display: flex; gap: var(--spacing-md); margin-top: var(--spacing-md); }
        .btn { padding: var(--spacing-sm) var(--spacing-lg); border: none; border-radius: var(--radius-md); cursor: pointer; font-weight: 600; transition: all var(--transition-normal); display: inline-flex; align-items: center; gap: var(--spacing-xs); font-size: 1rem; }
        .btn-primary { background: var(--primary-color); color: white; }
        .btn-secondary { background: var(--secondary-color); color: white; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        .btn:disabled { opacity: 0.6; cursor: not-allowed; transform: none; }
        .info-item { display: flex; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--bg-overlay); }
        .info-item:last-child { border-bottom: none; }
        .info-label { font-weight: bold; color: var(--text-dark); }
        .info-value { color: var(--text-muted); }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }
        @media (max-width: 768px) { .nav-links { flex-direction: column; gap: 0.5rem; } .profile-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-user"></i> My Profile</h1>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/customer/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/customer/bills"><i class="fas fa-file-invoice"></i> My Bills</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="profile-container">
            <div class="profile-header">
                <img src="https://ui-avatars.com/api/?name=${customer.name}&background=667eea&color=fff&size=120" class="profile-pic" alt="Profile Picture" />
                <h2>${customer.name}</h2>
                <span class="status-badge status-active">Active Customer</span>
            </div>
            <div class="profile-grid">
                <div class="card">
                    <div class="table-header"><h3>Personal Information</h3></div>
                    <div class="info-item">
                        <span class="info-label">Full Name:</span>
                        <span class="info-value">${customer.name}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Email:</span>
                        <span class="info-value">${customer.email}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Account Number:</span>
                        <span class="info-value">${customer.accountNumber}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Phone:</span>
                        <span class="info-value">${customer.phone != null && !customer.phone.isEmpty() ? customer.phone : 'Not provided'}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Address:</span>
                        <span class="info-value">${customer.address != null && !customer.address.isEmpty() ? customer.address : 'Not provided'}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Account Created:</span>
                        <span class="info-value">${customer.createdAt}</span>
                    </div>
                </div>
                <div class="card">
                    <div class="table-header"><h3>Account Settings</h3></div>
                    <form id="profileForm">
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" class="form-control" value="${user.firstName}" />
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" class="form-control" value="${user.lastName}" />
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" class="form-control" value="${customer.email}" />
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter phone number" />
                        </div>
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Profile</button>
                            <button type="button" class="btn btn-secondary" onclick="resetForm()"><i class="fas fa-undo"></i> Reset</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="profile-grid">
                <div class="card">
                    <div class="table-header"><h3>Security Settings</h3></div>
                    <form id="passwordForm">
                        <div class="form-group">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" />
                        </div>
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-key"></i> Change Password</button>
                            <button type="button" class="btn btn-secondary" onclick="resetPasswordForm()"><i class="fas fa-undo"></i> Clear</button>
                        </div>
                    </form>
                </div>
                <div class="card">
                    <div class="table-header"><h3>Preferences</h3></div>
                    <div class="form-group">
                        <label>
                            <input type="checkbox" id="emailNotifications" checked />
                            Receive email notifications
                        </label>
                    </div>
                    <div class="form-group">
                        <label>
                            <input type="checkbox" id="smsNotifications" />
                            Receive SMS notifications
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="language">Language</label>
                        <select id="language" class="form-control">
                            <option value="en">English</option>
                            <option value="es">Spanish</option>
                            <option value="fr">French</option>
                        </select>
                    </div>
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary" onclick="savePreferences()"><i class="fas fa-save"></i> Save Preferences</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/4b7c1b6e8b.js" crossorigin="anonymous"></script>
    <script>
        function resetForm() {
            document.getElementById('profileForm').reset();
        }
        function resetPasswordForm() {
            document.getElementById('passwordForm').reset();
        }
        function savePreferences() {
            alert('Preferences saved successfully!');
        }
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Profile updated successfully!');
        });
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            if (newPassword !== confirmPassword) {
                alert('Passwords do not match!');
                return;
            }
            alert('Password changed successfully!');
            resetPasswordForm();
        });
    </script>
</body>
</html> 