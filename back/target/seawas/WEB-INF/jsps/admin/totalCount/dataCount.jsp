<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>数据统计</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        select {
            display: inline !important;
            margin-left: 10px;
            width: 15% !important;
        }
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-table"></span> 数据统计</strong>
        <select class="input" name="more">
            <option value="1">总数据统计</option>
            <option value="2">注册用户统计</option>
            <option value="3">领队人数统计</option>
            <option value="4">产品数量统计</option>
            <option value="5">总成交量统计</option>
            <option value="6">总成交金额统计</option>
        </select>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th width="20%">注册用户人数</th>
            <th width="20%">领队人数</th>
            <th width="20%">产品数量</th>
            <th width="20%">总成交数量</th>
            <th width="20%">总成交金额</th>
        </tr>
        <tr>
            <td>
                <a href="${ctx}/admin/totalCount/showDataCountUsers" title="注册用户统计">
                    ${totalCountData.userNum}
                </a>
            </td>
            <td>
                <a href="${ctx}/admin/totalCount/showDataCountLeaders" title="领队人数统计">
                    ${totalCountData.leaderNum}
                </a>
            </td>
            <td>
                <a href="${ctx}/admin/totalCount/showDataCountProduct" title="产品数量统计">
                    ${totalCountData.productNum}
                </a>
            </td>
            <td>
                <a href="${ctx}/admin/totalCount/showDataCountTotalNum" title="总成交量统计">
                    ${totalCountData.orderNum}
                </a>
            </td>
            <td>
                <a href="${ctx}/admin/totalCount/showDataCountTotalMoney" title="总成交金额统计">
                    ${totalCountData.orderPrice * 0.01}
                </a>
            </td>
        </tr>
    </table>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        //下拉框onChange
        $("select[name=more]").change(function () {
            var v = $(this).find("option:selected").val();
            switch (v){
                case "1":$(location).prop("href","${ctx}/admin/totalCount/showTotalCount");break;
                case "2":$(location).prop("href","${ctx}/admin/totalCount/showDataCountUsers");break;
                case "3":$(location).prop("href","${ctx}/admin/totalCount/showDataCountLeaders");break;
                case "4":$(location).prop("href","${ctx}/admin/totalCount/showDataCountProduct");break;
                case "5":$(location).prop("href","${ctx}/admin/totalCount/showDataCountTotalNum");break;
                case "6":$(location).prop("href","${ctx}/admin/totalCount/showDataCountTotalMoney");break;
            }
        })
    })
</script>
</body>
</html>

