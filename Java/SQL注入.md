# Day10

## JDBC

### 连接数据库

1. 初始化url，user，password
2. 加载驱动
3. 获取连接

### SQL注入问题



Statement SQL注入问题：系统没有对用户输入的数据进行充分的检查，而在用户输入数据中注入非法的SQL语句段或命令：`SELECT user,password,FROM user_table WHERE user = '1' OR ' AND password  = '=1' OR '1' = '1'`

为了避免SQL注入问题，需要用PrepareStatement取代Statement

### PrepareStatement

预编译SQL语句

