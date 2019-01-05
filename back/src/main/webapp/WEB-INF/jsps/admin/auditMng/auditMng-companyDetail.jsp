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
    <title>团队定制详情</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        td{text-align: center}
        .panel-head{overflow: hidden;line-height: 40px}
        .panel{text-align: center}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="float-left"><span class="icon-list-alt"></span> 团队定制详情</strong>
        <a class="float-right" href="${ctx}/admin/audit/company" style="margin-right: 15px">
            <span class="icon-reply"></span> 返回</a>
    </div>
    <table class="table table-bordered table-hover">
        <tr>
            <th>用户名</th>
            <th>定制类型</th>
            <th>企业名称</th>
            <th>参与人数</th>
            <th>平均年龄</th>
            <th>价格预算</th>
            <th>出发城市</th>
            <th>出发时间</th>
            <th>联系人</th>
            <th>联系电话</th>
        </tr>
        <tr>
            <td>${custom.user.nickName}</td>
            <td>团队定制</td>
            <td>${custom.name}</td>
            <td>${custom.number}</td>
            <td>${custom.price}</td>
            <td>${custom.averageAge}</td>
            <td>${custom.departCity.name}</td>
            <td><fmt:formatDate value="${custom.startTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td>${custom.manaName}</td>
            <td>${custom.manaTel}</td>
        </tr>
        <tr>
            <td style="border: none" colspan="11"></td>
        </tr><tr>
        <td style="border: none" colspan="11"></td>
    </tr>
        <tr>
            <th colspan="2">申请时间</th>
            <th colspan="4">目的</th>
            <th colspan="4">备注</th>
        </tr>
        <tr>
            <td colspan="2"><fmt:formatDate value="${custom.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td colspan="4">${custom.aim}</td>
            <td colspan="4">${custom.remark}</td>
        </tr>
    </table>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
</body>
</html>
