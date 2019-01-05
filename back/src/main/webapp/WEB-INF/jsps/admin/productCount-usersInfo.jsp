<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>查看用户信息</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        select {
            display: inline !important;
            margin-left: 10px;
            width: 20% !important;
        }
        .panel-head{line-height: 42px}
        .pagelist{border-top: 1px solid #eee}
        .pagelist li{display: inline}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-users"></span> 参与用户信息</strong>
        <a href="javascript:history.back()" class="button float-right">返回</a>
        <c:if test="${signList!=[]}">
            <button class="button border-blue" style="float: right;margin-right: 10px">导出Excel表格</button>
        </c:if>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th style="display: none">序号</th>
            <th>用户名</th>
            <th>性别</th>
            <th>年龄</th>
            <th>身份证号</th>
            <th>金额</th>
        </tr>
        <c:forEach var="sign" items="${signListPage}">
            <tr>
                <td style="display: none">${sign.id}</td>
                <td>${sign.name}</td>
                <td>${fns:getDictLabel('sex',sign.sex ,'')}</td>
                <td>${sign.age}</td>
                <td>${sign.certId}</td>
                <td>${sign.price * 0.01}</td>
            </tr>
        </c:forEach>
        <c:forEach var="sign1" items="${signList}">
            <tr style="display: none" class="t-complete">
                <td>${sign1.id}</td>
                <td>${sign1.name}</td>
                <td>${sign1.sex}</td>
                <td>${sign1.age}</td>
                <td>${sign1.certId}</td>
                <td>${sign1.price * 0.01}</td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${signList==[]}">
        <div style="width: 100%;padding: 30px;text-align: center;font-size: 18px">
            <span class="icon-warning"></span> 该产品暂无用户参加</div>
    </c:if>
    <center>
        <div class="pagelist">
            <c:if test="${pageVo.pageNum > 1}">
                <li><a href="${ctx}/productCount/checkUsersMessageByProductId?productId=${productId}&pageNumber=1">首页</a></li>
                <li><a href="${ctx}/productCount/checkUsersMessageByProductId?productId=${productId}&pageNumber=${pageVo.pageNum - 1}">上一页</a></li>
            </c:if>
            <c:if test="${pageVo.pageNum < pageVo.totalPage}">
                <li><a href="${ctx}/productCount/checkUsersMessageByProductId?productId=${productId}&pageNumber=${pageVo.pageNum + 1}">下一页</a></li>
                <li><a href="${ctx}/productCount/checkUsersMessageByProductId?productId=${productId}&pageNumber=${pageVo.totalPage}">尾页</a></li>
            </c:if>
            &nbsp;&nbsp;&nbsp;&nbsp;当前页：第 <a>${pageVo.pageNum}</a> 页
        </div>
    </center>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        $(".panel-head button").click(function () {
            var signID = "";
            $(".t-complete").each(function () {
                signID += $(this).find("td:first").text() + ",";
            });
            window.open("${ctx}/productCount/putSignMessageExcel?signID=" + signID);
        })
    })
</script>
</body>
</html>
