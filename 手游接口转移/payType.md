

# payType

```php
//将channel:appstore键值对放到request中
if (empty($request->channel)){
    $request->merge(['channel' => 'appstore']);
}
```

用到的表：

- switch_pay
- switch_third_lib

TODO：向接口文档中添加set_ums_wx_sdk字段

数据库中的银联微信英文名：UmsWxPay

PHP工程中银联微信英文名：UmpWxPay

缓存策略

|      |                     | 价格 |
| ---- | ------------------- | ---- |
| CPU  | 3600x               | 1260 |
| GPU  | 七彩虹1660s         | 1870 |
| 主板 | 华硕B550M-PLUS wifi | 739  |
| 内存 | 芝奇8g*2            | 459  |
| 电源 | 鑫谷GP600G 600w     | 349  |
| 散热 | 九州神风            | 69   |
| 固态 | 西数蓝盘1T          | 789  |
| 机箱 | 安钛克DP501         | 299  |
|      |                     |      |

