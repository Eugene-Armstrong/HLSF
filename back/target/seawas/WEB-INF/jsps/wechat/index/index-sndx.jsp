<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${fns:getDictLabel('mediaModule', media.module, '')}</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        .weui-tab__bd{padding-bottom: 45px}
        .empty-tip {
            margin-top: 20%;
            text-align: center;
            color: #aaa;
        }
        .empty-tip img {
            width: 60%;
            max-width: 300px;
            opacity: .5;
        }
        table{
            width: 100%;
            font-size: 12px;
            line-height: 30px;
        }
    </style>
</head>
<body>
<div class="weui-tab__bd">
    <div class="weui-tab__bd-item weui-tab__bd-item--active">
        <%--无内容显示--%>
        <c:if test="${productAndActivityList==[]}">
            <div class='empty-tip'>
                <img src='${ctx}/images/empty-pic.png' alt='哎呀~'>
                <br>
            </div>
        </c:if>
        <c:forEach var="productAndActivity" items="${productAndActivityList}">
            <div class="my-item">
                <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${productAndActivity.product.id}&cityId=${sessionScope.currentCity.id}">
                    <div class="weui-flex my-pic">
                        <div class="weui-flex__item">
                            <img src="/photo/product/${productAndActivity.product.picUrl}">
                        </div>
                    </div>
                    <div class="my-title">
                        ${productAndActivity.product.name}
                    </div>
                </a>
                <c:forEach var="activity" items="${productAndActivity.activities}" varStatus="status">
                    <c:choose>
                        <c:when test="${status.index <= 2}">
                            <a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${activity.id}&productId=${productAndActivity.product.id}&cityId=${sessionScope.currentCity.id}">
                                <table>
                                    <tr>
                                        <td width="25%">
                                            <fmt:formatDate value="${activity.departTime}" type="date"/>
                                        </td>
                                        <td width="15%">(${activity.days}天)</td>
                                        <td width="20%">￥${activity.price * 0.01}</td>
                                        <td width="20%" style="text-align: center">
                                            好评：<fmt:formatNumber value="${productAndActivity.product.productAvgVote}" pattern="#.0#"/>
                                        </td>
                                        <td width="20%" style="text-align: right">
                                            <c:if test="${activity.state == '未成行'}">
                                                <span class="my-status-1">未成行</span>
                                            </c:if>
                                            <c:if test="${activity.state == '已成行'}">
                                                <span class="my-status-2">已成行</span>
                                            </c:if>
                                            <c:if test="${activity.state == '活动中'}">
                                                <span class="my-status-3">活动中</span>
                                            </c:if>
                                            <c:if test="${activity.state == '已满人'}">
                                                <span class="my-status-4">已满人</span>
                                            </c:if>
                                            <c:if test="${activity.state == '已结束'}">
                                                <span class="my-status-5">已结束</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </table>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${status.index == 3}">
                                <div class="my-hidden">
                            </c:if>
                                <a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${activity.id}&productId=${productAndActivity.product.id}&cityId=${sessionScope.currentCity.id}">
                                    <table>
                                        <tr>
                                            <td width="25%">
                                                <fmt:formatDate value="${activity.departTime}" type="date"/>
                                            </td>
                                            <td width="15%">(${activity.days}天)</td>
                                            <td width="20%">￥${activity.price * 0.01}</td>
                                            <td width="20%" style="text-align: center">
                                                好评：<fmt:formatNumber value="${productAndActivity.product.productAvgVote}" pattern="#.0#"/>
                                            </td>
                                            <td width="20%" style="text-align: right">
                                                <span class="my-status-2">${activity.state}</span>
                                            </td>
                                        </tr>
                                    </table>
                                </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${fn:length(productAndActivity.activities) > 3}">
                                </div>
                    <div class="my-spread-down">(｡･ω･｡) 还有${fn:length(productAndActivity.activities) - 3}期活动哟~点击展开</div>
                    <div class="my-spread-up">点击收起 ↑</div>
                </c:if>
            </div>
        </c:forEach>
        <div class="weui-loadmore">
        <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}">没有更多活动了，去首页看看吧</a>
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
<script src="${ctx}/js/common.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
    })
</script>
</body>
</html>