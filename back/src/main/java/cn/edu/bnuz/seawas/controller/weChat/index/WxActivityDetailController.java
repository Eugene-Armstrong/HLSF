package cn.edu.bnuz.seawas.controller.weChat.index;

import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.service.admin.ActivityService;
import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.service.admin.OrderService;
import cn.edu.bnuz.seawas.service.admin.product.ProductService;
import cn.edu.bnuz.seawas.service.weChat.index.*;
import cn.edu.bnuz.seawas.service.weChat.WxLoginService;
import cn.edu.bnuz.seawas.service.weChat.mine.ContactService;
import cn.edu.bnuz.seawas.utils.EmailUtils;
import cn.edu.bnuz.seawas.utils.JsonUtils;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import cn.edu.bnuz.seawas.vo.WxActivityVo;
import cn.edu.bnuz.seawas.vo.WxProductDetailVo;
import cn.edu.bnuz.seawas.vo.wechat.UsersVo;
import com.foxinmy.weixin4j.util.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 微信进入购买界面
 * Created by wifi on 2017/9/1.
 */
@Controller
@RequestMapping("/wechat/WxProductDetail")
public class WxActivityDetailController {

    private Logger logger = LoggerFactory.getLogger(WxActivityDetailController.class);

    @Autowired
    private ActivityService activityService;

    @Autowired
    private WxActivityDetailService wxActivityDetailService;

    @Autowired
    private WxLoginService wxLoginService;

    @Autowired
    private ProductService productService;

    @Autowired
    private CityService cityService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private EquipOrdersService equipOrdersService;

    @Autowired
    private ContactService contactService;

    @Autowired
    private SignService signService;

    @Autowired
    private SignPromotionService signPromotionService;

    @Autowired
    private UserService userService;

    @Autowired
    private WxActivityService wxActivityService;

    /**
     * wifi
     * 微信获取产品详情--->购买界面
     * 接口条件：1、传入产品id，获取此产品下的所有活动；2、传入产品id + 活动id，获取产品下的活动的信息
     * 获取活动的条件：1、报名时间大于等于当天时间；2、活动状态不等于：活动中
     * @param model
     * @param productId
     * @return
     */
    @RequestMapping("/getProductDetail")
    public String getProductDetail(Model model,String productId,String actId,String cityId,HttpServletRequest request){
        try {
            // 1 查看产品是否存在，查看是否已被删除
            WxProductDetailVo wxProductVo = wxActivityDetailService.getWxProductDetails(productId);
            // 查看此产品下是否存在活动
            int activityNumber = wxActivityDetailService.getWxActivityNumber(productId,cityId);
            if (wxProductVo.getDelFlag().equals("1")) {
                // 1-1 产品已被删除
                return "wechat/index/index-offsale";
            } else if (activityNumber <= 0) {
                // 1-2 产品下面没有正在运作的活动
                return "wechat/index/index-offsale";
            } else {
                // 1-3 产品未下架
                // 1-3-1 获取产品+活动的详细信息
                int num = 0; // 定位到对应的活动
                // 获得此产品的下所有符合条件的活动
                WxProductDetailVo wxProductDetailVo = wxActivityDetailService.getWxProductActivitiesDetails(productId,cityId);
                /**
                 * 默认选择第一个
                 * 通过选择的活动id确定选择的所在位置
                 */
                if (actId != null && !actId.equals("")){
                    // 1-3-2 判断此活动是否已结束：通过活动id获取活动状态
                    String state = activityService.getActivityStateById(actId);
                    if (!state.equals("活动中")){
                        // 1-3-3 查找活动所在位置
                        for (WxActivityVo wxActivityVo : wxProductDetailVo.getActivityVoList()){
                            if (actId.equals(wxActivityVo.getId()))
                                break;
                            else
                                num++;
                        }
                    }
                }
                // 如果找不到对应的活动定位，则默认为第一项
                if (wxProductDetailVo.getActivityVoList().size() == num){
                    num = 0;
                }
                // 2 产品浏览次数加一，每次进入产品选购界面，浏览次数增加1
                wxActivityDetailService.updateProductReadNumber(productId);

                boolean isCol;
                // 3 获取产品收藏信息
                User user = (User) request.getSession().getAttribute("userInfo");

                // 查看对应的用户是否有收藏对应的产品
                int collectionActivity = wxActivityDetailService.getCollectionType(user.getOpenid(),productId);
                if (collectionActivity == 1)
                    isCol = true;
                else
                    isCol = false;

                // 4 将选择的产品id、活动id存入session中
                request.getSession().setAttribute("productId", productId);
                request.getSession().setAttribute("activityId",wxProductDetailVo.getActivityVoList().get(num).getId());

                model.addAttribute("isCol",isCol);
                model.addAttribute("productDetail",wxProductDetailVo);
                model.addAttribute("num",num);
                model.addAttribute("cityId",cityId);
                return "wechat/index/activity-detail";
            }
        }catch (Exception e) {
            e.printStackTrace();
            return "wechat/error";
        }
    }

