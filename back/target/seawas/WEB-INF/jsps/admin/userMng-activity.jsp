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
    <title>用户活动列表</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        .panel-head{line-height: 42px}
        .message{margin-top: 20px}
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
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-cube"></span> 活动列表</strong>
        <span style="float: right;margin-right: 20px">
            <a href="javascript:history.back()" class="icon-reply"> 返回</a>
        </span>
    </div>
    <div class="padding border-bottom" style="overflow: hidden">
       <%-- <span style="float: right">
            <a style="margin-right: 20px" class="icon-plus-square-o" href="${ctx}/activity/toAddActivity?productId=${productId}"> 添加活动</a>
            <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 删除活动</a>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>--%>
    </div>
    <table class="table table-hover text-center">
        <c:if test="${activityPageInfo.list == []}">
            <div style="width: 100%;margin: 30px;text-align: center;font-size: 18px">
                <span class="icon-warning"></span> 该用户暂未参与过任何活动
            </div>
        </c:if>
        <c:if test="${activityPageInfo.list != []}">
            <tr>
                    <%--<th>
                        全选 <input type="checkbox" value="all">
                    </th>--%>
                <th style="display: none">活动ID</th>
                <th  width="14%">活动名称</th>
                <th width="5%">价格</th>
                <th width="14%">出发时间</th>
                <th width="10%">集合地点</th>
                <th width="7%">成行人数</th>
                <th width="7%">人数上限</th>
                <th width="5%">状态</th>
                <th width="14%">截止报名时间</th>
                <th width="14%">结束时间</th>
                <th width="13%">操作</th>
            </tr>
            <c:forEach items="${activityPageInfo.list}" var="act">
                <tr>
                        <%-- <td class="ckb"><input type="checkbox"></td>--%>
                    <td style="display: none">${act.id}</td>
                    <td>${act.product.name}</td>
                    <td><fmt:formatNumber value="${act.price * 0.01}" pattern="0.0#"/></td>
                    <td><fmt:formatDate value="${act.departTime}"
                                        pattern="yyyy-MM-dd HH:mm" /></td>
                    <td>${act.gatherPlace}</td>
                    <td>${act.tripNumber}</td>
                    <td>${act.totalNumber}</td>
                    <td>${act.state}</td>
                    <td><fmt:formatDate value="${act.closeTime}"
                                        pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td><fmt:formatDate value="${act.endTime}"
                                        pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td>
                        <a href="${ctx}/user/admin/showActivityDetail?activityId=${act.id}">详情</a> /
                        <a href="${ctx}/user/admin/order?activityId=${act.id}&userId=${userId}">订单</a>
                            <%--/ <a href="${ctx}/activity/toActivityChange?productId=${productId}&id=${act.id}">修改</a>--%>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>
</div>
<!-- 页数 -->
<div class="message">
    共<i class="blue">${activityPageInfo.total}</i>条记录，当前显示第&nbsp;<i
        class="blue">${activityPageInfo.pageNum}/${activityPageInfo.pages}</i>&nbsp;页
</div>
<div style="text-align:center;margin-top: -20px">
    <ul class="pagination">
        <!-- <li><a href="#">&laquo;</a></li> -->
        <c:if test="${!activityPageInfo.isFirstPage}">
            <li><a href="${ctx}/user/admin/userGone?pageNumber=1&pageSize=${activityPageInfo.pageSize}&userId=${userId}">首页</a></li>
            <li><a href="${ctx}/user/admin/userGone?pageNumber=${activityPageInfo.prePage}&pageSize=${activityPageInfo.pageSize}&userId=${userId}">上一页</a></li>
        </c:if>
        <c:forEach items="${activityPageInfo.navigatepageNums}" var="navigatepageNum">
            <c:if test="${navigatepageNum==activityPageInfo.pageNum}">
                <li class="active"><a href="${ctx}/user/admin/userGone?pageNumber=${navigatepageNum}&pageSize=${activityPageInfo.pageSize}&userId=${userId}">${navigatepageNum}</a></li>
            </c:if>
            <c:if test="${navigatepageNum!=activityPageInfo.pageNum}">
                <li><a href="${ctx}/user/admin/userGone?pageNumber=${navigatepageNum}&pageSize=${activityPageInfo.pageSize}&userId=${userId}">${navigatepageNum}</a></li>
            </c:if>
        </c:forEach>
        <c:if test="${!activityPageInfo.isLastPage}">
            <li><a href="${ctx}/user/admin/userGone?pageNumber=${activityPageInfo.nextPage}&pageSize=${activityPageInfo.pageSize}&userId=${userId}">下一页</a></li>
            <li><a href="${ctx}/user/admin/userGone?pageNumber=${activityPageInfo.pages}&pageSize=${activityPageInfo.pageSize}&userId=${userId}">最后一页</a></li>
        </c:if>
    </ul>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
</body>
</html>
