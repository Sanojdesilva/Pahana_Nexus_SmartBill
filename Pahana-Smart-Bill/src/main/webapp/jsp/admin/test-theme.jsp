<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theme Test - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
</head>
<body>
    <div class="header">
        <h1>Theme Test Page</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/settings">Settings</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="card">
            <h2>Theme System Test</h2>
            <p>This page tests the global theme system. Try changing the theme in Settings and see if it applies here!</p>
            
            <div class="grid grid-2">
                <div class="card">
                    <h3>Test Card 1</h3>
                    <p>This card should change with the theme.</p>
                    <button class="btn">Test Button</button>
                </div>
                
                <div class="card">
                    <h3>Test Card 2</h3>
                    <p>Another card to test theme changes.</p>
                    <button class="btn btn-success">Success Button</button>
                </div>
            </div>
            
            <div class="alert alert-success">
                This is a success alert that should adapt to the theme.
            </div>
            
            <div class="alert alert-error">
                This is an error alert that should adapt to the theme.
            </div>
            
            <table class="table">
                <thead>
                    <tr>
                        <th>Column 1</th>
                        <th>Column 2</th>
                        <th>Column 3</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Data 1</td>
                        <td>Data 2</td>
                        <td>Data 3</td>
                    </tr>
                    <tr>
                        <td>Data 4</td>
                        <td>Data 5</td>
                        <td>Data 6</td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div style="text-align: center; margin-top: 2rem;">
            <a href="${pageContext.request.contextPath}/admin/settings" class="btn">Go to Settings</a>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-success">Go to Dashboard</a>
        </div>
    </div>
</body>
</html> 