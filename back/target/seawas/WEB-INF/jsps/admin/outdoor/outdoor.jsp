<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta name="renderer" content="webkit">
    <title>推送管理</title>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        a[href='#del']{color: red}
        select {
            display: inline !important;
            margin-left: 5px;
            width: 12% !important;
        }
        .input {
            display: inline !important;
            width: 20%;
        }
        td img {
            max-height: 64px;
        }
        .table{margin-bottom: 0}
        .table td{vertical-align: middle!important;}
        form{display: inline}
        .my-size{width: 180px;height: 100px}
        a[href='#yes'], a[href='#no'], th:first-child, .ckb{
            display: none;
        }
        .webUrl{width: 300px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-paper-plane"></span> 推送管理</strong>
        <form:form id ="searchForm" action="${ctx}/admin/outdoor/list" method="post" modelAttribute="outdoor">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <form:select path="type" class="input" onchange="change()">
                <form:options items="${fns:getDictList('outdoorType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
            <button class="button border-blue float-right"> 查询 <span class="icon-search-plus"></span></button>
            <form:input type="text" class="input float-right" style="margin-right: 5px"
                        name="searchtxt" placeholder="输入推送名进行查询" path="title"/>
        </form:form>
    </div>
    <div class="padding border-bottom" style="overflow: hidden">
        <span style="float: right">
            <a style="margin-right: 20px" class="icon-plus-square-o" href="${ctx}/admin/outdoor/addPage?type=${outdoor.type}"> 添加推送</a>
            <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 推送删除</a>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>
    </div>
    <form id="outdoorShow">
        <table class="table table-hover text-center">
            <tr>
                <th width="10%">
                    全选 <input type="checkbox" value="all">
                </th>
                <th width="10%">序号</th>
                <th width="20%">推送封面</th>
                <th width="20%">推送标题</th>
                <th width="20%">链接</th>
                <th width="20%">操作</th>
            </tr>
            <c:forEach items="${pageInfo.list}" var="outdoor" varStatus="status">
                <tr>
                    <td class="ckb"><input type="checkbox" name="outdoorId" value="${outdoor.id}"/></td>
                    <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                    <td>
                        <img src="/photo/outdoor/${outdoor.pic}" alt="" class="my-size">
                    </td>
                    <td style="max-width: 300px">${outdoor.title}</td>
                    <td>
                            <div class="webUrl">${outdoor.webURL}</div>
                    </td>
                    <td>
                        <a href="${outdoor.webURL}" target="_blank">查看链接</a> /
                        <a href="${ctx}/admin/outdoor/updatePage?id=${outdoor.id}">修改</a> /
                        <a href="javascript:" onclick="del('${outdoor.id}')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>
    <c:if test="${pageInfo.list == []}">
        <div style="width: 100%;margin: 30px;text-align: center;font-size: 18px">
            <span class="icon-warning"></span> 暂无推送数据</div>
    </c:if>
</div>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp"%>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script>
    $(function () {
        //点击删除事件
        $("a[href='#del']").click(function () {
            $(this).hide();
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").show();
        });
        //点击确认删除
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                var sure = confirm("确定删除所选推送吗？");
                if(sure){
                    $.ajax({
                        type: "POST",
                        url:"${ctx}/admin/outdoor/delete",
                        data:$('#outdoorShow').serialize(),// 要提交的表单
                        dataType: "JSON",
                        success: function(result) {
                            if (result.code == 200) {
                                alert(result.message);
                                location.reload();
                            } else {
                                alert(result.message);
                            }
                        }
                    });
                }
            } else {
                alert("请先选中要删除的推送！");
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
     * 推送类型下拉框onChange事件
     * @returns {boolean}
     */
    function change() {
        $('#pageNumber').val(1);
        $('#searchForm').submit();
        return false;
    }

    /**
     * 单项推送删除事件
     * @param outdoorId
     */
    function del(outdoorId) {
        var sure = confirm("确定删除本条推送吗？");
        if(sure){
            $.ajax({
                url: "${ctx}/admin/outdoor/delete",
                type: "POST",
                dataType: "json",
                data: {"outdoorId": outdoorId},
                success: function (data) {
                    if (data.code == 200) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                }
            });
        }
    }
</script>
</body>
</html>
