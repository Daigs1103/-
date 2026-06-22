# 贡献指南

感谢您对校园二手交易平台项目的兴趣！我们欢迎您的贡献。

## 贡献方式

### 1. 报告 Bug

- 在 GitHub Issues 中创建新的 issue
- 提供详细的复现步骤
- 包含错误日志和堆栈跟踪
- 说明您的环境信息（操作系统、Java 版本等）

### 2. 提议新功能

- 在 GitHub Issues 中创建 Feature Request
- 详细描述新功能的需求
- 解释为什么需要这个功能
- 提供可能的实现思路

### 3. 代码贡献

#### 步骤

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

#### 代码规范

- 遵循 Google Java 风格指南
- 使用 4 个空格缩进
- 每行不超过 120 个字符
- 为公共方法添加 JavaDoc 注释
- 编写单元测试（测试覆盖率应 > 80%）

#### 提交信息规范

```
<type>(<scope>): <subject>

<body>

<footer>
```

类型：
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码风格
- `refactor`: 代码重构
- `test`: 测试
- `chore`: 构建和依赖

## 开发流程

1. **分支管理**
   - `main`: 生产分支
   - `develop`: 开发分支
   - `feature/*`: 特性分支
   - `bugfix/*`: Bug 修复分支

2. **代码审查**
   - 至少需要 1 个维护者审查
   - 所有检查必须通过
   - 解决所有评论

3. **测试要求**
   - 单元测试
   - 集成测试
   - 功能测试

## 许可证

贡献代码表示您同意将代码发布在 MIT 许可证下。

## 联系我们

- GitHub Issues: 功能请求和 Bug 报告
- Email: 联系方式见 README.md
