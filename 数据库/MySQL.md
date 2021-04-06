[TOC]

# Java-Day6

## MySQl

### INSERT INTO

```sql
INERTO INTO [tablename] (colname1,colname2,colname3) VALUES (val1,val2,val2),(val3,val5,val6).....;
```

### ALTER

```SQL
-- 改变表的字段属性参数
ALTER TABLE tablename MODIFY [columnname] [typename] NOT NULL DEFAULT;
-- 改变表的字段名称属性参数
ALTER TABLE tablename CHANGE [oldname] [newname] [typename] NOT NULL DEFAULT;
```

### LIKE

```SQL
SELECT col1,col2... FROM tablename WHERE colx LIKE '%pattern%';
```

#### 通配符

| 通配符                | 描述                         |
| --------------------- | ---------------------------- |
| %                     | 0个或多个字符                |
| -                     | 一个字符                     |
| [charlist]            | charlist中的任意单一字符     |
| [^charlist/!charlist] | 不在charlist中的任意单一字符 |

### IN

```SQL
-- 
SELECT  col FROM WHERE col IN (val1,val2,val3);
```

### BETWEEN

```SQL
SELECT col FROM tablename WHERE col BETWEEN val1 AND val2;
```

### AS(别名)

```SQL
SELECT col AS alias_name FROM tableame;
```

#### CONCAT

连接几个字段

### VIEWS

```SQL
-- 视图总是显示最新的数据，每当用户查询视图时，数据库引擎通过使用视图的SQL语句重建数据
CREATE VIEW view_name AS SELECT column_name FROM table_name WHERE condition;
```

### enum

更改enum的值

1. 添加新的enum值
2. 更新表中的旧值为新值
3. 删除旧值