<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>更多分类</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <style>
        body{
            background: #eee;
            padding-bottom: 60px;
            font-size: 14px;
            max-width: 500px;
            margin: 0 auto;
        }
        .weui-tabbar__icon {width: 22px;height: 22px}
        .weui-tabbar__label{font-size: 12px}
        .weui-flex {background: #ffffff;padding:8px 0}
        .weui-flex p {font-size: 12px;}
        .weui-grid {padding: 8px;width: 25%}
        .my-flex .weui-grid{width: 20%}
        .weui-grids:before, .weui-grids:after,.weui-grid:before, .weui-grid:after {border: none}
        .my-title{text-align: center;line-height: 40px;background: #fafafa}
        .my-title{margin-top: 10px}
        .my-flex .weui-grid__icon{width: 36px;height: 36px}
        .my-flex p{color: #999999}
        /*.province .weui-grid__icon{width: 50px;height: 50px}*/
        /*.province .js_grid{padding-top: 0}*/
        .wrap .weui-grid__label{margin-top: 2px}
        .wrap .weui-grid{padding: 6px}
        .weui-tabbar{position: fixed;bottom: 0;max-width: 500px}
    </style>
</head>
<body>
<!--项目分类-->
<div class="wrap">
    <div class="my-title">
        <div class="weui-flex__item">
            <b>> 项目分类 <</b>
        </div>
    </div>
    <div class="weui-flex">
        <div class="weui-flex__item weui-grids">
            <c:forEach items="${sortList}" var="sort" varStatus="status">
                <a href="${ctx}/wechat/sort/ShowProductBySort?classId=${sort.id}&cityId=${cityId}#tab${status.index + 1}" class="weui-grid js_grid">
                    <div class="weui-grid__icon">
                        <img src="/photo/sort/${sort.picUrl}" alt="">
                    </div>
                    <p class="weui-grid__label">${sort.name}</p>
                </a>
            </c:forEach>
        </div>
    </div>
</div>
<!--活动天数-->
<div class="my-title">
    <div class="weui-flex__item">
        <b>> 活动天数 <</b>
    </div>
</div>
<div class="weui-flex my-flex">
    <div class="weui-flex__item weui-grids">
        <c:forEach var="i" begin="1" end="4">
            <a href="${ctx}/wechat/sort/ShowProductByDay?days=${i}&cityId=${cityId}#tab${i}" class="weui-grid js_grid">
                    <div class="weui-grid__icon">
                    <img src="${ctx}/images/day-0${i}.png" alt="">
                </div>
                <p class="weui-grid__label">${i} 天</p>
            </a>
        </c:forEach>
        <a href="${ctx}/wechat/sort/ShowProductByDay?days=5&cityId=${cityId}#tab5" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/day-05.png" style="width: auto">
            </div>
            <p class="weui-grid__label">5天以上</p>
        </a>
    </div>
</div>
<!--难度等级-->
<div class="my-title">
    <div class="weui-flex__item">
        <b>> 难度等级 <</b>
    </div>
</div>
<div class="weui-flex my-flex">
    <div class="weui-flex__item weui-grids">
        <c:forEach var="i" begin="1" end="5">
            <a href="${ctx}/wechat/sort/ShowProductByDif?degreeDifficultycity=${i}&cityId=${cityId}#tab${i}" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="${ctx}/images/level-0${i}.png" alt="">
                </div>
                <p class="weui-grid__label">
                    ${i} 星
                </p>
            </a>
        </c:forEach>
    </div>
</div>
<!--目的地分类-->
<div class="wrap">
    <div class="my-title">
        <div class="weui-flex__item">
            <b>> 目的地分类 <</b>
        </div>
    </div>
    <div class="weui-flex">
        <div class="weui-flex__item weui-grids">
            <c:forEach items="${destinationList}" var="destination" varStatus="status">
                <a href="${ctx}/wechat/sort/ShowProductByDist?destinationId=${destination.id}&cityId=${cityId}#tab${status.index + 1}" class="weui-grid js_grid">
                    <div class="weui-grid__icon">
                        <img src="/photo/dist/${destination.picUrl}" alt="">
                    </div>
                    <p class="weui-grid__label">${destination.name}</p>
                </a>
            </c:forEach>
        </div>
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
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
    })
</script>
</body>
</html>