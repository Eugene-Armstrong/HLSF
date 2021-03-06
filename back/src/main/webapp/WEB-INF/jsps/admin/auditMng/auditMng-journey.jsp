<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>游记审核</title>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        a[href='#del']{color: red}
        a[href='#yes'],a[href='#no']{display: none}
        .ckb{display: none}
        .message{margin: 20px 20px 0 20px;display: none}
        .pagination{margin-bottom: 30px}
        .pagination .active{background: #337ab7!important}
        .active a{color: #fff!important}
        .pagination a{border: 1px solid #eee!important}
        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
        /*已审核全选框*/
        .all{display: none}
        .table{border-bottom: 2px solid #eee}
        td{vertical-align: middle!important;}
        .page-btn{text-align:center;margin-top: -20px;display: none}
        .note-id{display: none}
        .cover{width: 180px;height: 80px}
        form{display: inline}
        .dialog-body img{width:100%;}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-check-square-o"></span> 游记审核</strong>
        <form:form id ="searchForm" action="${ctx}/admin/audit/journey" method="post" modelAttribute="travelNote">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <form:select path="state" class="input" onchange="change()">
                <form:option  value="0">待审核</form:option>
                <form:option  value="1">审核通过</form:option>
                <form:option  value="2">审核不通过</form:option>
            </form:select>
        </form:form>
        <span style="float: right;line-height: 42px">
            <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 删除</a>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>
    </div>

    <!--对应游记信息列表-->
    <table id="todo" class="table table-hover text-center">
        <tr>
            <th width="8%" class="all">
                全选 <input type="checkbox" value="all">
            </th>
            <th width="5%">序号</th>
            <th width="15%">标题</th>
            <th width="15%">封面图</th>
            <th width="12%">用户名</th>
            <th width="10%">查看</th>
            <th width="15%">上传时间</th>
            <th width="5%">浏览量</th>
            <th width="15%">审核</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="note" varStatus="status">
            <tr>
                <td class="ckb"><input type="checkbox"></td>
                <td class="note-id">${note.id}</td>
                <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                <td>${note.title}</td>
                <td>
                    <img src="${ctx}/photo/TravelNote/${note.picUrl}" alt="" class="cover">
                </td>
                <td>${note.userRealName}</td>
                <td>
                    <a href="#" class="dialogs journey" data-toggle="click" data-target="#journey" data-mask="1" data-width="40%">游记内容</a>
                        <%--/ <a href="${ctx}/admin/journeyComment/show?noteId=${note.id}">游记评论</a>--%>
                </td>
                <td><fmt:formatDate value="${note.createTime }" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>${note.browseTimes}</td>
                <td>
                    <c:choose>
                        <c:when test="${note.state == '0'}">
                            <a href="${ctx}/admin/audit/journey/pass?noteId=${note.id}">通过并发布</a> /
                            <a href="#" class="dialogs reject" data-toggle="click" data-target="#reject" data-mask="1" data-width="50%">否决</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#" class="delete">删除</a> /
                            <a href="${ctx}/admin/audit/journey/moreDetail?noteId=${note.id}">更多详情</a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!--否决模态框-->
<div id="reject">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>回复否决理由</strong>
        </div>
        <div class="dialog-body">
            <textarea rows="5" style="width: 100%" class="input" placeholder="请输入否决理由"></textarea>
        </div>
        <div class="dialog-foot">
            <button class="button dialog-close">取消</button>
            <button class="button bg-green send-reason">发送</button>
        </div>
    </div>
</div>

<!--游记模态框-->
<div id="journey">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>查看游记</strong>
        </div>
        <div class="dialog-body my-test-journey" style="max-height:330px;overflow: scroll;overflow-x: hidden">
        </div>
        <div class="dialog-foot">
            <button class="button dialog-close">
                关闭</button>
        </div>
    </div>
</div>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp"%>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    var rejectId="",
        idSelected ="";
    $(function () {
        $(".page-btn:first,.message:first").show();
        var $todo = $("#todo");

        //点击删除事件
        $("a[href='#del']").click(function () {
            $(this).hide();
            $("a[href='#yes'], a[href='#no'], table th:first, .ckb, .all").show();
        });
        //点击确认删除
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                var sure = confirm("您确定要删除所选项吗？");
                if(sure){
                    $("input[type=checkbox]").each(function (index) { // 遍历全部复选框的行
                        if (this.checked) { // 如果选中
                            idSelected += ($(this).parent("td").next("td").text() + ",");//获取勾选项id
                        }
                    });
                    $.ajax({
                        type:'post',
                        url: "${ctx}/admin/audit/journey/delete", // 请求处理页
                        dataType: "html",
                        data: {idSelected: idSelected},
                        success: function (result) {
                            if (result == '0'){
                                alert("删除失败");
                            }
                            else {
                                alert("删除成功");
                            }
                            window.location.href = "${ctx}/admin/audit/journey";
                        }
                    });
                }
            } else {
                alert("请先选中要删除的项！");
            }
        });
        //点击取消删除
        $("a[href='#no']").click(function () {
            $("a[href='#yes'], a[href='#no'], table th:first, .ckb, .all").hide();
            $("a[href='#del']").show();
        });

        //待审核全选复选框
        $todo.find("input[value='all']").click(function () {
            if (this.checked) { // 如果自己被选中
                $todo.find("input[type=checkbox]").prop("checked", true);
            } else { // 如果自己没被选中
                $todo.find("input[type=checkbox]").prop("checked", false);
            }
        });

        //删除已审核的游记,获取对应id
        $(".delete").click(function () {
            var sure = confirm("确定删除该游记吗？");
            if(sure){
                idSelected=$(this).parent().siblings(".note-id").text();
                $.ajax({
                    type:'post',
                    url: "${ctx}/admin/audit/journey/delete", // 请求处理页
                    dataType: "html",
                    data: {idSelected:idSelected},
                    success: function (result) {
                        if (result == '0'){
                            alert("删除失败");
                        }
                        else {
                            alert("删除成功");
                        }
                        window.location.href = "${ctx}/admin/audit/journey";
                    }
                });
            }
        });

        //拒绝模态框获取选择id
        $(".reject").click(function () {
            rejectId = $(this).parent().siblings(".note-id").text();
        });

        $(document)
        //发送审核不通过理由
            .on("click",".send-reason",function () {
                var managerReplyContent = $(this).parent().prev().find("textarea").val();
                $.ajax({
                    type:'post',
                    url: "${ctx}/admin/audit/journey/sendReason", // 请求处理页
                    dataType: "html",
                    data: {rejectId:rejectId,managerReplyContent:managerReplyContent},
                    success: function (result) {
                        if (result == '0'){
                            alert("发送失败");
                        }
                        else {
                            alert("发送成功");
                        }
                        window.location.href = "${ctx}/admin/audit/journey";
                    }
                });
            })
            //查看游记内容
            .on("click",".journey",function () {
                var tmp = $(".my-test-journey"),
                    noteId = $(this).parent().siblings(".note-id").text();
                tmp.html("");//清空标签间的内容
                $.ajax({
                    type:'get',
                    url: "${ctx}/admin/audit/journey/Content", // 请求处理页
                    dataType: "json",
                    data: {id:noteId},
                    success: function (data) {
                        tmp.append(data.content);
                    },error:function () {
                        alert("系统繁忙，请稍后重试");
                    }
                });
            })
    });

    /**
     * 分页必需
     */
    function page(n,s) {
        $('#pageNumber').val(n);
        $('#pageSize').val(s);
        $('#searchForm').submit();
        return false;
    }

    /**
     * 审核类型下拉框onChange事件
     * @returns {boolean}
     */
    function change() {
        $('#pageNumber').val(1);
        $('#searchForm').submit();
        return false;
    }
</script>
</body>
</html>
