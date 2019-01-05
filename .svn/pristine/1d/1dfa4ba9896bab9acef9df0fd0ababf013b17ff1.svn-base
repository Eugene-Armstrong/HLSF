<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>海浪山风</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <style>
        .page-title {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 999;
            background: #679aff;
            color: #fff;
            font-size: 16px;
            padding: 10px 0;
            text-align: center;
        }
        .return {
            position: absolute;
            left: 10px;
            width: 20px;
            height: 20px;
            background: url("${ctx}/images/return.png");
            background-size: cover;
        }
        .go-home{
            position: absolute;
            right: 10px;
            width: 22px;
            height: 22px;
        }
        a{color: #fff}
        .weui-uploader__file,.weui-uploader__input-box{
            width: 30%;
            height: auto;
            border: none;
            cursor: pointer;
        }
        .weui-uploader__input-box:after{height: 0}
        .weui-uploader__title{font-size: 14px}
        .weui-uploader__file img,.weui-uploader__input-box img{width: 100%}
        .minus:before{width: 0}
        .minus{border: none}
        .weui-uploader__file-content{display: none}
        .weui-badge{width: 30px;font-size: 20px;line-height: 30px;padding: 0}
        .my-btn{
            position: fixed;
            bottom: 0;
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
            z-index: 2;
        }
        .weui-btn{
            border-radius: 0;
            font-size: 16px;
            line-height: 45px;
            cursor: pointer
        }
        .weui-photo-browser-modal{z-index: 99}
        .weui-dialog__btn{color: #679aff}
    </style>
</head>
<body style="padding-bottom: 50px">
<div class="page-title">
    <a href="javascript:history.back()" class="return"></a>
    添加照片
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}">
        <img src="${ctx}/images/topbar-home.png" class="go-home">
    </a>
</div>
<div class="weui-cells weui-cells_form" style="margin-top: 50px">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <div class="weui-uploader">
                <div class="weui-uploader__hd">
                    <p class="weui-uploader__title">相册名：${album.name}<br></p>
                </div>
                <div class="weui-uploader__bd">
                    <ul class="weui-uploader__files" id="uploaderFiles"></ul>
                    <div class="weui-uploader__input-box">
                        <div id="uploaderInput" onchange="uploadImg(this)"
                               class="weui-uploader__input"></div>
                        <img src="${ctx}/images/minus.png" alt="">
                    </div>
                    <div class="weui-uploader__input-box minus">
                        <img src="${ctx}/images/minus.png" alt="">
                    </div>
                </div>
                <p style="font-size: 14px;color: #999">(所有照片需审核通过方可成功放入您的相册)</p>
            </div>
        </div>
    </div>
    <div class="weui-flex my-btn">
        <div class="weui-flex__item">
            <a href="javascript:history.back()">
                <button class="weui-btn weui-btn_warn">取消</button>
            </a>
        </div>
        <div class="weui-flex__item">
            <button class="weui-btn weui-btn_primary">保存</button>
        </div>
    </div>
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/swiper.min.js"></script>
<script src="${ctx}/js/fastclick.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(function () {
        FastClick.attach(document.body);
        var config = {
            debug: '', // 开启调试模式
            appId: '', // 必填，公众号的唯一标识
            timestamp: '', // 必填，生成签名的时间戳
            nonceStr: '', // 必填，生成签名的随机串
            signature: '',// 必填，签名，见附录
            jsApiList: [] // 必填，需要使用的JS接口列表，所有JS接口列表见附录
        };
        $.ajax({
            url: '${ctx}/wechat/getSdkConfig',
            type: 'GET',
            dataType: 'json',
            async:false,
            data: {url: window.location.href},
            success: function (data) {
                config.debug = data.debug;
                config.appId = data.appId;
                config.timestamp = data.timestamp;
                config.nonceStr = data.nonceStr;
                config.signature = data.signature;
                config.jsApiList = data.jsApiList;
            }
        });
        var localIds = [];
        wx.config(config);//配置参数
        $(document)
            //添加图片
            .on("click","#uploaderInput",function () {
                $(".weui-uploader__file").removeClass("weui-uploader__file_status");
                wx.ready(function(){
                    wx.chooseImage({
                        count: 9, // 默认9
                        sizeType: ['compressed'], // 指定为压缩图，无原图（默认二者都有）
                        sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
                        success: function (res) {
                            // 返回选定照片的本地ID列表，
                            // localId可以作为img标签的src属性显示图片
                            localIds = res.localIds;
                            for (var i=0;i<localIds.length;i++){
                                $("#uploaderFiles").append("<li class='weui-uploader__file'>" +
                                    "<img src='"+localIds[i]+"' alt=''>" +
                                    "<div class='weui-uploader__file-content'>" +
                                    "<div class='weui-badge'>—</div></div></li>");
                            }
                            //图片宽高相等
                            var $photoFile = $(".weui-uploader__file"),
                                _w = $photoFile.find("img").width();
                            $photoFile.find("img").css("height", _w);
                            console.log(localIds);
                            //保存上传
                            $(document).on("click",".weui-btn_primary",function () {
//                                setTimeout(function(){
//                                    wx.uploadImage({
//                                        localId: localIds.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
//                                        isShowProgressTips: 1, // 默认为1，显示进度提示
//                                        success: function (res) {
//                                            var serverId = res.serverId; // 返回图片的服务器端ID
//                                            alert(serverId);
//                                        }
//                                    });
//                                },100);
                                //调用上传递归函数
                                wxUploadImg(localIds);
                            })
                        }
                    });
                    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，
                    // config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，
                    // 则须把相关接口放在ready函数中调用来确保正确执行。
                    // 对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
                });
            })

            //点击图片查看大图
            .on("click",".weui-uploader__file img",function () {
                $.photoBrowser({
                    items: [$(this).attr("src")]
                }).open();
            })

            //移除照片
            .on("click",".minus",function () {
                $(".weui-uploader__file").toggleClass("weui-uploader__file_status");
            })
            .on("click",".weui-uploader__file_status",function () {
                $(this).remove();
            })

            .on("click",".weui-btn_primary",function () {
                if(localIds.length == 0){
                    alert("请先选择图片")
                }
            });
    });

    // 上传序号
    var idx = 0;
    var serverIds=[];
    /**
     * [wxUploadImg 获取图片媒体ID 递归函数]
     * @param  {[type]} localIds [本地图片ID数组]
     * @return {[type]}          [description]
     */
    function wxUploadImg(localIds){
        wx.uploadImage({//获取图片媒体ID
            localId: localIds[idx].toString(),  // 需要上传的图片的本地ID
            isShowProgressTips: 1, // 默认为1，显示进度提示
            success: function (res) {//获取成功
                // 上传序号，上传一张 累计 +1
                idx++;
                //存储图片媒体ID，用，号分割
                serverIds.push(res.serverId);

                if(idx<localIds.length){//本地图片ID 还没全部获取完图片媒体ID
                    //调用上传递归函数
                    wxUploadImg(localIds);
                }else{
                    //上传序号归零
                    idx=0;
                    //服务器csrf 验证字符串，如果后端框架没开启csrf，则不需要
//                    var csrf=$('meta[name="csrf-token"]').attr('content');
                    $.ajax({
                        url: "${ctx}/wechat/photo/add",
                        type: 'POST',
                        dataType: 'json',
                        data: {"mediaIds": serverIds, "id": '${album.id}'},
                        traditional: true,
                        success: function (data) {
                            if (data.code == 200) {
                                alert(data.message);
                                window.location.href = "${ctx}/wechat/mine/showMinePhoto?album.id=${album.id}";
                            } else {
                                alert(data.message);
                            }
                        },
                        error: function () {
                            alert(data.message);
                        }
                    })
                        .done(function(data) {
                            console.log("上传成功");
                        })
                        .fail(function() {
                            console.log("error");
                        })
                        .always(function() {
                            console.log("complete");
                        });
                    serverIds=[];
                    return true;
                }
            },
            fail: function(res){//获取多媒体id失败 返回错误代码
                alert("上传失败，msg："+JSON.stringify(res));
            }
        });
    }

    //选择图片并预览(需要当前浏览器支持FileReader接口)-支持多图预览
    function uploadImg(obj) {
        for(var i=0;i<obj.files.length;i++){
            var file = obj.files[i];
            var reader = new FileReader();
            reader.onload = function (e) { // 成功读取
                var newNode = document.createElement("div");
                newNode.innerHTML = "<li class='weui-uploader__file'>" +
                    "<img src='"+this.result+"' alt=''>" +
                    "<div class='weui-uploader__file-content'>" +
                    "<div class='weui-badge'>—</div></div></li>";
                var list = document.getElementById("uploaderFiles");
                list.appendChild(newNode);
            };
            reader.readAsDataURL(file);
        }
    }
</script>
</body>
</html>