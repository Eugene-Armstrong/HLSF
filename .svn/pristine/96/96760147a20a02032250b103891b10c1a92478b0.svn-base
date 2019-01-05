<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>订单详情</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        body{padding-bottom: 30px}
        /*自定义模态框*/
        .custom-mask{
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            right: 0;
            bottom: 0;
            background: #000;
            z-index: 10;
            filter: alpha(opacity=50);
            opacity: .5;
            overflow-x: hidden;
            overflow-y: auto;
        }
        #refundDialog{
            display: none;
            position: fixed;
            top: 10%;
            left: 25%;
            width: 50%;
            border: 1px solid #ddd;
            z-index: 99;
            box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
            border-radius: 4px;
            background-color: #fff;
        }
        .custom-head{
            padding: 10px 20px;
            border-bottom: solid 1px #ddd;
            background-color: #f5f5f5;
        }
        .close{float: right}
        .custom-body{
            padding: 15px 20px;
        }
        .custom-body td{border: none}
        .custom-foot{
            padding: 10px 20px;
            text-align: right;
            border-top: solid 1px #ddd;
        }
        .table th{vertical-align: middle}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-tags"></span> 订单详情</strong>
        <span class="float-right">
            <a href="javascript:history.back()">
                <span class="icon-reply"> 返回</span>&nbsp;&nbsp;&nbsp;&nbsp;
            </a>
        </span>
    </div>
    <table class="table table-hover table-bordered">
        <tr>
            <td class="text-right" width="200px">订单编号：</td>
            <td width="30%"><span>${order.merOrderNumber}</span></td>
            <td>产品图片：</td>
        </tr>
        <tr>
            <td class="text-right" width="200px">交付金额：</td>
            <td>￥ <span>${order.price * 0.01}</span></td>
            <td rowspan="16"><img src="/photo/product/${order.activity.product.picUrl}" class="img-border" style="width: 100%"></td>
        </tr>
        <tr>
            <td class="text-right">产品名称：</td>
            <td>${order.activity.product.name}</td>
        </tr>
        <tr>
            <td class="text-right">出发城市：</td>
            <td>${order.city.name}</td>
        </tr>
        <tr>
            <td class="text-right">出发地点：</td>
            <td>${order.gatherPlace}</td>
        </tr>
        <tr>
            <td class="text-right">出发时间：</td>
            <td><fmt:formatDate value="${order.activity.departTime}" type="both"/></td>
        </tr>
        <tr>
            <td class="text-right">备注：</td>
            <td>${order.remark}</td>
        </tr>
        <tr>
            <td class="text-right">订单状态：</td>
            <td><span>${fns:getDictLabel('orderState', order.state, '')}</span></td>
        </tr>
        <tr>
            <td class="text-right">下单时间：</td>
            <td><span><fmt:formatDate value="${order.createTime}" type="both"/></span></td>
        </tr>
        <c:if test="${order.state == '2' || order.state == '3' || order.state== '4'}">
            <tr>
                <td class="text-right">支付时间：</td>
                <td><span><fmt:formatDate value="${order.payTime}" type="both"/></span></td>
            </tr>
        </c:if>
        <c:if test="${order.state == '3' || order.state == '4'}">
            <tr>
                <td class="text-right">申请退款时间：</td>
                <td><span><fmt:formatDate value="${order.applyRefundTime}" type="both"/></span></td>
            </tr>
        </c:if>
        <c:if test="${order.state == '4'}">
            <tr>
                <td class="text-right">退款时间：</td>
                <td><span><fmt:formatDate value="${order.auditTime}" type="both"/></span></td>
            </tr>
            <tr>
                <td class="text-right">退款审核人：</td>
                <td><span>${order.admin.realName}</span></td>
            </tr>
        </c:if>
        <%--<c:if test="${order.state == '3'}">
            <tr>
                <td></td>
                <td>
                    <button class="button border-blue" onclick="refund('${order.id}', '4')">允许退款</button>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="#"><button type="button" class="button border-red" onclick="refund('${order.id}', '2')">拒绝退款</button></a>
                </td>
            </tr>
        </c:if>--%>
        <c:if test="${sessionScope.admin.isSuperAdmin == '1'}">
            <c:if test="${order.state == '3'}">
                <tr>
                    <td class="text-right">退款审核：</td>
                    <td>
                        <a href="javascript:" class="button border-blue" id="allow">允许退款</a>
                        &nbsp;&nbsp;
                        <a href="javascript:" class="button border-red" id="reject">拒绝退款</a>
                    </td>
                </tr>
            </c:if>
        </c:if>
    </table>
    <br><br>
    <table class="table table-striped text-center table-bordered">
        <tr>
            <th colspan="6" style="text-align: left;padding: 10px 15px">
                <span class="icon-table"></span> 用户报名表
            </th>
            <td colspan="3"><a class="button border-blue" target="_blank" href="${ctx}/admin/order/exportExcel?orderId=${order.id}">导出用户报名表</a></td>
        </tr>
        <tr>
            <th width="15%">订单号</th>
            <th width="10%">用户真实姓名</th>
            <th width="10%">性别</th>
            <th width="10%">年龄</th>
            <th width="10%">手机号码</th>
            <th width="15%">身份证号</th>
            <th width="10%">购买价格</th>
            <th width="10%">优惠规则</th>
            <th width="10%">优惠比例</th>
        </tr>
        <c:forEach var="sign" items="${signs}">
            <tr>
                <td>${order.merOrderNumber}</td>
                <td>${sign.name}</td>
                <td>${fns:getDictLabel('sex',sign.sex,'')}</td>
                <td>${sign.age}</td>
                <td>${sign.phone}</td>
                <td>${sign.certId}</td>
                <td>${sign.price * 0.01}</td>
                <td>
                    <c:if test="${not empty sign.promotion}">
                        ${sign.promotion.detail}
                    </c:if>
                </td>
                <td>
                    <c:if test="${not empty sign.promotion}">
                        ${sign.promotion.rule}
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<!--退款审核模态框-->
<div class="custom-mask"></div>
<div id="refundDialog">
    <div class="custom-dialog">
        <div class="custom-head">
            <span class="close rotate-hover"></span>
            <strong style="font-size: 16px">退款审核</strong>
            <span style="color: #999">
                （交付金额为￥${order.price * 0.01}，退款金额不得超过交付金额）
            </span>
        </div>
        <form action="">
            <div class="custom-body">
                <table class="table table-hover">
                    <tr>
                        <td class="text-right">退款金额：</td>
                        <td>
                            <input class="input" type="number" placeholder="请输入退款金额(元)" id="refundNum" required>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">退款密码：</td>
                        <td>
                            <input class="input" type="password" placeholder="请输入退款密码" id="refundPwd" required>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="custom-foot">
                <button class="button border-green">发起退款</button>
                &nbsp;&nbsp;
                <button class="button dialog-close" type="button">取消</button>
            </div>
        </form>
    </div>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script>
    var $dialog = $("#refundDialog"),
        $mask = $(".custom-mask"),
        $refundNum = $("#refundNum"),
        $refundPwd = $("#refundPwd"),
        _refundNum, _orderPrice = ${order.price * 0.01},check = true;
    $(document)
        .on("change",$refundNum,function () {
            _refundNum = Number(Number($refundNum.val()).toFixed(2));
            if(_refundNum > _orderPrice){
                alert("退款金额不得超过交付金额，请重新填写");
                $refundNum.focus();
                check = false;
            }
        })
        // 发起退款
        .on("click",".custom-foot .border-green",function () {
            check = true;
            if($refundNum.val()==""){
                alert("退款金额不能为空");
                $refundNum.focus();
                check = false;
            }else if($refundPwd.val() == ""){
                alert("退款密码不能为空");
                $refundPwd.focus();
                check = false;
            }
            if(check){
                refund('${order.id}', '4');
            }
        })
        //允许退款
        .on("click","#allow",function () {
            $dialog.show();
            $mask.show();
        })
        //拒绝退款
        .on("click","#reject",function () {
            refund('${order.id}', '2');
        })
        .on("click",".close",function () {
            $dialog.hide();
            $mask.hide();
        });

    /**
     * 退款处理
     * @param orderId - 订单id
     * @param state - 订单状态（2:退款失败，4:退款成功）
     */
    function refund(orderId, state) {
        event.preventDefault();
        $.ajax({
            url: "${ctx}/admin/order/refund",
            type: "POST",
            dataType: "json",
            data: {"id": orderId, "state": state, "refundPrices": $refundNum.val(), "password": $refundPwd.val()},
            success: function (data) {
                if (data.code == 200) {
                    alert(data.message);
                    location.reload(true);
                } else {
                    alert(data.message);
                }
            },
            error: function () {
                location.reload();
            }
        });
    }
</script>
</body>
</html>
