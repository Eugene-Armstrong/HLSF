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
    <title>查看上传相册列表</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        /*CSS3实现瀑布流*/
        .container {
            width: 100%;
            background: #eee;
        }

        /*瀑布流层*/
        .waterfall {
            -moz-column-count: 4; /* Firefox */
            -webkit-column-count: 4; /* Safari 和 Chrome */
            column-count: 4;
            -moz-column-gap: 1em;
            -webkit-column-gap: 1em;
            column-gap: 1em;
        }

        /*一个内容层*/
        .item {
            background: #ffffff;
            padding: 1em;
            margin: 0 0 1em 0;
            -moz-page-break-inside: avoid;
            -webkit-column-break-inside: avoid;
            break-inside: avoid;
        }

        .item img {
            cursor: pointer;
            width: 100%;height:200px;
            margin-bottom: 10px;
        }

        /*自定义照片大图查看模态框*/
        .custom-mask {
            display: none;
            top: 0;
            position: absolute;
            width: 100%;
            background: #000000;
            opacity: 0.7;
        }

        .custom-dialog {
            background-color: rgba(0, 0, 0, 0) !important;
            display: none;
            position: absolute;
            border-radius: 4px;
            background-color: #fff;
            max-width: 80%;
        }

        .close {
            position: absolute;
            color: #fff;
            top:10px;
            right: 10px;
            display: none;
            font-size: 50px;
        }
        .my-info{
            float: right;
            margin-right: 40px;
        }
        .check{display: none;width: 24px!important;height: 24px!important;margin: 0!important;}
        #group{cursor: pointer;margin-right: 20px}
        #group:hover{color: #37a1ff}
        #cancel,#pass,#fail,.all{cursor: pointer;display: none;margin-right: 10px}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-check-square-o"></span> 用户(${album.user.nickName})上传的照片</strong>
        <span class="icon-check-circle-o float-right" id="group"> 批量审核</span>
        <span class="icon-ban float-right" id="cancel"> 取消</span>
        <span class="icon-times float-right text-red" id="fail">不通过</span>
        <span class="icon-check float-right text-green" id="pass"> 审核通过</span>
        <label for="all" class="float-right all"><input type="checkbox" id="all">全选</label>
        <span class="my-info">
            <a href="javascript:history.back()"><span class="icon-reply"></span> 返回</a>
        </span>
    </div>
    <div class="panel-body container">
        <c:if test="${photoList == []}">
            <div style="width: 100%;margin: 30px;text-align: center;font-size: 18px">
                <span class="icon-warning"></span> 该相册暂无照片</div>
        </c:if>
        <c:if test="${photoList != []}">
            <div class="waterfall">
                <c:forEach var="photo" items="${photoList}">
                    <div class="item">
                        <p>上传时间：
                            <span><fmt:formatDate value="${photo.createTime}" type="both"/></span>
                            <input type="checkbox" class="float-right check" style="line-height: 24px">
                        </p>
                        <p>审核人：${photo.admin.realName}</p>
                        <img src="/photo/user/${photo.picUrl}" id="${photo.id}">
                        <div class="text-right">
                            <c:choose>
                                <c:when test="${photo.state == '1'}">
                                    <button class="button border-green" onclick="auditPhoto('${photo.id}', '2')">
                                        <span class="icon-check"></span> 审核通过
                                    </button>
                                    <button class="button border-red" onclick="auditPhoto('${photo.id}', '1')">
                                        <span class="icon-times"></span> 不通过
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="button border-red" onclick="auditPhoto('${photo.id}', '1')">
                                        <span class="icon-times"></span> 删除
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</div>
<!--查看照片原图-->
<div class="custom-mask"></div>
<div class="custom-dialog">
    <span class="close float-right rotate-hover"></span>
    <img src="" alt="" class="img-responsive">
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        //背景低亮
        $(".custom-mask").css("height", $(document).height());
        $(window).scroll(function () {
            $(".custom-mask").css("height", $(document).height());
        });

        //点击图片查看大图
        $("img").click(function () {
            var imgSrc = $(this).attr("src");
            $(".custom-dialog img").attr("src", imgSrc).load(function () {
                var ml = ($(window).width() - $(this).width()) / 2;
                var tp = ($(window).height() - $(this).height()) / 2 + $(window).scrollTop();
                if(tp >= 0){
                    //在恰当的位置显示
                    $(".custom-dialog").css({"margin-left": ml, "top": tp});
                }else{
                    $(".custom-dialog").css({"margin-left": ml, "top": "20px"});
                }
            }).click(function () {
                $(".custom-mask, .custom-dialog, .close").hide();
            });
            $(".custom-mask, .custom-dialog, .close").show();
        });
        $(".close").click(function () {
            $(".custom-mask, .custom-dialog, .close").hide();
        });

        //批量审核操作
        var group = {
            group : $("#group"),    //批量审核
            pass : $("#pass"),      //审核通过
            fail : $("#fail"),      //不通过
            all : $(".all"),        //全选
            cancel:$("#cancel"),    //取消批量审核
            check : $(".check"),    //照片复选框
            imgsID: []              //所选照片ID数组
        };

        $(document)
        //点击批量审核
            .on("click","#group",function () {
                group.check.toggle();
                $(this).hide();
                group.cancel.show();
                group.pass.show();
                group.fail.show();
                group.all.show();
            })

            //取消批量审核
            .on("click","#cancel",function () {
                group.check.toggle();
                group.group.show();
                $(this).hide();
                group.pass.hide();
                group.fail.hide();
                group.all.hide();
            })

            //点击全选
            .on("click","#all",function () {
                if (this.checked) { // 如果自己被选中
                    group.check.prop("checked", true);
                } else { // 如果自己没被选中
                    group.check.prop("checked", false);
                }
            })

            //点击批量审核中的“审核通过”
            .on("click","#pass",function () {
                var intL = $("input:checked").length; // 获取所有复选框选中项
                if (intL != 0) { // 如果有选中项
                    var sure = confirm("确定所选的照片[通过审核]吗？");
                    if(sure){
                        group.check.each(function () {
                            if(this.checked){
                                group.imgsID.push($(this).parent().next().next().attr("id"));
                            }
                        });
                        $.ajax({
                            url: "${ctx}/admin/audit/photo/audit",
                            type: "POST",
                            dataType: "json",
                            data: {"photoIds": group.imgsID, "state": "2"}, //state为2，通过
                            traditional: true,
                            success: function (data) {
                                if (data.code == 200) {
                                    alert(data.message);
                                    location.reload(true);
                                } else {
                                    alert(data.message);
                                }
                            },
                            error: function () {
                                alert("系统繁忙");
                            }
                        });
                    }
                } else {
                    alert("请先选中要审核的照片！");
                }
            })

            //点击批量审核中的“不通过”
            .on("click","#fail",function () {
                var intL = $("input:checked").length; // 获取所有复选框选中项
                if (intL != 0) { // 如果有选中项
                    var sure = confirm("确定所选的照片[不通过审核]吗？");
                    if(sure){
                        group.check.each(function () {
                            if(this.checked){
                                group.imgsID.push($(this).parent().next().next().attr("id"));
                            }
                        });
                        $.ajax({
                            url: "${ctx}/admin/audit/photo/audit",
                            type: "POST",
                            dataType: "json",
                            data: {"photoIds": group.imgsID, "state": "1"}, //state为1，不通过
                            traditional: true,
                            success: function (data) {
                                if (data.code == 200) {
                                    alert(data.message);
                                    location.reload(true);
                                } else {
                                    alert(data.message);
                                }
                            },
                            error: function () {
                                alert("系统繁忙");
                            }
                        });
                    }
                } else {
                    alert("请先选中要审核的照片！");
                }
            });
    });

    /**
     * 单张图片审核操作
     * @param photoId   图片id
     * @param state     状态
     */
    function auditPhoto(photoId, state) {
        $.ajax({
            url: "${ctx}/admin/audit/photo/audit",
            type: "POST",
            dataType: "json",
            data: {"photoIds": photoId, "state": state},
            success: function (data) {
                if (data.code == 200) {
                    alert(data.message);
                    location.reload(true);
                } else {
                    alert(data.message);
                }
            },
            error: function () {
                alert("系统繁忙，请稍后再试");
            }
        });
    }
</script>
</body>
</html>