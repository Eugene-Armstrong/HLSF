﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>登录</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css"/>
    <style type="text/css">
        body {
            background: url("${ctx}/images/bg.png") no-repeat;
            background-size: cover;
            background-attachment: fixed;
        }
        li {
            list-style: none;
        }
        .container{margin-top: 8%}
        .loginbox {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 2px 4px 10px #a1a1a1;
            border: none;
        }
        .panel-body {
            padding: 10px 30px 0px 30px;
        }
        .form-group {
            margin-bottom: 0;
        }
        .input{width: 100%}
    </style>
    <%--<script type="text/javascript">
        $(function () {
            //根据不同身份登录对应首页
            $("input[type='submit']").click(function () {
                if ($("#inlineRadio1").prop("checked")) {
                    $("form").prop("action", "index.html");
                }else {
                    $("form").prop("action", "index-super.html");
                }
            })
        })
    </script>--%>
</head>
<body>
<div class="bg"></div>
<div class="container">
    <div class="line bouncein">
        <div class="xs6 xm4 xs3-move xm4-move">
            <div class="media media-y margin-big-bottom">
            </div>
            <form action="${ctx}/doLogin" method="post" >
                <div class="panel loginbox">
                    <div class="text-center margin-big padding-big-top">
                        <h1>HLSF 后台管理系统</h1>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="text" class="input input-big"
                                       name="loginName" placeholder="登录帐号"
                                       data-validate="required:请填写账号"/>
                                <span class="icon icon-user margin-small"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="password"
                                       class="input input-big" name="password" placeholder="登录密码"
                                       data-validate="required:请填写密码"/>
                                <span class="icon icon-key margin-small"></span>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body text-red">
                        <c:if test="${tips != null }">
                            <c:out value="${tips.message}"/>
                        </c:if>
                    <%-- <label class="radio-inline">
                            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" checked> 管理员
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> 超级管理员
                        </label>--%>
                        <a href="https://www.baidu.com" target="_blank" style="float: right">忘记密码</a>
                    </div>
                    <div style="padding:20px 30px 30px 30px">
                        <input type="submit"
                               class="button button-block bg-main text-big input-big" value="登录">
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script>
    $(function () {
        $(document).on("input",".input",function () {
            $(".text-red").text("");
        })
    })
</script>
</body>
</html>