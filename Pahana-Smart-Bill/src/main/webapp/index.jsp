<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Smart Bill - Welcome</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .welcome-container {
            background: white;
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        
        .logo {
            margin-bottom: 2rem;
        }
        
        .logo h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .logo p {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }
        
        .features {
            margin: 2rem 0;
            text-align: left;
        }
        
        .feature {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.5rem;
        }
        
        .feature-icon {
            width: 20px;
            height: 20px;
            background: #667eea;
            border-radius: 50%;
            margin-right: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 0.8rem;
        }
        
        .btn-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.2s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .loading {
            display: none;
            margin-top: 1rem;
        }
        
        .spinner {
            border: 3px solid #f3f3f3;
            border-top: 3px solid #667eea;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <div class="logo">
            <h1>Pahana Smart Bill</h1>
            <p>Smart Billing Management System</p>
        </div>
        
        <div class="features">
            <div class="feature">
                <div class="feature-icon">✓</div>
                <span>User Registration with Email Verification</span>
            </div>
            <div class="feature">
                <div class="feature-icon">✓</div>
                <span>Role-based Access Control</span>
            </div>
            <div class="feature">
                <div class="feature-icon">✓</div>
                <span>Customer & Bill Management</span>
            </div>
            <div class="feature">
                <div class="feature-icon">✓</div>
                <span>Secure Password Hashing</span>
            </div>
            <div class="feature">
                <div class="feature-icon">✓</div>
                <span>Comprehensive Reporting</span>
            </div>
        </div>
        
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">Register</a>
        </div>
        
        <div class="loading" id="loading">
            <div class="spinner"></div>
            <p>Redirecting to login...</p>
        </div>
    </div>
    
    <script>
        // Auto-redirect to login after 3 seconds
        setTimeout(function() {
            document.getElementById('loading').style.display = 'block';
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/login';
            }, 1000);
        }, 3000);
    </script>
</body>
</html>
