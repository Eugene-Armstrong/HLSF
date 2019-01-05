<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人资料编辑</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css?v=">
    <style>
        form{margin-top: 55px;}
        a {color: #679aff}
        nobr {font-size: 10px}
        nobr button:first-child {float: left}
        nobr button:last-child {float: right}
        .weui-cells {
            border-radius: 5px;
            margin: 15px;
        }
        .weui-cells:before,.weui-cells:after{border: none}
        .my-edit-btn{margin: 20px}
        .weui-cell__bd img{height: 60px}
        .current-len{color: #333}
        /*表单错误*/
        .check-error{border: 1px solid red;}
        .weui-input{width: 90%}
        .text-red{color: red;float: right}
    </style>
</head>
<body style="height: auto">
<div class="page-title">
    <a href="${ctx}/wechat/mine/showMinePage" class="return"></a>
    个人资料编辑
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}"><img src="${ctx}/images/topbar-home.png" class="go-home"></a>
</div>
<form action="${ctx}/wechat/mine/editUserSetting">
    <input id="id" name="id" type="hidden" value="${userdetail.id}">
    <div class="weui-cells weui-cells_form">
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">常用人</label></div>
            <a href="${ctx}/wechat/contact/showMineFrequentUsers?id=${userdetail.id}"><div class="weui-cell__bd">点击进入编辑</div></a>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">真实姓名</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must" type="text" id="real-name" name="realName" placeholder="请输入真实姓名" value="${userdetail.realName}" required>
                <b class="text-red">*</b>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">年龄</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must" type="number" id="age" placeholder="请输入年龄" name="age" value="${userdetail.age}" required>
                <b class="text-red">*</b>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">手机</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must" type="tel" id="phone" placeholder="请输入手机号" name="phone" value="${userdetail.phone}" required>
                <b class="text-red">*</b>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">身份证</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must" type="text" id="id-card" placeholder="请输入身份证号(与姓名对应)" name="certId" value="${userdetail.certId}" required>
                <b class="text-red">*</b>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">兴趣爱好</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input" type="text" placeholder="兴趣爱好" name="hobby" value="${userdetail.hobby}">
            </div>
        </div>
    </div>
    <div class="weui-cells__title">个人经历</div>
    <div class="weui-cells weui-cells_form">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <textarea class="weui-textarea" placeholder="个人经历(不超过200字)" name="experience" rows="3" maxlength="200">${userdetail.experience}</textarea>
                <div class="weui-textarea-counter"><span class="current-len">0</span>/200</div>
            </div>
        </div>
    </div>
    <div class="weui-cells__title">座右铭</div>
    <div class="weui-cells weui-cells_form">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <textarea class="weui-textarea" placeholder="座右铭(不超过60字)" name="motto" rows="3" maxlength="60">${userdetail.motto}</textarea>
                <div class="weui-textarea-counter"><span class="current-len">0</span>/60</div>
            </div>
        </div>
    </div>
    <div class="my-edit-btn">
        <button class="weui-btn weui-btn_primary" type="button">保存</button>
    </div>
</form>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        $(document).on("input","textarea",function () {
            var currentLen = $(this).val().length;
            $(this).next().find(".current-len").text(currentLen);
        });
        //点击保存
        $(".my-edit-btn").click(function () {
            $(".must").each(function () {
                if($(this).val() === ""){
                    $.toast.prototype.defaults.duration = 1500; //toast时间
                    $.toast($(this).parent().prev().find(".weui-label").text() + "不能为空哦","cancel");
                    $(this).addClass("check-error").focus();
                    return false;
                }else {
                    if($(this).attr("id")==="phone"){ //手机
                        var phone = /^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/;
                        var val = $(this).val();
                        if(!phone.test(val)){
                            $.toast.prototype.defaults.duration = 1500; //toast时间
                            $.toast("请输入有效的手机号","cancel");
                            $(this).addClass("check-error").focus();
                            return false;
                        }else {
                            $(this).removeClass("check-error");
                        }
                    }else if($(this).attr("id")==="id-card"){ //身份证
                        var ID = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                        var val = $(this).val();
                        if(!ID.test(val)){
                            $.toast.prototype.defaults.duration = 1500; //toast时间
                            $.toast("请输入有效的身份证号","cancel");
                            $(this).addClass("check-error");
                            return false;
                        }else{
                            $(this).removeClass("check-error");
                        }
                    }else {
                        $(this).removeClass("check-error");
                    }
                }
            });
            var errorCheck = 0;
            $(".check-error").each(function () {
                errorCheck++;
            });
            //没有错误，验证通过
            if(errorCheck === 0){
                $("form").submit();
            }
        });
    });
</script>
</body>
</html>