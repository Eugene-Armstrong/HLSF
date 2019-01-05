package cn.edu.bnuz.seawas.controller.weChat;

import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.weChat.WxLoginService;
import cn.edu.bnuz.seawas.service.weChat.WxOrderService;
import cn.edu.bnuz.seawas.service.weChat.index.UserService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityDetailService;
import cn.edu.bnuz.seawas.service.weChat.index.WxOrdersService;
import cn.edu.bnuz.seawas.utils.DateUtils;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.http.weixin.XmlResult;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.foxinmy.weixin4j.mp.api.OauthApi;
import com.foxinmy.weixin4j.mp.message.TemplateMessage;
import com.foxinmy.weixin4j.mp.model.OauthToken;
import com.foxinmy.weixin4j.payment.WeixinPayProxy;
import com.foxinmy.weixin4j.payment.mch.Order;
import com.foxinmy.weixin4j.type.TradeState;
import com.foxinmy.weixin4j.util.Consts;
import com.foxinmy.weixin4j.util.DateUtil;
import com.foxinmy.weixin4j.util.IOUtil;
import com.foxinmy.weixin4j.util.StringUtil;
import com.foxinmy.weixin4j.xml.ListsuffixResultDeserializer;
import com.foxinmy.weixin4j.xml.XmlStream;
import com.google.gson.Gson;
import com.sun.istack.internal.Nullable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by wifi on 2017/8/14.
 */
@Controller
@RequestMapping("/callBack")
public class CallBackController {

    private Logger logger = LoggerFactory.getLogger(CallBackController.class);

    @Autowired
    private WeixinProxy weixinProxy;

    @Autowired
    private WxLoginService wxLoginService;

    @Autowired
    private WeixinPayProxy weixinPayProxy;

    @Autowired
    private WxOrderService orderService;

    @Autowired
    private WxOrdersService wxOrdersService;

    @Autowired
    private UserService userService;

    @Autowired
    private WxActivityDetailService wxActivityDetailService;


