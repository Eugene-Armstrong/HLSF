<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的相册</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        .photo-bg {
            width: 100%;
            height: 180px;
            /*position: absolute;*/
            /*top: 0;*/
            z-index: -1
        }

        .photo-info {
            background: rgba(255, 255, 255, 0.8);
            padding: 10px;
            font-size: 12px;
            color: #666;
            position: relative;
            overflow: hidden;
            margin-top: -67px;
        }
        .edit-name,.save-name{
            cursor: pointer;
            background: rgba(0,0,0,0.5);
            color: #fff;
            padding: 0 10px;
            border-radius: 20px;
            position: absolute;
            right: 10px
        }
        .save-name{display: none}

        .photo-info b {
            font-size: 14px;
            color: #000;
        }

        /*CSS3实现瀑布流*/
        .container {
            margin-top: 10px;
            background: #fff;
            padding-bottom: 50px;
        }

        /*瀑布流层*/
        .waterfall {
            -moz-column-count: 2; /* Firefox */
            -webkit-column-count: 2; /* Safari 和 Chrome */
            column-count: 2;
            -moz-column-gap: 5px;
            -webkit-column-gap: 5px;
            column-gap: 5px;
        }

        /*一个内容层*/
        .item {
            padding: 5px;
            overflow: hidden;
            -moz-page-break-inside: avoid;
            -webkit-column-break-inside: avoid;
            break-inside: avoid;
            line-height: 25px;
            font-size: 12px;
            color: #333;
        }

        .item .photo {
            width: 100%;min-height: 80px;
        }
        /*.swiper-pagination{display: none}*/
        .page-nav{position: absolute;width: 100%}
        .page-nav img{width: 30px;height: 30px;margin: 10px;}
        .weui-photo-browser-modal{z-index: 999}
        .add-photo{
            position: fixed;
            bottom: 22px;
            z-index: 100;
            width: 14%;
            left: 43%;
            background: #fff;
            border-radius: 50%;
        }
        .weui-dialog__btn{color: #679aff}
        .weui-btn{border-radius: 0;cursor: pointer;max-width: 500px}
        .weui-btn_default{
            color: #fff;
            background: #2c2c2c;
            font-size: 16px;
            line-height: 45px;
        }
        .weui-btn_warn{
            position: fixed;
            top: 0;
            display: none;
            z-index: 99;
            font-size: 16px;
        }
        .myCheck{
            position: relative;
            z-index: 10;
            margin-bottom: -31px;
            background-color: white;
            border:3px solid #e64340;
            width:25px;
            height:25px;
            text-align: center;
            line-height: 25px;
            cursor: pointer;
            -webkit-tap-highlight-color:rgba(0,0,0,0);
        }
        .myChecked{
            background-color: #e64340;
        }
        .myChecked:after{
            font: 20px weui;
            content:"\EA11";
            color: #fff;
        }
        .my-btn{
            position: fixed;
            bottom: 0;
            width: 100%;
            max-width: 500px;
            margin:0 auto;
            z-index: 99;
        }
        .empty-tip {
            padding: 10% 0;
            text-align: center;
            color: #aaa;
        }
        .empty-tip img {
            width: 50%;
            max-width: 300px;
            opacity: .5;
        }
    </style>
</head>
<body>
<div class="page-nav">
    <a href="javascript:history.back()"><img src="${ctx}/images/go-back.png" alt=""></a>
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}"><img src="${ctx}/images/go-home.png" style="float: right"></a>
</div>
<div style="overflow: hidden">
    <c:choose>
        <c:when test="${!empty photoList}">
            <img src="/photo/user/${photoList[0].photo.picUrl}" class="photo-bg">
        </c:when>
        <c:otherwise>
            <img src="${ctx}/images/tmp.jpg" class="photo-bg">
        </c:otherwise>
    </c:choose>
    <div class="photo-info">
        <c:if test="${sessionScope.userInfo.id == album.user.id}">
            <b>
                <input class="weui-input album-name" type="text" value="${album.name}" readonly>
                <nobr class="edit-name">改相册名</nobr>
                <nobr class="save-name">保存</nobr>
            </b>
        </c:if>
        <br>
        <div class="weui-flex" style="margin-top: 10px">
            <div class="weui-flex__item">浏览：${album.views}次</div>
            <div class="weui-flex__item">照片：${photoNum}张</div>
            <div class="weui-flex__item">日期: <fmt:formatDate value="${album.createTime}" pattern="yyyy-MM-dd"/></div>
        </div>
    </div>
    <div class="container">
        <c:if test="${photoList==[]}">
            <div class='empty-tip'>
                <img src='${ctx}/images/empty-pic.png' alt='emmmm~'>
                <br>此相册暂未添加图片
            </div>
        </c:if>
        <div class="waterfall">
            <c:forEach var="photoVo" items="${photoList}">
                <div class="item">
                    <div class="myCheck" style="display: none"></div>
                    <img src="/photo/user/${photoVo.photo.picUrl}" class="photo" id="${photoVo.photo.id}">
                    <%--<img src="${album.user.headImgUrl}" class="head-img">&nbsp;${album.user.nickName}--%>
                    <%--<c:choose>--%>
                        <%--<c:when test="${sessionScope.userInfo.id == album.user.id}">--%>
                            <%--<span class="praise">点赞量(<span class="praise-num">${photoVo.photo.likes}</span>)</span>--%>
                        <%--</c:when>--%>
                        <%--<c:otherwise>--%>
                            <%--<c:choose>--%>
                                <%--<c:when test="${photoVo.like}"><span class="praise">已赞</c:when>--%>
                            <%--</c:choose>--%>
                            <%--<c:otherwise><span class="praise">赞</span></c:otherwise>--%>
                            <%--(<span class="praise-num">${photoVo.photo.likes}</span>)--%>
                        <%--</span>--%>
                        <%--</c:otherwise>--%>
                    <%--</c:choose>--%>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<c:if test="${sessionScope.userInfo.id == album.user.id}">
    <a href="${ctx}/wechat/photo/addPage?id=${album.id}">
        <img src="${ctx}/images/add-photo.png" alt="" class="add-photo">
    </a>
    <button class="weui-btn weui-btn_warn">
        确定删除
    </button>
    <div class="weui-flex my-btn">
        <div class="weui-flex__item">
            <button class="weui-btn weui-btn_default delete-album">删除相册</button>
        </div>
        <div class="weui-flex__item">
            <button class="weui-btn weui-btn_default delete-photo">删除照片</button>
        </div>
    </div>
