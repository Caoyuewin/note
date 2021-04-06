[TOC]

# @SpringBootApplication

> 用在Spring Boot主类上，标识这是一个Spring Boot应用，用来开启Spring Boot 的各项功能

```java
/**
 * Indicates a {@link Configuration configuration} class that declares one or more
 * {@link Bean @Bean} methods and also triggers {@link EnableAutoConfiguration
 * auto-configuration} and {@link ComponentScan component scanning}. This is a convenience
 * annotation that is equivalent to declaring {@code @Configuration},
 * {@code @EnableAutoConfiguration} and {@code @ComponentScan}.
 *
 * @author Phillip Webb
 * @author Stephane Nicoll
 * @author Andy Wilkinson
 * @since 1.2.0
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan(excludeFilters = { @Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
      @Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) })
```



## ComponentScan

> 自动扫描并加载符合条件的组件(`@Component` `@Repository` `@Bean`)将这些bean定义加载到IoC容器

- `basePackageClassses`：对`basepackages()`进行类型安全的指代
- `excludeFilters`：指定不适合组件扫描的类型
- `includeFilters`：指定适合用于组件扫描的类型
- `lazInit`：被扫描的`beans`是否使用`lazy`初始化方式
- `resourcePattern`：类似于`excludeFilters`和`includeFilters`

## @EnableAutoConfiguration

> 启用Spring Application Context的自动配置，尝试猜测和配置您可能需要的bean。 通常根据您的类路径和定义的bean来应用自动配置类。

## @Documentted

> `@Documented`注解表明这个注释是由 `javadoc`记录的，在默认情况下也有类似的记录工具。 如果一个类型声明被注释了文档化，它的注释成为公共API的一部分。

## @Inherited

> 使用此`@Inherited`的注解会被子类自动继承

## @Retention

> `RetentionPolicy`这个枚举类型的常量描述保留注释的各种策略，它们与元注释(@Retention)一起指定注释要保留多长时间

## @Target

> `ElementType `这个枚举类型的常量提供了一个简单的分类：注释可能出现在Java程序中的语法位置（这些常量与元注释类型(@Target)一起指定在何处写入注释的合法位置）

# @RequestParam

> 是`springmvc`中接收普通参数的注解

```java
@Request(value="paramName",required="true/false",defaultValue="")
```

* `value`参数名
* `required`url中是否必须传递该参数
* `defaultValue`默认参数值，如果设置了该值，`required=true`将会失效



# @RestContrller

> `@Controller` + `@ResponseBody`

# @ResponseBody

> 将Object转换成Json格式

# @ControllerService

# @Valid

> 用于表单验证

```java
@Null 限制只能为null
@NotNull 限制必须不为null
@AssertFalse 限制必须为false
@AssertTrue 限制必须为true
@DecimalMax(value) 限制必须为一个不大于指定值的数字
@DecimalMin(value) 限制必须为一个不小于指定值的数字
@Digits(integer,fraction) 限制必须为一个小数，且整数部分的位数不能超过integer，小数部分的位数不能超过fraction
@Future 限制必须是一个将来的日期
@Max(value) 限制必须为一个不大于指定值的数字
@Min(value) 限制必须为一个不小于指定值的数字
@Past 限制必须是一个过去的日期
@Pattern(value) 限制必须符合指定的正则表达式
@Size(max,min) 限制字符长度必须在min到max之间
@Past 验证注解的元素值（日期类型）比当前时间早
@NotEmpty 验证注解的元素值不为null且不为空（字符串长度不为0、集合大小不为0）
@NotBlank 验证注解的元素值不为空（不为null、去除首位空格后长度为0），不同于@NotEmpty，@NotBlank只应用于字符串且在比较时会去除字符串的空格
@Email 验证注解的元素值是Email，也可以通过正则表达式和flag指定自定义的email格式

作者：叫我胖虎大人
链接：https://www.jianshu.com/p/c8686fa5ef63
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```

# @JsonPropertyOrder

> ```java
> package com.fasterxml.jackson.annotation
> ```

- 用于规定属性的序列化顺序

```java
//ret，msg，content属性将最先进行序列化
@JsonPropertyOrder({"ret","msg","content"})
```

- 未显示声明序列化顺序的设置为按字母顺序

```java
@JsonPropertyOrder(alphabetic=true)
```

# @JsonInclude

> 规定特定属性的才会被序列化

- 非空(non_null)的属性才被序列化

```java
@JsonInclude(JosnInclude.Include.NON_NULL
```

# [@RefreshScope](https://www.jianshu.com/p/dbf3933aecb3)

> ```java
> package org.springframework.cloud.context.config.annotation;
> ```

- 当遇到生产环境配置参数需要调整，但又没有配置中心的支持的情况下，只能重启应用以加载新参数，可能会影响业务系统运行，太暴力不优雅；@RefreshScope注解能帮助我们做局部的参数刷新，但侵入性较强，需要开发阶段提前预知可能的刷新点，并且该注解底层是依赖于cglib进行代理的，所以不要掉入cglib的坑，出现刷了也不更新情况；

# [@ConfigurationProperties](https://blog.csdn.net/yusimiao/article/details/97622666)

==一定要写getter和setter！！！==

# [@Schedule](https://www.mmzsblog.cn/articles/2019/08/08/1565247960802.html)

[Cron表达式](https://www.cnblogs.com/jing99/p/11546559.html)