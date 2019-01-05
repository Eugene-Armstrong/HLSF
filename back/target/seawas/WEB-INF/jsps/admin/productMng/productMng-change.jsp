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
    <title>产品修改</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <script src="${ctx}/js/jquery.js"></script>
    <script src="${ctx}/js/pintuer.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <style>
        td textarea {
            color: #999;
        }

        td {
            border-top: 0 !important;
        }

        .checkbox label {
            margin: 5px 0
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
            line-height: inherit;
            border-radius: 2px;
        }

        .my-equip-items img {
            width: 100px;
            height: 100px;
        }

        .my-equip-items .media {
            margin-bottom: 10px;
        }

        .my-equip-items .media-body {
            text-align: center;
        }
    </style>
    <script>
        $(function () {
            //图片尺寸校验
//            $("#pic").on("load", function () { //当图片加载完毕执行
//                $("<img/>").attr("src", $("#pic").attr("src")).load(function () {
//                    var realWidth = this.width;
//                    var realHeight = this.height;
//                    if (realWidth != 1000 || realHeight != 450) { //严格规定宽高尺寸
//                        alert("当前所选图片实际尺寸为 " + realWidth + "px * " + realHeight + "px，不符要求，请重新选择");
//                        $("#pic").attr("src", "");
//                    }
//                })
//            });
            var preview = $("#pic");
            var selectMt = $("select[name=multiType]");
            var selectEq = $("select[name=equipments]");
            var selectCity = $("select[name=cities]");
            var req;

            var _picUrl;//原封面图

            //免责富文本
            var _disclaimer = UE.getEditor('disclaimer',{
                autoHeightEnabled:false,
                toolbars: [
                    [
                        'fullscreen',
                        'source',
                        'undo',
                        'redo',
                        'bold',
                        'italic',
                        'underline',
                        'fontborder',
                        'strikethrough',
                        'superscript',
                        'subscript',
                        'removeformat',
                        'formatmatch',
                        'autotypeset',
                        'blockquote',
                        'pasteplain', '|',
                        'forecolor',
                        'backcolor',
                        'insertorderedlist',
                        'insertunorderedlist',
                        'selectall',
                        'cleardoc',
                        'justifyleft', //居左对齐
                        'justifyright', //居右对齐
                        'justifycenter', //居中对齐
                        'justifyjustify', //两端对齐
                        'forecolor', //字体颜色
                        'backcolor' //背景色
                    ]
                ]
            });//免责声明

            //把数据显示在表单中
            $.ajax({
                url: "${ctx}/product/showProductDetailData?id=${id}",//读取文件方式获取
                type: "POST",
                dataType: "text",
                cache:false,
                success: function(data){
                    var content = eval("(" + data + ")");//文本转json

                    var productID = content.id;//产品ID
                    $(".product-id").text(productID);

                    //产品名
                    var productName = content.name;
                    $(".name").val(productName);

                    //封面
                    _picUrl = content.picUrl;
                    $("#pic").attr("src","/photo/product/"+_picUrl);

                    //产品类别
                    var index = parseInt(content.type)-1;
                    $("select[name=singleType] option:eq("+index+")").attr("selected",true);

                    //难度
                    var level = parseInt(content.degreeDifficulty)-1;
                    $("select[name=level] option:eq("+level+")").attr("selected",true);

                    //平均分
                    var avg = content.productAvgVote;
                    $(".score").val(avg);

                    //出发城市
                    var cities = content.cityList;
                    for(var i=0;i<cities.length;i++){
                        $(".cities .my-tags").append("<span class='my-tag close' title='删除' id='"
                            + cities[i].id + "'>" + cities[i].name + "</span>");
                    }
                    if(cities.length>1){
                        selectCity.find("option:last").attr("selected",true);
                    }

                    //目的地
                    var distVal = content.destinationId;
                    $("select[name=dist] option").each(function () {
                        if($(this).val() == distVal){
                            $(this).attr("selected",true);
                        }
                    });

                    //分类
                    var sort = content.classificationList;
                    for(var i=0;i<sort.length;i++){
                        $(".mt .my-tags").append("<span class='my-tag close' title='删除' id='"
                            + sort[i].id + "'>" + sort[i].name + "</span>");
                    }
                    if(sort.length>1){
                        selectMt.find("option:last").attr("selected",true);
                    }

                    //免责声明
                    _disclaimer.ready(function () {
                        _disclaimer.setContent(content.disclaimer);
                    });

                    //装备
                    var equip = content.equipmentList;
                    for(var i=0;i<equip.length;i++){
                        $(".media-inline").append("<div class='media clearfix' id='"+equip[i].id+"'>" +
                            "<img src='/photo/equip/"+equip[i].picUrl+"' class='radius' alt=''>" +
                            "<div class='media-body'>"+equip[i].name+"</div>"+
                            "<div class='media-body text-red'>(￥" +myToFixed(equip[i].price)+ ")</div></div>");
                    }
                    if(equip.length>1){
                        selectEq.find("option:last").attr("selected",true);
                    }
                },error : function(XMLHttpRequest, textStatus, errorThrown) {
                    //解析不正确，则弹出错误信息框
                    console.log("请求文本内容："+XMLHttpRequest.responseText);
                    console.log("请求状态码："+XMLHttpRequest.status);
                    console.log("对象处理状态："+XMLHttpRequest.readyState);
                    console.log(textStatus); // parser error返回类型错误;
                }
            });

            //添加城市
            selectCity.change(function () {
                if($(this).get(0).selectedIndex != 0){
                    var cityTxt = $(this).find("option:selected").text();//选中城市文本
                    var cityVal = $(this).find("option:selected").val();//选中城市value(即tag.id)
                    var check = true;
                    $(".cities .my-tag").each(function () {
                        if(cityVal == $(this).attr("id")){
                            alert("不能重复添加已存在的城市");
                            check = false;
                            return false;
                        }
                    });
                    if(check){
                        //追加指定内容
                        $(".cities .my-tags").append("<span class='my-tag close' title='删除' id='"
                            + cityVal + "'>" + cityTxt + "</span>");
                    }
                    $("body").on("click",".cities .my-tag",function () {
                        $(this).remove();
                    });
                }
            });
            $("body").on("click",".cities .my-tag",function () { //下拉选中值没有变动时的执行删除
                $(this).remove();
            });

            //添加分类
            selectMt.change(function () {
                if($(this).get(0).selectedIndex != 0){
                    var mtTxt = $(this).find("option:selected").text();//选中分类文本
                    var mtVal = $(this).find("option:selected").val();//选中分类value
                    var check = true;
                    $(".mt .my-tag").each(function () {
                        if(mtVal == $(this).attr("id")){
                            alert("不能重复添加已存在的分类");
                            check = false;
                            return false;
                        }
                    });
                    if(check){
                        //追加指定内容
                        $(".mt .my-tags").append("<span class='my-tag close' title='删除' id='"
                            + mtVal + "'>" + mtTxt + "</span>");
                    }
                    $("body").on("click",".mt .my-tag",function () {
                        $(this).remove();
                    });
                }
            });
            $("body").on("click",".mt .my-tag",function () { //下拉选中值没有变动时的执行删除
                $(this).remove();
            });

            //添加装备
            selectEq.change(function () {
                if($(this).get(0).selectedIndex != 0){
                    var eqTxt = $(this).find("option:selected").text();//选中装备文本
                    var eqVal = $(this).find("option:selected").val();//选中装备value
                    var cls = $(this).find("option:selected").attr("class").split(" ");
                    var eqPrice = cls[0];//装备价格
                    var eqPic = cls[1];//装备图片
                    var check = true;
                    $(".media").each(function () {
                        if(eqVal == $(this).attr("id")){
                            alert("不能重复添加已存在的装备");
                            check = false;
                            return false;
                        }
                    });
                    if(check){
                        //追加指定内容
                        $(".media-inline").append("<div class='media clearfix' id='"+eqVal+"'>" +
                            "<img src='/photo/equip/"+eqPic+"' class='radius' alt=''>" +
                            "<div class='media-body'>"+eqTxt+"</div>"+
                            "<div class='media-body text-red'>(￥" +myToFixed(eqPrice)+ ")</div></div>");
                    }
                    $("body").on("dblclick",".media",function () {
                        $(this).remove();
                    });
                }
            });
            $("body").on("dblclick",".media",function () {
                $(this).remove();
            });

            //表单提交事件
            $(".confirm").click(function () {
                var check = true;
                if($(".cities .my-tags").html() == ""){
                    alert("请选择城市");
                    check = false;
                }
                if($(".mt .my-tags").html() == ""){
                    alert("请选择分类");
                    check = false;
                }
                if(check){
                    var nameInput = $(".name"); //名称
                    var scoreInput = $(".score");//评分
                    //var citySelect = $("select[name=cities]");//城市
                    var distSelect = $("select[name=dist]");//目的地
                    var typeSelect = $("select[name=singleType]");//产品类别
                    //var sortSelect = $("select[name=multiType]");//产品分类
                    var levelSelect = $("select[name=level]");//难度
                    //var equipSelect = $("select[name=equipments]");//装备
                    var cv = $("#cover");
                    var _img;//封面图片
                    if(cv.val()==""){
                        _img = preview.attr("src");
                    }else {
                        _img = $("#cover").val();
                    }
                    var disclaimerTxt = $(".disclaimer");
                    var _disclaimerTxt = _disclaimer.getContent();//免责声明内容

                    var _productID = $(".product-id").text();
                    var _name = nameInput.val();
                    var _score = scoreInput.val();
                    var _type = typeSelect.find("option:selected").val();
                    var _dist = distSelect.find("option:selected").val();
                    var _level =  levelSelect.find("option:selected").val();

                    if(_name == ""){
                        nameInput.focus();
                        alert("产品名不能为空");
                        return false;
                    }
//                    if(distSelect.get(0).selectedIndex == "0"){
//                        alert("请选择目的地");
//                        return false;
//                    }
                    if(preview.attr("src")==""){ //没有预览图
                        if (_img == "") {
                            alert("请选择合适的图片");
                            return false;
                        }else { // 检测文件是否为图片类型
                            var point = cv.val().lastIndexOf(".");
                            var fileExt = cv.val().substr(point).toLowerCase();
                            if (!(fileExt == ".jpg" || fileExt == ".png" || fileExt == ".gif" || fileExt == ".bmp" || fileExt == ".jpeg")) {
                                alert("只能上传后缀名为jpg,png,gif,bmp,jpeg等图片文件，请重新选择");
                                return false;
                            }
                        }
                    }
                    if(_disclaimerTxt==""){
                        disclaimerTxt.focus();
                        alert("请输入免责声明");
                        return false;
                    }

                    var citiesArray = new Array();
                    var mtArray = new Array();
                    var eqArray = new Array();

                    //获取所选城市、分类与装备value
                    $(".cities .my-tag").each(function () { // 城市遍历
                        citiesArray.push($(this).attr("id"));
                    });
                    $(".mt .my-tag").each(function () { // 分类遍历
                        mtArray.push($(this).attr("id"));
                    });
                    $(".media").each(function () { // 装备遍历
                        eqArray.push($(this).attr("id"));
                    });
                    //装备为空
                    if($(".my-equip-items .media-inline").html()==""){
                        var _data = {
                            "product_id":_productID,
                            "name":_name,
                            "score":_score,
                            "city":citiesArray,
                            "dist":_dist,
                            "type":"1",
                            "img":_img,
                            "picUrl":_picUrl,
                            "sort":mtArray,
                            "level":_level,
                            "disclaimer":_disclaimerTxt
                        };
                        var data = new FormData(document.getElementById("addForm"));
                        data.append("product_id", _productID);
                        data.append("name", _name);
                        data.append("score", _score);
                        data.append("city", citiesArray);
                        data.append("destinationId", _dist);
                        data.append("type", "1");
                        data.append("picUrl", _picUrl);
                        data.append("sort", mtArray);
                        data.append("degreeDifficulty", _level);
                        data.append("disclaimer", _disclaimerTxt);
                    }else {
//                        var _data = {
//                            "product_id":_productID,
//                            "name":_name,
//                            "score":_score,
//                            "city":citiesArray,
//                            "dist":_dist,
//                            "type":"1",
//                            "img":_img,
//                            "picUrl":_picUrl,
//                            "sort":mtArray,
//                            "level":_level,
//                            "equip":eqArray,
//                            "disclaimer":_disclaimerTxt
//                        };
                        var data = new FormData(document.getElementById("addForm"));
                        data.append("product_id", _productID);
                        data.append("name", _name);
                        data.append("score", _score);
                        data.append("city", citiesArray);
                        data.append("destinationId", _dist);
                        data.append("type", "1");
                        data.append("picUrl", _picUrl);
                        data.append("sort", mtArray);
                        data.append("degreeDifficulty", _level);
                        data.append("equip", eqArray);
                        data.append("disclaimer", _disclaimerTxt);
                    }
                    //var json = JSON.stringify(_data);
                    //alert(json); //打印测试

                    if (req == null){
                        req = $.ajax({
                            type:'post',
                            cache:false,
                            url: "${ctx}/product/updateProduct", // 请求处理页
                            dataType: "json",
                            data: data,
//                        headers:{
//                            Accept:"application/json",
//                            "Content-Type":"application/json"
//                        },
                            processData: false,
                            contentType: false,
                            success: function(result) {
                                window.location.href = "${ctx}/activity/showProductActivity?productId=" +  result['productId'];
                                <%--window.location.href = "${ctx}/activity/showProduct";--%>
                            },
                            error: function () {
                                alert("系统繁忙，请稍后再试");
                            }
                        });
                    }
                }
            });
        });
        //选择图片并预览(需要当前浏览器支持FileReader接口)
        function uploadImg(obj) {
            var file = obj.files[0];
            var reader = new FileReader();
            reader.onload = function (e) { // 成功读取
                var img = document.getElementById("pic");
                img.src = this.result;
            };
            reader.readAsDataURL(file);
        }
        function myToFixed(price) {
            var result = Number(Number(price) * 0.01).toFixed(2);
            return result;
        }
    </script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-pencil-square-o"></span> 修改产品</strong>
    </div>
    <form action="" name="addActivity" id="addForm">
        <table class="table table-hover">
            <tr style="display: none;">
                <td class="product-id"></td>
            </tr>
            <tr>
                <td class="text-right" style="min-width: 120px">产品名称：</td>
                <td width="20%">
                    <input type="text" class="input name" placeholder="请输入产品名称" required>
                </td>
                <td width="15%"></td>
                <td rowspan="13">
                    免责声明：
                    <script id="disclaimer" type="text/plain"
                            style="margin-top:10px;width:400px;height:600px;"></script>
                </td>
                <td width="5%"></td>
            </tr>
            <tr>
                <td class="text-right" style="width: 120px">产品评分：</td>
                <td><input type="number" class="input score" value="5.0" readonly></td>
                <td></td>
            </tr>
            <tr>
                <td class="text-right">出发城市：</td>
                <td>
                    <select class="input" name="cities">
                        <option value="">请选择城市(多选)</option>
                        <c:forEach items="${cityList}" var="citys">
                            <option value="${citys.id}">${citys.name}</option>
                        </c:forEach>
                    </select>
                </td>
                <td></td>
            </tr>
            <tr class="cities">
                <td></td>
                <td colspan="3" class="my-tags"></td>
                <td></td>
            </tr>
            <tr>
                <td class="text-right">目的地：</td>
                <td>
                    <select class="input" name="dist" required>
                         <option value="">请选择目的地</option>
                            <c:forEach items="${destinationList}" var="destination">
                            <option value="${destination.id}">${destination.name}</option>
                            </c:forEach>
                    </select>
                </td>
                <td></td>
            </tr>
            <tr>
                <td class="text-right">产品类别：</td>
                <td>
                    <select class="input" name="singleType" readonly="">
                        <option value="1">普通</option>
                        <option value="2">定制</option>
                        <option value="3">约伴</option>
                    </select>
                </td>
                <td></td>
            </tr>
            <tr>
                <td class="text-right">封面图片：</td>
                <td colspan="2">
                    <label class="button border-blue" for="cover">
                        选择图片
                    </label>
                    <span style="color: #999"> (图片实际尺寸推荐为1000px * 450px)</span>
                    <input type="file" name="file" id="cover" onchange="uploadImg(this)" accept="*" style="display: none"/>
                </td>
            </tr>
            <tr>
                <td></td>
                <td colspan="2"><img src="" alt="封面图预览区" id="pic" width="300px"></td>
            </tr>
            <tr>
                <td class="text-right" width="200px">产品分类：</td>
                <td>
                    <select class="input" name="multiType">
                        <option value="">请选择分类(多选)</option>
                        <c:forEach items="${sortList}" var="sort">
                            <option value="${sort.id}">${sort.name}</option>
                        </c:forEach>
                    </select>
                </td>
                <td></td>
            </tr>
            <tr class="mt">
                <td></td>
                <td colspan="3" class="my-tags"></td>
                <td></td>
            </tr>
            <tr>
                <td class="text-right">难度：</td>
                <td>
                    <select class="input" name="level">
                        <option value="1">★</option>
                        <option value="2">★★</option>
                        <option value="3">★★★</option>
                        <option value="4">★★★★</option>
                        <option value="5">★★★★★</option>
                    </select>
                </td>
                <td></td>
            </tr>
            <tr>
                <td class="text-right">对应装备：</td>
                <td>
                    <select class="input" name="equipments">
                        <option value="">请选择装备(多选)</option>
                        <c:forEach items="${equipmentList}" var="equio">
                            <option value="${equio.id}" class="${equio.price} ${equio.picUrl}">${equio.name}</option>
                        </c:forEach>
                    </select>
                </td>
                <td style="color: #999">（双击装备图取消选择）</td>
                <td></td>
            </tr>
            <tr class="my-equip-items">
                <td></td>
                <td colspan="2">
                    <div class="media-inline"></div>
                </td>
            </tr>
            <tr>
                <td><br><br></td>
                <td colspan="2">
                    <button class="button border-green confirm" type="button">保存修改</button>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:history.back()" class="button border-red">取消</a>
                </td>
            </tr>
            <tr><td></td></tr>
        </table>
    </form>
</div>
</body>
</html>