    /**
     * wifi
     * 获取活动已报名用户 + 领队信息
     * @param model
     * @param activityId
     * @return
     */
    @RequestMapping("/toActivityParticipants")
    public String toActivityParticipants(Model model,String activityId){
        try {
            // 获取此活动下已报名的用户信息
            List<User> userList = wxActivityDetailService.getWxParticipantsUsers(activityId);
            // 获取此活动下分配的领队信息
            List<User> leaderList = wxActivityDetailService.getWxParticipantsLeaders(activityId);
            model.addAttribute("userList",userList);
            model.addAttribute("leaderList",leaderList);
            return "wechat/index/activity-participants";
        }catch (Exception e) {
            e.printStackTrace();
            return "wechat/error";
        }
    }

    /**
     * wifi
     * 微信获取获得单个产品-单个活动-多个领队信息--->购买确认界面
     * @param model
     * @param productId
     * @param activityId
     * @return
     */
    @RequestMapping("/toEnrollPage")
    public String toEnrollPage(Model model,String productId,String activityId,HttpServletRequest request){
        try{
            // 1、获取产品信息-活动信息
            WxProductDetailVo wxProductDetailVo = wxActivityDetailService.getWxProductActivityDetails(productId,activityId);
            // 1-1 修改活动原来价格
            wxProductDetailVo.getActivityVoList().get(0).setPrice(wxProductDetailVo.getActivityVoList().get(0).getPrice());
            // 1-2 修改活动优惠价格
            if (wxProductDetailVo.getActivityVoList().get(0).getOnSalePrice() != null && !wxProductDetailVo.getActivityVoList().get(0).getOnSalePrice().equals("")){
                wxProductDetailVo.getActivityVoList().get(0).setOnSalePrice(wxProductDetailVo.getActivityVoList().get(0).getOnSalePrice());
            }

            // 2、将装备、优惠json转换成list
            if (wxProductDetailVo.getEquipmentMessage() != null && !wxProductDetailVo.getEquipmentMessage().equals("")){
                List<Equipment> equipmentList = JsonUtils.jsonToList(wxProductDetailVo.getEquipmentMessage(), Equipment.class);
                model.addAttribute("equipmentList",equipmentList);
            }
            if (wxProductDetailVo.getActivityVoList().get(0).getDiscountRules() != null && !wxProductDetailVo.getActivityVoList().get(0).getDiscountRules().equals("")){
                List<Promotion> promotionList = JsonUtils.jsonToList(wxProductDetailVo.getActivityVoList().get(0).getDiscountRules(),Promotion.class);
                model.addAttribute("promotionList",promotionList);
            }

            // 3、获取用户积分 + 常用联系人
            // 3-1 得到存在session中的用户信息
            User user = (User) request.getSession().getAttribute("userInfo");
            // 3-2 得到用户详细信息
            User userDetail = wxLoginService.selectUserByOpenid(user.getOpenid());
            // 3-3 得到用户的常用联系人信息
            List<Contact> contactList = wxActivityDetailService.getWxUsersContacts(user.getOpenid());

            // 4、将集合地点分解
            String[] gatherPlaces = wxProductDetailVo.getActivityVoList().get(0).getGatherPlace().split("-");

            model.addAttribute("gatherPlaces",gatherPlaces);
            model.addAttribute("userDetail",userDetail);
            model.addAttribute("contactList",contactList);
            model.addAttribute("productDetail",wxProductDetailVo);
            return "wechat/index/activity-enroll";
        }catch (Exception e) {
            e.printStackTrace();
            return "wechat/error";
        }
    }

