<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>评论详情</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body {
            font-size: 3vw;
            padding-top: 50px;
            padding-bottom: 60px;
        }
        .weui-cell_link{
            color: #679aff;
            font-size: 3vw;
            padding:4vw;
        }
        .fl-right{float: right}
        .my-detail{color: #999}
        .weui-panel__hd{background: #fff}
        .user {
            position: relative;
            padding: 20px 0;
            background: #fff;
        }
        .user-info {
            position: absolute;
            width: 25%;
            text-align: center;
        }
        .user-img {
            border-radius: 50%;
            width: 50px;
        }
        .user-name,.comment-content {
            position: relative;
            margin-left: 25%;
            padding-right:10px;
            font-size: 14px;
        }
        .user-name {
            line-height: 30px;
        }
        .user-score {
            height: 12px;
            margin-top: 7px;
        }
        .comment-detail {
            float: right;
            line-height: 25px;
            color: #999;
            font-size: 12px;
        }
        .weui-tabbar{position: fixed;border-bottom: 0}
    </style>
</head>
<body>
<div class="page-title">
    <a href="${ctx}/wechat/mine/showMinePage" class="return"></a>
    评价详情
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}"><img src="${ctx}/images/topbar-home.png" class="go-home"></a>
</div>
<div class="weui-panel__hd">
    我的评论<span class="comment-detail"><fmt:formatDate value="${productComment.createTime}"
                                                     pattern="yyyy-MM-dd HH:mm" /></span>
</div>
<div class="user">
    <div class="user-info">
        <a href="#">
            <img src="${orders.user.headImgUrl}" class="user-img" alt="">
        </a>
    </div>
    <div class="user-name"><b>${orders.user.nickName}</b></div>
    <div class="comment-content">${productComment.commentContent}<br>
        <c:forEach var="i" begin="1" end="${productComment.grade}">
            <img src="${ctx}/images/star-on.png" class="user-score">
        </c:forEach>
                    <br>
    </div>
</div>
<!--导航推荐-->
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__ft">
        <a href="${ctx}/wechat/sort/ShowSortindex?cityId=${sessionScope.currentCity.id}" class="weui-cell weui-cell_access weui-cell_link">
            <div class="weui-cell__bd">
                <span>
                    海浪山风 <b>·</b> 更多分类
                </span>
                <span class="fl-right">更多惊喜</span>
            </div>
            <span class="weui-cell__ft"></span>
        </a>
    </div>
</div>
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__ft">
        <a href="${ctx}/wechat/calender/show?cityId=${sessionScope.currentCity.id}" class="weui-cell weui-cell_access weui-cell_link">
            <div class="weui-cell__bd">
                <span>海浪山风 <b>·</b> 活动日历</span>
                <span class="fl-right">查看更多</span>
            </div>
            <span class="weui-cell__ft"></span>
        </a>
    </div>
</div>
<!--底部导航栏-->
<div class="weui-tabbar">
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}" class="weui-tabbar__item">
        <!--<span class="weui-badge" style="position: absolute;top: -.4em;right: 1.5em;">8</span>-->
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
<script src="${ctx}/js/swiper.min.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        FastClick.attach(document.body);
        $(".swiper-container").swiper({
            slidesPerView: 2
        });
    })
</script>
</body>
</html>