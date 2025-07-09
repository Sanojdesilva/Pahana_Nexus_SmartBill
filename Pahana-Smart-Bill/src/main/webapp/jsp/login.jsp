<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: var(--spacing-lg);
        }
        
        .login-container {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            padding: var(--spacing-2xl);
            border-radius: var(--radius-2xl);
            box-shadow: var(--shadow-xl);
            width: 100%;
            max-width: 480px;
            border: 1px solid var(--bg-overlay);
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
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light), var(--secondary-color));
        }
        
        .logo {
            text-align: center;
            margin-bottom: var(--spacing-xl);
        }
        
        .logo-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            border-radius: 50%;
            margin-bottom: var(--spacing-lg);
            box-shadow: var(--shadow-lg);
            position: relative;
            animation: pulse 2s infinite;
        }
        
        .logo-badge i {
            font-size: 2rem;
            color: var(--text-white);
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .logo h1 {
            color: var(--text-dark);
            font-size: 2.8rem;
            margin-bottom: var(--spacing-xs);
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
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
            margin-bottom: var(--spacing-lg);
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: var(--spacing-xs);
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
            left: var(--spacing-sm);
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1.1rem;
            transition: color var(--transition-normal);
            z-index: 2;
        }
        
        .form-group input {
            width: 100%;
            padding: var(--spacing-sm) var(--spacing-sm) var(--spacing-sm) 3rem;
            border: 2px solid #e5e7eb;
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: all var(--transition-normal);
            background: rgba(255, 255, 255, 0.9);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
        }
        
        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(44, 85, 48, 0.1);
            background: var(--bg-white);
        }
        
        .form-group input:focus + i {
            color: var(--primary-color);
        }
        
        .form-group input::placeholder {
            color: var(--text-muted);
        }
        
        .btn {
            width: 100%;
            padding: var(--spacing-sm);
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            color: var(--text-white);
            border: none;
            border-radius: var(--radius-md);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-normal);
            font-family: 'Inter', sans-serif;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: var(--spacing-xs);
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left var(--transition-slow);
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