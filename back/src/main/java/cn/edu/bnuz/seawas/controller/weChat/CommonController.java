package cn.edu.bnuz.seawas.controller.weChat;

import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.weChat.index.WxOrdersService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import com.foxinmy.weixin4j.jssdk.JSSDKAPI;
import com.foxinmy.weixin4j.jssdk.JSSDKConfigurator;
import com.foxinmy.weixin4j.payment.PayRequest;
import com.foxinmy.weixin4j.payment.WeixinPayProxy;
import com.foxinmy.weixin4j.payment.mch.MchPayRequest;
import com.foxinmy.weixin4j.util.DateUtil;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 通用Controller
 * Created by sjk on 2017-09-21.
 */
@Controller
@RequestMapping(value = "/wechat")
public class CommonController {

    private Logger logger = LoggerFactory.getLogger(CommonController.class);

    @Autowired
    private JSSDKConfigurator jssdkConfigurator;

    @Autowired
    private WeixinPayProxy weixinPayProxy;

    @Autowired
    private WxOrdersService wxOrdersService;

    /**
     * 获取微信JSSDK配置
     */
    @RequestMapping(value = "/getSdkConfig")
    @ResponseBody
    public String getSdkConfig(@RequestParam(value = "url") String url) {

        try {
            //jssdkConfigurator.debugMode();
            //设置获取所有api
            jssdkConfigurator.apis(JSSDKAPI.MP_ALL_APIS);

            //生成配置信息
            return jssdkConfigurator.toJSONConfig(url);

        } catch (Exception e) {
            e.printStackTrace();
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("msg", "系统繁忙");
            return jsonObject.toString();
        }
    }

    /**
     * 统一下单
     */
    @RequestMapping(value = "/pay")
    @ResponseBody
    public String preOrder(HttpServletRequest request, String ordersId) {
        try {
            logger.info("进入统一下单接口");
            User user = (User) request.getSession().getAttribute("userInfo");

            // 1-1 设置订单信息
            Orders orders = new Orders();
            orders.setId(ordersId);
            // 1-2 获取订单所有的信息
            Orders ordersDetail = wxOrdersService.getOrdersById(orders);
            // 1-3 完善参数填写
            //请求统一下单
            MchPayRequest mchPayRequest = weixinPayProxy.createJSPayRequest(user.getOpenid(), ordersDetail.getActivity().getProduct().getName(),
                    ordersDetail.getMerOrderNumber(), DateUtil.formatFee2Yuan(ordersDetail.getPrice()), PropertiesUtil.getProperty("Pay.Callback"),
                    request.getRemoteAddr(), null);

            logger.info("统一下单返回数据：{}", mchPayRequest.toRequestString());

            return new Gson().toJson(new Condition<PayRequest>(Condition.SUCCESS_CODE, "success", mchPayRequest.toRequestObject()));

        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
}
