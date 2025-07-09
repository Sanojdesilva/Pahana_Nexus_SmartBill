<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Settings - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            --light-bg: #f8f9fa;
            --dark-bg: #343a40;
            --text-color: #333;
            --border-color: #dee2e6;
            --card-bg: #fff;
            --shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        [data-theme="dark"] {
            --primary-color: #7c8fff;
            --secondary-color: #9b6bff;
            --light-bg: #1a1a1a;
            --dark-bg: #2d2d2d;
            --text-color: #e0e0e0;
            --border-color: #444;
            --card-bg: #2d2d2d;
            --shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--light-bg);
            color: var(--text-color);
            transition: all 0.3s ease;
        }
        
        .header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
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
        
        .settings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
        }
        
        .settings-card {
            background: var(--card-bg);
            border-radius: 10px;
            box-shadow: var(--shadow);
            padding: 2rem;
            border: 1px solid var(--border-color);
        }
        
        .settings-card h3 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-size: 1.3rem;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-color);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            background: var(--card-bg);
            color: var(--text-color);
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2);
        }
        
        .btn {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.9rem;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn:hover {
            background: var(--secondary-color);
            transform: translateY(-1px);
        }
        
        .btn-success {
            background: var(--success-color);
        }
        
        .btn-warning {
            background: var(--warning-color);
            color: #333;
        }
        
        .btn-danger {
            background: var(--danger-color);
        }
        
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }
        
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }
        
        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        
        input:checked + .slider {
            background-color: var(--primary-color);
        }
        
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        
        .toggle-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        
        .toggle-label {
            font-weight: 600;
            color: var(--text-color);
        }
        
        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }
        
        .alert-success {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success-color);
            border: 1px solid var(--success-color);
        }
        
        .alert-error {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger-color);
            border: 1px solid var(--danger-color);
        }
        
        .color-picker {
            width: 50px;
            height: 50px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .theme-preview {
            width: 100%;
            height: 100px;
            border-radius: 5px;
            border: 2px solid var(--border-color);
            margin-top: 0.5rem;
        }
        
        .backup-info {
            background: rgba(23, 162, 184, 0.1);
            border: 1px solid var(--info-color);
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }
        
        .security-level {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        
        .security-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--success-color);
        }
        
        .security-indicator.medium {
            background: var(--warning-color);
        }
        
        .security-indicator.low {
            background: var(--danger-color);
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>System Settings</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/customers/">Customers</a>
            <a href="${pageContext.request.contextPath}/bills/">Bills</a>
            <a href="${pageContext.request.contextPath}/reports/">Reports</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/admin/settings">
            <div class="settings-grid">
                
                <!-- General Settings -->
                <div class="settings-card">
                    <h3>General Settings</h3>
                    <div class="form-group">
                        <label for="siteName">Site Name</label>
                        <input type="text" id="siteName" name="siteName" class="form-control" value="${settings.siteName}" required />
                    </div>
                    <div class="form-group">
                        <label for="supportEmail">Support Email</label>
                        <input type="email" id="supportEmail" name="supportEmail" class="form-control" value="${settings.supportEmail}" required />
                    </div>
                    <div class="form-group">
                        <label for="timezone">Timezone</label>
                        <select id="timezone" name="timezone" class="form-control">
                            <option value="UTC" ${settings.timezone == 'UTC' ? 'selected' : ''}>UTC</option>
                            <option value="America/New_York" ${settings.timezone == 'America/New_York' ? 'selected' : ''}>Eastern Time</option>
                            <option value="America/Chicago" ${settings.timezone == 'America/Chicago' ? 'selected' : ''}>Central Time</option>
                            <option value="America/Denver" ${settings.timezone == 'America/Denver' ? 'selected' : ''}>Mountain Time</option>
                            <option value="America/Los_Angeles" ${settings.timezone == 'America/Los_Angeles' ? 'selected' : ''}>Pacific Time</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="currency">Default Currency</label>
                        <select id="currency" name="currency" class="form-control">
                            <option value="USD" ${settings.currency == 'USD' ? 'selected' : ''}>USD ($)</option>
                            <option value="EUR" ${settings.currency == 'EUR' ? 'selected' : ''}>EUR (€)</option>
                            <option value="GBP" ${settings.currency == 'GBP' ? 'selected' : ''}>GBP (£)</option>
                            <option value="JPY" ${settings.currency == 'JPY' ? 'selected' : ''}>JPY (¥)</option>
                        </select>
                    </div>
                </div>
                
                <!-- Appearance Settings -->
                <div class="settings-card">
                    <h3>Appearance</h3>
                    <div class="toggle-group">
                        <span class="toggle-label">Dark Mode</span>
                        <label class="toggle-switch">
                            <input type="checkbox" id="darkMode" name="darkMode" ${settings.darkMode == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="primaryColor">Primary Color</label>
                        <input type="color" id="primaryColor" name="primaryColor" class="color-picker" value="${settings.primaryColor}" />
                    </div>
                    <div class="form-group">
                        <label for="theme">Theme</label>
                        <select id="theme" name="theme" class="form-control">
                            <option value="default" ${settings.theme == 'default' ? 'selected' : ''}>Default</option>
                            <option value="modern" ${settings.theme == 'modern' ? 'selected' : ''}>Modern</option>
                            <option value="classic" ${settings.theme == 'classic' ? 'selected' : ''}>Classic</option>
                            <option value="minimal" ${settings.theme == 'minimal' ? 'selected' : ''}>Minimal</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Theme Preview</label>
                        <div class="theme-preview" id="themePreview"></div>
                    </div>
                </div>
                
                <!-- Notification Settings -->
                <div class="settings-card">
                    <h3>Notifications</h3>
                    <div class="toggle-group">
                        <span class="toggle-label">Email Notifications</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="emailNotifications" ${settings.emailNotifications == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">SMS Notifications</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="smsNotifications" ${settings.smsNotifications == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">Push Notifications</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="pushNotifications" ${settings.pushNotifications == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="notificationEmail">Notification Email</label>
                        <input type="email" id="notificationEmail" name="notificationEmail" class="form-control" value="${settings.notificationEmail}" />
                    </div>
                </div>
                
                <!-- Security Settings -->
                <div class="settings-card">
                    <h3>Security</h3>
                    <div class="security-level">
                        <div class="security-indicator ${settings.securityLevel}"></div>
                        <span>Security Level: ${settings.securityLevel}</span>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">Two-Factor Authentication</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="twoFactorAuth" ${settings.twoFactorAuth == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">Session Timeout (30 min)</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="sessionTimeout" ${settings.sessionTimeout == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">Password Policy</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="passwordPolicy" ${settings.passwordPolicy == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="maxLoginAttempts">Max Login Attempts</label>
                        <select id="maxLoginAttempts" name="maxLoginAttempts" class="form-control">
                            <option value="3" ${settings.maxLoginAttempts == '3' ? 'selected' : ''}>3</option>
                            <option value="5" ${settings.maxLoginAttempts == '5' ? 'selected' : ''}>5</option>
                            <option value="10" ${settings.maxLoginAttempts == '10' ? 'selected' : ''}>10</option>
                        </select>
                    </div>
                </div>
                
                <!-- Billing Settings -->
                <div class="settings-card">
                    <h3>Billing & Payment</h3>
                    <div class="form-group">
                        <label for="taxRate">Default Tax Rate (%)</label>
                        <input type="number" id="taxRate" name="taxRate" class="form-control" value="${settings.taxRate}" min="0" max="100" step="0.01" />
                    </div>
                    <div class="form-group">
                        <label for="paymentTerms">Payment Terms (days)</label>
                        <input type="number" id="paymentTerms" name="paymentTerms" class="form-control" value="${settings.paymentTerms}" min="0" max="365" />
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">Auto-generate Bills</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="autoGenerateBills" ${settings.autoGenerateBills == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">Late Payment Fees</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="latePaymentFees" ${settings.latePaymentFees == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="lateFeeRate">Late Fee Rate (%)</label>
                        <input type="number" id="lateFeeRate" name="lateFeeRate" class="form-control" value="${settings.lateFeeRate}" min="0" max="50" step="0.01" />
                    </div>
                </div>
                
                <!-- System Settings -->
                <div class="settings-card">
                    <h3>System</h3>
                    <div class="form-group">
                        <label for="backupFrequency">Backup Frequency</label>
                        <select id="backupFrequency" name="backupFrequency" class="form-control">
                            <option value="daily" ${settings.backupFrequency == 'daily' ? 'selected' : ''}>Daily</option>
                            <option value="weekly" ${settings.backupFrequency == 'weekly' ? 'selected' : ''}>Weekly</option>
                            <option value="monthly" ${settings.backupFrequency == 'monthly' ? 'selected' : ''}>Monthly</option>
                        </select>
                    </div>
                    <div class="backup-info">
                        <strong>Last Backup:</strong> ${settings.lastBackup}<br>
                        <strong>Next Backup:</strong> ${settings.nextBackup}
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">Auto Backup</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="autoBackup" ${settings.autoBackup == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <span class="toggle-label">System Maintenance Mode</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="maintenanceMode" ${settings.maintenanceMode == 'true' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="logLevel">Log Level</label>
                        <select id="logLevel" name="logLevel" class="form-control">
                            <option value="ERROR" ${settings.logLevel == 'ERROR' ? 'selected' : ''}>Error</option>
                            <option value="WARN" ${settings.logLevel == 'WARN' ? 'selected' : ''}>Warning</option>
                            <option value="INFO" ${settings.logLevel == 'INFO' ? 'selected' : ''}>Info</option>
                            <option value="DEBUG" ${settings.logLevel == 'DEBUG' ? 'selected' : ''}>Debug</option>
                        </select>
                    </div>
                </div>
                
            </div>
            
            <div style="text-align: center; margin-top: 2rem;">
                <button type="submit" class="btn btn-success">Save All Settings</button>
                <button type="button" class="btn btn-warning" onclick="resetSettings()">Reset to Defaults</button>
                <button type="button" class="btn btn-danger" onclick="exportSettings()">Export Settings</button>
            </div>
        </form>
    </div>

    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
    <script>
        // Dark mode toggle functionality
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
        
        // Load saved theme
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme === 'dark') {
            darkModeToggle.checked = true;
        }
        
        // Theme preview functionality
        const themeSelect = document.getElementById('theme');
        const themePreview = document.getElementById('themePreview');
        
        function updateThemePreview() {
            const theme = themeSelect.value;
            const colors = {
                default: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                modern: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                classic: 'linear-gradient(135deg, #2c3e50 0%, #34495e 100%)',
                minimal: 'linear-gradient(135deg, #ecf0f1 0%, #bdc3c7 100%)'
            };
            themePreview.style.background = colors[theme];
        }
        
        themeSelect.addEventListener('change', updateThemePreview);
        updateThemePreview();
        
        // Color picker functionality
        const primaryColorPicker = document.getElementById('primaryColor');
        primaryColorPicker.addEventListener('change', function() {
            window.themeManager.setPrimaryColor(this.value);
        });
        
        // Settings functions
        function resetSettings() {
            if (confirm('Are you sure you want to reset all settings to defaults?')) {
                // This would typically make an AJAX call to reset settings
                alert('Settings reset functionality would be implemented here.');
            }
        }
        
        function exportSettings() {
            // This would typically export settings as JSON
            alert('Export settings functionality would be implemented here.');
        }
        
        // Auto-save functionality for theme changes
        const themeInputs = document.querySelectorAll('#darkMode, #primaryColor, #theme');
        themeInputs.forEach(input => {
            input.addEventListener('change', function() {
                // Trigger storage event for other pages
                const event = new StorageEvent('storage', {
                    key: this.id === 'darkMode' ? 'theme' : this.id === 'primaryColor' ? 'primaryColor' : 'appTheme',
                    newValue: this.type === 'checkbox' ? (this.checked ? 'dark' : 'light') : this.value
                });
                window.dispatchEvent(event);
            });
        });
    </script>
</body>
</html> 