<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>普通用户管理</title>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        .dialog-body td{
            border: none;
        }
        .panel-head{overflow: hidden}
        .panel-head strong{line-height: 42px}
        .panel-head .input {
            display: inline !important;
            width: 15%;
            margin-right: 5px;
        }

        ul.pagination > li > span, ul.pagination > li > a, ul.pagination > li.active > a, ul.pager > li > span {
            cursor: pointer;
        }
        .pagination > li{margin: 10px 0}

        .input-page-div > input {
            width: 5em;
            height: 1.8em;
            margin: 0.4em 0.2em 0.2em 0.2em;
            text-align: center;
        }

        .input-page-div > .input-btn-xs {
            margin-left: 1em;
            font-size: 1em;
            width: 3em;
            background-color: #337ab7;
            color: #fff;
        }

        .input-page-div {
            display: inline-block;
            margin-left: 1em;
            float: right;
            margin-top: 10px;
        }
        .table td{
            vertical-align: middle!important;
        }
        .user-img{
            width: 48px;
            height: 48px;
            border-radius: 50%;
        }
        /*分页*/
        .mypagenav {
            margin-top: 40px;
            float: right;
        }

        .mypagenav > li {
            float: left;
            margin-left: 1em;
            list-style: none;
            width: 1.1em;
        }

        .mypagenav > li.active > a {
            color: #f00;
        }

        .mypagenav > li > span {
            cursor: pointer;
        }

        .mypagenav > li.disabled > span {
            cursor: default;
            color: #999;
        }
        .table{border-bottom: 1px solid #eee}
        form{display: inline}
        .message{padding: 20px 0 0 20px}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-users"></span> 普通用户管理</strong>
        <form action="${ctx}/user/admin/showUser">
            <button type="submit" class="button border-blue float-right">
                查询 <span class="icon-search-plus"></span>
            </button>
            <input type="text" class="input float-right" name="phone" placeholder="输入手机号进行查询"/>
            <input type="text" class="input float-right" name="realName" placeholder="输入真实姓名进行查询"/>
        </form>
    </div>
    <div class="padding border-bottom" style="overflow: hidden">
        <%--<span class="float-right">
            <a style="margin-right: 20px" class="icon-plus-square-o" href="userMng-add.html"> 添加用户</a>
            <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 删除用户</a>
            <a href="#yes"> 确认删除</a>&nbsp;
           <a href="#no" style="margin-right: 20px"> 取消删除</a>--%>
        </span>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <%--<th>--%>
                <%--全选 <input type="checkbox" value="all">--%>
            <%--</th>--%>
            <th width="5%">序号</th>
            <th width="15%">头像</th>
            <th width="15%">昵称</th>
            <th width="10%">真实姓名</th>
            <th width="5%">性别</th>
            <th width="5%">年龄</th>
            <th width="10%">手机号码</th>
            <th width="10%">用户积分</th>
            <th width="15%">最后登录时间</th>
            <th width="10%">查看活动</th>
        </tr>
        <c:forEach items="${users.list}" var="user" varStatus="status">
        <tr>
            <%--<td class="ckb"><input type="checkbox"></td>--%>
            <%-- <td>${user.id}</td>--%>
            <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
            <td><img src="${user.headImgUrl}" class="user-img"></td>
            <td>${user.nickName}</td>
            <td>${user.realName}</td>
            <td>${fns:getDictLabel('sex',user.sex ,'')}</td>
            <td>${user.age}</td>
            <td>${user.phone}</td>
            <td>${user.score}</td>
            <td><fmt:formatDate value="${user.lastLoginTime}" pattern="yyyy-MM-dd HH:mm" /></td>
            <td><a href="${ctx}/user/admin/userGone?userId=${user.id}">活动列表</a></td>
        </tr>
        </c:forEach>
    </table>
    <!-- 页数 -->
    <div class="message">
        共<i class="blue">${users.total}</i>条记录，当前显示第&nbsp;<i
            class="blue">${users.pageNum}/${users.pages}</i>&nbsp;页
    </div>
    <div style="text-align:center;margin-top: -20px">
        <ul class="pagination">
            <!-- <li><a href="#">&laquo;</a></li> -->
            <c:if test="${!users.isFirstPage}">
                <li><a href="${ctx}/user/admin/showUser?pageNumber=1&pageSize=${users.pageSize}&realName=${realName}&phone=${phone}">首页</a></li>
                <li><a href="${ctx}/user/admin/showUser?pageNumber=${users.prePage}&pageSize=${users.pageSize}&realName=${realName}&phone=${phone}">上一页</a></li>
            </c:if>
            <c:forEach items="${users.navigatepageNums}" var="navigatepageNum">
                <c:if test="${navigatepageNum==users.pageNum}">
                    <li class="active"><a href="${ctx}/user/admin/showUser?pageNumber=${navigatepageNum}&pageSize=${users.pageSize}&realName=${realName}&phone=${phone}">${navigatepageNum}</a></li>
                </c:if>
                <c:if test="${navigatepageNum!=users.pageNum}">
                    <li><a href="${ctx}/user/admin/showUser?pageNumber=${navigatepageNum}&pageSize=${users.pageSize}&realName=${realName}&phone=${phone}">${navigatepageNum}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${!users.isLastPage}">
                <li><a href="${ctx}/user/admin/showUser?pageNumber=${users.nextPage}&pageSize=${users.pageSize}&realName=${realName}&phone=${phone}">下一页</a></li>
                <li><a href="${ctx}/user/admin/showUser?pageNumber=${users.pages}&pageSize=${users.pageSize}&realName=${realName}&phone=${phone}">最后一页</a></li>
            </c:if>
        </ul>
    </div>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<%--<script type="text/javascript">--%>
    <%--$(function () {--%>
        <%--//点击删除前--%>
        <%--$("a[href='#yes'], a[href='#no'], th:first, .ckb").hide();--%>
        <%--//点击删除事件--%>
        <%--$("a[href='#del']").css("color", "red")--%>
            <%--.click(function () {--%>
                <%--$(this).hide();--%>
                <%--$("a[href='#yes'], a[href='#no'], th:first, .ckb").show();--%>
            <%--});--%>
        <%--//点击确认删除--%>
        <%--$("a[href='#yes']").click(function () {--%>
            <%--var intL = $("input:checked").length; // 获取所有复选框选中项--%>
            <%--if (intL != 0) { // 如果有选中项--%>
                <%--alert("您确定要删除所选的普通用户吗？");--%>
                <%--$("input[type=checkbox]").each(function (index) { // 遍历全部复选框的行--%>
                    <%--if (this.checked) { // 如果选中--%>
                        <%--$(this).parent("td").parent("tr").remove();// 获取选中的值，并删除对应内容--%>
                    <%--}--%>
                <%--})--%>
            <%--} else {--%>
                <%--alert("请先选中要删除的普通用户！");--%>
            <%--}--%>
        <%--});--%>
        <%--//点击取消删除--%>
        <%--$("a[href='#no']").click(function () {--%>
            <%--$("a[href='#yes'], a[href='#no'], th:first, .ckb").hide();--%>
            <%--$("a[href='#del']").show();--%>
        <%--});--%>
        <%--//全选复选框--%>
        <%--$("input[value='all']").click(function () {--%>
            <%--if (this.checked) { // 如果自己被选中--%>
                <%--$("input[type=checkbox]").prop("checked", true);--%>
            <%--} else { // 如果自己没被选中--%>
                <%--$("input[type=checkbox]").prop("checked", false);--%>
            <%--}--%>
        <%--});--%>
    <%--});--%>
<%--</script>--%>
</body>
</html>
