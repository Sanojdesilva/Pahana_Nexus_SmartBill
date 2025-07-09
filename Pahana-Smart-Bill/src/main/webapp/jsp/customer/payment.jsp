<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make Payment - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
    <script src="${pageContext.request.contextPath}/js/theme-manager.js"></script>
    <style>
        .payment-container { max-width: 800px; margin: 0 auto; }
        .payment-header { text-align: center; margin-bottom: 2rem; }
        .payment-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; }
        .payment-section { background: var(--card-bg); padding: 1.5rem; border-radius: 10px; box-shadow: var(--shadow); }
        .payment-section h3 { color: var(--primary-color); margin-bottom: 1rem; border-bottom: 2px solid var(--border-color); padding-bottom: 0.5rem; }
        
        .form-group { margin-bottom: 1rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: bold; color: var(--text-color); }
        .form-control { width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 5px; background: var(--input-bg); color: var(--text-color); }
        .form-control:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2); }
        
        .btn { padding: 0.75rem 1.5rem; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; transition: all 0.3s; }
        .btn-primary { background: var(--primary-color); color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn-secondary { background: var(--secondary-color); color: white; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        .btn:disabled { opacity: 0.6; cursor: not-allowed; transform: none; }
        
        .payment-method { display: flex; align-items: center; padding: 1rem; border: 2px solid var(--border-color); border-radius: 8px; margin-bottom: 1rem; cursor: pointer; transition: all 0.3s; }
        .payment-method:hover { border-color: var(--primary-color); background: var(--table-hover-bg); }
        .payment-method.selected { border-color: var(--primary-color); background: rgba(102, 126, 234, 0.1); }
        .payment-method input { margin-right: 1rem; }
        .payment-method-icon { font-size: 1.5rem; margin-right: 1rem; }
        
        .bill-item { display: flex; justify-content: space-between; align-items: center; padding: 1rem; border: 1px solid var(--border-color); border-radius: 8px; margin-bottom: 1rem; }
        .bill-info h4 { margin: 0; color: var(--text-color); }
        .bill-info p { margin: 0.25rem 0 0 0; color: var(--text-muted); font-size: 0.9rem; }
        .bill-amount { font-weight: bold; color: var(--primary-color); }
        .bill-checkbox { margin-right: 1rem; }
        
        .total-section { background: var(--primary-color); color: white; padding: 1.5rem; border-radius: 10px; margin-top: 1rem; }
        .total-section h3 { margin: 0; font-size: 1.5rem; }
        .total-section p { margin: 0.5rem 0 0 0; opacity: 0.9; }
        
        .card-inputs { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 1rem; }
        .card-number { grid-column: 1 / -1; }
        
        .coming-soon { text-align: center; padding: 3rem; color: var(--text-muted); }
        .coming-soon h3 { margin-bottom: 1rem; color: var(--text-color); }
        .coming-soon .icon { font-size: 4rem; margin-bottom: 1rem; opacity: 0.5; }
        
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-overdue { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Make Payment</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/bills">My Bills</a>
            <a href="${pageContext.request.contextPath}/customer/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="payment-container">
            <div class="payment-header">
                <h2>Online Payment Portal</h2>
                <p>Pay your pending bills securely online</p>
            </div>
            
            <!-- Coming Soon Message -->
            <div class="coming-soon">
                <div class="icon">💳</div>
                <h3>Online Payment Coming Soon</h3>
                <p>We are working hard to enable secure online payments for your convenience. Our payment gateway is currently under development and will be available soon.</p>
                <p>In the meantime, you can:</p>
                <ul style="text-align: left; max-width: 400px; margin: 1rem auto;">
                    <li>Download your bills as PDF</li>
                    <li>Contact our support team for payment assistance</li>
                    <li>Visit our office for in-person payments</li>
                </ul>
                <button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/customer/bills'">View My Bills</button>
            </div>
            
            <!-- Payment Form (Hidden for now) -->
            <div style="display: none;">
                <div class="payment-grid">
                    <div class="payment-section">
                        <h3>Select Bills to Pay</h3>
                        <div class="bill-item">
                            <input type="checkbox" class="bill-checkbox" id="bill1" />
                            <div class="bill-info">
                                <h4>Bill #2024-001</h4>
                                <p>Due: Jan 15, 2024</p>
                                <span class="status-badge status-pending">Pending</span>
                            </div>
                            <div class="bill-amount">$150.00</div>
                        </div>
                        <div class="bill-item">
                            <input type="checkbox" class="bill-checkbox" id="bill2" />
                            <div class="bill-info">
                                <h4>Bill #2024-002</h4>
                                <p>Due: Feb 15, 2024</p>
                                <span class="status-badge status-overdue">Overdue</span>
                            </div>
                            <div class="bill-amount">$200.00</div>
                        </div>
                        <div class="total-section">
                            <h3>Total: $350.00</h3>
                            <p>Selected bills: 2</p>
                        </div>
                    </div>
                    
                    <div class="payment-section">
                        <h3>Payment Method</h3>
                        <div class="payment-method selected">
                            <input type="radio" name="paymentMethod" value="credit" checked />
                            <span class="payment-method-icon">💳</span>
                            <div>
                                <strong>Credit/Debit Card</strong>
                                <p>Visa, Mastercard, American Express</p>
                            </div>
                        </div>
                        <div class="payment-method">
                            <input type="radio" name="paymentMethod" value="bank" />
                            <span class="payment-method-icon">🏦</span>
                            <div>
                                <strong>Bank Transfer</strong>
                                <p>Direct bank transfer</p>
                            </div>
                        </div>
                        <div class="payment-method">
                            <input type="radio" name="paymentMethod" value="digital" />
                            <span class="payment-method-icon">📱</span>
                            <div>
                                <strong>Digital Wallet</strong>
                                <p>PayPal, Apple Pay, Google Pay</p>
                            </div>
                        </div>
                        
                        <form id="paymentForm">
                            <div class="form-group">
                                <label for="cardNumber">Card Number</label>
                                <input type="text" id="cardNumber" class="form-control card-number" placeholder="1234 5678 9012 3456" maxlength="19" />
                            </div>
                            <div class="card-inputs">
                                <div class="form-group">
                                    <label for="expiryDate">Expiry Date</label>
                                    <input type="text" id="expiryDate" class="form-control" placeholder="MM/YY" maxlength="5" />
                                </div>
                                <div class="form-group">
                                    <label for="cvv">CVV</label>
                                    <input type="text" id="cvv" class="form-control" placeholder="123" maxlength="4" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cardholderName">Cardholder Name</label>
                                <input type="text" id="cardholderName" class="form-control" placeholder="John Doe" />
                            </div>
                            <div class="form-group">
                                <label for="email">Email for Receipt</label>
                                <input type="email" id="email" class="form-control" placeholder="john@example.com" />
                            </div>
                            <button type="submit" class="btn btn-success" style="width: 100%;">Pay Now</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Payment method selection
        document.querySelectorAll('.payment-method').forEach(method => {
            method.addEventListener('click', function() {
                document.querySelectorAll('.payment-method').forEach(m => m.classList.remove('selected'));
                this.classList.add('selected');
                this.querySelector('input').checked = true;
            });
        });
        
        // Bill selection
        document.querySelectorAll('.bill-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', updateTotal);
        });
        
        function updateTotal() {
            const selectedBills = document.querySelectorAll('.bill-checkbox:checked');
            let total = 0;
            selectedBills.forEach(bill => {
                const amount = bill.closest('.bill-item').querySelector('.bill-amount').textContent;
                total += parseFloat(amount.replace('$', ''));
            });
            
            const totalElement = document.querySelector('.total-section h3');
            const countElement = document.querySelector('.total-section p');
            totalElement.textContent = `Total: $${total.toFixed(2)}`;
            countElement.textContent = `Selected bills: ${selectedBills.length}`;
        }
        
        // Card number formatting
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s/g, '').replace(/\D/g, '');
            let formattedValue = value.replace(/(\d{4})(?=\d)/g, '$1 ');
            e.target.value = formattedValue;
        });
        
        // Expiry date formatting
        document.getElementById('expiryDate').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            e.target.value = value;
        });
        
        // Form submission
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Payment processing is not yet available. Please check back later!');
        });
    </script>
</body>
</html> 