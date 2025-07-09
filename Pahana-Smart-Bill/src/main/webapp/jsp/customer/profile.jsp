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
        .profile-container { max-width: 800px; margin: 0 auto; }
        .profile-header { text-align: center; margin-bottom: 2rem; }
        .profile-pic { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 4px solid var(--primary-color); margin-bottom: 1rem; }
        .profile-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem; }
        .profile-section { background: var(--card-bg); padding: 1.5rem; border-radius: 10px; box-shadow: var(--shadow); }
        .profile-section h3 { color: var(--primary-color); margin-bottom: 1rem; border-bottom: 2px solid var(--border-color); padding-bottom: 0.5rem; }
        .form-group { margin-bottom: 1rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: bold; color: var(--text-color); }
        .form-control { width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 5px; background: var(--input-bg); color: var(--text-color); }
        .form-control:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2); }
        .btn-group { display: flex; gap: 1rem; margin-top: 1rem; }
        .btn { padding: 0.75rem 1.5rem; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; transition: all 0.3s; }
        .btn-primary { background: var(--primary-color); color: white; }
        .btn-secondary { background: var(--secondary-color); color: white; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        .btn:disabled { opacity: 0.6; cursor: not-allowed; transform: none; }
        .info-item { display: flex; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--border-color); }
        .info-item:last-child { border-bottom: none; }
        .info-label { font-weight: bold; color: var(--text-color); }
        .info-value { color: var(--text-muted); }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <div class="header">
        <h1>My Profile</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/bills">My Bills</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
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
                <div class="profile-section">
                    <h3>Personal Information</h3>
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
                
                <div class="profile-section">
                    <h3>Account Settings</h3>
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
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                            <button type="button" class="btn btn-secondary" onclick="resetForm()">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="profile-section">
                <h3>Security Settings</h3>
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
                        <button type="submit" class="btn btn-primary">Change Password</button>
                        <button type="button" class="btn btn-secondary" onclick="resetPasswordForm()">Clear</button>
                    </div>
                </form>
            </div>
            
            <div class="profile-section">
                <h3>Preferences</h3>
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
                    <button type="button" class="btn btn-primary" onclick="savePreferences()">Save Preferences</button>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function resetForm() {
            document.getElementById('profileForm').reset();
        }
        
        function resetPasswordForm() {
            document.getElementById('passwordForm').reset();
        }
        
        function savePreferences() {
            // Placeholder for preferences saving
            alert('Preferences saved successfully!');
        }
        
        // Form submission handlers
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            e.preventDefault();
            // Placeholder for profile update
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
            
            // Placeholder for password change
            alert('Password changed successfully!');
            resetPasswordForm();
        });
    </script>
</body>
</html> 