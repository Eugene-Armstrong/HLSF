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
    <title>出发城市管理</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        td .input{
            display: inline;
        }
        td textarea{
            color: #999;;
        }
        td{border-top: 0!important;}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-institution "></span> 出发城市管理</strong>
    </div>
    <table class="table table-hover">
        <tr>
            <td class="text-right">添加旅游城市：</td>
            <td>
                <input id="newCity" type="text" class="input" placeholder="请输入新的旅游城市">
                <button class="button border-blue" onclick="saveCity()">添加</button>
            </td>
        </tr>
        <tr>
            <td class="text-right">删除城市：</td>
            <td>
                <select class="input" id="deleteSelect">
                    <option value="">请选择城市</option>
                    <c:forEach var="city" items="${cityList}">
                        <option value="${city.id}">${city.name}</option>
                    </c:forEach>
                </select>
                <button class="button border-red dialogs" data-toggle="click"
                        data-target="#mydialog" data-mask="1" data-width="50%">
                    删除
                </button>
            </td>
        </tr>
        <tr>
            <td class="text-right">已添加：</td>
            <td>
                <textarea rows="3" class="input" placeholder="仍未添加旅游城市" readonly><c:forEach var="city" items="${cityList}">${city.name};</c:forEach></textarea>
            </td>
        </tr>
    </table>
    <!--确认删除模态框-->
    <div id="mydialog">
        <div class="dialog">
            <div class="dialog-head">
                <span class="close rotate-hover"></span><strong>删除城市</strong>
            </div>
            <div class="dialog-body">
                确定删除此城市吗？
            </div>
            <div class="dialog-foot">
                <button class="button dialog-close">
                    取消</button>
                <button class="button border-blue" onclick="deleteCity()">
                    确定</button>
            </div>
        </div>
    </div>
</div>
</body>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script>
    /**
     * 添加出发城市
     */
    var newCity = $('#newCity');
    function saveCity() {
        $.ajax({
            url: "${ctx}/admin/city/save",
            type: "POST",
            dataType: "json",
            data: {newCity: newCity.val()},
            success: function (data) {
                if (data.code == 200) {
                    alert(data.message);
                    location.reload(true);
                } else {
                    alert(data.message);
                    newCity.focus();
                }
            },
            error: function () {
                alert("系统繁忙");
            }
        });
    }

    /**
     * 删除出发城市
     */
    function deleteCity() {
        $.ajax({
            url: "${ctx}/admin/city/delete",
            type: "POST",
            dataType: "json",
            data: {cityId: $('#deleteSelect').val()},
            success: function (data) {
                if (data.code == 200) {
                    alert(data.message);
                    location.reload(true);
                } else {
                    alert(data.message);
                }
            },
            error: function () {
                alert("系统繁忙");
            }
        });
    }
</script>
</html>