<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>游记列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        body,html{height: 100%}
        .weui-tab__bd {
            background: #eee;
            font-size: 14px;
            padding-bottom: 50px;
        }
        .weui-flex__item{background: #fff;}
        /*游记*/
        .weui-panel{margin-top: 0;margin-bottom: 10px}
        .weui-panel:before{border-top: none}
        .weui-media-box{padding: 10px}
        .weui-media-box__title{font-size: 14px}
        .weui-media-box_appmsg .weui-media-box__hd,.weui-media-box__thumb{width: 35%;height: 80px}
        .my-name{color: #333;line-height: 47px}
        .weui-media-box__desc{font-size: 10px}
        .weui-media-box__desc img{width: 32px;height: 32px;border-radius: 50%;vertical-align: middle}
        .weui-media-box__desc span{float: right}
        .my-info p{padding: 6px 0}
        .weui-loadmore__tips{color:#999}
        #more{
            display: none;
            text-align: center;
            font-size: 14px;
            line-height: 40px;
            border-top: 1px solid #eee;
            color: #999;
            cursor:pointer;
        }
        #end-tip{display: none}
        /*底部提示*/
        .weui-loadmore a {
            font-size: 12px;
            color: #37a1ff
        }
    </style>
</head>
<body>
<!--导航对应内容-->
<div class="weui-tab__bd">
    <div class="weui-tab__bd-item weui-tab__bd-item--active">
        <div class="weui-flex">
            <div class="weui-flex__item">
                <img src="${ctx}/images/youji-banner.png" style="width: 100%">
            </div>
        </div>
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__bd" id="journeyList">
                <%--<a href="society-journey.html" class="weui-media-box weui-media-box_appmsg">--%>
                    <%--<div class="weui-media-box__hd">--%>
                        <%--<img class="weui-media-box__thumb" src="${ctx}/images/tmp-02.jpg">--%>
                    <%--</div>--%>
                    <%--<div class="weui-media-box__bd">--%>
                        <%--<h4 class="weui-media-box__title">海外温泉一日游</h4>--%>
                        <%--<p class="weui-media-box__desc my-name">--%>
                            <%--<img src="${ctx}/images/head-img.jpg"> 用户名--%>
                        <%--</p>--%>
                        <%--<p class="weui-media-box__desc">--%>
                            <%--2017-07-12 10:00--%>
                            <%--<span>浏览 500+</span>--%>
                        <%--</p>--%>
                    <%--</div>--%>
                <%--</a>--%>
            </div>
            <div class='weui-loadmore'>
                <i class='weui-loading'></i>
                <span class='weui-loadmore__tips'> 加载中</span>
            </div>
            <div id='more'>点击加载更多</div>
            <div class="weui-panel__ft" id="end-tip">
                <a class="weui-cell weui-cell_access weui-cell_link">
                    <div class="weui-cell__bd">没有更多游记了哦~</div>
                </a>
            </div>
        </div>
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
    <a href="${ctx}/wechat/mine/showMinePage" class="weui-tabbar__item">
        <div class="weui-tabbar__icon">
            <img src="${ctx}/images/nav-mine.png" alt="">
        </div>
        <p class="weui-tabbar__label">我的</p>
    </a>
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script>
    var jList = $("#journeyList"),
        pageNum = 1, //当前页码
        pageSize = 10,//每页显示游记数量
        isEnd = false, //页码是否结束标志
        loading = $(".weui-loadmore"),//加载中
        more = $("#more"),//加载更多
        endTip = $("#end-tip");//没有更多
    $(function () {
        myAjax();
        $(document).on("click","#more",function () {
            myAjax();
        })
    });

    /**
     * 获取对应页码的数据
     */
    function myAjax() {
        if(!isEnd){ //页码未结束
            $.ajax({
                url: '${ctx}/wechat/journey/showJourneyList',
                type: 'GET',
                dataType: 'json',
                data: {pageNum:pageNum, pageSize:pageSize},
                beforeSend:function(){
                    loading.show();
                    more.hide();
                    endTip.hide();
                },
                success: function (pageInfo) {
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
                    console.log(pageInfo);
                    for (var i = 0;i<len;i++){
                        str += '<a href="${ctx}/wechat/journey/showJourneyById?id='+pageInfo.list[i].id+'"' +
                            'class="weui-media-box weui-media-box_appmsg">' +
                            '<div class="weui-media-box__hd">' +
                            '<img class="weui-media-box__thumb" src="${ctx}/photo/TravelNote/'+pageInfo.list[i].picUrl+'"></div>' +
                            '<div class="weui-media-box__bd">' +
                            '<h4 class="weui-media-box__title">'+pageInfo.list[i].title+'</h4>' +
                            '<p class="weui-media-box__desc my-name">' +
                            '<img src="'+pageInfo.list[i].user.headImgUrl+'"> ' +
                            pageInfo.list[i].userRealName+'</p>' +
                            '<p class="weui-media-box__desc">'+fmtDate(pageInfo.list[i].createTime)+
                            ' <span>浏览 '+pageInfo.list[i].browseTimes+'+</span></p></div></a>'
                    }
                    if (str !== null){
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
                },
                error:function () {
                    alert("系统繁忙，请稍后重试");
                }
            });
        }
    }
    //出发时间格式化
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