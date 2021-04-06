[toc]

# redis

## 安装启动

- Windows
  - 启动redis：``redis-server.exe redis.windows.conf``
  - 客户端连接服务器：`redis-cli.exe -h 127.0.0.1 -p 6379`

- Linux：`./src/redis-server`

- Ubuntu：
  1. `sudo apt-get update`
  2. ``sudo apt-get install redis-server`
  3. `redis-server`
  4. `redis-cli`





## 数据类型

### String

- 一个key对应一个value
- 二进制安全，可以包含任何数据
- 最大储存512MB

[string](https://www.runoob.com/redis/redis-strings.html)

### Hash

- 键值对集合
- string类型的field和value的映射表，适合用于存储对象
- 每个hash可以存储2^32^-1个键值对

[hash](https://www.runoob.com/redis/redis-hashes.html)

### List

* 简单的字符串列表
* 可以向头部或者尾部添加元素
* 可以存储2^32^-1个元素

[list](https://www.runoob.com/redis/redis-lists.html)

### Set

* String类型的无序集合
* 通过哈希表实现，增删查的都是O(1)
* 添加一个string到set集合中，成功返回1，如果元素已经在集合中返回0

[set](https://www.runoob.com/redis/redis-sets.html)

### Zset

* String类型的有序集合
* 每个元素关联一个double类型的分数，按照从小到大的顺序排序
* 成员唯一，分数可以重复

[zset](runoob.com/redis/redis-sorted-sets.html)

## Redis HyperLogLog

> Redis HyperLogLog 是用来做基数统计的算法，HyperLogLog 的优点是，在输入元素的数量或者体积非常非常大时，计算基数所需的空间总是固定 的、并且是很小的。
>
> 在 Redis 里面，每个 HyperLogLog 键只需要花费 12 KB 内存，就可以计算接近 2^64 个不同元素的基 数。这和计算基数时，元素越多耗费内存就越多的集合形成鲜明对比。
>
> 但是，因为 HyperLogLog 只会根据输入元素来计算基数，而不会储存输入元素本身，所以 HyperLogLog 不能像集合那样，返回输入的各个元素。

### 什么是基数

比如数据集 {1, 3, 5, 7, 5, 7, 8}， 那么这个数据集的基数集为 {1, 3, 5 ,7, 8}, 基数(不重复元素)为5。 基数估计就是在误差可接受的范围内，快速计算基数。

## 发布订阅

在频道redisChat发布两条消息

![image-20200819155739538](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200819155739538.png)

订阅redisChat 的频道收到两条消息

​			订阅者1：

![image-20200819155759144](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200819155759144.png)

​			订阅者2

![image-20200819155819157](C:\Users\曹粤文\AppData\Roaming\Typora\typora-user-images\image-20200819155819157.png)

[redis发布订阅命令](https://www.runoob.com/redis/redis-pub-sub.html)

## 事务

事务开始到执行的三个阶段

* 开始事务
* 命令入队
* 执行事务

[事务命令](https://www.runoob.com/redis/redis-transactions.html)

## 服务器

[服务器命令](https://www.runoob.com/redis/redis-server.html)

## 数据备份与恢复

`save`创建当前数据库的备份

## 安全

`CONFIG GET requirepass`查看是否设置密码验证

`CONFIG SET requirepass`设置密码验证

设置密码验证后需要验证密码才能执行命令

`AUTH password`密码验证

## 管道技术

> Redis技术可以在服务端为响应时，客户端可以继续向服务端发送请求，并最终一次性读取所有服务端的响应。

## 分区

### 范围分区

### 哈希分区