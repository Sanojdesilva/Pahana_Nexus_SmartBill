<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Pahana Smart Bill</title>
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
            padding: 2rem 0;
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
        
        .register-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 3.5rem;
            border-radius: 24px;
            box-shadow: var(--shadow-xl);
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .register-container::before {
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
        
        .form-row {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .form-group {
            flex: 1;
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
        
        .form-group input, .form-group select {
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
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(44, 85, 48, 0.1);
            background: white;
        }
        
        .form-group input:focus + i,
        .form-group select:focus + i {
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
        
        .info {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
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
        
        .customer-fields {
            display: none;
            background: linear-gradient(135deg, rgba(44, 85, 48, 0.05), rgba(74, 124, 89, 0.05));
            padding: 2rem;
            border-radius: 16px;
            margin-top: 2rem;
            border: 1px solid rgba(44, 85, 48, 0.1);
            position: relative;
        }
        
        .customer-fields::before {
            content: '📚 Customer Information';
            position: absolute;
            top: -12px;
            left: 20px;
            background: white;
            padding: 0 12px;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--primary-color);
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
            .form-row {
                flex-direction: column;
                gap: 1rem;
            }
            
            .register-container {
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
        <div class="floating-element">📚</div>
    </div>
    
    <div class="register-container">
        <div class="logo">
            <div class="logo-badge">
                <i class="fas fa-book-open"></i>
            </div>
            <h1>Pahana Smart Bill</h1>
            <p>Create your account</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <i class="fas fa-exclamation-circle"></i>
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="info">
                <i class="fas fa-info-circle"></i>
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <input type="hidden" name="action" value="register">
            
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">First Name *</label>
                    <div class="input-wrapper">
                        <input type="text" id="firstName" name="firstName" placeholder="Enter your first name" required>
                        <i class="fas fa-user"></i>
                    </div>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name *</label>
                    <div class="input-wrapper">
                        <input type="text" id="lastName" name="lastName" placeholder="Enter your last name" required>
                        <i class="fas fa-user"></i>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="username">Username *</label>
                    <div class="input-wrapper">
                        <input type="text" id="username" name="username" placeholder="Choose a username" required>
                        <i class="fas fa-at"></i>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email">Email *</label>
                    <div class="input-wrapper">
                        <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                        <i class="fas fa-envelope"></i>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password *</label>
                    <div class="input-wrapper">
                        <input type="password" id="password" name="password" placeholder="Create a password" required minlength="6">
                        <i class="fas fa-lock"></i>
                    </div>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password *</label>
                    <div class="input-wrapper">
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required minlength="6">
                        <i class="fas fa-lock"></i>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="role">Role *</label>
                <div class="input-wrapper">
                    <select id="role" name="role" required onchange="toggleCustomerFields()">
                        <option value="">Select your role</option>
                        <option value="ADMIN">Admin</option>
                        <option value="EMPLOYEE">Employee</option>
                        <option value="CUSTOMER">Customer</option>
                    </select>
                    <i class="fas fa-user-tag"></i>
                </div>
            </div>
            
            <div id="customerFields" class="customer-fields">
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <div class="input-wrapper">
                            <input type="tel" id="phone" name="phone" placeholder="Enter your phone number">
                            <i class="fas fa-phone"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <div class="input-wrapper">
                            <input type="text" id="address" name="address" placeholder="Enter your address">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-user-plus"></i>
                Create Account
            </button>
        </form>
        
        <div class="links">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
        </div>
    </div>
    
    <script>
        function toggleCustomerFields() {
            const role = document.getElementById('role').value;
            const customerFields = document.getElementById('customerFields');
            
            if (role === 'CUSTOMER') {
                customerFields.style.display = 'block';
            } else {
                customerFields.style.display = 'none';
            }
        }
        
        // Password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.setCustomValidity('Passwords do not match');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html> 