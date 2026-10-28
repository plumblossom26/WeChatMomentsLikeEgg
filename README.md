# 朋友圈点赞彩蛋

微信 **8.0.80+** 强开朋友圈点赞彩蛋，注入后发圈页面查看。

## 编译

需要 [Theos](https://theos.dev)。默认打无根：

```bash
export THEOS=/opt/theos
make FINALPACKAGE=1 package
```

有根 / 隐根：`SCHEME=rootful` 或 `SCHEME=roothide`。一次打三份：`./package-all.sh`



## 预览图

发送方式：

![发送方式预览](预览/发送方式预览.png)

点赞效果：

![点赞效果预览](预览/点赞效果预览.jpeg)



## 如何测试

1. 仅支持微信 8.0.80 及以上。

2. 发表朋友圈，看有没有设置彩蛋页面。

3. 带彩蛋的动态，列表点赞应能播官方动画。

   

## License

MIT
