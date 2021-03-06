<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>活动列表</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        a[href='#yes'], a[href='#no'],.ckb{
            display: none;
        }
        .panel-head{line-height: 42px}
        .message{margin-top: 20px}
        .pagination{margin-bottom: 30px}
        .pagination .active{
            background: #337ab7!important;
        }
        .active a{
            color: #fff!important;
        }
        .pagination  a{
            border: 1px solid #eee!important;
        }
        .empty-tip{width: 100%;text-align: center;padding: 20px 0;line-height: 20px;color: #999}
        #empty{width: 200px;opacity: .5}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-cube"></span> 活动列表</strong>
        <a href="${ctx}/product/showProduct" style="margin-right: 5px"
           class="button border-blue float-right">返回</a>
    </div>
    <div class="padding border-bottom" style="overflow: hidden">
        <span style="float: right">
            <a style="margin-right: 20px" class="icon-plus-square-o" href="${ctx}/activity/toAddActivity?productId=${productId}"> 添加活动</a>
            <c:if test="${activityPageInfo.list!=[]}">
                <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 删除活动</a>
            </c:if>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th style="display: none" width="5%">
                全选 <input type="checkbox" value="all">
            </th>
            <th style="display: none">活动ID</th>
            <th width="7%">价格</th>
            <th width="12%">出发时间</th>
            <th width="10%">集合地点</th>
            <th width="7%">成行人数</th>
            <th width="7%">人数上限</th>
            <th width="7%">已报名人数</th>
            <th width="8%">状态</th>
            <th width="12%">截止报名时间</th>
            <th width="12%">结束时间</th>
            <th width="13%">操作</th>
        </tr>
        <c:forEach items="${activityPageInfo.list}" var="act">
            <tr>
                <td class="ckb"><input type="checkbox"></td>
                <td style="display: none">${act.id}</td>
                <td><fmt:formatNumber value="${act.price * 0.01}" pattern="0.0#"/></td>
                <td><fmt:formatDate value="${act.departTime}"
                                    pattern="yyyy-MM-dd HH:mm" /></td>
                <td>${act.gatherPlace}</td>
                <td>${act.tripNumber}</td>
                <td>${act.totalNumber}</td>
                <td>${act.signNumber}</td>
                <c:if test="${act.state != '未发布'}">
                    <td class="text-green">${act.state}</td>
                </c:if>
                <c:if test="${act.state == '未发布'}">
                    <td><a href="${ctx}/activity/changeActivityType?activityId=${act.id}&productId=${productId}" class="text-red">点击发布</a></td>
                </c:if>
                <td><fmt:formatDate value="${act.closeTime}"
                                    pattern="yyyy-MM-dd HH:mm" /></td>
                <td><fmt:formatDate value="${act.endTime}"
                                    pattern="yyyy-MM-dd HH:mm" /></td>
                <td>
                    <a href="${ctx}/activity/showActivityDetail?activityId=${act.id}">详情</a> /
                    <a href="${ctx}/admin/activityOrders/toActivityOrders?activityId=${act.id}">订单</a> /
                    <a href="${ctx}/activity/toActivityChange?productId=${productId}&id=${act.id}">修改</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${activityPageInfo.list==[]}">
        <div class="empty-tip">
            <img src="${ctx}/images/empty-pic.png" id="empty">
            <br>此产品尚未添加活动，点击右上角添加活动吧~ (｡･ω･｡)
        </div>
    </c:if>
</div>
<!-- 页数 -->
<div class="message">
    共<i class="blue">${activityPageInfo.total}</i>条记录，当前显示第&nbsp;<i
        class="blue">${activityPageInfo.pageNum}/${activityPageInfo.pages}</i>&nbsp;页
</div>
<div style="text-align:center;margin-top: -20px">
    <ul class="pagination">
        <!-- <li><a href="#">&laquo;</a></li> -->
        <c:if test="${!activityPageInfo.isFirstPage}">
            <li><a href="${ctx}/activity/showProductActivity?pageNumber=1&pageSize=${activityPageInfo.pageSize}&productId=${productId}">首页</a></li>
            <li><a href="${ctx}/activity/showProductActivity?pageNumber=${activityPageInfo.prePage}&pageSize=${activityPageInfo.pageSize}&productId=${productId}">上一页</a></li>
        </c:if>
        <c:forEach items="${activityPageInfo.navigatepageNums}" var="navigatepageNum">
            <c:if test="${navigatepageNum==activityPageInfo.pageNum}">
                <li class="active"><a href="${ctx}/activity/showProductActivity?pageNumber=${navigatepageNum}&pageSize=${activityPageInfo.pageSize}&productId=${productId}">${navigatepageNum}</a></li>
            </c:if>
            <c:if test="${navigatepageNum!=activityPageInfo.pageNum}">
                <li><a href="${ctx}/activity/showProductActivity?pageNumber=${navigatepageNum}&pageSize=${activityPageInfo.pageSize}&productId=${productId}">${navigatepageNum}</a></li>
            </c:if>
        </c:forEach>
        <c:if test="${!activityPageInfo.isLastPage}">
            <li><a href="${ctx}/activity/showProductActivity?pageNumber=${activityPageInfo.nextPage}&pageSize=${activityPageInfo.pageSize}&productId=${productId}">下一页</a></li>
            <li><a href="${ctx}/activity/showProductActivity?pageNumber=${activityPageInfo.pages}&pageSize=${activityPageInfo.pageSize}&productId=${productId}">最后一页</a></li>
        </c:if>
    </ul>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        var idSelected = "";
        //点击删除事件
        $("a[href='#del']").click(function () {
            $(this).hide();
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").show();
        });
        //点击确认删除
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                $("input[type=checkbox]").each(function (index) { // 遍历全部复选框的行
                    if (this.checked) { // 如果选中
                        idSelected += ($(this).parent("td").next("td").text() + ",");//获取勾选项id
                    }
                });
                $.ajax({
                    type:'post',
                    url: "${ctx}/activity/deleteActivity", // 请求处理页
                    dataType: "json",
                    data: {idSelected: idSelected},
                    success: function (result) {
                        if (result == '0'){
                            alert("删除失败");
                        }
                        else {
                            alert("删除成功");
                        }
                        window.location.href = "${ctx}/activity/showProductActivity?productId=${productId}";
                    },
                    error: function () {
                        alert("系统繁忙，请稍后再试");
                    }
                });
            }else {
                alert("请先选中要删除的后台活动！");
            }
        })
        //点击取消删除
        $("a[href='#no']").click(function () {
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").hide();
            $("a[href='#del']").show();
        })
        //全选复选框
        $("input[value='all']").click(function () {
            if (this.checked) { // 如果自己被选中
                $("input[type=checkbox]").prop("checked", true);
            } else { // 如果自己没被选中
                $("input[type=checkbox]").prop("checked", false);
            }
        });
    })
</script>
</body>
</html>
