<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>已下架产品列表</title>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        a[href='#yes'], a[href='#no'], th:first-child, .ckb{display: none}
        a[href='#del']{color: red}
        .input {
            display: inline !important;
            width: 25%;
            margin-right: 10px;
        }
        .table td{vertical-align: middle!important;}
        td img {
            height: 64px;
        }
        .panel-head{line-height: 42px}
        form{display: inline}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong><span class="icon-cube"></span> 已下架产品</strong>
        <form:form id ="searchForm" action="${ctx}/product/ShowOffSaleProduct" method="post" modelAttribute="productVo">
            <input id="pageNumber" name="pageNumber" type="hidden" value="${pageInfo.pageNum}">
            <input id="pageSize" name="pageSize" type="hidden" value="${pageInfo.pageSize}">
            <button class="button border-blue" style="float: right;margin-right: 5px" onclick="change(${pageInfo.pageNum})">
                查询 <span class="icon-search-plus"></span>
            </button>
            <form:input type="text" class="input" style="float: right"
                        name="searchtxt" placeholder="输入产品名进行查询" path="searchtxt"/>
        </form:form>
        <a href="${ctx}/product/showProduct"  style="margin-right: 10px"
           class="button float-right">返回</a>
    </div>
    <div class="padding border-bottom" style="overflow: hidden">
        <span style="float: right">
            <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 重新上架</a>
            <a href="#yes"> 确认上架</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消上架</a>
        </span>
    </div>
    <form id="productShow">
    <table class="table table-hover text-center">
        <tr>
            <th width="10%">
                全选 <input type="checkbox" value="all">
            </th>
            <th width="15%">已下架产品图片</th>
            <th width="20%">已下架产品名称</th>
            <th width="10%">产品类别</th>
            <th width="20%">创建时间</th>
            <th width="5%">评分</th>
            <th width="10%">浏览量</th>
            <th width="10%">操作</th>
        </tr>
        <c:forEach items="${pageInfo.list }" var="product">
            <tr>
                <td class="ckb"><input type="checkbox" name="productId" value="${product.id}"/></td>
                <td>
                    <img src="/photo/product/${product.picUrl}" alt="" class="my-size">
                </td>
                <td>${product.name}</td>
                <td>${fns:getDictLabel('productType',product.type,'')}</td>
                <td><fmt:formatDate value="${product.createTime}"
                                    pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td>${product.productAvgVote}</td>
                <td>${product.readNumber}</td>
                <td>
                    <a href="${ctx}/product/showProductDetail?id=${product.id}">产品详情</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    </form>
</div>
<div>
    <%@ include file="/WEB-INF/include/pagehelper.jsp"%>
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        //点击重新上架事件
        $("a[href='#del']").click(function () {
            $(this).hide();
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").show();
        });
        //点击确认取消下架
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                $.ajax({
                    type: "POST",
                    url:"${ctx}/product/onSalProduct",
                    data:$('#productShow').serialize(),// 要提交的表单
                    dataType: "JSON",
                    success: function(result) {
                        alert("正在上架所选的产品…");
                        $('#searchForm').submit();
                    },
                    error:function(result) {
                        alert("您确定要上架所选的产品吗？");
                        $('#searchForm').submit();
                    },
                });
            } else {
                alert("请先选中要上架的产品！");
            }
        });
        //点击取消上架
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
