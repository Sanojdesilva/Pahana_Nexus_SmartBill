<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Item - Pahana Smart Bill</title>
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
        
        .code-info {
            background: #e8f5e8;
            border: 1px solid #4caf50;
            border-radius: 5px;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        
        .code-info h4 {
            color: #2e7d32;
            margin-bottom: 0.5rem;
        }
        
        .code-info ul {
            margin: 0;
            padding-left: 1.5rem;
        }
        
        .code-info li {
            margin-bottom: 0.25rem;
        }
        
        .auto-calculated {
            background: #f8f9fa;
            color: #6c757d;
            border: 1px solid #dee2e6;
        }
        
        .category-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 0.5rem;
            margin-top: 0.5rem;
        }
        
        .category-option {
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 3px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .category-option:hover {
            background: #f8f9fa;
            border-color: #667eea;
        }
        
        .category-option.selected {
            background: #667eea;
            color: white;
            border-color: #667eea;
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
        <h1>Add New Item</h1>
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
            <h2>Create New Item</h2>
            <a href="${pageContext.request.contextPath}/items/" class="btn btn-secondary">Back to Items</a>
        </div>
        
        <div class="form-container">
            <div class="form-header">
                <h3>Item Information</h3>
            </div>
            
            <div class="code-info">
                <h4>Automatic Item Code Generation</h4>
                <p>Item codes are automatically generated based on category:</p>
                <ul>
                    <li><strong>Fiction:</strong> FIC + timestamp + random</li>
                    <li><strong>Non-Fiction:</strong> NF + timestamp + random</li>
                    <li><strong>Children’s Books:</strong> CHD + timestamp + random</li>
                    <li><strong>Educational:</strong> EDU + timestamp + random</li>
                    <li><strong>Stationery:</strong> STN + timestamp + random</li>
                    <li><strong>Science & Technology:</strong> SCI + timestamp + random</li>
                    <li><strong>Religion & Spirituality:</strong> REL + timestamp + random</li>
                </ul>
            </div>
            
            <form method="post" action="${pageContext.request.contextPath}/items">
                <input type="hidden" name="action" value="create" />
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Item Code</label>
                        <input type="text" id="code" name="code" readonly class="auto-calculated" />
                        <div class="help-text">Item code will be automatically generated</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="name">Item Name <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required value="${param.name}" 
                               placeholder="e.g., Electricity Unit" maxlength="100" />
                        <div class="help-text">Enter the item name (max 100 characters)</div>
                    </div>
                </div>
                
                <div class="form-group full-width">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" 
                              placeholder="Enter item description (optional)">${param.description}</textarea>
                    <div class="help-text">Provide a detailed description of the item</div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="category">Category <span class="required">*</span></label>
                        <select id="category" name="category" required>
                            <option value="">Select Category</option>
                            <option value="FICTION" ${param.category == 'FICTION' ? 'selected' : ''}>Fiction</option>
                            <option value="NONFICTION" ${param.category == 'NONFICTION' ? 'selected' : ''}>Non-Fiction</option>
                            <option value="CHILDREN" ${param.category == 'CHILDREN' ? 'selected' : ''}>Children’s Books</option>
                            <option value="EDUCATIONAL" ${param.category == 'EDUCATIONAL' ? 'selected' : ''}>Educational</option>
                            <option value="STATIONERY" ${param.category == 'STATIONERY' ? 'selected' : ''}>Stationery</option>
                            <option value="MAGAZINES" ${param.category == 'MAGAZINES' ? 'selected' : ''}>Magazines</option>
                            <option value="COMICS" ${param.category == 'COMICS' ? 'selected' : ''}>Comics & Graphic Novels</option>
                            <option value="REFERENCE" ${param.category == 'REFERENCE' ? 'selected' : ''}>Reference</option>
                            <option value="ART" ${param.category == 'ART' ? 'selected' : ''}>Art & Photography</option>
                            <option value="SCIENCE" ${param.category == 'SCIENCE' ? 'selected' : ''}>Science & Technology</option>
                            <option value="RELIGION" ${param.category == 'RELIGION' ? 'selected' : ''}>Religion & Spirituality</option>
                            <option value="BIOGRAPHY" ${param.category == 'BIOGRAPHY' ? 'selected' : ''}>Biographies</option>
                            <option value="HISTORY" ${param.category == 'HISTORY' ? 'selected' : ''}>History</option>
                            <option value="MYSTERY" ${param.category == 'MYSTERY' ? 'selected' : ''}>Mystery & Thriller</option>
                            <option value="ROMANCE" ${param.category == 'ROMANCE' ? 'selected' : ''}>Romance</option>
                            <option value="FANTASY" ${param.category == 'FANTASY' ? 'selected' : ''}>Fantasy & Sci-Fi</option>
                            <option value="SELFHELP" ${param.category == 'SELFHELP' ? 'selected' : ''}>Self-Help</option>
                            <option value="BUSINESS" ${param.category == 'BUSINESS' ? 'selected' : ''}>Business & Economics</option>
                            <option value="OTHER" ${param.category == 'OTHER' ? 'selected' : ''}>Other</option>
                        </select>
                        <div class="help-text">Choose the appropriate category for the item</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="price">Price <span class="required">*</span></label>
                        <input type="number" id="price" name="price" step="0.01" min="0" required 
                               value="${param.price}" placeholder="0.00" />
                        <div class="help-text">Enter the price in dollars (e.g., 25.50)</div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="stockQuantity">Stock Quantity <span class="required">*</span></label>
                        <input type="number" id="stockQuantity" name="stockQuantity" min="0" required 
                               value="${param.stockQuantity}" placeholder="0" />
                        <div class="help-text">Enter the available stock quantity</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="reorderLevel">Reorder Level</label>
                        <input type="number" id="reorderLevel" name="reorderLevel" min="0" 
                               value="${param.reorderLevel}" placeholder="10" />
                        <div class="help-text">Stock level at which to reorder (default: 10)</div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="supplierInfo">Supplier Information</label>
                        <input type="text" id="supplierInfo" name="supplierInfo" 
                               value="${param.supplierInfo}" placeholder="Supplier name and contact" />
                        <div class="help-text">Enter supplier details (optional)</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="active">Status</label>
                        <select id="active" name="active">
                            <option value="true" ${param.active == 'true' || empty param.active ? 'selected' : ''}>Active</option>
                            <option value="false" ${param.active == 'false' ? 'selected' : ''}>Inactive</option>
                        </select>
                        <div class="help-text">Set the item status (active items can be used in bills)</div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/items/" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn">Create Item</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            const categorySelect = document.getElementById('category');
            const codeInput = document.getElementById('code');
            const nameInput = document.getElementById('name');
            
            // Function to generate item code
            function generateItemCode() {
                const category = categorySelect.value;
                const name = nameInput.value;
                
                if (category && name) {
                    let prefix = '';
                    
                    // Generate prefix based on category
                    switch (category) {
                        case 'ELECTRICITY':
                            prefix = 'ELEC';
                            break;
                        case 'WATER':
                            prefix = 'WATER';
                            break;
                        case 'GAS':
                            prefix = 'GAS';
                            break;
                        case 'INTERNET':
                            prefix = 'NET';
                            break;
                        case 'TELEPHONE':
                            prefix = 'TEL';
                            break;
                        default:
                            prefix = 'ITEM';
                    }
                    
                    // Generate code with timestamp and random number
                    const timestamp = Date.now().toString();
                    const random = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
                    const code = prefix + timestamp.substring(timestamp.length - 6) + random;
                    
                    codeInput.value = code;
                }
            }
            
            // Generate code when category or name changes
            categorySelect.addEventListener('change', generateItemCode);
            nameInput.addEventListener('input', generateItemCode);
            
            // Format price input
            const priceInput = document.getElementById('price');
            priceInput.addEventListener('blur', function() {
                if (this.value) {
                    this.value = parseFloat(this.value).toFixed(2);
                }
            });
            
            // Validate form before submit
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                const name = nameInput.value.trim();
                const category = categorySelect.value;
                const price = parseFloat(priceInput.value);
                const stock = parseInt(document.getElementById('stockQuantity').value);
                
                if (!name || !category) {
                    e.preventDefault();
                    alert('Please fill in all required fields.');
                    return;
                }
                
                if (price < 0) {
                    e.preventDefault();
                    alert('Price cannot be negative.');
                    return;
                }
                
                if (stock < 0) {
                    e.preventDefault();
                    alert('Stock quantity cannot be negative.');
                    return;
                }
            });
            
            // Auto-focus on name field
            nameInput.focus();
        });
    </script>
</body>
</html> 