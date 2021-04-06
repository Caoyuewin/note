[toc]

# Spring Cloud Alibaba

## SpringBoot

启动项目前执行：`mvn clean install`

命令行启动项目：`java -jar jarPacakageName`

### actuator

引入依赖

```xml
 <dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

`http://localhost:8081/actuator`

```json
{
    "_links": {
        "self": {
            "href": "http://localhost:8081/actuator",
            "templated": false
        },
        "health": {
            "href": "http://localhost:8081/actuator/health",
            "templated": false
        },
        "health-path": {
            "href": "http://localhost:8081/actuator/health/{*path}",
            "templated": true
        },
        "info": {
            "href": "http://localhost:8081/actuator/info",
            "templated": false
        }
    }
}
```

`http://localhost:8081/actuator/health`

```json
{
    "status": "UP",
    "components": {
        "diskSpace": {
            "status": "UP",
            "details": {
                "total": 172874526720,
                "free": 156612726784,
                "threshold": 10485760,
                "exists": true
            }
        },
        "ping": {
            "status": "UP"
        }
    }
}
```

status：

1. UP：正常
2. DOWN：不正常
3. OUT_OF_SERVICE：自愿未使用、不应使用
4. UNKNOWN：未知

```yaml
# application.yml
info:
	author: caoyuewen
```

`http://localhost:8081/actuator/info`

```json
{
    "author": "caoyuewen"
}
```

## 微服务

![image-20200901135307012](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200901135307012.png)

微服务适用场景：

* 大型、复杂的项目
* 有快速迭代的需求
* 访问压力大

### 微服务拆分

领域驱动设计（Dommain Driven Design）

面向对象

### 小程序拆分

####  项目架构图

![image-20200901141437903](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200901141437903.png)

### 数据库设计

## NACOS

![image-20200901193239056](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200901193239056.png)

![nacosMap](E:\工作文档\studynotes\Spring\Spring Cloud Alibaba.assets\nacosMap.jpg)

添加Spring Cloud依赖（

```xml
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-alibaba-dependencies</artifactId>
    <version>2.2.1.RELEASE</version>
    <type>pom</type>
    <scope>import</scope>
</dependency>
```

```yaml
spring:
  cloud:
    nacos:
      server-addr: localhost:8848
  application: 
  	name: servername
```

#### SpringCloud DiscoveryClient

```java
@Autowired
private DiscoveryClient discoveryClient;
```

#### 元数据

* 提供描述信息
* 让微服务调用更加灵活

##### 设置元数据

1. 控制台设置
2. 配置设置

#### 配置管理

##### 添加依赖：

```xml
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
    <version>${latest.version}</version>
</dependency>
```

dataId格式：`${prefix}-{spring.profiles.active}.${file-extension}`

- `prefix`：注册到nacos上的服务名，`spring.application.name`的值，可以通过配置`spring.cloud.nacos.cofig.prefix`来改变。
- `spring.profiles.active`：环境对应的profile，如果没有指定，则去掉此字段
- `file-extension`：文件拓展名





## Feign

 #### 使用

```java
@SpringBootApplication(scanBasePackages = {"com.hzyuewan.sdk.core"})
@EnableDiscoveryClient
//启动类上加注解
@EnableFeignClients
@ServletComponentScan
@MapperScan("com.hzyuewan.sdk.core.game.mapper")
public class GameApplication {
    public static void main(String[] args) {
        SpringApplication.run(GameApplication.class, args);
        System.out.println("启动game-center");
    }
}
```

```java
@FeignClient(name = "user-center")
public interface UserCenterFeignClient {
    /**
     * http://user-center/user/{id}
     * @param id
     * @return
     */
    @GetMapping("/user/{id}")
    String FindById(@PathVariable Integer id);
}
```

### 配置

#### 代码配置

##### 自定义Feign日志级别

| 级别         | 打印内容                                      |
| ------------ | --------------------------------------------- |
| NONE(默认值) | 不记录任何日志                                |
| BASIC        | 仅记录请求方法、URL、响应状态代码以及执行时间 |
| HEADERS      | 记录BASIC级别的基础上，记录请求和响应的header |
| FULL         | 记录请求和响应的header、body和元数据          |

