<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>更多分类-项目分类</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body {
            font-size: 14px;
            padding-bottom:50px;
        }
        /*活动*/
        .my-item {
            font-size: 14px;
            margin-top: 10px;
            padding: 10px 10px 5px 10px;
            background-color: #ffffff
        }

        .my-detail{color: #999}
        table{
            width: 100%;
            font-size: 12px;
            line-height: 30px;
        }
        .my-pic img {width: 100%}
        .weui-navbar__item{
            margin:0;
            padding:5px 18px;
            color: #000;
            cursor: pointer;
            font-size: 12px!important;
        }
        .weui-grids{
            width: 92%;
            padding:10px 4%;
            background: #fafafa;
            position: fixed;
            top: 0;
            z-index: 2;
            border-bottom: 5px solid #eee;
            max-width: 450px;
        }
        .weui-grid{width: 25%;padding:4px 8px;margin:4px 0;border: 1px solid #fafafa}
        .highlight{border: 1px solid #37a1ff;color:#679aff;border-radius: 5px}
        .empty-tip {
            margin-top: 50px;
            text-align: center;
            color: #aaa;
        }
        .empty-tip img {
            width: 50%;
            max-width: 300px;
        }
    </style>
</head>
<body>
<!--导航-->
<div class="weui-grids">
    <%--href="${ctx}/wechat/sort/ShowProductBySort?classId=${sort.id}&cityId=${cityId}#tab${status.index + 1}"--%>
    <c:forEach items="${sortList}" var="sort" varStatus="status">
        <a id="${sort.id}" class="weui-navbar__item weui-grid">${sort.name}</a>
    </c:forEach>
</div>
<!--对应内容-->
<div id="showProduct"></div>
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
        // 根据锚点跳转导航对应的内容
        var _hash = window.location.hash,
            _index = Number(_hash.replace(/[^0-9\.]+/g,""))-1,
            $nav = $(".weui-grid:eq("+_index+")"),
            $navWrap = $(".weui-grids");

        $("body").css("padding-top",$navWrap.height()+20);
        $nav.addClass("highlight");

        // 进入页面即刻点击
        setTimeout(function () {
            $nav.trigger("click");
        },1);

        var loadingHtml = "<div class='weui-loadmore'><br>" +
            "<i class='weui-loading'></i>" +
            "<span class='weui-loadmore__tips'> 拼命加载中</span></div>",

            emptyHtml = "<div class='empty-tip'>" +
                "<img src='${ctx}/images/offsale.png' alt='哎呀'>" +
                "<br>该分类产品即将上架，去别处逛逛吧~ </div>";
        var req;
        $(document).on("click",".weui-grid",function () {
            console.log($(this).attr("id"));
            var cityId = "${cityId}",
                classId = $(this).attr("id"),
                $showProduct = $("#showProduct");

            $(this).addClass("highlight").siblings().removeClass("highlight");
            if (req != null)
                req.abort();
            req = $.ajax({
                type:"post",
                url:"${ctx}/wechat/sort/ShowProductBySortInfo",
                data:{cityId:cityId,classId:classId},
                dataType:"json",
                beforeSend:function(XMLHttpRequest){
                    $showProduct.html(loadingHtml);
                },
                success:function (data) {
                    $showProduct.html("");
                    var str = "";
                    if (data.length == 0){
                        $showProduct.html(emptyHtml);
                    }
                    for(var i = 0;i<data.length;i++){
                        var _score = Number(Number(data[i].product.productAvgVote).toFixed(2));
                        str += "<div class='my-item'>" +
                        "<a href='${ctx}/wechat/WxProductDetail/getProductDetail?productId="+
                        data[i].product.id +"&cityId=" +cityId+
                            "'>" +
                        "<div class='weui-flex my-pic'>" +
                        "<div class='weui-flex__item'>" +
                        "<img src='/photo/product/"+ data[i].product.picUrl+ "'>" +
                        "</div></div><div class='my-title'>" + data[i].product.name + "</div>" + "</a>";
                        for (var j = 0;j < data[i].activities.length;j++){
                            var _date = new Date(data[i].activities[j].departTime),
                                _month = _date.getMonth()+1,
                                _day = _date.getDate(),
                                _dayCount = data[i].activities[j].days;
                            _month = _month<10?("0"+_month):_month;
                            _day = _day<10?("0"+_day):_day;
                            _dayCount = _dayCount<10?("0"+_dayCount):_dayCount;
                            var state = data[i].activities[j].state;
                            if (j <= 2){
                                str +=
                                    "<a href='${ctx}/wechat/WxProductDetail/getProductDetail?actId="+
                                    data[i].activities[j].id+"&productId="+data[i].product.id+"&cityId=" +cityId+
                                    "'>"+
                                    "<table><tr><td width='38%'>" +_month+"月"+_day+"日 ("+ _dayCount +"天)</td>" +
                                    "<td width='20%'>￥"+ (data[i].activities[j].price * 0.01) +"</td>" +
                                    "<td width='22%' style='text-align: center'>" +
                                    "好评："+ _score +"</td>" +
                                    "<td width='20%' style='text-align: right'>";
                                if(state == "未成行"){
                                    str += "<span class='my-status-1'>未成行</span>";
                                }else if(state == "已成行"){
                                    str += "<span class='my-status-2'>已成行</span>";
                                }else if(state == "活动中"){
                                    str += "<span class='my-status-3'>活动中</span>";
                                }else if(state == "已满人"){
                                    str += "<span class='my-status-4'>已满人</span>";
                                }else if(state == "已结束"){
                                    str += "<span class='my-status-5'>已结束</span>";
                                }
                                str += "</td></tr></table></a>";
                            }else {
                                if (j == 3){
                                    str += "<div class='my-hidden'>";
                                }
                                str +=
                                    "<a href='${ctx}/wechat/WxProductDetail/getProductDetail?actId="+
                                    data[i].activities[j].id+"&productId="+data[i].product.id+"&cityId=" +cityId+
                                    "'>"+
                                    "<table><tr><td width='38%'>" +_month+"月"+_day+"日 ("+ _dayCount +"天)</td>" +
                                    "<td width='20%'>￥"+ (data[i].activities[j].price * 0.01) +"</td>" +
                                    "<td width='22%' style='text-align: center'>" +
                                    "好评："+_score+"</td>" +
                                    "<td width='20%' style='text-align: right'>";
                                if(state == "未成行"){
                                    str += "<span class='my-status-1'>未成行</span>";
                                }else if(state == "已成行"){
                                    str += "<span class='my-status-2'>已成行</span>";
                                }else if(state == "活动中"){
                                    str += "<span class='my-status-3'>活动中</span>";
                                }else if(state == "已满人"){
                                    str += "<span class='my-status-4'>已满人</span>";
                                }else if(state == "已结束"){
                                    str += "<span class='my-status-5'>已结束</span>";
                                }
                                str += "</td></tr></table></a>";
                            }
                        }
                        if (data[i].activities.length > 3){
                            str += "</div>";
                            str += "<div class='my-spread-down'>(｡･ω･｡) 还有" +
                                (data[i].activities.length-3)+ "期活动哟~点击展开</div>" +
                                "<div class='my-spread-up'>点击收起 ↑</div>";
                        }
                        str += "</div>"
                    }
                    if (str !== null){
                        $showProduct.append(str);
                    }
                }
            })
        });
    })
</script>
</body>
</html>