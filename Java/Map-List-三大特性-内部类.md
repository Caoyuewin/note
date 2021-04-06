[TOC]

# Java-Day4

## LinkedList

![img](https://www.runoob.com/wp-content/uploads/2020/06/20190328164737.png)

* 双向链表，插入删除快，查询慢

## ArrayList

![img](https://www.runoob.com/wp-content/uploads/2020/06/arraylist.png)
```java
import java.util.ArrayList;
//E:泛型数据类型，只能为引用数据类型，使用基本类型时需要使用对应的包装类
ArrayList<E> objectName = new ArrayList<>();
```

## HashSet

![img](https://www.runoob.com/wp-content/uploads/2020/07/java-hashset-hierarchy.png)

* 不允许有重复元素
* 无序
* 非线程安全
* HashSet实现Set接口

## HashMap

![img](https://www.runoob.com/wp-content/uploads/2020/07/WV9wXLl.png)

* 散列表，储存键值对

* 实现了Map接口，根据HashCode值储存数据，具有很快的访问速度，最多允许一条记录的键为null，不支持线程同步

  

## Iterator

![img](https://www.runoob.com/wp-content/uploads/2020/07/ListIterator-Class-Diagram.jpg)

```java
Iterator<String> it = objectName.iterator();
```

## 继承

### super和this

super关键字用来实现对父类成员的访问，引用当前对象的父类

this是指向自己的引用

### final

final修饰的类和方法不能再被继承

```java
final class className {}
public final returntype funName() {}
```

## 多态

### 必要条件

1. 继承
2. 重写
3. 父类引用指向子类对象

```java
Parent p = new Child();
```

## 内部类

### 成员内部类

成员内部类可以访问外部类所有成员。当成员内部类与外部类有同名的成员变量或者方法时，会默认访问内部类成员，要访问外部类的同名成员，使用以下方法

```java
外部类.this.成员名
```

外部类要访问内部类的成员，需要先创建一个成员内部类的对象，通过这个对象访问内部类的成员。

要创建一个成员内部类对象，需要先创建一个外部类对象。

成员内部类可以用private和protected修饰符修饰，相当于成员

### 局部内部类

局部内部类的成员仅限在定义所在的方法或作用于中访问，相当与局部变量

### 匿名内部类

用来实现父类或者接口的同时产生一个相应的对象，前提是这个父类或者接口存在

### 静态内部类

不依赖外部对象，可以直接创建静态内部类的对象，静态内部类不能使用外部类的非static成员

## 修饰符

### 访问控制修饰符

![image-20200723161232929](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200723161232929.png)

### 非访问修饰符

static

* static修饰的变量永远只有一份实例，局部变量不能被声明为static
* 静态方法不能使用类的非静态变量

final

* 被final修饰的变量不能被重新赋值，所以final修饰的实例变量必须显式指定初始值
* 与static一起使用来创建类常量
* 父类中的final方法可以被继承，但是不能被重写
* final类不能被继承

synchronized

* synchronized声明的方法同意时间只能被一个线程访问
* synchronized可以应用于四个访问修饰符

transient

* 序列化对象包含被transient修饰的实例变量时，JVM跳过该特定的变量
* 用来预处理类和变量的数据类型

volatile

* volatile修饰的成员变量每次被线程访问时，强制从共享内存中读取该变量的值，若成员发生变化，强制线程将变化值写到共享内存
* volatile对象引用可能是null

## 枚举