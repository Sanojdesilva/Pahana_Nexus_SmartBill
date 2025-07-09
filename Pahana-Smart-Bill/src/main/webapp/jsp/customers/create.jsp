<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Customer - Pahana Smart Bill</title>
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
        
        .rate-info {
            background: #e3f2fd;
            border: 1px solid #2196f3;
            border-radius: 5px;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        
        .rate-info h4 {
            color: #1976d2;
            margin-bottom: 0.5rem;
        }
        
        .rate-info ul {
            margin: 0;
            padding-left: 1.5rem;
        }
        
        .rate-info li {
            margin-bottom: 0.25rem;
        }
        
        .auto-calculated {
            background: #f8f9fa;
            color: #6c757d;
            border: 1px solid #dee2e6;
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
        <h1>Add New Customer</h1>
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
            <h2>Create New Customer</h2>
            <a href="${pageContext.request.contextPath}/customers/" class="btn btn-secondary">Back to Customers</a>
        </div>
        
        <div class="form-container">
            <div class="form-header">
                <h3>Customer Information</h3>
            </div>
            
            <div class="rate-info">
                <h4>Automatic Unit Rate Calculation</h4>
                <p>Unit rates are automatically calculated based on customer type and consumption tier:</p>
                <ul>
                    <li><strong>Residential:</strong> Base rate $0.12/unit</li>
                    <li><strong>Commercial:</strong> Base rate $0.18/unit</li>
                    <li><strong>Industrial:</strong> Base rate $0.25/unit</li>
                    <li><strong>Low Consumption:</strong> 10% discount</li>
                    <li><strong>Medium Consumption:</strong> Standard rate</li>
                    <li><strong>High Consumption:</strong> 15% premium</li>
                </ul>
            </div>
            
            <form method="post" action="${pageContext.request.contextPath}/customers/">
                <input type="hidden" name="action" value="create" />
                <input type="hidden" id="unitRate" name="unitRate" />
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Full Name <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required 
                               value="${name}" placeholder="Enter customer's full name" maxlength="100" />
                        <div class="help-text">Enter the customer's complete name (max 100 characters)</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email Address <span class="required">*</span></label>
                        <input type="email" id="email" name="email" required 
                               value="${email}" placeholder="customer@example.com" />
                        <div class="help-text">Enter a valid email address for billing notifications</div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" 
                               value="${phone}" placeholder="+1 (555) 123-4567" />
                        <div class="help-text">Enter contact phone number (optional)</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="customerType">Customer Type <span class="required">*</span></label>
                        <select id="customerType" name="customerType" required>
                            <option value="RESIDENTIAL" ${customerType == 'RESIDENTIAL' || empty customerType ? 'selected' : ''}>Residential</option>
                            <option value="COMMERCIAL" ${customerType == 'COMMERCIAL' ? 'selected' : ''}>Commercial</option>
                            <option value="INDUSTRIAL" ${customerType == 'INDUSTRIAL' ? 'selected' : ''}>Industrial</option>
                        </select>
                        <div class="help-text">Select the customer type for rate calculation</div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="consumptionTier">Consumption Tier <span class="required">*</span></label>
                        <select id="consumptionTier" name="consumptionTier" required>
                            <option value="LOW" ${consumptionTier == 'LOW' || empty consumptionTier ? 'selected' : ''}>Low Consumption</option>
                            <option value="MEDIUM" ${consumptionTier == 'MEDIUM' ? 'selected' : ''}>Medium Consumption</option>
                            <option value="HIGH" ${consumptionTier == 'HIGH' ? 'selected' : ''}>High Consumption</option>
                        </select>
                        <div class="help-text">Select the consumption tier for rate calculation</div>
                    </div>
                    
                    <div class="form-group">
                        <label>Calculated Unit Rate</label>
                        <input type="text" id="calculatedRate" readonly class="auto-calculated" />
                        <div class="help-text">Unit rate will be automatically calculated</div>
                    </div>
                </div>
                
                <div class="form-group full-width">
                    <label for="address">Billing Address</label>
                    <textarea id="address" name="address" 
                              placeholder="Enter complete billing address (optional)">${address}</textarea>
                    <div class="help-text">Provide the customer's billing address for invoice generation</div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="isActive">Status</label>
                        <select id="isActive" name="isActive">
                            <option value="true" ${isActive == 'true' || empty isActive ? 'selected' : ''}>Active</option>
                            <option value="false" ${isActive == 'false' ? 'selected' : ''}>Inactive</option>
                        </select>
                        <div class="help-text">Active customers can receive bills and access their dashboard</div>
                    </div>
                    
                    <div class="form-group">
                        <label>Account Number</label>
                        <input type="text" value="Auto-generated" readonly class="auto-calculated" />
                        <div class="help-text">Account number will be automatically generated</div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/customers/" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn">Create Customer</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            const customerTypeSelect = document.getElementById('customerType');
            const consumptionTierSelect = document.getElementById('consumptionTier');
            const calculatedRateInput = document.getElementById('calculatedRate');
            
            // Function to calculate unit rate
            function calculateUnitRate() {
                const customerType = customerTypeSelect.value;
                const consumptionTier = consumptionTierSelect.value;
                
                let baseRate = 0;
                
                // Base rates by customer type
                switch (customerType) {
                    case 'RESIDENTIAL':
                        baseRate = 0.12;
                        break;
                    case 'COMMERCIAL':
                        baseRate = 0.18;
                        break;
                    case 'INDUSTRIAL':
                        baseRate = 0.25;
                        break;
                    default:
                        baseRate = 0.12;
                }
                
                // Apply consumption tier multiplier
                let finalRate = baseRate;
                switch (consumptionTier) {
                    case 'LOW':
                        finalRate = baseRate * 0.9; // 10% discount
                        break;
                    case 'MEDIUM':
                        finalRate = baseRate; // Standard rate
                        break;
                    case 'HIGH':
                        finalRate = baseRate * 1.15; // 15% premium
                        break;
                    default:
                        finalRate = baseRate;
                }
                
                // Round to 2 decimal places
                finalRate = Math.round(finalRate * 100) / 100;
                calculatedRateInput.value = '$' + finalRate.toFixed(2) + ' per unit';
                // Set hidden input for backend
                document.getElementById('unitRate').value = finalRate;
            }
            
            // Calculate rate when selections change
            customerTypeSelect.addEventListener('change', calculateUnitRate);
            consumptionTierSelect.addEventListener('change', calculateUnitRate);
            
            // Calculate initial rate
            calculateUnitRate();
            
            // Validate form before submit
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                const name = document.getElementById('name').value.trim();
                const email = document.getElementById('email').value.trim();
                
                if (!name) {
                    e.preventDefault();
                    alert('Please enter the customer name.');
                    return;
                }
                
                if (!email) {
                    e.preventDefault();
                    alert('Please enter a valid email address.');
                    return;
                }
                
                // Basic email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    e.preventDefault();
                    alert('Please enter a valid email address.');
                    return;
                }
            });
            
            // Auto-focus on name field
            document.getElementById('name').focus();
        });
    </script>
</body>
</html> 