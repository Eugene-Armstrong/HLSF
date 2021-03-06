<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>活动报名</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css?v=">
    <style>
        .weui-cells__title {margin: 0.77em 0  }
        a {color: #679aff}
        .return {
            position: absolute;
            left: 10px;
            width: 20px;
            height: 20px;
            background: url("${ctx}/images/return.png");
            background-size: cover;
        }
        #add {
            position: absolute;
            right: 10px;
            width: 24px;
            height: 24px
        }

        /*移除*/
        .weui-badge {
            cursor: pointer;
            z-index: 9;
            position: absolute;
            top: -10px;
            right: 15px;
            padding: 15px 10px;
            border-radius: 50%;
        }

        /*户外装备*/
        .swiper-container {padding: 10px 0 15px 0}
        .weui-flex__item img{
            margin: 5px 0;
            min-height: 100px;
        }
        .swiper-slide .weui-flex__item {
            margin:0 5px;
            text-align: center
        }
        .my-price {
            position: relative;
            float: right;
            z-index: 999;
            margin-top: -50px;
            width: 50px;
            height: 30px;
            line-height: 30px;
            font-size: 12px;
            background: rgba(0, 0, 0, 0.5);
            border-radius: 50%;
            color: #fff;
        }
        nobr {font-size: 10px}
        nobr button:first-child {float: left}
        nobr button:last-child {float: right}
        .equip-sub{
            float:left;
            width:28px;
            height: 28px;
            background: url('${ctx}/images/equip-sub.png');
            background-size: cover
        }
        .equip-plus{
            float:right;
            width:28px;
            height: 28px;
            background: url('${ctx}/images/equip-plus.png');
            background-size: cover
        }
        .equip-num{font-size: 14px}

        /*积分*/
        .points{
            background: #ff2728;
            color: #fff;
            padding: 2px 5px;
            border-radius: 5px;
        }
        /*商品查看大图*/
        .weui-photo-browser-modal {z-index: 99}
        .weui-cells {
            margin-top: 10px;
            overflow: inherit;
        }
        .weui-cells:after, .weui-cells:before{border: none}
        .weui-cells_form,
        .weui-cells_radio,
        .weui-cells_checkbox{margin:15px;border-radius: 10px}
        .weui-cell{height: 44px;padding: 0 15px}
        /*支付*/
        .weui-cell__bd{display: inherit}
        .weui-cell__bd img{width: 20px;height: 20px;margin-right: 10px}
        .my-bar {
            max-width: 500px;
            font-size: 16px;
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 50px;
            background: #ffffff;
            border-top: 1px solid #eaeaea;
            z-index: 98
        }
        .total-cost {
            width: 60%;
            float: left;
            line-height: 50px;
            padding: 0 15px;
        }
        .total-cost span {color: #679aff;}
        .my-pay-btn {
            position: absolute;
            right: 0;
            width: 40%;
            height: 100%;
            background: #bbb;
            text-align: center;
            line-height: 50px;
            color: #ffffff;
            cursor: pointer;
        }
        .is-disclaimed{background: #679aff}
        /*表单错误*/
        .check-error{border: 1px solid red;}

        /* 插入常用人*/
        .weui-popup__modal{position: relative;max-width: 500px;margin: 0 auto}
        .my-tip{
            z-index: -1;
            text-align: center;
            margin-top: 70px;
            line-height: 30px;
            color: #999
        }
        /*popup*/
        .weui-popup__container{z-index: 999}
        .weui-popup__container .weui-cells{
            border: 2px solid #fff;
            margin: 15px;
        }
        .weui-popup__container .weui-btn_mini{line-height: 21px}
        .confirm{
            cursor: pointer;
            position: absolute;
            right: 10px;
        }
        .weui-tab__bd img{width: 100%}
        /*选择*/
        .select-user {
            z-index: 998;
            background: #ddd;
            position: absolute;
            top: -10px;
            right: 15px;
            line-height: 16px;
            padding: 15px 10px;
            border-radius: 50%;
            color: #fff;
        }
        .ic-selected{background: #679aff}
        .user-selected{border: 2px solid #679aff!important;} /*选中常用人*/
        .existed .weui-cell__bd{color: #999}
        /*.real-name{width: 50%}*/
        .weui-agree{padding:0 10px;display: inline}
        .weui-agree__checkbox{
            top: 5px;
            border: 3px solid #679aff;
            border-radius: 0;
            width: 20px;
            height: 20px;
        }
        .weui-agree__checkbox:checked:before{
            background: #679aff;
            color: #fff;
            font-size: 22px;
        }
    </style>
</head>
<body>
<div class="page-title">
    <a href="javascript:history.back()" class="return"></a>
    填写参与活动者信息
    <img src="${ctx}/images/p-add.png" id="add">
</div>
<div class="weui-cells__title" style="margin-top: 50px">
    参与者信息
    <a class="open-popup" data-target="#frequent-user"
       style="float: right;cursor: pointer">插入常用人</a>
</div>
<%--填写参与者信息--%>
<form action="">
    <div class="weui-cells weui-cells_form to-submit">
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">姓名</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must real-name" type="text" placeholder="请填写真实姓名" value="" required>
                <span class="weui-badge">移除</span>
            </div>
        </div>
        <div class="weui-cell weui-cell_select weui-cell_select-after">
            <div class="weui-cell__hd">
                <label class="weui-label">性别</label>
            </div>
            <div class="weui-cell__bd">
                <select class="weui-select" name="aim">
                    <option value="1">男</option>
                    <option value="2">女</option>
                </select>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">年龄</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must age" type="number" placeholder="请输入年龄" value="" required>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">手机</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must phone" type="tel" placeholder="请输入手机号" value="" required>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">身份证</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must id-card" type="text" placeholder="输入身份证号(用于买保险)" value="" required>
            </div>
        </div>
        <div class="weui-cell weui-cell_select weui-cell_select-after">
            <div class="weui-cell__hd">
                <label class="weui-label">费用</label>
            </div>
            <div class="weui-cell__bd">
                <select class="weui-select" name="cost">
                    <c:if test="${productDetail.activityVoList.get(0).onSalePrice != null}">
                        <option value="onSalePrice">优惠价：${productDetail.activityVoList.get(0).onSalePrice * 0.01}元</option>
                    </c:if>
                    <c:if test="${productDetail.activityVoList.get(0).onSalePrice == null}">
                        <option value="price">原价：${productDetail.activityVoList.get(0).price * 0.01}元</option>
                        <c:forEach items="${promotionList}" var="pro">
                            <option value="${pro.id}">${pro.detail}：${pro.rule * productDetail.activityVoList.get(0).price * 0.01}元</option>
                        </c:forEach>
                    </c:if>
                </select>
            </div>
        </div>
    </div>
    <div class="weui-cells weui-cells_form other-info">
        <div class="weui-cell weui-cell_select weui-cell_select-after">
            <div class="weui-cell__hd">
                <label class="weui-label">集合地点</label>
            </div>
            <div class="weui-cell__bd">
                <select class="weui-select" name="gather">
                    <c:forEach items="${gatherPlaces}" var="g">
                        <option value="${g}">${g}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">备注</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input remark" placeholder="请填写备注(选填)" required>
            </div>
        </div>
    </div>
</form>
<c:if test="${equipmentList.size() > 0}">
    <div class="weui-cells__title">户外装备(点击可查看大图)</div>
    <div class="weui-cells weui-cells_form">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <c:forEach items="${equipmentList}" var="equip">
                    <div class="swiper-slide">
                        <div class="weui-flex">
                            <div class="weui-flex__item">
                                <input type="hidden" class="equip-id" value="${equip.id}">
                                <p>${equip.name}</p>
                                    <img src="/photo/equip/${equip.picUrl}" alt="">
                                <div class="my-price">￥${equip.price * 0.01}</div>
                                <nobr>
                                    <div class="equip-sub"></div>
                                    <span class="equip-num">0</span>
                                    <div class="equip-plus"></div>
                                </nobr>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</c:if>
<div class="weui-cells__title">支付方式</div>
<div class="weui-cells weui-cells_radio">
    <label class="weui-cell weui-check__label" for="微信">
        <div class="weui-cell__bd">
            <img src="${ctx}/images/pay_weixin.png">
            <p>微信支付</p>
        </div>
        <div class="weui-cell__ft">
            <input type="radio" class="weui-check" name="pay" id="微信" checked="checked">
            <span class="weui-icon-checked"></span>
        </div>
    </label>
    <%--<label class="weui-cell weui-check__label" for="支付宝">--%>
        <%--<div class="weui-cell__bd">--%>
            <%--<img src="${ctx}/images/pay_alipay.png">--%>
            <%--<p>支付宝</p>--%>
        <%--</div>--%>
        <%--<div class="weui-cell__ft">--%>
            <%--<input type="radio" name="pay" class="weui-check" id="支付宝">--%>
            <%--<span class="weui-icon-checked"></span>--%>
        <%--</div>--%>
    <%--</label>--%>
    <%--<label class="weui-cell weui-check__label" for="银联卡">--%>
        <%--<div class="weui-cell__bd">--%>
            <%--<img src="${ctx}/images/pay_yinlian.png">--%>
            <%--<p>银联卡</p>--%>
        <%--</div>--%>
        <%--<div class="weui-cell__ft">--%>
            <%--<input type="radio" name="pay" class="weui-check" id="银联卡">--%>
            <%--<span class="weui-icon-checked"></span>--%>
        <%--</div>--%>
    <%--</label>--%>
</div>
<div class="weui-cells__title">优惠抵扣 (1000积分可兑换1元)</div>
<div class="weui-cells weui-cells_checkbox">
    <label class="weui-cell weui-check__label" for="discount">
        <div class="weui-cell__bd">
                <p>使用积分 <span class="points">现有 ${userDetail.integral} 积分</span></p>
        </div>
        <div class="weui-cell__hd">
            <input type="checkbox" class="weui-check" name="bonusPoints" id="discount">
            <i class="weui-icon-checked"></i>
        </div>
    </label>
</div>
<div class="weui-cells__title" style="margin-bottom: 70px">
    <label for="agree" class="weui-agree">
        <input id="agree" type="checkbox" class="weui-agree__checkbox">
        <span> 我已阅读并同意</span>
    </label>
    <a href="${ctx}/wechat/WxProductDetail/toDisclaimerPage?productId=${productDetail.id}">
        活动提示与免责声明
    </a>
</div>
<div class="my-bar">
    <div class="total-cost">
        总费用：<span><b id="total-cost"></b></span> 元
    </div>
    <label class="my-pay-btn">支付</label>
</div>
<%--插入常用人--%>
<div id="frequent-user" class="weui-popup__container">
    <div class="weui-popup__overlay"></div>
    <div class="weui-popup__modal">
        <div class="page-title">
            <a class="return close-popup"></a>
            插入常用人
            <span class="weui-btn weui-btn_mini weui-btn_primary confirm close-popup">确定</span>
        </div>
        <div class="my-tip">
            亲~您还没添加常用人哦<br>
        </div>
        <div style="margin-top: -60px">
            <!--已添加常用人-->
            <c:forEach items="${contactList}" var="con">
                <div class="weui-cells weui-cells_form existed">
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">真实姓名</label></div>
                        <div class="weui-cell__bd">
                            <span class="weui-input real-name">${con.name}</span>
                            <span class="select-user">选择</span>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">性别</label></div>
                        <div class="weui-cell__bd">
                            <span class="weui-input sex">${fns:getDictLabel('sex',con.sex ,'')}</span>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">年龄</label></div>
                        <div class="weui-cell__bd">
                            <span class="weui-input age">${con.age}</span>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">手机</label></div>
                        <div class="weui-cell__bd">
                            <span class="weui-input phone">${con.phone}</span>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">身份证</label></div>
                        <div class="weui-cell__bd">
                            <span class="weui-input id-card">${con.certId}</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/swiper.min.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        if(IsPC()){alert("请在手机微信上进行支付，谢谢！")}
        // 微信支付
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


        //总费用
        var $totalCost = $("#total-cost");
        //总费用（基础价格）
        var beginCost = Number(Number(${productDetail.activityVoList.get(0).price * 0.01}).toFixed(2));
        $totalCost.text(beginCost);

        //选择基础价格
        var before;
        $(document).on("change","select",function () {
            //变更之后当前价格
            var current = parseInt(parseInt($(this).find("option:selected")
                .text().replace(/[^0-9\.]+/g,"")).toFixed(2));

            //当前总费用
            var totalCost = Number(Number($totalCost.text()).toFixed(2));

            //总费用更新
            totalCost = sub(add(totalCost,current),before);
            $totalCost.text(totalCost);

        }).on("click","select",function () {
            //变更之前的基础价格
            before = Number(Number($(this).find("option:selected")
                .text().replace(/[^0-9\.]+/g,"")).toFixed(2));
        });

        //添加参与者
        var info = $(".weui-cells_form:first").prop("outerHTML");
        $(".weui-badge:first").hide();
        $("#add").click(function () {
            if($(".to-submit").length > 4){
                alert("报名人数最多为5人");
            }else{
                $(".other-info").before(info);
                var totalCost = Number(Number($totalCost.text()).toFixed(2));
                totalCost = add(totalCost,beginCost);
                $totalCost.text(totalCost); //总费用累加 基础价格
            }
        });

        //新增参与者删除
        $(document).on("click", ".weui-badge", function () {
            var $ppp = $(this).parent().parent().parent();
            var totalCost = Number(Number($totalCost.text()).toFixed(2));
            totalCost = sub(totalCost,Number(Number($ppp.find("select").find("option:selected")
                .text().replace(/[^0-9\.]+/g,"")).toFixed(2)));
            $ppp.remove();
            $totalCost.text(totalCost); //总费用累减 基础价格
        })
            .on("change","#discount",function () {
                var totalCost = Number(Number($totalCost.text()).toFixed(2)),
                    points = Number((Number($(".points").text().replace(/[^0-9\.]+/g,""))).toFixed(2));
                var p = (points - (points % 1000))/1000;
                if($(this).is(":checked")){
                    if(p >= 1){
                        alert("积分满1000抵1元，现可兑换金额为"+p+"元");
                        totalCost = sub(totalCost,p); //启动积分兑换
                        $totalCost.text(totalCost);
                    }else{
                        alert("您的积分不足1000，暂时无法兑换哦");
                        $(this).prop("checked",false);
                    }
                }else{
                    totalCost = add(totalCost,p); //取消积分兑换
                    $totalCost.text(totalCost);
                }
            });

        //选择常用人
        $(".select-user").click(function () {
            var $self = $(this);
            if ($self.text() === "选择")
                $self.text("已选");
            else
                $self.text("选择");
            $self.toggleClass("ic-selected");
            $self.parent().parent().parent().toggleClass("user-selected")
        });

        $(document).on("click",".confirm",function () { // 确认插入
            var totalCost = Number(Number($totalCost.text()).toFixed(2));
            $(".user-selected").each(function () {
                var check = true;
                var name = $(this).find(".real-name").text(),
                    age = $(this).find(".age").text(),
                    sex = $(this).find(".sex").text()=="男"?"1":"2",
                    phone = $(this).find(".phone").text(),
                    idCard = $(this).find(".id-card").text();
                $(".to-submit").each(function () {
                    var $name = $(this).find(".real-name"),
                        $sex = $(this).find("select"),
                        $age = $(this).find(".age"),
                        $phone = $(this).find(".phone"),
                        $idCard = $(this).find(".id-card");
                    if($idCard.val()===""){ //身份证号为空时，则当前插入
                        $name.val(name);
                        $sex.find("option[value="+sex+"]").attr("selected",true);
                        $age.val(age);
                        $phone.val(phone);
                        $idCard.val(idCard);
                        check = false;
                        return false;
                    }else{
                        if($idCard.val()===idCard){ //身份证不为空，但重复时，阻止插入
                            alert("同一身份证号不能重复插入，请仔细核对");
                            check = false;
                            return false;
                        }
                    }
                });
                if(check){ //新增插入
                    $(".other-info").before("<div class='weui-cells weui-cells_form to-submit'>" +
                        "<div class='weui-cell'>" +
                        "<div class='weui-cell__hd'><label class='weui-label'>真实姓名</label></div>" +
                        "<div class='weui-cell__bd'>" +
                        "<input class='weui-input must real-name' type='text' placeholder='请输入真实姓名' value='"+name+"' required>" +
                        "<span class='weui-badge'>移除</span></div></div>" +
                        "<div class='weui-cell weui-cell_select weui-cell_select-after'>" +
                        "<div class='weui-cell__hd'><label class='weui-label'>性别</label></div>" +
                        "<div class='weui-cell__bd'><select class='weui-select' name='aim'>" +
                        "<option value='1'>男</option>" +
                        "<option value='2'>女</option></select></div></div>"+
                        "<div class='weui-cell'>" +
                        "<div class='weui-cell__hd'><label class='weui-label'>年龄</label></div>" +
                        "<div class='weui-cell__bd'>" +
                        "<input class='weui-input must age' type='number' placeholder='请输入年龄' value='"+age+"' required></div></div>" +
                        "<div class='weui-cell'>" +
                        "<div class='weui-cell__hd'><label class='weui-label'>手机</label></div>" +
                        "<div class='weui-cell__bd'>" +
                        "<input class='weui-input must phone' type='tel' placeholder='请输入手机号' value='"+phone+"' required></div></div>" +
                        "<div class='weui-cell'>" +
                        "<div class='weui-cell__hd'><label class='weui-label'>身份证</label></div>" +
                        "<div class='weui-cell__bd'>" +
                        "<input class='weui-input must id-card' type='text' placeholder='请输入身份证号(与姓名对应)' value='"+idCard+"' required>" +
                        "</div></div>" +
                        "<div class='weui-cell weui-cell_select weui-cell_select-after'>" +
                        "<div class='weui-cell__hd'>" +
                        "<label class='weui-label'>费用</label></div>" +
                        "<div class='weui-cell__bd'>" +
                        "<select class='weui-select' name='cost'>" +
                        "<c:if test='${productDetail.activityVoList.get(0).onSalePrice != null}'>"+
                        "<option value='onSalePrice'>优惠价：${productDetail.activityVoList.get(0).onSalePrice * 0.01}元</option>"+
                        "</c:if><c:if test='${productDetail.activityVoList.get(0).onSalePrice == null}'>"+
                        "<option value='price'>原价：${productDetail.activityVoList.get(0).price * 0.01}元</option>"+
                        "<c:forEach items='${promotionList}' var='pro'>"+
                        "<option value='${pro.id}'>${pro.detail}：${pro.rule * productDetail.activityVoList.get(0).price * 0.01}元</option>"+
                        "</c:forEach></c:if> </select></div></div></div>");
                    totalCost = add(totalCost,beginCost);
                }
            });
            $totalCost.text(totalCost); //总费用累加 基础价格
        });

        //焦点轮播图
        var _w, $swiper = $(".swiper-container"),
            $obj = $swiper.find(".weui-flex__item img");
        $swiper.swiper({
            autoplay: 5000,
            slidesPerView: 3,//预览幅数
            onInit:function (swiper) {
                _w = $obj.width();
            }
        });
        $obj.css("height",_w);

        //户外装备商品增减
        $(".equip-sub").click(function () {
            var next = Number(Number($(this).next().text()).toFixed(2)),
                price = Number(Number($(this).parent().prev().text().replace("￥","")).toFixed(2)),
                totalCost = Number(Number($totalCost.text()).toFixed(2));
            if (next > 0) {
                next--;
                totalCost = sub(totalCost,price);
                $(this).next().text(next.toString());
                $totalCost.text(totalCost);
            }
        });
        $(".equip-plus").click(function () {
            var prev = Number(Number($(this).prev().text()).toFixed(2)),
                price = Number(Number($(this).parent().prev().text().replace("￥","")).toFixed(2)),
                totalCost = Number(Number($totalCost.text()).toFixed(2));
            totalCost = add(totalCost,price);
            prev++;
            $(this).prev().text(prev.toString());
            $totalCost.text(totalCost);
        });

        //点击图片查看大图
        $(".swiper-slide img").click(function () {
            $.photoBrowser({
                items: [{
                    image: $(this).attr("src"),
                    caption: $(this).attr("alt")
                }]
            }).open();
        });

        //表单同步验证
        $(document).delegate(".must","blur",function () {
            if($(this).val() === ""){
                $.toast.prototype.defaults.duration = 1500; //toast时间
                $.toast($(this).parent().prev().find(".weui-label").text() + "不能为空哦","cancel");
                $(this).addClass("check-error");
                return false;
            }else {
                var val;
                if($(this).attr("class").indexOf("phone")!==-1){ //手机
                    var phone = /^(?:13\d|14\d|15\d|17\d|18\d|19\d)\d{5}(\d{3}|\*{3})$/;
                    val = $(this).val();
                    if(!phone.test(val)){
                        $.toast.prototype.defaults.duration = 1500; //toast时间
                        $.toast("请输入有效的手机号","cancel");
                        $(this).addClass("check-error");
                    }else {
                        $(this).removeClass("check-error");
                    }
                }else if($(this).attr("class").indexOf("id-card")!==-1){ //身份证
                    var ID = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                    val = $(this).val();
                    if(!ID.test(val)){
                        $.toast.prototype.defaults.duration = 1500; //toast时间
                        $.toast("请输入有效的身份证号","cancel");
                        $(this).addClass("check-error");
                    }else{
                        $(this).removeClass("check-error");
                    }
                }else {
                    $(this).removeClass("check-error");
                }
            }
        });

        //免责声明勾选项
        var $payBtn = $(".my-pay-btn");
        $(document).on("click","#agree",function () {
            $payBtn.toggleClass("is-disclaimed");
        });

        //点击支付
        $payBtn.click(function () {
            if(!IsPC()){
                console.log("手机端");
                var isDisclaimed;
                if($("#agree").is(":checked")){
                    isDisclaimed = true;
                }
                if(isDisclaimed){
                    $(".must").each(function () {
                        if ($(this).val().length === 0){
                            $.toast.prototype.defaults.duration = 1500; //toast时间
                            $.toast($(this).parent().prev().find(".weui-label").text()+"不能为空哦","cancel");
                            $(this).addClass("check-error").focus();
                            return false;
                        }
                    });
                    var errorCheck = 0;
                    $(".check-error").each(function () {
                        errorCheck++;
                        $(this).focus();
                        return false;
                    });

                    //没有错误，验证通过
                    if(errorCheck === 0){

                        // 参与者信息与价格
                        var participants = [],_numberCheck=0;
                        $(".to-submit").each(function () {
                            var name = $(this).find(".real-name").val(),
                                sex = $(this).find("select").find("option:selected").val(),
                                age = $(this).find(".age").val(),
                                phone = $(this).find(".phone").val(),
                                idCard = $(this).find(".id-card").val(),
                                price = Number(Number($(this).find("option:selected").text()
                                    .replace(/[^0-9\.]+/g,"")).toFixed(2)),
                                priceID = $(this).find("select").find("option:selected").val();
                            participants.push({
                                "name":name,
                                "sex":sex,
                                "age":age,
                                "phone":phone,
                                "idCard":idCard,
                                "price":price,
                                "priceID":priceID
                            });
                            _numberCheck++;
                        });
                        var _totalNumber = ${productDetail.activityVoList.get(0).totalNumber},
                            _enrollNumber = ${productDetail.activityVoList.get(0).num},
                            _leftNumber = _totalNumber - _enrollNumber;
                        if(_numberCheck > _leftNumber){
                            alert("当前活动的仅剩"+_leftNumber+"个名额，请检查报名人数");
                        }else{
                            // 户外装备
                            var equips = [];
                            $(".equip-id").each(function () {
                                var equipNum = Number($(this).parent().find(".equip-num").text());
                                if(equipNum > 0){
                                    equips.push({
                                        "equipId":$(this).val(),
                                        "number": equipNum
                                    })
                                }
                            });

                            // 支付方式
                            var payWay = "";
                            $("input[name=pay]").each(function () {
                                if($(this).is(":checked")){
                                    payWay = $(this).attr("id");
                                }
                            });

                            // 积分余额
                            var bonusPoints;
                            var points = Number((Number($(".points").text().replace(/[^0-9\.]+/g,""))).toFixed(2)),
                                p = (points - (points % 1000))/1000;
                            if($("#discount").is(":checked")){
                                if(p >= 1){
                                    bonusPoints = points % 1000;
                                }else{
                                    bonusPoints = points;
                                }
                            }else{
                                bonusPoints = points;
                            }

                            // 总费用
                            var finalCost = Number(Number($("#total-cost").text()).toFixed(2));

                            //测试
                            console.log(participants);
                            console.log(equips);
                            console.log("\n支付方式："+payWay+ "\n积分余额："+bonusPoints+
                                "\n总费用："+finalCost);

                            $.ajax({
                                type: "post",
                                url: "${ctx}/wechat/WxProductDetail/userPaiedOrder", // 请求处理页
                                dataType: "json",
                                traditional:true,
                                data: {
                                    "participants":JSON.stringify(participants),
                                    "gatherPlace":$("select[name=gather]").find("option:selected").val(),
                                    "remark":$(".remark").val(),
                                    "equips":JSON.stringify(equips),
                                    "payWay":payWay,
                                    "points":bonusPoints,
                                    "totalCost":finalCost
                                },
                                beforeSend:function(){
                                    $.showLoading();
                                    $(".weui-toast_content").text("支付申请中");
                                    setTimeout(function() {$.hideLoading()}, 1000);
                                },
                                success: function (result) {
                                    if (result.code == 200) {
                                        var payConfig = result.entity;

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
                                        alert("系统繁忙");
                                    }
                                }
                                ,error: function() {
                                    alert("系统繁忙，请稍后再试！");
                                }
                            });
                        }
                    }
                }else{
                    alert("请先阅读并勾选同意免责声明");
                }
            }
            else{
                console.log("电脑端");
                alert("请在手机微信上进行支付，谢谢！")
            }

        });
    });

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
    //加法
    function add(a, b) {
        var c, d, e;
        try {
            c = a.toString().split(".")[1].length;
        } catch (f) {
            c = 0;
        }
        try {
            d = b.toString().split(".")[1].length;
        } catch (f) {
            d = 0;
        }
        return e = Math.pow(10, Math.max(c, d)), (mul(a, e) + mul(b, e)) / e;
    }
    //减法
    function sub(a, b) {
        var c, d, e;
        try {
            c = a.toString().split(".")[1].length;
        } catch (f) {
            c = 0;
        }
        try {
            d = b.toString().split(".")[1].length;
        } catch (f) {
            d = 0;
        }
        return e = Math.pow(10, Math.max(c, d)), (mul(a, e) - mul(b, e)) / e;
    }
    //乘法
    function mul(a, b) {
        var c = 0,
            d = a.toString(),
            e = b.toString();
        try {
            c += d.split(".")[1].length;
        } catch (f) {}
        try {
            c += e.split(".")[1].length;
        } catch (f) {}
        return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
    }
    //除法
    function div(a, b) {
        var c, d, e = 0,
            f = 0;
        try {
            e = a.toString().split(".")[1].length;
        } catch (g) {}
        try {
            f = b.toString().split(".")[1].length;
        } catch (g) {}
        return c = Number(a.toString().replace(".", "")), d = Number(b.toString().replace(".", "")), mul(c / d, Math.pow(10, f - e));
    }
</script>
</body>
</html>