<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>添加活动</title>

    <link href="http://xiumi.us/connect/ue/v5/xiumi-ue-v5.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="http://xiumi.us/connect/ue/v5/xiumi-ue-dialog-v5.js"></script>

    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <script src="${ctx}/js/jquery.js"></script>
    <script src="${ctx}/js/pintuer.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script>
        $(function () {
            var cur_date; // 当前日期
            var start_date; //出发日期
            var stop_date; //截止报名日期
            var end_date; //结束日期

            /**
             * 日期先后验证
             */
            //选择截止报名日期
            $(".stop-date").on("input", function () {
                cur_date = new Date();//当前日期
                stop_date = new Date($(this).val());
                if(stop_date.getTime() < cur_date.getTime()){
                    alert("截止报名日期必须大于当前日期，请重新选择");
                    $(this).val("");
                }
            });
            //选择截止报名钟点时间
            $(".stop-clock").on("input",function () {
                var startDate = new Date($(".start-date").val());
                var stopDate = new Date($(".stop-date").val());
                if(startDate.getTime() == stopDate.getTime()){ //出发日期与截止报名日期为同一天时
                    var start_clock = $(".start-clock").val();
                    var stop_clock = $(this).val();
                    if(start_clock <= stop_clock){
                        alert("截止报名钟点时间必须小于出发钟点时间，请重新选择");
                        $(this).val("");
                    }
                }
            });
            //选择出发日期
            $(".start-date").on("input", function () {
                if ($(".stop-date").val() == "") {
                    alert("请先选择截止报名时间");
                    $(this).val("");
                } else {
                    start_date = new Date($(this).val());
                    if(start_date.getTime() < stop_date.getTime()){
                        alert("出发日期不能小于截止报名日期，请重新选择");
                        $(this).val("");
                    }
                }
            });
            //选择出发钟点时间
            $(".start-clock").on("input",function () {
                var startDate = new Date($(".start-date").val());
                var stopDate = new Date($(".stop-date").val());
                if(startDate.getTime() == stopDate.getTime()){ //出发日期与截止报名日期为同一天时
                    var start_clock = $(this).val();
                    var stop_clock = $(".stop-clock").val();
                    var end_clock = $(".end-clock").val();
                    if(start_clock <= stop_clock){
                        alert("出发钟点时间必须大于截止报名钟点时间，请重新选择");
                        $(this).val("");
                    }else if(start_clock >= end_clock){
                        alert("出发钟点时间必须小于结束钟点时间，请重新选择");
                        $(this).val("");
                    }
                }
            });
            //选择结束日期
            $(".end-date").on("input", function () {
                if ($(".start-date").val() == "") {
                    alert("请先选择出发时间");
                    $(this).val("");
                } else {
                    end_date = new Date($(this).val());
                    if(end_date.getTime() < start_date.getTime()){
                        alert("结束日期不能小于出发日期，请重新选择");
                        $(this).val("");
                    }
                }
            });
            //选择结束钟点时间
            $(".end-clock").on("input",function () {
                var endDate = new Date($(".end-date").val());
                var startDate = new Date($(".start-date").val());
                if(endDate.getTime() == startDate.getTime()){ //结束日期与出发日期为同一天时
                    var end_clock = $(this).val();
                    var start_clock = $(".start-clock").val();
                    if(end_clock <= start_clock){
                        alert("结束钟点时间必须大于出发钟点时间，请重新选择");
                        $(this).val("");
                    }
                }
            });

            var selectLeaders = $("select[name=leaders]");
            //添加活动领队
            selectLeaders.change(function () {
                if($(this).get(0).selectedIndex != 0){
                    var leadersTxt = $(this).find("option:selected").text();//选中领队文本
                    var leadersVal = $(this).find("option:selected").val();//选中领队value
                    var check = true;
                    $(".leaders .my-tag").each(function () {
                        if(leadersVal == $(this).attr("id")){
                            alert("不能重复添加已存在的领队");
                            check = false;
                            return false;
                        }
                    });
                    if(check){
                        //追加指定内容
                        $(".leaders .my-tags").append("<span class='my-tag close' title='删除' id='"
                            + leadersVal + "'>" + leadersTxt + "</span>");
                    }
                    $("body").on("click",".leaders .my-tag",function () {
                        $(this).remove();
                    });
                }
            });
            $(document).on("click",".leaders .my-tag",function () { //下拉选中值没有变动时的执行删除
                $(this).remove();
            });

            var selectRules = $("select[name=rules]");
            //添加优惠规则
            selectRules.change(function () {
                if($(this).get(0).selectedIndex != 0){
                    var rulesTxt = $(this).find("option:selected").text();//选中规则文本
                    var rulesVal = $(this).find("option:selected").val();//选中规则value
                    var check = true;
                    $(".rules .my-tag").each(function () {
                        if(rulesVal == $(this).attr("id")){
                            alert("不能重复添加已存在的优惠规则");
                            check = false;
                            return false;
                        }
                    });
                    if(check){
                        //追加指定内容
                        $(".rules .my-tags").append("<span class='my-tag close' title='删除' id='"
                            + rulesVal + "'>" + rulesTxt + "</span>");
                    }
                    $("body").on("click",".rules .my-tag",function () {
                        $(this).remove();
                    });
                }
            });
            $(document).on("click",".rules .my-tag",function () { //下拉选中值没有变动时的执行删除
                $(this).remove();
            });


            var formCheck;
            //表单信息保存
            $(".confirm").on("click",function () {
                var check = true,self = $(this);
                $(".must").each(function () {
                    if($(this).val()==""){
                        $(this).focus();
                        var s = $(this).parent().prev().text();
                        alert("请把 "+s.substring(0,s.length-1)+" 填写完整");
                        check = false;
                        return false;
                    }
                });

                var _num = parseInt($(".num").val());//成行人数
                var _sum = parseInt($(".sum").val());//总人数
                var stop = new Date($(".stop-date").val()).getTime();
                var start = new Date($(".start-date").val()).getTime();
                var end = new Date($(".end-date").val()).getTime();

                if(check){
                    if(Number(_num)>Number(_sum)){
                        alert("成行人数不能大于总人数");
                        $(".num").focus();
                        return;
                    }else if($(".leaders .my-tags").html() == ""){
                        alert("请选择至少一个领队");
                        selectLeaders.focus();
                        return;
                    }else if(stop > start){
                        alert("截止报名日期不能大于出发日期，请核对后再提交");
                        $(".stop-date").focus();
                        return;
                    }else if(start > end){
                        $(".start-date").focus();
                        alert("出发日期不能大于结束日期，请核对后再提交");
                        return;
                    }
                    var _id = $(".product-id").val();//产品ID
                    var _price = parseInt(Number(Number($(".price").val()).toFixed(2))*100); //活动价格
                    var _city = $("select[name=city]").find("option:selected").val();
//                    var _num = $(".num").val();//成行人数
//                    var _sum = $(".sum").val();//总人数
                    var _discount = parseInt(Number(Number($(".discount").val()).toFixed(2))*100);//优惠价格
                    var _leaders = "";
                    //获取所选领队value
                    $(".leaders .my-tag").each(function () { // 规则遍历
                        _leaders += $(this).attr("id") + ",";
                    });
                    var _rules = "";
                    //获取所选优惠规则value
                    $(".rules .my-tag").each(function () { // 规则遍历
                        _rules += $(this).attr("id") + ",";
                    });
                    var _location = $(".location").val();//集合地点
                    var _startTime = $(".start-date").val() + " " + $(".start-clock").val();//出发时间
                    var _stopTime = $(".stop-date").val() + " " + $(".stop-clock").val();//截止报名时间
                    var _endTime = $(".end-date").val() + " " + $(".end-clock").val();//结束时间

                    $.ajax({
                        type: "post",
                        async: false,
                        url: "${ctx}/activity/addActivity", // 请求处理页
                        dataType: "json",
                        data: {
                            id: _id,
                            price: _price,
                            city:_city,
                            num: _num,
                            sum:_sum,
                            leaders:_leaders,
                            onSalePrice: _discount,
                            rules: _rules,
                            location: _location,
                            startTime: _startTime,
                            stopTime: _stopTime,
                            endTime: _endTime
                        },
                        beforeSend:function(){
                            self.text("保存中,请稍候…").attr("disabled",true);
                        },
                        success: function (result) {
                            if(result == 1){
                                self.text("表单已保存");
                                formCheck = true;
                            }
                            else{
                                alert("表单保存失败！请稍后重试！");
                                self.text("保存表单").attr("disabled",false);
                            }
                        },error: function() {
                            alert("系统繁忙，请稍后再试！");
                        }
                    });
                }
            });

            /**
             * 点击富文本导航
             * 切换对应的保存按钮
             */
            $(".tab-nav li").click(function () {
                $(".tab-btn").hide();
                $("#save"+($(this).index()+1)).show();
            });

            //分块保存富文本内容
            $(document)
            //活动介绍
                .on("click","#save1",function () {
                    if(formCheck){
                        var self = $(this),
                            _introduce = UE.getEditor('introduce',{
                                autoHeightEnabled:false,
                                iframeCssUrl: '__PUBLIC__/other/ueditor/themes/iframe.css'// 引入css
                            }).getContent();//活动介绍
                        console.log(_introduce);
                        $.ajax({
                            type: "post",
                            async: false,
                            url: "${ctx}/activity/addActivityUeditor", // 请求处理页
                            dataType: "json",
                            data: {html_introduce: _introduce},
                            beforeSend:function(){
                                self.text("保存中,请稍候…").attr("disabled",true);
                            },
                            success: function (result) {
                                if(result.code == 200){
                                    self.text("活动介绍已保存").attr("disabled",false);
                                }
                                else{
                                    alert("活动介绍保存失败！请稍后重试！");
                                    self.text("保存活动介绍").attr("disabled",false);
                                }
                            },error: function() {
                                alert("系统繁忙，请稍后再试！");
                                self.text("保存活动介绍").attr("disabled",false);
                            }
                        });
                    }
                    else{alert("请先保存表单信息");}
                })

                //活动行程
                .on("click","#save2",function () {
                    if(formCheck){
                        var self = $(this),
                            _process = UE.getEditor('process',{autoHeightEnabled:false}).getContent();//活动行程
                        $.ajax({
                            type: "post",
                            async: false,
                            url: "${ctx}/activity/addActivityUeditor", // 请求处理页
                            dataType: "json",
                            data: {html_process: _process},
                            beforeSend:function(){
                                self.text("保存中,请稍候…").attr("disabled",true);
                            },
                            success: function (result) {
                                if(result.code == 200){
                                    self.text("活动行程已保存").attr("disabled",false);
                                }
                                else{
                                    alert("活动行程保存失败！请稍后重试！");
                                    self.text("保存活动行程").attr("disabled",false);
                                }
                            },error: function() {
                                alert("系统繁忙，请稍后再试！");
                                self.text("保存活动介绍").attr("disabled",false);
                            }
                        });
                    }
                    else{alert("请先保存表单信息");}
                })

                //费用说明
                .on("click","#save3",function () {
                    if(formCheck){
                        var self = $(this),
                            _cost = UE.getEditor('cost',{autoHeightEnabled:false}).getContent();//费用说明
                        $.ajax({
                            type: "post",
                            async: false,
                            url: "${ctx}/activity/addActivityUeditor", // 请求处理页
                            dataType: "json",
                            data: {html_cost: _cost},
                            beforeSend:function(){
                                self.text("保存中,请稍候…").attr("disabled",true);
                            },
                            success: function (result) {
                                if(result.code == 200){
                                    self.text("费用说明已保存").attr("disabled",false);
                                }
                                else{
                                    alert("费用说明保存失败！请稍后重试！");
                                    self.text("保存费用说明").attr("disabled",false);
                                }
                            },error: function() {
                                alert("系统繁忙，请稍后再试！");
                                self.text("保存活动介绍").attr("disabled",false);
                            }
                        });
                    }
                    else{alert("请先保存表单信息");}
                });
        })
    </script>
    <style>
        #introduce,#process,#cost{overflow-x: hidden}
        td input {float: left;}
        td {border-top: 0 !important;}
        textarea{width: 100%!important;}
        input[type=date],input[type=time]{
            width: 48%;
            margin-right: 2px;
        }
        .my-tags {
            padding-top: 0 !important;
        }

        .my-tag {
            background: #3288de;
            color: #fff;
            padding: 2px 5px;
            margin: 2px;
            font-size: 14px;
            line-height: inherit;9
            border-radius: 2px;
        }
        #save1,#save2,#save3{
            cursor: pointer;
            padding: 5px 20px;
            display: none;
            margin-left: 5px;
        }
        #save1{display: inline}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-plus-square-o"></span> 添加活动</strong>
        <a class="float-right" href="${ctx}/activity/showProductActivity?productId=${productId}">
            <span class="icon-reply"></span> 返回
        </a>
    </div>
        <table class="table">
            <tr style="display: none">
                <td><input type="text" class="product-id" value="${productId}"></td>
            </tr>
            <tr>
                <td class="text-right" width="120px">活动价格：</td>
                <td width="30%">
                    <input type="number" class="input price must" placeholder="请输入活动价格(必填)" required>
                </td>
                <td width="5%"></td>
                <td rowspan="14" width="50%">
                    <div class="tab">
                        <div class="tab-head">
                            <ul class="tab-nav">
                                <li class="active">
                                    <a href="#tab-1">活动介绍</a></li>
                                <li>
                                    <a href="#tab-2">活动行程</a></li>
                                <li>
                                    <a href="#tab-3">费用说明</a></li>
                                <span class="button bg-main tab-btn" id="save1">保存活动介绍</span>
                                <span class="button bg-green tab-btn" id="save2">保存活动行程</span>
                                <span class="button bg-yellow tab-btn" id="save3">保存费用说明</span>
                            </ul>
                        </div>
                        <div class="tab-body">
                            <div class="tab-panel active" id="tab-1">
                                <script id="introduce" type="text/plain" style="width:450px;height:800px;">请编辑活动介绍</script>
                            </div>
                            <div class="tab-panel" id="tab-2">
                                <script id="process" type="text/plain" style="width:450px;height:800px;">请编辑活动行程</script>
                            </div>
                            <div class="tab-panel" id="tab-3">
                                <script id="cost" type="text/plain" style="width:450px;height:800px;">请编辑费用说明</script>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="text-right">出发城市：</td>
                <td>
                    <select class="input" name="city" required>
                        <option value=" ">请选择城市(非必选)</option>
                        <c:forEach items="${cities}" var="city">
                            <option value="${city.id}">${city.name}</option>
                        </c:forEach>
                    </select>
                </td>
                <td></td>
            </tr>
            <tr>
                <td class="text-right">成行人数：</td>
                <td width="30%"><input type="number" class="input num must" placeholder="请输入成行人数(必填)" required></td>
            </tr>
            <tr>
                <td class="text-right">总人数：</td>
                <td width="30%"><input type="number" class="input sum must" placeholder="请输入总人数(必填)" required></td>
            </tr>
            <tr>
                <td class="text-right">活动领队：</td>
                <td>
                    <select class="input" name="leaders" required>
                        <option value="">请选择领队(必填-多选)</option>
                        <c:forEach items="${leader}" var="leader">
                                <option value=${leader.id}>${leader.workNo}-${leader.realName} (带队${leader.leaderNum}次)
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr class="leaders">
                <td class="text-right">已添加领队：</td>
                <td class="my-tags"></td>
            </tr>
            <tr>
                <td class="text-right" width="200px">优惠价格：</td>
                <td>
                    <input type="number" class="input discount" placeholder="请输入优惠价格" value="${0}">
                </td>
            </tr>
            <tr>
                <td class="text-right">优惠规则：</td>
                <td>
                    <select class="input" name="rules">
                        <option value="">请选择优惠规则(多选)</option>
                        <c:forEach items="${promotionList}" var="pro">
                            <option value="${pro.id}">${pro.detail}:${pro.rule}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr class="rules">
                <td class="text-right">已添加规则：</td>
                <td class="my-tags"></td>
            </tr>
            <tr>
                <td class="text-right">截止报名时间：</td>
                <td>
                    <input type="date" class="input stop-date must" required>
                    <input type="time" class="input stop-clock must" value="00:00" required>
                </td>
            </tr>
            <tr>
                <td class="text-right">集合地点：</td>
                <td>
                    <textarea rows="5" class="input location must" placeholder="请输入集合地点，多个地点之间用-分隔（必填,不超过200字）"
                              maxlength="200" required></textarea>
                </td>
            </tr>
            <tr>
                <td class="text-right">出发时间：</td>
                <td>
                    <input type="date" class="input start-date must" required>
                    <input type="time" class="input start-clock must" value="08:00" required>
                </td>
            </tr>
            <tr>
                <td class="text-right">结束时间：</td>
                <td>
                    <input type="date" class="input end-date must" required>
                    <input type="time" class="input end-clock must" value="23:30" required>
                </td>
            </tr>
            <tr>
                <td><br><br></td>
                <td>
                    <button class="button border-blue confirm" type="button">保存表单</button>&nbsp;&nbsp;
                    <a class="button" href="${ctx}/activity/showProductActivity?productId=${productId}"> 返回</a>
                </td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
</div>
<script>
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例
    // 如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue_introduce = UE.getEditor('introduce', {autoHeightEnabled: false});
    var ue_process = UE.getEditor('process', {autoHeightEnabled: false});
    var ue_cost = UE.getEditor('cost', {autoHeightEnabled: false});
</script>
</body>
</html>

