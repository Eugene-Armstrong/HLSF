<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>领队列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body{
            padding: 40px 10px 70px 0;
            background: url('${ctx}/images/leader-bg.jpg') no-repeat fixed;
            background-size: cover
        }
        .leader{margin-top: 20px}
        .leader-info{
            position: absolute;
            width: 75px;
            text-align: center;
        }
        .leader-name{font-size: 12px;color: #fff;padding: 0 5px}
        .leader-img {
            border-radius: 50%;
            width: 55%;
        }
        .my-item{
            position: relative;
            margin:0 0 2px 75px;
            padding: 10px;
            background: rgba(255,255,255,.8);
        }
        .my-status-1,.my-status-2,.my-status-3,.my-status-4,.my-status-5
        {margin-top: 9px;float: right;font-size: 12px}
        .weui-tabbar{position: fixed;bottom: 0}
    </style>
</head>
<body>
<div class="page-title">
    <a href="javascript:history.back()" class="return"></a>
    领队动态
</div>

<c:forEach items="${leaders}" var="leader">
    <c:if test="${fns:getActivityFromLeader(leader.id,sessionScope.currentCity.id)!=[]}">
    <div class="leader">
        <div class="leader-info">
            <a href="${ctx}/wechat/user/showUserIndex?userId=${leader.id}">
                <img src="${leader.headImgUrl}" class="leader-img" alt="领队头像">
            </a>
            <div class="leader-name">${leader.nickName}</div>
        </div>
        <c:forEach items="${leaderActivitys}" var="la">
            <c:if test="${la.leader.id == leader.id}">
                <div class="my-item">
                    <a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${la.id}&productId=${la.product.id}&cityId=${sessionScope.currentCity.id}">
                        <strong>${la.product.name}</strong>
                        <div>
                            <span class="my-detail">
                                <fmt:formatDate value="${la.departTime}" pattern="yyyy-MM-dd HH:mm" />出发
                            </span>
                            <c:if test="${la.state =='未成行'}">
                                <span class='my-status-1'>未成行</span><br>
                            </c:if>
                            <c:if test="${la.state =='已成行'}">
                                <span class='my-status-2'>已成行</span><br>
                            </c:if>
                            <c:if test="${la.state =='活动中'}">
                                <span class='my-status-3'>活动中</span><br>
                            </c:if>
                            <c:if test="${la.state =='已满人'}">
                                <span class='my-status-4'>已满人</span><br>
                            </c:if>
                            <c:if test="${la.state =='已结束'}">
                                <span class='my-status-5'>已结束</span><br>
                            </c:if>
                        </div>
                    </a>
                </div>
            </c:if>

        </c:forEach>
    </div>
    </c:if>
</c:forEach>
<!--底部导航栏-->
<div class="weui-tabbar">
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}" class="weui-tabbar__item">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-home.png" alt="">
        </div>
        <p class="weui-tabbar__label">首页</p>
    </a>
    <a href="${ctx}/wechat/society/showSocietyPage" class="weui-tabbar__item">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-society.png" alt="">
        </div>
        <p class="weui-tabbar__label">社区</p>
    </a>
    <a href="${ctx}/wechat/outdoor/showOutdoorPage" class="weui-tabbar__item">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-out.png" alt="">
        </div>
        <p class="weui-tabbar__label">户外学堂</p>
    </a>
    <a href="${ctx}/wechat/order/" class="weui-tabbar__item">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-order.png" alt="">
        </div>
        <p class="weui-tabbar__label">订单</p>
    </a>
    <a href="${ctx}/wechat/mine/showMinePage" class="weui-tabbar__item">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-mine.png" alt="">
        </div>
        <p class="weui-tabbar__label">我的</p>
    </a>
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/fastclick.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        FastClick.attach(document.body);
    });
    $(".none").each(function () {
        $(this).css("height",$(this).prev().height()-20);
    });
</script>
</body>
</html>
