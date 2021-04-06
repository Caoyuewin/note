[TOC]

# [Mybatis-Plus](https://baomidou.com/guide/)

## 代码生成器

通过`AutoGenerator`快速生成Entity,Mapper,Mapper XML,Service,Controller等模块

### 添加**代码生成器**依赖

```xml
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-generator</artifactId>
    <version>3.3.2</version>
</dependency>
```

### 添加**模板引擎**依赖

Velocity（默认）：

```xml
<dependency>
    <groupId>org.apache.velocity</groupId>
    <artifactId>velocity-engine-core</artifactId>
    <version>2.2</version>
</dependency>
```

Freemarker：

```xml
<dependency>
    <groupId>org.freemarker</groupId>
    <artifactId>freemarker</artifactId>
    <version>2.3.30</version>
</dependency>
```

Beetl：

```xml
<dependency>
    <groupId>com.ibeetl</groupId>
    <artifactId>beetl</artifactId>
    <version>3.1.8.RELEASE</version>
</dependency>
```

使用非默认引擎，需要在AutoGenerator中设置模板引擎



```java
AutoGenerator generator = new AutoGenerator();

// set freemarker engine
generator.setTemplateEngine(new FreemarkerTemplateEngine());

// set beetl engine
generator.setTemplateEngine(new BeetlTemplateEngine());

// set custom engine (reference class is your custom engine class)
generator.setTemplateEngine(new CustomTemplateEngine());

// other config
...
```

### 编写配置

```yaml
mybatis-plus: 
# 为这个包下的所有POJO起别名，别名默认是类名，不区分大小写
	type-aliases-package: packageName
```



### CRUD接口

### 条件构造器

#### 参数说明

```yaml
boolean condition: 表示该条件是否加入最后生成的sql
param: Wrapper的子类实例具有AbstraWrapper的所有方法
R: 泛型，在普通wrapper中是String，在LambdaWrapper中是函数
R column: 表示数据库字段
```

## 常用注解

### @TableField

>  表字段标识

`fill`自动填充策略：

​	`DEFAULT`不处理

​	`INSERT`插入时填充

​	`UPDATE`更新时填充

​	`INSERT_UPDATE`更新和插入时填充

示例：

```java
 @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date lastUpdateTime;
```