    /**
     * 获取code的回调函数
     * @param code 微信代理返回的code
     * @return 请求的地址
     */
    @RequestMapping(value = "/getMessage")
    public void getMessage(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "code", required = false) String code, @RequestParam(value = "requestURL") String requestURL) throws Exception {

        OauthApi oauthApi = weixinProxy.getOauthApi();

        if (StringUtil.isNotBlank(code)) {
            //如果用户同意授权

            //通过code获取token
            OauthToken oauthToken = null;
            try {
                oauthToken = oauthApi.getAuthorizationToken(code);
            } catch (Exception e) {
                //如果code已使用，微信会报错，这时候重新获取code
                response.sendRedirect(requestURL);
                return;
            }

            //获取用户信息
            com.foxinmy.weixin4j.mp.model.User user = oauthApi.getAuthorizationUser(oauthToken);

            //判断用户是否存在数据库中
            User existUser = wxLoginService.selectUserByOpenid(user.getOpenId());
            if (existUser != null) {

                existUser.setLastLoginTime(new Date());
                existUser.setNickName(user.getNickName());
                existUser.setSex(String.valueOf(user.getGender()));
                existUser.setHeadImgUrl(user.getHeadimgurl());

                //更新数据库
                new Thread(() -> wxLoginService.updateSelective(existUser)).start();

                logger.info("update database");

                request.getSession().setAttribute("userInfo", existUser);
            } else {
                //存入数据库
                User insertUser = new User();
                insertUser.setId(UUIDUtil.createUUID());
                insertUser.setOpenid(user.getOpenId());
                insertUser.setNickName(user.getNickName());
                insertUser.setSex(String.valueOf(user.getGender()));
                insertUser.setHeadImgUrl(user.getHeadimgurl());
                insertUser.setCreateTime(new Date());
                insertUser.setLastLoginTime(new Date());
                insertUser.setType("1");

                //插入数据库
                new Thread(() -> wxLoginService.insertSelective(insertUser)).start();

                //存进session中
                request.getSession().setAttribute("userInfo", insertUser);
            }

            //跳转到请求的地址
            request.getRequestDispatcher(request.getContextPath() + requestURL).forward(request, response);

        } else {
            //如果用户不同意授权
            response.sendRedirect(requestURL);
        }



        //response.sendRedirect(requestURL);
    }

    /**
     * 支付成功后回调地址
     */
    @RequestMapping(value = "/getPayNotify")
    @ResponseBody
    public String getPayNotify(InputStream inputStream) throws Exception {

        //获取订单信息
        String content = StringUtil.newStringUtf8(IOUtil.toByteArray(inputStream));
        Order order = ListsuffixResultDeserializer.deserialize(content, Order.class);

        //验证签名
        String sign = order.getSign();
        String validSign = weixinPayProxy.getWeixinSignature().sign(order);

        //如果签名错误
        if (!sign.equals(validSign)) {
            logger.info("Sign Error");
            return XmlStream.toXML(new XmlResult(Consts.FAIL, "签名错误"));
        }

        //更新Order表的支付结果
        Orders orders = new Orders();

        //设置微信支付订单号
        orders.setWechatOrderNum(order.getTransactionId());

        //设置商户订单号
        orders.setMerOrderNumber(order.getOutTradeNo());

        //设置支付时间
        orders.setPayTime(DateUtil.parse2yyyyMMddHHmmss(order.getTimeEnd()));

        //设置支付状态
        if (order.getResultCode().equals("SUCCESS")) {
            //如果返回SUCCESS，就设置成已支付
            orders.setState("2");
        } else {
            //如果返回FAIL
            orders.setState("1");
        }

        //更新数据库
        orderService.updatePayInfo(orders);

        // 获取订单消息
        Orders ordersDetail = wxOrdersService.findOrderIdByMerOrderId(orders.getMerOrderNumber());

        // 发送支付成功推送模板消息
        try {
            sendTmplMessage(ordersDetail);
        } catch (WeixinException e) {
            //如果用户没有关注公众号，发送模板消息时微信会报错，未关注不影响业务流程，此处照样回应微信，签名成功
            return XmlStream.toXML(new XmlResult(Consts.SUCCESS, ""));
        }

        //返回签名验证成功
        return XmlStream.toXML(new XmlResult(Consts.SUCCESS, ""));
    }

    /**
     * wifi
     * 支付成功后发送信息给用户
     * @param orders
     * @throws WeixinException
     */
    private void sendTmplMessage(Orders orders) throws WeixinException{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // 获取用户信息
        User user = userService.get(new User(orders.getUser().getId()));
        // 获取领队信息
        List<User> leaderList = wxActivityDetailService.getWxParticipantsLeaders(orders.getActivity().getId());
        String leaders = "";
        for (User user1:leaderList){
            leaders += user1.getNickName() + "：" + user1.getPhone() + "；";
        }

        /**
         * 发送模块信息
         */
        TemplateMessage templateMessage = new TemplateMessage(user.getOpenid(), PropertiesUtil.getProperty("Pay.TmplMessage"),"http://www.ailangfamily.com/showRounte/toRounte?rounte=" + orders.getActivity().getRoute());
        // first
        templateMessage.pushHead("您好，您参加的：" + orders.getActivity().getProduct().getName() + "活动已购买成功");
        // keyword-1：集合时间
        templateMessage.pushItem("keyword1",sdf.format(orders.getActivity().getDepartTime()));
        // keyword-2：集合地点
        templateMessage.pushItem("keyword2",orders.getActivity().getGatherPlace());
        // keyword-3：必备物品
        templateMessage.pushItem("keyword3","red","请点击链接查看详细行前准备");
        // keyword-4：领队信息
        templateMessage.pushItem("keyword4",leaders);
        // keyword-5：其他提醒
        templateMessage.pushItem("keyword5","提前做好交通攻略，晚上调好闹钟，准时到达集合点签到，告知家人及最亲密的人你去的地方！");
        // remark
        templateMessage.pushTail("行前好好休息，有问题随时联系领队！");
        weixinProxy.sendTmplMessage(templateMessage);
    }
}
