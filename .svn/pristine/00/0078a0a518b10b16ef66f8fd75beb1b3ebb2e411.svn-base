<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>活动订单</title>
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
        .empty-tip{width: 100%;text-align: center;padding: 20px 0;line-height: 20px;color: #999}
        #empty{width: 200px;opacity: .5}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-file-text-o"></span> 活动订单列表</strong>
        <c:if test="${pageInfo.list!=[]}">
            <button class="button border-blue float-right">导出Excel表格</button>
        </c:if>
        <span style="float: right;margin-right: 20px">
            <a href="javascript:history.back()" class="icon-reply"> 返回</a>
        </span>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th>订单编号</th>
            <th>用户昵称</th>
            <th>付款方式</th>
            <th>付款时间</th>
            <th>订单状态</th>
            <th>订单金额</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="ord">
            <tr>
                <td class="order-id">${ord.id}</td>
                <td>${ord.merOrderNumber}</td>
                <td>${ord.user.nickName}</td>
                <td>${fns:getDictLabel('payment',ord.payment,'')}</td>
                <td><fmt:formatDate value="${ord.payTime}"
                                    pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td><span></span>${fns:getDictLabel('orderState',ord.state ,'')}</td>
                <td>${ord.price * 0.01}</td>
                <td><a href="${ctx}/admin/order/show?id=${ord.id}">订单详情</a></td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${pageInfo.list==[]}">
        <div class="empty-tip">
            <img src="${ctx}/images/empty-pic.png" id="empty">
            <br>该活动暂未有订单哦~ (｡･ω･｡)
        </div>
    </c:if>
</div>
<div class="message">
    共<i class="blue">${pageInfo.total}</i>条记录，当前显示第&nbsp;<i
        class="blue">${pageInfo.pageNum}/${pageInfo.pages}</i>&nbsp;页
</div>
<div style="text-align:center;margin-top: -20px">
    <ul class="pagination">
        <!-- <li><a href="#">&laquo;</a></li> -->
        <c:if test="${!pageInfo.isFirstPage}">
            <li><a href="${ctx}/admin/activityOrders/toActivityOrders?pageNumber=1&pageSize=${pageInfo.pageSize}&activityId=${activityId}">首页</a></li>
            <li><a href="${ctx}/admin/activityOrders/toActivityOrders?pageNumber=${pageInfo.prePage}&pageSize=${pageInfo.pageSize}&activityId=${activityId}">上一页</a></li>
        </c:if>
        <c:forEach items="${pageInfo.navigatepageNums}" var="navigatepageNum">
            <c:if test="${navigatepageNum==pageInfo.pageNum}">
                <li class="active"><a href="${ctx}/admin/activityOrders/toActivityOrders?pageNumber=${navigatepageNum}&pageSize=${pageInfo.pageSize}&activityId=${activityId}">${navigatepageNum}</a></li>
            </c:if>
            <c:if test="${navigatepageNum!=pageInfo.pageNum}">
                <li><a href="${ctx}/admin/activityOrders/toActivityOrders?pageNumber=${navigatepageNum}&pageSize=${pageInfo.pageSize}&activityId=${activityId}">${navigatepageNum}</a></li>
            </c:if>
        </c:forEach>
        <c:if test="${!pageInfo.isLastPage}">
            <li><a href="${ctx}/admin/activityOrders/toActivityOrders?pageNumber=${pageInfo.nextPage}&pageSize=${pageInfo.pageSize}&activityId=${activityId}">下一页</a></li>
            <li><a href="${ctx}/admin/activityOrders/toActivityOrders?pageNumber=${pageInfo.pages}&pageSize=${pageInfo.pageSize}&activityId=${activityId}">最后一页</a></li>
        </c:if>
    </ul>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        //导出表格
        $(".panel-head button").click(function () {
            var listID = "";
            if (${ordersList.size() > 0}){
                <c:forEach items="${ordersList}" var="t">
                    listID += "${t.id}" + ",";
                </c:forEach>
                window.open("${ctx}/admin/activityOrders/exportExcel?orderId=" + listID);
            }
        })
    });
</script>
</body>
</html>
