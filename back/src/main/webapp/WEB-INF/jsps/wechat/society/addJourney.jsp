<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>新建游记</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="海浪山风休闲户外旅游在线平台">
    <link rel="stylesheet" href="${ctx}/css/weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <link rel="stylesheet" href="${ctx}/js/layout/base.css">
    <style>
        body{padding: 50px 0;
            /*background: #fff*/
        }
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
            cursor:pointer;
        }
        .go-home{
            position: absolute;
            right: 10px;
            width: 22px;
            height: 22px;
        }
        a{color: #679aff;font-size: 14px}
        .my-btn{position: fixed;bottom: 0;width:100%;max-width: 500px;z-index: 2}
        .weui-btn{border-radius: 0;font-size: 16px}
        #articleEditor{
            background: #fff;
            margin-top: 10px;
            line-height: 25px;
            padding:15px;
        }
        .weui-cell__hd {
            display: -webkit-box;
        }
        .weui-cell__hd img {
            width: 16px;
            height: 16px;
            margin-right: 10px;
        }
        .Eleditor-textStyle-linedecoration,
        .Eleditor-textStyle-color,
        .Eleditor-textStyle-bgColor,
        .Eleditor-textStyle-fontSize,
        .Eleditor-textStyle-lineHeight,
        .Eleditor-textStyle-item-upImg
        {display: none}
        .Eleditor-placeholder{text-align: center}
        .weui-cells{margin-top: 10px}
        #add-cover{
            position: relative;
            width: 100%;
            height:150px;
            background:#fff;
            text-align: center;
            color: #bbb;
            cursor: pointer;
            -webkit-tap-highlight-color:rgba(0,0,0,0);
        }
        #uploaderInput{display: none}
        .weui-panel{z-index: -1}
        .weui-agree{padding:15px 0 15px 15px;display: inline-block}
        .weui-agree__checkbox{
            top: 5px;
            border: 3px solid #679aff;
            border-radius: 0;
            width: 20px;
            height: 20px;
        }
        .weui-agree__checkbox:checked:before{
            background: #37a1ff;
            color: #fff;
            font-size: 22px;
        }
        .weui-media-box__desc{line-height: 20px;font-size: 12px;}
        .weui-media-box{padding-top: 10px}
        .Eleditor-area img{width: 100%;margin: 5px 0}
        p{word-break:break-all}
    </style>
</head>
<body>
<!--版头-->
<div class="page-title">
    <span class="return"></span>
    新建游记
    <a href="${ctx}/wechat/index/show?cityId=${sessionScope.currentCity.id}">
        <img src="${ctx}/images/topbar-home.png" class="go-home">
    </a>
</div>
<!--游记封面-->
<div id="add-cover">
    <img src="${ctx}/images/addCover.png" style="width: 60px;margin-top: 30px">
    <br>点击添加封面
    <img src="${ctx}/images/ic_cover.png" style="width:60px;position: absolute;bottom: 0;right: 0">
</div>
<!--游记标题-->
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <img src="${ctx}/images/icon_type.png">
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="title" type="text" placeholder="请输入游记标题(必填)">
        </div>
    </div>
</div>
<!--游记图文内容-->
<div id="articleEditor"></div>
<!--游记编辑说明-->
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__hd">☞ 温馨提示：</div>
    <div class="weui-panel__bd">
        <div class="weui-media-box weui-media-box_text">
            <p class="weui-media-box__desc">1. 单次最多可插入1张图片，可分多次插入</p>
            <p class="weui-media-box__desc">2. 暂不支持实时保存功能，退出编辑请注意保存</p>
            <p class="weui-media-box__desc">3. 游记发布后，经后台工作人员审核通过即可成功发布</p>
        </div>
    </div>
</div>
<label for="agree" class="weui-agree">
    <input id="agree" type="checkbox" class="weui-agree__checkbox">
    <span>&nbsp;我已阅读并同意 </span>