</c:if>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/swiper.min.js"></script>
<script src="${ctx}/js/wechatShare.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        sharpConfig(window.location.href);
        var $albumName = $(".album-name"),
            $saveName = $(".save-name"),
            originalName;//原相册名
        $albumName.width($albumName.val().length*14);
        $(document).on("input",".album-name",function(){
            $(this).width($(this).val().length*14);
        })
            .on("click",".edit-name",function () { //改相册名
            $albumName.attr("readonly",false).focus();
            $(this).hide();
            $saveName.show();
            originalName = $albumName.val();//原相册名
        });
        $saveName.click(function () {//保存相册名
            $albumName.attr("readonly",true);
            $.confirm({
                title:'温馨提示',
                text: '确定保存对相册名的修改吗',
                onOK: function () {
                    //点击确认
                    $.ajax({
                        url: "${ctx}/wechat/album/updateName",
                        type: "POST",
                        dataType: "json",
                        data: {"name": $(".album-name").val(), "id": '${album.id}'},
                        success: function (data) {
                            if (data.code == 200) {
                                alert(data.message);

                            } else {
                                alert(data.message);
                            }
                        },
                        error:function (e) {
                            alert("系统繁忙，请稍后再试");
                            $albumName.val(originalName);
                        }
                    });
                },
                onCancel: function () { //点击取消
                    $albumName.val(originalName);
                }
            });
            $saveName.hide();
            $(".edit-name").show();
        });

        //点击图片查看大图
        var $photo = $(".photo"),
            _src = "";
        $photo.each(function (i) {
            if (i == 0) {_src += $(this).attr("src");}
            else {_src += "," + $(this).attr("src");}
        });
        var itemsArray = _src.split(","); //需要显示的图片src数组
        $photo.click(function () {
            $.photoBrowser({
                items: itemsArray,
                initIndex:$(this).parent().index()
            }).open();
        });

        //点赞(不考虑取消点赞)
        <%--$(".praise").click(function () {--%>
            <%--var $self = $(this);--%>
            <%--$.ajax({--%>
                <%--url: "${ctx}/wechat/photo/like",--%>
                <%--type: "POST",--%>
                <%--dataType: "json",--%>
                <%--data: {"id": $self.siblings(".photo").attr("id")},--%>
                <%--success: function (data) {--%>
                    <%--if (data.code == 200) {--%>
                        <%--var $praiseNum = $self.find(".praise-num"),--%>
                            <%--_praiseNum = parseInt($praiseNum.text())+1;--%>
                        <%--$praiseNum.text(_praiseNum);--%>
                        <%--$self.text("已赞");--%>
                    <%--} else {--%>
                        <%--alert(data.message);--%>
                    <%--}--%>
                <%--},--%>
                <%--error:function (e) {--%>
                    <%--alert("系统繁忙，请稍后再试");--%>
                <%--}--%>
            <%--});--%>
            <%--$(this).unbind();//解绑事件(阻止重复点赞)--%>
        <%--});--%>

        //删除相册
        $(".delete-album").click(function () {
            $.confirm({
                title:'温馨提示',
                text: '删除后相册中的所有图片将无法恢复，确定要删除本相册吗？',
                onOK: function () {
                    //点击确认-删除
                    $.ajax({
                        url: "${ctx}/wechat/album/deleteAlbum",
                        type: "POST",
                        dataType: "json",
                        data: {"albumId": '${album.id}'},
                        success: function (data) {
                            if (data.code == 200) {
                                window.location.href = "${ctx}/wechat/mine/showMinePage";
                            } else {
                                alert(data.message);
                            }
                        },
                        error:function (e) {
                            alert("系统繁忙，请稍后再试");
                        }
                    });
                }
            });
        });

        //删除照片
        $(document).on("click",".delete-photo",function () {
        $(".myCheck").toggle();
            $(".weui-btn_warn").toggle();
            var $self = $(this);
            if($self.text()=="删除照片"){
                $self.text("取消删除");
            }else{
                $self.text("删除照片");
            }
        })
            .on("click",".myCheck",function () { //选定照片
            $(this).toggleClass("myChecked");
        })
            .on("click",".weui-btn_warn",function () { //确定删除
            var $deleteItems = $(".myChecked");
            if($deleteItems.length == 0){
                $.alert({
                    title:'温馨提示',
                    text: '请先选中要删除的照片'
                });
            }else{
                $.confirm({
                    title:'温馨提示',
                    text: '删除后将无法恢复，确定要删除所选的'+$deleteItems.length+'张照片吗？',
                    onOK: function () {
                        var deleteIdArray = [];
                        $deleteItems.each(function () {
                            deleteIdArray.push($(this).next().attr("id"));
                            $(this).parent().remove();
                        });
//                        alert(deleteIdArray);
                        $.ajax({
                            type:"post",
                            url: "${ctx}/wechat/photo/delete", // 请求处理页
                            dataType: "json",
                            data: {"photoIds": deleteIdArray},
                            traditional: true,
                            success: function (data) {
                                if (data.code == 200) {
                                    alert(data.message);
                                    location.reload(false);
                                } else {
                                    alert(data.message);
                                }
                            },
                            error:function (e) {
                                alert("系统繁忙，请稍后再试");
                            }
                        });
                        $(".delete-photo").trigger("click");
                    }
                });
            }
        });
    })
</script>
</body>
</html>