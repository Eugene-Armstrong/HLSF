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
    <title>优惠管理</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        td .input{
            display: inline;
        }
        td textarea{
            color: #999;
        }
        td{border-top: 0!important;}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-credit-card"></span> 优惠管理</strong>
    </div>
    <table class="table table-hover">
        <tr>
            <td class="text-right" width="20%">删除优惠：</td>
            <td>
                <select class="input">
                    <option value="">请选择要删除的优惠</option>
                    <c:forEach items="${promotionList}" var="pro">
                        <option value="${pro.id}">${pro.detail}</option>
                    </c:forEach>
                </select>
                <button class="button border-red delete-btn">
                    删除
                </button>
            </td>
        </tr>
    </table>
    <form action="${ctx}/discount/addDiscount" method="post">
        <table class="table table-hover">
        <tr>
            <td class="text-right" width="20%">添加优惠：</td>
            <td>
                <input type="text" class="input" name="promoDetail" placeholder="请输入新的优惠名称" required>
            </td>
        </tr>
        <tr>
            <td class="text-right">优惠规则：</td>
            <td>
                <input type="text" class="input" name="promoRule" placeholder="请输入优惠规则，例如：八折请输入0.8" required>
                <!--<button class="button border-blue">添加</button>-->
            </td>
        </tr>
        <tr>
            <td class="text-right">已添加：</td>
            <td>
                <textarea rows="3" class="input" readonly>${promotions}</textarea>
            </td>
        </tr>
        <tr>
            <td class="text-right"></td>
            <td>
                <button type="submit" class="button bg-green">保存</button>
            </td>
        </tr>
    </table>
    </form>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        var discountSelected = "";
        //选择优惠传值
        $(".delete-btn").click(function () {
            var t = $("select");
            if(t.get(0).selectedIndex == 0){
                alert("请先选择要删除的装备");
            }else{
                discountSelected = t.find("option:selected").val();
                $.ajax({
                    type:"post",
                    url: "${ctx}/discount/deleteDiscount", // 请求处理页
                    dataType: "html",
                    data: {discountSelected: discountSelected},
                    success: function (result) {
                        if (result == '1'){
                            alert("删除成功！");
                        }else {
                            alert("删除失败，请重新尝试！");
                        }
                        window.location.href = "${ctx}/discount/discountPage";
                    },
                    error:function () {
                        alert("系统繁忙，请稍后再试");
                    }
                });
            }
        })
    });
</script>
</body>
</html>
