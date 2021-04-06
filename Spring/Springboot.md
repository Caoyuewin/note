# Springboot

## 项目文件介绍

### pom.xml

```xml
<!-- Springboot的父级依赖-->
<!-- spring-boot-stater-parent是一个特殊的stater，用来提供Maven默认依赖，常用的包依赖可以省去version标签 -->
<parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.1.0.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
</parent>
```

### SpringbootApplication.java

```java
//@SpringBootApplication注解组合了@Configuration、@EnableAutoConfiguration、@ComponentScan三个注解
@SpringBootApplication
public class SpringbootApplication {
    public static void main(String[] args) {
        SpringApplication.run(SpringbootApplication.class, args);
    }

}

```

* @EnableAutoConfiguration：让SpringBoot根据类路径中的jar包依赖为当前项目进行自动配置
* SpringBoot还会自动扫描@SpringBootApplication所在类的同级包以及下级包里的Bean，所以建议入口类就配置在groupID+artifactID组合的包名

## 热部署

### 1.IDE设置

![image-20200811201840405](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200811201840405.png)

![image-20200811201912789](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200811201912789.png)

### 2.pom.xml设置

![image-20200811202315291](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200811202315291.png)

![image-20200811202846286](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200811202846286.png)

## profile

### 多profile文件

在`application.properties`指定要启用的配置

```properties
#application.properties
#将启用application-dev.properties作为
spring.profiles.active=dev

#默认使用application.properties配置
#默认端口号8080
```

```properties
#application-dev.properties
#开发环境配置文件
server.port=8081
```

```properties
#application-prod.properties
#生产环境配置文件
server.port=8082
```

### [YML文档](https://juejin.im/post/6844903977121742861)

```yaml
server:
  port: 8081
spring:
  profiles:
    active: dev
---
server:
  port: 8082
spring:
  profiles: dev

---
server:
  port: 8083
spring:
  profiles: prod
```

### 命令行指定

<img src="C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200812110920038.png" alt="image-20200812110920038" style="zoom:100%;" />



## 文件加载位置

### 加载配置文件顺序

1. file:/config/
2. file:/
3. classpath:/config/
4. classpath:/

高优先级覆盖低优先级，但是也会全部加载

### 加载外部配置顺序

**1.命令行参数**

所有的配置都可以在命令行上进行指定

java -jar spring-boot-02-config-02-0.0.1-SNAPSHOT.jar --server.port=8087  --server.context-path=/abc

多个配置用空格分开； --配置项=值



2.来自java:comp/env的JNDI属性

3.Java系统属性（System.getProperties()）

4.操作系统环境变量

5.RandomValuePropertySource配置的random.*属性值



==**由jar包外向jar包内进行寻找；**==

==**优先加载带profile**==

**6.jar包外部的application-{profile}.properties或application.yml(带spring.profile)配置文件**

**7.jar包内部的application-{profile}.properties或application.yml(带spring.profile)配置文件**



==**再来加载不带profile**==

**8.jar包外部的application.properties或application.yml(不带spring.profile)配置文件**

**9.jar包内部的application.properties或application.yml(不带spring.profile)配置文件**



10.@Configuration注解类上的@PropertySource

11.通过SpringApplication.setDefaultProperties指定的默认属性

所有支持的配置加载来源；

## 自动配置原理



使用SpringBoot Debug功能检查哪些自动配置类生效

```yaml
# 开启SpringBoot的Debug功能
debug: true
```

![image-20200812141247085](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200812141247085.png)

* Positive matches：生效的配置(条件满足)
* Negative matches：未生效的配置(条件不满足)

## 日志

### SpringBoot选用的日志框架和实现

日志框架：`SLF4j`

实现版本：`logback`

![image-20200812144011243](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200812144011243.png)

### 遗留问题

其他日志框架转换成log4j

![image-20200812145147846](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200812145147846.png)



### 日志级别

`trace`<`debug`<`info`<`warn`<`error`

### 日志输出格式

```properties
logging.pattern.console=...
logging.pattern.file=...	
```



```xml
<!--
        日志输出格式：
			%d表示日期时间，
			%thread表示线程名，
			%-5level：级别从左显示5个字符宽度
			%logger{50} 表示logger名字最长50个字符，否则按照句点分割。 
			%msg：日志消息，
			%n是换行符
-->
```



