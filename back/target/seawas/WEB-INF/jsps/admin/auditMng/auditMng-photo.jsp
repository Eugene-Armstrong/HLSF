<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>相册审核</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <style>
        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
        .pagination {
            margin: 0
        }
        form{display: inline}

    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-check-square-o"></span> 相册审核</strong>
        <form:form id="searchForm" modelAttribute="photo" action="${ctx}/admin/audit/auditPhotoPage" method="post">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <input id="checkState" name="checkState" type="hidden" value="${checkState}">
            <form:select path="state" id="state" class="input" onchange="showAnotherState()">
                <form:options items="${fns:getDictList('photoState')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </form:form>
    </div>
    <table id="todo" class="table table-hover text-center">
        <c:if test="${pageInfo.list == []}">
            <div style="width: 100%;margin: 30px;text-align: center;font-size: 18px">
                <span class="icon-warning"></span> 暂无待审核相册</div>
        </c:if>
        <c:if test="${pageInfo.list != []}">
            <tr>
                <th>序号</th>
                <th width="40%">用户名</th>
                <th>类型</th>
                <th>用户上传相册</th>
            </tr>
            <c:forEach var="user" items="${pageInfo.list}" varStatus="status">
                <tr>
                    <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                    <td>${user.nickName}</td>
                    <td>${fns:getDictLabel('userType', user.type, '')}</td>
                    <td>
                        <a href="${ctx}/admin/audit/photo/album?user.id=${user.id}">查看</a>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>
</div>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp" %>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
</body>
</html>
<script>
    $(function () {
        //选择状态显示信息
        $("select").change(function () {
            if ($("option[value='todo']").is(":selected")) {
                $("#todo").show();
                $("#done").hide();
            } else {
                $("#todo").hide();
                $("#done").show();
            }
        })
    });
    /**
     * 分页必需
     */
    function page(n, s) {
        $('#pageNumber').val(n);
        $('#pageSize').val(s);
        $('#searchForm').submit();
        return false;
    }
    /**
     * 下拉框onChange事件
     */
    function showAnotherState() {
        window.location.href = "${ctx}/admin/audit/photo?state=" + $('#state').val();
    }
</script>
