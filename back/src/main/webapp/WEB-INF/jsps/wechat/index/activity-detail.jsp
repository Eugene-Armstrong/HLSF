<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="now" class="java.util.Date" scope="page"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>活动详情</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css?v=">
    <style>
        body,html{height: 100%;-webkit-overflow-scrolling: touch;}
        /*领队信息*/
        .leader-info {
            font-size: 14px;
            background: #fff;
            padding: 10px 15px;
            color: #333;
            line-height: 20px
        }
        .leader-info p {
            padding: 6px 0 15px 0
        }
        .score{
            color: #999;
            font-size: 12px;
        }
        .original-price{
            color: #999;
            font-size: 10px;
            text-decoration: line-through;
        }
        .discount-price{font-size: 10px}
        .discount-price b{color: #ff2332;font-size: 22px}
        .my-title {
            text-align: left;
            font-size: 16px;
        }
        .head-img {
            margin-right: 5px;
            float: left;
            width: 48px!important;
            height: 48px;
            vertical-align: middle;
            border-radius: 50%;
        }
        .weui-cells{margin-top: 10px;color: #999}
        .weui-cell__hd img{width: 16px;height: 16px;margin-right: 10px}
        /*出发时间*/
        .weui-panel__hd{
            color: #333;
            font-size: 14px;
            padding: 10px 15px;
            overflow: hidden
        }
        .weui-panel__hd b{color:#679aff}
        .weui-panel__hd a{float: right;color: #333}
        .swiper-container,.participant{
            margin: 10px 15px;
            font-size: 12px;
            overflow: hidden;
        }
        .swiper-slide{width: auto!important;text-align: center;float: left}
        .time-info{
            padding: 10px;
            background: #37a1ff;
            border-radius: 8px;
            float: left;
            margin-right: 10px;
            color: #fff;
            opacity: .5;
        }
        .selected{opacity: 1}
        .weui-tab {margin-top: 10px}
        .weui-tab .weui-tab__bd{padding:50px 15px;background: #fff}
        #tab1{margin: 0 15px;overflow-x: hidden;padding-top: 10px}
        #tab2,#tab3,#tab4{overflow-x: hidden;padding-top: 10px}
        /*评价*/
        #tab4::-webkit-scrollbar {display: none}
        .overall-score{
            width: 20vw;
            height: 26vw;
            margin: 5px;
            float: left;
            text-align: center;
            padding: 10px 5px 5px 5px;
            color: #679aff;
            border-radius: 5px;
            border: 2px solid #679aff;
        }
        .overall-score hr{
            border: 1px solid #679aff;
            margin: 2vw 0 1vw 0;
        }
        .score-level{
            margin: 5px 0 5px 5px;
            display: inline-block;
            width: 61vw;
        }
        td{line-height: 5.5vw;color: #999;text-align: center}
        .across-line{
            border: 1px solid #ddd;
            border-top: none;
            margin: 15px 0;
        }
        .user{position: relative}
        .user-info {
            position: absolute;
            width: 20%;
            text-align: center;
        }
        .user-img{
            border-radius: 50%;
            width: 42px;
        }
        .user-name{
            font-size: 12px;
            height:30px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
        }
        .comment-content {
            position: relative;
            margin-left: 20%;
            padding:0 10px;
            font-size: 14px;
        }
        .comment-detail{
            line-height: 25px;
            color: #999;
            font-size: 12px;
        }
        .user-score{
            height: 12px;
            margin-top: 7px;
            margin-right: 2px;
        }
        .admin-reply{
            margin-top: 5px;
            background: #eee;
            padding: 10px 15px;
            border-radius: 5px;
        }
        .admin-name{color: orangered}
        .end-tip{color: #999;line-height: 30px;text-align: center;margin-bottom: 20px}
        /*底部*/
        .my-bar{
            width: 100%;
            max-width: 500px;
            line-height: 50px;
            position: fixed;
            bottom: 0;
            background: #fff;
            font-size: 14px;
            color: #fff;
            z-index: 999;
        }
        .my-bar div{float: left;text-align: center;cursor: pointer;font-size: 16px}
        .my-bar div:after{border-right: 1px solid #ccc;}
        .weui-popup__container{z-index: 999;max-width: 500px;margin: 0 auto}
        .weui-popup__modal{background: #fff;text-align: center}
        .consult-tip{width: 70%;margin: 0 auto;font-size: 14px}
        .collect{cursor: pointer;width: 30px;float: right}
        .weui-btn{border-radius: 0;cursor: pointer;}
        #tab4{font-size: 12px}
        .weui-slider{padding: 0}
        .weui-slider__inner,.weui-slider__track{height: 4px;border-radius: 5px}
        .weui-slider__inner{width: 90%;margin: 0 auto}
        .weui-slider__track{background: orangered}
        .weui-tab img{max-width: 100%}
        .weui-photo-browser-modal .swiper-container{margin: 10px 0}
        .weui-photo-browser-modal{z-index: 999}
        .weui-photo-browser-modal .swiper-slide{width: inherit!important}
        .not-active{width: 50%;background: #bbb;color: #fff;}
        .weui-loadmore{margin-top: 0}
        .more{
            text-align: center;
            font-size: 14px;
            margin-bottom: 30px;
            color: #999;cursor:pointer;
        }
        .weui-loadmore__tips{color: #999}
    </style>
</head>
<body style="overflow-x: hidden">
<!--活动图+名称-->
<div class="weui-flex my-pic">
    <div class="weui-flex__item">
        <img src="/photo/product/${productDetail.picUrl}" style="min-height: 100px">
    </div>
</div>
<div class="my-title">${productDetail.name}</div>
<!--领队信息-->
<div class="leader-info">
    <img src="${productDetail.activityVoList.get(num).activityLeaderList.get(0).user.headImgUrl}" class="head-img">
    <img src="${ctx}/images/collected.png" alt="收藏" class="collect">
    <p>${productDetail.activityVoList.get(num).activityLeaderList.get(0).user.nickName}<br>
        <span class="score">评分：
            <fmt:formatNumber value="${productDetail.activityVoList.get(num).activityLeaderList.get(0).user.score}" pattern="#.0#"/>
            &nbsp;&nbsp;
        </span>
    </p>
    <c:if test="${productDetail.activityVoList.get(num).onSalePrice == null}">
        <span class="discount-price">￥ <b>${productDetail.activityVoList.get(num).price * 0.01}</b> 元/人</span>
    </c:if>
    <c:if test="${productDetail.activityVoList.get(num).onSalePrice != null}">
        <span class="discount-price">￥ <b>${productDetail.activityVoList.get(num).onSalePrice * 0.01}</b> 元/人</span>
        <span class="original-price">(原价￥${productDetail.activityVoList.get(num).price * 0.01})</span>
    </c:if>
    <span style="float: right">
        难度：
        <c:forEach begin="0" end="${productDetail.degreeDifficulty - 1}">
            <img src="${ctx}/images/star-on.png" class="user-score">
        </c:forEach>
    </span>
</div>
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_flag.png">
        </div>
        <div class="weui-cell__bd">出发：
            <fmt:formatDate value="${productDetail.activityVoList.get(num).departTime}" pattern="HH:mm" />
            ${productDetail.activityVoList.get(num).gatherPlace}
        </div>
    </div>
</div>
<!--出发时间-->
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__hd">出发时间</div>
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <c:forEach items="${productDetail.activityVoList}" var="act">
                <div class="swiper-slide">
                    <a href="${ctx}/wechat/WxProductDetail/getProductDetail?actId=${act.id}&productId=${productDetail.id}&cityId=${cityId}">
                        <c:if test="${act.state == '已结束'}">
                            <div class="time-info" style="background: #bbb">
                                <nobr><fmt:formatDate value="${act.departTime}" pattern="MM-dd" />
                                    - <fmt:formatDate value="${act.endTime}" pattern="MM-dd" /></nobr><br>
                                <nobr>已结束 | ${act.tripNumber}人</nobr>
                            </div>
                        </c:if>
                        <c:if test="${act.state != '已结束'}">
                            <div class="time-info">
                                <nobr><fmt:formatDate value="${act.departTime}" pattern="MM-dd" />
                                    - <fmt:formatDate value="${act.endTime}" pattern="MM-dd" /></nobr><br>
                                <nobr>${act.state} | ${act.tripNumber}人</nobr>
                            </div>
                        </c:if>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!--已参加的人数-->
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__hd">
        已参加的人（<b>${productDetail.activityVoList.get(num).tripNumber}</b>人成行）
        <a href="${ctx}/wechat/WxProductDetail/toActivityParticipants?activityId=${productDetail.activityVoList.get(num).id}">总共
            <b>${productDetail.activityVoList.get(num).num}</b>/${productDetail.activityVoList.get(num).totalNumber}人 ▶
        </a>
    </div>
</div>
<!--活动说明-->
<div class="weui-tab">
    <!--导航-->
    <div class="weui-navbar">
        <a class="weui-navbar__item weui-bar__item--on" href="#tab1">活动详情</a>
        <a class="weui-navbar__item" href="#tab2">行程须知</a>
        <a class="weui-navbar__item" href="#tab3">费用说明</a>
        <c:if test="${productDetail.voteNumber > 0}">
            <a class="weui-navbar__item" href="#tab4">评价</a>
        </c:if>
    </div>
    <!--对应内容-->
    <div class="weui-tab__bd">
        <!--活动详情-->
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
            ${productDetail.activityVoList.get(num).productIntroduce}
        </div>
        <!--活动行程-->
        <div id="tab2" class="weui-tab__bd-item">
            ${productDetail.activityVoList.get(num).route}
        </div>
        <!--费用说明-->
        <div id="tab3" class="weui-tab__bd-item">
            ${productDetail.activityVoList.get(num).priceIntroduce}
        </div>
        <!--评价-->
        <c:if test="${productDetail.voteNumber > 0}">
            <div id="tab4" class="weui-tab__bd-item">
                <div class="overall-score">
                    <h3>综合评分</h3><hr>
                    <h1 style="line-height: 10vw"><fmt:formatNumber value="${productDetail.productAvgVote}" pattern="#.0#"/></h1>
                    <span style="line-height:5vw;color: #999;font-size: 12px">${productDetail.voteNumber}人评分</span>
                </div>
                <div class="score-level">
                    <table>
                        <tr>
                            <td width="15%">超赞</td>
                            <td width="80%">
                                <div class="weui-slider">
                                    <div class="weui-slider__inner">
                                        <div style="width:${productDetail.vote5 * 1.0 / productDetail.voteNumber * 100}%" class="weui-slider__track"></div>
                                    </div>
                                </div>
                            </td>
                            <td width="15%"><fmt:formatNumber type="percent"
                                                              maxIntegerDigits="3" value="${productDetail.vote5 * 1.0 / productDetail.voteNumber}" /></td>
                        </tr>
                        <tr>
                            <td width="15%">很好</td>
                            <td width="80%">
                                <div class="weui-slider">
                                    <div class="weui-slider__inner">
                                        <div style="width: ${productDetail.vote4 * 1.0 / productDetail.voteNumber * 100}%" class="weui-slider__track"></div>
                                    </div>
                                </div>
                            </td>
                            <td width="15%"><fmt:formatNumber type="percent"
                                                              maxIntegerDigits="3" value="${productDetail.vote4 * 1.0 / productDetail.voteNumber}" /></td>
                        </tr>
                        <tr>
                            <td width="15%">一般</td>
                            <td width="80%">
                                <div class="weui-slider">
                                    <div class="weui-slider__inner">
                                        <div style="width: ${productDetail.vote3 * 1.0 / productDetail.voteNumber * 100}%" class="weui-slider__track"></div>
                                    </div>
                                </div>
                            </td>
                            <td width="15%"><fmt:formatNumber type="percent"
                                                              maxIntegerDigits="3" value="${productDetail.vote3 * 1.0 / productDetail.voteNumber}" /></td>
                        </tr>
                        <tr>
                            <td width="15%">不好</td>
                            <td width="80%">
                                <div class="weui-slider">
                                    <div class="weui-slider__inner">
                                        <div style="width: ${productDetail.vote2 * 1.0 / productDetail.voteNumber * 100}%" class="weui-slider__track"></div>
                                    </div>
                                </div>
                            </td>
                            <td width="15%"><fmt:formatNumber type="percent"
                                                              maxIntegerDigits="3" value="${productDetail.vote2 * 1.0 / productDetail.voteNumber}" /></td>
                        </tr>
                        <tr>
                            <td width="15%">很差</td>
                            <td width="80%">
                                <div class="weui-slider">
                                    <div class="weui-slider__inner">
                                        <div style="width: ${productDetail.vote1 * 1.0 / productDetail.voteNumber * 100}%" class="weui-slider__track"></div>
                                    </div>
                                </div>
                            </td>
                            <td width="15%"><fmt:formatNumber type="percent"
                                                              maxIntegerDigits="3" value="${productDetail.vote1 * 1.0 / productDetail.voteNumber}" /></td>
                        </tr>
                    </table>
                </div><br><br>
                <div style="color: #999;font-size: 14px">
                    ▶ 热门评论 <span class="my-status-3">Hot</span>
                </div>
                <hr class="across-line">
                <div id="showComment">
                    <%--<div class="user">--%>
                        <%--<div class="user-info">--%>
                            <%--<a href="../mine.html">--%>
                                <%--<img src="${ctx}/images/head-img.jpg" class="user-img" alt="">--%>
                            <%--</a>--%>
                            <%--<div class="user-name">用户名</div>--%>
                        <%--</div>--%>
                        <%--<div class="comment-content">这是评论内容这是评论内容这是评论内容<br>--%>
                            <%--<img src="${ctx}/images/star-on.png" class="user-score">--%>
                            <%--<img src="${ctx}/images/star-on.png" class="user-score">--%>
                            <%--<img src="${ctx}/images/star-on.png" class="user-score">--%>
                            <%--<img src="${ctx}/images/star-on.png" class="user-score">--%>
                            <%--<img src="${ctx}/images/star-on.png" class="user-score"><br>--%>
                            <%--<span class="comment-detail">09月02日出发</span>--%>
                        <%--</div>--%>
                        <%--<div class="admin-reply">--%>
                            <%--<span class="admin-name">后台小姐姐 回复：</span>--%>
                            <%--嘤嘤嘤讨厌啦人家要用小拳头捶你小胸口嘤嘤嘤捶你小胸口--%>
                            <%--捶你小胸口捶你小胸口捶你小胸口捶你小胸口嘤嘤嘤--%>
                        <%--</div>--%>
                        <%--<hr class="across-line">--%>
                    <%--</div>--%>
                </div>
                <div class="end-tip">没有更多评论了</div>
            </div>
        </c:if>
    </div>
</div>
<!--footer-->
<div class="my-bar">
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}">
        <div style="width:25%;color: #fff;background: #86a2f9">
            <img src="${ctx}/images/topbar-home.png"
                 style="width: 14px;vertical-align: middle" alt="☛"> 首页
        </div>
    </a>
    <a class="open-popup" data-target="#qr" style="color: #fff">
        <div style="width: 25%;background:#fdab32">群咨询</div>
    </a>
    <c:if test="${productDetail.activityVoList.get(num).state != '已满人' && productDetail.activityVoList.get(num).closeTime > now}">
        <a href="${ctx}/wechat/WxProductDetail/toEnrollPage?productId=${productDetail.id}&activityId=${productDetail.activityVoList.get(num).id}">
            <div style="width: 50%;background: #37a1ff;color: #fff;">立即报名</div>
        </a>
    </c:if>
    <c:if test="${productDetail.activityVoList.get(num).state == '已满人' && productDetail.activityVoList.get(num).closeTime > now}">
        <a href="javascript:">
            <div class="not-active">已满人</div>
        </a>
    </c:if>
    <c:if test="${productDetail.activityVoList.get(num).closeTime <= now && productDetail.activityVoList.get(num).state != '已结束'}">
        <a href="javascript:">
            <div class="not-active">已截止报名</div>
        </a>
    </c:if>
    <c:if test="${productDetail.activityVoList.get(num).state == '已结束'}">
        <a href="javascript:">
            <div class="not-active">暂无活动</div>
        </a>
    </c:if>
</div>
<div id="qr" class="weui-popup__container" style="display: none;">
    <div class="weui-popup__overlay"></div>
    <div class="weui-popup__modal">
        <a class="weui-btn weui-btn_primary close-popup">返回</a>
        <br><br>欢迎长按二维码<br>加入${productDetail.name}活动群<br><br>
        <img src="/photo/QRCode/${productDetail.activityVoList.get(num).QRCode}"
             style="width: 60%;min-width: 150px;min-height: 150px" alt="（待上传）"><br><br>
        <div class="consult-tip">
            温馨提示：这是公开接受咨询的活动群，无法逐一审核群内用户，小伙伴们请谨慎接受陌生人的好友请求。
        </div>
    </div>
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/swiper.min.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        $(".swiper-container").swiper({slidesPerView: 2});
        $(".time-info").each(function (index) {
            if("${num}"===index.toString()){
                $(this).addClass("selected");
            }
        });
        var $collect = $(".collect"),isCollected = "${isCol}",
            loadingHtml = "<div class='weui-loadmore'>" +
                "<i class='weui-loading'></i>" +
                "<span class='weui-loadmore__tips'> 拼命加载中</span></div>";
        if(isCollected === "true"){
            //原状态为-已收藏
            $collect.attr("src","${ctx}/images/collected.png");
        }
        else{
            //原状态为-未收藏
            $collect.attr("src","${ctx}/images/no-collected.png");
        }

        var pageNum = 1, //当前页码
            isEnd = false, //页码是否结束标志
            $showComment = $("#showComment"); //评论显示区
        var req;
        $(document)
            //点击评价
            .on("click","a[href='#tab4']",function () {
                $(".more").hide();
                $(".end-tip").hide();
                $(".weui-loadmore").hide();
                var _date, _month, _day;
                if(!isEnd){ //页码未结束，继续执行
                    if (req != null)
                        req.abort();
                    req = $.ajax({
                        type:"post",
                        url:"${ctx}/wechat/comment/ShowProductComment",
                        data:{productId:"${productDetail.id}",pageNum:pageNum, pageSize:10},
                        dataType:"json",
                        beforeSend:function(){
                            $showComment.append(loadingHtml);
                        },
                        success:function (pageInfo) {
                            //console.log("当前第"+pageNum+"页,剩下"+(pageInfo.total-pageNum*10)+"条数据");
                            var pageSum = parseInt(pageInfo.total/10)+1; //总页数，设定10条为一页
                            var len;
                            if(pageSum == 1){  //只有一页，即<=10条评价
                                len = pageInfo.total;
                            }
                            else{   //大于一页，即>=10条评价
                                len = pageNum*10<pageInfo.total?
                                    10:(pageInfo.total-(pageNum-1)*10);
                                // 当前页码*10，是否小于总数据长度，是则先显示10条，len=10；
                                // 否则表示剩下最后一页，显示完剩下的数据，len=pageInfo.total-(pageNum-1)*10
                            }
                            var str = "";
                            //取决于len，若不是最后一页，就每次加载10条
                            //console.log("加载了"+len+"条数据");
                            for (var i = 0;i<len;i++){
                                str += "<div class=\"user\">" +
                                    "<div class=\"user-info\">" +
                                    "<a href=\"${ctx}/wechat/user/showUserIndex?userId="+pageInfo.list[i].user.id+"\">" +
                                    "<img src=\""+pageInfo.list[i].user.headImgUrl+"\" class=\"user-img\"></a>" +
                                    "<div class=\"user-name\">"+pageInfo.list[i].user.nickName+"</div></div>" +
                                    "<div class=\"comment-content\">"+pageInfo.list[i].commentContent+"<br>";
                                for (var k = 0;k < pageInfo.list[i].grade;k++){
                                    str += "<img src=\"${ctx}/images/star-on.png\" class=\"user-score\">";
                                }
                                _date = new Date(pageInfo.list[i].activity.departTime);

                                _month = _date.getMonth()+1;
                                _day = _date.getDate();

                                _month = _month<10?("0"+_month):_month;
                                _day = _day<10?("0"+_day):_day;

                                str += "<br><span class=\"comment-detail\">"+
                                    _month+"月"+_day+"日 "+"出发</span></div>";

                                if (pageInfo.list[i].sysReply != null
                                    && pageInfo.list[i].sysReply != ""){
                                    str += "<div class=\"admin-reply\">" +
                                        "<span class=\"admin-name\">系统 回复：</span>" +
                                        pageInfo.list[i].sysReply + "</div>";
                                }
                                str += "<hr class=\"across-line\"></div>";
                            }
                            console.log(str);
                            if (str !== null){
                                $(".weui-loadmore").hide();
                                $showComment.append(str);
                                pageNum++;
                                if(pageNum <= pageSum){
                                    $(".more").hide();
                                    $showComment.append("<div class='more'>点击加载更多</div>");
                                }else{
                                    $(".more").hide();
                                    $(".end-tip").show();
                                    isEnd = true; //页码已结束
                                }
                            }
                        }
                    })
                }
            })
            //点击加载更多评价
            .on("click",".more",function () {
                $("a[href='#tab4']").trigger("click");
            })
            //点击收藏
            .on("click",".collect",function () {
                if(isCollected === "true"){
                    isCollected = "false";
                }
                else{
                    isCollected = "true";
                }
                $.ajax({
                    url: "${ctx}/wechat/WxProductDetail/changeCollectionType",
                    type: "POST",
                    dataType: "json",
                    data: {isCollected:isCollected},
                    success: function (data) {
                        //返回true，设置状态为已收藏
                        if(data === 1){
                            $.toptip("收藏成功","success");
                            $collect.attr("src","${ctx}/images/collected.png");
                        }
                        //返回false，设置状态为未收藏
                        else if (data === 0){
                            $.toptip("已取消收藏本活动");
                            $collect.attr("src","${ctx}/images/no-collected.png");
                        }else {
                            alert("操作失败！请稍后重试");
                        }
                    },
                    error:function (e) {
                        alert("系统繁忙，请稍后再试");
                    }
                });
            })
            .on("click",".weui-navbar__item",function () {
                window.location.hash = $(this).attr("href");
            });
        //点击图片查看大图
        var $img = $(".weui-tab img"), _src;
        $img.click(function () {
            _src = $(this).attr("src");
            $.photoBrowser({
                items: [_src]
            }).open();
        });

        //调用滚动函数
        myScroll("#tab1");
        myScroll("#tab2");
        myScroll("#tab3");
        myScroll("#tab4");
    });
    //滑动活动详情、行程须知和费用说明时内容置顶
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
    function sharpConfig(url) {
        var config = {
            debug: '', // 开启调试模式
            appId: '', // 必填，公众号的唯一标识
            timestamp: '', // 必填，生成签名的时间戳
            nonceStr: '', // 必填，生成签名的随机串
            signature: '',// 必填，签名，见附录
            jsApiList: [] // 必填，需要使用的JS接口列表，所有JS接口列表见附录
        };
        $.ajax({
            url: 'http://www.ailangfamily.com/wechat/getSdkConfig',
            type: 'GET',
            dataType: 'json',
            async:false,
            data: {url: url},
            success: function (data) {
                config.debug = data.debug;
                config.appId = data.appId;
                config.timestamp = data.timestamp;
                config.nonceStr = data.nonceStr;
                config.signature = data.signature;
                config.jsApiList = data.jsApiList;
            }
        });
        wx.config(config);
        var index = url.indexOf("&code=");
        if (index != -1) {
            url = url.substring(0, index);
        }
        window.sharp_Config = {
            "share": {
                "imgUrl": "http://www.ailangfamily.com/photo/product/${productDetail.picUrl}",//分享图，默认当相对路径处理，所以使用绝对路径的的话，“http://”协议前缀必须在。
                "desc": "世界那么大，我们就爱浪。",//摘要,如果分享到朋友圈的话，不显示摘要。
                "title": '${productDetail.name}',//分享卡片标题
                "link": url,//分享出去后的链接，这里可以将链接设置为另一个页面。
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
            wx.hideMenuItems({
                menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
            });
        });
    }
    //"menuItem:copyUrl"
</script>
</body>
</html>