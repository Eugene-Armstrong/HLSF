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
    <title>后台账户管理</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        select {
            display: inline !important;
            margin-left: 10px;
            width: 30% !important;
        }
        a[href='#yes'], a[href='#no'], th:first-child, .ckb{display: none}
        a[href='#del']{color: red}
        .dialog-body td{border-top:none; }
        /*超级管理员复选框*/
        .all {
            display: none;
        }
        #super {
            display: none;
        }
    </style>
</head>
<body>
<!--修改信息模态框-->
<div id="change">
    <div class="dialog">
        <div class="dialog-head">
            <strong style="font-size: 16px">修改信息</strong>
            <span class="close rotate-hover"></span>
        </div>
        <div class="dialog-body">
            <form action="${ctx}/admin/adminManage/updateAdmin">
                <table class="table">
                    <tr style="display: none">
                        <td class="text-right">账户ID：</td>
                        <td><input type="text" class="input aID" placeholder="请输入账户ID" name="aID"></td>
                    </tr>
                    <tr>
                        <td class="text-right">登录账号：</td>
                        <td><input type="text" class="input aName" placeholder="请输入账户名" name="aName"></td>
                    </tr>
                    <tr>
                        <td class="text-right">真实姓名：</td>
                        <td><input type="text" class="input aRealName" placeholder="请输入真实姓名" name="aRealName"></td>
                    </tr>
                </table>
                <div class="dialog-foot">
                    <button class="button dialog-close" type="button">
                        取消
                    </button>
                    <button class="button bg-green" type="submit">
                        保存
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-user"></span> 后台账户管理</strong>
        <span style="float: right">
            <a class="icon-plus-square-o" href="${ctx}/admin/adminManage/addAdminPage" style="margin-right:20px"> 添加账户</a>
            <a class="icon-trash-o" href="#del" style="margin-right:20px"> 删除账户</a>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>
    </div>
    <!--管理员-->
    <table id="ordinary" class="table table-hover text-center">
        <tr>
            <th>
                全选 <input type="checkbox" value="all">
            </th>
            <th>账户ID</th>
            <th>真实姓名</th>
            <th>账户名</th>
            <th>最后登录时间</th>
            <th>最后登录IP</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${normalAdmins }" var="normal">
            <tr>
                <td class="ckb"><input type="checkbox"></td>
                <td class="id-num">${normal.id}</td>
                <td class="real-name">${normal.realName}</td>
                <td class="name">${normal.loginName}</td>
                <td><fmt:formatDate value="${normal.loginDate}"
                                    pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td>${normal.loginIp}</td>
                <td>
                    <a href="#" class="dialogs change-pwd" data-toggle="click" data-target="#change"
                       data-mask="1" data-width="50%">修改信息</a> /
                    <a href="#" class="reset-pwd" >重置密码</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        var idSelected = "";
        $("th:eq(1),.id-num,.super-id").hide();
        //点击删除事件
        $("a[href='#del']").click(function () {
            $(this).hide();
            $("a[href='#yes'], a[href='#no'], th:first, .ckb, .all").show();
        });
        //点击确认删除
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                $("input[type=checkbox]").each(function () { // 遍历全部复选框的行
                    if (this.checked) { // 如果选中
                        idSelected += ($(this).parent("td").next("td").text() + ",");//获取勾选项id
                    }
                });
                $.ajax({
                    type:'post',
                    url: "${ctx}/admin/adminManage/deleteAdmin", // 请求处理页
                    dataType: "html",
                    data: {idSelected: idSelected},
                    success: function (result) {
                        if (result == '0'){
                            alert("删除失败");
                        }
                        else {
                            alert("删除成功");
                        }
                        window.location.href = "${ctx}/admin/adminManage/showDatas";
                    },
                    error: function () {
                        alert("系统繁忙，请稍后再试");
                    }
                });
//                    alert(idSelected);//当前所有所选项的id
//                    idSelected = "";//下一步清空上一步已被删除的id
            } else {
                alert("请先选中要删除的后台账户！");
            }
        });
        //点击取消删除
        $("a[href='#no']").click(function () {
            $("a[href='#yes'], a[href='#no'], th:first, .ckb, .all").hide();
            $("a[href='#del']").show();
        });
        //管理员全选复选框
        $("#ordinary input[value='all']").click(function () {
            if (this.checked) { // 如果自己被选中
                $("#ordinary input[type=checkbox]").prop("checked", true);
            } else { // 如果自己没被选中
                $("#ordinary input[type=checkbox]").prop("checked", false);
            }
        });

        //模态框表单获取对应信息
        $(".change-pwd").click(function () {
            var aID = $(this).parent().siblings(".id-num");
            var aRealName = $(this).parent().siblings(".real-name");
            var aName = $(this).parent().siblings(".name");
            $(".dialog-body .aID").val(aID.text());
            $(".dialog-body .aRealName").val(aRealName.text());
            $(".dialog-body .aName").val(aName.text());
        });
        //点击重置密码
        $(".reset-pwd").click(function () {
            var ID = $(this).parent().siblings(".id-num").text();
            $.ajax({
                type:"post",
                url: "${ctx}/admin/adminManage/reSetPwd", // 请求处理页
                dataType: "json",
                data: {ID: ID},
                success: function (result) {
                    if (result == '1'){
                        alert("重置密码成功！初始密码为：HLSFHWLY，请尽快登录更改密码！");
                    }else {
                        alert("重置密码失败，请重新尝试！");
                    }
                },
                error:function () {
                    alert("系统繁忙，请稍后再试");
                }
            });
        })
    });
</script>
</body>
</html>
