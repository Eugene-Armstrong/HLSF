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
    <title>添加产品</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <script src="${ctx}/js/jquery.js"></script>
    <script src="${ctx}/js/pintuer.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加载语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型
        比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
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
        .media-body{margin-bottom: 2px}
        .price{color: red;text-align: center}
        .input{width: 100%}
    </style>
    <script>
        $(function () {
            var score;
            var scoreInput;
            var req;
            $("body").on("change", ".score", function () {
                scoreInput = $(this);
                score = parseFloat(scoreInput.val());

                if (score < 0) {
                    alert("评分不得少于0分，请重新输入");
                    scoreInput.val("");
                    score = scoreInput.val();
                    scoreInput.focus();
                }
                if (score > 5) {
                    alert("评分不得超过5分，请重新输入");
                    scoreInput.val("");
                    score = scoreInput.val();
                    scoreInput.focus();
                }
            });
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

            var selectMt = $("select[name=multiType]");
            var selectEq = $("select[name=equipments]");
            var selectCity = $("select[name=cities]");

            // 记录分类下拉选项状态值（是否已选）的映射数组
            var mtL = selectMt.find("option").length;
            var mt = new Array(mtL);
            for (var i = 0; i < mtL; i++) {
                mt[i] = 0; //默认未选状态值为0
            }
            var mt_index;

            // 记录装备下拉选项状态值（是否已选）的映射数组
            var eqL = selectEq.find("option").length;
            var eq = new Array(eqL);
            for (var j = 0; j < eqL; j++) {
                eq[j] = 0; //默认未选状态值为0
            }
            var eq_index;

            //添加城市
            selectCity.change(function () {
                if($(this).get(0).selectedIndex != 0){
                    var citiesTxt = $(this).find("option:selected").text();//选中城市文本
                    var citiesVal = $(this).find("option:selected").val();//选中城市value
                    var check = true;
                    $(".cities .my-tag").each(function () {
                        if(citiesVal == $(this).attr("id")){
                            alert("不能重复添加已存在的城市");
                            check = false;
                            return false;
                        }
                    });
                    if(check){
                        //追加指定内容
                        $(".cities .my-tags").append("<span class='my-tag close' title='删除' id='"
                            + citiesVal + "'>" + citiesTxt + "</span>");
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
                    mt_index = $(this).get(0).selectedIndex; //选中项index
                    if (mt_index != 0) { //选中非默认项后触发
                        if (mt[mt_index] == 0) { //所选项为未选状态
                            //追加指定内容
                            $(".mt .my-tags").append("<span class='my-tag close "+mt_index+"' title='删除' id='" + mtVal + "'>" + mtTxt + "</span>");
                            mt[mt_index] = 1;//设已选状态值为1
                        } else {
                            alert("不能重复添加已存在的分类");
                        }
                    }
                    $(".mt .my-tag").click(function () {
                        $(this).remove();
                        var _class = $(this).attr("class");
                        mt[_class.substr(_class.length - 1, 1)] = 0; //恢复为未选状态(索引值为id最后一位)
                    });
                }
            });
            $(".mt .my-tag").click(function () { //下拉选中值没有变动时的执行删除
                $(this).remove();
                var _class = $(this).attr("_class");
                mt[_class.substr(_class.length - 1, 1)] = 0; //恢复为未选状态
            });

            //添加装备
            selectEq.change(function () {
                if($(this).get(0).selectedIndex != 0){
                    var eqTxt = $(this).find("option:selected").text();//选中装备名
                    var eqVal = $(this).find("option:selected").val();//选中装备value
                    var cls = $(this).find("option:selected").attr("class").split(" ");
                    var eqPrice = cls[0];//装备价格
                    var eqPic = "/photo/equip/" + cls[1];//装备图片
                    eq_index = $(this).get(0).selectedIndex; //选中项index
                    if (eq_index != 0) {
                        if (eq[eq_index] == 0) {
                            $(".media-inline").append("<div class='media clearfix "+eq_index+"' id='" + eqVal + "'>" +
                                "<a title='双击取消选择'><div class='media-body'>" + eqTxt + "</div><img src='"+eqPic+"' class='radius' alt=''></a>" +
                                "<div class='price'>"+myToFixed(eqPrice)+"</div></div>");
                            eq[eq_index] = 1;
                        } else {
                            alert("不能重复添加已存在的装备");
                        }
                    }
                    $(".media").dblclick(function () {
                        $(this).remove();
                        var _class = $(this).attr("class");
                        eq[_class.substr(_class.length - 1, 1)] = 0; //恢复为未选状态(索引值为id最后一位)
                    });
                }
            });
            $(".media").dblclick(function () {
                $(this).remove();
                var _class = $(this).attr("class");
                eq[_class.substr(_class.length - 1, 1)] = 0; //恢复为未选状态(索引值为id最后一位)
            });

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
                        'fontfamily', //字体
                        'insertorderedlist',
                        'insertunorderedlist',
                        'selectall',
                        'cleardoc',
                        'justifyleft', //居左对齐
                        'justifycenter', //居中对齐
                        'justifyright', //居右对齐
                        'justifyjustify' //两端对齐
                    ]
                ]
            });

            //表单提交事件
            $(".confirm").on("click",function (){
                var nameInput = $(".name"),
                    scoreInput = $(".score"),
                    citiesSelect = $("select[name=cities]"),
                    distSelect = $("select[name=dist]"),
                    typeSelect = $("select[name=multiType]"),
                    levelSelect = $("select[name=level]"),
                    customizedId = $(".customizedId");
                var _disclaimerTxt = _disclaimer.getContent();//免责声明内容
//                var equipSelect = $("select[name=equipments]");

                var _name = nameInput.val();//产品名称
                var _customizedId = customizedId.val();
                var _score = parseFloat(scoreInput.val()).toFixed(2);//评分
                var _dist = distSelect.find("option:selected").val();
                var _img = $("#cover").val();
                var _level = levelSelect.find("option:selected").val();

                if(_name == ""){
                    nameInput.focus();
                    alert("产品名不能为空");
                    return false;
                }
                if(scoreInput.val() == ""){
                    scoreInput.focus();
                    alert("产品评分请输入正确的数字");
                    scoreInput.val("");
                    return false;
                }
                if(citiesSelect.get(0).selectedIndex == "0"){
                    alert("请选择城市");
                    return false;
                }
//                if(distSelect.get(0).selectedIndex == "0"){
//                    alert("请选择目的地");
//                    return false;
//                }
                if(typeSelect.get(0).selectedIndex == "0"){
                    alert("请选择分类");
                    return false;
                }
                if(_disclaimerTxt==""){
                    alert("请输入免责声明");
                    return false;
                }
                if ($("#pic").attr("src") == "") { //图片为空
                    alert("请选择合适的图片");
                    return false;
                }
                else { // 检测文件是否为图片类型
                    var cv = $("#cover");
                    var point = cv.val().lastIndexOf(".");
                    var fileExt = cv.val().substr(point).toLowerCase();
                    if (!(fileExt == ".jpg" || fileExt == ".png" || fileExt == ".gif" || fileExt == ".bmp" || fileExt == ".jpeg")) {
                        alert("只能上传后缀名为jpg,png,gif,bmp,jpeg等图片文件，请重新选择");
                        return false;
                    }
                }
                var citiesArray = [],
                    mtArray = [],
                    eqArray = [];
//                var eqObj = new Object();
                //获取所选城市、分类与装备value
                $(".cities .my-tag").each(function () { // 城市遍历
                    citiesArray.push($(this).attr("id"));
                });
                $(".mt .my-tag").each(function () { // 分类遍历
                    mtArray.push($(this).attr("id"));
                });
                $(".media").each(function () { // 装备遍历
//                    var eqObj = {};
//                    eqObj.id = $(this).attr("id");
//                    eqObj.name = $(this).find(".media-body").text();
//                    eqObj.price = $(this).find(".price").text();
//                    eqObj.picUrl = $(this).find(".pic").text();
                    eqArray.push($(this).attr("id"));
                });

                //装备为空
                if($(".my-equip-items .media-inline").html()==""){
//                    var _data = {
//                        "name":_name,
//                        "customizedId":_customizedId,
//                        "score":_score,
//                        "cities":citiesArray,
//                        "dist":_dist,
//                        "type":"1",
//                        "img":_img,
//                        "sort":mtArray,
//                        "level":_level,
//                        "disclaimer":_disclaimerTxt
//                    };
                    var data = new FormData(document.getElementById("addForm"));
                    data.append("name", _name);
                    data.append("customizedId",_customizedId);
                    data.append("score", _score);
                    data.append("city", citiesArray);
                    data.append("destinationId",_dist);
                    data.append("type", "1");
                    data.append("sort", mtArray);
                    data.append("degreeDifficulty", _level);
                    data.append("disclaimer", _disclaimerTxt);
                }else {
//                    var _data = {
//                        "name":_name,
//                        "score":_score,
//                        "customizedId":_customizedId,
//                        "cities":citiesArray,
//                        "dist":_dist,
//                        "type":"1",
//                        "img":_img,
//                        "sort":mtArray,
//                        "level":_level,
//                        "equip":eqArray,
//                        "disclaimer":_disclaimerTxt
//                    };
                    var data = new FormData(document.getElementById("addForm"));
                    data.append("name", _name);
                    data.append("score", _score);
                    data.append("customizedId",_customizedId);
                    data.append("city", citiesArray);
                    data.append("destinationId",_dist);
                    data.append("type", "1");
                    data.append("sort", mtArray);
                    data.append("degreeDifficulty", _level);
                    data.append("disclaimer", _disclaimerTxt);
                    data.append("equip", eqArray);
                }
                //alert(JSON.stringify(_data)); //打印测试


                if (req == null){
                    req = $.ajax({
                        type:'post',
                        cache:false,
                        url: "${ctx}/product/addProduct", // 请求处理页
                        dataType: "json",
                        processData: false,
                        contentType: false,
                        data: data,
//                    headers:{
//                        Accept:"application/json",
//                        "Content-Type":"application/json"
//                    },
//                    processData:false,
//                    cache:false,
                        beforeSend:function(XMLHttpRequest){
                            $(".confirm").text("添加中…").attr("readonly",true);
                        },
                        success: function(result) {
                            window.location.href = "${ctx}/activity/showProductActivity?productId=" +  result['productId'];
                            <%--window.location.href = "${ctx}/product/showProduct";--%>
                            alert('产品添加成功！');
                        },
                        error: function () {
                            alert("系统繁忙，请稍后再试");
                        }
                    });
                }

            })
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
        <strong><span class="icon-plus-square-o"></span> 添加产品</strong>
    </div>
    <form action="" name="addActivity" id="addForm">
        <table class="table table-hover">
            <tr>
                <input  name="customizedId" type="hidden" class="input customizedId" value="${customizedId}">
            </tr>
            <tr>
                <td class="text-right" width="200px">产品名称：</td>
                <td width="20%">
                    <input type="text" class="input name" placeholder="请输入产品名称" name="" required>
                </td>
                <td width="15%"></td>
                <td rowspan="14">
                    免责声明：
                    <script id="disclaimer" type="text/plain"
                            style="margin-top:10px;width:400px;height:600px"></script>
                </td>
                <td width="5%"></td>
            </tr>
            <tr>
                <td class="text-right" style="width: 120px" name="">产品评分：</td>
                <td><input type="number" class="input score" placeholder="请输入产品默认评分" required></td>
                <td></td>
            </tr>
            <tr>
                <td class="text-right">出发城市：</td>
                <td>
                    <select class="input" name="cities" required>
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
                <td colspan="2" class="my-tags"></td>
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
                    <input type="text" class="input" value="普通" readonly>
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
                <td class="text-right">产品分类：</td>
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
                <td colspan="2" class="my-tags"></td>
            </tr>
            <tr>
                <td class="text-right">难度：</td>
                <td>
                    <select class="input" name="level">
                        <option value="1">1星 ★</option>
                        <option value="2">2星 ★★</option>
                        <option value="3">3星 ★★★</option>
                        <option value="4">4星 ★★★★</option>
                        <option value="5">5星 ★★★★★</option>
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
            </tr>
            <tr class="my-equip-items">
                <td></td>
                <td colspan="2">
                    <div class="media-inline"></div>
                </td>
            </tr>
            <tr>
                <td><br><br></td>
                <td>
                    <button class="button border-blue confirm" type="button">确定添加</button>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="${ctx}/product/showProduct" class="button border-red">取消</a>
                </td>
                <td></td>
            </tr>
            <tr><td></td></tr>
        </table>
    </form>
</div>
</body>
</html>
