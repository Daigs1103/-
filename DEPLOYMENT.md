# 部署指南

## 开发环境部署

### 1. 环境准备

- Java 11+
- Maven 3.6+
- Git
- Docker & Docker Compose（可选，用于快速启动依赖服务）

### 2. 克隆项目

```bash
git clone https://github.com/Daigs1103/-.git
cd campus-trade-platform
```

### 3. 启动依赖服务

使用 Docker Compose 快速启动所有依赖服务：

```bash
docker-compose up -d
```

这将启动：
- MySQL (3306)
- Redis (6379)
- RabbitMQ (5672, 15672)
- Nacos (8848, 9848)
- MongoDB (27017)
- Prometheus (9090)
- Grafana (3000)

### 4. 初始化数据库

```bash
# 登录 MySQL
mysql -h localhost -u root -p

# 输入密码: root@123
# 然后执行 sql/init.sql 中的 SQL 语句
```

或者使用命令行：

```bash
mysql -h localhost -u root -proot@123 < sql/init.sql
```

### 5. 编译项目

```bash
mvn clean package -DskipTests
```

### 6. 启动微服务

#### 方式一：使用 IDE（推荐开发阶段）

在 IDEA 中右键点击各个服务的 `xxxApplication` 类，选择 "Run" 或按 Shift+F10。

启动顺序建议：
1. gateway-service (9999)
2. user-service (8001)
3. product-service (8002)
4. order-service (8003)
5. comment-service (8004)
6. notification-service (8005)

#### 方式二：使用命令行

```bash
# 启动网关服务
cd gateway-service
mvn spring-boot:run

# 新开终端，启动用户服务
cd user-service
mvn spring-boot:run

# 启动其他服务...（同样方式）
```

#### 方式三：使用 Docker（生产环境）

```bash
# 为每个服务创建 Dockerfile（示例）
# 然后构建镜像和启动容器
docker build -t campus-user-service user-service/
docker run -d -p 8001:8001 --name user-service campus-user-service
```

## 验证部署

### 1. 检查 Nacos 服务注册

访问 http://localhost:8848/nacos，默认账密为 nacos/nacos

应该能看到已注册的服务：
- gateway-service
- user-service
- product-service
- order-service
- comment-service
- notification-service

### 2. 测试 API

```bash
# 用户注册
curl -X POST http://localhost:9999/api/users/register \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"123456","email":"test@example.com"}'

# 用户登录
curl -X POST http://localhost:9999/api/users/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"123456"}'
```

### 3. 查看 Swagger 文档

- 网关 Swagger: http://localhost:9999/swagger-ui.html
- 用户服务 Swagger: http://localhost:8001/swagger-ui.html
- 商品服务 Swagger: http://localhost:8002/swagger-ui.html
- 订单服务 Swagger: http://localhost:8003/swagger-ui.html
- 评价服务 Swagger: http://localhost:8004/swagger-ui.html
- 通知服务 Swagger: http://localhost:8005/swagger-ui.html

### 4. 监控面板

- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (默认用户: admin, 密码: admin@123)
- RabbitMQ: http://localhost:15672 (默认用户: guest, 密码: guest)

## 生产环境部署

### 1. 配置优化

更新各服务的 `application-prod.yml` 配置：

```yaml
spring:
  datasource:
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5
  redis:
    jedis:
      pool:
        max-active: 20
        max-idle: 10

server:
  compression:
    enabled: true
    min-response-size: 1024
```

### 2. 使用 Kubernetes 部署（可选）

创建 k8s 部署文件和服务配置...

### 3. 使用 Jenkins 进行 CI/CD

创建 Jenkinsfile 进行自动化部署...

## 故障排除

### 问题：无法连接 MySQL

```bash
# 检查 MySQL 状态
docker ps | grep mysql

# 查看日志
docker logs campus-mysql

# 重启 MySQL
docker restart campus-mysql
```

### 问题：Nacos 连接超时

```bash
# 检查 Nacos 是否启动
docker ps | grep nacos

# 查看 Nacos 日志
docker logs campus-nacos

# 确保网络连接
ping localhost
```

### 问题：服务无法注册到 Nacos

1. 检查各服务配置中 Nacos server-addr 是否正确
2. 确保 Nacos 已启动
3. 检查防火墙设置

### 问题：RabbitMQ 连接失败

```bash
# 检查 RabbitMQ 状态
docker ps | grep rabbitmq

# 查看 RabbitMQ 日志
docker logs campus-rabbitmq

# 重启 RabbitMQ
docker restart campus-rabbitmq
```

## 常用命令

```bash
# 查看所有容器
docker ps -a

# 查看容器日志
docker logs container_name

# 进入容器
docker exec -it container_name bash

# 停止所有服务
docker-compose down

# 重启所有服务
docker-compose restart

# 查看服务状态
docker-compose ps
```

## 更多信息

- [Spring Boot 文档](https://spring.io/projects/spring-boot)
- [Spring Cloud 文档](https://spring.io/projects/spring-cloud)
- [Nacos 文档](https://nacos.io/docs)
- [Docker 文档](https://docs.docker.com/)
