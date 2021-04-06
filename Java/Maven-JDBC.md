[TOC]

# Day8

## 数据库规范

1. 所有数据库对象必须使用小写字母并用下划线分割
2. 禁止使用MySQL保留关键字命名
3. 命名不要超过32字符
4. 临时表必须以tmp_为前缀并以日期为后缀
5. 备份必须以bak_为前缀以日期为后缀
6. 储存相同数据的列名和列类型必须一致
7. 禁止使用enum类型命名字段
8. 使用tinyint存储，在注释中写清数字代表的业务含义

## Maven

### 仓库

1. 本地仓库(联网情况下会自动去中央仓库下载)
2. 远程仓库(私服)
3. 中央仓库

![image-20200729101951355](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200729101951355.png)

### 目录结构

* 核心代码部分
* 配置文件部分
* 测试代码部分
* 测试配置文件

### 常用命令

`mvn clean`：删除target

默认生命周期：

1. `mvn compile`：编译
2. `mvn test`：编译->测试
3. `mvn package`：打包
4. `mvn install`：编译->测试->打包->安装
5. `mvn deploy`：发布

## 泛型

1. 类型参数只能代表类型参数
2. 泛型类中的static方法的类型参数要与类的类型参数不同

### 类型通配符

* extends
  * 这种使用的泛型定义称之为上界通配符（Upper Bounds Wildcards），即把泛型类型`T`的上界限定在`Number`了。除了可以传入`Pair`类型，我们还可以传入`Pair`类型，`Pair`类型等等，因为`Double`和`BigDecimal`都是`Number`的子类。
* 何时使用`extends`，何时使用`super`？为了便于记忆，我们可以用PECS原则：Producer Extends Consumer Super。即：如果需要返回`T`，它是生产者（Producer），要使用`extends`通配符；如果需要写入`T`，它是消费者（Consumer），要使用`super`通配符。



## 注解

作用在代码的注解

* @Overrride-检查方法是否是重写方法，如果发现其父类或者结果中没有该方法或编译报错
* @Deprecated-标记过时的方法，使用该方法会被编译警告
* @SuppressWarnnings-指示编译器忽略注解中声明的警告

元注解(作用在其他注解的注解)

* @Retention-标识这个注解是怎么保存，代码中？class文件中？运行时可以通过反射访问？
* @Doucumented-标记这个注解应该是哪种Java成员
* @Target-标记这个注解应该是那猴子那个Java成员
* @Inherited-标记这个注解是继承与哪个注解类

Java7后添加的3个注解

* @SafeVarargs-忽略任何使用参数为泛型变量的方法或构造函数调用产生的警告
* @FunctionalInterface 标识一个匿名函数或者函数式接口
* @Repeatable 标识某注解可以在同一个声明上使用多次

![img](https://www.runoob.com/wp-content/uploads/2019/08/28123151-d471f82eb2bc4812b46cc5ff3e9e6b82.jpg)

## JDBC

1. 创建Connection对象
2. 创建Statement对象
3. 执行SQL语句
4. 使用ResultSet对象
5. 关闭ResultSet对象
6. 关闭StateMent对象
7. 关闭Connection对象