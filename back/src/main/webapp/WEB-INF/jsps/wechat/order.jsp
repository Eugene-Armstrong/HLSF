<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单中心</title>
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
        .weui-panel{margin-bottom: 15px}
        .need-to-pay:after,.has-paid:after,.refund:after{
            font: 16px weui;
            color: #999;
            vertical-align: top;
        }
        .need-to-pay:after{content: "\EA09"}
        .has-paid:after{content: "\EA04"}
        .refund:after{content: "\EA06"}
        .weui-bar__item--on .need-to-pay:after,
        .weui-bar__item--on .has-paid:after,
        .weui-bar__item--on .refund:after{color: #37a1ff}

        /*订单项*/
        .cancel-order{
            position: absolute;
            right: 15px;
            top: 10px;
        }
        .cancel-order:after{
            font: 18px weui;
            color: #bfbfbf;
            content: "\EA11";
            cursor: pointer;
        }
        /*多行文本溢出省略号*/
        .product-name{
            height: 40px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
        }
        .product-count{float: right;color: #999}
        .to-pay{color: #f44336;font-size: 16px}
        .paid{color:#333;font-size: 16px}
        .weui-cell_link{color: #999}
        .weui-form-preview__btn_primary{color: #fff}
        button.weui-form-preview__btn{background:#f44336;cursor: pointer}
        .stamp{position: absolute;width: 80px;top: -10px;right:20px;opacity: .8}
        .my-pic img {width: 100%;min-height: 120px}
        .empty-order{width: 50%;margin: 25% 25% 20px 25%;}
        .weui-media-box{padding: 10px}
        .weui-media-box_appmsg .weui-media-box__hd,
        .weui-media-box__thumb{width: 110px;height: 60px}
        .weui-media-box__desc span{float: right}
        .weui-form-preview{margin-bottom: 15px}
        .weui-loadmore__tips{color: #999}
        /*底部导航*/
        .weui-tabbar{position: fixed;bottom: 0}
    </style>
</head>
<body>
<!--导航+内容-->
<div class="weui-tab" style="margin-top: 0">
    <div class="weui-navbar">
        <a class="weui-navbar__item weui-bar__item--on" href="#tab1" id="paid">
            <span class="has-paid"></span> 已付款
        </a>
        <a class="weui-navbar__item" href="#tab2" id="unpaid">
            <span class="need-to-pay"></span> 待支付
        </a>
        <a class="weui-navbar__item" href="#tab3" id="refund">
            <span class="refund"></span> 已退款
        </a>
    </div>
    <div class="weui-tab__bd">
        <!--已付款-->
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
            <%--<img src="${ctx}/images/empty-order.png" alt="诶呀~" class="empty-order">--%>
            <%--<div style="width: 100%;text-align: center;color: #999">--%>
            <%--您还未购买过任何产品，快去首页抢购吧~--%>
            <%--</div>--%>
            <%--<div class="weui-panel weui-panel_access">--%>
                <%--<img src="${ctx}/images/done.png" class="stamp">--%>
                <%--<div class="weui-panel__hd">--%>
                    <%--支付时间：2017-11-10 00:00:00--%>
                <%--</div>--%>
                <%--<div class="weui-panel__bd">--%>
                    <%--<a class="weui-media-box weui-media-box_appmsg">--%>
                        <%--<div class="weui-media-box__hd">--%>
                            <%--<img class="weui-media-box__thumb" src="${ctx}/images/tmp-04.jpg">--%>
                        <%--</div>--%>
                        <%--<div class="weui-media-box__bd">--%>
                            <%--<div class="product-name">这是产品3这是产品3</div>--%>
                            <%--<div>--%>
                                <%--<span class="product-price">￥180</span>--%>
                                <%--<span class="product-count">X2</span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</a>--%>
                <%--</div>--%>
                <%--<div class="weui-panel__ft">--%>
                    <%--<div class="weui-cell weui-cell_access weui-cell_link">--%>
                        <%--出发：2017-11-11 08:00 北师珠校名石集合--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="weui-form-preview__ft">--%>
                    <%--<a class="weui-form-preview__btn weui-form-preview__btn_default">--%>
                        <%--已付款：<b class="paid">￥360</b>--%>
                    <%--</a>--%>
                    <%--<button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary">--%>
                        <%--我要退款--%>
                    <%--</button>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
        <!--待支付-->
        <div id="tab2" class="weui-tab__bd-item">
            <%--<img src="${ctx}/images/empty-pic.png" alt="购物车空空如也~" class="empty-order" style="opacity: 0.6">--%>
            <%--<div style="width: 100%;text-align: center;color: #999">--%>
            <%--亲~这里没有任何待支付订单--%>
            <%--</div>--%>
            <%--<div class="weui-panel weui-panel_access">--%>
                <%--<div class="weui-panel__hd">--%>
                    <%--下单时间：2017-11-10 00:00:00--%>
                    <%--<span class="cancel-order"></span>--%>
                <%--</div>--%>
                <%--<div class="weui-panel__bd">--%>
                    <%--<a class="weui-media-box weui-media-box_appmsg">--%>
                        <%--<div class="weui-media-box__hd">--%>
                            <%--<img class="weui-media-box__thumb" src="${ctx}/images/tmp-04.jpg">--%>
                        <%--</div>--%>
                        <%--<div class="weui-media-box__bd">--%>
                            <%--<div class="product-name">这是产品1这是产品1</div>--%>
                            <%--<div>--%>
                                <%--<span class="product-price">￥180</span>--%>
                                <%--<span class="product-count">X2</span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</a>--%>
                <%--</div>--%>
                <%--<div class="weui-panel__ft">--%>
                    <%--<div class="weui-cell weui-cell_access weui-cell_link">--%>
                        <%--出发：2017-11-11 08:00 北师珠校名石集合--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="weui-form-preview__ft">--%>
                    <%--<a class="weui-form-preview__btn weui-form-preview__btn_default">--%>
                        <%--待付款：<b class="to-pay">￥360</b>--%>
                    <%--</a>--%>
                    <%--<button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary">--%>
                        <%--去支付--%>
                    <%--</button>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
        <!--已退款-->
        <div id="tab3" class="weui-tab__bd-item">
            <%--<img src="images/empty-pic.png" alt="诶呀~" class="empty-order"--%>
                 <%--style="opacity: 0.6">--%>
            <%--<div style="width: 100%;text-align: center;color: #999">--%>
                <%--这里暂时没有任何退款订单</div>--%>
            <%--<div class="weui-form-preview">--%>
                <%--<div class="weui-form-preview__hd">--%>
                    <%--<label class="weui-form-preview__label">退款金额</label>--%>
                    <%--<em class="weui-form-preview__value">¥2400.00</em>--%>
                <%--</div>--%>
                <%--<div class="weui-form-preview__bd">--%>
                    <%--<div class="weui-form-preview__item">--%>
                        <%--<label class="weui-form-preview__label">产品名称</label>--%>
                        <%--<span class="weui-form-preview__value">这是产品名称这是产品名称</span>--%>
                    <%--</div>--%>
                    <%--<div class="weui-form-preview__item">--%>
                        <%--<label class="weui-form-preview__label">出发时间地点</label>--%>
                        <%--<span class="weui-form-preview__value">2017-11-11 08:00 北师珠校名石</span>--%>
                    <%--</div>--%>
                    <%--<div class="weui-form-preview__item">--%>
                        <%--<label class="weui-form-preview__label">退款原因</label>--%>
                        <%--<span class="weui-form-preview__value">个人发起</span>--%>
                    <%--</div>--%>
                    <%--<div class="weui-form-preview__item">--%>
                        <%--<label class="weui-form-preview__label">退款时间</label>--%>
                        <%--<span class="weui-form-preview__value">2017-11-10 00:00:00</span>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="weui-form-preview__ft">--%>
                    <%--<a class="weui-form-preview__btn weui-form-preview__btn_default consult">详情咨询</a>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<!--底部导航栏-->
<div class="weui-tabbar">
    <a href="${ctx}/wechat/index/show" class="weui-tabbar__item">
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
    <a href="${ctx}/wechat/order/" class="weui-tabbar__item weui-bar__item--on">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-order_on.png" alt="">
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
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        FastClick.attach(document.body);
        var loadingHtml = "<div class='weui-loadmore'><br><br>" +
                "<i class='weui-loading'></i>" +
                "<span class='weui-loadmore__tips'> 加载中</span></div>",
            empty1 = '<img src="${ctx}/images/empty-order.png" alt="诶呀~" class="empty-order">' +
                '<div style="width: 100%;text-align: center;color: #999">' +
                '您还未购买过任何产品，快去首页抢购吧~</div>',
            empty2 = '<img src="${ctx}/images/empty-pic.png" alt="购物车空空如也~"' +
                'class="empty-order" style="opacity: 0.6">' +
                '<div style="width: 100%;text-align: center;color: #999">' +
                '亲~这里没有任何待支付订单 </div>',
            empty3 = '<img src="${ctx}/images/empty-pic.png" alt="诶呀~" ' +
                'class="empty-order"style="opacity: 0.6">' +
                '<div style="width: 100%;text-align: center;color: #999">' +
                '这里暂时没有任何退款订单</div>';

        var tab1 = $("#tab1");
        //获取已支付订单信息
        $.ajax({
            type:"post",
            url:"${ctx}/wechat/order/show",
            data:{"state":"2"},
            dataType:"json",
            beforeSend:function(){tab1.html(loadingHtml)},
            success:function (data) {
                if(data.entity.length == 0){
                    tab1.html(empty1);
                }else{
                    tab1.html("");
                    var text = '';
                    for (var i = 0; i < data.entity.length; i++) {
                        text += '<div class="weui-panel weui-panel_access">';
                        if (data.entity[i].state == '2') {
                            text += '<img src="${ctx}/images/done.png" class="stamp">';
                        }

                        text += '<div class="weui-panel__hd">支付时间：' + fmtDate(data.entity[i].payTime, true) + '</div>' + //支付时间
                            '<div class="weui-panel__bd">' +
                            '<a class="weui-media-box weui-media-box_appmsg">' +
                            '<div class="weui-media-box__hd">' +
                            '<img class="weui-media-box__thumb" src="/photo/product/' + data.entity[i].activity.product.picUrl + '"></div>' + //产品图片
                            '<div class="weui-media-box__bd">' +
                            '<div class="product-name">' + data.entity[i].activity.product.name + '</div>' + //产品名
                            '<div><span class="product-price">￥' + parseFloat((data.entity[i].activity.price)/100) + '</span>' +
                            '</div></div></a></div>' + //活动价格
                            '<div class="weui-panel__ft">' +
                            '<div class="weui-cell weui-cell_access weui-cell_link">' +
                            '出发：' + fmtDate(data.entity[i].activity.departTime,false) +
                            ' ' + data.entity[i].activity.gatherPlace + '</div></div>' + //出发时间、集合地点
                            '<div class="weui-form-preview__ft">' +
                            '<a class="weui-form-preview__btn weui-form-preview__btn_default">' +
                            '已付款：<b class="paid">￥' + parseFloat((data.entity[i].price)/100) + '</b></a>'; //付款金额
                        if (data.entity[i].state == '2') {
                            text += '<button type="button" class="weui-form-preview__btn weui-form-preview__btn_primary" onclick="refund(\'' + data.entity[i].id + '\')">' +
                                '我要退款</button></div></div>';
                        }
                        if (data.entity[i].state == '3') {
                            text += '<button type="button" disabled class="weui-form-preview__btn weui-form-preview__btn_primary"' +
                                'style="background: #679aff">' +
                                '退款申请中</button></div></div>';
                        }
                    }
                    tab1.append(text);
                }
            }
        });

        $(document).on("click",".cancel-order",function () {
            var sure = confirm("确定取消 "+
                $(this).parent().parent().find(".product-name").text()+
                " 的订单吗？");
            if(sure){
                var orderId = $(this).parent().next().val();
                $.ajax({
                    url: "${ctx}/wechat/order/cancelOrder",
                    type: "POST",
                    dataType: "json",
                    data: {"orderId": orderId},
                    success: function (data) {
                        if (data.code == 200) {
                            alert(data.message);
                            $('#unpaid').click();
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function () {
                        alert("系统繁忙，请稍后再试");
                    }
                });
            }
        })
            //获取待支付订单
            .on("click","a[href='#tab2']",function () {
                var self = $("#tab2");
                $.ajax({
                    type:"post",
                    url:"${ctx}/wechat/order/show",
                    data:{"state":"1"},
                    dataType:"json",
                    beforeSend:function(){self.html(loadingHtml)},
                    success:function (data) {
                        if(data.entity.length == 0){ //数据为空时
                            self.html(empty2);
                        }else{
                            self.html("");
                            var text = '';
                            for (var i = 0; i < data.entity.length; i++) {
                                text += '<div class="weui-panel weui-panel_access">' +
                                    '<div class="weui-panel__hd">下单时间：' + fmtDate(data.entity[i].createTime,true) + //下单时间
                                    '<span class="cancel-order"></span></div>' +
                                    '<input type="hidden" value="' + data.entity[i].id.toString() + '"/>' +
                                    '<div class="weui-panel__bd">' +
                                    '<a class="weui-media-box weui-media-box_appmsg">' +
                                    '<div class="weui-media-box__hd">' +
                                    '<img class="weui-media-box__thumb" src="/photo/product/' + data.entity[i].activity.product.picUrl + '"></div>' + //产品图片
                                    '<div class="weui-media-box__bd">' +
                                    '<div class="product-name">' + data.entity[i].activity.product.name + '</div>' + //产品名
                                    '<div><span class="product-price">￥' + parseFloat((data.entity[i].activity.price)/100) +
                                    '</span></div></div></a></div>' + //活动价格
                                    '<div class="weui-panel__ft">' +
                                    '<div class="weui-cell weui-cell_access weui-cell_link">' +
                                    '出发：' + fmtDate(data.entity[i].activity.departTime,false) +
                                    ' ' + data.entity[i].activity.gatherPlace + '</div></div>' +  //出发时间地点
                                    '<div class="weui-form-preview__ft">' +
                                    '<a class="weui-form-preview__btn weui-form-preview__btn_default">' +
                                    '待付款：<b class="to-pay">￥' + parseFloat((data.entity[i].price)/100) + '</b></a>' + //待付款金额
                                    '<button type="button" class="weui-form-preview__btn weui-form-preview__btn_primary" onclick="rePay(\'' + data.entity[i].id.toString() + '\')">' +
                                    '去支付</button></div></div>';
                            }
                            self.append(text);
                        }
                    }
                })
            })
            //获取已退款订单
            .on("click","a[href='#tab3']",function () {
                var self = $("#tab3");
                $.ajax({
                    type:"post",
                    url:"${ctx}/wechat/order/show",
                    data:{"state":"4"},
                    dataType:"json",
                    beforeSend:function(){self.html(loadingHtml)},
                    success:function (data) {
                        if(data.entity.length == 0){ //数据为空时
                            self.html(empty3);
                        }else{
                            self.html("");
                            var text = '';
                            for (var i = 0; i < data.entity.length; i++) {
                                text += '<div class="weui-form-preview">' +
                                    '<div class="weui-form-preview__hd">' +
                                    '<label class="weui-form-preview__label">退款金额</label>' +
                                    '<em class="weui-form-preview__value">¥' + parseFloat((data.entity[i].refundPrice)/100) + '</em></div>' +
                                    '<div class="weui-form-preview__bd">' +
                                    '<div class="weui-form-preview__item">' +
                                    '<label class="weui-form-preview__label">产品名称</label>' +
                                    '<span class="weui-form-preview__value">' + data.entity[i].activity.product.name + '</span>' +
                                    '</div><div class="weui-form-preview__item">' +
                                    '<label class="weui-form-preview__label">出发时间地点</label>' +
                                    '<span class="weui-form-preview__value">' + fmtDate(data.entity[i].activity.departTime,false) + ' ' + data.entity[i].activity.gatherPlace + '</span></div>' +
                                    '<div class="weui-form-preview__item">' +
                                    '<label class="weui-form-preview__label">退款时间</label>' +
                                    '<span class="weui-form-preview__value">' + fmtDate(data.entity[i].applyRefundTime,true) + '</span></div></div>' +
                                    '<div class="weui-form-preview__ft">' +
                                    '<a class="weui-form-preview__btn weui-form-preview__btn_default consult">详情咨询</a></div></div>';
                            }
                            self.append(text);
                        }
                    }
                })
            })
            .on("click",".consult",function () {
                alert("关于退款详情，欢迎咨询手机号18520148370，谢谢。")
            });
    });

    /**
     * 时间格式化
     * @param obj - 时间戳
     * @param bool - 是否具体显示到秒的布尔值
     * @returns {string}
     */
    function fmtDate(obj,bool){ //经console.log()，知obj为12小时制
        var apm = obj.substring(obj.length-2,obj.length), //上午或下午
            date = new Date(obj.substring(0,obj.length-2)),
            y = date.getFullYear(),
            m = date.getMonth()<9?"0"+(date.getMonth()+1):date.getMonth()+1,
            d = date.getDate()<10?"0"+date.getDate():date.getDate(),
            h,
            min = date.getMinutes()<10?"0"+date.getMinutes():date.getMinutes(),
            s = date.getSeconds()<10?"0"+date.getSeconds():date.getSeconds();
        if(apm == "AM"){ //上午
            h = date.getHours()<10?"0"+date.getHours():date.getHours();
        }else{ //下午
            h = date.getHours()+12;
        }
        if(bool){
            return y+"-"+m+"-"+d+" "+h+":"+min+":"+s;
        }else{
            return y+"-"+m+"-"+d+" "+h+":"+min;
        }
    }

    /**
     * 已支付订单：退款操作
     * @param orderId - 订单id
     */
    function refund(orderId) {
        $.ajax({
            url: "${ctx}/wechat/order/refund",
            type: "POST",
            dataType: "json",
            data: {"orderId": orderId.toString()},
            success: function (data) {
                if (data.code == 200) {
                    alert(data.message);
                    $('#paid').click();
                } else {
                    alert(data.message);
                }
            },
            error: function () {
                alert("系统繁忙，请稍后再试");
            }
        });
    }

    /**
     * 待支付订单：去支付
     * @param orderId - 订单id
     */
    function rePay(orderId) {
        var config = {
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

        $.ajax({
            url: "${ctx}/wechat/pay",
            type: "POST",
            dataType: "json",
            data: {"ordersId": orderId},
            success: function (data) {
                if (data.code == 200) {
                    var payConfig = data.entity;

                    wx.ready(function () {
                        wx.chooseWXPay({
                            timestamp: payConfig.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                            nonceStr: payConfig.nonceStr, // 支付签名随机串，不长于 32 位
                            package: payConfig.packageInfo, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
                            signType: payConfig.signType, // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                            paySign: payConfig.paySign, // 支付签名
                            success: function (res) {
                                location.href = "${ctx}/wechat/mine/showMinePage";
                            }
                        });
                    })
                } else {
                    alert(data.message);
                }
            },
            error: function () {
                alert("系统繁忙，请稍后再试");
            }
        });
    }

    //判断是否是电脑端
    function IsPC() {
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                flag = false;
                break;
            }
        }
        return flag;
    }
</script>
</body>
</html>