    /**
     * wifi
     * 跳转到免责声明界面
     * @param model
     * @param productId
     * @return
     */
    @RequestMapping("/toDisclaimerPage")
    public String toDisclaimerPage(Model model,String productId){
        try{
            Product product = productService.selectProductByProductId(productId);
            model.addAttribute("product",product);
            return "wechat/index/activity-disclaimer";
        }catch (Exception e) {
            e.printStackTrace();
            return "wechat/error";
        }
    }

    /**
     * wifi
     * 收藏/取消收藏产品
     * @param isCollected
     * @return
     */
    @RequestMapping("/changeCollectionType")
    public @ResponseBody int changeCollectionType(boolean isCollected,HttpServletRequest request){
        // 1 获取用户信息
        User user = (User) request.getSession().getAttribute("userInfo");
        User userDetail = wxLoginService.selectUserByOpenid(user.getOpenid());
        // 2 判断用户点击的是收藏还是取消收藏
        if (isCollected){
            // 2-1 检查是否已收藏（避免前端界面出错）
            int collectionCheck = wxActivityDetailService.getCollectionType(user.getOpenid(),(String) request.getSession().getAttribute("productId"));
            if (collectionCheck == 1){
                // 2-2 已收藏，直接返回成功
                return 1;
            }else {
                // 2-3 没有收藏，添加收藏
                CollectionActivity collectionActivity = new CollectionActivity();
                collectionActivity.setId(UUIDUtil.createUUID());
                collectionActivity.setCreateTime(new Date());
                collectionActivity.setProductId((String) request.getSession().getAttribute("productId"));
                collectionActivity.setUserId(userDetail.getId());
                int key = wxActivityDetailService.changeCollectionTypeTrue(collectionActivity);
                if (key == 1){
                    return 1;
                }else
                    return 2;
            }
        }else{
            int key = wxActivityDetailService.changeCollectionTypeFalse(userDetail.getId(),(String)request.getSession().getAttribute("productId"));
            if (key != 0)
                return 0;
            else
                return 2;
        }
    }

