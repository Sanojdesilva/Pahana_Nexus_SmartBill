<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Bill - Pahana Smart Bill</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .page-header h2 {
            color: #333;
            font-size: 1.8rem;
        }
        
        .btn {
            background: #667eea;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
            transition: background 0.3s;
            font-size: 1rem;
        }
        
        .btn:hover {
            background: #5a6fd8;
        }
        
        .btn-secondary {
            background: #6c757d;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .form-header {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            border-left: 4px solid #667eea;
        }
        
        .form-header h3 {
            margin: 0;
            color: #333;
            font-size: 1.2rem;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #333;
        }
        
        .form-group input, 
        .form-group select, 
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus, 
        .form-group select:focus, 
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .required {
            color: #dc3545;
            font-weight: bold;
        }
        
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            padding-top: 1rem;
            border-top: 1px solid #eee;
            margin-top: 2rem;
        }
        
        .error {
            background: #fee;
            color: #c33;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #fcc;
        }
        
        .success {
            background: #efe;
            color: #3c3;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #cfc;
        }
        
        .help-text {
            font-size: 0.85rem;
            color: #666;
            margin-top: 0.25rem;
        }
        
        .calculation-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
            border-left: 4px solid #28a745;
        }
        
        .calculation-summary h4 {
            margin-bottom: 1rem;
            color: #333;
        }
        
        .calculation-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            padding: 0.5rem 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .calculation-row:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.1rem;
            color: #28a745;
        }
        
        .readonly {
            background: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .nav-links {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Edit Bill</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/customers/">Customers</a>
            <a href="${pageContext.request.contextPath}/bills/">Bills</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <c:if test="${not empty message}">
            <div class="success">${message}</div>
        </c:if>
        
        <div class="page-header">
            <h2>Edit Bill</h2>
            <a href="${pageContext.request.contextPath}/bills/" class="btn btn-secondary">Back to Bills</a>
        </div>
        
        <c:if test="${not empty editBill}">
            <div class="form-container">
                <div class="form-header">
                    <h3>Edit Bill Information</h3>
                </div>
                
                <form method="post" action="${pageContext.request.contextPath}/bills">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" value="${editBill.id}" />
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>Bill ID</label>
                            <input type="text" value="${editBill.id}" class="readonly" readonly />
                            <div class="help-text">Auto-generated bill ID</div>
                        </div>
                        
                        <div class="form-group">
                            <label>Bill Number</label>
                            <input type="text" value="${editBill.billNumber}" class="readonly" readonly />
                            <div class="help-text">Auto-generated bill number</div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="customerId">Customer <span class="required">*</span></label>
                            <select id="customerId" name="customerId" required>
                                <c:forEach var="customer" items="${customers}">
                                    <option value="${customer.id}" ${editBill.customerId == customer.id ? 'selected' : ''}>
                                        ${customer.name} (${customer.accountNumber})
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="help-text">Select the customer for this bill</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="status">Status <span class="required">*</span></label>
                            <select id="status" name="status" required>
                                <option value="PENDING" ${editBill.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                <option value="PAID" ${editBill.status == 'PAID' ? 'selected' : ''}>Paid</option>
                                <option value="CANCELLED" ${editBill.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                            </select>
                            <div class="help-text">Set the current status of the bill</div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="unitsConsumed">Units Consumed <span class="required">*</span></label>
                            <input type="number" id="unitsConsumed" name="unitsConsumed" 
                                   required value="${editBill.unitsConsumed}" placeholder="0" min="0" />
                            <div class="help-text">Enter the number of units consumed</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="unitRate">Unit Rate <span class="required">*</span></label>
                            <input type="number" step="0.01" min="0" id="unitRate" name="unitRate" 
                                   required value="${editBill.unitRate}" placeholder="0.00" />
                            <div class="help-text">Enter the rate per unit (e.g., 0.15 for $0.15 per unit)</div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="dueDate">Due Date <span class="required">*</span></label>
                            <input type="date" id="dueDate" name="dueDate" 
                                   required value="${editBill.dueDate}" />
                            <div class="help-text">Set the due date for payment</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="paidDate">Paid Date</label>
                            <input type="date" id="paidDate" name="paidDate" 
                                   value="${editBill.paidDate}" />
                            <div class="help-text">Enter the date when payment was received (optional)</div>
                        </div>
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="notes">Notes</label>
                        <textarea id="notes" name="notes" 
                                  placeholder="Enter any additional notes or comments">${editBill.notes}</textarea>
                        <div class="help-text">Add any additional information about this bill</div>
                    </div>
                    
                    <div class="calculation-summary">
                        <h4>Bill Calculation Summary</h4>
                        <div class="calculation-row">
                            <span>Units Consumed:</span>
                            <span id="displayUnits">${editBill.unitsConsumed}</span>
                        </div>
                        <div class="calculation-row">
                            <span>Unit Rate:</span>
                            <span id="displayRate">$${editBill.unitRate}</span>
                        </div>
                        <div class="calculation-row">
                            <span>Subtotal:</span>
                            <span id="displaySubtotal">$${editBill.subtotal}</span>
                        </div>
                        <div class="calculation-row">
                            <span>Tax (15%):</span>
                            <span id="displayTax">$${editBill.taxAmount}</span>
                        </div>
                        <div class="calculation-row">
                            <span>Total Amount:</span>
                            <span id="displayTotal">$${editBill.total}</span>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/bills" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn">Update Bill</button>
                    </div>
                </form>
            </div>
        </c:if>
        
        <c:if test="${empty editBill}">
            <div class="form-container">
                <div style="text-align: center; padding: 3rem;">
                    <h3>Bill Not Found</h3>
                    <p>The requested bill could not be found.</p>
                    <a href="${pageContext.request.contextPath}/bills/" class="btn btn-secondary">Back to Bills</a>
                </div>
            </div>
        </c:if>
    </div>
    
    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            const unitsInput = document.getElementById('unitsConsumed');
            const rateInput = document.getElementById('unitRate');
            
            // Auto-calculate totals when units or rate changes
            function calculateTotals() {
                const units = parseFloat(unitsInput.value) || 0;
                const rate = parseFloat(rateInput.value) || 0;
                const subtotal = units * rate;
                const tax = subtotal * 0.15; // 15% tax
                const total = subtotal + tax;
                
                document.getElementById('displayUnits').textContent = units;
                document.getElementById('displayRate').textContent = '$' + rate.toFixed(2);
                document.getElementById('displaySubtotal').textContent = '$' + subtotal.toFixed(2);
                document.getElementById('displayTax').textContent = '$' + tax.toFixed(2);
                document.getElementById('displayTotal').textContent = '$' + total.toFixed(2);
            }
            
            // Event listeners
            unitsInput.addEventListener('input', calculateTotals);
            rateInput.addEventListener('input', calculateTotals);
            
            // Format inputs on blur
            unitsInput.addEventListener('blur', function() {
                if (this.value) {
                    this.value = parseInt(this.value);
                }
            });
            
            rateInput.addEventListener('blur', function() {
                if (this.value) {
                    this.value = parseFloat(this.value).toFixed(2);
                }
            });
            
            // Validate form before submit
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                const units = parseInt(document.getElementById('unitsConsumed').value);
                const rate = parseFloat(document.getElementById('unitRate').value);
                const dueDate = document.getElementById('dueDate').value;
                
                if (!units || units < 0) {
                    e.preventDefault();
                    alert('Please enter a valid number of units consumed.');
                    return;
                }
                
                if (!rate || rate < 0) {
                    e.preventDefault();
                    alert('Please enter a valid unit rate.');
                    return;
                }
                
                if (!dueDate) {
                    e.preventDefault();
                    alert('Please select a due date.');
                    return;
                }
            });
            
            // Initialize calculations
            calculateTotals();
        });
    </script>
</body>
</html> 