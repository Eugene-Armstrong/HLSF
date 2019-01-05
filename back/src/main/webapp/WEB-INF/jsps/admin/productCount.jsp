<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>产品统计</title>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
        .input {
            display: inline !important;
            width: 25%;
        }
        .panel-head form{display: inline}
        form{display: inline}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-cubes"></span> 产品统计</strong>
        <form:form id ="searchForm" action="${ctx}/productCount/productCountPage" method="post" modelAttribute="productCountVo">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <form:select path="cityId" class="input" onchange="change()">
                <option value="">请选择出发城市</option>
                <c:forEach items="${cityList}" var="citys">
                    <form:option value="${citys.id}">${citys.name}</form:option>
                </c:forEach>
            </form:select>
            <form:select path="media"  class="input" onchange="change()">
                <form:option value="">请选择线路种类</form:option>
                <form:option value="12">省内短线</form:option>
                <form:option value="13">国内长线</form:option>
                <form:option value="14">境外长线</form:option>
                <form:option value="15">团队出行</form:option>
            </form:select>
            <%--<form:select path="orders" class="input" onchange="change()">--%>
                <%--<form:option value="productBuyNumber">按-购买次数-排列</form:option>--%>
                <%--<form:option value="productReadNumber">按-浏览次数-排列</form:option>--%>
                <%--<form:option value="productCollectionNumber">按-收藏次数-排列</form:option>--%>
                <%--<form:option value="productSumMoney">按-交易金额-排列</form:option>--%>
            <%--</form:select>--%>
            <button class="button border-blue float-right" onclick="change(${pageInfo.pageNum})">
                查询 <span class="icon-search-plus"></span>
            </button>
            <form:input type="text" class="input float-right" style="margin-right: 5px"
                        name="searchtxt" placeholder="输入产品名进行查询" path="searchtxt"/>
        </form:form>
    </div>
    <form id="productShow">
        <table class="table table-hover text-center">
            <tr>
                <th style="display: none">产品ID</th>
                <th width="10%">序号</th>
                <th width="30%">产品名（活动名）</th>
                <th width="10%">购买次数</th>
                <th width="10%">浏览次数</th>
                <th width="10%">收藏人数</th>
                <th width="10%">交易额</th>
                <th width="20%">参与用户信息</th>
            </tr>
            <c:forEach items="${pageInfo.list}" var="product" varStatus="status">
                <tr>
                    <td style="display: none">${product.productId}</td>
                    <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                    <td>${product.productName}</td>
                    <td>${product.productBuyNumber}</td>
                    <td>${product.productReadNumber}</td>
                    <td>${product.productCollectionNumber}</td>
                    <td>${product.productSumMoney * 0.01}</td>
                    <td><a href="${ctx}/productCount/checkUsersMessageByProductId?productId=${product.productId}">查看</a></td>
                </tr>
            </c:forEach>
        </table>
    </form>
    <c:if test="${pageInfo.list == []}">
        <div style="width: 100%;margin: 30px;text-align: center;font-size: 18px">
            <span class="icon-warning"></span> 暂无产品数据</div>
    </c:if>
</div>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp"%>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
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

    /**
     * 下拉框表单刷新
     * @returns {boolean}
     */
    function change() {
        $('#pageNumber').val(1);
        $('#searchForm').submit();
        return false;
    }
</script>
</body>
</html>
