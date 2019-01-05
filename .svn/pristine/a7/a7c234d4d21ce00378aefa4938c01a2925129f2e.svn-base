/**
 * Created by lenovo on 2017/8/27.
 */
$(function () {
    /**
     * 省内短线+国内长线+国外长线+海岛路线+最新活动
     * 活动列表展开收起
     */
    FastClick.attach(document.body);
    $(".my-spread-down").click(function () {
        $(this).prev(".my-hidden").slideDown();
        $(this).hide();
        $(this).next().show();
    });
    $(".my-spread-up").click(function () {
        $(this).prev().prev(".my-hidden").slideUp();
        $(this).hide();
        $(this).prev().show();
    });
});