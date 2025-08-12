<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahana Smart Bill</title>
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
            overflow: hidden;
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
        
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 3.5rem;
            border-radius: 24px;
            box-shadow: var(--shadow-xl);
            width: 100%;
            max-width: 480px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color), var(--accent-color));
        }
        
        .logo {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .logo-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 50%;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-lg);
            position: relative;
            animation: pulse 2s infinite;
        }
        
        .logo-badge i {
            font-size: 2rem;
            color: white;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .logo h1 {
            font-family: 'Playfair Display', serif;
            color: var(--text-dark);
            font-size: 2.8rem;
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
            font-size: 1.1rem;
            font-weight: 400;
            letter-spacing: 0.5px;
        }
        
        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.8rem;
            color: var(--text-dark);
            font-weight: 600;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-wrapper i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            font-size: 1.1rem;
            transition: color 0.3s ease;
        }
        
        .form-group input {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
        }
        
        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(44, 85, 48, 0.1);
            background: white;
        }
        
        .form-group input:focus + i {
            color: var(--primary-color);
        }
        
        .form-group input::placeholder {
            color: #9ca3af;
        }
        
        .btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
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
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }
        
        .btn:active {
            transform: translateY(0);
        }
        
        .error {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            border: none;
            font-weight: 500;
            box-shadow: var(--shadow-md);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .success {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            border: none;
            font-weight: 500;
            box-shadow: var(--shadow-md);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .links {
            text-align: center;
            margin-top: 2.5rem;
            padding-top: 2rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .links p {
            color: var(--text-light);
            font-size: 0.95rem;
        }
        
        .links a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        
        .links a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
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
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-10px) rotate(5deg); }
        }
        
        @media (max-width: 480px) {
            .login-container {
                margin: 1rem;
                padding: 2.5rem 2rem;
            }
            
            .logo h1 {
                font-size: 2.2rem;
            }
            
            .logo-badge {
                width: 60px;
                height: 60px;
            }
            
            .logo-badge i {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="floating-elements">
        <div class="floating-element">📚</div>
        <div class="floating-element">📖</div>
    </div>
    
    <div class="login-container">
        <div class="logo">
            <div class="logo-badge">
                <i class="fas fa-book-open"></i>
            </div>
            <h1>Pahana Smart Bill</h1>
            <p>Sign in to your account</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <i class="fas fa-exclamation-circle"></i>
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="success">
                <i class="fas fa-check-circle"></i>
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-wrapper">
                    <input type="text" id="username" name="username" placeholder="Enter your username" required>
                    <i class="fas fa-user"></i>
                </div>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    <i class="fas fa-lock"></i>
                </div>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-sign-in-alt"></i>
                Sign In
            </button>
        </form>
        
        <div class="links">
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
        </div>
    </div>
</body>
</html> 