package cn.edu.bnuz.seawas.sysconfig;

import cn.edu.bnuz.seawas.dao.ActivityLeaderMapper;
import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.dao.OrdersMapper;
import cn.edu.bnuz.seawas.dao.UserMapper;
import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.service.SignService;
import cn.edu.bnuz.seawas.service.admin.ActivityService;
import cn.edu.bnuz.seawas.service.weChat.WCommentService;
import cn.edu.bnuz.seawas.service.weChat.WxOrderService;
import cn.edu.bnuz.seawas.service.weChat.index.UserService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityDetailService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityService;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import cn.edu.bnuz.seawas.vo.ChangeProductGrade;
import cn.edu.bnuz.seawas.vo.WxProductDetailVo;
import com.foxinmy.weixin4j.payment.WeixinPayProxy;
import com.foxinmy.weixin4j.payment.mch.MerchantResult;
import com.foxinmy.weixin4j.util.DateUtil;
import com.foxinmy.weixin4j.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 定时器任务
 * Created by sjk on 2017-09-08.
 */
@Component
public class TimerTask {

    private Logger logger = LoggerFactory.getLogger(TimerTask.class);

    @Autowired
    private WxOrderService orderService;

    @Autowired
    private WeixinPayProxy weixinPayProxy;

    @Autowired
    private UserService userService;

    @Autowired
    private WxActivityService activityService;

    @Autowired
    private WxActivityDetailService activityDetailService;

    @Autowired
    private SignService signService;

    @Autowired
    private ActivityService actService;

    @Autowired
    private WCommentService commentService;

    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ActivityLeaderMapper activityLeaderMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 每天0点执行
     * 将7天前的 未设置的活动评价默认好评
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void setDefaultCommon() throws Exception {

        //查询7天前未评价的订单
        List<Orders> ordersList = orderService.find7DaysBeforeOeders();

        //遍历订单列表
        for (Orders order : ordersList) {

            ProductComment productComment = new ProductComment();
            productComment.setActivityId(order.getActivity().getId());
            productComment.setUserId(order.getUser().getId());
            productComment.setGrade(5);
            productComment.setCommentContent("系统自动好评");
            productComment.setProductId(order.getActivity().getProduct().getId());
            productComment.setId(UUIDUtil.createUUID());
            productComment.setCreateTime(new Date());
            productComment.setOrderId(order.getId());
            commentService.insertSelective(productComment);

            commentService.addLeaderScore(order.getUser().getId(), order.getActivity().getId(), 5);

            order.setIsComment("1");
            ordersMapper.updateByPrimaryKeySelective(order);

            ChangeProductGrade changeProductGrade = new ChangeProductGrade();
            changeProductGrade.setId(order.getActivity().getProduct().getId());
            changeProductGrade.setScore(5);
            commentService.updateProductScore(changeProductGrade);
        }
    }

    /**
     * 将订单状态为待支付的订单 且 下单时间超过30分钟的
     * 执行关闭订单，并向微信服务器请求关闭订单申请
     */
    @Scheduled(cron = "0 */1 * * * ?")
    public void closeUnPayOrder() throws Exception {

        //查询出需要关闭支付的订单
        List<Orders> ordersList = orderService.findPass30MinOrders();

        //遍历订单列表
        for (Orders order : ordersList) {
            if (StringUtil.isNotBlank(order.getMerOrderNumber())) {
                //发起关闭订单申请
                MerchantResult result = weixinPayProxy.closeOrder(order.getMerOrderNumber());
                //如果返回结果为SUCCESS，则代表订单已成功关闭，执行更新数据库操作
                if (result.getResultCode().equals("SUCCESS")) {
                    //设置订单状态
                    orderService.updatePayInfo(new Orders(order.getMerOrderNumber(), "5"));

                    //获取本订单的报名人数
                    Integer orderNum = signService.countSign(order.getId());
                    //获取本活动已报名的人数
                    WxProductDetailVo temp = activityDetailService.getWxProductActivityDetails(order.getActivity().getProduct().getId(), order.getActivity().getId());
                    Integer activityNum = temp.getActivityVoList().get(0).getNum();

                    Activity activity = activityService.getActivityDetail(order.getActivity().getId());
                    //设置活动状态
                    if ((activityNum - orderNum) >= activity.getTotalNumber()) {
                        activity.setState("已满人");
                    } else if ((activityNum - orderNum) >= activity.getTripNumber()) {
                        activity.setState("已成行");
                    } else {
                        activity.setState("未成行");
                    }

                    //更新活动表信息
                    actService.updateByPrimaryKeySelective(activity);

                    //假删除报名表
                    signService.deleteByOrder(order.getId());

                    logger.info("成功修改数据库信息");
                } else {
                    logger.info("订单关闭失败");
                }
            }
        }
    }

    /**
     * 活动到了活动结束日期，系统强制结束活动
     * 同时添加用户的积分
     */
    @Scheduled(cron = "0 */1 * * * ?")
    public void endActivity() throws Exception {

        logger.info("start to close activities");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        //查询出已经到了结束时间的活动
        List<Activity> activityList = activityMapper.findEndTimeActivity(sdf.format(new Date()));

        //遍历活动列表进行相应操作
        for (Activity activity : activityList) {

            //改变活动状态
            activityMapper.changeActivityState(activity.getId(), "已结束");

            //查询本次活动带队的领队
            List<ActivityLeader> activityLeaderList = activityLeaderMapper.findList(new ActivityLeader(activity.getId(), null));
            //更新领队带队次数
            for (ActivityLeader activityLeader : activityLeaderList) {
                userMapper.updateLeaderNum(new User(activityLeader.getLeaderId()));
            }

            //查询本次活动中的订单,且订单状态为已支付
            List<Orders> orderList = ordersMapper.findListByActivityId(activity.getId(), "2");
            //将积分、经验值添加进用户账户
            for (Orders order : orderList) {
                User user = order.getUser();
                user = userMapper.get(user);
                user.setIntegral(user.getIntegral() + DateUtil.formatFee2Yuan(order.getPrice()));
                user.setExperValue(user.getExperValue() + DateUtil.formatFee2Yuan(order.getPrice()));
                userMapper.updateByPrimaryKeySelective(user);
            }
        }

        logger.info("close activities finished");
    }
}
