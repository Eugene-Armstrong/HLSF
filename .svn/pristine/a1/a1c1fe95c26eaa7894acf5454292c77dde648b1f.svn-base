<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>访问错误</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <style type="text/css">
        body {
            background: url(${ctx}/images/bg.jpg) no-repeat;
            background-position: 40% 0;
            font-family: "微软雅黑";
        }
        .container {
            margin-top: 15%;
            width: 100%;
            text-align: center;
            color: #6bbaa3;
            vertical-align: middle;
        }
        .container a{color: #6bbaa3;text-decoration: none}
        .container_1 img,.container_2 img{width: 50%;max-width: 200px}
        .weui-btn{
            margin: 15px auto;
            width: 80%!important;
            max-width: 400px;
            font-size: 16px
        }
    </style>
</head>
<body>
<div class="container">
    <div class="container_1"><img src="${ctx}/images/404.png"></div>
    <div class="container_2"><img src="${ctx}/images/cry.gif"></div>
    <div class="container_3">
        <div class="container_3_1"><span>SORRY…你要访问的页面弄丢了<br><br></span></div>
        <div class="container_3_2">
            <a href="javascript:history.back()">
                <button class="weui-btn weui-btn_primary">返回上一页</button>
            </a>
            <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}">
                <button class="weui-btn weui-btn_primary">返回首页</button>
            </a>
        </div>
    </div>
</div>
</body>
</html>