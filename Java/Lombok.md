# Lombok

## 常用注解

### val/var

public void testValAndVar() {
    val a = 10;
    var b = "Salah";
    System.out.println(a);
    System.out.println(b);
    
    //会编译报错
    a = 9;
    b = "Mane";
}

![image-20200817195024113](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200817195024113.png)

### @Getter/@Setter

```java
public class LomBokTestClass {
    public static void main(String[] args) {
        LomBokTestClass lomBokTestClass = new LomBokTestClass();
        lomBokTestClass.setName("Salah");
        System.out.println(lomBokTestClass.getName());
    }
    @Setter
    @Getter
    private String name;

    @Setter
    @Getter
    private Integer age;

    @Setter
    private String address;

    @Getter(AccessLevel.PROTECTED)
    @Setter
    private String password;
}

```



### @Data

@ToString,@EqualsAndHashCode,@Getter/@Setter,@RequiredArgsConstructor的集合