```java
//这里不加@Configuration，有可能产生父子上下文重复扫描问题
@FeignClient(name = "user-center",configuration = UserCenterFeignConfiguration.class)
public interface UserCenterFeignClient {
    /**
     * http://user-center/user/{id}
     * @param id
     * @return
     */
    @GetMapping("/user/{id}")
    String FindById(@PathVariable Integer id);
}

```

```yaml
# 对应的接口的日志级别也要设为debug以上
logging:
  level:
    com.hzyuewan.springcloudalibabademo.feignclient.UserCenterFeignClient: debug
```

#### 配置文件配置  

```yaml
feign:
  client:
    config:
      #想要调用的微服务名称
      user-center:
        loggerLevel: full
```

##### 全局配置 

```yaml
feign:
  client:
    config:
      # 全局配置
      default:
        loggerLevel: full
```

### 继承特性

官方不建议使用(紧耦合)，实际上很多公司在用(契约 )

### 多参数请求构造

### RestTemplate VS Feign

| 角度     | RestTemplate | Feign                         |
| -------- | ------------ | ----------------------------- |
| 可读性   | 一般         | 极佳                          |
| 开发体验 | 欠佳         | 极佳                          |
| 性能     | 很好         | 中等（RestTemplate的50%左右） |
| 灵活性   | 极佳         | 中等                          |

### 性能优化

- 连接池

```yaml
feign:
  httpclient:
  	# 让feign使用Apache httpclient做请求而不是默认的urlconnection
    enabled: true
    # feign的最大连接数
    max-connections: 200
    # feign单个路径的最大连接数
    max-connections-per-route: 50
```

### 常见问题

