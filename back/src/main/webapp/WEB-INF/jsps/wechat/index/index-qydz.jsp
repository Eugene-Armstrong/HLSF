<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>团队定制</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css?v=">
    <style>
        .weui-cell{padding: 13px 15px}
        .weui-cell_select{padding: 0 15px}
        .weui-cells__title {margin: 0.77em 0}
        .my-submit-btn{margin: 20px}
        .toolbar .toolbar-inner{background: #333;color: #fff;font-size: 16px;}
        .picker-calendar-day.picker-calendar-day-selected span{background: #679aff}
        .weui-btn{font-size: 16px}
        .return {
            position: absolute;
            left: 10px;
            width: 20px;
            height: 20px;
            background: url("${ctx}/images/return.png");
            background-size: cover;
        }
        .weui-cell__hd{display: -webkit-box}
        .weui-cell__hd img{width: 16px;height: 16px;margin-right: 10px}
        /*表单错误*/
        .check-error{border: 1px solid red;}
        .current-len{color: #333}
    </style>
</head>
<body>
<div class="page-title">
    <a href="javascript:history.back()" class="return"></a>
    团队定制
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}">
        <img src="${ctx}/images/topbar-home.png" class="go-home">
    </a>
</div>
<div class="weui-cells__title" style="margin-top: 50px">
    定制信息填写
</div>
<%--<p>${tips}</p>--%>
<form id="form1" action="/wechat/company/addCompanyCustom" >
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_date.png">
            <label class="weui-label">出发日期</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="startTime" type="text" id="date" placeholder="请选择日期" readonly>
        </div>
    </div>
    <div class="weui-cell weui-cell_select weui-cell_select-after">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_city.png">
            <label class="weui-label">出发城市</label>
        </div>
        <div class="weui-cell__bd">
            <select class="weui-select" name="departCity">
                <c:forEach items="${cityList}" var="citys">
                    <option value="${citys.id}">${citys.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_num.png">
            <label class="weui-label">人数</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="number" type="number" placeholder="请输入人数(不少于2人)">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_age.png">
            <label class="weui-label">平均年龄</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="averageAge" type="number" placeholder="请输入平均年龄">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_price.png">
            <label class="weui-label">预算</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="price" type="number" placeholder="请输入预算价格">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_company.png">
            <label class="weui-label">团队名称</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="name" type="text" placeholder="请输入企业名称">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_contact.png">
            <label class="weui-label">联系人</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="manaName" type="text" placeholder="请输入联系人姓名">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_phone.png">
            <label class="weui-label">联系手机</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="manaTel" type="tel" placeholder="请输入联系人手机号">
        </div>
    </div>
    <div class="weui-cell weui-cell_select weui-cell_select-after">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_purpose.png">
            <label class="weui-label">目的</label>
        </div>
        <div class="weui-cell__bd">
            <select class="weui-select" name="aim">
                <option value="娱乐">娱乐</option>
                <option value="学习">学习</option>
                <option value="拓展">拓展</option>
            </select>
        </div>
    </div>
</div>
<div class="weui-cells__title">其他需求说明</div>
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <textarea class="weui-textarea" name="remark" placeholder="请输入其他需求说明" rows="3" maxlength="200"></textarea>
            <div class="weui-textarea-counter">
                <span class="current-len">0</span>/200</div>
        </div>
    </div>
</div>
<div class="my-submit-btn">
    <button type="button" class="weui-btn weui-btn_primary">提交</button>
</div>
</form>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        //初始化日历组件
        $("#date").calendar({
            dateFormat: 'yyyy年mm月dd日',
            onChange: function (p, values, displayValues) {
                console.log(values, displayValues);
//                alert(displayValues);
            }
        });
        //字数统计
        $(document).on("input","textarea",function () {
            var currentLen = $(this).val().length;
            $(this).next().find(".current-len").text(currentLen);
        });
        //提交
       $(".my-submit-btn").on("click",function () {
           var submitCheck = true;
           $("input").each(function () {
               if($(this).val() === ""){
                   $.toast.prototype.defaults.duration = 1500; //toast时间
                   $.toast($(this).parent().prev().find(".weui-label").text() + "不能为空哦","cancel");
                   $(this).addClass("check-error").focus();
                   submitCheck = false;
                   return false;
               }else {
                   if($(this).attr("name")==="manaTel"){ //手机
                       var phone = /^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/;
                       var val = $(this).val();
                       if(!phone.test(val)){
                           $.toast.prototype.defaults.duration = 1500; //toast时间
                           $.toast("请输入有效的手机号","cancel");
                           $(this).addClass("check-error").focus();
                           submitCheck = false;
                           return false;
                       }else {
                           $(this).removeClass("check-error");
                       }
                   }else if($(this).attr("name")==="number"){
                       if(parseInt($(this).val()) < 2){
                           $.toast("人数至少为2人","cancel");
                           $(this).addClass("check-error").focus();
                           submitCheck = false;
                           return false;
                       }else {
                           $(this).removeClass("check-error");
                       }
                   }else {
                       $(this).removeClass("check-error");
                   }
               }
           });
           if(submitCheck){
               //$("form").submit();
               $.ajax({
                   type: "POST",
                   url: "${ctx}/wechat/company/addCompanyCustom",
                   data: $('#form1').serialize(),
                   dataType: "json",
                   success: function (data) {
                       if(data == 1){
                           alert("提交成功，工作人员会尽快与您联系，祝您生活愉快！");
                           window.location.href =
                               "${ctx}/wechat/index/showSecondPage?city.id=${currentCity.id}&location=1&module=15";
                       }else{
                           alert("提交失败，请稍后再试。")
                       }
                   },
                   error: function () {
                       alert("系统繁忙，请稍后再试。");
                   }
               })
           }
        })
    })
</script>
</body>
</html>