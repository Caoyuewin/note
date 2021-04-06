[TOC]

# [RSA](https://blog.csdn.net/dbs1215/article/details/48953589?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-3.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-3.channel_param)

## RSA加密(Encryption)

密文 = 明文^E^modN，其中E,N为公钥，记为(E,N)

## RSA解密(Decryption)

明文  = 密文^D^modN, 其中D,N为私钥，记为(D,N)

# 步骤

| 步骤 | 说明         | 描述              |
| ---- | ------------ | ----------------- |
| 1    | 选择两个质数 | P、Q              |
| 2    | 计算公共模数 | N = P * Q         |
| 3    | 欧拉函数     | φ(N) = (P-1)(Q-1) |
| 4    | 计算公钥E    | 1 < E < φ(N)      |
| 5    | 计算私钥D    | E * D % φ(N) = 1  |
| 6    | 加密         | C ＝ M^E^mod N    |
| 7    | 解密         | M ＝C^D^mod N     |

