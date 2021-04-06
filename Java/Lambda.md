# Lambda

- **可选类型声明：**不需要声明参数类型，编译器可以统一识别参数值。
- **可选的参数圆括号：**一个参数无需定义圆括号，但多个参数需要定义圆括号。
- **可选的大括号：**如果主体包含了一个语句，就不需要使用大括号。
- **可选的返回关键字：**如果主体只有一个表达式返回值则编译器会自动返回值，大括号需要指定明表达式返回了一个数值。

```java
public class Test{
	interface MathOperation{
	    int operation(int a, int b);
	}
	interface GreetingService{
    	void sayMessage(String message);
	}
	private int operate(int a, int b, MathOperation mathOperation){
    	return mathOperation.operation(a,b);
	}
    public static void main(String args[]){
        Test test = new Test();
        
        //有类型声明
        MathOperation addition = (int a, int b) -> a + b;
        //无类型声明
        MathOperation subtraction = (a,b) -> a - b;
        //大括号中的返回语句
        MathOperation mul = (int a, int b) -> {return a * b}
        //没有大括号及返回语句
        MathOperation division = (int a, int b) -> a / b;
        
        //
        test.operate(10,5,addition);
        test.operate(10,5,subtraction);
       
        //不用括号
        GreetingService greetService1 = message -> System.out.println("hello" + message);
        //用括号
        GreetingService greetService2 = (message) -> System.out.println("hello" + message);
    }
}



```

Lambda表达式可以访问外层的局部变量，但是不能修改，lambda表达式的局部变量不用声明为final，但是必须不可被后面的代码修改，隐形的具有final语义





## 函数式接口

> 函数式接口是仅含一个抽象方法的接口，但可以指定Object定义的任何公有方法

以下两个都是函数式接口

```java

@FunctionalInterface
public interface IFunctionSum<T extends Number> {
    T sum(List<T> numbers);
}
```

```java
@FunctionalInterface
public interface IFunctionMulti<T extends Number> {
    void multi(List<T> numbers);

    boolean equals(Object object);
}
```

[Lambda教程](https://www.jianshu.com/p/613a6118e2e0)