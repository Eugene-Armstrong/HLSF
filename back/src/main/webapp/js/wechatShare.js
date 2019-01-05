function sharpConfig(url) {
    
    var config = {
        debug: '', // 开启调试模式
        appId: '', // 必填，公众号的唯一标识
        timestamp: '', // 必填，生成签名的时间戳
        nonceStr: '', // 必填，生成签名的随机串
        signature: '',// 必填，签名，见附录
        jsApiList: [] // 必填，需要使用的JS接口列表，所有JS接口列表见附录
    };

    $.ajax({
        url: 'http://www.ailangfamily.com/wechat/getSdkConfig',
        type: 'GET',
        dataType: 'json',
        async:false,
        data: {url: url},
        success: function (data) {
            config.debug = data.debug;
            config.appId = data.appId;
            config.timestamp = data.timestamp;
            config.nonceStr = data.nonceStr;
            config.signature = data.signature;
            config.jsApiList = data.jsApiList;
        }
    });

    wx.config(config);

    var index = url.indexOf("&code=");

    if (index != -1) {
        url = url.substring(0, index);
    }

    window.sharp_Config = {
        "share": {
            "imgUrl": "http://www.ailangfamily.com/images/wechat-logo.jpg",//分享图，默认当相对路径处理，所以使用绝对路径的的话，“http://”协议前缀必须在。
            "desc": "世界那么大，我们就爱浪。",//摘要,如果分享到朋友圈的话，不显示摘要。
            "title": '爱浪Family',//分享卡片标题
            "link": url,//分享出去后的链接，这里可以将链接设置为另一个页面。
            "success": function () {//分享成功后的回调函数
            },
            'cancel': function () {
                // 用户取消分享后执行的回调函数
            }
        }
    };

    wx.ready(function() {
        wx.onMenuShareAppMessage(sharp_Config.share);//分享给好友
        wx.onMenuShareTimeline(sharp_Config.share);//分享到朋友圈
        wx.onMenuShareQQ(sharp_Config.share);//分享给手机QQ
        wx.hideMenuItems({
            menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
        });
    });
}