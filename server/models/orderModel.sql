CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    order_id VARCHAR(255) UNIQUE NOT NULL,
    product_id INTEGER REFERENCES products(id),
    product_name VARCHAR(255),
    product_image TEXT[],
    payment_id VARCHAR(255) DEFAULT '',
    payment_status VARCHAR(255) DEFAULT '',
    delivery_address_id INTEGER REFERENCES addresses(id),
    subtotal_amount NUMERIC DEFAULT 0,
    total_amount NUMERIC DEFAULT 0,
    invoice_receipt TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
