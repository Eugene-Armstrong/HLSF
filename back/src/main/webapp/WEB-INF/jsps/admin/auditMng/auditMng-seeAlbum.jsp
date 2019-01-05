<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>查看用户相册</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <style>
        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
        .go-back{
            float: right;
            margin-right: 20px;
        }
        #del{margin-right: 20px;color: red;cursor: pointer}
        #yes,#no,.all,.ckb{display: none}
        .table{margin-bottom: 0}

    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-check-square-o"></span> 用户“${album.user.nickName}”的所有相册</strong>
        <span class="icon-trash-o float-right" id="del"> 批量删除</span>
        <span class="float-right">
            <a href="javascript:" id="no" style="margin-right: 10px"> 取消删除</a>
            <a href="javascript:" class="dialogs" data-toggle="click" data-target="#delete"
               data-mask="1" data-width="30%" id="yes"> 确认删除</a>&nbsp;
        </span>
        <span class="go-back">
            <a href="javascript:history.back()"><span class="icon-reply"></span> 返回</a>
        </span>
    </div>
    <form id="deleteBatch" action="${ctx}/admin/audit/deleteAlbum">
        <input type="hidden" name="user.id" value="${album.user.id}"/>
        <input type="hidden" name="id" value="${album.id}"/>
        <table class="table table-hover text-center">
            <tr>
                <th class="all">
                    全选 <input type="checkbox" value="all">
                </th>
                <th>序号</th>
                <th width="40%">相册名</th>
                <th>操作</th>
            </tr>
            <c:forEach var="albumInfo" items="${pageInfo.list}" varStatus="status">
                <tr>
                    <td class="ckb"><input type="checkbox" id="albumIds" name="albumIds" value="${albumInfo.id}"></td>
                    <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                    <c:choose>
                        <c:when test="${albumInfo.existUnAudit}">
                            <td><span style="color: red">${albumInfo.name}</span></td>
                        </c:when>
                        <c:otherwise>
                            <td>${albumInfo.name}</td>
                        </c:otherwise>
                    </c:choose>
                    <td>
                        <a href="${ctx}/admin/audit/deleteAlbum?albumIds=${albumInfo.id}&userId=${album.user.id}"
                           onclick="return confirm('删除后将无法恢复，确定删除相册吗？', this.href)">删除</a> /
                        <a href="${ctx}/admin/audit/photo/show?album.id=${albumInfo.id}">查看</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>
</div>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp" %>
</div>
<!--确认删除模态框-->
<div id="delete">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>删除相册</strong>
        </div>
        <div class="dialog-body">
            删除后将无法恢复，确定删除相册吗？
        </div>
        <div class="dialog-foot">
            <button class="button bg-main dialog-close sure">确定</button>
            <button class="button dialog-close">取消</button>
        </div>
    </div>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script>
    $(function () {
        $(document)
            //点击批量删除事件
            .on("click","#del",function () {
                $(this).hide();
                $("#yes,#no,.ckb,.all").show();
            })
            //点击确认删除
            .on("click","#yes",function () {
                var intL = $("input:checked").length; // 获取所有复选框选中项
                if (intL != 0) { // 如果有选中项
                    $(".dialog-foot .sure").click(function () {
                        $('#deleteBatch').submit();
                    })
                } else {
                    alert("请先选中要删除的项！");
                }
            })
            //点击取消删除
            .on("click","#no",function () {
                $("#yes,#no,.ckb,.all").hide();
                $("#del").show();
            })
            //待审核全选复选框
            .on("click","input[value='all']",function () {
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
