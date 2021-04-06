[toc]



# Filter

> javax.servlet.Filter

1. init
2. doFilter
   1. chain.doFilter：将请求传回过滤链
3. destroy





# Intercepter

> org.springframework.web.servlet



## HandlerInterceptor

```java
boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception;
void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)throws Exception;
void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)throws Exception;
```

## WebRequestInterceptor

```java
void preHandle(WebRequest request) throws Exception;
void postHandle(WebRequest request, ModelMap model) throws Exception;
void afterCompletion(WebRequest request, Exception ex) throws Exception;
```

## 相同点

两个接口都可用于Contrller层请求拦截，接口中定义的方法作用也是一样的。

WebRequestInterceptor间接实现了HandlerInterceptor，只是他们之间使用WebRequestHandlerInterceptorAdapter适配器类联系。

## 不同点

1. WebRequestInterceptor的入参WebRequest是包装了HttpServletRequest 和HttpServletResponse的，通过WebRequest获取Request中的信息更简便。
2. WebRequestInterceptor的preHandle是没有返回值的，说明该方法中的逻辑并不影响后续的方法执行，所以这个接口实现就是为了获取Request中的信息，或者预设一些参数供后续流程使用。
3. HandlerInterceptor的功能更强大也更基础，可以在preHandle方法中就直接拒绝请求进入controller方法。

## 配置

```java
@Configuration
public class LoginConfigurer implements WebMvcConfigurer{
    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(new TestFilter()).addPathPatterns("/pathname");
    }
}
```

