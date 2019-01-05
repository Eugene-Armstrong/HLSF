/**
 * Created by lenovo on 2017/8/27.
 */
$(function () {
    /**
     * 省内短线+国内长线+国外长线+海岛路线+最新活动
     * 活动列表展开收起
     */
    $(document).on("click",".my-spread-down",function () {
        $(this).prev(".my-hidden").slideDown();
        $(this).hide();
        $(this).next().show();
    })
        .on("click",".my-spread-up",function () {
            $(this).prev().prev(".my-hidden").slideUp();
            $(this).hide();
            $(this).prev().show();
        });
});