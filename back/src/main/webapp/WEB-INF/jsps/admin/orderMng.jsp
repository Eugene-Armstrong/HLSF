<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>订单管理</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <style>
        select {
            display: inline !important;
            margin:0 5px;
            width: 10% !important;
        }
        .panel-head{line-height: 42px}
        .panel-head input{
            display: inline-block;
            margin:0 5px;
            width: 200px;
            line-height: 20px
        }
        form{display: inline}
        .pagination{margin: 0}
        .table{margin-bottom: 0}
        a[href='#yes'], a[href='#no'], th:first-child, .ckb{display: none}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-file-text-o"></span> 订单管理</strong>
        <form:form id="searchForm" modelAttribute="orders" action="${ctx}/admin/order/" method="post">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <form:select path="state" class="input">
                <form:options items="${fns:getDictList('orderState')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
            <input name="beginDate" type="date" class="input start" value="<fmt:formatDate value="${orders.beginDate}" pattern="yyyy-MM-dd"/>">至
            <input name="endDate" type="date" class="input end" value="<fmt:formatDate value="${orders.endDate}" pattern="yyyy-MM-dd"/>">
            <form:input type="text" path="merOrderNumber" class="input" placeholder="输入订单号进行查询"/>
            <button class="button border-blue"><span class="icon-search-plus"></span> 查询</button>
        </form:form>
        <c:if test="${orders.state != '3'}">
            <span style="float: right;line-height: 42px">
            <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 删除订单</a>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>
        </c:if>
    </div>
    <form name="delete">
        <table class="table table-hover text-center table-bordered">
            <c:if test="${pageInfo.list == []}">
                <div style="width: 100%;margin: 30px;text-align: center;font-size: 18px">
                    <span class="icon-warning"></span> 暂无订单数据
                </div>
            </c:if>
            <c:if test="${pageInfo.list != []}">
                <tr>
                    <th width="10%">
                        全选 <input type="checkbox" value="all">
                    </th>
                    <th width="5%">序号</th>
                    <th width="25%">订单编号</th>
                    <th width="10%">订单状态</th>
                    <th width="20%">创建时间</th>
                    <th width="20%">支付时间</th>
                    <th width="10%">操作</th>
                </tr>
                <c:forEach var="order" items="${pageInfo.list}" varStatus="status">
                    <tr>
                        <td class="ckb"><input type="checkbox" name="orderIds" value="${order.id}"/></td>
                        <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                        <td>${order.merOrderNumber}</td>
                        <td><span></span>${fns:getDictLabel('orderState', order.state, '')}</td>
                        <td><fmt:formatDate value="${order.createTime}" type="both"/></td>
                        <td><fmt:formatDate value="${order.payTime}" type="both"/></td>
                        <td><a href="${ctx}/admin/order/show?id=${order.id}">订单详情</a></td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </form>
</div>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp"%>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        //日期先后验证
        $(".end").on("input", function () {
            var start_d = new Date($(".start").val()).getTime();
            var end_d = new Date($(this).val()).getTime();
            if (start_d >= end_d) {
                alert("截止日期必须大于起始日期，请重新选择");
                $(this).val("");
            }
        });
        $(".start").on("input",function () {
            var start_d = new Date($(this).val()).getTime();
            var end_d = new Date($(".end").val()).getTime();
            if (start_d >= end_d) {
                alert("起始日期必须小于截止日期，请重新选择");
                $(this).val("");
            }
        });
        //点击删除事件
        $("a[href='#del']").click(function () {
            $(this).hide();
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").show();
        });
        //点击确认删除
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                var sure = confirm("您确定要删除所选的订单吗？");
                if(sure){
                    document.delete.action = "${ctx}/admin/order/delete";
                    document.delete.submit();
                }
            } else {
                alert("请先选中要删除的订单！");
            }
        });
        //点击取消删除
        $("a[href='#no']").click(function () {
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").hide();
            $("a[href='#del']").show();
        });
        //全选复选框
        $("input[value='all']").click(function () {
            if (this.checked) { // 如果自己被选中
                $("input[type=checkbox]").prop("checked", true);
            } else { // 如果自己没被选中
                $("input[type=checkbox]").prop("checked", false);
            }
        });
    });
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