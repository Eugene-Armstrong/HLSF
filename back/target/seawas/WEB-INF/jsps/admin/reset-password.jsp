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
    <title>修改密码</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        .form-group{margin: 0}
        form{padding:0 10%}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-lock"></span> 修改我的密码</strong>
        <a href="javascript:history.back()" class="float-right">
            <span class=icon-reply></span> 返回
        </a>
    </div>
    <div class="body-content">
        <form method="post" class="form-x" action="${ctx}/admin/adminManage/updatePassword">
            <div class="form-group" style="display: none">
                <input type="text" name="user-id" value="${admin.id}">
            </div>
            <div class="form-group">
                <div class="label">
                <label>原密码：</label>
            </div>
                <div class="field">
                    <input type="password" class="input" name="orgPwd" size="50" placeholder="请输入原密码">
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>新密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input" name="newpass" size="50" placeholder="请输入新密码"
                           data-validate="required:请输入新密码,length#>=6:新密码不能小于6位" required>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>确认密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input" name="renewpass" size="50" placeholder="请再次输入新密码"
                           data-validate="required:请再次输入新密码,repeat#newpass:两次输入的密码不一致" required>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                    <button id="save" class="button bg-green icon-check-square-o" type="submit"> 保存</button>
                    &nbsp;&nbsp;
                    <a href="javascript:history.back()" class="button bg-main icon-ban"> 取消</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
</body>
</html>
