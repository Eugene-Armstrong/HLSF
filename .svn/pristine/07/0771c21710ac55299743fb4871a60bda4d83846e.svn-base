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
    <title>约伴审核</title>
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
        #success,#fail{display: none}
        .table{border-bottom: 2px solid #eee}
        .page-btn{text-align:center;margin-top: -20px;display: none}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-check-square-o"></span> 约伴审核</strong>
        <select class="input" name="auditType">
            <option value="todo">待审核</option>
            <option value="success">审核通过</option>
            <option value="fail">审核不通过</option>
        </select>
        <%--<span style="float: right;line-height: 42px">
            <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 删除</a>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>--%>
    </div>
    <!--待审核-->
    <table id="todo" class="table table-hover text-center">
        <tr>
            <th width="10%" class="all">
                全选 <input type="checkbox" value="all">
            </th>
            <th width="15%">用户名</th>
            <th width="15%">出发城市</th>
            <th width="20%">申请时间</th>
            <th width="5%">查看</th>
            <th width="25%">审核</th>
        </tr>
        <c:forEach items="${customs.list}" var="custom">
            <tr>
                <td class="ckb"><input type="checkbox"></td>
                <td hidden class="cus-id">${custom.id}</td>
                <td>${custom.user.realName}</td>
                <td>${custom.departCity}</td>
                <td><fmt:formatDate value="${custom.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td><a href="${ctx}/admin/audit/company/detail?customId=${custom.id}">详情</a></td>
                <td>
                    <a href="${ctx}/admin/audit/company/pass?customId=${custom.id}">通过并发布</a> /
                    <a href="#" class="dialogs reject" data-toggle="click" data-target="#reject" data-mask="1" data-width="50%">否决</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <!-- 页数 -->
    <div class="message">
        共<i class="blue">${customs.total}</i>条记录，当前显示第&nbsp;<i
            class="blue">${customs.pageNum}/${customs.pages}</i>&nbsp;页
    </div>
    <div class="page-btn">
        <ul class="pagination">
            <!-- <li><a href="#">&laquo;</a></li> -->
            <c:if test="${!customs.isFirstPage}">
                <li><a href="${ctx}/admin/audit/partner?pageNumber1=1&pageSize1=${customs.pageSize}">首页</a></li>
                <li><a href="${ctx}/admin/audit/partner?pageNumber1=${customs.prePage}&pageSize1=${customs.pageSize}">上一页</a></li>
            </c:if>
            <c:forEach items="${customs.navigatepageNums}" var="navigatepageNum1">
                <c:if test="${navigatepageNum1==customs.pageNum}">
                    <li class="active"><a href="${ctx}/admin/audit/partner?pageNumber1=${navigatepageNum1}&pageSize1=${customs.pageSize}">${navigatepageNum1}</a></li>
                </c:if>
                <c:if test="${navigatepageNum1!=customs.pageNum}">
                    <li><a href="${ctx}/admin/audit/partner?pageNumber1=${navigatepageNum1}&pageSize1=${customs.pageSize}">${navigatepageNum1}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${!customs.isLastPage}">
                <li><a href="${ctx}/admin/audit/partner?pageNumber1=${customs.nextPage}&pageSize1=${customs.pageSize}">下一页</a></li>
                <li><a href="${ctx}/admin/audit/partner?pageNumber1=${customs.pages}&pageSize1=${customs.pageSize}">最后一页</a></li>
            </c:if>
        </ul>
    </div>
    <!--审核通过-->
    <table id="success" class="table table-hover text-center">
        <tr >
            <th width="10%" class="all">
                全选 <input type="checkbox" value="all">
            </th>
            <th width="15%">用户名</th>
            <th width="15%">出发城市</th>
            <th width="20%">申请时间</th>
            <th width="5%">查看</th>
            <th width="25%">审核</th>
        </tr>
        <c:forEach items="${passCustoms.list}" var="pass">
        <tr>
            <td class="ckb"><input type="checkbox"></td>
            <td>${pass.user.realName}</td>
            <td>${pass.departCity}</td>
            <td><fmt:formatDate value="${pass.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td><a href="/admin/audit/company/showPassDetail?customizedId=${pass.id}">详情</a></td><%--弹到生成的产品详情--%>
            <td class="text-blue">已通过</td>
        <tr>
            </c:forEach>
    </table>
    <!-- 页数 -->
    <div class="message">
        共<i class="blue">${passCustoms.total}</i>条记录，当前显示第&nbsp;<i
            class="blue">${passCustoms.pageNum}/${passCustoms.pages}</i>&nbsp;页
    </div>
    <div class="page-btn">
        <ul class="pagination">
            <!-- <li><a href="#">&laquo;</a></li> -->
            <c:if test="${!passCustoms.isFirstPage}">
                <li><a href="${ctx}/admin/audit/partner?pageNumber2=1&pageSize2=${passCustoms.pageSize}">首页</a></li>
                <li><a href="${ctx}/admin/audit/partner?pageNumber2=${passCustoms.prePage}&pageSize2=${passCustoms.pageSize}">上一页</a></li>
            </c:if>
            <c:forEach items="${passCustoms.navigatepageNums}" var="navigatepageNum2">
                <c:if test="${navigatepageNum2==passCustoms.pageNum}">
                    <li class="active"><a href="${ctx}/admin/audit/partner?pageNumber2=${navigatepageNum2}&pageSize2=${passCustoms.pageSize}">${navigatepageNum2}</a></li>
                </c:if>
                <c:if test="${navigatepageNum2!=passCustoms.pageNum}">
                    <li><a href="${ctx}/admin/audit/partner?pageNumber2=${navigatepageNum2}&pageSize2=${passCustoms.pageSize}">${navigatepageNum2}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${!passCustoms.isLastPage}">
                <li><a href="${ctx}/admin/audit/partner?pageNumber2=${passCustoms.nextPage}&pageSize2=${passCustoms.pageSize}">下一页</a></li>
                <li><a href="${ctx}/admin/audit/partner?pageNumber2=${passCustoms.pages}&pageSize2=${passCustoms.pageSize}">最后一页</a></li>
            </c:if>
        </ul>
    </div>
    <!--审核不通过-->
    <table id="fail" class="table table-hover text-center">
        <tr >
            <th width="10%" class="all">
                全选 <input type="checkbox" value="all">
            </th>
            <th width="15%">用户名</th>
            <th width="15%">出发城市</th>
            <th width="20%">申请时间</th>
            <th width="5%">查看</th>
            <th width="25%">审核</th>
        </tr>
        <c:forEach items="${unpassCustoms.list}" var="un">
        <tr>
            <td class="ckb"><input type="checkbox"></td>
            <td>${un.user.realName}</td>
            <td>${un.departCity}</td>
            <td><fmt:formatDate value="${un.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td><a href="${ctx}/admin/audit/company/detail?customId=${custom.id}">详情</a></td>
            <td class="text-red">不通过</td>
        <tr>
            </c:forEach>
    </table>
    <!-- 页数 -->
    <div class="message">
        共<i class="blue">${unpassCustoms.total}</i>条记录，当前显示第&nbsp;<i
            class="blue">${unpassCustoms.pageNum}/${unpassCustoms.pages}</i>&nbsp;页
    </div>
    <div class="page-btn">
        <ul class="pagination">
            <!-- <li><a href="#">&laquo;</a></li> -->
            <c:if test="${!unpassCustoms.isFirstPage}">
                <li><a href="${ctx}/admin/audit/partner?pageNumber3=1&pageSize3=${unpassCustoms.pageSize}">首页</a></li>
                <li><a href="${ctx}/admin/audit/partner?pageNumber3=${unpassCustoms.prePage}&pageSize3=${unpassCustoms.pageSize}">上一页</a></li>
            </c:if>
            <c:forEach items="${unpassCustoms.navigatepageNums}" var="navigatepageNum3">
                <c:if test="${navigatepageNum3==unpassCustoms.pageNum}">
                    <li class="active"><a href="${ctx}/admin/audit/partner?pageNumber3=${navigatepageNum3}&pageSize3=${unpassCustoms.pageSize}">${navigatepageNum3}</a></li>
                </c:if>
                <c:if test="${navigatepageNum3!=unpassCustoms.pageNum}">
                    <li><a href="${ctx}/admin/audit/partner?pageNumber3=${navigatepageNum3}&pageSize3=${unpassCustoms.pageSize3}">${navigatepageNum3}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${!unpassCustoms.isLastPage}">
                <li><a href="${ctx}/admin/audit/partner?pageNumber3=${unpassCustoms.nextPage}&pageSize3=${unpassCustoms.pageSize}">下一页</a></li>
                <li><a href="${ctx}/admin/audit/partner?pageNumber3=${unpassCustoms.pages}&pageSize3=${unpassCustoms.pageSize}">最后一页</a></li>
            </c:if>
        </ul>
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
                <button class="button bg-green dialog-close">
                    发送</button>
                <button class="button dialog-close">
                    取消</button>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    var rejectId="";
    $(function () {
        $(".page-btn:first,.message:first").show();
        var $todo = $("#todo"),
            $success = $("#success"),
            $fail = $("#fail"),
            $message = $(".message"),
            $pageBtn = $(".page-btn");
        /*//点击删除前
         $("a[href='#yes'], a[href='#no'], table th:first, .ckb").hide();*/
        //点击删除事件
        $("a[href='#del']").css("color", "red")
            .click(function () {
                $(this).hide();
                $("a[href='#yes'], a[href='#no'], table th:first, .ckb, .all").show();
            });
        //点击确认删除
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                $("input[type=checkbox]").each(function (index) { // 遍历全部复选框的行
                    if (this.checked) { // 如果选中
                        $(this).parent("td").parent("tr").remove();// 获取选中的值，并删除对应内容
                    }
                })
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
        $("#todo input[value='all']").click(function () {
            if (this.checked) { // 如果自己被选中
                $("#todo input[type=checkbox]").prop("checked", true);
            } else { // 如果自己没被选中
                $("#todo input[type=checkbox]").prop("checked", false);
            }
        });
        //审核通过全选复选框
        $("#success input[value='all']").click(function () {
            if (this.checked) { // 如果自己被选中
                $("#success input[type=checkbox]").prop("checked", true);
            } else { // 如果自己没被选中
                $("#success input[type=checkbox]").prop("checked", false);
            }
        });
        //审核不通过全选复选框
        $("#fail input[value='all']").click(function () {
            if (this.checked) { // 如果自己被选中
                $("#fail input[type=checkbox]").prop("checked", true);
            } else { // 如果自己没被选中
                $("#fail input[type=checkbox]").prop("checked", false);
            }
        });

        //选择活动显示信息
        $("select").change(function () {
            $message.hide();
            $pageBtn.hide();
            if($(this).get(0).selectedIndex === 0){
                $todo.show();
                $todo.next().show();
                $todo.next().next().show();
                $success.hide();
                $fail.hide();
            }else if($(this).get(0).selectedIndex === 1){
                $todo.hide();
                $success.show();
                $success.next().show();
                $success.next().next().show();
                $fail.hide();
            }else{
                $todo.hide();
                $success.hide();
                $fail.show();
                $fail.next().show();
                $fail.next().next().show();
            }
        })

        //记录否决的customid
        $(".reject").click(function () {
            rejectId = $(this).parent().siblings(".cus-id").text();
        })
    });
    function sendReason() {
        var replyContent =   $(".dialog-body textarea").text();

        $.ajax({
            type:'post',
            url: "${ctx}/admin/audit/company/sendReason", // 请求处理页
            dataType: "html",
            data: {rejectId:rejectId,replyContent:replyContent},
            success: function (result) {
                if (result == '0'){
                    alert("发送失败");
                }
                else {
                    alert("发送成功");
                }
                window.location.href = "${ctx}/admin/audit/company";
            }
        });
    }
</script>
</body>
</html>
