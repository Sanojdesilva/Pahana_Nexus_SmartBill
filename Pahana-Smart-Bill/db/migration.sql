-- Minimal migration script for smartbill database
USE smartbill;

SET FOREIGN_KEY_CHECKS = 0;

-- Update existing records to have proper default values
UPDATE customers SET customer_type = 'RESIDENTIAL' WHERE customer_type IS NULL;
UPDATE customers SET consumption_tier = 'LOW' WHERE consumption_tier IS NULL;
UPDATE customers SET unit_rate = 0.12 WHERE unit_rate = 0.00;

UPDATE items SET reorder_level = 10 WHERE reorder_level IS NULL;
UPDATE items SET category = 'OTHER' WHERE category IS NULL;
UPDATE items SET created_by = 'USR001' WHERE created_by IS NULL;

UPDATE bills SET status = 'DRAFT' WHERE status IS NULL;
UPDATE bills SET total = 0.00 WHERE total IS NULL;
UPDATE bills SET subtotal = 0.00 WHERE subtotal IS NULL;
UPDATE bills SET tax_amount = 0.00 WHERE tax_amount IS NULL;
UPDATE bills SET tax_rate = 0.00 WHERE tax_rate IS NULL;
UPDATE bills SET units_consumed = 0 WHERE units_consumed IS NULL;
UPDATE bills SET unit_rate = 0.00 WHERE unit_rate IS NULL;
UPDATE bills SET payment_method = 'CASH' WHERE payment_method IS NULL;

-- Update bill_items to have total_price calculated from quantity * unit_price
UPDATE bill_items SET total_price = quantity * unit_price WHERE total_price IS NULL OR total_price = 0;

SET FOREIGN_KEY_CHECKS = 1;

-- Insert default admin user if not exists
INSERT IGNORE INTO users (id, username, passwordHash, email, role, isActive, firstName, lastName, createdAt) VALUES
('USR001', 'admin', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'admin@pahana.com', 'ADMIN', TRUE, 'Admin', 'User', NOW());

-- Insert sample items if not exists
INSERT IGNORE INTO items (code, name, description, category, price, stock_quantity, reorder_level, is_active, created_at, created_by) VALUES
('ELEC001', 'Electricity Unit', 'Standard electricity consumption unit', 'ELECTRICITY', 0.15, 1000, 100, TRUE, NOW(), 'USR001'),
('WATER001', 'Water Unit', 'Standard water consumption unit', 'WATER', 0.08, 2000, 200, TRUE, NOW(), 'USR001'),
('GAS001', 'Gas Unit', 'Standard gas consumption unit', 'GAS', 0.12, 1500, 150, TRUE, NOW(), 'USR001'); 