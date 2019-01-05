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
    <title>游记评论</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        a[href='#yes'], a[href='#no'], th:first-child, .ckb{display: none}
        a[href='#del']{color: red}
        select {
            display: inline !important;
            margin-left: 10px;
            width: 30% !important;
        }
        .ac-com {
            width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            text-align: center;
        }
        .panel-head{line-height: 42px}
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
        .table{border-bottom: 2px solid #eee}
        .message{padding: 0 20px}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
      <strong><span class="icon-comments"></span> 游记评论</strong>
        <%--<select class="input" name="1">
            <option value="journey1">这是一篇游记</option>
            <option value="journey2">这是另一篇游记</option>
            <option value="journey3">这是另另一篇游记</option>
        </select>--%>
        <span style="float: right;line-height: 42px">
            <a class="icon-reply" href="javascript:window.history.back()"
               style="margin-right:20px"> 返回</a>
            <a class="icon-trash-o" href="#del" style="margin-right:20px"> 删除游记评论</a>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th>
                全选 <input type="checkbox" value="all">
            </th>
            <th>回复者</th>
            <th>被回复者</th>
            <th>评论内容</th>
            <th>评论时间</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${travelCommentList.list}" var="com">
        <tr>
            <td class="ckb"><input type="checkbox"></td>
            <td hidden="true" class="ac-com2">${com.id}</td>
            <td>${com.userName}</td>
            <td>${com.replyUserName}</td>
            <td width="300px">${com.content}<div class="ac-com"></div></td>
            <td><fmt:formatDate value="${com.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td>
                <a href="#" class="dialogs" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%">
                    查看更多
                </a>
            </td>
        </tr>
        </c:forEach>
    </table>
    <!-- 页数 -->
    <div class="message">
        共<i class="blue">${travelCommentList.total}</i>条记录，当前显示第&nbsp;<i
            class="blue">${travelCommentList.pageNum}/${travelCommentList.pages}</i>&nbsp;页
    </div>
    <div style="text-align:center;margin-top: -20px">
        <ul class="pagination">
            <!-- <li><a href="#">&laquo;</a></li> -->
            <c:if test="${!travelCommentList.isFirstPage}">
                <li><a href="${ctx}/admin/journeyComment/show?pageNumber=1&pageSize=${travelCommentList.pageSize}&noteId=${noteId}">首页</a></li>
                <li><a href="${ctx}/admin/journeyComment/show?pageNumber=${travelCommentList.prePage}&pageSize=${travelCommentList.pageSize}&noteId=${noteId}">上一页</a></li>
            </c:if>
            <c:forEach items="${travelCommentList.navigatepageNums}" var="navigatepageNum">
                <c:if test="${navigatepageNum==travelCommentList.pageNum}">
                    <li class="active"><a href="${ctx}/admin/journeyComment/show?pageNumber=${navigatepageNum}&pageSize=${travelCommentList.pageSize}&noteId=${noteId}">${navigatepageNum}</a></li>
                </c:if>
                <c:if test="${navigatepageNum!=travelCommentList.pageNum}">
                    <li><a href="${ctx}/admin/journeyComment/show?pageNumber=${navigatepageNum}&pageSize=${travelCommentList.pageSize}&noteId=${noteId}">${navigatepageNum}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${!travelCommentList.isLastPage}">
                <li><a href="${ctx}/admin/journeyComment/show?pageNumber=${travelCommentList.nextPage}&pageSize=${travelCommentList.pageSize}&noteId=${noteId}">下一页</a></li>
                <li><a href="${ctx}/admin/journeyComment/show?pageNumber=${travelCommentList.pages}&pageSize=${travelCommentList.pageSize}&noteId=${noteId}">最后一页</a></li>
            </c:if>
        </ul>
    </div>
    <!--详细游记评论模态框-->
    <div id="mydialog">
        <div class="dialog">
            <div class="dialog-head">
                <span class="close rotate-hover"></span><strong>详细游记评论</strong>
            </div>
            <div class="dialog-body">
                <textarea rows="5" style="width: 100%" class="input" placeholder="用户评论内容" readonly></textarea>
            </div>
            <div class="dialog-foot">
                <button class="button dialog-close">
                    关闭</button>
                <button class="button bg-green" onclick="btnSwitch()">
                    更改评论</button>
                <button class="button border-blue" style="display: none" onclick="btnSwitch()">
                    保存</button>
            </div>
        </div>
    </div>
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
                alert("您确定要删除所选的游记评论吗？");
                $("input[type=checkbox]").each(function (index) { // 遍历全部复选框的行
                    if (this.checked) { // 如果选中
                        idSelected += ($(this).parent("td").next("td").text() + ",");//获取勾选项id
                    }
                }); $.ajax({
                    type:'post',
                    url: "${ctx}/admin/journeyComment/delete", // 请求处理页
                    dataType: "html",
                    data: {idSelected: idSelected},
                    success: function (result) {
                        if (result == '0'){
                            alert("删除失败");
                        }
                        else {
                            alert("删除成功");
                        }
                        window.location.href = "${ctx}/admin/journeyComment/show";
                    }
                });
            } else {
                alert("请先选中要删除的游记评论！");
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
        $(".dialogs").click(function () {
            var txt = $(".ac-com").text();
            $(".dialog-body textarea").val(txt);
        })
    });
    //详细评论模态框
    function btnSwitch() {
        $(".dialog-foot button:lt(1)").toggle(); // 前2个：关闭与更改评论按钮
        $(".dialog-foot button:gt(1)").toggle(); // 后1个：保存按钮
        if($(".dialog-close").is(":visible")){
            $(".dialog-body textarea").attr("readonly",true);
        }else {
            $(".dialog-body textarea").attr("readonly",false);
        }
    }
</script>
</body>
</html>
