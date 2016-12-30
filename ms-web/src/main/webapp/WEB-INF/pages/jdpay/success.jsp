<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0, minimal-ui" />
    <meta name="format-detection" content="email=no" />
    <meta name="format-detection" content="address=no" />
    <meta name="format-detection" content="telephone=no" />
    <title>在线支付 | 桔子分期</title>
    <meta name="keywords" content="桔子分期,大学生分期,大学生分期网,手机分期,笔记本分期,相机分期,大学生分期付款,大学生兼职">
    <meta name="description" content="桔子分期是一家专注于年轻人分期购物的在线商城及金融服务平台，所有商品100%正品行货,支持全网分期,产品以限时特卖、零首付分期付款为主，是国内领先的年轻人分期消费服务商。">
    <meta name="copyright" content="Copyright (c) juzifenqi.com">
    <link rel="stylesheet" href="/static/css/jdpay/reset.css" type="text/css" />
    <link rel="stylesheet" href="/static/css/jdpay/zxzf.css" type="text/css" />
    <script type="text/javascript">
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?47643296f155da8f6542057f90e97247";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
</head>
<body>
<h1 class="web-h1">成功</h1>
<div class="wrapper">
    <img src="/static/img/jdpay/succeed-ico.png" class="succeed-ico">
    <div class="success-tit">支付成功！</div>
    <div class="success-zffs">支付方式：京东支付</div>
    <div class="success-zffs">支付金额:<span>¥${tradeAmount}</span></div>
    <div class="success-btn"><a href="showDetail">查看订单</a><a href="backHome">回首页</a></div>
</div>
</body>
</html>
