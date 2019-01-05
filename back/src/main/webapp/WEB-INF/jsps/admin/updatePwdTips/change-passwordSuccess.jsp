<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>修改成功</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <script src="${ctx}/js/jquery.js"></script>
    <script src="${ctx}/js/pintuer.js"></script>
    <script type="text/javascript">
        window.onload =function() { //倒计时
            var i = 3;
            setInterval(function(){
                if(i == 1) {location.href = "${ctx}/admin/media/list"}
                document.getElementById("count").innerHTML = i--;
            },1000);
        };
    </script>
    <style>
        .icon-check {
            font-size: 20px;
        }
        .form-x {
            color: #0ae;
            line-height: 20px;
            padding: 0 10%
        }
        .form-x a{color: #0ae;}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-lock"></span> 修改我的密码</strong>
    </div>
    <div class="body-content">
        <form method="post" class="form-x" action="">
            <span class="icon-check">
                <b>密码修改成功！ o(*￣▽￣*)ブ</b>
            </span>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="${ctx}/admin/media/list"><span id="count">3</span> 秒后返回</a>
        </form>
    </div>
</div>
</body>
</html>
