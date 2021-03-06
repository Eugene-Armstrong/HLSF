<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>活动日历</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css?v=">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css?v=">
    <link rel="stylesheet" href="${ctx}/css/index.css?v=0">
    <style>
        .page-title {
            background: #333;
        }
        /*日历*/
        #inline-calendar{margin-top: 41px}
        .weui-picker-calendar,
        .weui-picker-calendar .picker-modal-inner{height: auto;background: #fafafa;}
        .picker-calendar-day.picker-calendar-day-selected span{background: #679aff}
        .special{
            color: #fff;
            background: #ff5a5f;
            border-radius: 50%;
        }
        .picker-calendar-day{
            position: relative;
        }
        .picker-calendar-day span{font-size: 12px;width: 25px;height: 25px;line-height: 25px}
        .toolbar .toolbar-inner{background: #679aff;color: #fff;font-size: 16px;}
        .picker-calendar-week-days{padding: 10px 0;height: auto;background: #fff}
        /*.picker-calendar-day{color: red}*/
        /*活动信息*/
        .product-name{color: #000;font-size: 14px;}
        .my-status-1,.my-status-2,.my-status-3,.my-status-4,.my-status-5,.time-info{float: right}
        .leader-name,.time-info{color: #999;margin-top: 5px}
        .leader-name{float: left}
        .weui-cell_access .weui-cell__ft{margin-left: 10px}
        .weui-cell{padding: 12px 15px;font-size: 12px}
    </style>
</head>
<body style="padding-bottom: 10px">
<!--Title-->
<div class="page-title">
    <a href="javascript:history.back()" class="return"></a>
    活动日历
    <a href="${ctx}/wechat/index/show?cityId=${currentCity.id}"><img src="${ctx}/images/topbar-home.png" class="go-home"></a>
</div>
<!--日历-->
<div id="inline-calendar"></div>
<!--活动列表-->
<div class="weui-panel weui-panel_access" id="show">
    <div class="weui-panel__ft">
        <%--<c:forEach var="activity" items="${todayActivity}">--%>
            <%--<div class='weui-panel__ft'>--%>
                <%--<a href='${ctx}/wechat/WxProductDetail/getProductDetail?productId=${activity.product.id}&actId=${activity.id}&cityId=${currentCity.id}' class='weui-cell weui-cell_access weui-cell_link'>--%>
                    <%--<div class='weui-cell__bd'>--%>
                        <%--<span class='product-name'>${activity.product.name}</span>--%>
                        <%--<c:if test="${activity.state}=='未成行'">--%>
                            <%--<span class='my-status-1'>未成行</span>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${activity.state}=='已成行'">--%>
                            <%--<span class='my-status-2'>已成行</span>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${activity.state}=='活动中'">--%>
                            <%--<span class='my-status-3'>活动中</span>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${activity.state}=='已满人'">--%>
                            <%--<span class='my-status-4'>已满人</span>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${activity.state}=='已结束'">--%>
                            <%--<span class='my-status-5'>已结束</span>--%>
                        <%--</c:if>--%>
                        <%--<br>--%>
                        <%--<span class='leader-name'>领队：--%>
                            <%--<c:forEach var="leader" items="${activity.activityLeaderList}">--%>
                                <%--${leader.user.nickName}&nbsp;--%>
                            <%--</c:forEach>--%>
                        <%--</span>--%>
                        <%--<span class='time-info'><fmt:formatDate value="${activity.departTime}" type="date"/>&nbsp;出发</span>--%>
                    <%--</div>--%>
                    <%--<span class='weui-cell__ft'></span>--%>
                <%--</a>--%>
            <%--</div>--%>
        <%--</c:forEach>--%>
        <a href="${ctx}/wechat/index/show?cityId=${currentCity.id}" class="weui-cell weui-cell_access weui-cell_link">
            <span class="weui-cell__bd">没有更多活动啦~去首页看看吧</span>
            <span class="weui-cell__ft"></span>
        </a>
    </div>
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js?v="></script>
<script src="${ctx}/js/fastclick.js?v="></script>
<script src="${ctx}/js/jquery-weui.min.js?v="></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        FastClick.attach(document.body);
        var lastContent = $(".weui-panel__ft").prop("outerHTML"),
            loadingHtml = "<div class='weui-loadmore'><br>" +
                "<i class='weui-loading'></i>" +
                "<span class='weui-loadmore__tips'> 加载中</span></div>";

        /**
         * weui日历组件初始化
         */
        $("#inline-calendar").calendar({
            container: "#inline-calendar",
            onMonthAdd:function () {
                var dateArray = [],_index,_len;
                <c:forEach var="date" items="${activityDate}">
                    dateArray.push(fmtDate('${date}'));
                </c:forEach>
                _len = dateArray.length;
                $(".picker-calendar-day").each(function () {
                    var $self = $(this);
                    for(_index=0;_index<_len;_index++){
                        var y = $self.attr("data-year"),
                            m = parseInt($self.attr("data-month"))+1,
                            d = parseInt($self.attr("data-day"));
                        if(m<10){m = 0+m.toString()}
                        if(d<10){d = 0+d.toString()}
                        var date = y+"/"+m+"/"+d;
                        if(dateArray[_index]==date){
                            $self.find("span").addClass("special");
                        }
                    }
                });
            },
            onDayClick:function (p, dayContainer, year, month, day){
                month = (parseInt(month) + 1);
                if (month<10) {month = 0 + month.toString()}
                if (day<10) {day = 0 + day.toString()}
                var date = year + "-" + month + "-" + day,
                    $obj = $(".weui-panel");
                $.ajax({
                    url: "${ctx}/wechat/calender/findByDate",
                    type: "POST",
                    dataType: "json",
                    data: {"cityId": '${currentCity.id}', "date": date.toString()},
                    beforeSend:function(XMLHttpRequest){
                        $obj.html(loadingHtml);
                    },
                    success: function (data) {
                        if (data.code == 200) {
                            $obj.html("");//清空
                            $('#show').empty();
                            if (data.entity && data.entity.length > 0) {
                                for (var i = 0; i < data.entity.length; i++) {
                                    var leader = ''; //领队
                                    if (data.entity[i].activityLeaderList && data.entity[i].activityLeaderList.length > 0) {
                                        for (var x = 0; x < data.entity[i].activityLeaderList.length; x++) {
                                            leader = leader + data.entity[i].activityLeaderList[x].user.nickName.toString() + ' ';
                                        }
                                    }
                                    var status, state = data.entity[i].state;
                                    if(state == "未成行"){
                                        status = "my-status-1"
                                    } else if(state == "已成行"){
                                        status = "my-status-2"
                                    } else if(state == "活动中"){
                                        status = "my-status-3"
                                    } else if(state == "已满人"){
                                        status = "my-status-4"
                                    } else if(state == "已结束"){
                                        status = "my-status-5"
                                    }
                                    $obj.append("<div class='weui-panel__ft'>" +
                                        "<a href='${ctx}/wechat/WxProductDetail/getProductDetail?productId=" + data.entity[i].product.id + "&actId=" + data.entity[i].id + "&cityId=${currentCity.id}' class='weui-cell weui-cell_access weui-cell_link'>" +
                                        "<div class='weui-cell__bd'>" +
                                        "<span class='product-name'>" + data.entity[i].product.name + "</span>" +
                                        "<span class='"+status+"'>" + data.entity[i].state + "</span><br>" +
                                        "<span class='leader-name'>领队：" + leader + "</span>" +
                                        "<span class='time-info'>" + fmtDate(data.entity[i].departTime) + " 出发</span></div>" +
                                        "<span class='weui-cell__ft'></span></a></div>")
                                }
                            }
                            $obj.append(lastContent);
                        } else {
                            alert(data.message);
                        }
                    }
                });
            }
        });
    });

    /**
     * 日期格式化
     * @param obj - 时间戳
     * @returns {string}
     */
    function fmtDate(obj){
        var data = obj.replace(/-/g, "/");
        var date =  new Date(data.substring(0,data.length-2));
        var y = date.getFullYear();
        var m = "0"+(date.getMonth()+1);
        var d = "0"+date.getDate();
        return y+"/"+m.substring(m.length-2,m.length)+"/"+d.substring(d.length-2,d.length);
    }
</script>
</body>
</html>