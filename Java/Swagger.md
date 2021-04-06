[TOC]

# Swagger

## Maven依赖

```xml
<dependency>
    <groupId>com.github.xiaoymin</groupId>
    <artifactId>knife4j-spring-boot-starter</artifactId>
    <!--在引用时请在maven中央仓库搜索最新版本号-->
    <version>2.0.4</version>
</dependency>
```

## 基本结构

使用`YAML`或者`Json`书写openAPI定义

`````yaml
openapi: 3.0.0
###
# API信息
###
info:
# API名称
  title:
# 扩展信息，可以是多行，支持Markdown
  description:
# 版本
  version:

# 指定API服务器和基本URL
servers:
  - url: http://localhost:8080/testSwagger
    description:
  - url:
    description:

###
# paths部分定义您的API中的各个端点（路径）以及这些端点支持的HTTP方法（操作）,GET/users可以描述为
###
paths:
# 路径名
  /users/{userId}:
# http方法
    get:
# 概述
      summary:
# 具体描述
      description:
# parameters 参数描述(通过URL路径，query string，headers，cookies传递)
      parameters:
        - name: userId
          in: path
# 是否必须
          required: true
# 参数描述
          description:
# 概要
          schema:
            type: integer
            format: int 64
            minimum: 2
# 响应
      responses:
# 状态码
        '200':
# 状态码描述
          description:
          content:
            application/json:
              schema:
                type: array
                items:
                  type: string
# 引用User模型
                $ref: '#/components/schemas/User'
  /user:
    post:
      summary:
# 请求体
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type:
              properties:
                username:
                  type:
      responses:
        '201':
          description:

###
# 输入输出模型
# 这里定义一个User模型
# {
#    "id":4,
#    "name":"caoyuewen"
# }
###
components:
  schemas:
    User:
      properties:
        id:
          type: integer
        name:
          type: string
      required:
        - id
        - name
# Authentication：认证方式
  securitySchemes:
    BasicAuth:
      type: http
      scheme: basic

security:
  - BasicAuth: []

`````

服务器模板：

```yaml
servers:
  - url: https://{customerId}.saas-app.com:{port}/v2
    variables:
      customerId:
        default: demo
        description: Customer ID assigned by the service provider
      port:
        enum:
          - '443'
          - '8443'
        default: '443'
```

