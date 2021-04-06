# 新增接口

## 编辑商务聚合后台订单接口

**简要描述：**

- 编辑商务悦玩后台渠道订单

**请求URL：**

- `http://bigdata.hzyuewan.com/support/businessChannel/{pid}`

**请求方式：**

- put 

**参数：**

| 参数名        | 必选 | 类型   | 说明             | type |
| ------------- | ---- | ------ | ---------------- | ---- |
| pid           | 是   | int    | spark程序配置id  | path |
| channel_id    | 是   | string | 渠道id           | body |
| userStartTime | 是   | string | 用户注册开始时间 | body |
| userEndTime   | 是   | string | 用户注册结束时间 | body |
| payStartTime  | 是   | string | 付费开始时间     | body |
| payEndTime    | 是   | string | 付费结束时间     | body |
| remark        | 是   | string | 备注             | body |

**请求示例**

```json
http://bigdata.hzyuewan.com/support/business/channel/1
{
    "channel_id":"",
    "userStartTime":"",
    "userEndTime":"",
    "payStartTime":"",
    "payEndTime":"",
    "remark":""
}
```

