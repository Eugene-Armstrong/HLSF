package cn.edu.bnuz.seawas.service.weChat;

import cn.edu.bnuz.seawas.dao.OrdersMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.SignService;
import cn.edu.bnuz.seawas.service.admin.ActivityService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityDetailService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.vo.WxProductDetailVo;
import com.foxinmy.weixin4j.payment.WeixinPayProxy;
import com.foxinmy.weixin4j.payment.mch.MerchantResult;
import com.foxinmy.weixin4j.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 微信端订单操作Service
 * Created by sjk on 2017-09-23.
 */
@Service
public class WxOrderService {

    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private WeixinPayProxy weixinPayProxy;

    @Autowired
    private SignService signService;

    @Autowired
    private WxActivityDetailService activityDetailService;

    @Autowired
    private WxActivityService activityService;

    @Autowired
    private ActivityService actService;

    /**
     * 微信回调更新支付结果
     */
    @Transactional(readOnly = false)
    public void updatePayInfo(Orders orders) throws Exception {
        ordersMapper.updateOrderPayInfo(orders);
    }

    /**
     * 查询超过30分钟且未支付订单
     */
    @Transactional(readOnly = true)
    public List<Orders> findPass30MinOrders() throws Exception { return ordersMapper.findPass30MinOrders(); }

    /**
     * 查询7天前未评价的订单
     */
    @Transactional(readOnly = true)
    public List<Orders> find7DaysBeforeOeders() throws Exception { return ordersMapper.find7DaysBeforeOeders(); }

    /**
     * 申请退款
     */
    @Transactional(readOnly = false)
    public Condition applyRefund(User user, String orderId) throws Exception {
        //通过用户和活动id获取订单id
        Orders order = ordersMapper.get(new Orders(orderId));

        //判断用户身份
        if (!order.getUser().getId().equals(user.getId())) {
            return new Condition(Condition.NOALLOW_CODE, "身份异常");
        }

        //只有活动未开始的状态才能退款
        if (order.getActivity().getState().equals("已结束") || order.getActivity().getState().equals("活动中")) {
            return new Condition(Condition.NOALLOW_CODE, "当前活动状态无法退款");
        }

        //设置状态为申请退款
        order.setState("3");
        //设置申请退款时间
        order.setApplyRefundTime(new Date());
        //更新数据库
        ordersMapper.updateByPrimaryKeySelective(order);

        return new Condition(Condition.SUCCESS_CODE, "申请成功");
    }

    /**
     * 根据用户和状态查询订单
     */
    @Transactional(readOnly = true)
    public List<Orders> findListByUserAndState(User user, String state) {
        return ordersMapper.findListByUserAndState(user.getId(), state);
    }

    /**
     * 取消订单
     */
    @Transactional(readOnly = false)
    public Condition cancelOrder(String orderId) {

        try {
            //获取订单信息
            Orders order = ordersMapper.get(new Orders(orderId));

            if (StringUtil.isNotBlank(order.getMerOrderNumber())) {
                //发起取消订单申请
                MerchantResult result = weixinPayProxy.closeOrder(order.getMerOrderNumber());
                //如果返回结果为SUCCESS，则代表订单已成功关闭，执行更新数据库操作
                if (result.getResultCode().equals("SUCCESS")) {
                    //设置订单状态
                    this.updatePayInfo(new Orders(order.getMerOrderNumber(), "5"));

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
                }
            } else {
                return new Condition(Condition.ERROR_CODE, "订单状态异常，请联系客服取消订单");
            }

            return new Condition(Condition.SUCCESS_CODE, "订单已取消");

        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }
}
