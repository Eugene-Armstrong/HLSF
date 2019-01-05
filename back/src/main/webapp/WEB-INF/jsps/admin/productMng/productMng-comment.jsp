<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fns" uri="http://java.sun.com/jsp/jstl/functionss" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>产品评价</title>
    <link rel="stylesheet" href="${ctx}/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/css/admin.css">
    <style>
        a[href='#del']{color: red}
        a[href='#yes'],a[href='#no']{display: none}
        .ckb{display: none}
        select {
            display: inline !important;
            margin-left: 10px;
            width: 30% !important;
        }
        .ac-com,.sys-com{
            width: 180px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .line-small img {
            margin-top: 10px
        }

        /*自定义照片大图查看模态框*/
        .custom-dialog {
            display: none;
            background-color: rgba(0, 0, 0, 0) !important;
            position: absolute;
            border-radius: 4px;
            background-color: #fff;
            max-width: 80%;
            z-index: 9999;
        }
        .custom-mask{
            position: absolute;
            display: none;
            top: 0;
            width: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 999;
        }
        .table{border-bottom: 2px solid #eee}

        img {
            cursor: pointer
        }
        .panel-head{line-height: 42px}
        .message{margin-top: 20px;padding: 0 20px}
        .pagination{margin-bottom: 30px}
        .pagination .active{
            background: #337ab7!important;
        }
        .active a{
            color: #fff!important;
        }
        .pagination  a{
            border: 1px solid #eee!important;
        }
        .empty-tip{width: 100%;text-align: center;padding: 20px 0;line-height: 20px;color: #999}
        #empty{width: 200px;opacity: .5}
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <span style="float: right;line-height: 42px">
            <a class="icon-reply" href="javascript:window.history.back()"
               style="margin-right:20px"> 返回</a>
            <c:if test="${allComment.list!=[]}">
                <a class="icon-trash-o" href="#del" style="margin-right: 20px"> 删除评价</a>
            </c:if>
            <a href="#yes"> 确认删除</a>&nbsp;
            <a href="#no" style="margin-right: 20px"> 取消删除</a>
        </span>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th width="5%" style="display: none">
            全选 <input type="checkbox" value="all">
            </th>
            <th width="20%">产品名称</th>
            <th width="15%">用户名</th>
            <th width="10%">产品评分</th>
            <th width="15%">评论时间</th>
            <th width="10%">评价内容</th>
            <th width="10%">系统回复</th>
            <th width="15%">操作</th>
            </tr>
            <c:forEach items="${allComment.list}" var="com">
                <tr>
                    <td class="ckb"><input type="checkbox"></td>
                    <td hidden="true" class="com-id">${com.id}</td>
                    <td>${com.productName}</td>
                    <td>${com.userNickName}</td>
                    <td>${com.grade}</td>
                    <td><fmt:formatDate value="${com.createTime }" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="ac-com"><div class="ac-com">${com.commentContent}</div></td>
                    <td class="sys-com"><div class="sys-com">${com.sysReply}</div></td>
                    <td>
                        <a href="#" class="dialogs more" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%">
                            查看更多
                        </a>/
                        <c:if test="${fns:isReplyByMng(com.id)==false}">
                            <a href="#" class="dialogs reply" data-toggle="click" data-target="#reply" data-mask="1" data-width="50%">
                                回复
                            </a>
                        </c:if>
                        <c:if test="${fns:isReplyByMng(com.id)==true}">
                            <a href="#" class="dialogs see-reply" data-toggle="click" data-target="#replied" data-mask="1" data-width="50%">
                                已回复
                            </a>
                        </c:if>
                    </td>
                </tr>
        </c:forEach>
    </table>
    <c:if test="${allComment.list==[]}">
        <div class="empty-tip">
            <img src="${ctx}/images/empty-pic.png" id="empty">
            <br>该产品暂未有评价哦~ (｡･ω･｡)
        </div>
    </c:if>
    <!-- 页数 -->
    <div class="message">
        共<i class="blue">${allComment.total}</i>条记录，当前显示第&nbsp;<i
            class="blue">${allComment.pageNum}/${allComment.pages}</i>&nbsp;页
    </div>
    <div style="text-align:center;margin-top: -20px">
        <ul class="pagination">
            <!-- <li><a href="#">&laquo;</a></li> -->
            <c:if test="${!allComment.isFirstPage}">
                <li><a href="${ctx}/admin/productComment/showData?pageNumber=1&pageSize=${allComment.pageSize}">首页</a></li>
                <li><a href="${ctx}/admin/productComment/showData?pageNumber=${allComment.prePage}&pageSize=${allComment.pageSize}">上一页</a></li>
            </c:if>
            <c:forEach items="${allComment.navigatepageNums}" var="navigatepageNum">
                <c:if test="${navigatepageNum==allComment.pageNum}">
                    <li class="active"><a href="${ctx}/admin/productComment/showData?pageNumber=${navigatepageNum}&pageSize=${allComment.pageSize}">${navigatepageNum}</a></li>
                </c:if>
                <c:if test="${navigatepageNum!=allComment.pageNum}">
                    <li><a href="${ctx}/admin/productComment/showData?pageNumber=${navigatepageNum}&pageSize=${allComment.pageSize}">${navigatepageNum}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${!allComment.isLastPage}">
                <li><a href="${ctx}/admin/productComment/showData?pageNumber=${allComment.nextPage}&pageSize=${allComment.pageSize}">下一页</a></li>
                <li><a href="${ctx}/admin/productComment/showData?pageNumber=${allComment.pages}&pageSize=${allComment.pageSize}}">最后一页</a></li>
            </c:if>
        </ul>
    </div>

    <!--详细评价模态框-->
    <div id="mydialog">
        <div class="dialog">
            <div class="dialog-head">
                <span class="close rotate-hover"></span><strong>详细产品评价</strong>
            </div>
            <div class="dialog-body line-small my-test">
                <textarea rows="3" style="width: 100%" class="input xs12" placeholder="用户评价内容" readonly></textarea>
                <%--   <c:forEach items="${cp}" var="obj">
                   <img src='${obj.pictureUrl}' class = 'radius-small xs2' onclick='myImg(this)'/>
                 </c:forEach>--%>
            </div>

            <div class="dialog-foot">
                <span class="float-left" style="color: #999">点击图片查看大图（最多显示5张）</span>
                <button class="button dialog-close">关闭</button>
            </div>
        </div>
    </div>

    <!--回复产品评价模态框-->
    <div id="reply">
        <div class="dialog">
            <div class="dialog-head">
                <span class="close rotate-hover"></span><strong>回复产品评价</strong>
            </div>


            <div class="dialog-body">
                <input  name="commentId" type="hidden">
                <textarea rows="5" style="width: 100%" class="input my-test-reply"
                          name="managerReplyContent" placeholder="请输入回复内容"></textarea>
            </div>
            <div class="dialog-foot">
                <button class="button border-blue" id="sendReply">
                    发送
                </button>
                <button class="button dialog-close" type="button">
                    关闭
                </button>
            </div>
            </form>
        </div>
    </div>

    <!--已回复模态框-->
    <div id="replied">
        <div class="dialog">
            <div class="dialog-head">
                <span class="close rotate-hover"></span><strong>回复内容</strong>
            </div>

            <div class="dialog-body replied">

                <%--<input  name="commentId" type="hidden">--%>
                <textarea rows="5" style="width: 100%" class="input" name="managerReplyContent" readonly></textarea>
            </div>
            <div class="dialog-foot">
                <button class="button dialog-close" type="button">
                    关闭
                </button>
            </div>
            </form>
        </div>
    </div>
</div>
<!--查看照片原图-->
<div class="custom-mask"></div>
<div class="custom-dialog">
    <img src="" title="返回" class="img-responsive" id="imgDetail" style="max-width: 1000px">
</div>
<script src="${ctx}/js/jquery.js"></script>
<script src="${ctx}/js/pintuer.js"></script>
<script type="text/javascript">
    $(function () {
        var idSelected = "";
        //点击删除事件
        $("a[href='#del']").click(function () {
            $(this).hide();
            $("a[href='#yes'], a[href='#no'], th:first, .ckb").show();
        });
        //点击确认删除
        $("a[href='#yes']").click(function () {
            var intL = $("input:checked").length; // 获取所有复选框选中项
            if (intL != 0) { // 如果有选中项
                var sure = confirm("您确定要删除所选的产品评价吗？");
                if(sure){
                    $("input[type=checkbox]").each(function (index) { // 遍历全部复选框的行
                        if (this.checked) { // 如果选中
                            idSelected += ($(this).parent("td").next("td").text() + ",");//获取勾选项id
                        }
                    }); $.ajax({
                        type:'post',
                        url: "${ctx}/admin/productComment/delete", // 请求处理页
                        dataType: "html",
                        data: {idSelected: idSelected},
                        success: function (result) {
                            if (result == '0'){
                                alert("删除失败");
                            }
                            else {
                                alert("删除成功");
                            }
                            window.location.href = "${ctx}/admin/productComment/showData";
                        }
                    });
                }
            } else {
                alert("请先选中要删除的产品评价！");
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
        //点击查看更多
        var obj;
        $(".more").click(function () {
            $(".dialog-body img").remove();
            var commentId = $(this).parent().siblings(".com-id").text();
            var txt = $(this).parent().siblings(".ac-com").find("div").text()
            $(".my-test textarea").val(txt);
            $.ajax({
                type:'post',
                url: "${ctx}/admin/productComment/showPicture", // 请求处理页
                dataType: "json",
                data: {commentId: commentId},
                success: function (data) {
                    obj = eval(data);
                    $(obj).each(function (index) {
                        var val = obj[index];
                        $(".my-test textarea").after("<img src='"+val.pictureUrl+"' class = 'radius-small xs2' onclick='myImg(this)'/>");
                    });
                }
            });
        });

        $(".reply").click(function () {
            $("#reply .dialog-body input").val($(this).parent().siblings(".com-id").text());
        });
        $(".see-reply").click(function () {
            $(".replied textarea").val($(this).parent().siblings(".sys-com").text());
        });

        //点击回复评论
        $(document).on("click","#sendReply",function () {
            var managerReplyContent =   $(this).parent().prev()
                .find(".my-test-reply").val();
            var commentId =  $(".dialog-body input").val();
            $.ajax({
                type:'post',
                url: "${ctx}/admin/productComment/managerReply", // 请求处理页
                dataType: "html",
                data: {managerReplyContent: managerReplyContent,commentId:commentId},
                success: function (result) {
                    if (result == '0'){
                        alert("回复失败");
                    }
                    else {
                        alert("回复成功");
                    }
                    window.location.href = "${ctx}/admin/productComment/showData";
                }
            });
        })
    });



    //点击图片查看大图
    function myImg(imgObj) {
        var customDialog = document.getElementsByClassName("custom-dialog");
        customDialog[0].style.display = "block";
        var customMask= document.getElementsByClassName("custom-mask");
        customMask[0].style.display = "block";
        //背景低亮
        customMask[0].style.height = document.body.scrollHeight + "px";
        window.onscroll = function () {
            customMask[0].style.height = document.body.scrollHeight + "px";
        };
        var target = document.getElementById("imgDetail");//新的图片对象
        target.src = imgObj.src;//获取图片路径（对象已包含原图实际宽高）

        //使大图在恰当的位置显示
        target.onload = function () {
            var ml = (document.body.clientWidth - this.width) / 2;
            var tp = (document.body.clientHeight - this.height) / 2;
            customDialog[0].style.marginLeft = ml + "px";
            if (tp >= 0) {
                customDialog[0].style.top = tp + "px";
            } else {
                customDialog[0].style.top = "20px";
                customDialog[0].style.paddingBottom = "30px";
            }
        };
        //点击关闭事件
        var cls = function () {
            customDialog[0].style.display = "none";
            customMask[0].style.display = "none";
        };
        target.onclick = cls;
        customMask[0].onclick = cls;
    }
</script>
</body>
</html>
