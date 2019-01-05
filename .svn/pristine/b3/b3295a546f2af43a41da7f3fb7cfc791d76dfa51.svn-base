<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>活动日历</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        input {
            display: inline !important;
            margin-left: 10px;
            width: 25% !important;
        }
        form{display: inline}
        .message{padding: 0 20px}
        .pagination  a:hover {
            background-color: #337ab7;
            color: #fff;
        }
        .table{border-bottom:1px solid #eee}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-calendar"></span> 活动日历</strong>
        <form action="${ctx}/admin/calendar/getActivities" method="post" id="searchForm">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <input id="departTime" name="departTime" type="hidden" value="${departTime}">
            <input type="date" name="date" class="input" required/>
            <button class="button border-blue" type="submit">
                <span class="icon search"> 查询</span>
            </button>
        </form>
    </div>
    <table class="table table-hover text-center">
        <c:if test="${pageInfo.list == []}">
            <div style="width: 100%;margin: 30px;text-align: center;font-size: 18px">
                <span class="icon-warning"></span> 暂无数据</div>
        </c:if>
        <c:if test="${pageInfo.list != []}">
            <tr>
                <th>序号</th>
                <th>活动名称</th>
                <th>活动原价</th>
                <th>优惠价格</th>
                <th>成行人数</th>
                <th>报名人数</th>
                <th>活动状态</th>
                <th>报名截止时间</th>
                <th>出发时间</th>
                <th>返回时间</th>
                <th>查看领队</th>
            </tr>
            <c:forEach items="${pageInfo.list}" var="act" varStatus="status">
                <tr>
                    <td style="display: none" class="leader-id">${act.id}</td>
                    <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                    <td>${act.product.name}</td>
                    <td>${act.price * 0.01}</td>
                    <td>${act.onSalePrice * 0.01}</td>
                    <td>${act.tripNumber}</td>
                    <td>${act.totalNumber}</td>
                    <td>${act.state}</td>
                    <td><fmt:formatDate value="${act.closeTime}"
                                        pattern="yyyy-MM-dd" /></td>
                    <td><fmt:formatDate value="${act.departTime}"
                                        pattern="yyyy-MM-dd HH:mm" /></td>
                    <td><fmt:formatDate value="${act.endTime}"
                                        pattern="yyyy-MM-dd HH:mm" /></td>
                    <td>
                        <a href="#" class="dialogs see" data-toggle="click"
                           data-target="#leader" data-mask="1" data-width="50%">查看</a>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>
    <%@ include file="/WEB-INF/include/pagehelper.jsp"%>
</div>
<!--领队信息模态框-->
<div id="leader">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>领队信息</strong>
        </div>
        <div class="dialog-body">
            <table class="table table-hover table-bordered text-center">
                <tr>
                    <th>工号</th>
                    <th>真实姓名</th>
                    <th>性别</th>
                    <th>年龄</th>
                    <th>评分</th>
                </tr>
            </table>
        </div>
        <div class="dialog-foot">
            <button class="button dialog-close">
                关闭</button>
        </div>
    </div>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        //查看领队信息模态框
        $(".see").click(function () {
            var activityId = $(this).parent().siblings(".leader-id").text();
            $.ajax({
                type:"post",
                url: "${ctx}/admin/calendar/getLeaderlist", // 请求处理页
                dataType: "json",
                data: {activityId: activityId},
                success: function (result) {
                    $(".dialog-body .info").remove();
                    for(var i = 0;i < result.length;i++){
                        var val = result[i],
                            score = Number(Number(val.user.score).toFixed(2));
                        $(".dialog-body .table").append("<tr class='info'>" +
                            "<td>"+val.user.workNo+"</td>"+
                            "<td>"+val.user.realName+"</td>"+
                            "<td>"+val.user.sex+"</td>"+
                            "<td>"+val.user.age+"</td>"+
                            "<td>"+score+"</td></tr>");
                    }
                }, error:function () {
                    alert("系统繁忙，请稍后再试");
                }
            });

        })
    });
</script>
</body>
</html>
