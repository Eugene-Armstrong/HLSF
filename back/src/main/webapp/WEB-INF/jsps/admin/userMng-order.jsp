<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>用户活动订单</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        .panel-head {
            line-height: 42px
        }

        .panel-head form {
            display: inline
        }

        .panel-head input {
            display: inline-block;
            margin: 0 5px;
            width: 200px;
        }
        .order-id{display: none}
        .pagination{margin-bottom: 30px}
        .pagination .active{
            background: #337ab7!important;
        }
        .active a{
            color: #fff!important;
        }
        .pagination  a{
            border: 1px solid #eee!important;
        }
        .message{margin:20px 20px 0 20px}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-file-text-o"></span> 活动订单详情</strong>
        <span style="float: right;margin-right: 20px">
            <a href="javascript:history.back()" class="icon-reply"> 返回</a>
        </span>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th>订单编号</th>
            <th>付款方式</th>
            <th>付款时间</th>
            <th>订单状态</th>
            <th>订单金额</th>
            <th>操作</th>
        </tr>

            <tr>
                <td class="order-id">${order.id}</td>
                <td>${order.merOrderNumber}</td>
                <td>${fns:getDictLabel('payment',order.payment,'')}</td>
                <td><fmt:formatDate value="${order.payTime}"
                                    pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td><span></span>${fns:getDictLabel('orderState',order.state ,'')}</td>
                <td>${order.price * 0.01}</td>
                <td><a href="${ctx}/admin/order/show?id=${order.id}">订单详情</a></td>
            </tr>

    </table>
</div>

<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
</body>
</html>
