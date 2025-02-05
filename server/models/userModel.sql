-- Step 1: Create ENUM Type for Status
CREATE TYPE user_status AS ENUM ('Active', 'Inactive', 'Suspended');

-- Step 2: Create Address Table
CREATE TABLE "public"."Address" (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INTEGER NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "public"."User"(id) ON DELETE CASCADE
);

CREATE TABLE "public"."CartProduct" (
    id SERIAL PRIMARY KEY NOT NULL,
    product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "public"."User"(id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES "public"."Product"(id) ON DELETE CASCADE
);

-- Step 3: Create User Table with Foreign Key for Address
CREATE TABLE "public"."User" (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) DEFAULT NULL,
    mobile BIGINT DEFAULT NULL,
    refreshToken VARCHAR(255) DEFAULT NULL,
    verifyEmail BOOLEAN DEFAULT FALSE,
    lastLoginDate DATE DEFAULT NULL,
    status user_status DEFAULT 'Active',
    address_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_address FOREIGN KEY (address_id) REFERENCES "public"."Address"(id) ON DELETE SET NULL
);
