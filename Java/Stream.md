[toc]

# Stream

```java
public class StreamTest {
    public static void main(String[] args) {
        List<String> strings = Arrays.asList("abc", "", "bc", "efg", "abcd", "", "jkl");
        List<Integer> numbers = Arrays.asList(3, 2, 2, 3, 7, 3, 5);

        System.out.println("列表：" + strings);
        long count = strings.stream().filter(string -> string.isEmpty()).count();
        System.out.println("空字符串数量为：" + count);

        count = strings.stream().filter(s -> s.length() == 3).count();
        System.out.println("字符创长度为3的数量:" + count);

        String collect = strings.stream().filter(s -> !s.isEmpty()).collect(Collectors.joining(","));
        System.out.println(collect);

        System.out.println(numbers);
        List<Integer> squareList = numbers.stream().map(n -> n * n).distinct().collect(Collectors.toList());
        System.out.println(squareList);

        IntSummaryStatistics stat = numbers.stream().mapToInt((x) -> x).summaryStatistics();
        System.out.println("列表中最大的数：" + stat.getMax());

        System.out.println("输出10个随机整数:");
        Random random = new Random();
        random.ints().limit(10).sorted().forEach(System.out::println);

        System.out.println("并行流");
        count = strings.parallelStream().filter(s -> s.isEmpty()).count();
        System.out.println(count);

    }
}
```