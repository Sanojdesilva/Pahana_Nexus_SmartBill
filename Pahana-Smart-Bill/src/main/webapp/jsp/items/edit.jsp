<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Item - Pahana Smart Bill</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; color: #333; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { font-size: 1.5rem; }
        .nav-links { display: flex; gap: 1rem; }
        .nav-links a { color: white; text-decoration: none; padding: 0.5rem 1rem; border-radius: 5px; transition: background 0.3s; }
        .nav-links a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 800px; margin: 0 auto; padding: 2rem; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
        .page-header h2 { color: #333; font-size: 1.8rem; }
        .btn { background: #667eea; color: white; padding: 0.75rem 1.5rem; border: none; border-radius: 5px; text-decoration: none; display: inline-block; cursor: pointer; transition: background 0.3s; font-size: 1rem; }
        .btn:hover { background: #5a6fd8; }
        .btn-secondary { background: #6c757d; }
        .btn-secondary:hover { background: #5a6268; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .form-container { background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); padding: 2rem; margin-bottom: 2rem; }
        .form-header { background: #f8f9fa; padding: 1rem; border-radius: 5px; margin-bottom: 2rem; border-left: 4px solid #667eea; }
        .form-header h3 { margin: 0; color: #333; font-size: 1.2rem; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group.full-width { grid-column: 1 / -1; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: bold; color: #333; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 5px; font-size: 1rem; transition: border-color 0.3s; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 2px rgba(102,126,234,0.2); }
        .form-group textarea { resize: vertical; min-height: 80px; }
        .required { color: #dc3545; font-weight: bold; }
        .form-actions { display: flex; gap: 1rem; justify-content: flex-end; padding-top: 1rem; border-top: 1px solid #eee; margin-top: 2rem; }
        .error { background: #fee; color: #c33; padding: 1rem; border-radius: 5px; margin-bottom: 1rem; border: 1px solid #fcc; }
        .success { background: #efe; color: #3c3; padding: 1rem; border-radius: 5px; margin-bottom: 1rem; border: 1px solid #cfc; }
        @media (max-width: 768px) { .form-row { grid-template-columns: 1fr; } .form-actions { flex-direction: column; } .nav-links { flex-direction: column; gap: 0.5rem; } }
    </style>
</head>
<body>
    <div class="header">
        <h1>Edit Item</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/items/">Items</a>
            <a href="${pageContext.request.contextPath}/customers/">Customers</a>
            <a href="${pageContext.request.contextPath}/bills/">Bills</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    <div class="container">
        <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
        <c:if test="${not empty message}"><div class="success">${message}</div></c:if>
        <div class="page-header">
            <h2>Edit Item</h2>
            <a href="${pageContext.request.contextPath}/items/" class="btn btn-secondary">Back to Items</a>
        </div>
        <c:if test="${not empty item}">
            <div class="form-container">
                <div class="form-header"><h3>Item Information</h3></div>
                <form method="post" action="${pageContext.request.contextPath}/items/">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" value="${item.id}" />
                    <div class="form-row">
                        <div class="form-group">
                            <label for="code">Item Code <span class="required">*</span></label>
                            <input type="text" id="code" name="code" value="${item.code}" required maxlength="50" readonly class="readonly" />
                            <div class="help-text">Item code cannot be changed</div>
                        </div>
                        <div class="form-group">
                            <label for="name">Name <span class="required">*</span></label>
                            <input type="text" id="name" name="name" value="${item.name}" required maxlength="100" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <select id="category" name="category">
                                <option value="FICTION" ${item.category == 'FICTION' ? 'selected' : ''}>Fiction</option>
                                <option value="NONFICTION" ${item.category == 'NONFICTION' ? 'selected' : ''}>Non-Fiction</option>
                                <option value="CHILDREN" ${item.category == 'CHILDREN' ? 'selected' : ''}>Children’s Books</option>
                                <option value="EDUCATIONAL" ${item.category == 'EDUCATIONAL' ? 'selected' : ''}>Educational</option>
                                <option value="STATIONERY" ${item.category == 'STATIONERY' ? 'selected' : ''}>Stationery</option>
                                <option value="MAGAZINES" ${item.category == 'MAGAZINES' ? 'selected' : ''}>Magazines</option>
                                <option value="COMICS" ${item.category == 'COMICS' ? 'selected' : ''}>Comics & Graphic Novels</option>
                                <option value="REFERENCE" ${item.category == 'REFERENCE' ? 'selected' : ''}>Reference</option>
                                <option value="ART" ${item.category == 'ART' ? 'selected' : ''}>Art & Photography</option>
                                <option value="SCIENCE" ${item.category == 'SCIENCE' ? 'selected' : ''}>Science & Technology</option>
                                <option value="RELIGION" ${item.category == 'RELIGION' ? 'selected' : ''}>Religion & Spirituality</option>
                                <option value="BIOGRAPHY" ${item.category == 'BIOGRAPHY' ? 'selected' : ''}>Biographies</option>
                                <option value="HISTORY" ${item.category == 'HISTORY' ? 'selected' : ''}>History</option>
                                <option value="MYSTERY" ${item.category == 'MYSTERY' ? 'selected' : ''}>Mystery & Thriller</option>
                                <option value="ROMANCE" ${item.category == 'ROMANCE' ? 'selected' : ''}>Romance</option>
                                <option value="FANTASY" ${item.category == 'FANTASY' ? 'selected' : ''}>Fantasy & Sci-Fi</option>
                                <option value="SELFHELP" ${item.category == 'SELFHELP' ? 'selected' : ''}>Self-Help</option>
                                <option value="BUSINESS" ${item.category == 'BUSINESS' ? 'selected' : ''}>Business & Economics</option>
                                <option value="OTHER" ${item.category == 'OTHER' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="price">Price <span class="required">*</span></label>
                            <input type="number" step="0.01" min="0" id="price" name="price" value="${item.price}" required />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="stockQuantity">Stock Quantity <span class="required">*</span></label>
                            <input type="number" min="0" id="stockQuantity" name="stockQuantity" value="${item.stockQuantity}" required />
                        </div>
                        <div class="form-group">
                            <label for="active">Status</label>
                            <select id="active" name="active">
                                <option value="true" ${item.active ? 'selected' : ''}>Active</option>
                                <option value="false" ${!item.active ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group full-width">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" maxlength="500">${item.description}</textarea>
                    </div>
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/items/" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn">Update Item</button>
                    </div>
                </form>
            </div>
        </c:if>
        <c:if test="${empty item}">
            <div class="form-container">
                <div style="text-align: center; padding: 3rem;">
                    <h3>Item Not Found</h3>
                    <p>The requested item could not be found.</p>
                    <a href="${pageContext.request.contextPath}/items/" class="btn btn-secondary">Back to Items</a>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html> 