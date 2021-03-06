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
    <title>活动详情</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        .panel-head{line-height: 42px}
        .dialog-body img{width: 100%}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-cube"></span> 活动详情</strong>
        <a href="javascript:history.back()" style="margin-right: 5px"
           class="button border-blue float-right">返回</a>
    </div>
    <table class="table table-hover text-center table-bordered">
        <tr>
            <th style="display: none">活动ID</th>
            <th>名称</th>
            <th>价格</th>
            <th>出发时间</th>
            <th>集合地点</th>
            <th>成行人数</th>
            <th>参加人数</th>
            <th>状态</th>
            <th>截止报名时间</th>
            <th>结束时间</th>
        </tr>
        <tr>
            <td style="display: none">${act.id}</td>
            <td>${act.product.name}</td>
            <td>${act.price * 0.01}</td>
            <td><fmt:formatDate value="${act.departTime}"
                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>${act.gatherPlace}</td>
            <td>${act.tripNumber}</td>
            <td>${act.totalNumber}</td>
            <td>${act.state}</td>
            <td><fmt:formatDate value="${act.closeTime}"
                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td><fmt:formatDate value="${act.endTime}"
                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
        </tr>
        <tr><td colspan="20"></td></tr>
        <tr>
            <th>群二维码</th>
            <th>城市</th>
            <th>活动创建者</th>
            <th>创建时间</th>
            <th>活动修改者</th>
            <th>修改时间</th>
            <th>活动介绍</th>
            <th>活动行程</th>
            <th>费用说明</th>
        </tr>
        <tr>
            <td><a href="#">二维码链接</a></td>
            <td>${city.name}</td>
            <td>${act.createUser.realName}</td>
            <td><fmt:formatDate value="${act.createTime}"
                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>${act.updateUser.realName}</td>
            <td><fmt:formatDate value="${act.updateTime}"
                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td><a href="#" class="button border-blue dialogs" data-toggle="click"
                   data-target="#introduce" data-mask="1" data-width="400px">查看</a></td>
            <td><a href="#" class="button border-blue dialogs" data-toggle="click"
                   data-target="#process" data-mask="1" data-width="400px">查看</a></td>
            <td><a href="#" class="button border-blue dialogs" data-toggle="click"
                   data-target="#cost" data-mask="1" data-width="400px">查看</a></td>
        </tr>
    </table>
</div>
<!--活动介绍模态框-->
<div id="introduce">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>查看活动介绍</strong>
        </div>
        <div class="dialog-body" style="max-height:70vh;overflow: scroll;overflow-x: hidden">
            ${act.productIntroduce}
        </div>
        <div class="dialog-foot">
            <button class="button dialog-close">
                关闭</button>
        </div>
    </div>
</div>
<!--活动行程模态框-->
<div id="process">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>查看活动行程</strong>
        </div>
        <div class="dialog-body" style="max-height:70vh;overflow: scroll;overflow-x: hidden">
            ${act.route}
        </div>
        <div class="dialog-foot">
            <button class="button dialog-close">
                关闭</button>
        </div>
    </div>
</div>
<!--费用说明模态框-->
<div id="cost">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>查看费用说明</strong>
        </div>
        <div class="dialog-body" style="max-height:70vh;overflow: scroll;overflow-x: hidden">
            ${act.priceIntroduce}
        </div>
        <div class="dialog-foot">
            <button class="button dialog-close">
                关闭</button>
        </div>
    </div>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
</body>
</html>
