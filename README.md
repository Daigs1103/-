# 校园二手交易平台 - 微服务项目

## 项目概述

一个基于微服务架构的校园二手交易平台，支持用户注册、物品发布、交易管理、评价系统等功能。

## 技术栈

- **后端框架**: Spring Boot 3.0+
- **消息队列**: RabbitMQ / Kafka
- **缓存**: Redis
- **数据库**: MySQL + MongoDB
- **服务治理**: Nacos
- **API网关**: Spring Cloud Gateway
- **负载均衡**: Ribbon / LoadBalancer
- **链路追踪**: Skywalking / Jaeger
- **容器化**: Docker + Docker Compose

## 微服务架构

```
┌─────────────────────────────────────────────────────┐
│                   API Gateway                       │
└──────────────────────┬──────────────────────────────┘
         ┌─────────────┼─────────────┬─────────────┐
         │             │             │             │
    ┌────▼────┐ ┌─────▼────┐ ┌─────▼────┐ ┌─────▼────┐
    │  User   │ │ Product  │ │ Order    │ │ Comment  │
    │ Service │ │ Service  │ │ Service  │ │ Service  │
    └─────────┘ └──────────┘ └──────────┘ └──────────┘
         │            │             │             │
    ┌────▼────────────▼─────────────▼─────────────▼──┐
    │              Nacos Registry                     │
    └──────────────────────────────────────────────────┘
```

## 项目结构

```
campus-trade-platform/
├── gateway-service/              # API 网关服务
├── user-service/                 # 用户服务
├── product-service/              # 商品服务
├── order-service/                # 订单服务
├── comment-service/              # 评价服务
├── notification-service/         # 通知服务
├── common/                        # 公共模块
│   ├── common-api/               # 通用 API
│   └── common-utils/             # 工具类
├── docker-compose.yml            # 容器编排
└── pom.xml                        # 父项目 POM
```

## 核心功能

### 1. 用户服务 (User Service)
- 用户注册/登录
- 个人信息管理
- 身份认证
- 用户等级/信用评分

### 2. 商品服务 (Product Service)
- 商品发布/编辑/删除
- 商品搜索/分类浏览
- 商品详情展示
- 图片上传管理

### 3. 订单服务 (Order Service)
- 订单创建/支付/发货/确认收货
- 订单查询/跟踪
- 交易超时处理
- 退款/售后处理

### 4. 评价服务 (Comment Service)
- 交易完成后评价
- 评价列表展示
- 评价统计分析
- 不良评价处理

### 5. 通知服务 (Notification Service)
- 订单提醒
- 信息推送
- 邮件/短信通知

## 快速开始

### 前置条件
- Java 11+
- Maven 3.6+
- Docker & Docker Compose
- MySQL 5.7+
- Redis 6.0+

### 启动服务

```bash
# 克隆项目
git clone https://github.com/Daigs1103/-.git
cd campus-trade-platform

# 使用 Docker Compose 启动所有依赖服务
docker-compose up -d

# 编译打包
mvn clean package -DskipTests

# 启动各个微服务（可使用 IDE 或命令行）
cd user-service && mvn spring-boot:run
cd product-service && mvn spring-boot:run
cd order-service && mvn spring-boot:run
# ... 其他服务
```

## API 文档

- **API 网关地址**: http://localhost:9999
- **Swagger UI**: http://localhost:9999/swagger-ui.html
- **Nacos 控制台**: http://localhost:8848/nacos

## 配置说明

### 数据库配置
见各服务的 `application.yml` 配置文件

### Redis 配置
用于缓存、分布式锁、Session 管理

### 消息队列配置
用于异步处理订单、通知等消息

## 开发规范

- RESTful API 设计规范
- 统一的异常处理和返回结果格式
- 服务间通信使用 Feign Client
- 使用 Spring Cloud 提供的负载均衡和熔断机制
- 数据库操作使用 MyBatis-Plus

## 监控告警

- 使用 Skywalking 进行链路追踪
- 使用 Prometheus + Grafana 监控指标
- 使用 ELK Stack 进行日志聚合分析

## 常见问题

Q: 如何添加新的微服务？
A: 在 pom.xml 中添加 module，参考现有服务的结构创建即可

Q: 如何进行分布式事务处理？
A: 使用 Seata 框架进行分布式事务管理

## 许可证

MIT License

## 联系方式

- GitHub: [@Daigs1103](https://github.com/Daigs1103)
