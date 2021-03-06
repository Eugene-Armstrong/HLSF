<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的个人中心</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body,html{height: 100%;-webkit-overflow-scrolling: touch}
        .weui-tab__bd {
            font-size: 14px;
            padding-bottom: 50px;
        }
        a.weui-navbar__item{font-size: 13px;padding: 15px 0}
        .weui-navbar__item.weui-bar__item--on{border-bottom: none}
        .weui-navbar__item.weui-bar__item--on span{
            color: #fff;
            background: #679aff;
            border-radius: 20px;
            padding: 3px 5px;
        }
        .weui-dialog__btn{color: #679aff}
        /*设置*/
        .my-settings{
            position: absolute;
            top: 15px;
            right:15px;
            width: 18px;
            height: 18px
        }
        /*个人信息*/
        .my-info{font-size: 14px}
        .head-img {
            text-align: center;
            color: #fff;
            margin-bottom: -100%;
            margin-top: 7%
        }
        .head-img img {
            width: 17%;
            border-radius: 50%;
            min-height: 50px;
        }
        .head-img .user-name{font-size: 14px;margin: 5px}
        .head-img .user-score{
            background: rgba(0, 0, 0, 0.5);
            padding: 1px 10px;
            border-radius: 20px;
            font-size: 12px;
        }

        /*活动*/
        .my-item {
            font-size: 14px;
            margin-bottom: 10px;
            padding: 10px 10px 5px 10px;
            background-color: #ffffff
        }
        .my-detail{color: #999;}
        .my-pic img {width: 100%;min-height: 120px}
        .my-status-1,.my-status-2,.my-status-3, .my-status-4,.my-status-5{float: right}
        .comments, .refund, .set-qrcode,
        .set-status, .change-endStatus,
        .release,.delete-draft,.delete-journey,
        .not-pass,.checking
        {
            cursor: pointer;
            z-index: 998;
            position: absolute;
            background: #ffb72b;
            right: 10px;
            padding: 5px 10px;
            color: #fff;
        }
        .not-pass{background: #999}
        .checking{background: #679aff}
        .comments {background: #679aff;top: 0}
        .refund,.delete-journey{background: #e64340;right: 10px;}
        .delete-draft{background: #e64340;right: 90px}
        .set-qrcode{right: 90px}
        .bg{background: #679aff;color: #fff}
        .weui-popup__container{z-index: 999;}
        .weui-popup__modal{background: #fff;text-align: center}
        .consult-tip{width: 70%;margin: 0 auto;font-size: 14px}
        .collect{width: 30%;background: #e74866}
        .weui-btn{border-radius: 0;font-size: 16px;cursor: pointer}
        .weui-btn_plain-default{margin: 30px 20%}
        .weui-tab__bd-item{position: relative}
        .empty-tip {
            margin: 5% 0 10%;
            text-align: center;
            color: #aaa;
        }
        .empty-tip img {
            width: 50%;
            max-width: 300px;
            opacity: .5;
        }
        #tab4 .weui-flex__item{padding-bottom: 5px}
        /*游记*/
        .weui-media-box{padding: 10px}
        .weui-media-box__title{font-size: 14px}
        .weui-media-box_appmsg .weui-media-box__hd,.weui-media-box__thumb{width: 120px;height: 80px}
        .my-name{color: #333;line-height: 47px}
        .weui-media-box__desc{font-size: 10px}
        .weui-media-box__desc img{width: 32px;height: 32px;border-radius: 50%;vertical-align: middle}
        .weui-media-box__desc span{float: right}
        #journeyList{background: #fff}
        .my-draftTitle{margin: 12px 0}
        #more,#moreDraft{
            background: #fff;
            display: none;
            text-align: center;
            font-size: 14px;
            line-height: 40px;
            border-top: 1px solid #eee;
            color: #999;
            cursor:pointer;
            margin-bottom: 10px;
        }
        .draft-weui-loadmore {
            display: none;
            width: 65%;
            margin: 1.5em auto;
            line-height: 1.6em;
            font-size: 14px;
            text-align: center;
        }
        #end-tip,#dradtEndTip{display: none;margin-bottom: 10px}
        #released,#draftList{display: none}
        #draftList .weui-media-box__title{color: #999}
        .weui-panel__bd{background: #fff}
        /*相册*/
        #tab3{padding:5px;}
        #tab3 .weui-flex{float: left;width: 50%}
        #tab3 .weui-flex__item{padding:0 10px}
        #tab3 img{width: 100%;min-height:160px;box-shadow: 2px 2px 5px #666;margin-bottom: 10px;}
        .photo-date{color: #999;margin: 5px 0 10px 0}
        .weui-cells__title{margin: 20px 0 10px;color: #bbb}
        .weui-cell_link{background: #fff}
        .product-name{margin: 5px 0 10px 0;color: #333}
        .time-info {
            color: #999;
            margin-top: 5px;
        }
        .end-tip{display: none;margin-bottom: 10px}
        .weui-loadmore__tips{color: #999}
        /*底部导航*/
        .weui-tabbar{position: fixed;bottom: 0;z-index: 999}
    </style>
</head>
<body style="position: relative">
<!--个人信息-->
<%--<a href="#" ><span class="add-album"><b>+</b> 添加相册</span></a>--%>
<a href="${ctx}/wechat/mine/showMineSettings?id=${sessionScope.userInfo.id}">
    <img src="${ctx}/images/go-settings.png" class="my-settings">
</a>
<div class="my-info">
    <div class="weui-flex">
        <div class="weui-flex__item">
            <div class="head-img">
                <img src="${sessionScope.userInfo.headImgUrl}" alt="用户头像"><br>
                <div class="user-name">${sessionScope.userInfo.nickName}
                    <c:if test="${sessionScope.userInfo.sex == '1'}">♂</c:if>
                    <c:if test="${sessionScope.userInfo.sex == '2'}">♀</c:if>
                </div>
                <span class="user-score">
                    经验：${sessionScope.userInfo.experValue} 分
                    <c:if test="${sessionScope.userInfo.type == '2'}">
                        &nbsp;&nbsp;|&nbsp;&nbsp;评分：<fmt:formatNumber value="${sessionScope.userInfo.score}" pattern="#.0#"/>
                    </c:if>
                </span>
            </div>
        </div>
    </div>
    <div class="weui-flex">
        <div class="weui-flex__item" style="position: relative;z-index: -1">
            <img src="${ctx}/images/mine-bg.jpg" style="width: 100%;height: 100%">
        </div>
    </div>
</div>
<!--导航+内容-->
<div class="weui-tab" style="margin-top: 0">
    <div class="weui-navbar">
        <a class="weui-navbar__item weui-bar__item--on" href="#tab1"><span>参与活动</span></a>
        <a class="weui-navbar__item" href="#tab2"><span>游记</span></a>
        <a class="weui-navbar__item" href="#tab3"><span>相册</span></a>
        <a class="weui-navbar__item" href="#tab4"><span>收藏</span></a>
        <c:if test="${sessionScope.userInfo.type == '2'}">
            <a class="weui-navbar__item" href="#tab5"><span>带队活动</span></a>
        </c:if>
    </div>
    <div class="weui-tab__bd">
        <!--参与活动-->
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
            <div id="notEnd1"></div>
            <div id="end1"></div>
            <div class='weui-loadmore'><br>
                <i class='weui-loading'></i>
                <span class='weui-loadmore__tips'> 加载中</span>
            </div>
            <div class="weui-panel weui-panel_access end-tip">
                <div class="weui-cell weui-cell_access weui-cell_link" style="color: #586c94">
                    <span class="weui-cell__bd">亲，没有更多活动啦~</span>
                </div>
            </div>
            <%--活动为空时--%>
            <%--<c:if test="${orders==[]}">--%>
                <%--<div class='empty-tip'>--%>
                    <%--<img src='${ctx}/images/empty-pic.png' alt='哎呀~'>--%>
                    <%--<br>暂未参与过任何活动--%>
                <%--</div>--%>
            <%--</c:if>--%>

            <%--<c:forEach items="${orders}" var="ord">--%>
                <%--<c:if test="${ord.activity.state == '已结束'}">--%>
                    <%--<c:if test="${ord.isComment == '0'}">--%>
                        <%--<a href="${ctx}/wechat/comment/ShowCommentIndex?id=${ord.id}"><span class="comments">发表评论</span></a>--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${ord.isComment != '0'}">--%>
                        <%--<a href="${ctx}/wechat/comment/ShowCommentIndexDetail?orderId=${ord.id}&userId=${ord.user.id}&activityId=${ord.activity.id}">--%>
                            <%--<span class="comments">查看评论</span></a>--%>
                    <%--</c:if>--%>
                <%--</c:if>--%>
                <%--<c:if test="${ord.activity.state == '未成行' || ord.activity.state == '已成行' || ord.activity.state == '已满人'}">--%>
                    <%--<c:if test="${ord.state == '2'}">--%>
                        <%--<span class="refund" id="${ord.id}">活动退款</span>--%>
                    <%--</c:if>--%>
                <%--</c:if>--%>
                <%--<div class="my-item">--%>
                    <%--<a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${ord.activity.id}&productId=${ord.activity.product.id}&cityId=${cityMessage.id}">--%>
                        <%--<div class="weui-flex my-pic">--%>
                            <%--<div class="weui-flex__item">--%>
                                <%--<img src="/photo/product/${ord.activity.product.picUrl}">--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <%--<div class="weui-flex">--%>
                            <%--<div class="weui-flex__item">--%>
                                    <%--${ord.activity.product.name}--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <%--<div>--%>
                    <%--<span class="my-detail"><fmt:formatDate value="${ord.activity.departTime}"--%>
                                                            <%--pattern="yyyy-MM-dd HH:mm" /> 出发</span>--%>
                            <%--<span class="my-status-1">${ord.activity.state}</span>--%>
                        <%--</div>--%>
                    <%--</a>--%>
                <%--</div>--%>
            <%--</c:forEach>--%>
        </div>
        <!--游记-->
        <div id="tab2" class="weui-tab__bd-item">
            <%--新建游记--%>
            <div class="weui-panel__ft">
                <a href="${ctx}/wechat/journey/showAddJourney"
                   class="weui-cell weui-cell_access weui-cell_link">
                    <span class="weui-cell__bd" style="color: #333">
                        <img src="${ctx}/images/equip-plus.png"
                             style="height: 19px;vertical-align: middle">
                        快来新建属于你的精彩游记吧~
                    </span>
                    <span class="weui-cell__ft"></span>
                </a>
            </div>
            <%--草稿箱--%>
            <div class="weui-panel__ft" id="draft">
                <a href="javascript:" class="weui-cell weui-cell_access weui-cell_link">
                    <span class="weui-cell__bd" id="draftTitle" style="color: #333">查看我的游记草稿</span>
                    <span class="weui-cell__ft"></span>
                </a>
            </div>
             <div id="draftList" style="margin-top: 10px">
                 <%--<div class="weui-panel__bd">--%>
                     <%--<span class="release">发布游记</span>--%>
                     <%--<span class="delete-draft">删除草稿</span>--%>
                     <%--<a href="#" class="weui-media-box weui-media-box_appmsg">--%>
                         <%--<div class="weui-media-box__bd">--%>
                             <%--<h4 class="weui-media-box__title">点击查看或编辑</h4>--%>
                             <%--<p class="weui-media-box__desc my-name">--%>
                                 <%--标题：震惊！老父亲竟然和小姐姐做过这种事…--%>
                             <%--</p>--%>
                             <%--<p class="weui-media-box__desc">--%>
                                 <%--保存时间：2017-11-21 12:28 <span>我的草稿</span>--%>
                             <%--</p>--%>
                         <%--</div>--%>
                     <%--</a>--%>
                 <%--</div>--%>
             </div>
                <div class='draft-weui-loadmore'>
                    <i class='weui-loading'></i>
                    <span class='weui-loadmore__tips'> 草稿加载中</span>
                </div>
                <div id='moreDraft'>点击加载更多</div>

             <%--已发布游记--%>
            <div class="weui-cells__title" id="released">已发布游记</div>
            <div class="weui-panel__bd" id="journeyList"></div>
            <div class='weui-loadmore'>
                <i class='weui-loading'></i>
                <span class='weui-loadmore__tips'> 游记加载中</span>
            </div>
            <div id='more'>点击加载更多</div>
            <div class="weui-panel__ft" id="end-tip">
                <a class="weui-cell weui-cell_access weui-cell_link">
                    <div class="weui-cell__bd">没有更多游记了哦~</div>
                </a>
            </div>
        </div>
        <!--相册-->
        <div id="tab3" class="weui-tab__bd-item">
            <c:forEach var="albumVo" items="${albumList}">
                <div class="weui-flex">
                    <div class="weui-flex__item">
                        <a href="${ctx}/wechat/mine/showMinePhoto?album.id=${albumVo.album.id}">
                            <img src="/photo/user/${albumVo.latestPhoto.picUrl}" alt="">
                            <p>${albumVo.album.name}<span class="my-status-1">${albumVo.photoCount}张</span></p>
                            <p class="photo-date"><fmt:formatDate value="${albumVo.album.createTime}" pattern="yyyy-MM-dd"/></p>
                        </a>
                    </div>
                </div>
            </c:forEach>
            <div class="weui-flex add-album">
                <div class="weui-flex__item">
                    <a href="javascript:">
                        <img src="${ctx}/images/upload.png">
                        <p>【添加相册】</p>
                    </a>
                </div>
            </div>
        </div>
        <!--收藏-->
        <div id="tab4" class="weui-tab__bd-item">
            <%--无内容显示--%>
            <c:if test="${collects==[]}">
                <div class='empty-tip'>
                    <img src='${ctx}/images/empty-box.png' alt='哎呀~'>
                    <br>暂未收藏过任何活动
                </div>
            </c:if>
            <c:forEach items="${collects}" var="collect">
                <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${collect.id}&cityId=${cityMessage.id}">
                    <div class="my-item">
                        <div class="weui-flex my-pic">
                            <div class="weui-flex__item">
                                <img src="/photo/product/${collect.picUrl}">
                            </div>
                        </div>
                        <div class="weui-flex">
                            <div class="weui-flex__item">${collect.name}</div>
                        </div>
                            <%--<div>--%>
                            <%--<span class="my-detail">更新时间：<fmt:formatDate value="${collect.updateTime}" pattern="yyyy-MM-dd HH:mm"/></span>--%>
                            <%--&lt;%&ndash;<span class="my-status-1"></span>&ndash;%&gt;--%>
                            <%--</div>--%>
                    </div>
                </a>
            </c:forEach>
        </div>
        <!--带队活动-->
        <c:if test="${sessionScope.userInfo.type == '2'}">
            <div id="tab5" class="weui-tab__bd-item">
                <div id="upDiv5"></div>
                <div id="downDiv5"></div>
                <div class='weui-loadmore'><br>
                    <i class='weui-loading'></i>
                    <span class='weui-loadmore__tips'> 加载中</span>
                </div>
                <div class="weui-panel weui-panel_access end-tip">
                    <div class="weui-cell weui-cell_access weui-cell_link" style="color: #586c94">
                        <span class="weui-cell__bd">亲，没有更多活动啦~</span>
                    </div>
                </div>
                    <%--无内容显示--%>
                <%--<c:if test="${leaderActivityList==[]}">--%>
                    <%--<div class='empty-tip'>--%>
                        <%--<img src='${ctx}/images/empty-pic.png' alt='哎呀~'>--%>
                        <%--<br>暂无任何带队活动--%>
                    <%--</div>--%>
                <%--</c:if>--%>
                <%--<c:forEach items="${leaderActivityList}" var="act">--%>
                    <%--<div>--%>
                        <%--<input type="hidden" class="actId" value="${act.id}"/>--%>
                        <%--<input type="hidden" value="/photo/QRCode/${act.QRCode}"/>--%>
                        <%--<c:if test="${act.state != '已结束'}">--%>
                            <%--<a class="open-popup" data-target="#qr">--%>
                                <%--<span class="set-qrcode">群二维码</span>--%>
                            <%--</a>--%>
                        <%--</c:if>--%>
                        <%--<span class="set-status">设置状态</span>--%>
                        <%--<div class="my-item">--%>
                            <%--<a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${act.id}&productId=${act.product.id}&cityId=${cityMessage.id}">--%>
                                <%--<div class="weui-flex my-pic">--%>
                                    <%--<div class="weui-flex__item">--%>
                                        <%--<img src="/photo/product/${act.product.picUrl}">--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<div class="weui-flex">--%>
                                    <%--<div class="weui-flex__item">--%>
                                            <%--${act.pro_name}--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<div>--%>
                                <%--<span class="my-detail">--%>
                                    <%--<fmt:formatDate value="${act.departTime}"--%>
                                                    <%--pattern="yyyy-MM-dd HH:mm" />出发--%>
                                <%--</span>--%>
                                    <%--<span class="my-status-1">${act.state}</span>--%>
                                <%--</div>--%>
                            <%--</a>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</c:forEach>--%>
            </div>
        </c:if>
    </div>
</div>
<!--添加二维码-->
<div id="qr" class="weui-popup__container" style="display: none;">
    <div class="weui-popup__overlay"></div>
    <div class="weui-popup__modal">
        <a class="weui-btn weui-btn_primary close-popup">返回</a>
        <br><br>欢迎长按二维码<br>加入活动群<br><br>
        <img src="" style="width: 60%" id="showQrCode" alt="二维码预览区"><br><br>
        <div class="consult-tip">
            温馨提示：这是公开接受咨询的活动群，无法逐一审核群内用户，小伙伴们请谨慎接受陌生人的好友请求。
        </div>
        <a class="weui-btn weui-btn_plain-default" id="uploadQrCode">上传二维码图片</a>
    </div>
</div>
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
    <a href="#" class="weui-tabbar__item weui-bar__item--on">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-mine_on.png" alt="">
        </div>
        <p class="weui-tabbar__label">我的</p>
    </a>
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/fastclick.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    var dList =$("#draftList"),
        dPageNum = 1, //当前草稿页码
        dPageSize = 5,//每页显示草稿数量
        dIsEnd = false, //草稿页码是否结束标志
        dLoading = $(".draft-weui-loadmore"),//草稿加载中
        dMore = $("#moreDraft"),//加载更多草稿
        dEndTip = '<div class="weui-panel__ft">' +
            '<a class="weui-cell weui-cell_access weui-cell_link">' +
            '<div class="weui-cell__bd">没有更多草稿了哦~</div></a></div>',//没有更多草稿

        jList = $("#journeyList"),
        pageNum = 1, //当前游记页码
        pageSize = 5,//每页显示游记数量
        isEnd = false, //游记页码是否结束标志
        jTitle = $("#released"),//已发布游记标题
        loading = $("#tab2").find(".weui-loadmore"),//游记加载中
        more = $("#more"),//加载更多游记
        endTip = $("#end-tip");//没有更多游记

    $(function () {
        FastClick.attach(document.body);
        var $showQrCode = $("#showQrCode"),
            config = {
                debug: '', // 开启调试模式
                appId: '', // 必填，公众号的唯一标识
                timestamp: '', // 必填，生成签名的时间戳
                nonceStr: '', // 必填，生成签名的随机串
                signature: '',// 必填，签名，见附录
                jsApiList: [] // 必填，需要使用的JS接口列表，所有JS接口列表见附录
            };
        $.ajax({
            url: '${ctx}/wechat/getSdkConfig',
            type: 'GET',
            dataType: 'json',
            async:false,
            data: {url: window.location.href},
            success: function (data) {
                config.debug = data.debug;
                config.appId = data.appId;
                config.timestamp = data.timestamp;
                config.nonceStr = data.nonceStr;
                config.signature = data.signature;
                config.jsApiList = data.jsApiList;
            }
        });
        wx.config(config);//配置参数
        window.sharp_Config = {
            "share": {
                "imgUrl": "http://www.ailangfamily.com/images/wechat-logo.jpg",//分享图，默认当相对路径处理，所以使用绝对路径的的话，“http://”协议前缀必须在。
                "desc": "世界那么大，我们就爱浪。",//摘要,如果分享到朋友圈的话，不显示摘要。
                "title": '爱浪Family',//分享卡片标题
                "link": window.location.href,//分享出去后的链接，这里可以将链接设置为另一个页面。
                "success": function () {//分享成功后的回调函数
                },
                'cancel': function () {
                    // 用户取消分享后执行的回调函数
                }
            }
        };
        wx.ready(function() {
            wx.onMenuShareAppMessage(sharp_Config.share);//分享给好友
            wx.onMenuShareTimeline(sharp_Config.share);//分享到朋友圈
            wx.onMenuShareQQ(sharp_Config.share);//分享给手机QQ
        });

        //相册
        var $tab3 = $("#tab3"),
            $weuiTab = $(".weui-tab__bd-item"),
            _h = ($weuiTab.width()-10)/2-20;
        $tab3.find("img").each(function () {
            $(this).css("height",_h);
            if($(this).attr("src") === "/photo/user/"){
                $(this).attr("src","${ctx}/images/album-default.png");
            }
        });
        $(window).resize(function () {
            _h = ($weuiTab.width()-10)/2-20;
            $tab3.find("img").each(function () {
                $(this).css("height",_h);
            })
        });
        //调用滚动函数
        myScroll("#tab1");
        myScroll("#tab2");
        myScroll("#tab3");
        myScroll("#tab4");
        myScroll("#tab5");

        /**
         * 获取用户参与活动信息
         */
        var tab1 = $("#tab1"),
            upDiv1 = $("#notEnd1"),
            downDiv1 = $("#end1"),
            loading1 = tab1.find(".weui-loadmore"),
            endTip1 = tab1.find(".end-tip");
        $.ajax({
            url: '${ctx}/wechat/mine/showMineAct',
            type: 'GET',
            dataType: 'json',
            data: {userId:"${sessionScope.userInfo.id}"},
            beforeSend:function(){
                loading1.show();
            },
            success: function (ord) {
                loading1.hide(); //隐藏加载提示
                var empty = '<div class="empty-tip">' +
                        '<img src="${ctx}/images/empty-pic.png" alt="哎呀~"><br>暂未参与过任何活动</div>',
                    notEnd = '',    //未结束
                    // 已结束
                    end = '<div class="weui-cells__title">已结束活动</div>';

                //参与活动为空时
                if(ord.length == 0){
                    tab1.append(empty)
                }
                else{   //参与活动不为空
                    for(var i=0;i<ord.length;i++){
                        /**
                         * 未结束活动
                         */
                        if(ord[i].activity.state != '已结束'){
                            //满足可退款条件时
                            if(ord[i].activity.state == '未成行' || ord[i].activity.state == '已成行' ||
                                ord[i].activity.state == '已满人'){
                                if(ord[i].state == '2'){
                                    notEnd += '<span class="refund" id="'+ord[i].id+'">活动退款</span>';
                                }
                            }
                            //活动链接+ID+活动封面+活动名称+出发时间+活动状态
                            notEnd += '<div class="my-item">' +
                                '<a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId='+
                                ord[i].activity.id+'&productId='+
                                ord[i].activity.product.id+'&cityId=${cityMessage.id}">' +
                                '<div class="weui-flex my-pic">' + '<div class="weui-flex__item">' +
                                '<img src="/photo/product/'+ord[i].activity.product.picUrl+'"></div></div>' +
                                '<div class="weui-flex">' +
                                '<div class="weui-flex__item">'+ord[i].activity.product.name+'</div></div>' +
                                '<div><span class="my-detail">'+ fmtDate(ord[i].activity.departTime)+' 出发</span>';
                            var s = ord[i].activity.state;
                            if(s == "未成行"){
                                notEnd +=
                                    '<span class="my-status-1">未成行</span></div></a></div></div>';
                            }else if(s == "已成行"){
                                notEnd +=
                                    '<span class="my-status-2">已成行</span></div></a></div></div>';
                            }else if(s == "活动中"){
                                notEnd +=
                                    '<span class="my-status-3">活动中</span></div></a></div></div>';
                            }else{
                                notEnd +=
                                    '<span class="my-status-4">已满人</span></div></a></div></div>';
                            }
                            upDiv1.append(notEnd);
                            notEnd = '';
                        }
                        /**
                         * 已结束活动
                         */
                        else{
                            //活动名称
                            end += '<div class="weui-panel weui-panel_access" ' +
                                'onclick="myHref(\''+ord[i].activity.id+'\',\''+ord[i].activity.product.id+'\')">' +
                                '<div class="weui-cell weui-cell_access weui-cell_link">' +
                                '<div class="weui-cell__bd">' +
                                '<div class="product-name">'+ord[i].activity.product.name+'</div>';
                            //未评论
                            if(ord[i].isComment == '0'){
                                end += '<a href="${ctx}/wechat/comment/ShowCommentIndex?id='+
                                    ord[i].id+'"><span class="comments">发表评论</span></a>'
                            }
                            //已评论
                            else{
                                end += '<a href="${ctx}/wechat/comment/ShowCommentIndexDetail?orderId='+
                                    ord[i].id+'&userId='+ord[i].user.id+'&activityId='+ord[i].activity.id+
                                    '"><span class="comments">查看评论</span></a>';
                            }
                            //出发时间+结束状态
                            end += '<span class="time-info">'+ fmtDate(ord[i].activity.departTime)+
                                ' 出发</span>' + '<span class="my-status-5">已结束</span></div></div></div>';
                            downDiv1.append(end);
                            end = '';
                        }
                        //没有更多活动了
                        if(i==ord.length-1){endTip1.show()}
                    }
                }
            }
        });


        /**
         * 获取领队带队活动信息
         */
        var tab5 = $("#tab5"),
            upDiv5 = $("#upDiv5"),
            downDiv5 = $("#downDiv5"),
            loading5 = tab5.find(".weui-loadmore"),
            endTip5 = tab5.find(".end-tip");
        $(document).on("click","a[href='#tab5']",function () {
            $.ajax({
                url: '${ctx}/wechat/mine/showMineLeaderAct',
                type: 'GET',
                dataType: 'json',
                data: {},
                beforeSend:function(){
                    upDiv5.html("");
                    downDiv5.html("");
                    loading5.show();
                },
                success: function (act) {
                    loading5.hide(); //去掉加载提示
                    var empty = '<div class="empty-tip">' +
                            '<img src="${ctx}/images/empty-pic.png" alt="哎呀~"><br>暂无任何带队活动</div>',
                        notEnd = '',    //未结束
                        //已结束
                        end = '<div class="weui-cells__title">已结束活动</div>';

                    //带队活动为空时
                    if(act.length == 0){
                        tab5.html(empty)
                    }
                    else{   //带队活动不为空
                        for(var i=0;i<act.length;i++){
                            /**
                             * 未结束活动
                             */
                            if(act[i].state != '已结束'){
                                //活动链接+ID+活动封面+活动名称+出发时间+活动状态
                                notEnd += '<div><input type="hidden" class="actId" value="'+act[i].id+'"/>' +
                                    '<input type="hidden" value="/photo/QRCode/'+act[i].QRCode+'"/>'+
                                    '<a class="open-popup" data-target="#qr">' +
                                    '<span class="set-qrcode">群二维码</span></a>' +
                                    '<span class="set-status">设置状态</span>' +
                                    '<div class="my-item">' +
                                    '<a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId='+
                                    act[i].id+'&productId='+act[i].product.id+'&cityId=${cityMessage.id}">' +
                                    '<div class="weui-flex my-pic"><div class="weui-flex__item">' +
                                    '<img src="/photo/product/'+act[i].product.picUrl+'"></div></div>' +
                                    '<div class="weui-flex"> <div class="weui-flex__item">'+ act[i].pro_name+'</div></div>' +
                                    '<div> <span class="my-detail">'+fmtDate(act[i].departTime)+' 出发</span>';
                                if(act[i].state == "未成行"){
                                    notEnd +=
                                        '<span class="my-status-1">未成行</span></div></a></div></div>';
                                }else if(act[i].state == "已成行"){
                                    notEnd +=
                                        '<span class="my-status-2">已成行</span></div></a></div></div>';
                                }else if(act[i].state == "活动中"){
                                    notEnd +=
                                        '<span class="my-status-3">活动中</span></div></a></div></div>';
                                }else{
                                    notEnd +=
                                        '<span class="my-status-4">已满人</span></div></a></div></div>';
                                }
                                upDiv5.append(notEnd);
                                notEnd = '';
                            }
                            /**
                             * 已结束活动
                             */
                            else{
                                //活动名称+状态设置+出发时间+结束状态
                                end += '<div><span class="change-endStatus">设置状态</span>' +
                                    '<input type="hidden" value="'+act[i].id+'">' +
                                    '<div class="wtexteui-panel weui-panel_access" ' +
                                    'onclick="myHref(\''+act[i].id+'\',\''+act[i].product.id+'\')">' +
                                    '<div class="weui-cell weui-cell_access weui-cell_link">' +
                                    '<div class="weui-cell__bd">' +
                                    '<div class="product-name">'+act[i].pro_name+'</div>' +
                                    '<span class="time-info">'+ fmtDate(act[i].departTime)+ ' 出发</span>'+
                                    '<span class="my-status-5">已结束</span></div></div></div></div>';
                                downDiv5.append(end);
                                end = '';
                            }
                            //没有更多活动了
                            if(i==act.length-1){endTip5.show()}
                        }
                    }
                }
            });
        });

        var tmpActID,
        dTitle = $("#draftTitle");
        $(document)
        /**
         * 参与活动
         */
        //活动退款
            .on("click",".refund",function () {
                var orderId = $(this).attr("id");
                $.confirm({
                    title: '温馨提示',
                    text: '退款请求需经后台审核通过后方可退款成功，确定对该活动进行退款吗？',
                    onOK: function () {
                        $.ajax({
                            url: "${ctx}/wechat/mine/applyRefund",
                            type: "POST",
                            dataType: "json",
                            data: {"orderId":orderId},
                            beforeSend:function(XMLHttpRequest){
                                $.showLoading("请求发送中");
                            },
                            success: function (data) {
                                $.hideLoading();
                                if (data.code == 200) {
                                    alert("退款申请发送成功，我们会尽快回复审核结果，祝您生活愉快！");
                                    window.location.reload();
                                } else {
                                    alert(data.message);
                                    alert("退款申请发送失败，请稍后重试！" +
                                        "如有疑问，欢迎咨询 18520148370，谢谢。")
                                }
                            }
                            ,error:function () {
                                $.hideLoading();
                                alert("退款申请发送失败，请稍后重试！" +
                                    "如有疑问，欢迎咨询 18520148370，谢谢。")
                            }
                        });
                    }
                });
//                var data = new FormData(document.getElementById("addForm"));
//                data.append("name", _name);
            })

            /*****************************************
             * 游记
             */
            //查看游记草稿
            .on("click","#draft",function () {
                if(dTitle.text() == "查看我的游记草稿"){
                    //获取草稿列表
                    dListAjax();
                }else{
                    dMore.hide();//隐藏加载更多
                }
                dList.toggle();
                var txt = dTitle.text() == "查看我的游记草稿"?"收起游记草稿 ↑":"查看我的游记草稿";
                dTitle.text(txt);
            })
            //删除草稿
            .on("click",".delete-draft",function () {
                var sure = confirm("草稿删除后将无法恢复，确定删除吗？");
                if(sure){
                    var self = $(this),obj = self.parent().find("input");
                    $.ajax({
                        url: '${ctx}/wechat/journey/deleteDraft',
                        type: 'post',
                        dataType: 'json',
                        data: {
                            id:obj.attr("id")
                        },
                        beforeSend:function(){
                            $.showLoading("草稿删除中");
                        },
                        success: function () {
                            $.hideLoading();
                            //删除成功
                            $.toast("草稿删除成功",1000);
                            self.parent().remove();
                        },
                        error:function () {
                            $.hideLoading();
                            alert("系统繁忙，请稍后重试");
                        }
                    });
                }
            })
            //发布游记
            .on("click",".release",function () {
                var self = $(this),
                    parent = self.parent(),
                    obj = parent.find("input");
                $.ajax({
                    url: '${ctx}/wechat/journey/changeDraftState',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        id:obj.attr("id"),
                        state:obj.val()
                    },
                    beforeSend:function(){
                        $.showLoading("申请发布中");
                    },
                    success: function () {
                        $.hideLoading();
                        //发布成功
                        alert("游记经后台工作人员审核通过后即可成功发布，请耐心等候，谢谢。");
                        self.removeClass("release");
                        self.addClass("checking");
                        self.text("审核中....");
                        parent.find("a").attr("href","javascript:");//不可点击
                        parent.find(".weui-media-box__title").text("请耐心等候，谢谢谅解。");
                        parent.find(".weui-media-box__desc").find("span").text("暂时不可查看或编辑");
                    },
                    error:function () {
                        $.hideLoading();
                        alert("系统繁忙，请稍后重试");
                    }
                });
            })
            //删除游记
            .on("click",".delete-journey",function () {
                var sure = confirm("游记删除后将无法恢复，确定删除吗？");
                if(sure){
                    var self = $(this),obj = self.parent().find("input");
                    $.ajax({
                        url: '${ctx}/wechat/journey/deleteDraft',
                        type: 'post',
                        dataType: 'json',
                        data: {
                            id:obj.attr("id")
                        },
                        beforeSend:function(){
                            $.showLoading("游记删除中");
                        },
                        success: function () {
                            $.hideLoading();
                            //删除成功
                            $.toast("游记删除成功",1000);
                            self.parent().remove();
                        },
                        error:function () {
                            $.hideLoading();
                            alert("系统繁忙，请稍后重试");
                        }
                    });
                }
            })

            /******************************************
             * 相册
             */
            // 相册——添加相册
            .on("click",".add-album",function () {
                $.prompt({
                    title: '请输入新相册名称',
                    empty: true, // 是否允许为空
                    onOK: function (input) {
                        var albumName = $("#weui-prompt-input").val();
                        if(albumName == ""){
                            $.alert({text: '相册名不能为空哦'})
                        }else{
//                            alert("你输入的相册名为"+albumName);
                            $.ajax({
                                type:"post",
                                url: "${ctx}/wechat/album/addAlbum", // 请求处理页
                                dataType: "json",
                                data: {"user.id": "${sessionScope.userInfo.id}", "name": albumName},
                                success: function (data) {
                                    if (data.code == 200) {
                                        alert(data.message);
                                        window.location.href = "${ctx}/wechat/mine/showMinePhoto?album.id=" + data.entity.id.toString();
                                    } else {
                                        alert(data.message);
                                    }
                                },
                                error:function (e) {
                                    alert("系统繁忙，请稍后再试");
                                }
                            });
                        }
                    }
                });
            })

            /******************************************
             * 带队活动
             */
            // 添加二维码图片
            .on("click","#uploadQrCode",function () {
                var qrUrl = $(this).prev().val();
                //actId = $("#actId").val();
                $showQrCode.prop("src",qrUrl); // 显示当前二维码图片
                wx.ready(function(){
                    wx.chooseImage({
                        count: 1, // 只允许上传1张
                        sizeType: ['compressed'], // 指定为压缩图，无原图
                        sourceType: ['album', 'camera'], // 可以指定来源是相册或相机
                        success: function (res) {
                            // 返回选定照片的本地ID列表，
                            // localId可以作为img标签的src属性显示图片
                            var localIds = res.localIds;
                            $showQrCode.prop("src",localIds);
                            console.log(localIds);
                            //保存上传
                            setTimeout(function(){
                                wx.uploadImage({
                                    localId: localIds.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
                                    isShowProgressTips: 1, // 默认为1，显示进度提示
                                    success: function (res) {
                                        var serverId = res.serverId; // 返回图片的服务器端ID
                                        //alert(serverId);
                                        $.ajax({
                                            url: "${ctx}/wechat/mine/setQRCode",
                                            type: 'POST',
                                            dataType: 'json',
                                            data: {"mediaId": serverId, "actId": tmpActID},
                                            traditional: true,
                                            success: function (data) {
                                                if (data.code === 200) {
                                                    alert(data.message);
                                                    location.reload();
                                                } else {
                                                    alert(data.message);
                                                }
                                            },
                                            error: function () {
                                                alert("系统繁忙，请稍后再试");
                                            }
                                        }).done(function(data) {
                                            console.log("上传二维码成功");
                                        }).fail(function() {
                                            console.log("error");
                                        }).always(function() {
                                            console.log("complete");
                                        });
                                    }
                                });
                            },100);
                        }
                    });
                });
            })
            // 展示群二维码
            .on("click",".set-qrcode",function () {
                var showQrUrl = $(this).parent().prev().val();
                tmpActID = $(this).parent().prev().prev().val();
                //alert(tmpActID);
                //alert(showQrUrl);
                $("#showQrCode").prop("src",showQrUrl);
            })
            // 设置 未结束带队活动 状态
            .on("click",".set-status",function () {
                var $self = $(this);
                $.actions({
                    title: "设置活动状态",
                    actions: [
                        {
                            text: "设置为 [ 已结束 ]",
                            className: "bg",
                            onClick: function () {
                                var actId = $self.parent().find(".actId").val();
                                $.ajax({
                                    url: "${ctx}/wechat/mine/changeActivityState",
                                    type: "POST",
                                    dataType: "json",
                                    data: {"actId": actId, "state": "已结束"},
                                    success: function (data) {
                                        if (data.code == 200) {
                                            alert(data.message);
                                            $("a[href='#tab5']").trigger("click");
                                        } else {
                                            alert(data.message);
                                        }
                                    },
                                    error: function () {
                                        alert("系统繁忙，请稍后再试");
                                    }
                                });
                            }
                        }
                    ]
                });
            })
            //设置 结束带队活动 状态
            .on("click",".change-endStatus",function () {
                var $self = $(this);
                $.actions({
                    title: "设置活动状态",
                    actions: [
                        {
                            text: "设置为 [ 活动中 ]",
                            className: "bg",
                            onClick: function () {
                                var actId = $self.next().val();
                                $.ajax({
                                    url: "${ctx}/wechat/mine/changeActivityState",
                                    type: "POST",
                                    dataType: "json",
                                    data: {"actId": actId, "state": "活动中"},
                                    success: function (data) {
                                        if (data.code == 200) {
                                            alert(data.message);
                                            $("a[href='#tab5']").trigger("click");
                                        } else {
                                            alert(data.message);
                                        }
                                    },
                                    error: function () {
                                        alert("系统繁忙，请稍后再试");
                                    }
                                });
                            }
                        }
                    ]
                });
            });

        $(document).on("click","#moreDraft",function () {//加载更多草稿
            dListAjax();
        });

        //获取已发布游记列表
        jListAjax();
        $(document).on("click","#more",function () {//加载更多游记
            jListAjax();
        })
    });

    /**
     * 获取对应游记列表页码的数据
     */
    function jListAjax() {
        if(!isEnd){ //页码未结束
            $.ajax({
                url: '${ctx}/wechat/journey/showJourneyListAtMine',
                type: 'GET',
                dataType: 'json',
                data: {
                    id:"${sessionScope.userInfo.id}",
                    pageNum:pageNum,
                    pageSize:pageSize
                },
                beforeSend:function(){
                    loading.show();
                    more.hide();
                    endTip.hide();
                },
                success: function (pageInfo) {
                    if(pageInfo.list.length == 0){
                        loading.hide();
                        var empty = '<div class="empty-tip">' +
                            '<img src="${ctx}/images/empty-pic.png" alt="哎呀~"><br>暂无已发布游记</div>';
                        $("#tab2").append(empty);
                    }
                    else{
                        //console.log("当前第"+pageNum+"页,剩下"+(pageInfo.total-pageNum*10)+"条数据");
                        var pageSum = parseInt(pageInfo.total/pageSize)+1; //总页数，设定10条为一页
                        var len;
                        if(pageSum == 1){  //只有一页，即<=10条评价
                            len = pageInfo.total;
                        }
                        else{   //大于一页，即>=10条评价
                            len = pageNum*pageSize<pageInfo.total?
                                pageSize:(pageInfo.total-(pageNum-1)*pageSize);
                            // 当前页码*10，是否小于总数据长度，是则先显示10条，len=10；
                            // 否则表示剩下最后一页，显示完剩下的数据，len=pageInfo.total-(pageNum-1)*10
                        }
                        var str = "";
                        for (var i = 0;i<len;i++){
                            str += '<span class="delete-journey">删除游记</span>'+
                                '<input type="hidden" id="'+pageInfo.list[i].id+
                                '" value="'+pageInfo.list[i].state+'">'+
                                '<a href="${ctx}/wechat/journey/showJourneyById?id='+pageInfo.list[i].id+'"' +
                                'class="weui-media-box weui-media-box_appmsg">' +
                                '<div class="weui-media-box__hd">' +
                                '<img class="weui-media-box__thumb" src="${ctx}/photo/TravelNote/'+pageInfo.list[i].picUrl+'"></div>' +
                                '<div class="weui-media-box__bd">' +
                                '<h4 class="weui-media-box__title">'+pageInfo.list[i].title+'</h4>' +
                                '<p class="weui-media-box__desc my-name">' +
                                '<img src="${sessionScope.userInfo.headImgUrl}"> ${sessionScope.userInfo.nickName}</p>' +
                                '<p class="weui-media-box__desc">'+fmtDate(pageInfo.list[i].createTime)+
                                ' <span>浏览 '+pageInfo.list[i].browseTimes+'+</span></p></div></a>'
                        }
                        if (str !== null){
                            jTitle.show();
                            loading.hide();
                            more.hide();
                            jList.append(str);
                            pageNum++;
                            if(pageNum <= pageSum){
                                more.show();
                            }else{
                                loading.hide();
                                more.hide();
                                endTip.show();
                                isEnd = true; //页码已结束
                            }
                        }
                    }
                },
                error:function () {
                    alert("系统繁忙，请稍后重试");
                }
            });
        }
    }

    /**
     * 获取对应草稿页码的数据
     */
    function dListAjax() {
        if(!dIsEnd){ //页码未结束
            $.ajax({
                url: '${ctx}/wechat/journey/showDraftListAtMine',
                type: 'GET',
                dataType: 'json',
                data: {
                    id:"${sessionScope.userInfo.id}",
                    pageNum:dPageNum,
                    pageSize:dPageSize
                },
                beforeSend:function(){
                    dLoading.show();
                    dMore.hide();
                },
                success: function (pageInfo) {
                    //console.log("当前第"+pageNum+"页,剩下"+(pageInfo.total-pageNum*10)+"条数据");
                    var pageSum = parseInt(pageInfo.total/dPageSize)+1; //总页数，设定10条为一页
                    var len;
                    if(pageSum == 1){  //只有一页，即<=10条评价
                        len = pageInfo.total;
                    }
                    else{   //大于一页，即>=10条评价
                        len = dPageNum*dPageSize<pageInfo.total?
                            dPageSize:(pageInfo.total-(dPageNum-1)*dPageSize);
                        // 当前页码*10，是否小于总数据长度，是则先显示10条，len=10；
                        // 否则表示剩下最后一页，显示完剩下的数据，len=pageInfo.total-(pageNum-1)*10
                    }
                    var str = "";
                    for (var i = 0;i<len;i++){
                        str += '<div class="weui-panel__bd">';
                        if(pageInfo.list[i].state == 0){
                            str += '<span class="checking">审核中....</span>';
                            str += '<span class="delete-draft">删除草稿</span>' +
                                '<input type="hidden" id="'+pageInfo.list[i].id+
                                '" value="'+pageInfo.list[i].state+'">'+
                                '<div class="weui-media-box weui-media-box_appmsg">' +
                                '<div class="weui-media-box__bd">' +
                                '<h4 class="weui-media-box__title">请耐心等候，谢谢谅解。</h4>' +
                                '<p class="my-draftTitle">标题：'+pageInfo.list[i].title+'</p>' +
                                '<p class="weui-media-box__desc">'+
                                fmtDate(pageInfo.list[i].createTime)+
                                ' 保存<span>暂时不可查看或编辑</span></p></div></div></div>'
                        }
                        else{
                            if(pageInfo.list[i].state == 2){
                                str += '<span class="not-pass">未能通过</span>';
                            }
                            else if(pageInfo.list[i].state == 3){
                                str += '<span class="release">发布游记</span>';
                            }
                            else{
                                console.log("其他草稿状态：");
                                console.log(pageInfo.list[i].state);
                            }
                            str += '<span class="delete-draft">删除草稿</span>' +
                                '<input type="hidden" id="'+pageInfo.list[i].id+
                                '" value="'+pageInfo.list[i].state+'">'+
                                '<a href="${ctx}/wechat/journey/showDraftJourneyById?id='+pageInfo.list[i].id+
                                '" class="weui-media-box weui-media-box_appmsg">' +
                                '<div class="weui-media-box__bd">' +
                                '<h4 class="weui-media-box__title">我的草稿</h4>' +
                                '<p class="my-draftTitle">标题：'+pageInfo.list[i].title+'</p>' +
                                '<p class="weui-media-box__desc">'+
                                fmtDate(pageInfo.list[i].createTime)+
                                ' 保存<span>点击查看或编辑</span></p></div></a></div>'
                        }
                    }
                    if (str !== null){
                        dLoading.hide();
                        dMore.hide();
                        dList.append(str);
                        dPageNum++;
                        if(dPageNum <= pageSum){
                            dMore.show();
                        }else{
                            dLoading.hide();
                            dMore.hide();
                            dList.append(dEndTip);
                            dIsEnd = true; //页码已结束
                        }
                    }
                },
                error:function () {
                    alert("系统繁忙，请稍后重试");
                }
            });
        }
    }

    /**
     * 滑动参与活动、相册、收藏（和带队活动）时内容置顶
     */
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

    /**
     * 已结束活动跳转对应详情页面
     * @param aID 活动ID
     * @param pID 产品ID
     */
    function myHref(aID,pID) {
        window.location.href =
            '${ctx}/wechat/WxProductDetail/getProductDetail?actId='+
            aID+'&productId='+ pID+'&cityId=${cityMessage.id}';
    }

    /**
     * 创建时间格式化
     * @param t
     * @returns {string}
     */
    function fmtDate(t) {
        var date = new Date(t),
            y = date.getFullYear(),
            m = date.getMonth()<9?"0"+(date.getMonth()+1):date.getMonth()+1,
            d = date.getDate()<10?"0"+date.getDate():date.getDate(),
            h = date.getHours()<10?"0"+date.getHours():date.getHours(),
            min = date.getMinutes()<10?"0"+date.getMinutes():date.getMinutes();
        return y+"-"+m+"-"+d+" "+h+":"+min;
    }
</script>
</body>
</html>