    /**
     * wifi
     * 支付
     * @param participants
     * @param equips
     * @param payWay
     * @param points
     * @param totalCost
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/userPaiedOrder")
    public String userPaiedOrder(String participants, String equips, String payWay, String points, String totalCost,HttpServletRequest request,String gatherPlace,String remark) throws Exception {
        // 1 创建订单
        Orders orders = new Orders();
        orders.setId(UUIDUtil.createUUID());
        // 1-1 设置订单出发城市
        City city = (City) request.getSession().getAttribute("currentCity");
        orders.setCity(city);
        // 1-2 设置订单用户信息
        User user = (User) request.getSession().getAttribute("userInfo");
        User userDetail = wxLoginService.selectUserByOpenid(user.getOpenid());
        orders.setUser(userDetail);
        // 1-3 设置订单活动信息
        Activity activity = new Activity();
        activity.setId((String)request.getSession().getAttribute("activityId"));
        orders.setActivity(activity);
        // 1-4 设置订单创建时间
        orders.setCreateTime(new Date());
        // 1-5 设置订单总价格
        orders.setPrice(DateUtil.formatYuan2Fen(Double.parseDouble(totalCost)));
        // 1-6 设置订单状态
        orders.setState("1");
        // 1-7 设置订单支付方式，目前只支持微信。
        switch (payWay){
            case "微信":
                orders.setPayment("1");
                break;
            case "支付宝":
                orders.setPayment("2");
                break;
            case "银联":
                orders.setPayment("3");
                break;
        }
        // 1-8 设置商家订单号
        orders.setMerOrderNumber(UUIDUtil.createOrderId());
        // 1-9 设置此订单使用了的积分
        orders.setIntegral(userDetail.getIntegral() - Double.parseDouble(points));
        // 1-10 设置订单的集合地点选择
        orders.setGatherPlace(gatherPlace);
        // 1-11 设置订单的备注
        if (!remark.equals("") && remark != null){
            orders.setRemark(remark);
        }
        // 1-10 提交（添加）订单
        orderService.insert(orders);

        // 2 创建订单装备
        // 2-1 查询订单是否包含装备
        if (!equips.equals("[]")){
            List<EquipOrders> equipOrdersList = JsonUtils.jsonToList(equips,EquipOrders.class);
            for (int i = 0;i < equipOrdersList.size();i++){
                equipOrdersList.get(i).setId(UUIDUtil.createUUID());
                equipOrdersList.get(i).setOrdersId(orders.getId());
            }
            // 2-2 批量提交订单装备
            equipOrdersService.insertList(equipOrdersList);
        }

        // 3 创建常用联系人
        // 3-1 获取已报名人名单
        List<UsersVo> usersVoList = JsonUtils.jsonToList(participants,UsersVo.class);
        // 3-2 转换类型
        for (UsersVo usersVo : usersVoList){
            Contact contact = new Contact();
            contact.setAge(Integer.parseInt(usersVo.getAge()));
            contact.setSex(usersVo.getSex());
            contact.setCertId(usersVo.getIdCard());
            contact.setName(usersVo.getName());
            contact.setPhone(usersVo.getPhone());
            contact.setUserId(userDetail.getId());
            // 3-2 提交（添加）已报名人名单到常用联系人中
            contactService.insertSelective(contact);
        }

        // 4 创建订单对应的报名人信息
        // 4-1 根据用户是否使用了报名优惠来进行不同的操作
        for (int i = 0;i < usersVoList.size();i++){
            // 4-2 将信息存入报名人表中
            Sign sign = new Sign();
            sign.setId(UUIDUtil.createUUID());
            sign.setOrdersId(orders.getId());
            sign.setName(usersVoList.get(i).getName());
            sign.setSex(usersVoList.get(i).getSex());
            sign.setAge(Integer.parseInt(usersVoList.get(i).getAge()));
            sign.setPhone(usersVoList.get(i).getPhone());
            sign.setPrice(DateUtil.formatYuan2Fen(Double.parseDouble(usersVoList.get(i).getPrice())));
            sign.setCertId(usersVoList.get(i).getIdCard());
            // 4-3 提交（添加）报名人
            signService.insert(sign);
            switch (usersVoList.get(i).getPriceID()){
                case "price":
                case "onSalePrice":
                    System.out.println("使用的是原价或者优惠价格");
                    break;
                default:
                    System.out.println("使用了优惠套餐");
                    // 4-4 创建报名优惠
                    SignPromotion signPromotion = new SignPromotion();
                    // 4-4-1 填充报名优惠数据
                    signPromotion.setId(UUIDUtil.createUUID());
                    signPromotion.setSignUserID(sign.getId());
                    signPromotion.setPromotionId(usersVoList.get(i).getPriceID());
                    // 4-4-2 提交（添加）报名优惠数据
                    signPromotionService.insert(signPromotion);
                    break;
            }
        }

        // 5 修改用户积分 + 经验，此步骤改成活动结束后才进行积分、经验值的更改
        /**
         * 提交订单之后：
         * 1、在剩余的积分上添加本次产品的价格：一元抵挡一积分，去除小数点以后的数
         * 2、在经验基础上添加本次的价格：一元抵挡一积分，去除小数点以后的数
         * 3、在订单取消的情况下根据总价格去减掉积分和经验值
         */
        // 5-1 修改用户的积分
        // userDetail.setIntegral(Double.parseDouble(points) + Math.floor(Double.parseDouble(totalCost)));
        // 5-2 修改用户的经验值
        // userDetail.setExperValue(userDetail.getExperValue() + Math.floor(Double.parseDouble(totalCost)));
        // 5-3 修改用户的信息
        // userService.update(userDetail);
        // 5-4 更新session里面user对象的值
        // request.getSession().setAttribute("userInfo",userDetail);

        // 6 修改活动状态（未成行-->已成行，未成行/已成行--->已满人）
        // 6-1 获得此活动下的已报名人数
        WxProductDetailVo wxProductDetailVo = wxActivityDetailService.getWxProductActivityDetails((String)request.getSession().getAttribute("productId"),activity.getId());
        int number = wxProductDetailVo.getActivityVoList().get(0).getNum();
        if (number >= wxProductDetailVo.getActivityVoList().get(0).getTripNumber() && number < wxProductDetailVo.getActivityVoList().get(0).getTotalNumber()){
            // 6-2 总人数 > 报名人数 > 成行人数
            wxActivityService.changeActivityState(activity.getId(),"已成行");
        }else if (wxProductDetailVo.getActivityVoList().get(0).getTotalNumber().equals(number)){
            // 6-3 报名人数 = 总人数
            wxActivityService.changeActivityState(activity.getId(),"已满人");
        }
       return "forward:/wechat/pay?ordersId=" + orders.getId();
    }
}
