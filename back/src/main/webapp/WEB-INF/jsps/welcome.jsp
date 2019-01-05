<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>扫描二维码</title>
    <meta name="description" content="海浪山风休闲户外旅游产品在线消费平台，致力于通过移动优先的微页平台+公众号模式网站来打造特色化服务，
    为广大旅游爱好者清晰地提供各种旅游产品信息，结合便利的微信线上支付，最大程度地简化了旅游产品的消费手续流程，提高用户消费体验。">
    <meta name="keywords" content="海浪山风,休闲,户外,旅游,旅游产品,爱浪,爱浪family">
    <style type="text/css">
        body {
            background: url(${ctx}/images/ailang-scan.jpg) no-repeat;
            background-size: cover;
            font-family: "微软雅黑";
            max-width: 500px;
        }
        .scan-box{
            position: absolute;
            top: 50%;
            left: 50%;
            margin-left: -190px;
            margin-top: -270px;
            border-radius: 4px;
            background-color: #fff;
            width: 380px;
            height: 500px;
            box-shadow: 0 2px 10px #666;
        }
        .qr-code img{
            display: block;
            width: 270px;
            height: 270px;
            margin: 42px auto 12px;
        }
        .sub_title {
            text-align: center;
            font-size: 20px;
            color: #353535;
            margin-bottom: 20px;
        }
        .sub_desc {
            text-align: center;
            color: #888;
            font-size: 18px;
        }
    </style>
</head>
<body>
<div class="scan-box">
    <div class="qr-code">
        <img src="${ctx}/images/QRCode.jpg" alt="">
        <div class="tip-info">
            <p class="sub_title">使用手机微信扫码</p>
            <p class="sub_desc">请在微信端选购产品</p>
        </div>
    </div>
</div>
</body>
</html>
