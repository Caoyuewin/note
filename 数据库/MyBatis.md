[toc]

# [MyBatis](https://mybatis.org/mybatis-3/zh/index.html)

## 简介

- MyBatis 是支持定制化 SQL、存储过程以及高级映射的优秀的持久层框架。
- MyBatis 避免了几乎所有的 JDBC 代码和手动设置参数以及获取结果集。
- MyBatis可以使用简单的XML或注解用于配置和原始映射，将接口和Java POJO（Plain Old Java Objects，普通的Java对象）映射成数据库中的记录

## 操作数据库

### 结合xml配置文件，获取SqlSessionFactory

```java
	public SqlSessionFactory getSqlSessionFactory() throws IOException {
		String resource = "mybatis-config.xml";
		InputStream inputStream = Resources.getResourceAsStream(resource);
		return new SqlSessionFactoryBuilder().build(inputStream);
	}

SqlSessionFactory sqlSessionFactory = getSqlSessionFactory();
//SqlSession 的实例不是线程安全的，因此是不能被共享的。
//SqlSession每次使用完成后需要正确关闭，这个关闭操作是必须的
SqlSession openSession = sqlSessionFactory.openSession();

```

`mybatis-config.xml`示例

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
  <environments default="development">
    <environment id="development">
      <transactionManager type="JDBC"/>
      <dataSource type="POOLED">
        <property name="driver" value="${driver}"/>
        <property name="url" value="${url}"/>
        <property name="username" value="${username}"/>
        <property name="password" value="${password}"/>
      </dataSource>
    </environment>
  </environments>
  <mappers>
    <mapper resource="org/mybatis/example/BlogMapper.xml"/>
  </mappers>
</configuration>
```

### 不使用xml配置mybatis

mybatis提供了一个与xml文件功能完全相同的配置类，借助注解实现，但是某些高级功能仍然需要xml文件进行映射

```java
DataSource dataSource = BlogDataSourceFactory.getBlogDataSource();
TransactionFactory transactionFactory = new JdbcTransactionFactory();
Environment environment =
  new Environment("development", transactionFactory, dataSource);
Configuration configuration = new Configuration(environment);
configuration.addMapper(BlogMapper.class);
SqlSessionFactory sqlSessionFactory =
  new SqlSessionFactoryBuilder().build(configuration);
```

### 从SqlSessionFactory获取一个SqlSession

```java
try (SqlSession session = sqlSessionFactory.openSession()) {
  Blog blog = session.selectOne(
    "org.mybatis.example.BlogMapper.selectBlog", 101);
}
```

启动springboot自动执行SQL文件

```yaml
spring:
	datasource:
		initialization-mode: always
```

## 动态SQL

• **#{key}**：获取参数的值，预编译到SQL中。安全。

• **${key}**：获取参数的值，拼接到SQL中。有SQL注入问题，ORDER BY ${name}

[动态sql](E:\Java学习\课件&代码\课件&代码\MyBatis.pdf)