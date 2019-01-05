<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>领队中心</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css?v=">
    <style>
        body, html {
            height: 100%
        }

        /*.weui-tab{height: auto}*/
        .weui-tab__bd {
            font-size: 14px;
            padding-bottom: 50px;
        }

        /*领队信息*/
        .my-info {
            font-size: 14px
        }
        .leader-name{margin: 5px 0}

        .head-img {
            text-align: center;
            color: #fff;
            margin-bottom: -100%;
            margin-top: 5%
        }

        .head-img img {
            width: 17%;
            border-radius: 50%;
        }
        .head-img .user-score{
            background: rgba(0, 0, 0, 0.5);
            padding: 1px 10px;
            border-radius: 20px;
            font-size: 12px;
        }

        .weui-navbar__item.weui-bar__item--on{border-bottom: none}
        .weui-navbar__item.weui-bar__item--on span{
            color: #fff;
            background: #679aff;
            border-radius: 20px;
            padding: 5px 10px;
        }
        /*领队活动*/
        .my-item {
            font-size: 14px;
            margin-bottom: 10px;
            padding: 10px 10px 5px 10px;
            background-color: #ffffff
        }

        .my-detail {
            color: #999;
        }

        .my-pic img {
            width: 100%
        }

        .my-status-1 {
            float: right
        }
        .empty-tip {
            margin-top: 5%;
            text-align: center;
            color: #aaa;
        }
        .empty-tip img {
            width: 50%;
            max-width: 300px;
            opacity: .5;
        }

        /*游记*/
        /*.weui-media-box {*/
        /*padding: 10px*/
        /*}*/
        /*.weui-media-box__title {*/
        /*font-size: 14px*/
        /*}*/
        /*.weui-media-box_appmsg .weui-media-box__hd, .weui-media-box__thumb {*/
        /*width: 120px;*/
        /*height: 80px*/
        /*}*/
        /*.my-name {*/
        /*color: #333;*/
        /*line-height: 47px*/
        /*}*/
        /*.weui-media-box__desc {*/
        /*font-size: 12px*/
        /*}*/
        /*.weui-media-box__desc img {*/
        /*width: 32px;*/
        /*height: 32px;*/
        /*border-radius: 50%;*/
        /*vertical-align: middle*/
        /*}*/
        /*.weui-media-box__desc span {*/
        /*float: right*/
        /*}*/

        /*相册*/
        #tab3 {
            padding: 5px;
        }

        #tab3 .weui-flex {
            float: left;
            width: 50%
        }

        #tab3 .weui-flex__item {
            padding: 0 10px
        }

        #tab3 .weui-flex img {
            width: 100%;
            box-shadow: 2px 2px 5px #666;
            margin-bottom: 10px;
        }

        .photo-date {
            color: #999;
            margin: 5px 0 10px 0
        }

        /*个人简历*/
        input, textarea {
            color: #999 !important;
        }

        .weui-cells {
            margin:10px 15px;
            font-size: 14px;
            border-radius: 5px;
        }

        .my-edit-btn, .my-save-btn {
            margin: 20px
        }

        /*底部导航*/
        .weui-tabbar {
            position: fixed;
            bottom: 0
        }
    </style>
</head>
<body>
<!--领队信息-->
<div class="my-info">
    <div class="weui-flex">
        <div class="weui-flex__item">
            <div class="head-img">
                <img src="${leader.headImgUrl}" alt=""><br>
                <div class="leader-name">${leader.nickName}</div>
                <span class="user-score">经验：${sessionScope.userInfo.experValue} 分</span>
            </div>
        </div>
    </div>
    <div class="weui-flex">
        <div class="weui-flex__item" style="z-index: -1">
            <img src="${ctx}/images/index-hdlx.jpg" style="width: 100%;height: 100%">
        </div>
    </div>
