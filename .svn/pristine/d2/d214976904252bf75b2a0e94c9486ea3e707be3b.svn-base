<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>户外学堂</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body,html{height: 100%}
        .weui-tab__bd {
            font-size: 14px;
            padding-bottom: 50px;
        }
        .weui-navbar__item.weui-bar__item--on{border-bottom: 0}
        .my-pic img {width: 100%;min-height: 120px}
        .empty{width: 50%;margin: 25% 25% 20px 25%;}
        .weui-media-box{padding: 10px 15px}
        .weui-media-box__desc span{float: right}
        .weui-media-box_appmsg .weui-media-box__hd{width: 110px;line-height: inherit}
        .weui-media-box_appmsg .weui-media-box__thumb{height: 60px}
        .weui-loadmore__tips{color: #999}
        .weui-media-box__title{
            font-size: 15px;
            white-space: normal;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
        }
        /*底部导航*/
        .weui-tabbar{position: fixed;bottom: 0}
    </style>
</head>
<body>
<!--导航对应内容-->
<div class="weui-tab" style="margin-top: 0">
    <div class="weui-navbar">
        <a class="weui-navbar__item weui-bar__item--on" href="#tab1">户外干货</a>
        <a class="weui-navbar__item" href="#tab2">出游攻略</a>
        <a class="weui-navbar__item" href="#tab3">摄影专栏</a>
    </div>
    <div class="weui-tab__bd">
        <!--1-->
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active"></div>
        <!--2-->
        <div id="tab2" class="weui-tab__bd-item"></div>
        <!--3-->
        <div id="tab3" class="weui-tab__bd-item"></div>
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
    <a href="${ctx}/wechat/outdoor/showOutdoorPage" class="weui-tabbar__item weui-bar__item--on">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-out_on.png" alt="">
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
        var loadingHtml = "<div class='weui-loadmore'><br><br>" +
                "<i class='weui-loading'></i> " +
                "<span class='weui-loadmore__tips'> 加载中</span></div>",
            empty = '<img src="${ctx}/images/empty-pic.png" alt="哎呀"' +
                'class="empty" style="opacity: 0.6">' +
                '<div style="width: 100%;text-align: center;color: #999">' +
                '更多猛料即将发布，敬请期待~ </div>';

        var tab1 = $("#tab1");
        //获取第一栏信息
        $.ajax({
            type:"post",
            url:"${ctx}/wechat/outdoor/show",
            data:{"type":"1"},
            dataType:"json",
            beforeSend:function(){tab1.html(loadingHtml)},
            success:function (data) {
                if(data.entity.length == 0){
                    tab1.html(empty);
                }else{
                    tab1.html("");
                    var text = '<div class="weui-panel weui-panel_access">' +
                        '<div class="weui-panel__bd">';
                    for (var i = 0; i < data.entity.length; i++) {
                        text += '<a href="'+data.entity[i].webURL+'" ' +  //链接地址
                            'class="weui-media-box weui-media-box_appmsg">' +
                            '<div class="weui-media-box__hd">' +    //封面图
                            '<img class="weui-media-box__thumb" src="${ctx}/photo/outdoor/'+data.entity[i].pic+'" alt=""></div>' +
                            '<div class="weui-media-box__bd">' +
                            '<h4 class="weui-media-box__title">'+data.entity[i].title+'</h4></div></a>';  //标题
                    }
                    text +='</div><div class="weui-panel__ft">' +
                        '<a href="javascript:" class="weui-cell weui-cell_access weui-cell_link">' +
                        '<div class="weui-cell__bd">已经没有更多内容啦~</div></a></div>';
                    tab1.append(text);
                }
            }
        });
        $(document)
            //获取第二栏信息
            .on("click","a[href='#tab2']",function () {
                var self = $("#tab2");
                $.ajax({
                    type:"post",
                    url:"${ctx}/wechat/outdoor/show",
                    data:{"type":"2"},
                    dataType:"json",
                    beforeSend:function(){self.html(loadingHtml)},
                    success:function (data) {
                        if(data.entity.length == 0){ //数据为空时
                            self.html(empty);
                        }else{
                            self.html("");
                            var text = '<div class="weui-panel weui-panel_access">' +
                                '<div class="weui-panel__bd">';
                            for (var i = 0; i < data.entity.length; i++) {
                                text += '<a href="'+data.entity[i].webURL+'" ' +  //链接地址
                                    'class="weui-media-box weui-media-box_appmsg">' +
                                    '<div class="weui-media-box__hd">' +    //封面图
                                    '<img class="weui-media-box__thumb" src="${ctx}/photo/outdoor/'+data.entity[i].pic+'" alt=""></div>' +
                                    '<div class="weui-media-box__bd">' +
                                    '<h4 class="weui-media-box__title">'+data.entity[i].title+'</h4></div></a>';  //标题
                            }
                            text +='</div><div class="weui-panel__ft">' +
                                '<a href="javascript:" class="weui-cell weui-cell_access weui-cell_link">' +
                                '<div class="weui-cell__bd">已经没有更多内容啦~</div></a></div>';
                            self.append(text);
                        }
                    }
                })
            })
            //获取第三栏信息
            .on("click","a[href='#tab3']",function () {
                var self = $("#tab3");
                $.ajax({
                    type:"post",
                    url:"${ctx}/wechat/outdoor/show",
                    data:{"type":"3"},
                    dataType:"json",
                    beforeSend:function(){self.html(loadingHtml)},
                    success:function (data) {
                        if(data.entity.length == 0){ //数据为空时
                            self.html(empty);
                        }else{
                            self.html("");
                            var text = '<div class="weui-panel weui-panel_access">' +
                                '<div class="weui-panel__bd">';
                            for (var i = 0; i < data.entity.length; i++) {
                                text += '<a href="'+data.entity[i].webURL+'" ' +  //链接地址
                                    'class="weui-media-box weui-media-box_appmsg">' +
                                    '<div class="weui-media-box__hd">' +    //封面图
                                    '<img class="weui-media-box__thumb" src="${ctx}/photo/outdoor/'+data.entity[i].pic+'" alt=""></div>' +
                                    '<div class="weui-media-box__bd">' +
                                    '<h4 class="weui-media-box__title">'+data.entity[i].title+'</h4></div></a>';  //标题
                            }
                            text +='</div><div class="weui-panel__ft">' +
                                '<a href="javascript:" class="weui-cell weui-cell_access weui-cell_link">' +
                                '<div class="weui-cell__bd">已经没有更多内容啦~</div></a></div>';
                            self.append(text);
                        }
                    }
                })
            });
    })
</script>
</body>
</html>