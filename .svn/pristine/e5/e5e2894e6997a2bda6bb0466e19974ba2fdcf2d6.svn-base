<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>注册用户统计</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <style>
        .panel-head {
            line-height: 42px
        }
        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
        td img {
            width: 64px;
            height: 64px;
            border-radius: 50%;
        }
        .table td{vertical-align: middle!important;}
        form{display: inline}
        .pagination{margin: 0}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-table"></span> 注册用户统计</strong>
        <form:form id="searchForm"  action="${ctx}/admin/totalCount/showDataCountUsers" method="post">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
        </form:form>
        <a href="${ctx}/admin/totalCount/showTotalCount" class="button border-blue float-right">返回</a>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th width="10%">序号</th>
            <th width="20%">用户头像</th>
            <th width="25%">昵称</th>
            <th width="20%">真实姓名</th>
            <th width="25%">注册时间</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="user" varStatus="status">
            <tr>
                <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                <td><img src="${user.headImgUrl}" alt=""></td>
                <td>${user.nickName}</td>
                <td>${user.realName}</td>
                <td><fmt:formatDate value="${user.createTime}"
                                    pattern="yyyy-MM-dd HH:mm:ss"/>
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
