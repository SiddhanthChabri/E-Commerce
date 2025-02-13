CREATE TABLE sub_category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) DEFAULT '',
    image TEXT DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE sub_category_category (
    sub_category_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (sub_category_id, category_id),
    FOREIGN KEY (sub_category_id) REFERENCES sub_category(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);
