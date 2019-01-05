<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>活动参与者</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        .page-title {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 999;
            background: #679aff;
            color: #fff;
            font-size: 16px;
            padding: 10px 0;
            text-align: center;
        }
        .return {
            position: absolute;
            left: 10px;
            width: 20px;
            height: 20px;
            background: url("${ctx}/images/return.png");
            background-size: cover;
        }
        .go-home{
            position: absolute;
            right: 10px;
            width: 22px;
            height: 22px;
        }
        a {color: #fff}
        .weui-grid{width: 20%;padding: 10px;height:93px;overflow:hidden}
        .weui-grid__icon{width: 50px;height: 50px;border-radius: 50%;overflow: hidden}
        .leader-name{color: red!important;}
    </style>
</head>
<body style="height: auto">
<div class="page-title">
    <a href="javascript:history.back()" class="return"></a>
    已报名的人
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}"><img src="${ctx}/images/topbar-home.png" class="go-home"></a>
</div>
<div class="weui-panel weui-panel_access" style="margin-top: 50px">
    <div class="weui-panel__hd">活动领队</div>
    <div class="weui-grids">
        <c:forEach items="${leaderList}" var="leader">
            <a href="${ctx}/wechat/user/showUserIndex?userId=${leader.id}" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="${leader.headImgUrl}" alt="">
                </div>
                <p class="weui-grid__label leader-name">${leader.nickName}</p>
            </a>
        </c:forEach>
    </div>
</div>
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__hd">已报名的小伙伴</div>
    <div class="weui-grids">
        <c:forEach items="${userList}" var="user">
            <a href="${ctx}/wechat/user/showUserIndex?userId=${user.id}" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="${user.headImgUrl}" alt="">
                </div>
                <p class="weui-grid__label">${user.nickName}</p>
            </a>
        </c:forEach>
    </div>
</div>
<c:if test="${userList==[]}">
    <div style="text-align: center;margin-top: 20px">
        <img src="${ctx}/images/enroll-pic.png" alt="" style="opacity: .5;width: 40%">
        <div style="color: #bbb;font-size: 14px">
            名额有限，快来
            <a href="javascript:history.back()" style="color: #679aff">报名</a>
            一起浪！
        </div>
    </div>
</c:if>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/fastclick.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        FastClick.attach(document.body);
    });
</script>
</body>
</html>