<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>已下架产品</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body{padding: 50px 0}
        /*活动*/
        /*底部导航*/
        .weui-tabbar{position: fixed;bottom: 0}
        .tip{
            margin-top: 50px;
            text-align: center;
            color: #999
        }
        img{width: 50%;max-width: 300px}
        a{color: #679aff}
    </style>
</head>
<body>
<!--版头-->
<div class="page-title">
    <a href="javascript:history.back()" class="return"></a>
    产品已下架
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}"><img src="${ctx}/images/topbar-home.png" class="go-home"></a>
</div>
<!--提示-->
<div class="tip">
    <img src="${ctx}/images/offsale.png" alt=""><br>
    此产品已下架，去<a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}">首页</a>看看吧~
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/fastclick.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        FastClick.attach(document.body);
    })
</script>
</body>
</html>