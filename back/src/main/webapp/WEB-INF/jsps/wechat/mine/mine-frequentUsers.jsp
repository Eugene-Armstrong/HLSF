<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>常用人信息</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css?v=">
    <style>
        .my-tip {
            /*position: absolute;*/
            z-index: -1;
            text-align: center;
            margin-top: 70px;
            line-height: 30px;
            color: #999
        }

        .weui-cells {
            border-radius: 10px;
            margin: 15px;
        }

        .weui-cells:before, .weui-cells:after {
            border: none
        }

        .weui-cells__title {
            margin: 0.77em 0
        }

        .weui-btn_mini {
            line-height: 21px
        }

        a {
            color: #679aff
        }
        .weui-btn_plain-default {
            color: #fff;
            border: 1px solid #fff;
        }

        .add, .cancel {
            cursor: pointer;
            position: absolute;
            right: 10px;
        }

        /*移除*/
        .weui-badge {
            cursor: pointer;
            position: absolute;
            top: 10px;
            right: 15px;
            padding: 2px 10px;
        }

        #mySubmit {
            display: none;
            width: 90%;
            margin: 20px 5%;
        }

        .check-error {
            border: 1px solid red;
        }

        .weui-btn + .weui-btn {
            margin-top: 0
        }

        .existed .weui-cell__bd {
            color: #999
        }

        .edit, .cancel {
            display: none
        }

        .real-name {
            width: 50%
        }
    </style>
</head>
<body style="padding-bottom: 20px">
<div class="page-title">
    <a href="${ctx}/wechat/mine/showMineSettings?id=${sessionScope.userInfo.id}" class="return"></a>
    编辑常用人信息
    <span class="weui-btn weui-btn_mini weui-btn_primary add">+ 添加</span>
    <span class="weui-btn weui-btn_mini weui-btn_plain-default cancel">取消</span>
</div>
<div class="my-tip">亲~您还没添加常用人哦<br>快戳右上角进行添加吧~</div>
<form style="margin-top: -90px" id="ContactInfo">
    <c:forEach items="${contactsList}" var="con">
        <!--已添加常用人-->
        <div class="weui-cells weui-cells_form existed">
            <input type="hidden" name="conId" class="conId" value="${con.id}">
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">真实姓名</label></div>
                <div class="weui-cell__bd">
                    <span class="weui-input real-name">${con.name}</span>
                    <span class="weui-badge">移除</span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">性别</label></div>
                <div class="weui-cell__bd">
                    <span class="weui-input age">${fns:getDictLabel('sex',con.sex,'')}</span>
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
    <!--添加编辑-->
    <div class="weui-cells weui-cells_form edit">
        <input type="hidden" name="userId" value="${sessionScope.userInfo.id}">
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">真实姓名</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must" type="text" name="name" placeholder="请输入真实姓名" required>
            </div>
        </div>
        <div class="weui-cell weui-cell_select weui-cell_select-after">
            <div class="weui-cell__hd">
                <label class="weui-label">性别</label>
            </div>
            <div class="weui-cell__bd">
                <select class="weui-select" name="sex">
                    <option value="1">男 ♂</option>
                    <option value="2">女 ♀</option>
                </select>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">年龄</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input" type="number" name="age" placeholder="请输入年龄" required>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">手机</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must" type="tel" name="phone" placeholder="请输入手机号">
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label">身份证</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input must" type="text" name="certId" placeholder="请输入身份证号(与姓名对应)" required>
            </div>
        </div>
    </div>
    <!--保存按钮-->
    <button id="mySubmit" class="weui-btn weui-btn_primary" type="button">确定添加</button>
    <button id="mySubmitClear" class="weui-btn weui-btn_primary" type="reset"></button>
</form>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/swiper.min.js"></script>
<script src="${ctx}/js/fastclick.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        FastClick.attach(document.body);
        //添加常用人开始编辑
        (function () {
            var $edit = $(".edit"),
                $add = $(".add"),
                $cancel = $(".cancel"),
                $mySubmit = $("#mySubmit"),
                $goBack = $(".return");

            $add.click(function () {
                $edit.show();
                $(".existed").hide();
                $(this).hide();
                $cancel.show();
                $mySubmit.show();
                $goBack.hide();
            });
            //取消添加退出编辑
            $cancel.click(function () {
                $edit.hide();
                $(".existed").show();
                $(this).hide();
                $add.show();
                $mySubmit.hide();
                $goBack.show();
            });
        })();

        //移除常用人
        $("body").on("click", ".weui-badge", function () {
            var $tmp = $(this).parent().parent();
            var conId = $tmp.siblings(".conId").val();
//            alert(conId);
            $.actions({
                title: "确定删除常用人" + $(this).prev(".real-name").text() + "吗？",
                actions: [{
                    text: "确定",
                    onClick: function () {
                        $.ajax({
                            type: "POST",
                            url: "${ctx}/wechat/contact/deleteFrequentUsers",
                            data: {conId: conId},
                            dataType: "html",
                            success: function (result) {
                                $tmp.parent().remove();
                                $.toast("移除成功", 1000);
                            },
                            error: function (result) {
                                $.toast("移除失败", 1000);
                            }
                        });

                    }
                }]
            });
        });

        //点击确定添加
        $("#mySubmit").click(function () {
            $(".must").each(function () { //表单验证
                if ($(this).val() === "") {
                    $.toast.prototype.defaults.duration = 1500; //toast时间
                    $.toast($(this).parent().prev().find(".weui-label").text() + "不能为空哦", "cancel");
                    $(this).addClass("check-error").focus();
                    return false;
                }else if ($(this).attr("name") === "phone"){
                    var phone = /^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/;
                    var $phone = $("input[name=phone]"),
                        phoneVal = $phone.val();
                    if (!phone.test(phoneVal) && phoneVal !== "") {
                        $.toast.prototype.defaults.duration = 1500; //toast时间
                        $.toast("请输入有效的手机号", "cancel");
                        $phone.addClass("check-error").focus();
                        return false;
                    } else {
                        $phone.removeClass("check-error");
                        return true;
                    }
                } else if ($(this).attr("name") === "certId") { //身份证
                    var ID = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                    var val = $(this).val();
                    if (!ID.test(val)) {
                        $.toast.prototype.defaults.duration = 1500; //toast时间
                        $.toast("请输入有效的身份证号", "cancel");
                        $(this).addClass("check-error").focus();
                        return false;
                    } else {
                        $(this).removeClass("check-error");
                        return true;
                    }
                } else {
                    $(this).removeClass("check-error");
                }
            });

            var errorCheck = 0;
            $(".check-error").each(function () {
                errorCheck++;
            });

            //没有错误，验证通过
            if (errorCheck === 0) {
                $.ajax({
                    type: "POST",
                    url: "${ctx}/wechat/contact/addFrequentUsers",
                    data: $('#ContactInfo').serialize(),// 你的formid
                    dataType: "json",
                    error: function (request) {
                        alert("系统错误");
                    },
                    success: function (data) {
                        if (data == "-2"){
                            alert("该常用人已存在");
                            $("input").val("");
                        }
                        else{
                            window.location.href = '${ctx}/wechat/contact/showMineFrequentUsers?id=${userId}';
                        }
                    }
                });
            }
        });
    });
</script>
</body>
</html>
