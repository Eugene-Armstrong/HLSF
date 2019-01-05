<%--
  Created by IntelliJ IDEA.
  User: sjk
  Date: 2017-07-26
  Time: 12:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="taglib.jsp"%>
<!--   -->
<style>
    .message{margin-top: 20px}
</style>
<!-- 页数 -->
<div class="message">
    共<i class="blue">${pageInfo.total}</i>条记录，当前显示第&nbsp;<i
        class="blue">${pageInfo.pageNum}/${pageInfo.pages}</i>&nbsp;页
</div>
<div style="text-align:center;margin:-20px 0 20px 0">
    <ul class="pagination">
        <!-- <li><a href="#">&laquo;</a></li> -->
        <c:if test="${!pageInfo.isFirstPage}">
            <li><a href="javascript:page('1', ${pageInfo.pageSize});">首页</a></li>
            <li><a href="javascript:page(${pageInfo.prePage}, ${pageInfo.pageSize});">上一页</a></li>
        </c:if>
        <c:forEach items="${pageInfo.navigatepageNums}" var="navigatepageNum">

            <c:if test="${navigatepageNum==pageInfo.pageNum}">
                <li class="active"><a href="javascript:page(${navigatepageNum}, ${pageInfo.pageSize});">${navigatepageNum}</a></li>
            </c:if>
            <c:if test="${navigatepageNum!=pageInfo.pageNum}">
                <li><a href="javascript:page(${navigatepageNum}, ${pageInfo.pageSize});">${navigatepageNum}</a></li>
            </c:if>
        </c:forEach>
        <c:if test="${!pageInfo.isLastPage}">
            <li><a href="javascript:page(${pageInfo.nextPage}, ${pageInfo.pageSize});">下一页</a></li>
            <li><a href="javascript:page(${pageInfo.pages}, ${pageInfo.pageSize});">最后一页</a></li>
        </c:if>
        <!-- <li><a href="#">&raquo;</a></li> -->
    </ul>
</div>
