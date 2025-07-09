<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Smart Bill - Welcome</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700;900&family=Inter:wght@300;400;500;600;700&family=Source+Sans+Pro:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        :root {
            --primary-color: #2c5530;
            --secondary-color: #4a7c59;
            --accent-color: #8b4513;
            --text-dark: #1a1a1a;
            --text-light: #6b7280;
            --bg-light: #f8fafc;
            --bg-white: #ffffff;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 50%, #cbd5e1 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
            color: var(--text-dark);
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(44, 85, 48, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(74, 124, 89, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(139, 69, 19, 0.02) 0%, transparent 50%);
            z-index: -1;
        }
        
        .welcome-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 4rem 3rem;
            border-radius: 24px;
            box-shadow: var(--shadow-xl);
            text-align: center;
            max-width: 800px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .welcome-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color), var(--accent-color));
        }
        
        .logo {
            margin-bottom: 3rem;
            position: relative;
        }
        
        .logo-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 50%;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-lg);
            position: relative;
            animation: pulse 2s infinite;
        }
        
        .logo-badge i {
            font-size: 2.5rem;
            color: white;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .logo h1 {
            font-family: 'Playfair Display', serif;
            color: var(--text-dark);
            font-size: 3.5rem;
            margin-bottom: 0.5rem;
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1.2;
        }
        
        .logo p {
            color: var(--text-light);
            font-size: 1.25rem;
            margin-bottom: 0;
            font-weight: 400;
            letter-spacing: 0.5px;
            max-width: 500px;
            margin: 0 auto;
        }
        
        .features {
            margin: 3rem 0;
            text-align: left;
            background: linear-gradient(135deg, rgba(44, 85, 48, 0.03), rgba(74, 124, 89, 0.03));
            padding: 2.5rem;
            border-radius: 20px;
            border: 1px solid rgba(44, 85, 48, 0.1);
            position: relative;
        }
        
        .features::before {
            content: '';
            position: absolute;
            top: -1px;
            left: -1px;
            right: -1px;
            bottom: -1px;
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            border-radius: 20px;
            z-index: -1;
            opacity: 0.1;
        }
        
        .features h3 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            font-size: 1.5rem;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
        }
        
        .feature {
            display: flex;
            align-items: flex-start;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 16px;
            transition: all 0.3s ease;
            border: 1px solid rgba(44, 85, 48, 0.05);
            position: relative;
            overflow: hidden;
        }
        
        .feature::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(180deg, var(--primary-color), var(--secondary-color));
            transform: scaleY(0);
            transition: transform 0.3s ease;
        }
        
        .feature:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(44, 85, 48, 0.1);
        }
        
        .feature:hover::before {
            transform: scaleY(1);
        }
        
        .feature-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 12px;
            margin-right: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            flex-shrink: 0;
            box-shadow: var(--shadow-md);
        }
        
        .feature-content {
            flex: 1;
        }
        
        .feature-title {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 1rem;
            margin-bottom: 0.25rem;
        }
        
        .feature-description {
            color: var(--text-light);
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .btn-group {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            margin-top: 3rem;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 1rem 2.5rem;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            min-width: 160px;
            justify-content: center;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            box-shadow: var(--shadow-md);
        }
        
        .btn-secondary {
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            font-weight: 600;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .btn-primary:hover {
            box-shadow: var(--shadow-lg);
        }
        
        .btn-secondary:hover {
            background: var(--primary-color);
            color: white;
            box-shadow: var(--shadow-lg);
        }
        
        .loading {
            display: none;
            margin-top: 2rem;
            padding: 2rem;
            background: linear-gradient(135deg, rgba(44, 85, 48, 0.05), rgba(74, 124, 89, 0.05));
            border-radius: 16px;
            border: 1px solid rgba(44, 85, 48, 0.1);
        }
        
        .spinner {
            border: 3px solid rgba(44, 85, 48, 0.2);
            border-top: 3px solid var(--primary-color);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto 1rem;
        }
        
        .loading p {
            color: var(--primary-color);
            font-weight: 500;
            font-size: 1rem;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            pointer-events: none;
            overflow: hidden;
        }
        
        .floating-element {
            position: absolute;
            color: rgba(44, 85, 48, 0.1);
            animation: float 6s ease-in-out infinite;
        }
        
        .floating-element:nth-child(1) {
            top: 10%;
            right: 10%;
            font-size: 2rem;
            animation-delay: 0s;
        }
        
        .floating-element:nth-child(2) {
            bottom: 20%;
            left: 5%;
            font-size: 1.5rem;
            animation-delay: 2s;
        }
        
        .floating-element:nth-child(3) {
            top: 60%;
            right: 5%;
            font-size: 1.8rem;
            animation-delay: 4s;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-10px) rotate(5deg); }
        }
        
        @media (max-width: 768px) {
            .welcome-container {
                margin: 1rem;
                padding: 2.5rem 2rem;
            }
            
            .logo h1 {
                font-size: 2.5rem;
            }
            
            .logo p {
                font-size: 1.1rem;
            }
            
            .features {
                padding: 2rem 1.5rem;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .btn-group {
                flex-direction: column;
                gap: 1rem;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 480px) {
            .welcome-container {
                padding: 2rem 1.5rem;
            }
            
            .logo h1 {
                font-size: 2rem;
            }
            
            .logo-badge {
                width: 60px;
                height: 60px;
            }
            
            .logo-badge i {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="floating-elements">
        <div class="floating-element">📚</div>
        <div class="floating-element">📖</div>
        <div class="floating-element">📚</div>
    </div>
    
    <div class="welcome-container">
        <div class="logo">
            <div class="logo-badge">
                <i class="fas fa-book-open"></i>
            </div>
            <h1>Pahana Smart Bill</h1>
            <p>Professional Bookshop Management System</p>
        </div>
        
        <div class="features">
            <h3>
                <i class="fas fa-star"></i>
                Key Features
            </h3>
            <div class="features-grid">
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="feature-content">
                        <div class="feature-title">User Registration & Verification</div>
                        <div class="feature-description">Secure email verification system for new user accounts</div>
                    </div>
                </div>
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="feature-content">
                        <div class="feature-title">Role-based Access Control</div>
                        <div class="feature-description">Admin, Employee, and Customer role management</div>
                    </div>
                </div>
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="feature-content">
                        <div class="feature-title">Customer & Bill Management</div>
                        <div class="feature-description">Comprehensive customer and billing system</div>
                    </div>
                </div>
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-lock"></i>
                    </div>
                    <div class="feature-content">
                        <div class="feature-title">Secure Password Hashing</div>
                        <div class="feature-description">Advanced security with encrypted passwords</div>
                    </div>
                </div>
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <div class="feature-content">
                        <div class="feature-title">Comprehensive Reporting</div>
                        <div class="feature-description">Detailed analytics and business insights</div>
                    </div>
                </div>
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-boxes"></i>
                    </div>
                    <div class="feature-content">
                        <div class="feature-title">Inventory Management</div>
                        <div class="feature-description">Complete stock tracking and management</div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                <i class="fas fa-sign-in-alt"></i>
                Sign In
            </a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">
                <i class="fas fa-user-plus"></i>
                Create Account
            </a>
        </div>
        
        <div class="loading" id="loading">
            <div class="spinner"></div>
            <p>Redirecting to login...</p>
        </div>
    </div>
    
    <script>
        // Auto-redirect to login after 5 seconds
        setTimeout(function() {
            document.getElementById('loading').style.display = 'block';
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/login';
            }, 1500);
        }, 5000);
    </script>
</body>
</html>

