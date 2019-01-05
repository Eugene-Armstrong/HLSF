<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta name="renderer" content="webkit">
    <title>产品管理</title>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        select {
            display: inline !important;
            margin-left: 5px;
            width: 12% !important;
        }
        .input {
            display: inline !important;
            width: 20%;
        }
        a[href='#yes'], a[href='#no'], th:first-child, .ckb{
            display: none;
        }
        a[href='#del']{color: red}
        td img {max-height: 64px;}
        .table{margin-bottom: 0}
        .table td{vertical-align: middle!important;}
        form{display: inline}
        .my-size{width: 180px;height: 100px}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-cube"></span> 产品管理</strong>
        <form:form id ="searchForm" action="${ctx}/product/showProduct" method="post" modelAttribute="productVo">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <form:select path="classId" class="input" onchange="change()">
                <form:option value="">请选择产品分类</form:option>
                <c:forEach items="${sortList}" var="sort">
                    <form:option value="${sort.id}">${sort.name}</form:option>
                </c:forEach>
            </form:select>
            <form:select path="cityId" class="input" onchange="change()">
                <form:option value="">请选择出发城市</form:option>
                <c:forEach items="${cityList}" var="citys">
                    <form:option value="${citys.id}">${citys.name}</form:option>
                </c:forEach>
            </form:select>
            <form:select path="media"  class="input" onchange="change()">
                <form:option value="">请选择线路种类</form:option>
                <form:option value="12">省内短线</form:option>
                <form:option value="13">国内长线</form:option>
                <form:option value="14">境外长线</form:option>
                <form:option value="15">团队出行</form:option>
            </form:select>
            <form:select path="type" class="input" onchange="change()">
                <form:option value="">请选择产品类别</form:option>
                <form:option value="1">普通产品</form:option>
                <form:option value="2">企业定制</form:option>
                <form:option value="3">约伴</form:option>
            </form:select>
            <button class="button border-blue float-right" onclick="change(${pageInfo.pageNum})">
                查询 <span class="icon-search-plus"></span>
            </button>
            <form:input type="text" class="input float-right" style="margin-right: 5px"
                        name="searchtxt" placeholder="输入产品名进行查询" path="searchtxt"/>
        </form:form>
        <a href="${ctx}/product/ShowOffSaleProduct" class="button float-right" style="margin-right: 10px">查看下架产品</a>
    </div>
    <div class="padding border-bottom" style="overflow: hidden">
        <span style="float: right">
            <a style="margin-right: 20px" class="icon-plus-square-o" href="${ctx}/product/showAddProduct"> 添加产品</a>
            <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 产品下架</a>
            <a href="#yes"> 确认下架</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消下架</a>
        </span>
    </div>
    <form id="productShow">
        <table class="table table-hover text-center">
            <tr>
                <th width="8%">
                    全选 <input type="checkbox" value="all">
                </th>
                <th width="5%">序号</th>
                <th width="10%">产品图片</th>
                <th width="20%">名称(点击查看活动列表)</th>
                <th width="15%">产品创建时间</th>
                <th width="10%">类别</th>
                <th width="5%">难度</th>
                <th width="5%">评分</th>
                <th width="10%">浏览次数</th>
                <th width="20%">操作</th>
            </tr>
            <c:forEach items="${pageInfo.list}" var="product" varStatus="status">
                <tr>
                    <td class="ckb"><input type="checkbox" name="productId" value="${product.id}"/></td>
                    <td>${status.index+1+(pageInfo.pageNum-1)*pageInfo.pageSize}</td>
                    <td>
                        <img src="/photo/product/${product.picUrl}" alt="" class="my-size">
                    </td>
                    <td>
                        <a href="${ctx}/activity/showProductActivity?productId=${product.id}">${product.name}</a>
                    </td>
                    <td><fmt:formatDate value="${product.createTime}"
                                        pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td>${fns:getDictLabel('productType',product.type,'')}</td>
                    <td>${product.degreeDifficulty}</td>
                    <td><fmt:formatNumber value="${product.productAvgVote}" pattern="#.0#"/></td>
                    <td>${product.readNumber}</td>
                    <td>
                        <a href="${ctx}/product/showProductDetail?id=${product.id}">详情</a> /
                        <a href="${ctx}/product/findComment?productId=${product.id}">评价</a> /
                        <a href="${ctx}/product/showProductChange?id=${product.id}">修改</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>
    <c:if test="${pageInfo.list == []}">
        <div style="width: 100%;margin: 30px;text-align: center;font-size: 18px">
            <span class="icon-warning"></span> 暂无产品数据</div>
    </c:if>
</div>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp"%>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        //点击下架事件
        $("a[href='#del']").click(function () {
            $(this).hide();
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").show();
        });
        //点击确认下架
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                $.ajax({
                    type: "POST",
                    url:"${ctx}/product/deleteProduct",
                    data:$('#productShow').serialize(),// 要提交的表单
                    dataType: "JSON",
                    success: function(result) {
                        alert("正在下架所选的产品");
                        $('#searchForm').submit();
                    }
                });
            } else {
                alert("请先选中要下架的产品！");
            }
        });
        //点击取消删除
        $("a[href='#no']").click(function () {
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").hide();
            $("a[href='#del']").show();
        });
        //全选复选框
        $("input[value='all']").click(function () {
            if (this.checked) { // 如果自己被选中
                $("input[type=checkbox]").prop("checked", true);
            } else { // 如果自己没被选中
                $("input[type=checkbox]").prop("checked", false);
            }
        });
    });
    /**
     * 分页必需
     * @param n
     * @param s
     * @returns {boolean}
     */
    function page(n,s) {
        $('#pageNumber').val(n);
        $('#pageSize').val(s);
        $('#searchForm').submit();
        return false;
    }
    /**
     * 下拉框onChange事件（表单刷新）
     * @returns {boolean}
     */
    function change() {
        $('#pageNumber').val(1);
        $('#searchForm').submit();
        return false;
    }
</script>
</body>
</html>
