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
<h1 class="web-h1">失败</h1>
<div class="wrapper">
    <img src="/static/img/jdpay/failure-ico.png" class="succeed-ico">
    <div class="success-tit">支付失败！</div>
    <form action="/jdPay/gotojdpay" id="myform">
    <input type="hidden" name="amount" value="${amount}"/>
    <input type="hidden"  name="userId" value="${userId}"/>
    <input type="hidden" name="tradeName" value="${tradeName}"/>
    <input type="hidden" name="source" value="${source}"/>
    <input type="hidden" name="orderId" value="${orderId}"/>
    <input type="hidden" name="period" value="${period}"/>
    <div class="success-btn"><a href="#" onclick="submit()">重新支付</a><a href="returnOrder">返回订单</a></div>
    </form>
</div>
</body>
<script>
    function submit(){
        document.getElementById("myform").submit();
    }
</script>
</html>
