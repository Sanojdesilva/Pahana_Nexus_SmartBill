<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support - Pahana Smart Bill</title>
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
        .card { background: var(--bg-card); border-radius: var(--radius-xl); box-shadow: var(--shadow-lg); border: 1px solid var(--bg-overlay); margin-bottom: var(--spacing-xl); padding: var(--spacing-xl); }
        .table-header { background: rgba(44, 85, 48, 0.05); padding: var(--spacing-lg); border-bottom: 1px solid var(--bg-overlay); border-radius: var(--radius-xl) var(--radius-xl) 0 0; }
        .table-header h2, .table-header h3 { margin: 0; color: var(--text-dark); font-weight: 700; }
        .support-container { max-width: 1000px; margin: 0 auto; }
        .support-header { text-align: center; margin-bottom: var(--spacing-xl); }
        .support-grid { display: grid; grid-template-columns: 1fr 1fr; gap: var(--spacing-xl); margin-bottom: var(--spacing-xl); }
        .support-section { background: var(--bg-white); padding: var(--spacing-xl); border-radius: var(--radius-lg); box-shadow: var(--shadow-md); }
        .form-group { margin-bottom: var(--spacing-md); }
        .form-group label { display: block; margin-bottom: var(--spacing-xs); font-weight: 600; color: var(--text-dark); }
        .form-control { width: 100%; padding: var(--spacing-sm); border: 2px solid #e5e7eb; border-radius: var(--radius-md); font-size: 1rem; background: rgba(255,255,255,0.9); color: var(--text-dark); transition: all var(--transition-normal); }
        .form-control:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(44, 85, 48, 0.1); background: var(--bg-white); }
        textarea.form-control { min-height: 120px; resize: vertical; }
        .btn { padding: var(--spacing-sm) var(--spacing-lg); border: none; border-radius: var(--radius-md); cursor: pointer; font-weight: 600; transition: all var(--transition-normal); display: inline-flex; align-items: center; gap: var(--spacing-xs); font-size: 1rem; }
        .btn-primary { background: var(--primary-color); color: white; }
        .btn-secondary { background: var(--secondary-color); color: white; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        .contact-info { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: var(--spacing-lg); margin-bottom: var(--spacing-xl); }
        .contact-card { background: var(--bg-white); padding: var(--spacing-xl); border-radius: var(--radius-lg); box-shadow: var(--shadow-md); text-align: center; }
        .contact-card .icon { font-size: 2rem; margin-bottom: 1rem; }
        .contact-card h4 { color: var(--primary-color); margin-bottom: 0.5rem; }
        .contact-card p { color: var(--text-muted); margin: 0; }
        .faq-item { border: 1px solid var(--bg-overlay); border-radius: var(--radius-md); margin-bottom: var(--spacing-md); overflow: hidden; }
        .faq-question { background: var(--bg-secondary); padding: var(--spacing-md); cursor: pointer; font-weight: bold; color: var(--text-dark); display: flex; justify-content: space-between; align-items: center; }
        .faq-question:hover { background: var(--bg-card); }
        .faq-answer { padding: var(--spacing-md); color: var(--text-muted); border-top: 1px solid var(--bg-overlay); display: none; }
        .faq-answer.active { display: block; }
        .faq-toggle { font-size: 1.2rem; transition: transform 0.3s; }
        .faq-toggle.active { transform: rotate(180deg); }
        .priority-select { padding: var(--spacing-sm); border: 2px solid #e5e7eb; border-radius: var(--radius-md); background: rgba(255,255,255,0.9); color: var(--text-dark); }
        .priority-high { color: #dc3545; }
        .priority-medium { color: #ffc107; }
        .priority-low { color: #28a745; }
        .coming-soon { text-align: center; padding: var(--spacing-xl); color: var(--text-muted); background: var(--bg-white); border-radius: var(--radius-lg); box-shadow: var(--shadow-md); margin-bottom: var(--spacing-xl); }
        .coming-soon h3 { margin-bottom: 1rem; color: var(--text-dark); }
        .coming-soon .icon { font-size: 4rem; margin-bottom: 1rem; opacity: 0.5; }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .status-open { background: #d4edda; color: #155724; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-resolved { background: #cce5ff; color: #004085; }
        @media (max-width: 900px) { .support-grid { grid-template-columns: 1fr; } }
        @media (max-width: 768px) { .nav-links { flex-direction: column; gap: 0.5rem; } .support-header { margin-bottom: var(--spacing-lg); } }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-headset"></i> Customer Support</h1>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/customer/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/customer/bills"><i class="fas fa-file-invoice"></i> My Bills</a>
                <a href="${pageContext.request.contextPath}/customer/profile"><i class="fas fa-user"></i> My Profile</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="support-container">
            <div class="card">
                <div class="table-header"><h2>How Can We Help You?</h2></div>
                <div class="support-header">
                    <p>Get assistance with your billing, payments, and account questions</p>
                </div>
                <div class="contact-info">
                    <div class="contact-card">
                        <div class="icon">📞</div>
                        <h4>Phone Support</h4>
                        <p>+1 (555) 123-4567</p>
                        <p>Mon-Fri: 9AM-6PM</p>
                    </div>
                    <div class="contact-card">
                        <div class="icon">✉️</div>
                        <h4>Email Support</h4>
                        <p>support@pahana.com</p>
                        <p>Response within 24h</p>
                    </div>
                    <div class="contact-card">
                        <div class="icon">💬</div>
                        <h4>Live Chat</h4>
                        <p>Available 24/7</p>
                        <p>Click to start chat</p>
                    </div>
                    <div class="contact-card">
                        <div class="icon">🏢</div>
                        <h4>Office Visit</h4>
                        <p>123 Main Street</p>
                        <p>City, State 12345</p>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="table-header"><h2>Support Portal</h2></div>
                <div class="coming-soon">
                    <div class="icon">🛠️</div>
                    <h3>Support Portal Coming Soon</h3>
                    <p>We are working on a comprehensive support portal that will allow you to submit tickets, track your requests, and get real-time updates. This feature will be available soon.</p>
                    <p>In the meantime, please use the contact methods above for immediate assistance.</p>
                    <button class="btn btn-primary" onclick="showContactForm()"><i class="fas fa-envelope"></i> Contact Support</button>
                </div>
            </div>
            <!-- Support Form (Hidden for now) -->
            <div id="supportForm" style="display: none;">
                <div class="support-grid">
                    <div class="support-section">
                        <div class="table-header"><h3>Submit a Support Ticket</h3></div>
                        <form id="ticketForm">
                            <div class="form-group">
                                <label for="subject">Subject</label>
                                <input type="text" id="subject" name="subject" class="form-control" placeholder="Brief description of your issue" required />
                            </div>
                            <div class="form-group">
                                <label for="category">Category</label>
                                <select id="category" name="category" class="form-control">
                                    <option value="">Select a category</option>
                                    <option value="billing">Billing Issue</option>
                                    <option value="payment">Payment Problem</option>
                                    <option value="account">Account Access</option>
                                    <option value="technical">Technical Issue</option>
                                    <option value="general">General Inquiry</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="priority">Priority</label>
                                <select id="priority" name="priority" class="form-control">
                                    <option value="low">Low</option>
                                    <option value="medium">Medium</option>
                                    <option value="high">High</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea id="description" name="description" class="form-control" placeholder="Please provide detailed information about your issue..." required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="email">Contact Email</label>
                                <input type="email" id="email" name="email" class="form-control" placeholder="your@email.com" required />
                            </div>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Submit Ticket</button>
                        </form>
                    </div>
                    <div class="support-section">
                        <div class="table-header"><h3>Frequently Asked Questions</h3></div>
                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFAQ(this)">
                                How do I download my bill?
                                <span class="faq-toggle">▼</span>
                            </div>
                            <div class="faq-answer">
                                You can download your bill as a PDF by clicking the "Download PDF" button next to any bill in your billing history.
                            </div>
                        </div>
                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFAQ(this)">
                                What payment methods do you accept?
                                <span class="faq-toggle">▼</span>
                            </div>
                            <div class="faq-answer">
                                We currently accept cash payments at our office. Online payment options will be available soon.
                            </div>
                        </div>
                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFAQ(this)">
                                How can I update my contact information?
                                <span class="faq-toggle">▼</span>
                            </div>
                            <div class="faq-answer">
                                You can update your contact information in your profile settings. Go to "My Profile" to make changes.
                            </div>
                        </div>
                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFAQ(this)">
                                What should I do if I can't access my account?
                                <span class="faq-toggle">▼</span>
                            </div>
                            <div class="faq-answer">
                                If you're having trouble accessing your account, please contact our support team immediately. We can help you reset your password or resolve any access issues.
                            </div>
                        </div>
                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFAQ(this)">
                                How often are bills generated?
                                <span class="faq-toggle">▼</span>
                            </div>
                            <div class="faq-answer">
                                Bills are typically generated monthly, but the frequency may vary based on your service plan and usage patterns.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/4b7c1b6e8b.js" crossorigin="anonymous"></script>
    <script>
        function showContactForm() {
            document.getElementById('supportForm').style.display = 'block';
            window.scrollTo({top: document.getElementById('supportForm').offsetTop-40, behavior: 'smooth'});
        }
        function toggleFAQ(el) {
            const answer = el.nextElementSibling;
            const toggle = el.querySelector('.faq-toggle');
            answer.classList.toggle('active');
            toggle.classList.toggle('active');
        }
        document.getElementById('ticketForm')?.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Your support ticket has been submitted! Our team will get back to you soon.');
            this.reset();
        });
    </script>
</body>
</html> 