</label>
<a href="#">《游记使用服务协议》</a>
<!--操作-->
<div class="weui-cells">
    <div class="weui-flex my-btn">
        <div class="weui-flex__item">
            <button class="weui-btn weui-btn_primary" id="save">保存草稿</button>
        </div>
        <div class="weui-flex__item">
            <button class="weui-btn weui-btn_warn" id="release" type="button">发布游记</button>
        </div>
    </div>
</div>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
<script src="${ctx}/js/jquery-weui.min.js"></script>
<script src="${ctx}/js/Eleditor.min.js"></script>
<%--<script src="${ctx}/js/webuploader.min.js"></script>--%>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>

    //实例化Eleditor
    var Edr = new Eleditor({
        el: '#articleEditor', //容器
        //placeHolder: '请输入内容',
        toolbars: [
            'insertText',
            'editText',
            //自定义图片插入按钮
            {
                id: 'myInsertImg',
                name: '插入图片',
                handle: function(select, controll){//回调返回选择的dom对象和控制按钮对象
                    var _$ele = $(select),//富文本区域
                        _$controll = $(controll);//该按钮区域
                    <%--_$ele.after('<img src="${ctx}/images/ad-01.jpg" alt="">');--%>
                }
            },
            'deleteThis',
            'cancel'
        ]
    });

    var $title = $("#title"), //标题
        $agree = $("#agree"), //同意复选框
        $addCover = $("#add-cover"), //添加封面
        isHasCover; //是否已选封面

    $(function () {
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
        var coverLocalId = [], localIds = [];
        wx.config(config);//配置参数

        $(document)
            .on("click",".return",function () {
                var sure = confirm("请检查是否已保存当前编辑内容，确定退出吗？");
                if(sure){
                    window.location.href = "javascript:history.back()"
                }
            })
            //添加封面
            .on("click","#add-cover",function () {
//                document.getElementById("uploaderInput").click();
                var self = $(this);
                wx.ready(function(){
                    wx.chooseImage({
                        count: 1, // 只允许上传1张
                        sizeType: ['compressed'], // 指定为压缩图
                        sourceType: ['album', 'camera'], // 可以指定来源是相册或相机
                        success: function (res) {
                            // 返回选定照片的本地ID列表，
                            // localId可以作为img标签的src属性显示图片
                            coverLocalId = res.localIds;
//                            self.css({
//                                "background":"url('"+coverLocalId[0]+"')",
//                                "background-size":"100% 150px"
//                            }).html("");//苹果手机无法正常显示
                            self.html('<img src="'+coverLocalId[0]+'" ' +
                                'style="width: 100%;height: 100%" alt="">');
                        }
                    });
                });
            })
            //富文本插入图片
            .on("click",".Eleditor-myInsertImg",function () {
                wx.ready(function(){
                    wx.chooseImage({
                        count: 1, // 最多允许上传1张
                        sizeType: ['compressed'], // 指定为压缩图
                        sourceType: ['album', 'camera'], // 可以指定来源是相册或相机
                        success: function (res) {
                            localIds = res.localIds;
                            //console.log(localIds);
                            setTimeout(function () {
                                wxUploadRichImg(localIds);
                            },100)
                        }
                    });
                });
            })
            //点击保存时
            .on("click","#save",function () {
                var isDisclaimed,
                    journeyContent = Edr.getContentText(),
                    back = $addCover.find("img").length;
                isHasCover = back == 1?true:false;
                isDisclaimed = $agree.is(":checked")?true:false;
                if(!isHasCover){
                    alert("游记封面不能为空");
                }
                else if($title.val().length == 0){
                    alert("游记标题不能为空");
                    $title.focus();
                }else if(Edr.getContent().length == 0 || journeyContent == "点击此处编辑内容"){
                    alert("游记内容不能为空")
                } else if(!isDisclaimed){
                    alert("请先阅读并勾选同意《游记使用服务协议》");
                }else{
                    wxUploadImg(coverLocalId,3);
                }
            })
            //点击发布时
            .on("click","#release",function () {
                var isDisclaimed,
                    journeyContent = Edr.getContentText(),
                    back = $addCover.find("img").length;
                isHasCover = back == 1?true:false;
                isDisclaimed = $agree.is(":checked")?true:false;
                if(!isHasCover){
                    alert("游记封面不能为空");
                } else if($title.val().length == 0){
                    alert("游记标题不能为空");
                    $title.focus();
                }else if(Edr.getContent().length == 0 || journeyContent == "点击此处编辑内容"){
                    alert("游记内容不能为空")
                } else if(!isDisclaimed){
                    alert("请先阅读并勾选同意《游记使用服务协议》");
                }else{
                    wxUploadImg(coverLocalId,0);
                }
            })
    });


    /**
     * [wxUploadImg 获取封面媒体ID]
     * @param  {[type]} localIds [封面ID]
     * @param state     游记状态
     */
    function wxUploadImg(localIds, state){
        wx.uploadImage({//获取图片媒体ID
            localId: localIds[0].toString(),  // 需要上传的图片的本地ID
            isShowProgressTips: 1, // 默认为1，显示进度提示
            success: function (res) {//获取成功
                $.ajax({
                    url: "${ctx}/wechat/journey/addJourney",
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        title:$title.val(),
                        mediaIds: res.serverId,
                        Content:Edr.getContent(),
                        state:state,
                        userId:"${sessionScope.userInfo.id}"
                    },
                    traditional: true,
                    success: function (data) {
                        if (data.code == 200) {
                            alert(data.message);
                            window.location.href = "${ctx}/wechat/mine/showMinePage";
                        } else {
                            alert(data.message);
                        }
                    },
                    error: function () {
                        alert(data.message);
                    }
                })
                    .done(function(data) {
                        console.log("封面上传成功");
                    })
                    .fail(function() {
                        console.log("error");
                    })
                    .always(function() {
                        console.log("complete");
                    });
                return true;
            },
            fail: function(res){//获取多媒体id失败 返回错误代码
                alert("封面上传失败，msg："+JSON.stringify(res));
            }
        });
    }

    /**
     * [wxUploadRichImg 获取富文本图片媒体ID 递归函数]
     * @param localIds
     */
    var idx = 0,serverIds=[];//富文本
    function wxUploadRichImg(localIds){
        wx.uploadImage({//获取图片媒体ID
            localId: localIds[idx].toString(),  // 需要上传的图片的本地ID
            isShowProgressTips: 1, // 默认为1，显示进度提示
            success: function (res) {//获取成功
                // 上传序号，上传一张 累计 +1
                idx++;
                //存储图片媒体ID，用逗号分割
                serverIds.push(res.serverId);

                if(idx<localIds.length){//本地图片ID 还没全部获取完图片媒体ID
                    //调用上传递归函数
                    wxUploadRichImg(localIds);
                }else{
                    //上传序号归零
                    idx=0;
                    //服务器csrf 验证字符串，如果后端框架没开启csrf，则不需要
//                    var csrf=$('meta[name="csrf-token"]').attr('content');
//                    for(var i=0;i<serverIds.length;i++){
//                        alert("serverId["+i+"]:"+serverIds[i]);
//                    }
                    setTimeout(function () {
                        $.ajax({
                            url: "${ctx}/wechat/journey/insertPicBtn",
                            type: 'POST',
                            dataType: 'json',
                            data: {
                                serverIds:serverIds
                            },
                            traditional: true,
                            success: function (data) {
                                for(var i=0;i<data.length;i++){
                                    if(data[i].condition.code == 200){
                                        Edr.append('<img src="${ctx}/photo/TravelNote/'+data[i].picUrl+'" alt="">');
                                    }
                                    else{
                                        alert(data[i].condition.message);
                                    }
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
                    },100);
                }
            },
            fail: function(res){//获取多媒体id失败 返回错误代码
                alert("上传失败，msg："+JSON.stringify(res));
            }
        });
    }

    //请记住下面常用方法---------------------------------------->
    //Edr.append(""); 往编辑器追加内容
    //Edr.getContent(); 获取编辑器内容
    //Edr.getContentText(); 获取编辑器纯文本
    //Edr.destory(); 移除编辑器
</script>
</body>
</html>
