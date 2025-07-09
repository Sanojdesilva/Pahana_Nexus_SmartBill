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
        .support-container { max-width: 1000px; margin: 0 auto; }
        .support-header { text-align: center; margin-bottom: 2rem; }
        .support-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem; }
        .support-section { background: var(--card-bg); padding: 1.5rem; border-radius: 10px; box-shadow: var(--shadow); }
        .support-section h3 { color: var(--primary-color); margin-bottom: 1rem; border-bottom: 2px solid var(--border-color); padding-bottom: 0.5rem; }
        
        .form-group { margin-bottom: 1rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: bold; color: var(--text-color); }
        .form-control { width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 5px; background: var(--input-bg); color: var(--text-color); }
        .form-control:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2); }
        textarea.form-control { min-height: 120px; resize: vertical; }
        
        .btn { padding: 0.75rem 1.5rem; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; transition: all 0.3s; }
        .btn-primary { background: var(--primary-color); color: white; }
        .btn-secondary { background: var(--secondary-color); color: white; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        
        .contact-info { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin-bottom: 2rem; }
        .contact-card { background: var(--card-bg); padding: 1.5rem; border-radius: 10px; box-shadow: var(--shadow); text-align: center; }
        .contact-card .icon { font-size: 2rem; margin-bottom: 1rem; }
        .contact-card h4 { color: var(--primary-color); margin-bottom: 0.5rem; }
        .contact-card p { color: var(--text-muted); margin: 0; }
        
        .faq-item { border: 1px solid var(--border-color); border-radius: 8px; margin-bottom: 1rem; overflow: hidden; }
        .faq-question { background: var(--table-alt-bg); padding: 1rem; cursor: pointer; font-weight: bold; color: var(--text-color); display: flex; justify-content: space-between; align-items: center; }
        .faq-question:hover { background: var(--table-hover-bg); }
        .faq-answer { padding: 1rem; color: var(--text-muted); border-top: 1px solid var(--border-color); display: none; }
        .faq-answer.active { display: block; }
        .faq-toggle { font-size: 1.2rem; transition: transform 0.3s; }
        .faq-toggle.active { transform: rotate(180deg); }
        
        .priority-select { padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 5px; background: var(--input-bg); color: var(--text-color); }
        .priority-high { color: #dc3545; }
        .priority-medium { color: #ffc107; }
        .priority-low { color: #28a745; }
        
        .coming-soon { text-align: center; padding: 3rem; color: var(--text-muted); }
        .coming-soon h3 { margin-bottom: 1rem; color: var(--text-color); }
        .coming-soon .icon { font-size: 4rem; margin-bottom: 1rem; opacity: 0.5; }
        
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .status-open { background: #d4edda; color: #155724; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-resolved { background: #cce5ff; color: #004085; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Customer Support</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/bills">My Bills</a>
            <a href="${pageContext.request.contextPath}/customer/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="support-container">
            <div class="support-header">
                <h2>How Can We Help You?</h2>
                <p>Get assistance with your billing, payments, and account questions</p>
            </div>
            
            <!-- Contact Information -->
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
            
            <!-- Coming Soon Message -->
            <div class="coming-soon">
                <div class="icon">🛠️</div>
                <h3>Support Portal Coming Soon</h3>
                <p>We are working on a comprehensive support portal that will allow you to submit tickets, track your requests, and get real-time updates. This feature will be available soon.</p>
                <p>In the meantime, please use the contact methods above for immediate assistance.</p>
                <button class="btn btn-primary" onclick="showContactForm()">Contact Support</button>
            </div>
            
            <!-- Support Form (Hidden for now) -->
            <div id="supportForm" style="display: none;">
                <div class="support-grid">
                    <div class="support-section">
                        <h3>Submit a Support Ticket</h3>
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
                            <button type="submit" class="btn btn-primary">Submit Ticket</button>
                        </form>
                    </div>
                    
                    <div class="support-section">
                        <h3>Frequently Asked Questions</h3>
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
                
                <!-- Ticket History (Hidden for now) -->
                <div class="support-section" style="display: none;">
                    <h3>My Support Tickets</h3>
                    <table class="bills-table">
                        <thead>
                            <tr>
                                <th>Ticket #</th>
                                <th>Subject</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#TKT-001</td>
                                <td>Payment Issue</td>
                                <td>Payment</td>
                                <td><span class="status-badge status-open">Open</span></td>
                                <td>Jan 15, 2024</td>
                                <td><button class="btn btn-secondary">View</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function showContactForm() {
            document.getElementById('supportForm').style.display = 'block';
            document.querySelector('.coming-soon').style.display = 'none';
        }
        
        function toggleFAQ(element) {
            const answer = element.nextElementSibling;
            const toggle = element.querySelector('.faq-toggle');
            
            if (answer.classList.contains('active')) {
                answer.classList.remove('active');
                toggle.classList.remove('active');
            } else {
                // Close all other FAQs
                document.querySelectorAll('.faq-answer').forEach(ans => ans.classList.remove('active'));
                document.querySelectorAll('.faq-toggle').forEach(tog => tog.classList.remove('active'));
                
                // Open this FAQ
                answer.classList.add('active');
                toggle.classList.add('active');
            }
        }
        
        // Form submission
        document.getElementById('ticketForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Support ticket submitted successfully! We will get back to you soon.');
            this.reset();
        });
        
        // Priority color coding
        document.getElementById('priority').addEventListener('change', function() {
            this.className = 'form-control priority-' + this.value;
        });
    </script>
</body>
</html> 