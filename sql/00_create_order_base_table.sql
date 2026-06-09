CREATE DATABASE IF NOT EXISTS olist
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE olist;

CREATE TABLE IF NOT EXISTS order_base (
    order_id VARCHAR(32) NOT NULL,
    customer_id VARCHAR(32),
    order_status VARCHAR(32),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATE,
    delivery_days DECIMAL(10, 2),
    delay_days DECIMAL(10, 2),
    is_delivered BOOLEAN,
    is_late BOOLEAN,
    customer_unique_id VARCHAR(32),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(128),
    customer_state VARCHAR(8),
    review_score DECIMAL(3, 1),
    review_count DECIMAL(10, 1),
    payment_total DECIMAL(12, 2),
    payment_count DECIMAL(10, 1),
    payment_installments_max DECIMAL(10, 1),
    payment_type_count DECIMAL(10, 1),
    main_payment_type VARCHAR(32),
    item_count DECIMAL(10, 1),
    product_count DECIMAL(10, 1),
    seller_count DECIMAL(10, 1),
    price_total DECIMAL(12, 2),
    freight_total DECIMAL(12, 2),
    PRIMARY KEY (order_id),
    INDEX idx_order_status (order_status),
    INDEX idx_customer_state (customer_state),
    INDEX idx_is_late (is_late),
    INDEX idx_purchase_time (order_purchase_timestamp)
);
