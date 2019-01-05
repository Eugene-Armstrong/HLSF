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
    <title>装备管理</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <script src="${ctx}/js/jquery.js"></script>
    <script src="${ctx}/js/pintuer.js"></script>
    <script>
        $(function () {
            var $eqName = $("input[name=equipName]"),
                $eqPrice = $("input[name=equipPrice]");
            //图片尺寸校验
//            $("#pic").on("load",function () { //当图片加载完毕执行
//                $("<img/>").attr("src", $("#pic").attr("src")).load(function() {
//                    var realWidth = this.width;
//                    var realHeight = this.height;
//                    if(realWidth != 400 || realHeight != 400){ //严格规定宽高尺寸
//                        alert("当前所选图片实际尺寸为 "+realWidth+"px * "+realHeight+"px，不符要求，请重新选择");
//                        $("#pic").attr("src","");
//                    }
//                })
//            });
            $("form").submit(function () {
                if($("#pic").attr("src")==""){ //图片为空
                    alert("请选择合适的图片");
                    return false;
                }
                else { // 检测文件是否为图片类型
                    var point = $("#cover").val().lastIndexOf(".");
                    var fileExt = $("#cover").val().substr(point).toLowerCase();
//                    alert(fileExt);//测试
                    if(!(fileExt == ".jpg"||fileExt == ".png"||fileExt == ".gif"||fileExt == ".bmp"||fileExt == ".jpeg")){
                        alert("只能上传后缀名为jpg,png,gif,bmp,jpeg等图片文件，请重新选择");
                        return false;
                    }else{
                        var eqPrice = parseInt(Number(Number($eqPrice.val())
                                .toFixed(2)) * 100);
                        $eqPrice.val(eqPrice);
                    }
                }
            });

            var equipSelected = "";
            //选择装备传值
            $(".delete-btn").click(function () {
                var t = $("select");
                if(t.get(0).selectedIndex == 0){
                    alert("请先选择要删除的装备");
                }else{
                    equipSelected = t.find("option:selected").val();
                    $.ajax({
                        type:"post",
                        url: "${ctx}/equip/deleteEquipment", // 请求处理页
                        dataType: "html",
                        data: {equipSelected: equipSelected},
                        success: function (result) {
                            if (result == '1'){
                                alert("删除成功！");
                            }else {
                                alert("删除失败，请重新尝试！");
                            }
                            window.location.href = "${ctx}/equip/equipmentPage";
                        },
                        error:function () {
                            alert("系统繁忙，请稍后再试");
                        }
                    });
                }
            });

            // 保存
            $(document).on("click",".bg-green",function () {
                if($eqName.val() == ""){
                    alert("装备名不能为空");
                    $eqName.focus();
                }else if($eqPrice.val() == ""){
                    alert("请输入装备价格");
                    $eqPrice.focus();
                }else{
                    $("form").submit();
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
            reader.readAsDataURL(file)
        }
    </script>
    <style>
        td .input{
            display: inline;
        }
        td textarea{
            color: #999;;
        }
        td{border-top: 0!important;}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-tags"></span> 装备管理</strong>
    </div>
    <table class="table table-hover">
        <tr>
            <td class="text-right" width="20%">删除装备：</td>
            <td>
                <select class="input">
                    <option value="">请选择要删除的装备</option>
                    <c:forEach items="${equipmentList}" var="equip">
                        <option value="${equip.id}">${equip.name}</option>
                    </c:forEach>
                </select>
                <button class="button border-red delete-btn">
                    删除
                </button>
            </td>
        </tr>
    </table>
    <form action="${ctx}/equip/addEquipment" method="post" enctype="multipart/form-data">
        <table class="table table-hover">
            <tr>
                <td class="text-right" width="20%">添加装备：</td>
                <td>
                    <input type="text" class="input" placeholder="请输入新的装备" name="equipName">
                </td>
            </tr>
            <tr>
                <td class="text-right">装备价格：</td>
                <td>
                    <input type="text" class="input" placeholder="请输入装备价格" name="equipPrice">
                    <label>元</label>
                </td>
            </tr>
            <tr>
                <td class="text-right">装备图片：</td>
                <td>
                    <label class="button border-blue" for="cover">
                        选择图片
                    </label>
                    <span style="color: #999"> （图片实际尺寸推荐为 400px * 400px）</span>
                    <input type="file" id="cover" onchange="uploadImg(this)" accept="*" style="display: none" name="equipPic"/>
                </td>
            </tr>
            <tr>
                <td></td>
                <td><img src="" alt="图片预览区" id="pic"
                         style="max-width: 300px;max-height: 300px"></td>
            </tr>
            <!--
             <tr>
                <td class="text-right">删除装备：</td>
                <td>
                    <select class="input">
                        <option value="">请选择要删除的装备</option>
                        <c:forEach items="${equipmentList}" var="equip">
                            <option value="${equip.id}">${equip.name}</option>
                        </c:forEach>
                    </select>
                    <button class="button border-red delete-btn">
                        删除
                    </button>
                </td>
            </tr>
             -->
            <tr>
                <td class="text-right">已添加：</td>
                <td>
                    <textarea rows="3" class="input"  readonly>${equipments}</textarea>
                </td>
            </tr>
            <tr>
                <td class="text-right"></td>
                <td>
                    <button type="button" class="button bg-green">保存</button>
                </td>
            </tr>
            <tr><td></td></tr>
        </table>
    </form>
</div>
</body>
</html>
