<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>总成交量统计</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <style>
        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
        td img{
            width: 180px;
            height: 80px;
        }
        .table td{vertical-align: middle!important;}
        form{display: inline}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-table"></span> 总成交量统计</strong>
        <form:form id ="searchForm" action="${ctx}/admin/totalCount/showDataCountTotalNum" method="post" modelAttribute="city">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <form:select path="id" class="input" onchange="form.submit()">
                <form:option value="">请选择所在城市</form:option>
                <c:forEach items="${cityList}" var="citys">
                    <form:option value="${citys.id}">${citys.name}</form:option>
                </c:forEach>
            </form:select>
        </form:form>
        <a href="${ctx}/admin/totalCount/showTotalCount" class="button border-blue float-right">返回</a>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th width="10%">序号</th>
            <th width="20%">产品图片</th>
            <th width="20%">产品名称</th>
            <th width="15%">总成交量</th>
            <th width="15%">总成交金额(元)</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="product" varStatus="status">
            <tr>
                <td>${ status.index + 1 + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                <td><img src="/photo/product/${product.picUrl}" alt=""></td>
                <td>${product.name}
                </td>
                <td>
                        ${product.vol}
                </td>
                <td>
                    <fmt:formatNumber value="${product.volPrice * 0.01}" pattern="0.##"/>
                </td>
            </tr>
        </c:forEach>
    </table>
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
</script>
</body>
</html>
