<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Bill - Pahana Smart Bill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-theme.css">
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
            max-width: 1200px;
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
        
        .btn-success {
            background: #28a745;
        }
        
        .btn-success:hover {
            background: #218838;
        }
        
        .btn-danger {
            background: #dc3545;
        }
        
        .btn-danger:hover {
            background: #c82333;
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
        
        .items-section {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin: 2rem 0;
        }
        
        .items-section h4 {
            margin-bottom: 1rem;
            color: #333;
        }
        
        .item-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr 1fr auto;
            gap: 1rem;
            align-items: center;
            padding: 1rem;
            background: white;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #dee2e6;
        }
        
        .item-row.header {
            background: #667eea;
            color: white;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .item-row.header span {
            color: white;
        }
        
        .item-select {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        
        .quantity-input {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 3px;
            text-align: center;
        }
        
        .price-display {
            background: #f8f9fa;
            padding: 0.5rem;
            border-radius: 3px;
            text-align: center;
            font-weight: bold;
        }
        
        .total-display {
            background: #e8f5e8;
            padding: 0.5rem;
            border-radius: 3px;
            text-align: center;
            font-weight: bold;
            color: #2e7d32;
        }
        
        .stock-display {
            background: #f8f9fa;
            padding: 0.5rem;
            border-radius: 3px;
            text-align: center;
            font-weight: bold;
        }
        
        .stock-warning {
            color: #dc3545;
            font-size: 0.8rem;
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
        
        .add-item-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 3px;
            cursor: pointer;
            margin-top: 1rem;
        }
        
        .add-item-btn:hover {
            background: #218838;
        }
        
        .remove-item-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 0.25rem 0.5rem;
            border-radius: 3px;
            cursor: pointer;
        }
        
        .remove-item-btn:hover {
            background: #c82333;
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
            
            .item-row {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }
            
            .item-row.header {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Create New Bill</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/customers/">Customers</a>
            <a href="${pageContext.request.contextPath}/bills">Bills</a>
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
            <h2>Create New Bill</h2>
            <a href="${pageContext.request.contextPath}/bills" class="btn btn-secondary">Back to Bills</a>
        </div>
        <!-- Bill Creation Form -->
        <form method="post" action="${pageContext.request.contextPath}/bills">
            <input type="hidden" name="action" value="create" />
            <div class="form-container">
                <div class="form-header"><h3>Bill Information</h3></div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="customerId">Customer <span class="required">*</span></label>
                        <select id="customerId" name="customerId" required>
                            <option value="">Select a customer</option>
                            <c:forEach var="customer" items="${customers}">
                                <option value="${customer.id}" ${customerId == customer.id ? 'selected' : ''}>
                                    ${customer.name} (${customer.accountNumber})
                                </option>
                            </c:forEach>
                        </select>
                        <div class="help-text">Select the customer for this bill</div>
                    </div>
                    <div class="form-group">
                        <label for="status">Status <span class="required">*</span></label>
                        <select id="status" name="status" required>
                            <option value="DRAFT" ${status == 'DRAFT' || empty status ? 'selected' : ''}>Draft</option>
                            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>Pending</option>
                            <option value="PAID" ${status == 'PAID' ? 'selected' : ''}>Paid</option>
                            <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                        </select>
                        <div class="help-text">Set the current status of the bill</div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="dueDate">Due Date <span class="required">*</span></label>
                        <input type="date" id="dueDate" name="dueDate" required value="${dueDate}" />
                        <div class="help-text">Set the due date for payment</div>
                    </div>
                    <div class="form-group">
                        <label for="paymentMethod">Payment Method</label>
                        <select id="paymentMethod" name="paymentMethod">
                            <option value="CASH" ${paymentMethod == 'CASH' || empty paymentMethod ? 'selected' : ''}>Cash</option>
                            <option value="CARD" ${paymentMethod == 'CARD' ? 'selected' : ''}>Card</option>
                            <option value="BANK_TRANSFER" ${paymentMethod == 'BANK_TRANSFER' ? 'selected' : ''}>Bank Transfer</option>
                            <option value="CHECK" ${paymentMethod == 'CHECK' ? 'selected' : ''}>Check</option>
                        </select>
                        <div class="help-text">Select the payment method</div>
                    </div>
                </div>
                <div class="form-group full-width">
                    <label for="notes">Notes</label>
                    <textarea id="notes" name="notes" placeholder="Enter any additional notes or comments">${notes}</textarea>
                    <div class="help-text">Add any additional information about this bill</div>
                </div>
            </div>
            <div class="form-container">
                <div class="form-header"><h3>Bill Items</h3></div>
                <div class="items-section">
                    <h4>Select Items for this Bill</h4>
                    <div class="item-row header">
                        <span>Item</span>
                        <span>Quantity</span>
                        <span>Unit Price</span>
                        <span>Total</span>
                        <span>Stock</span>
                        <span>Action</span>
                    </div>
                    <div id="itemsContainer">
                        <!-- Initial item row -->
                        <div class="item-row" id="item-row-0">
                            <div>
                                <select class="item-select" name="itemIds[]" onchange="updateItemPrice(0)" required>
                                    <option value="">Select Item</option>
                                    <c:forEach var="item" items="${items}">
                                        <option value="${item.id}" data-price="${item.price}" data-stock="${item.stockQuantity}" data-category="${item.category}">
                                            ${item.code} - ${item.name} (Stock: ${item.stockQuantity})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <input type="number" class="quantity-input" name="quantities[]" min="1" value="1" onchange="updateItemTotal(0)" required />
                            </div>
                            <div>
                                <div class="price-display" id="price-0">$0.00</div>
                            </div>
                            <div>
                                <div class="total-display" id="total-0">$0.00</div>
                            </div>
                            <div>
                                <div class="stock-display" id="stock-0">0</div>
                            </div>
                            <div>
                                <button type="button" class="remove-item-btn" onclick="removeItemRow(0)" style="display: none;">Remove</button>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="add-item-btn" onclick="addItemRow()">+ Add Item</button>
                </div>
                <div class="calculation-summary">
                    <h4>Bill Calculation Summary</h4>
                    <div class="calculation-row">
                        <span>Subtotal:</span>
                        <span id="displaySubtotal">$0.00</span>
                    </div>
                    <div class="calculation-row">
                        <span>Tax (15%):</span>
                        <span id="displayTax">$0.00</span>
                    </div>
                    <div class="calculation-row">
                        <span>Total Amount:</span>
                        <span id="displayTotal">$0.00</span>
                    </div>
                </div>
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/bills" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-success">Create Bill</button>
                </div>
            </div>
        </form>
    </div>
    <script>
        let itemRowCount = 1;
        
        function addItemRow() {
            const container = document.getElementById('itemsContainer');
            const newRow = document.createElement('div');
            newRow.className = 'item-row';
            newRow.id = 'item-row-' + itemRowCount;
            
            newRow.innerHTML = `
                <div>
                    <select class="item-select" name="itemIds[]" onchange="updateItemPrice(${itemRowCount})" required>
                        <option value="">Select Item</option>
                        <c:forEach var="item" items="${items}">
                            <option value="${item.id}" data-price="${item.price}" data-stock="${item.stockQuantity}" data-category="${item.category}">
                                ${item.code} - ${item.name} (Stock: ${item.stockQuantity})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <input type="number" class="quantity-input" name="quantities[]" min="1" value="1" onchange="updateItemTotal(${itemRowCount})" required />
                </div>
                <div>
                    <div class="price-display" id="price-${itemRowCount}">$0.00</div>
                </div>
                <div>
                    <div class="total-display" id="total-${itemRowCount}">$0.00</div>
                </div>
                <div>
                    <div class="stock-display" id="stock-${itemRowCount}">0</div>
                </div>
                <div>
                    <button type="button" class="remove-item-btn" onclick="removeItemRow(${itemRowCount})">Remove</button>
                </div>
            `;
            
            container.appendChild(newRow);
            itemRowCount++;
        }
        
        function removeItemRow(rowIndex) {
            const row = document.getElementById('item-row-' + rowIndex);
            if (row) {
                row.remove();
                updateTotals();
            }
        }
        
        function updateItemPrice(rowIndex) {
            const select = document.querySelector('#item-row-' + rowIndex + ' .item-select');
            const priceDisplay = document.getElementById('price-' + rowIndex);
            const stockDisplay = document.getElementById('stock-' + rowIndex);
            const quantityInput = document.querySelector('#item-row-' + rowIndex + ' .quantity-input');
            
            if (select.value) {
                const selectedOption = select.options[select.selectedIndex];
                const price = parseFloat(selectedOption.getAttribute('data-price'));
                const stock = parseInt(selectedOption.getAttribute('data-stock'));
                
                priceDisplay.textContent = '$' + price.toFixed(2);
                stockDisplay.textContent = stock;
                
                // Update quantity max value
                quantityInput.max = stock;
                
                updateItemTotal(rowIndex);
            } else {
                priceDisplay.textContent = '$0.00';
                stockDisplay.textContent = '0';
                updateItemTotal(rowIndex);
            }
        }
        
        function updateItemTotal(rowIndex) {
            const priceDisplay = document.getElementById('price-' + rowIndex);
            const totalDisplay = document.getElementById('total-' + rowIndex);
            const quantityInput = document.querySelector('#item-row-' + rowIndex + ' .quantity-input');
            
            const price = parseFloat(priceDisplay.textContent.replace('$', ''));
            const quantity = parseInt(quantityInput.value) || 0;
            const total = price * quantity;
            
            totalDisplay.textContent = '$' + total.toFixed(2);
            updateTotals();
        }
        
        function updateTotals() {
            let subtotal = 0;
            
            // Calculate subtotal from all item rows
            const totalDisplays = document.querySelectorAll('.total-display');
            totalDisplays.forEach(display => {
                const total = parseFloat(display.textContent.replace('$', '')) || 0;
                subtotal += total;
            });
            
            const tax = subtotal * 0.15; // 15% tax
            const total = subtotal + tax;
            
            document.getElementById('displaySubtotal').textContent = '$' + subtotal.toFixed(2);
            document.getElementById('displayTax').textContent = '$' + tax.toFixed(2);
            document.getElementById('displayTotal').textContent = '$' + total.toFixed(2);
        }
        
        // Initialize totals on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateTotals();
        });
    </script>
</body>
</html> 