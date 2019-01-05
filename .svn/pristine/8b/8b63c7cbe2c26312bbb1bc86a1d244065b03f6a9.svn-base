<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>免责声明</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        .page-title {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 999;
            background: #679aff;
            color: #fff;
            font-size: 16px;
            padding: 10px 0;
            text-align: center;
        }
        .return {
            position: absolute;
            left: 10px;
            width: 20px;
            height: 20px;
            background: url("${ctx}/images/return.png");
            background-size: cover;
        }
        .go-home{
            position: absolute;
            right: 10px;
            width: 22px;
            height: 22px;
        }
        a {color: #fff}
        .disclaimer-content{
            margin-top: 40px;
            padding: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body style="height: auto;background: #fafafa">
<div class="page-title">
    <a href="javascript:history.back()" class="return"></a>
    免责声明
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}"><img src="${ctx}/images/topbar-home.png" class="go-home"></a>
</div>
<div class="disclaimer-content">${product.disclaimer}</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/fastclick.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        FastClick.attach(document.body);
    });
</script>
</body>
</html>