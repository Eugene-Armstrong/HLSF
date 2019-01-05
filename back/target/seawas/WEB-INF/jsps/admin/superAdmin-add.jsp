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
    <title>超级管理员-添加账户</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <style type="text/css">
        form {
            padding: 2% 10%;
        }
        li {
            list-style: none;
        }
        button {
            margin-right: 20px !important;
        }
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-plus-square-o"></span> 添加管理员</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="${ctx}/admin/adminManage/addAdmin">
            <div class="form-group">
                <div class="label">
                    <label>账户类型：</label>
                </div>
                <div class="field">
                    <select class="input w50" name="adminType" required>
                        <option value="ordinary" name="ordinary">管理员</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>真实姓名：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" style="width: auto" name="adminUser" required/>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>账户名：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" style="width: auto" name="adminLoginName" required>
                </div>
            </div>
            <div id="input-pwd" style="display: block;">
                <div class="form-group">
                    <div class="label">
                        <label>新密码：</label>
                    </div>
                    <div class="field">
                        <input type="password" class="input w50" name="newpass" size="50" placeholder="请输入新密码" data-validate="required:请输入新密码,length#>=6:新密码不能小于6位" required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>确认密码：</label>
                    </div>
                    <div class="field">
                        <input type="password" class="input w50" name="renewpass" size="50" placeholder="请再次输入新密码" data-validate="required:请再次输入新密码,repeat#newpass:两次输入的密码不一致" required>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                        <button id="add" class="button bg-green icon-plus"> 确认添加</button>
                        <a href="${ctx}/admin/adminManage/showDatas" class="button bg-main icon-repeat"> 取消</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="${ctx}/js/jquery-1.8.3.min.js"></script>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
</body>
</html>