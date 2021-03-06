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
    <title>添加推送</title>
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
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-file-text"></span> 添加推送</strong>
        <a href="javascript:history.back()" class="icon-reply float-right"> 返回</a>
    </div>
    <form action="" method="post" enctype="multipart/form-data" id="addForm">
        <input type="hidden" name="type" value="${outdoor.type}"/>
        <table class="table table-hover">
            <tr>
                <td class="text-right" width="20%">推送标题：</td>
                <td>
                    <input type="text" class="input" placeholder="请输入推送标题" name="title">
                </td>
            </tr>
            <tr>
                <td class="text-right">推送封面：</td>
                <td>
                    <label class="button border-blue" for="cover">
                        选择图片
                    </label>
                    <span style="color: #999"> （图片实际尺寸推荐为 400px * 200px）</span>
                    <input type="file" id="cover" onchange="uploadImg(this)" accept="*" style="display: none" name="file"/>
                </td>
            </tr>
            <tr>
                <td></td>
                <td><img src="" alt="图片预览区" id="pic" style="max-width: 300px;max-height: 300px"></td>
            </tr>
            <tr>
                <td class="text-right" width="20%">推送链接：</td>
                <td>
                    <input type="text" class="input" placeholder="请输入有效的推送链接" name="webURL">
                </td>
            </tr>
            <tr>
                <td class="text-right"></td>
                <td>
                    <button type="button" class="button bg-blue" id="add">确认添加</button>
                    &nbsp;&nbsp;
                    <a href="javascript:history.back()" class="button border-red">取消</a>
                </td>
            </tr>
            <tr><td></td></tr>
        </table>
    </form>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script>
    $(function () {
        var wxNews = {
            title:$("input[name=title]"),
            webURL:$("input[name=webURL]")
        };
        $("#add").click(function () {
            var self = $(this);
            if(wxNews.title.val() == ""){
                wxNews.title.focus();
                alert("推送名称不能为空");
                return false;
            }
            if(wxNews.webURL.val() == ""){
                wxNews.webURL.focus();
                alert("推送链接不能为空");
                return false;
            }
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
                }
            }
            var form = new FormData(document.getElementById("addForm"));
            $.ajax({
                url: "${ctx}/admin/outdoor/add",
                type: "POST",
                dataType: "json",
                processData: false,
                contentType: false,
                data: form,
                beforeSend:function(){
                    self.text("添加中,请稍候…").attr("disabled",true);
                },
                success: function (data) {
                    if (data.code == 200) {
                        alert(data.message);
                        location.href = "${ctx}/admin/outdoor/list?type=${outdoor.type}"
                    } else {
                        alert(data.message);
                        self.text("确认添加").attr("disabled",false);
                    }
                },
                error: function () {
                    alert("系统繁忙，请稍后再试");
                }
            });
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
</body>
</html>
