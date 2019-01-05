<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>哎呀！</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <style type="text/css">
        body {
            background-image: url(${ctx}/images/404-bg.jpg);
            background-position: 40% 0;
            font-family: "微软雅黑";
            max-width: 500px;
        }

        .container {
            margin-left: auto;
            width: 100%;
            margin-right: auto;
            text-align: center;
            margin-top: 25%;
            color: #6bbaa3;
            font: 18px bold;
            line-height: 30px;
        }

        .container_2 img{width: 50%;}
    </style>
</head>
<body>
<div class="container">
    <div class="container_2"><img src="${ctx}/images/505.png"></div>
    <div>
        <div><br>SORRY…</div>
        <div>服务器正在维护中，请稍后再试</div>
    </div>
</div>
</body>
</html>