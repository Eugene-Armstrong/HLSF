package cn.edu.bnuz.seawas.controller.weChat.order;

import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.weChat.WxOrderService;
import cn.edu.bnuz.seawas.utils.Condition;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 微信端订单模块
 * Created by sjk on 2017-10-26.
 */
@Controller
@RequestMapping(value = "/wechat/order")
public class WxOrderController {

    @Autowired
    private WxOrderService orderService;

    /**
     * 显示订单页面
     */
    @RequestMapping(value = "/")
    public String order() { return "wechat/order"; }

    /**
     * 根据状态查询订单列表
     */
    @RequestMapping(value = "/show")
    @ResponseBody
    public String show(HttpServletRequest request, String state) {
        try {
            //获取session中的用户信息
            User user = (User) request.getSession().getAttribute("userInfo");

            //获取订单列表
            List<Orders> ordersList = orderService.findListByUserAndState(user, state);

            return new Gson().toJson(new Condition<List>(Condition.SUCCESS_CODE, "SUCCESS", ordersList));

        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 取消订单
     */
    @RequestMapping(value = "/cancelOrder")
    @ResponseBody
    public String cancelOrder(String orderId) {
        try {
            Condition condition = orderService.cancelOrder(orderId);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 申请退款
     */
    @RequestMapping(value = "/refund")
    @ResponseBody
    public String refund(String orderId, HttpServletRequest request) {
        try {
            Condition condition = orderService.applyRefund((User) request.getSession().getAttribute("userInfo"), orderId);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
}
