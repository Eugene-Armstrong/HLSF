<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>媒体管理</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <link rel="stylesheet" href="${ctx}/css/myStyle.css">
    <link rel="stylesheet" href="${ctx}/css/combo.select.css">
    <style type="text/css">
        .panel td {border-top-color: #f4f4f4}

        .panel tr:nth-child(2) td {
            border: none;
            padding-bottom: 30px
        }

        button {margin: 0 10px !important }

        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
        img {
            border-radius: 5px;
            cursor: pointer;
            max-height: 300px;
        }

        .my-title {
            text-align: center;
            padding-top: 25px;
            border-top: 1px solid #f0f0f0;
        }
        .product{display: inline}
        .panel-head{width: 100%;top: 0;position: fixed;z-index: 99}
        .line-middle{margin:20px 15px 35px 15px;line-height: 30px}
        .media img{width: 100%;}
        .add img{min-width: 100px}

        /*自定义模态框*/
        .custom-add-dialog,.custom-info-dialog{
            display: none;
            text-align: center;
            min-width: 200px;
            margin-top: 110px;
            z-index: 11;
            position: fixed;
            border: 1px solid #ddd;
            box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
            border-radius: 4px;
            background-color: #fff;
        }
        .custom-mask{
            position: fixed;
            left: 0;
            top: 0;
            right: 0;
            bottom: 0;
            background: #000;
            z-index: 10;
            opacity: .5;
            display: none;
            overflow-x: hidden;
            overflow-y: auto;
        }
        .custom-add-dialog{
            width: 60%;
            margin-left: 20%;
            text-align: left;
        }
        .custom-info-dialog{
            width: 60%;
            margin-left: 20%;
            text-align: left;
        }
        .dialog-head {
            border-bottom: solid 1px #ddd;
            background-color: #f5f5f5;
            padding: 10px 20px;
        }
        .dowebok{width: 60%;}
        .dialog-head .combo-select{margin: 0;}
        .dialog-body{padding: 15px 20px}
        .dialog-foot{padding: 10px 20px;text-align: right;border-top:1px solid #ddd}
    </style>
</head>
<body>
<!--自定义模态框-->
<div class="custom-mask"></div>
<!--自定义添加活动模态框-->
<div class="custom-add-dialog">
    <div class="dialog-head">
        <span class="close rotate-hover float-right"></span>
        <div class="dowebok">
            <select name="search" id="productSelect" onchange="selectInfo(this)">
            </select>
        </div>
    </div>
    <div class="dialog-body">
        <input type="hidden" id="location"/>
        <input type="hidden" id="module"/>
        <table class="table table-hover table-bordered">
            <tr>
                <td rowspan="6" colspan="2" width="40%">
                    <img id="select_pic" src="" class="img-responsive">
                </td>
            </tr>
            <tr>
                <th>产品名称</th>
                <td id="select_name"></td>
            </tr>
            <tr>
                <th>产品类型</th>
                <td id="select_type"></td>
            </tr>
            <tr>
                <th>平均分</th>
                <td id="select_score"></td>
            </tr>
            <tr>
                <th>难度</th>
                <td id="select_difficulty"></td>
            </tr>
        </table>
    </div>
    <div class="dialog-foot">
        <span style="color: #999;float: left">【注：选择(或输入)有效产品名后方可成功添加】</span>
        <button class="button border-blue dialog-close" title="输入有效活动名后方可点击添加" onclick="add()">
            确认添加
        </button>
        <button class="button dialog-close">
            取消
        </button>
    </div>
</div>
<!--自定义产品信息模态框-->
<div class="custom-info-dialog">
    <div class="dialog-head">
        <span class="close rotate-hover float-right"></span>
        <strong>查看产品信息</strong>
    </div>
    <div class="dialog-body">
        <input type="hidden" id="show_id"/>
        <table class="table table-hover table-bordered">
            <tr>
                <td rowspan="6" colspan="2" width="40%">
                    <img id="show_pic" src="" class="img-responsive">
                </td>
            </tr>
            <tr>
                <th>产品名称</th>
                <td id="show_name"></td>
            </tr>
            <tr>
                <th>产品类型</th>
                <td id="show_type"></td>
            </tr>
            <tr>
                <th>平均分</th>
                <td id="show_score"></td>
            </tr>
            <tr>
                <th>难度</th>
                <td id="show_difficulty"></td>
            </tr>
        </table>
    </div>
    <div class="dialog-foot">
        <button class="button border-red dialog-close">
            移除
        </button>
        <button class="button dialog-close">
            关闭
        </button>
    </div>
</div>
<!--产品-->
<form action="" method="post" enctype="multipart/form-data" name="upload_product">
    <div class="panel admin-panel">
        <div class="panel-head">
            <strong><span class="icon-photo"></span> 产品轮播</strong>
            <select class="input" name="city" id="city" onchange="reload()">
                <option value="">--- 请选择城市 ---</option>
                <c:forEach var="city" items="${cityList}">
                    <option value="${city.id}">${city.name}</option>
                </c:forEach>
            </select>
            <span style="color: #999">【注：点击“+”号上传产品（选择有效产品方可成功添加），点击已添加产品可查看产品信息】</span>
        </div>
        <!--首页-轮播大图-->
        <div class="my-title" style="margin-top: 62px">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 轮播大图
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '1'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '1', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-本周活动-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 本周活动
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '2'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '2', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-下周活动-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 下周活动
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '3'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '3', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-近期假日-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 近期假日
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '4'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '4', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-往期活动-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 往期活动
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '5'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '5', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-限时优惠-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 限时优惠
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '6'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '6', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-热门线路-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 热门线路
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '7'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '7', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-定制回顾-->
        <%--<div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 定制回顾
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '8'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '8', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>--%>

        <!--首页-游记-->
        <%--<div class="my-title">--%>
        <%--<b>--%>
        <%--<span class="icon-angle-double-right"></span>--%>
        <%--首页 - 游记--%>
        <%--<span class="icon-angle-double-left"></span>--%>
        <%--</b>--%>
        <%--</div>--%>
        <%--<div class="line-middle">--%>
        <%--<c:forEach var="media" items="${mediaList}">--%>
        <%--<c:if test="${media.location == '1'}">--%>
        <%--<c:if test="${media.module == '9'}">--%>
        <%--<div class="xs2 product" onclick="infoFunc('1', '8', '${media.product.id}')">--%>
        <%--<div class="media clearfix">--%>
        <%--<a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>--%>
        <%--<div class="media-body">${media.product.name}</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</c:if>--%>
        <%--</c:if>--%>
        <%--</c:forEach>--%>
        <%--<div class="xs2 add">--%>
        <%--<div class="media clearfix">--%>
        <%--<a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>--%>
        <%--<div class="media-body">【 上传产品 】</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>

        <!--首页-更多推荐-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 更多推荐
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '11'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '11', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-省内短线-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 省内短线
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '12'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '12', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-国内长线-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 国内长线
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '13'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '13', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-境外长线-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 境外长线
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '14'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '14', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--首页-城市度假-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                首页 - 城市度假
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '1'}">
                    <c:if test="${media.module == '15'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('1', '15', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>

        <!--社区-驴友推荐-->
        <div class="my-title">
            <b>
                <span class="icon-angle-double-right"></span>
                社区 - 驴友推荐
                <span class="icon-angle-double-left"></span>
            </b>
        </div>
        <div class="line-middle">
            <c:forEach var="media" items="${mediaList}">
                <c:if test="${media.location == '2'}">
                    <c:if test="${media.module == '10'}">
                        <div class="xs2 product" onclick="infoFunc('${media.product.id}', '${media.id}')">
                            <div class="media clearfix">
                                <a><img src="/photo/product/${media.product.picUrl}" class="radius" alt=""></a>
                                <div class="media-body">${media.product.name}</div>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
            <div class="xs2 add" onclick="addFunc('2', '10', null)">
                <div class="media clearfix">
                    <a><img src="${ctx}/images/upload.png" class="radius" alt=""></a>
                    <div class="media-body">【 上传产品 】</div>
                </div>
            </div>
        </div>
    </div>
</form>
<script src="${ctx}/js/jquery-1.8.3.min.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script src="${ctx}/js/jquery.combo.select.js"></script>
<script>
    $(function () {
        $('#city').val('${mediaCity.city.id}');

        //上传图标宽高
        var add = $(".add");
        var _w = add.prev().find("img").height();
        add.find("img").css("width", _w);
        $(window).resize(function () {
            _w = add.prev().find("img").height();
            add.find("img").css("width", _w);
        });

        var _mask = $(".custom-mask");//自定义mask
        var _addDialog = $(".custom-add-dialog");//添加产品
        var _infoDialog = $(".custom-info-dialog");//查看产品信息
        var _dialog = $(".confirm-dialog");//确认移除产品

        //点击添加产品
//            add.click(function () {
//                _addDialog.show();
//                _mask.show();
//            });

        //查看产品信息
//            var product;
//            $("body").on("click",".product",function () {
//                _mask.show();
//                _infoDialog.show();
//                product = $(this);
//            });
        //取消产品上传(移除)
        $(".dialog-foot .border-red").click(function () {
            _mask.show();
            _dialog.show();
            deleteProduct();
        });

        //隐藏自定义模态框
        $(".dialog-foot button").click(function () {
            _mask.hide();
            _dialog.hide();
            _addDialog.hide();
            _infoDialog.hide()
        });
        $(".close").click(function () {
            _mask.hide();
            _dialog.hide();
            _addDialog.hide();
            _infoDialog.hide()
        });
    });
    //添加产品
    function addFunc(location, module) { //进入模态框
        $(".custom-add-dialog").show();
        $(".custom-mask").show();
//            var addBtn = $(".dialog-foot .border-blue"); //添加按钮
//            addBtn.attr("disabled", true);
        getProducts(location, module);
        $('#location').val(location);
        $('#module').val(module);
        $("body").on("change",".dialog-head .combo-input", function () { //搜索框内容改变后触发
            var search = $(this);
            var name = search.val();
            var check = false;
            $(".dowebok option").each(function () { //检查产品是否存在
                if (name == $(this).text()) {
                    check = true;
                    return false;
                }
            });
            if (name != "") {
                if (check) {
//                        addBtn.attr("disabled", false);
                }else{
//                        addBtn.attr("disabled", true);
                    alert("所输入的产品名不存在，请重新输入");
                    search.val("");
                    search.focus();
                }
            }
        })
    }
    //查看产品信息
    function infoFunc(productId, mediaId) {
        $.ajax({
            url: "${ctx}/admin/media/productInfo",
            type: "POST",
            dataType: "json",
            data: {"id": productId.toString()},
            success: function (data) {
                if (data.code == 200) {
                    if (data.entity) {
                        //显示图片
                        $('#show_pic').attr("src","/photo/product/" + data.entity.picUrl.toString());

                        //名称
                        $('#show_name').text(data.entity.name);

                        //类型
                        var type = data.entity.type;
                        switch (type) {
                            case "1":
                                $('#show_type').text("普通");
                                break;
                            case "2":
                                $('#show_type').text("定制");
                                break;
                            case "3":
                                $('#show_type').text("约伴");
                                break;
                        }

                        //评分
                        $('#show_score').text(data.entity.productAvgVote);

                        //等级
                        var level = "";
                        for (var i = 0; i < data.entity.degreeDifficulty; i++) {
                            level += "★";
                        }
                        $('#show_difficulty').text(level);
                    }
                } else {
                    alert("系统繁忙");
                }
            },
            error: function () {
                alert("系统繁忙");
            }
        });
        $('#show_id').val(mediaId.toString());
        $(".custom-mask").show();
        $(".custom-info-dialog").show();
    }

    <%-- 城市下拉框刷新 --%>
    function reload() {
        if ($('#city').val() != '') {
            window.location.href = "${ctx}/admin/media/list?city.id=" + $('#city').val();
        }
    }

    <%-- 获取模态款的产品列表 --%>
    function getProducts(location, module) {
        $.ajax({
            url: "${ctx}/admin/media/getProduct",
            type: "POST",
            dataType: "json",
            data: {"location": location.toString(), "module": module.toString(), "city.id": "${mediaCity.city.id}"},
            success: function (data) {
                if (data.code == 200) {
                    if (data.entity && data.entity.length > 0) {
                        $('#productSelect').empty();
                        var productSelect = document.getElementById("productSelect");
                        productSelect.options[0] = new Option('---请选择产品---', '');
                        for (var i = 0; i < data.entity.length; i++) {
                            productSelect.options[i + 1] = new Option(data.entity[i].name, data.entity[i].id);
                        }
                        $(".dowebok select").comboSelect();
                    }
                } else {
                    alert(data.message);
                }
            },
            error: function () {
                alert("系统繁忙");
            }
        });
    }

    <!-- 删除产品 -->
    function deleteProduct() {
        $.ajax({
            url: "${ctx}/admin/media/delete",
            type: "POST",
            dataType: "json",
            data: {"id": $('#show_id').val()},
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

    <!-- 下拉框选择更新 -->
    function selectInfo(obj) {
        $.ajax({
            url: "${ctx}/admin/media/productInfo",
            type: "POST",
            dataType: "json",
            data: {"id": obj.value.toString()},
            success: function (data) {
                if (data.code == 200) {
                    if (data.entity) {
                        //显示图片
                        $('#select_pic').attr("src","/photo/product/" + data.entity.picUrl.toString());

                        //名称
                        $('#select_name').text(data.entity.name);

                        //类型
                        var type = data.entity.type;
                        switch (type) {
                            case "1":
                                $('#select_type').text("普通");
                                break;
                            case "2":
                                $('#select_type').text("定制");
                                break;
                            case "3":
                                $('#select_type').text("约伴");
                                break;
                        }

                        //评分
                        $('#select_score').text(data.entity.productAvgVote);

                        //等级
                        var level = "";
                        for (var i = 0; i < data.entity.degreeDifficulty; i++) {
                            level += "★";
                        }
                        $('#select_difficulty').text(level);
                    }
                } else {
                    alert("系统繁忙");
                }
            },
            error: function () {
                alert("系统繁忙");
            }
        });
        $(".custom-add-dialog").show();
        $(".custom-mask").show();
    }

    <!-- 添加 -->
    function add() {
        $.ajax({
            url: "${ctx}/admin/media/save",
            type: "POST",
            dataType: "json",
            data: {"city.id": $('#city').val(), "location": $('#location').val(), "module": $('#module').val(), "product.id": $('#productSelect').val()},
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
</script>
</body>
</html>
