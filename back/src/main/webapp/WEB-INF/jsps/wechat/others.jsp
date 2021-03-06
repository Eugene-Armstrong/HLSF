<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <c:if test="${user.type == '2'}">
        <title>领队中心</title>
    </c:if>
    <c:if test="${user.type != '2'}">
        <title>用户个人中心</title>
    </c:if>
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
        .weui-cell{background: #fff}
        .weui-loadmore__tips{color:#999}
        /*个人信息*/
        .my-info{font-size: 14px}
        .head-img {
            text-align: center;
            color: #fff;
            margin-bottom: -100%;
            margin-top: 5%
        }
        .head-img img {
            width: 15%;
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
        .product-name{margin: 5px 0 10px 0;color: #333}
        .my-status-1, .my-status-2, .my-status-3, .my-status-4, .my-status-5 {
            float: right;
        }
        .my-item {
            font-size: 14px;
            margin-bottom: 10px;
            padding: 10px 10px 5px 10px;
            background-color: #ffffff
        }
        .my-detail{color: #999;}
        .my-pic img {width: 100%;min-height: 120px}
        .my-status-1,.my-status-2,.my-status-3{float: right}
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
        /*游记*/
        .weui-media-box{padding: 10px}
        .weui-media-box__title{font-size: 14px}
        .weui-media-box_appmsg .weui-media-box__hd,.weui-media-box__thumb{width: 120px;height: 80px}
        .my-name{color: #333;line-height: 47px}
        .weui-media-box__desc{font-size: 10px}
        .weui-media-box__desc img{width: 32px;height: 32px;border-radius: 50%;vertical-align: middle}
        .weui-media-box__desc span{float: right}
        #journeyList{background: #fff}
        #more{
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
        #end-tip,.end-tip{display: none;margin-bottom: 10px}
        .weui-panel__bd{background: #fff}
        /*相册*/
        #tab3{padding:5px;}
        #tab3 .weui-flex{float: left;width: 50%}
        #tab3 .weui-flex__item{padding:0 10px}
        #tab3 .weui-flex img{width: 100%;min-height:160px;box-shadow: 2px 2px 5px #666;margin-bottom: 10px;}
        .photo-date{color: #999;margin: 5px 0 10px 0}
        .weui-panel__bd{background: #fff}
        .time-info {
            color: #999;
            margin-top: 5px;
        }
        /*底部导航*/
        .weui-tabbar{position: fixed;bottom: 0}
    </style>
</head>
<body>
<!--个人信息-->
<div class="my-info">
    <div class="weui-flex">
        <div class="weui-flex__item">
            <div class="head-img">
                <img src="${user.headImgUrl}" alt="用户头像"><br>
                <div class="user-name">${user.nickName}
                    <c:if test="${user.sex == '1'}">♂</c:if>
                    <c:if test="${user.sex == '2'}">♀</c:if>
                </div>
                <span class="user-score">
                    经验：${user.experValue}分
                    <c:if test="${user.type == '2'}">
                        &nbsp;&nbsp;|&nbsp;&nbsp;
                        评分：<fmt:formatNumber value="${user.score}" pattern="#.0#"/>
                    </c:if>
                </span>

            </div>
        </div>
    </div>
    <div class="weui-flex">
        <div class="weui-flex__item" style="position: relative;z-index: -1">
            <img src="${ctx}/images/index-hdlx.jpg" style="width: 100%">
        </div>
    </div>
</div>
<!--导航+内容-->
<div class="weui-tab" style="margin-top: 0">
    <div class="weui-navbar">
        <a class="weui-navbar__item weui-bar__item--on" href="#tab1">参与活动</a>
        <a class="weui-navbar__item" href="#tab2">游记</a>
        <a class="weui-navbar__item" href="#tab3">相册</a>
        <a class="weui-navbar__item" href="#tab4">收藏</a>
        <c:if test="${user.type == '2'}">
            <a class="weui-navbar__item" href="#tab5">带队活动</a>
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
            <%--无内容显示--%>
            <%--<c:if test="${orders==[]}">--%>
                <%--<div class='empty-tip'>--%>
                    <%--<img src='${ctx}/images/empty-pic.png' alt='哎呀~'>--%>
                    <%--<br>暂未参与过任何活动--%>
                <%--</div>--%>
            <%--</c:if>--%>
            <%--<c:forEach items="${orders}" var="ord">--%>
                <%--<a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${ord.activity.id}&productId=${ord.activity.product.id}&cityId=${cityMessage.id}">--%>
                    <%--<div class="my-item">--%>
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
                                                            <%--pattern="yyyy-MM-dd HH:mm" />出发</span>--%>
                            <%--<span class="my-status-1">${ord.activity.state}</span>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</a>--%>
            <%--</c:forEach>--%>
        </div>
        <!--游记-->
        <div id="tab2" class="weui-tab__bd-item">
            <%--已发布游记--%>
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
                            <p class="photo-date"><fmt:formatDate value="${albumVo.album.createTime}" pattern="yyyy-MM-dd"/></p>
                        </a>
                    </div>
                </div>
            </c:forEach>
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
                <a href="${ctx}/wechat/WxProductDetail/getProductDetail?productId=${collect.id}">
                    <div class="my-item">
                        <div class="weui-flex my-pic">
                            <div class="weui-flex__item">
                                <img src="/photo/product/${collect.picUrl}">
                            </div>
                        </div>
                        <div class="weui-flex">
                            <div class="weui-flex__item">
                                    ${collect.name}
                            </div>
                        </div>
                        <div>
                            <span class="my-detail">更新时间：<fmt:formatDate value="${collect.updateTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                <%--<span class="my-status-1"></span>--%>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <!-- 带队活动 -->
        <c:if test="${user.type == '2'}">
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
                    <%--<a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${act.id}&productId=${act.product.id}&cityId=${cityMessage.id}">--%>
                        <%--<input type="hidden" id="actId" value="${act.id}"/>--%>
                        <%--<input type="hidden" value="/photo/QRCode/${act.QRCode}"/>--%>
                        <%--<div class="my-item">--%>
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
                            <%--<span class="my-detail"><fmt:formatDate value="${act.departTime}"--%>
                                                                    <%--pattern="yyyy-MM-dd HH:mm" />出发</span>--%>
                                <%--<span class="my-status-1">${act.state}</span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</a>--%>
                <%--</c:forEach>--%>
            </div>
        </c:if>
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
<script src="${ctx}/js/fastclick.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    var jList = $("#journeyList"),
        pageNum = 1, //当前游记页码
        pageSize = 5,//每页显示游记数量
        isEnd = false, //游记页码是否结束标志
        jTitle = $("#released"),//已发布游记标题
        loading = $("#tab2").find(".weui-loadmore"),//游记加载中
        more = $("#more"),//加载更多游记
        endTip = $("#end-tip");//没有更多游记

    $(function () {
        sharpConfig(window.location.href);
        FastClick.attach(document.body);

        /**
         * 获取用户参与活动信息
         */
        var tab1 = $("#tab1"),
            upDiv1 = $("#notEnd1"),
            downDiv1 = $("#end1"),
            loading1 = tab1.find(".weui-loadmore"),
            endTip1 = tab1.find(".end-tip");
        $.ajax({
            url: '${ctx}/wechat/user/showOtherPageAct',
            type: 'GET',
            dataType: 'json',
            data: {userId:"${user.id}"},
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
                else{  //console.log(ord);
                    //参与活动不为空
                    for(var i=0;i<ord.length;i++){
                        /**
                         * 未结束活动
                         */
                        if(ord[i].activity.state != '已结束'){
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
                url: '${ctx}/wechat/user/showOtherPageLeaderAct',
                type: 'GET',
                dataType: 'json',
                data: {userId:"${user.id}"},
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
                                notEnd += '<div><div class="my-item">' +
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
                                end += '<div><input type="hidden" value="'+act[i].id+'">' +
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

        // 相册宽高
        var $tab3 = $("#tab3"),
            $weuiTab = $(".weui-tab__bd-item"),
            _h = ($weuiTab.width()-10)/2-20;
        $tab3.find(".weui-flex img").each(function () {
            $(this).css("height",_h);
        });
        $(window).resize(function () {
            _h = ($weuiTab.width()-10)/2-20;
            $tab3.find(".weui-flex img").each(function () {
                $(this).css("height",_h);
                if($(this).attr("src") === "/photo/user/"){
                    $(this).attr("src","${ctx}/images/album-default.png");
                }
            })
        });
        //调用滚动函数
        myScroll("#tab1");
        myScroll("#tab2");
        myScroll("#tab3");
        myScroll("#tab4");
        myScroll("#tab5");

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
                    id:"${user.id}",
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
                            str += '<a href="${ctx}/wechat/journey/showJourneyById?id='+pageInfo.list[i].id+'"' +
                                'class="weui-media-box weui-media-box_appmsg">' +
                                '<div class="weui-media-box__hd">' +
                                '<img class="weui-media-box__thumb" src="${ctx}/photo/TravelNote/'+pageInfo.list[i].picUrl+'"></div>' +
                                '<div class="weui-media-box__bd">' +
                                '<h4 class="weui-media-box__title">'+pageInfo.list[i].title+'</h4>' +
                                '<p class="weui-media-box__desc my-name">' +
                                '<img src="${user.headImgUrl}"> ${user.nickName}</p>' +
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

    //滑动参与活动、相册、收藏（和带队活动）时内容置顶
    function myScroll(obj) {
        var count = 0;
        $(obj).scroll(function () {
            count++;
            if($(window).scrollTop()+50 < $(this).offset().top && count == 1){
//                console.log($(window).scrollTop() + " "+$(this).offset().top);
                $("html,body").animate({scrollTop: $(this).offset().top}, 100);
            }else{
                count = 0;
            }
        });
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