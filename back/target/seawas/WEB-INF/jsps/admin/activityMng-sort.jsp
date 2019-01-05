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
    <title>分类管理</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        td .input{
            display: inline;
        }
        td textarea{
            color: #999;;
        }
        td{border-top: 0!important;}
        .media img {
            width: 64px;
            height: 64px;
        }
        .media-body{text-align: center}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-tags"></span> 分类管理</strong>
    </div>
    <form action="" target="my_iframe" id="addForm">
        <table class="table table-hover">
        <tr>
            <td class="text-right" width="20%">添加分类：</td>
            <td>
                <input type="text" name="name" class="input" placeholder="请输入新的分类" required>
                <button type="button" class="button border-blue add">添加</button>
            </td>
        </tr>
        <tr>
            <td class="text-right">分类图标：</td>
            <td>
                <label class="button border-blue" for="cover">
                    选择图片
                </label>
                <span style="color: #999">（图标实际尺寸推荐为 64px * 64px）</span>
                <input type="file" name="pic" id="cover" onchange="uploadImg(this)" accept="*" style="display: none"/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><img src="" alt="图片预览区" id="pic" style="max-width: 80px;max-height: 80px"></td>
        </tr>
    </table>
    </form>
    <iframe id="my_iframe" name="my_iframe" style="display:none;"></iframe>
    <table class="table">
        <tr>
            <td class="text-right" width="20%">已添加：</td>
            <td>
                <div class="media-inline">
                    <c:forEach var="sort" items="${categoryList}">
                        <div class="media clearfix">
                            <a href="#">
                                <img src="/photo/sort/${sort.picUrl}" class="radius" alt="">
                            </a>
                            <div class="media-body">${sort.name}</div>
                        </div>
                    </c:forEach>
                </div>
            </td>
        </tr>
    </table>
    <form action="">
        <table class="table">
            <tr>
                <td class="text-right" width="20%">删除分类：</td>
                <td>
                    <select class="input" required id="deleteSelect">
                        <c:forEach var="sort" items="${categoryList}">
                            <option value="${sort.id}">${sort.name}</option>
                        </c:forEach>
                    </select>
                    <button class="button border-red" onclick="deleteCategory()">删除</button>
                </td>
            </tr>
        </table>
    </form>

</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        //图片尺寸校验
//            $("#pic").on("load",function () { //当图片加载完毕执行
//                $("<img/>").attr("src", $("#pic").attr("src")).load(function() {
//                    var realWidth = this.width;
//                    var realHeight = this.height;
//                    if(realWidth != 64 || realHeight != 64){ //严格规定宽高尺寸
//                        alert("当前所选图片实际尺寸为 "+realWidth+"px * "+realHeight+"px，不符要求，请重新选择");
//                        $("#pic").attr("src","");
//                    }
//                })
//            });
        //添加分类
        $(".add").click(function () {
            var check = true,
                sortName = $(this).prev().val(), //分类名
                fileVal = $("#cover").val(), //文件选择控件value
                picSrc = $("#pic").attr("src");//预览图src
            if(sortName == ""){
                alert("分类名不能为空");
                $(this).prev().focus();
                check = false;
            }else{
                //重复校验
                $(".media-body").each(function () {
                    if($(this).text() == sortName){
                        alert("不能添加已存在的分类");
                        check = false;
                        return false;
                    }
                });
            }
            if(check){
                if(picSrc==""){ //图片为空
                    alert("请选择合适的图片");
                    return false;
                }
                else { // 检测文件是否为图片类型
                    var point = fileVal.lastIndexOf(".");
                    var fileExt = fileVal.substr(point).toLowerCase();
                    if(!(fileExt == ".jpg"||fileExt == ".png"||fileExt == ".gif"||fileExt == ".bmp"||fileExt == ".jpeg")){
                        alert("只能上传后缀名为jpg,png,gif,bmp,jpeg等图片文件，请重新选择");
                        return false;
                    }else{
                        var form = new FormData(document.getElementById("addForm"));
                        $.ajax({
                            url: "${ctx}/admin/category/save",
                            type: "POST",
                            dataType: "json",
                            processData: false,
                            contentType: false,
                            data: form,
                            success: function (data) {
                                if (data.code == 200) {
                                    alert(data.message);
                                    location.reload();
                                } else {
                                    alert(data.message);
                                }
                            },
                            error: function () {
                                alert("系统繁忙");
                            }
                        });
                    }
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
    function deleteCategory() {
        var sure = confirm("确定删除该分类吗");
        if(sure){
            $.ajax({
                url: "${ctx}/admin/category/delete",
                type: "POST",
                dataType: "json",
                data: {"id": $('#deleteSelect').val()},
                success: function (data) {
                    if (data.code == 200) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                }
            });
        }
    }
</script>
</body>
</html>
