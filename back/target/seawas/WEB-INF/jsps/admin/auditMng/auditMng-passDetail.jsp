<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>产品详情</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        .panel-head{line-height: 42px}
        .equip img {
            height: 64px;
        }
        .img{width: 200px;height:100px;}
        .panel{margin-bottom: 30px}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-cube"></span> 产品详情</strong>
        <a href="javascript:history.back()" style="margin-right: 5px"
           class="button border-blue float-right">返回</a>
    </div>
    <table class="table table-hover table-bordered text-center">
        <tr>
            <th>名称</th>
            <th colspan="2">封面</th>
            <th>类别</th>
            <th>难度</th>
            <th>浏览量</th>
            <th>平均分</th>
            <th>1星评</th>
            <th>2星评</th>
            <th>3星评</th>
            <th>4星评</th>
            <th>5星评</th>
            <th>评分总人数</th>
        </tr>
        <tr>
            <td class="name"></td>
            <td colspan="2">
                <img src="" class="img" alt="活动封面">
            </td>
            <td class="type"></td>
            <td class="level"></td>
            <td class="visited"></td>
            <td class="avg"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr><td colspan="20"></td></tr>
        <tr>
            <th>出发城市</th>
            <th colspan="2">分类</th>
            <th>创建时间</th>
            <th colspan="3">创建者</th>
            <th colspan="3">更新时间</th>
            <th colspan="3">更新者</th>
        </tr>
        <tr>
            <td class="city"></td>
            <td class="sort" colspan="2"></td>
            <td class="createT"></td>
            <td class="createUser" colspan="3"></td>
            <td colspan="3"></td>
            <td colspan="3"></td>
        </tr>
        <tr><td colspan="20"></td></tr>
        <tr>
            <th colspan="20">对应装备</th>
        </tr>
        <tr>
            <td colspan="20" class="equip">
                <div class="media-inline"></div>
            </td>
        </tr>
    </table>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script>
    $(function () {
        //把数据显示在table中
        $.ajax({
            url: "${ctx}/product/showProductDetailData?id=${id}",//读取文件方式获取
            type: "POST",
            dataType: "text",
            success: function(data){
                var content = eval("(" + data + ")");//文本转json
                //var productID = content.id;//产品ID
                //产品名
                var productName = content.name;
                $(".name").text(productName);

                //封面
                var pic = content.picUrl;
                $(".img").attr("src","/photo/product/"+pic);

                //产品类别
                var type = "";
                switch (content.type){
                    case "1":type = "普通";break;
                    case "2":type = "定制";break;
                    case "3":type = "约伴";break;
                }
                $(".type").text(type);

                //难度
                var level = "";
                for(var i=0;i<content.degreeDifficulty;i++){
                    level+="★";
                }
                $(".level").text(level);

                //浏览量
                var visited = content.readNumber;
                $(".visited").text(visited);

                //平均分
                var avg = content.productAvgVote;
                $(".avg").text(avg);

                //出发城市
                var cities = "";
                for(var i=0;i<content.cityList.length;i++){
                    cities += content.cityList[i].name+", ";
                }
                cities = cities.substring(0,cities.length-2);
                $(".city").text(cities);

                //分类
                var sort = "";
                for(var i=0;i<content.classificationList.length;i++){
                    sort += content.classificationList[i].name+", ";
                }
                sort = sort.substring(0,sort.length-2);
                $(".sort").text(sort);

                //创建时间
                var createT;
                var d = new Date(content.createTime);
                var yy = d.getFullYear();
                var mm = d.getMonth()+1;
                var day = d.getDate();
                var h = d.getHours();
                var m = d.getMinutes();
                createT = yy +"-"+mm+"-"+day+" ("+h+":"+m+")";
                $(".createT").text(createT);

                //创建者name
                var createUser = content.createUser.realName;
                $(".createUser").text(createUser);

                //装备
                var equip = content.equipmentList;
                for(var i=0;i<equip.length;i++){
                    $(".media-inline").append("<div class='media clearfix'>" +
                        "<img src='/photo/"+equip[i].picUrl+"' class='radius' alt=''>" +
                        "<div class='media-body'>"+equip[i].name+"</div>"+
                        "<div class='media-body text-red'>(￥" +(equip[i].price * 0.01)+ ")</div></div>");
                }
            },error : function(XMLHttpRequest, textStatus, errorThrown) {
                //解析不正确，则弹出错误信息框
                console.log("请求文本内容："+XMLHttpRequest.responseText);
                console.log("请求状态码："+XMLHttpRequest.status);
                console.log("对象处理状态："+XMLHttpRequest.readyState);
                console.log(textStatus); // parser error返回类型错误;
            }
        });
    })
</script>
</body>
</html>
