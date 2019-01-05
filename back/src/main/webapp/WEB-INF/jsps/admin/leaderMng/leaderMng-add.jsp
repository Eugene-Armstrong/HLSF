<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>添加领队</title>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <script src="${ctx}/js/jquery.js"></script>
    <script src="${ctx}/js/pintuer.js"></script>
    <script>
        $(function () {
            $(".set-leader").click(function () {
                $(".dialog-body #user-id").val($(this).parent().siblings(".user-id").find("input").val());
            })
        });
        /**
         * 分页必需
         * @param n
         * @param s
         * @returns {boolean}
         */
        function page(n,s) {
            $('#pageNumber').val(n);
            $('#pageSize').val(s);
            $('#searchForm').submit();
            return false;
        }
    </script>
    <style>
        .panel-head {overflow: hidden}
        .panel-head strong {line-height: 42px}
        .panel-head form{display: inline}
        .panel-head input {
            display: inline !important;
            width: 15% !important;
            margin-left: 5px;
        }
        td img {
            width: 64px;
            border-radius: 50%
        }
        td{vertical-align: middle!important;}
        .dialog-body td {border-top: none}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-users"></span> 添加领队</strong>
        <form:form id="searchForm" modelAttribute="user" action="${ctx}/user/showPrepareLeader" method="post">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <input type="text" class="input float-right" name="phone" placeholder="输入手机号进行查询" value="${user.phone}"/>
            <input type="text" class="input float-right" name="realName" placeholder="输入姓名进行查询"
                   value="${user.realName}"/>
            <button class="button border-blue float-right" type="submit">
                查询 <span class="icon-search-plus"></span>
            </button>
        </form:form>
        <a class="button float-right" href="${ctx}/leader/showIndex"
           style="margin-right: 5px;text-decoration: none"><span class="icon-reply"></span> 返回</a>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th><input type="hidden"/></th>
            <th width="10%">昵称</th>
            <th width="10%">真实姓名</th>
            <th width="10%">头像</th>
            <th width="10%">性别</th>
            <th width="10%">年龄</th>
            <th width="10%">手机</th>
            <th width="30%">身份证号</th>
            <th width="10%">操作</th>
        </tr>
        <c:forEach items="${pageInfo.list }" var="user">
            <tr>
                <td class="user-id"><input type="hidden" value="${user.id}"/></td>
                <td>${user.nickName}</td>
                <td>${user.realName}</td>
                <td>
                    <img src="${user.headImgUrl}" alt="">
                </td>
                <td>${fns:getDictLabel('sex',user.sex,'')}</td>
                <td>${user.age}</td>
                <td>${user.phone}</td>
                <td>${user.certId}</td>
                <td>
                    <a href="#" class="dialogs set-leader" data-toggle="click" data-target="#setleader" data-mask="1"
                       data-width="50%">设为领队</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!--设为领队模态框-->
<div id="setleader">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>设为领队</strong>
        </div>
        <form name="form1" action="${ctx}/user/updatetoLeader">
            <div class="dialog-body">
                <table class="table table-hover">
                    <tr style="display: none">
                        <td class="text-right">userID:</td>
                        <td><input id="user-id" type="text" class="input" name="id" placeholder="请输入ID" required></td>
                    </tr>
                    <tr>
                        <td class="text-right">领队工号：</td>
                        <td><input type="text" class="input" name="workNo" placeholder="请输入领队工号" required></td>
                    </tr>
                    <tr>
                        <td class="text-right">领队评分：</td>
                        <td><input type="number" class="input score" name="score" placeholder="请输入领队初始评分" required></td>
                    </tr>
                </table>
            </div>
            <div class="dialog-foot">
                <button class="button border-blue" type="submit">
                    确定
                </button>
            </div>
        </form>
    </div>
</div>
<script>
    $(function () {
        var score;
        var scoreInput;
        $(document).on("change", ".dialog-body .score", function () {
            scoreInput = $(this);
            score = parseInt(scoreInput.val());
        }).on("click", ".dialog-foot .border-blue", function () {
            if (score < 0) {
                alert("评分不得少于0分，请重新输入");
                scoreInput.val("");
                scoreInput.focus();
                score = scoreInput.val();
                return false;
            }
            if (score > 5) {
                alert("评分不得超过5分，请重新输入");
                scoreInput.val("");
                scoreInput.focus();
                score = scoreInput.val();
                return false;
            }
        })
    });
</script>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp"%>
</div>
</body>
</html>
