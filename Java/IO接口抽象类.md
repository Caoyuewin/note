[TOC]



# Java-Day3

## 昨日问题

1. 方法命名遵循驼峰原则
2. 方法和类的注释用/**/
3. 行注释写在对应代码上方
4. 每天先拉一下代码

## 流、文件、IO

### 读取控制台输入

```java
//将System.in装在BufferedReader中来创建一个字符流
BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
//read()读取一个字符，readLine()读取一个字符串,read()将读取到的字符当做整数值返回，流结束时返回-1，该方法抛出IOException

    
```

### FileInputStream

```java
//文件名创建一个输入流对象
InputStream f = new FileInputStream("C:java/hello");
//用File方法创建一个文件对象，再用这个文件对象来创建输入流对象
File f = new File("C:/java/hello");
InputStream out = new FileInputStream(f);
```

### IO类层次图

![img](https://www.runoob.com/wp-content/uploads/2013/12/iostream2xx.png)

### 目录

- **mkdir( )**方法创建一个文件夹，成功则返回true，失败则返回false。失败表明File对象指定的路径已经存在，或者由于整个路径还不存在，该文件夹不能被创建。
- **mkdirs()**方法创建一个文件夹和它的所有父文件夹。

```java
public static void main(String args[]) {
    String dir = "tmp/use/java/bin";
    File f = new File(dir);
    d.mkdirs();
}
```

## Scanner类

```java
Scanner s = new Scanner(System.in);
```

### next()和nextLine()的区别

1. next()方法读取有效字符后才结束输入
2. next()自动去掉第一个有效字符前的所有的空字符，如空格和tab
3. next()接受有效字符后会将后面的空字符当做分隔符或结束符
4. nextLine以Enter为结束符，接受之前的所有字符包括空白字符

## Java异常处理

![img](https://www.runoob.com/wp-content/uploads/2013/12/12-130Q1234I6223.jpg)

## 类和对象

* 一个源文件只能有一个public类，可以有多个非public类
* 如果类定义在某个包中，那么package语句应放在首行

### 抽象类

* 抽象类不能实例化对象
* 抽象类不一定含有抽象方法，但是有抽象方法的类一定是抽象类
* 抽象类的子类如果不是抽象类，那么子类一定要重写抽象类中的抽象方法

### 接口

* 接口(Interface)是抽象方法的集合，类通过继承接口来继承接口的抽象方法

#### 接口与类的相似点

1. 一个接口可以有多个方法
2. 保存在与接口名相同的.java文件中
3. 字节码文件保存在.class文件中
4. 字节码文件必须在与包名称相匹配的目录结构中

#### 接口与类的区别

1. 接口不能实例化
2. 没有构造方法
3. 所有方法都是抽象方法，public abract
4. 接口中的变量都会被隐式指定为pulblic static final
5. 接口支持多继承

#### 接口与抽象类的区别

1. 接口中不能有方法的具体实现
2. 变量只能是public static final类型的
3. 不能含有静态代码块和静态方法(jdk 1.8之前)
4. 一个类只能继承一个抽象类，但是可以实现多个接口

#### 接口声明

```java
[可见度] interface 接口名称 [extends 其他接口名] {
    //声明变量
    //抽象方法
}
```

#### 标记接口

* 没有任何方法的接口成为标记接口
* 标记接口作用
  * 建立一个公共的父接口



## 空指针错误

使用equals()方法式，可以翻转调用保证调用对象不为空指针