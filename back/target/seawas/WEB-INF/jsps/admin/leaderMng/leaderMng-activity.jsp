<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>领队活动</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <script src="${ctx}/js/jquery.js"></script>
    <script src="${ctx}/js/pintuer.js"></script>
    <script type="text/javascript">
        $(function () {
            //点击删除事件
//            $("a[href='#del']").click(function () {
//                $(this).hide();
//                $("a[href='#yes'], a[href='#no'], th:first, .ckb").show();
//            });
            //点击确认删除
//            $("a[href='#yes']").click(function () {
//                var intL = $("input:checked").length; // 获取所有复选框选中项
//                if (intL != 0) { // 如果有选中项
//                    alert("您确定要删除所选的活动吗？");
//                    $("input[type=checkbox]").each(function (index) { // 遍历全部复选框的行
//                        if (this.checked) { // 如果选中
//                            $(this).parent("td").parent("tr").remove();// 获取选中的值，并删除对应内容
//                        }
//                    })
//                } else {
//                    alert("请先选中要删除的活动！");
//                }
//            });
            //点击取消删除
//            $("a[href='#no']").click(function () {
//                $("a[href='#yes'], a[href='#no'], th:first, .ckb").hide();
//                $("a[href='#del']").show();
//            });
            //全选复选框
//            $("input[value='all']").click(function () {
//                if (this.checked) { // 如果自己被选中
//                    $("input[type=checkbox]").prop("checked", true);
//                } else { // 如果自己没被选中
//                    $("input[type=checkbox]").prop("checked", false);
//                }
//            });
        })
    </script>
    <style>
        .panel-head {line-height: 42px}
        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
        a[href='#yes'], a[href='#no'], th:first-child, .ckb{display: none}
        a[href='#del']{color: red}
        .input {
            display: inline !important;
            width: 25%;
        }
        td img {height: 64px}
        .panel{margin-bottom: 30px}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-cube"></span> 领队活动</strong>
        <%--<input type="text" class="input float-right"--%>
               <%--name="searchTxt" placeholder="输入活动名进行查询"/>--%>
        <%--<button class="button border-blue float-right" style=" margin-right: 5px">--%>
            <%--查询 <span class="icon-search-plus"></span>--%>
        <%--</button>--%>
        <a href="javascript:history.back()" style="margin-right: 5px" class="button float-right">返回</a>
    </div>
    <%--<div class="padding border-bottom" style="overflow: hidden">--%>
        <%--<span style="float: right">--%>
            <%--<a class="icon-trash-o" href="#del" style="margin-right: 20px"> 删除活动</a>--%>
            <%--<a href="#yes"> 确认删除</a>&nbsp;--%>
            <%--<a href="#no" style="margin-right: 20px"> 取消删除</a>--%>
        <%--</span>--%>
    <%--</div>--%>
    <table class="table table-hover text-center">
        <tr>
            <th width="5%">
                全选 <input type="checkbox" value="all">
            </th>
            <th style="display: none">活动ID</th>
            <th width="5%">序号</th>
            <th width="15%">产品名</th>
            <th width="5%">价格</th>
            <th width="10%">出发时间</th>
            <th width="10%">集合地点</th>
            <th width="5%">成行</th>
            <th width="5%">上限</th>
            <th width="5%">已报名</th>
            <th width="5%">状态</th>
            <th width="10%">截止报名时间</th>
            <th width="10%">结束时间</th>
            <th width="10%">操作</th>
        </tr>
        <tr>
            <c:forEach items="${pageInfo.list}" var="act" varStatus="status">
        <tr>
            <td class="ckb"><input type="checkbox" name="user_id" value="${act.id}"/></td>
            <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
            <td>${act.pro_name}</td>
            <td><fmt:formatNumber value="${act.price * 0.01}" pattern="#.0#"/></td>
            <td><fmt:formatDate value="${act.departTime}"
                                pattern="yyyy-MM-dd HH:mm"/></td>
            <td>${act.gatherPlace}</td>
            <td>${act.tripNumber}</td>
            <td>${act.totalNumber}</td>
            <td>${act.signNumber}</td>
            <td>${act.state}</td>
            <td><fmt:formatDate value="${act.closeTime}"
                                pattern="yyyy-MM-dd HH:mm"/></td>
            <td><fmt:formatDate value="${act.endTime}"
                                pattern="yyyy-MM-dd HH:m"/></td>
            <td>
                <a href="${ctx}/activity/showActivityDetail?activityId=${act.id}">活动详情</a>
            </td>
        </tr>
        </c:forEach>
        </tr>
    </table>
    <c:if test="${pageInfo.list == []}">
        <div style="width: 100%;padding: 30px;text-align: center;font-size: 18px">
            <span class="icon-warning"></span> 该领队暂无带队活动</div>
    </c:if>
</div>
</body>
</html>

