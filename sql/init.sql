-- 创建数据库
CREATE DATABASE IF NOT EXISTS campus_trade DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE campus_trade;

-- 用户表
CREATE TABLE t_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    real_name VARCHAR(100),
    status VARCHAR(50) DEFAULT 'ACTIVE',
    credit_score INT DEFAULT 100,
    avg_rating DOUBLE DEFAULT 5.0,
    total_orders INT DEFAULT 0,
    avatar VARCHAR(500),
    introduction VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 商品表
CREATE TABLE t_product (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    status VARCHAR(50) DEFAULT 'ACTIVE',
    views INT DEFAULT 0,
    likes INT DEFAULT 0,
    image_url VARCHAR(500),
    `condition` VARCHAR(50),
    location VARCHAR(100),
    tags VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    sold_at TIMESTAMP,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 订单表
CREATE TABLE t_order (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_number VARCHAR(100) UNIQUE NOT NULL,
    buyer_id BIGINT NOT NULL,
    seller_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    price DECIMAL(10, 2),
    status VARCHAR(50) DEFAULT 'PENDING',
    payment_method VARCHAR(50),
    delivery_address VARCHAR(500),
    remark TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    paid_at TIMESTAMP,
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP,
    INDEX idx_buyer_id (buyer_id),
    INDEX idx_seller_id (seller_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 评价表
CREATE TABLE t_comment (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    commenter_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    rating INT NOT NULL,
    content TEXT,
    type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_order_id (order_id),
    INDEX idx_receiver_id (receiver_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 通知表
CREATE TABLE t_notification (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(255),
    content TEXT,
    type VARCHAR(50),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP,
    INDEX idx_user_id (user_id),
    INDEX idx_is_read (is_read)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Nacos 配置中心数据库（可选）
-- 以下脚本来自 Nacos 官方文档
CREATE TABLE IF NOT EXISTS config_info (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'id',
    data_id VARCHAR(255) NOT NULL COMMENT 'data_id',
    group_id VARCHAR(255) DEFAULT NULL COMMENT 'group_id',
    content LONGTEXT NOT NULL COMMENT 'content',
    md5 VARCHAR(32) DEFAULT NULL COMMENT 'md5',
    gmt_create BIGINT NOT NULL DEFAULT 0 COMMENT '创建时间',
    gmt_modified BIGINT NOT NULL DEFAULT 0 COMMENT '修改时间',
    src_user LONGTEXT COMMENT 'src_user',
    src_ip VARCHAR(50) DEFAULT NULL COMMENT 'src_ip',
    app_name VARCHAR(128) DEFAULT NULL COMMENT 'app_name',
    tenant_id VARCHAR(128) DEFAULT '' COMMENT '租户字段',
    c_desc VARCHAR(256) DEFAULT NULL COMMENT 'c_desc',
    c_use VARCHAR(64) DEFAULT NULL COMMENT 'c_use',
    effect VARCHAR(64) DEFAULT NULL COMMENT 'effect',
    type VARCHAR(64) DEFAULT NULL COMMENT 'type',
    c_schema LONGTEXT COMMENT 'c_schema',
    encrypted_data_key TEXT COMMENT 'encrypted_data_key',
    UNIQUE KEY uk_configinfoitem (data_id, group_id, tenant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';

CREATE TABLE IF NOT EXISTS config_info_aggr (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'id',
    data_id VARCHAR(255) NOT NULL COMMENT 'data_id',
    group_id VARCHAR(255) NOT NULL COMMENT 'group_id',
    datum_id VARCHAR(255) NOT NULL COMMENT 'datum_id',
    content LONGTEXT NOT NULL COMMENT 'content',
    gmt_create BIGINT NOT NULL DEFAULT 0 COMMENT '创建时间',
    gmt_modified BIGINT NOT NULL DEFAULT 0 COMMENT '修改时间',
    tenant_id VARCHAR(128) DEFAULT '' COMMENT '租户字段',
    UNIQUE KEY uk_configinfoaggr (data_id, group_id, tenant_id, datum_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_aggr';
