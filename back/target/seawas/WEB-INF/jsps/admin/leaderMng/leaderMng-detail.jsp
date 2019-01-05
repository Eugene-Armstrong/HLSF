<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>领队详细信息</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <script src="${ctx}/js/jquery.js"></script>
    <script src="${ctx}/js/pintuer.js"></script>
    <script type="text/javascript">
        $(function () {
            //
        });
    </script>
    <style>
        td{text-align: center}
        .panel-head{overflow: hidden;line-height: 80px}
        .panel{text-align: center}
        .panel button{margin: 20px}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="float-left"><span class="icon-list-alt"></span> 领队详细信息</strong>
        <img src="${leader.headImgUrl}" class="input float-right rotate-hover"
             style="width: 80px;height: 80px;border-radius: 50%;">
        <span class="float-right"><span class="icon-user"></span> 头像：</span>
        <a class="float-right" href="${ctx}/leader/showIndex" style="margin-right: 15px">
            <span class="icon-reply"></span> 返回</a>
    </div>
    <table class="table table-bordered table-hover">
        <tr>
            <th>昵称</th>
            <th>真实姓名</th>
            <th>性别</th>
            <th>年龄</th>
            <th>手机号码</th>
            <th>身份证号</th>
            <th>兴趣爱好</th>
            <th>标签</th>
        </tr>
        <tr>
            <td>${leader.nickName}</td>
            <td>${leader.realName}</td>
            <td>${leader.sex}</td>
            <td>${leader.age}</td>
            <td>${leader.phone}</td>
            <td>${leader.certId}</td>
            <td>${leader.hobby}</td>
            <td>${leader.tag}</td>
        </tr>
        <tr>
            <td style="border: none" colspan="11"></td>
        </tr><tr>
        <td style="border: none" colspan="11"></td>
    </tr>
        <tr>
            <th>领队工号</th>
            <th>用户类型</th>
            <th>积分</th>
            <th>经验值</th>
            <th>带队次数</th>
            <th>领队评分</th>
            <th>最后登录时间</th>
            <th>创建时间</th>
        </tr>
        <tr>
            <td>${leader.workNo}</td>
            <td>${fns:getDictLabel('userType', leader.type ,'')}</td>
            <td>${leader.integral}</td>
            <td>${leader.experValue}</td>
            <td>${leader.leaderNum}</td>
            <td><fmt:formatNumber value="${leader.score}" pattern="#.0#"/></td>
            <td><fmt:formatDate value="${leader.lastLoginTime}"
                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td><fmt:formatDate value="${leader.createTime}"
                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
        </tr>
        <tr>
            <td style="border: none" colspan="11"></td>
        </tr><tr>
        <td style="border: none" colspan="11"></td>
    </tr>
        <tr>
            <th colspan="5" width="50%">个人经历</th>
            <th colspan="5" width="50%">座右铭</th>
        </tr>
        <tr>
            <td colspan="5">
                ${leader.experience}
            </td>
            <td colspan="5">${leader.motto}</td>
        </tr>
    </table>
    <a  href="${ctx}/leader/leaderActivity?id=${leader.id}"><button class="button border-blue">查看带队活动</button></a>
</div>
</body>
</html>