</div>
<!--导航+内容-->
<div class="weui-tab" style="margin-top: 0">
    <div class="weui-navbar">
        <a class="weui-navbar__item weui-bar__item--on" href="#tab1"><span>领队活动</span></a>
        <%--   <a class="weui-navbar__item" href="#tab2">游记</a>--%>
        <a class="weui-navbar__item" href="#tab3"><span>相册</span></a>
        <a class="weui-navbar__item" href="#tab4"><span>个人简历</span></a>
    </div>
    <div class="weui-tab__bd">
        <!--领队活动-->
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
            <%--无内容显示--%>
            <c:if test="${activities==[]}">
                <div class='empty-tip'>
                    <img src='${ctx}/images/empty-pic.png' alt='哎呀~'>
                    <br>暂未参与过任何活动
                </div>
            </c:if>
            <c:forEach items="${activities}" var="act">
                <a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${act.id}&productId=${act.product.id}&cityId=${cityId}">
                    <div class="my-item">
                        <div class="weui-flex my-pic">
                            <div class="weui-flex__item">
                                <img src="/photo/product/${act.product.picUrl}">
                            </div>
                        </div>
                        <div class="weui-flex">
                            <div class="weui-flex__item">
                                    ${act.product.name}
                            </div>
                        </div>
                        <div>
                            <span class="my-detail">
                                <fmt:formatDate value="${act.departTime}"
                                                pattern="yyyy-MM-dd HH:mm" /> 出发
                            </span>
                            <span class="my-status-1">${act.state}</span>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <!--游记-->
        <%--<div id="tab2" class="weui-tab__bd-item">
            <div class="weui-panel weui-panel_access">
                <div class="weui-panel__bd">
                    <a href="#" class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" src="${ctx}/images/tmp-04.jpg">
                        </div>
                        <div class="weui-media-box__bd">
                            <h4 class="weui-media-box__title">海外温泉一日游</h4>
                            <p class="weui-media-box__desc my-name">
                                <img src="${ctx}/images/head-img.jpg">
                                领队用户名
                            </p>
                            <p class="weui-media-box__desc">
                                2017-07-12 10:00
                                <span>浏览500+</span>
                            </p>
                        </div>
                    </a>
                    <a href="#" class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" src="${ctx}/images/tmp-04.jpg">
                        </div>
                        <div class="weui-media-box__bd">
                            <h4 class="weui-media-box__title">海外温泉一日游</h4>
                            <p class="weui-media-box__desc my-name">
                                <img src="${ctx}/images/head-img.jpg">
                                领队用户名
                            </p>
                            <p class="weui-media-box__desc">
                                2017-07-12 10:00
                                <span>浏览500+</span>
                            </p>
                        </div>
                    </a>
                    <a href="#" class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" src="${ctx}/images/tmp-04.jpg">
                        </div>
                        <div class="weui-media-box__bd">
                            <h4 class="weui-media-box__title">海外温泉一日游</h4>
                            <p class="weui-media-box__desc my-name">
                                <img src="${ctx}/images/head-img.jpg">
                                领队用户名
                            </p>
                            <p class="weui-media-box__desc">
                                2017-07-12 10:00
                                <span>浏览500+</span>
                            </p>
                        </div>
                    </a>
                    <a href="#" class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" src="${ctx}/images/tmp-04.jpg">
                        </div>
                        <div class="weui-media-box__bd">
                            <h4 class="weui-media-box__title">海外温泉一日游</h4>
                            <p class="weui-media-box__desc my-name">
                                <img src="${ctx}/images/head-img.jpg">
                                领队用户名
                            </p>
                            <p class="weui-media-box__desc">
                                2017-07-12 10:00
                                <span>浏览500+</span>
                            </p>
                        </div>
                    </a>
                    <a href="#" class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" src="${ctx}/images/tmp-04.jpg">
                        </div>
                        <div class="weui-media-box__bd">
                            <h4 class="weui-media-box__title">海外温泉一日游</h4>
                            <p class="weui-media-box__desc my-name">
                                <img src="${ctx}/images/head-img.jpg">
                                领队用户名
                            </p>
                            <p class="weui-media-box__desc">
                                2017-07-12 10:00
                                <span>浏览500+</span>
                            </p>
                        </div>
                    </a>
                </div>
                <div class="weui-panel__ft">
                    <a href="../society/society-journeyList.html" class="weui-cell weui-cell_access weui-cell_link">
                        <div class="weui-cell__bd">查看更多好玩游记</div>
                        <span class="weui-cell__ft"></span>
                    </a>
                </div>
            </div>
        </div>--%>
        <!--相册-->
        <div id="tab3" class="weui-tab__bd-item">
            <%--无内容显示--%>
            <c:if test="${albumList==[]}">
                <div class='empty-tip'>
                    <img src='${ctx}/images/empty-pic.png' alt='哎呀~'>
                    <br>暂未创建新相册
                </div>
            </c:if>
            <c:forEach var="albumVo" items="${albumList}">
                <div class="weui-flex">
                    <div class="weui-flex__item">
                        <a href="${ctx}/wechat/mine/showMinePhoto?album.id=${albumVo.album.id}">
                            <img src="/photo/user/${albumVo.latestPhoto.picUrl}" alt="">
                            <p>${albumVo.album.name}<span class="my-status-1">${albumVo.photoCount}张</span></p>
                            <p class="photo-date"><fmt:formatDate value="${albumVo.album.createTime}"
                                                                  pattern="yyyy-MM-dd"/></p>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <!--个人简历-->
        <div id="tab4" class="weui-tab__bd-item">
            <div class="weui-cells weui-cells_form">
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">领队编号</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text" placeholder="" value="${leader.workNo}" readonly>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">性别</label></div>
                    <div class="weui-cell__bd">
                        <c:if test="${leader.sex}=='1'">
                            <input class="weui-input" type="text" placeholder=""
                                   value="男♂" readonly></c:if>
                        <c:if test="${leader.sex}=='2'">
                            <input class="weui-input" type="text" placeholder=""
                                   value="女♀" readonly></c:if>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">带队次数</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text" placeholder="" value="${leader.leaderNum}" readonly>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">评分</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text" placeholder="" value="${leader.score}" readonly>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">兴趣爱好</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text" placeholder="" value="${leader.hobby}" readonly>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">个人经历</label></div>
                    <div class="weui-cell__bd">
                        <textarea class="weui-textarea" placeholder="" rows="3" readonly>${leader.experience}</textarea>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">标签</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text" placeholder="" value="${leader.tag}" readonly>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">座右铭</label></div>
                    <div class="weui-cell__bd">
                        <textarea class="weui-textarea" placeholder="" rows="2" readonly>${leader.motto}</textarea>
                    </div>
                </div>
            </div>

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
        var $editBtn = $(".my-edit-btn"),
            $saveBtn = $(".my-save-btn"),
            $it = $("input,textarea");
        $editBtn.click(function () {
            $(this).hide();
            $saveBtn.show();
            $it.attr("readonly", false);
        });
        $saveBtn.click(function () {
            $(this).hide();
            $editBtn.show();
            $it.attr("readonly", true);
        });
        //相册
        var $tab3 = $("#tab3"),
            $weuiTab = $(".weui-tab__bd-item"),
            _h = ($weuiTab.width() - 10) / 2 - 20;
        $tab3.find(".weui-flex img").each(function () {
            $(this).css("height", _h);
            if($(this).attr("src") === "/photo/user/"){
                $(this).attr("src","${ctx}/images/album-default.png");
            }
        });
        $(window).resize(function () {
            _h = ($weuiTab.width() - 10) / 2 - 20;
            $tab3.find(".weui-flex img").each(function () {
                $(this).css("height", _h);
            })
        });
        //调用滚动函数
        myScroll("#tab1");
//        myScroll("#tab2");
        myScroll("#tab3");
        myScroll("#tab4");
    });
    //滑动带队活动、相册和个人简历时内容置顶
    function myScroll(obj) {
        var count = 0;
        $(obj).scroll(function () {
            count++;
            if($(window).scrollTop()+50 < $(this).offset().top && count == 1){
//                console.log($(window).scrollTop() + " "+$(this).offset().top);
                $("html,body").animate({scrollTop: $(this).offset().top}, 300);
            }else{
                count = 0
            }
        });
    }
</script>
</body>
</html>