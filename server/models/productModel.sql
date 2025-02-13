CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image TEXT[], 
    unit VARCHAR(50) DEFAULT '',
    stock INTEGER DEFAULT NULL,
    price NUMERIC DEFAULT NULL,
    discount NUMERIC DEFAULT NULL,
    description TEXT DEFAULT '',
    more_details JSONB DEFAULT '{}'::JSONB,
    publish BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Many-to-Many Relationship Tables
CREATE TABLE product_category (
    product_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);

CREATE TABLE product_sub_category (
    product_id INTEGER NOT NULL,
    sub_category_id INTEGER NOT NULL,
    PRIMARY KEY (product_id, sub_category_id),
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (sub_category_id) REFERENCES sub_category(id) ON DELETE CASCADE
);

-- Full-Text Search Index for Name and Description
CREATE INDEX product_text_search_idx ON product USING GIN (to_tsvector('english', name || ' ' || description));
