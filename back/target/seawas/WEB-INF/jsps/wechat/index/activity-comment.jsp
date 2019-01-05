<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>活动评价</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body {
            font-size: 3vw;
            color: #999;
            padding-bottom: 60px;
        }
        .my-detail{color:#999}
        /*评分*/
        .rating{
            float: left;
            line-height: 8vw;
        }
        .rating-item{
            width: 8vw;
            height: 8vw;
            padding: 0 1.5vw
        }
        .my-panel{
            background: #fff;
            overflow: hidden;
            padding: 3vw 4vw 0 4vw;
            font-size: 3vw;
        }
        .weui-cells{font-size: 3vw;margin-top: 0;padding-bottom: 3vw}
        .weui-cells:before,.weui-cell:before{border-top: none}
        .weui-cells .weui-cell__bd{
            border-radius: 5px;
            padding: 10px;
            background: #f4f4f4
        }
        textarea{background: #f4f4f4}
        .weui-btn{
            width: auto!important;
            margin:2vw auto;
            font-size: 3.5vw;
            border-radius: 10vw;
            padding: 0 9vw;
        }
        .weui-media-box_appmsg{
            background: url("${ctx}/images/score-banner.jpg") center no-repeat;
            background-size:200% 100%;;
            padding: 1vw 4vw;
        }
        .weui-media-box_appmsg .weui-media-box__hd{
            padding: 10px;
            text-align: center;
            height: auto;
            line-height: inherit;
            color: #fff;
            width: 15%;
        }
        .weui-media-box_appmsg .weui-media-box__hd img{
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }
        .weui-media-box__desc{
            line-height: 6vw;
            color: #fff;
            font-size: 3vw;
            padding-bottom: 3vw;
        }
        .weui-tabbar{position: fixed;border-bottom: 0}
        .weui-panel__hd{background: #fff;margin-top: 2vw}
        .current-len{color: #333}
    </style>
</head>
<body>
<!--版头-->
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__bd">
        <a class="weui-media-box weui-media-box_appmsg">
            <div class="weui-media-box__hd">
                <img class="weui-media-box__thumb" src="${orders.user.headImgUrl}">
                <nobr>${orders.user.nickName}</nobr>
            </div>
            <div class="weui-media-box__bd">
                <p class="weui-media-box__desc">
                    本次活动已结束，您的积分+${orders.integral}<br>
                    海浪山风邀请您对本次活动进行评价：
                </p>
            </div>
        </a>
    </div>
</div>
<!--参与活动-->
<div class="weui-panel__hd">本次参与活动</div>
<div class="my-item">
    <div class="weui-flex my-pic">
        <div class="weui-flex__item">
            <img src="/photo/product/${orders.activity.product.picUrl}">
        </div>
    </div>
    <div class="weui-flex">
        <div class="weui-flex__item">${orders.activity.product.name}</div>
    </div>
    <div>
        <span class="my-detail"><fmt:formatDate value="${orders.activity.endTime}"
                                                pattern="yyyy-MM-dd HH:mm" /></span>
        <span class="my-status-3">已结束</span>
    </div>
</div>
<!--评分-->
<div class="my-panel">
    <div class="rating">产品满意度：</div>
    <div id="productScore" class="rating">
        <img class="rating-item" title="很不好">
        <img class="rating-item" title="不好">
        <img class="rating-item" title="一般">
        <img class="rating-item" title="好">
        <img class="rating-item" title="很好">
    </div>
    <div class="rating">领队满意度：</div>
    <div id="leaderScore" class="rating">
        <img class="rating-item" title="很不好">
        <img class="rating-item" title="不好">
        <img class="rating-item" title="一般">
        <img class="rating-item" title="好">
        <img class="rating-item" title="很好">
    </div>
</div>
<!--发表评论-->
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <textarea class="weui-textarea" placeholder="请写下您对本次活动的感受，或者对我们的建议，谢谢。"
                      rows="4" maxlength="300"></textarea>
            <div class="weui-textarea-counter"><span class="current-len">0</span>/300</div>
        </div>
    </div>
    <div style="padding:0 4vw">
        <!--<input type="checkbox" id="nick-name">-->
        <!--<label for="nick-name">匿名评论</label>-->
        <button class="weui-btn weui-btn_primary" id="sendComment">发表评论</button>
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
<script src="${ctx}/js/fastclick.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/swiper.min.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {

        sharpConfig(window.location.href);

        FastClick.attach(document.body);
        $(document).on("input","textarea",function () {
            var currentLen = $(this).val().length;
            $(this).next().find(".current-len").text(currentLen);
        });
        $(".swiper-container").swiper({
            slidesPerView: 2
        });

        //闭包尽量防止全局变量冲突的问题
        var rating = (function () {
            //点亮星星函数声明
            var lightOn = function ($item,num) {
                $item.each(function (index) {
                    if(index < num){
                        $(this).attr("src","${ctx}/images/rating-on.png")
                            .addClass("on");
                    }else{
                        $(this).attr("src","${ctx}/images/rating-off.png")
                            .removeClass("on");
                    }
                })
            };
            /**
             * 函数复用
             * @param selector - 用到评分功能的选择器
             * @param num - 默认评分
             */
            var init = function (selector,num) {
                var $rating = $(selector),
                    $item = $rating.find(".rating-item");

                //初始化评分
                lightOn($item,num);

                //绑定点击评分事件
                $rating.on("click",".rating-item",function () {
                    lightOn($item,$(this).index()+1);
                })
            };
            return {init:init};//返回对象
        })();

        //开始调用评分功能
        rating.init("#productScore",0);
        rating.init("#leaderScore",0);
        var req;
        $(document).on("click","#sendComment",function () {
            var _productScore = 0,
                _leaderScore = 0,
                _commentContent = $("textarea").val();
            $("#productScore").find(".on").each(function () {
                _productScore++;
            });
            $("#leaderScore").find(".on").each(function () {
                _leaderScore++;
            });
            if(_productScore === 0){
                alert("请完成对产品的评分，谢谢");
            }else if(_leaderScore === 0){
                alert("请完成对领队的评分，谢谢");
            } else if(_commentContent === ""){
                alert("评论内容不能为空");
            }else{
                if (req != null)
                    alert("耐性等待，不要重复点击哦");
                else{
                    req =
                        $.ajax({
                            url: "${ctx}/wechat/comment/AddommentIndex",
                            type: "POST",
                            dataType: "json",
                            data: {productScore:_productScore,
                                leaderScore:_leaderScore,
                                textarea:$("textarea").val(),
                                userId:'${orders.user.id}',
                                productId:'${orders.activity.product.id}',
                                activityId:'${orders.activity.id}',
                                orderId:'${orders.id}'
                            },
                            success: function (data) {
                                alert("评价成功！！");
                                window.location.href = "${ctx}/wechat/comment/ShowCommentIndexDetail?orderId=${orders.id}&userId=${orders.user.id}&activityId=${orders.activity.id}"
                            },
                            error:function (e) {
                                alert("系统繁忙，请稍后再试");
                            }
                        });
                }
            }
        })
    })
</script>
</body>
</html>