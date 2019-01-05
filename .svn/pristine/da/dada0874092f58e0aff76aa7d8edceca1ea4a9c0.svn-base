<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css?v=">
    <style>
        .swiper-pagination-bullet-active,.weui-flex,.swiper-container{background: #ffffff}
        .weui-tab__bd .swiper-pagination-bullets{text-align: center;margin-bottom:5px}
        .weui-tab__bd .swiper-pagination-bullet-active{background: #679aff}
        .swiper-pagination-bullet{width: 6px;height: 6px}
        #adSwiper img{min-height: 160px}
        .weui-tab{height: auto}
        .weui-navbar+.weui-tab__bd{padding-top: 44px}
        .weui-flex,.js_grid{padding: 8px}
        .weui-flex__item img{width: 100%;border-radius: 3px}
        .weui-grid__icon{width: 40px;height: 40px}
        .weui-flex a {width: 25%;}
        #larger{
            position: absolute;
            padding: 10px 20px 20px 10px;
            cursor: pointer;
            z-index: 999;
            -webkit-tap-highlight-color:rgba(0,0,0,0);
        }
        .city{
            background: rgba(0,0,0,.6);
            display: inline-block;
            padding: 5px 10px;
            color: #fff;
            font-size: 12px;
            line-height: 16px;
            border-radius: 20px;
        }
        .city img{width: 12px;height: 12px;}
        #city{
            background: rgba(0,0,0,0);
            border: none;
            color: #ffffff;
            display: inline-block;
            cursor: pointer;
        }
        .toolbar .picker-button {color: #999}
        .my-pagination{z-index: 999;position: absolute;bottom:10px;text-align: center}
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
        .main-title{font-size: 20px;letter-spacing:3px;font-family: "微软雅黑 Light"}
        .weui-navbar__item {padding: 10px 0}
        .weui-tab .weui-flex__item img{min-height: 100px}
        .weui-actionsheet__action {
            margin-top: 6px;
            color: #fff;
            background-color: #ef6364;
        }
    </style>
</head>
<body style="padding-bottom: 60px">
<!--选择所在城市-->
<div id="larger">
    <div class="city">
        <img src="${ctx}/images/ic-city.png" alt="">
        <div id="city">${currentCity.name}</div>
    </div>
</div>
<!--part1-广告焦点图-->
<div class="swiper-container" id="adSwiper">
    <div class="swiper-wrapper">
        <c:forEach var="media" items="${mediaList}">
            <c:if test="${media.module == '1' }">
                <c:if test="${media.location == '1'}">
                    <div class="swiper-slide">
                        <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${sessionScope.currentCity.id}">
                            <img src="/photo/product/${media.product.picUrl}" alt="">
                        </a>
                    </div>
                </c:if>
            </c:if>
        </c:forEach>
    </div>
    <div class="my-pagination"></div>
</div>
<!--part2-内容导航-->
<div class="weui-flex" style="margin-top: -4px">
    <div class="weui-flex__item weui-grids">
        <a href="${ctx}/wechat/index/showSecondPage?city.id=${currentCity.id}&location=1&module=12" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/ic-sndx.png" alt="">
            </div>
            <p class="weui-grid__label">
                省内短线
            </p>
        </a>
        <a href="${ctx}/wechat/index/showSecondPage?city.id=${currentCity.id}&location=1&module=13" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/ic-gncx.png" alt="">
            </div>
            <p class="weui-grid__label">
                国内长线
            </p>
        </a>
        <a href="${ctx}/wechat/index/showSecondPage?city.id=${currentCity.id}&location=1&module=14" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/ic-gwcx.png" alt="">
            </div>
            <p class="weui-grid__label">
                境外长线
            </p>
        </a>
        <a href="${ctx}/wechat/index/showSecondPage?city.id=${currentCity.id}&location=1&module=15" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/ic-hdlx.png" alt="">
            </div>
            <p class="weui-grid__label">
                团队出行
            </p>
        </a>
        <a href="${ctx}/wechat/company/show" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/ic-qydz.png" alt="">
            </div>
            <p class="weui-grid__label">
                团队定制
            </p>
        </a>
        <a href="${ctx}/wechat/leader/show" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/ic-ldzl.png" alt="">
            </div>
            <p class="weui-grid__label">
                领队资料
            </p>
        </a>
        <a href="${ctx}/wechat/calender/show?cityId=${currentCity.id}" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/ic-zxhd.png" alt="">
            </div>
            <p class="weui-grid__label">
                活动日历
            </p>
        </a>
        <a href="${ctx}/wechat/sort/ShowSortindex?cityId=${currentCity.id}" class="weui-grid js_grid">
            <div class="weui-grid__icon">
                <img src="${ctx}/images/ic-gdfl.png" alt="">
            </div>
            <p class="weui-grid__label">
                更多分类
            </p>
        </a>
    </div>
</div>
<!--part3-活动焦点图-->
<div class="weui-tab">
    <div class="weui-navbar">
        <a class="weui-navbar__item weui-bar__item--on" href="#tab1">本周活动</a>
        <a class="weui-navbar__item" href="#tab2">下周活动</a>
        <a class="weui-navbar__item" href="#tab3">近期假日</a>
        <a class="weui-navbar__item" href="#tab4">往期活动</a>
    </div>
    <div class="weui-tab__bd">
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach var="media" items="${mediaList}">
                        <c:if test="${media.location == '1'}">
                            <c:if test="${media.module == '2'}">
                                <div class="swiper-slide">
                                    <div class="weui-flex">
                                        <div class="weui-flex__item">
                                            <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${currentCity.id}">
                                                <img src="/photo/product/${media.product.picUrl}" alt="">
                                                <p>${media.product.name}</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="pagination-1"></div>
            </div>
        </div>
        <div id="tab2" class="weui-tab__bd-item">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach var="media" items="${mediaList}">
                        <c:if test="${media.location == '1'}">
                            <c:if test="${media.module == '3'}">
                                <div class="swiper-slide">
                                    <div class="weui-flex">
                                        <div class="weui-flex__item">
                                            <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${currentCity.id}">
                                                <img src="/photo/product/${media.product.picUrl}" alt="">
                                                <p>${media.product.name}</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="pagination-2"></div>
            </div>
        </div>
        <div id="tab3" class="weui-tab__bd-item">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach var="media" items="${mediaList}">
                        <c:if test="${media.location == '1'}">
                            <c:if test="${media.module == '4'}">
                                <div class="swiper-slide">
                                    <div class="weui-flex">
                                        <div class="weui-flex__item">
                                            <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${currentCity.id}">
                                                <img src="/photo/product/${media.product.picUrl}" alt="">
                                                <p>${media.product.name}</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="pagination-3"></div>
            </div>
        </div>
        <div id="tab4" class="weui-tab__bd-item">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach var="media" items="${mediaList}">
                        <c:if test="${media.location == '1'}">
                            <c:if test="${media.module == '5'}">
                                <div class="swiper-slide">
                                    <div class="weui-flex">
                                        <div class="weui-flex__item">
                                            <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${currentCity.id}">
                                                <img src="/photo/product/${media.product.picUrl}" alt="">
                                                <p>${media.product.name}</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="pagination-4"></div>
            </div>
        </div>
    </div>
</div>
<div class="weui-tab">
    <div class="weui-navbar">
        <a class="weui-navbar__item weui-bar__item--on" href="#tab5">限时优惠</a>
        <a class="weui-navbar__item" href="#tab6">热门线路</a>
        <a class="weui-navbar__item" href="#tab7">定制回顾</a>
        <%--<a class="weui-navbar__item" href="#tab8">--%><%--游记--%><%--</a>--%>
    </div>
    <div class="weui-tab__bd">
        <!-- 限时优惠 -->
        <div id="tab5" class="weui-tab__bd-item weui-tab__bd-item--active">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach var="media" items="${mediaList}">
                        <c:if test="${media.location == '1'}">
                            <c:if test="${media.module == '6'}">
                                <div class="swiper-slide">
                                    <div class="weui-flex">
                                        <div class="weui-flex__item">
                                            <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${currentCity.id}">
                                                <img src="/photo/product/${media.product.picUrl}" alt="">
                                                <p>${media.product.name}</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="pagination-5"></div>
            </div>
        </div>
        <!-- 热门路线 -->
        <div id="tab6" class="weui-tab__bd-item">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach var="media" items="${mediaList}">
                        <c:if test="${media.location == '1'}">
                            <c:if test="${media.module == '7'}">
                                <div class="swiper-slide">
                                    <div class="weui-flex">
                                        <div class="weui-flex__item">
                                            <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${currentCity.id}">
                                                <img src="/photo/product/${media.product.picUrl}" alt="">
                                                <p>${media.product.name}</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="pagination-6"></div>
            </div>
        </div>
        <!-- 定制回顾 -->
        <div id="tab7" class="weui-tab__bd-item">
            <div class="swiper-container">
                <div class="swiper-wrapper"></div>
                <div class="pagination-7"></div>
            </div>
        </div>
    </div>
</div>
<!--part4-活动推荐-->
<div class="block-title">
    <span class="title-content"> 热门推荐 <span class="my-status-3">Hot</span></span>
</div>
<div id="hot-content">
    <c:forEach var="media" items="${mediaList}">
        <c:if test="${media.location == '1'}">
            <c:if test="${media.module == '11'}">
                <div class="activity-item">
                    <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${media.product.id}&cityId=${currentCity.id}">
                        <div class="weui-flex my-pic">
                            <div class="weui-flex__item">
                                <div class="my-mask">
                                    <div class="activity-title">
                                        <b class="main-title">${media.product.name}</b>
                                    </div>
                                </div>
                                <img src="/photo/product/${media.product.picUrl}">
                            </div>
                        </div>
                    </a>
                </div>
            </c:if>
        </c:if>
    </c:forEach>
</div>
<!--底部导航栏-->
<div class="weui-tabbar">
    <a href="#" class="weui-tabbar__item weui-bar__item--on">
        <!--<span class="weui-badge" style="position: absolute;top: -.4em;right: 1.5em;">8</span>-->
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-home_on.png" alt="">
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
<script src="${ctx}/js/swiper.min.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        var $adSwiper = $("#adSwiper"),
            $adWrapper = $adSwiper.find(".swiper-wrapper"),
            $tabWrapper = $(".weui-tab .swiper-wrapper"),
            $tab1 = $("#tab1"),
            $tab2 = $("#tab2"),
            $tab3 = $("#tab3"),
            $tab4 = $("#tab4"),
            $tab5 = $("#tab5"),
            $tab6 = $("#tab6"),
            $tab7 = $("#tab7"),
            $hot = $("#hot-content");

        var adDefaultContent = '<div class="swiper-slide">' +
            '<img src="${ctx}/images/ad-01.jpg" alt="更多产品即将上线，敬请期待"></div>' +
            '<div class="swiper-slide">' +
            '<img src="${ctx}/images/ad-02.jpg" alt="更多产品即将上线，敬请期待"></div>',
            tabDefaultContent =
                '<div class="swiper-slide">' +
                '<div class="weui-flex">' +
                '<div class="weui-flex__item">' +
                '<img src="${ctx}/images/empty-product.png" alt=""></div></div></div>' +
                '<div class="swiper-slide">' +
                '<div class="weui-flex">' +
                '<div class="weui-flex__item">' +
                '<img src="${ctx}/images/empty-product.png" alt=""></div></div></div>',
            hotDefaultContent =
                '<div class="activity-item">' +
                '<div class="weui-flex my-pic">' +
                '<div class="weui-flex__item">' +
                '<div class="my-mask">' +
                '<div class="activity-title">' +
                '<b class="main-title">更多产品即将上线</b></div></div>' +
                '<img src="${ctx}/images/index-sndx.jpg"></div></div></div>';

        //海报轮播产品为空时的默认显示图
        if($adWrapper.children().length === 0) {
            $adWrapper.append(adDefaultContent);
        }
        //其他产品为空时的默认显示图
        $tabWrapper.each(function () {
            if($(this).children().length===0){
                $(this).append(tabDefaultContent);
            }
        });
        //热门推荐为空时默认显示图
        if($hot.children().length ===0){
            $hot.append(hotDefaultContent);
        }
        //焦点轮播图swiper实例化
        $adSwiper.swiper({ //广告海报轮播图
            loop: true,
            pagination : '.my-pagination',
            autoplay: 5000
        });
        $tab1.find(".swiper-container").swiper({
            slidesPerView: 2,//预览幅数
            loop: false,
            autoplay: 5000,
            pagination : ".pagination-1"
        });
        $tab2.find(".swiper-container").swiper({
            slidesPerView: 2,//预览幅数
            loop: false,
            autoplay: 5000,
            observer:true,
            observeParents:true,
            pagination : ".pagination-2"
        });
        $tab3.find(".swiper-container").swiper({
            slidesPerView: 2,//预览幅数
            loop: false,
            autoplay: 5000,
            observer:true,
            observeParents:true,
            pagination : ".pagination-3"
        });
        $tab4.find(".swiper-container").swiper({
            slidesPerView: 2,//预览幅数
            loop: false,
            autoplay: 5000,
            observer:true,
            observeParents:true,
            pagination : ".pagination-4"
        });
        $tab5.find(".swiper-container").swiper({
            slidesPerView: 2,//预览幅数
            loop: false,
            autoplay: 5000,
            observer:true,
            observeParents:true,
            pagination : ".pagination-5"
        });
        $tab6.find(".swiper-container").swiper({
            slidesPerView: 2,//预览幅数
            loop: false,
            autoplay: 5000,
            observer:true,
            observeParents:true,
            pagination : ".pagination-6"
        });
        $tab7.find(".swiper-container").swiper({
            slidesPerView: 2,//预览幅数
            loop: false,
            autoplay: 5000,
            observer:true,
            observeParents:true,
            pagination : ".pagination-7"
        });
        //获取城市列表
        var cityList = null;
        $.ajax({
            url: "${ctx}/wechat/index/getCityList",
            type: "POST",
            dataType: "json",
            success: function (data) {
                var itemsArray = [],idArray = [];
                if (data.code == 200) {
                    if (data.entity && data.entity.length > 0) {
                        cityList = eval(data.entity);
                        for (var i = 0; i < cityList.length; i++) {
                            itemsArray.push({"text":cityList[i].name});
                            idArray.push(cityList[i].id);
                        }
                    }
                } else {
                    alert("系统繁忙");
                }
                $(document).on("click","#larger",function () {
                    $.actions({
                        title: "请选择出发城市",
                        actions: itemsArray
                    });
                    $(".weui-actionsheet__cell").each(function (index) {
                        $(this).attr("id",idArray[index]);
                    });
                });
                $(document).on("click",".weui-actionsheet__cell",function () {
                    var thisID = $(this).attr("id");
                    if (thisID != "${currentCity.id}"&&thisID.length!=0) {
//                        alert(thisID);
                        window.location.href = "${ctx}/wechat/index/show?cityId=" + thisID;
                    }
                })
            },
            error: function () {
                alert("系统繁忙");
            }
        });
    })
</script>
</body>
</html>