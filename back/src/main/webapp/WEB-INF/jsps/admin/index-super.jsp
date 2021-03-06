<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>超级管理员首页</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${ctx}/css/admin.css"/>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css"/>
    <link rel="stylesheet" href="${ctx}/css/myStyle.css"/>
    <style type="text/css">
        ul {
            display: none;
            padding-left: 5px !important;
        }

        .nav-active {
            border-left: 5px solid #0099FF
        }

        .leftnav h2:hover {
            border-left: 5px solid #0099FF;
        }
        .tip{display: none}
        .order-badge{
            padding: 1px 5px;
            border-radius: 18px;
            background-color: #f43530;
            color: #fff;
            text-align: center;
            font-size: 10px;
            vertical-align: top;
        }
        h5 a:hover{color: #23527c}
    </style>
</head>
<body>
<!--顶部header-->
<div class="my-header">
    <h1 style="float: left" class="animated fadein-top">
        <img src="${ctx}/images/logo.png" style="width: 60px;height: 50px">
        <span style="color: white;line-height: 50px">HLSF 后台管理系统</span>
    </h1>
    <h5>
        <a href="${ctx}/admin/logout" class="setting">
            <span class="icon-power-off"></span> 退出系统</a>
        <a href="${ctx}/admin/adminManage/toUpdatePassword" class="setting" target="right">
            <span class="icon-lock"></span> 修改密码</a>
        欢迎您：
        <c:choose>
            <c:when test="${sessionScope.admin.isSuperAdmin == '1'}">
                ${ sessionScope.admin.realName} [超级管理员]
            </c:when>
            <c:otherwise>
                ${ sessionScope.admin.realName} [管理员]
            </c:otherwise>
        </c:choose>
    </h5>
</div>
<!--左侧导航栏-->
<div class="leftnav">
    <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
    <c:if test="${sessionScope.admin.isSuperAdmin == '1'}">
        <h2><a href="${ctx}/admin/adminManage/showDatas" target="right"><span class="icon-user"></span>后台账户管理</a></h2>
    </c:if>
    <h2 class="nav-active"><a href="${ctx}/admin/media/list" target="right"><span class="icon-folder-open"></span>媒体管理</a></h2>
    <h2><a href="${ctx}/product/showProduct" target="right"><span class="icon-cube"></span>产品管理</a></h2>
    <ul>
        <li><a href="${ctx}/admin/calendar/getActivities" target="right"><span class="icon-caret-right"></span>活动日历</a></li>
        <li><a href="${ctx}/admin/productComment/showData" target="right"><span class="icon-caret-right"></span>产品评价</a></li>
        <li><a href="${ctx}/admin/category/" target="right"><span class="icon-caret-right"></span>分类管理</a></li>
        <li><a href="${ctx}/admin/city/" target="right"><span class="icon-caret-right"></span>出发城市管理</a></li>
        <li><a href="${ctx}/admin/destination/" target="right"><span class="icon-caret-right"></span>目的地管理</a></li>
        <li><a href="${ctx}/equip/equipmentPage" target="right"><span class="icon-caret-right"></span>装备管理</a></li>
        <li><a href="${ctx}/discount/discountPage" target="right"><span class="icon-caret-right"></span>优惠管理</a></li>
    </ul>
    <h2><a href="${ctx}/admin/outdoor/list" target="right"><span class="icon-mortar-board "></span>户外学堂</a></h2>
    <h2 id="audit"><a><span class="icon-check-square-o"></span>审核管理 </a></h2>
    <ul>
        <li><a href="${ctx}/admin/audit/journey" target="right"><span class="icon-caret-right"></span>游记审核</a></li>
        <li><a href="${ctx}/admin/audit/company" target="right"><span class="icon-caret-right"></span>团队定制</a></li>
        <li>
            <a href="${ctx}/admin/audit/photo" target="right" id="auditPhoto">
                <span class="icon-caret-right"></span>相册审核
            </a>
        </li>
    </ul>
    <h2><a href="${ctx}/leader/showIndex" target="right"><span class="icon-flag"></span>领队管理</a></h2>
    <h2><a href="${ctx}/user/admin/showUser" target="right"><span class="icon-users"></span>用户管理</a></h2>
    <h2 id="order">
        <a href="${ctx}/admin/order/" target="right">
            <span class="icon-file-text-o"></span>订单管理
        </a>
    </h2>
    <h2><a href="${ctx}/admin/totalCount/showTotalCount" target="right"><span class="icon-table"></span>数据统计</a></h2>
    <h2><a href="${ctx}/productCount/productCountPage" target="right"><span class="icon-cubes"></span>产品统计</a></h2>
    <%--<h2><a href="${ctx}/toChangeUrl" target="right"><span class="icon-refresh"></span>链接转换</a></h2>--%>
</div>
<!--当前位置提示-->
<div class="location">
    <ol class="breadcrumb">
        <li><span class="icon-home"></span> <a href="#">首页</a></li>
        <li class="active" id="current-page">媒体管理</li>
    </ol>
</div>
<!--内容显示块-->
<div class="admin">
    <iframe scrolling="auto" frameborder="0" src="${ctx}/admin/media/list" name="right" width="100%"
            height="100%"></iframe>
</div>
<footer>
    Copyright © 2017 北京师范大学珠海分校·凤凰山创业谷 版权所有
</footer>
<%--<c:if test="${refundOrders}">--%>
    <%--<button class="tip dialogs" data-toggle="click" data-target="#mydialog"--%>
            <%--data-mask="1" data-width="30%">退款未处理订单提示</button>--%>
    <%--<div id="mydialog">--%>
        <%--<div class="dialog animated shake">--%>
            <%--<div class="dialog-head">--%>
                <%--<span class="close rotate-hover"></span><strong>温馨提示</strong>--%>
            <%--</div>--%>
            <%--<div class="dialog-body">存在退款申请订单仍未审核，请及时处理。</div>--%>
            <%--<div class="dialog-foot">--%>
                <%--<button class="button dialog-close">OK，待会再处理</button>--%>
                <%--<button class="button bg-green dialog-close">现在去处理</button>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</c:if>--%>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script src="${ctx}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
    $(function () {
        check();
        setInterval(check, 10000);//每十秒检查一次
        var $order = $("#order"),
            $audit = $("#audit"),
            $auditPhoto = $("#auditPhoto");

        /**
         * 判断是否有待处理事务
         */
        function check() {
            $.ajax({
                url: "${ctx}/admin/check",
                type: "POST",
                dataType: "json",
                success: function (data) {
                    if (data.code == 200 && data.entity) {
                        //判断是否存在待处理订单
                        if (data.entity.isExistUncheckOrder &&
                            $order.html().indexOf("order-badge") == -1) {
                            $order.append('<span class="order-badge">待处理</span>');
                        }
                        //判断是否存在待处理相片
                        if (data.entity.isExistUncheckPhoto &&
                            $auditPhoto.html().indexOf("order-badge") == -1) {
                            $audit.append('<span class="order-badge">待处理</span>');
                            $auditPhoto.append('<span class="order-badge">待处理</span>');
                        }
                    }
                }
            });
        }
        setTimeout(function () {$(".tip").trigger("click")},1000);
        $(document).on("click",".dialog-foot .bg-green",function () {
            $("#order").trigger("click");
        }).on("click","#order",function () {
            var tmp = $(this).find(".order-badge");
            tmp.addClass("animated fadeout-top");
            setTimeout(function () {
                tmp.remove();
            },2000)
        }).on("click","#auditPhoto",function () {
            var tmp1 = $("#audit").find(".order-badge"),
                tmp2 = $(this).find(".order-badge");
            tmp1.addClass("animated fadeout-top");
            tmp2.addClass("animated fadeout-top");
            setTimeout(function () {
                tmp1.remove();
                tmp2.remove();
            },2000);
        });
        // 点击左侧导航效果
        $(".leftnav h2").click(function () {
            $(this).addClass("nav-active");
            $(this).siblings().removeClass("nav-active");
            var page = $(this).find("a").attr("href");
            $("iframe").prop("src",page);
            // 当前一级导航位置
            $("#current-page").text($(this).text());
            $(".leftnav li").click(function () {
                //当前二级导航页面位置
                $("#current-page").text($(this).parent("ul").prev().text() + " / " + $(this).text());
                $(".leftnav h2").removeClass("nav-active");
                $(this).parent("ul").prev().addClass("nav-active");
            });
            //当前下拉展开
            $(this).next("ul").slideToggle(200);
            $(this).siblings().next("ul").slideUp(200);//其他下拉收起
            $(this).toggleClass("on");
        });
    });
</script>
</body>
</html>