[feign使用常见问题](https://www.imooc.com/article/289005)

![image-20200902144820907](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200902144820907.png)

## Sentinel

> 懒加载

### 雪崩效应

> 又称为级联失效/级联故障

![image-20200902145243908](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200902145243908.png)

### 常见容错方案

- 超时
- 限流
- 仓壁模式
- 断路器模式

### sentinel配置

```yaml
spring:
  cloud:
    sentinel:
      transport:
        dashboard: localhost:8080
```

### 限流方式

- 直接

- 关联

  > 当关联的资源达到阈值，就限流自己

- 链路

  > 只限流入口资源

  #### 处理方式

* 快速失败
* Warm Up
* 排队等待
* 

### 降级规则

#### RT

默认最大4900ms

可以通过`-Dcsp.sentinel.statistic.max.rt=xxx`修改

### 热点规则

对指定参数/指定参数的值进行限流

### 系统规则

#### LOAD

> 当系统load1（一分钟的load）超过阈值，并且并发线程数超过系统容量时触发，建议设置为CPU核心数*2.5。（进队Linux/Unix-like机器生效）

系统容量 = maxQps * minRT

- maxQps：秒级统计出来的最大Qps
- minRT：秒级统计出来的最小响应时间

#### RT(ResponseTime)

>  所有入口流量的平均RT达到阈值触发

#### 线程数

> 所有入口流量的并发线程数达到阈值触发

#### 入口Qps(Queries-per-second)

> 所有入口流量的Qps达到阈值触发

### 授权规则

### 用代码配置规则

### 应用端连接控制台配置项

### 控制台配置项

| 配置项                         | 默认值         | 最小值 | 描述                                                         |
| ------------------------------ | -------------- | ------ | ------------------------------------------------------------ |
| server.port                    | 8080           | -      | 指定端口                                                     |
| csp.sentinel.dashboard.server  | localhost:8080 | -      | 指定地址                                                     |
| project.name                   | -              | -      | 指定程序名称                                                 |
| sentinel.dash.auth.username    | sentinel       | -      | Dashboard登录账号                                            |
| sentinel.dash.auth.password    | sentinel       | -      | Dashboard登录密码                                            |
| server.servlet.session.timeout | 30分钟         | -      | 登录session过期时间，配置7200表示7200秒，配置60m表示将60分钟 |

配置方法（以配置控制台登录账号和密码为例）：`java -jar -Dsentinel.dash.auth.username=caoyuewen -Dsentinel.dash.auth.password=123456 ${sentinel jar包}`

### Sentinel API

###  @SentinelResource

### Feign整合Sentinel

```yaml
feign:
	sentinel:
		enabled: true
```

#### fallback/fallbackFacttory

fallback：限流或降级时自定义逻辑

fallbackFactory：自定义逻辑并获取异常

```java
//fallback和fallbackFactory只能选择一个
@FeignClient(name = "clientName",
            fallback = XXX.class,
            fallbackFactory = XXX.class
            )
```

#### Sentinel使用总结

| 使用方式     | 使用方式                   | 使用方法                 |
| ------------ | -------------------------- | ------------------------ |
| 编码方式     | API                        | try...catch...finally    |
| 注解方式     | SentinelResource           | blockHandler/fallback    |
| RestTemplate | SentinelRestTemplate       | blockHandler/fallback    |
| Feign        | feign.sentinel.enable-true | fallback/fallbcakFactory |

### 规则持久化

#### 拉模式

```xml
<dependency>
	<groupId>com.alibaba.csp</groupId>
    <artifactId>sentinel-datasource-extension</artifactId>
</dependency>
```

[拉模式](https://www.imooc.com/article/289402)

[推模式](https://www.imooc.com/article/289464)

#### AHAS

[开通地址](https://ahas.console.aliyun.com)(需登录)

### 集群流控

### 拓展Sentinel

#### 错误页优化

`UrlBlockHandler`

##  Spring实现异步的方法

- [AsyncRestTemplate](https://bloq.csdn.net/jiangchao858/article/details/86709750)
- [@Async注解](https://spring.io/quides/qs/ async-method/)
- [WebClient(Spring5.0 引入)](https://docs.spring.io/spring/docs/5.1.8.RELEASE/spring-
  framework-reference/web-reactive.html#webflux-client)
- MQ

## MQ

### 适用场景

- 异步处理
- 流量削峰填谷
- 解耦微服务

[MQ的选择](https://www.imooc.com/article/290040)

### 使用

依赖

```xml
<dependency>
	<groupId>org.apache.rocketmq</groupId>
    <artifactId>rocketmq-spring-boot-starter</artifactId>
    <version>2.1.1</version>
</dependency>
```

配置

```yaml
rocketmq:
  producer:
    # 必须指定group
    group:  test-group
  name-server: 127.0.0.1:9876
```

## 网关

### 什么是Spring Cloud GateWay

- Spring Cloud第二代网关，未来会取代第一代(Zuul)
- 基于Netty、Reactor、WebFlux构建

### 优点

- [性能强劲](https://www.imooc.com/article/285068)
- 功能强大
- 设计优雅、易扩展

### 缺点

- 依赖Netty和WebFlux，不是Servlet编程模型
- 不能再Servlet容器下工作，不能构建成War包
- 不支持Spring Boot 1.x

### 配置

```yaml
server:
  port: 8040
spring:
  application:
    name: gateway
  cloud:
    nacos:
      server-addr: localhost:8848
    gateway:
      discovery:
        locator:
          # 让gateway通过服务发现组件找他其他微服务
          enabled: true
```

### 核心概念

![image-20200908114011752](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200908114011752.png)

#### Route(路由)

配置示例

```yaml
spring:
	cloud:
		gateway:
			routes:
				- id: some_route
				  uri: http://www.xxx.com
				  predicates:
				  	- Path=/users/1
				  filters:
				  	- AddRequestHeader=X-Request-Foo,Bar
```



#### Predicate(谓词)

[谓词工厂](https://www.imooc.com/article/290804)

自定义路由谓词工厂

 

#### Filter(过滤器)

[过滤器工厂](https://www.imooc.com/article/290816)

自定义过滤器工厂

过滤器生命周期：

- pre：Gateway转发请求之前
- post：Gateway转发请求之后

方式1：

继承 

```yaml
spring:
	cloud:
		gateway:
			routes:
				filters:
				- name: RequestSize
					args: 
						maxSize: 500000
```

方式2：

继承 

```yaml
spring:
	cloud:
		gateway:
			routes:
				filters:
				- AddRequestHeader=S-Header,Bar
```

[全局过滤器](https://www.imooc.com/article/290816)

order值越小，越靠前执行 ，可自行设置order的值

[Spring Cloud Gateway监控](https://www.imooc.com/article/290822)

[Spring Cloud Gateway限流](https://www.imooc.com/article/290828)