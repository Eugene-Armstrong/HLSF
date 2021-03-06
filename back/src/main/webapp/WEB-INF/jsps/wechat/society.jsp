<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>社区</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body{padding-bottom: 50px}
        .weui-panel {margin: 10px;border-radius: 10px}
        .nav-bar{background: url("${ctx}/images/bg-1.jpg") center no-repeat;background-size:200% 100%;}
        .weui-grid__label img{height: 20px}
        .weui-cells__title img{height: 24px}
        .weui-grid__icon,.weui-media-box__hd{width: 36px!important;height: 36px!important;}
        .my-rank img{width: 80%!important;}
        .my-img{border-radius: 50%}
        .weui-media-box__bd p{margin-top: 5px}
        .hot-content{background: #fff}
        .my-pic{padding:8px}
        .block-title{
            margin-top: 10px;
            padding: 12px 8px 4px 8px;
            background: #fff;
        }
        .title-content{
            border-left: 5px solid #37a1ff;
            padding: 0 8px;
            font-size: 14px;
        }
        .my-mask:before {
            content: " ";
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background-color: rgba(0,0,0,.3);
            text-align: center;
        }
        .my-pic{text-align: center}
        .my-pic img{height: 100%}
        .activity-title{
            position: absolute;
            height: 20%;
            color: rgba(255,255,255,0.9);
            z-index: 99;
            top:38%;
            left: 0;
            right: 0;
        }
        .empty{width: 50%;margin: 5% 25% 20px 25%;}
        .weui-cell_link{color: #333}
        .main-title{font-size: 20px;letter-spacing:3px;font-family: "微软雅黑 Light"}
    </style>
</head>
<body>
<%--<img src="${ctx}/images/waiting.jpg" style="width: 100%;height: 100%">--%>
<!--海报图-->
<img src="${ctx}/images/society-banner.jpg" style="width: 100%" alt="">
<!--游记列表-->
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__ft">
        <a href="${ctx}/wechat/journey/showJourneyIndex"
           class="weui-cell weui-cell_access weui-cell_link">
            <span class="weui-cell__bd">
                <img src="${ctx}/images/collected.png"
                     style="height: 20px;vertical-align: middle">
                查看小伙伴们的精彩游记
            </span>
            <span class="weui-cell__ft"></span>
        </a>
    </div>
</div>
<!--驴友推荐-->
<div class="block-title">
    <span class="title-content"> 驴友推荐 <span class="my-status-3">Hot</span></span>
</div>
<c:if test="${mediaList == []}">
    <img src="${ctx}/images/empty-pic.png" alt="哎呀" class="empty" style="opacity: 0.6">
    <div style="width: 100%;text-align: center;color: #999;font-size: 14px">更多推荐活动即将发布，敬请期待~ </div>
</c:if>
<c:forEach var="media" items="${mediaList}">
    <div class="hot-content">
        <div class="activity-item">
            <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${sessionScope.currentCity.id}">
                <div class="weui-flex my-pic">
                    <div class="weui-flex__item">
                        <div class="my-mask">
                            <div class="activity-title">
                                <b class="main-title">${media.product.name}</b>
                            </div>
                        </div>
                        <img src="/photo/product/${media.product.picUrl}"  class="test">
                    </div>
                </div>
            </a>
        </div>
    </div>
</c:forEach>
<!--底部导航栏-->
<div class="weui-tabbar">
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}" class="weui-tabbar__item">
        <!--<span class="weui-badge" style="position: absolute;top: -.4em;right: 1.5em;">8</span>-->
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-home.png" alt="">
        </div>
        <p class="weui-tabbar__label">首页</p>
    </a>
    <a href="#" class="weui-tabbar__item weui-bar__item--on">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-society_on.png" alt="">
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
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
    })
</script>
</body>
</html>