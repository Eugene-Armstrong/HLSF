package cn.edu.bnuz.seawas.controller.admin.activity;

import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.service.admin.ActivityService;
import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.JsonUtils;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import cn.edu.bnuz.seawas.vo.ActivityDetailsVo;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 活动管理
 * Created by Zhong-Yan on 2017/8/4.
 */
@Controller
@RequestMapping("/activity")
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @Autowired
    private CityService cityService;

    /**
     * wifi
     * 跳转到后台活动管理界面 + 分页
     * @param productId
     * @return
     */
    @RequestMapping("/showProductActivity")
    public String showProductActivity(String productId, Model model, HttpServletRequest request){
        try {
            // 默认当前页为1，每页数量为10
            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
                pageNum = Integer.parseInt(request.getParameter("pageNumber"));
            }
            if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }

            /**
             * 获得前端传来的产品id
             * 为了获得这个产品下的所有活动
             */
            Product product = new Product();
            product.setId(productId);
            Activity activity = new Activity();
            activity.setProduct(product);

            // 获得此产品下的所有活动的详细信息
            PageInfo<ActivityDetailsVo> activityPageInfo = activityService.selectActivitiesByProductId(pageNum,pageSize,activity);
            model.addAttribute("productId",productId);
            model.addAttribute("activityPageInfo",activityPageInfo);
            return "admin/activityMng-activity";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * wifi
     * 通过活动id获得所有信息
     * @param activityId
     * @param model
     * @return
     */
    @RequestMapping("/showActivityDetail")
    public String showActivityDetail(String activityId,Model model){
        try {
            /**
             * 通过前端传来的活动id
             * 获得此活动更加详细的信息
             */
            Activity activity = new Activity();
            activity.setId(activityId);
            Activity activity1 = activityService.getActivityMessage(activity);
            // 通过城市id获取城市名称
            City city = cityService.get(activity1.getCity());
            model.addAttribute("city",city);
            model.addAttribute("act",activity1);
            return "admin/activityMng-activityDetail";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * wifi
     * 通过活动id假删除活动
     * @param idSelected
     * @return
     */
    @RequestMapping("/deleteActivity")
    public @ResponseBody int deleteActivity(String idSelected){
        int result = activityService.deleteActivityMessage(idSelected);
        return result;
    }

    /**
     * 通过产品id创建此产品的活动
     * @param productId
     * @return
     */
    @RequestMapping("/toAddActivity")
    public String toAddActivity(String productId,Model model,User user){
        try {
            // 获得领队信息
            List<User> userList = activityService.findLeaderList(user);
            model.addAttribute("leader",userList);

            // 获得优惠规则
            List<Promotion> promotionList = activityService.selectPromotions();
            model.addAttribute("promotionList",promotionList);

            // 获得产品所属城市
            List<City> cities = cityService.selectCityProByProductId(productId);
            model.addAttribute("cities",cities);

            // 传产品id，为此产品添加活动
            model.addAttribute("productId",productId);

            return "admin/activityMng-activityAdd";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * wifi
     * 添加活动
     * @param request
     * @return
     * @throws ParseException
     */
    @RequestMapping("/addActivity")
    public @ResponseBody int addActivity(HttpServletRequest request)throws ParseException{
        Activity activity = new Activity();
        Product product = new Product();
        Admin admin = new Admin();
        Gson gson = new Gson();
        ActivityLeader activityLeader = new ActivityLeader();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        List<Promotion> promotionList = new ArrayList<Promotion>();
        int result = 0;

        /**
         * 判断是否添加了优惠规则
         * 有：分解传过来的字符串，获得所选的优惠规则，再转换成json格式存入数据库
         * 否：跳过
         */
        String rules = request.getParameter("rules");
        if (rules != null && !rules.equals("")){
            String[] Str = rules .split(",");
            for (String s : Str){
                // 通过优惠规则id获得具体信息
                Promotion promotion = activityService.selectPromotionByPrimaryKey(s);
                promotionList.add(promotion);
            }
        }
        String rulesJsons = gson.toJson(promotionList);

        /**
         * 将前端填写的资料放入对象中，添加进数据库
         * 因为添加活动分成4块保存，所以这一块主要是表格的添加
         */
        activity.setId(UUIDUtil.createUUID()); // 活动id
        product.setId(request.getParameter("id")); // 产品id
        activity.setProduct(product);
        activity.setCloseTime(simpleDateFormat.parse(request.getParameter("stopTime"))); // 报名截止日期
        activity.setCreateTime(new Date()); // 活动创建时间
        activity.setCreateUser((Admin)(request.getSession().getAttribute("admin"))); // 活动创建者
        activity.setDepartTime(simpleDateFormat.parse(request.getParameter("startTime"))); // 出发时间
        activity.setDiscountRules(rulesJsons); // 优惠规则
        activity.setEndTime(simpleDateFormat.parse(request.getParameter("endTime"))); // 活动结束时间
        activity.setGatherPlace(request.getParameter("location")); // 集合地点
        if (request.getParameter("onSalePrice") != null && !request.getParameter("onSalePrice").equals("0") && !request.getParameter("onSalePrice").equals("")){
            activity.setOnSalePrice(Integer.parseInt(request.getParameter("onSalePrice")));
        }
        activity.setPrice(Integer.parseInt(request.getParameter("price"))); // 原价格
        activity.setState("未发布"); // 活动状态
        activity.setTripNumber(Integer.parseInt(request.getParameter("num"))); // 成行人数
        activity.setTotalNumber(Integer.parseInt(request.getParameter("sum"))); // 总人数
        activity.setCity(request.getParameter("city")); // 城市
        activity.setUpdateUser(admin); // 默认修改人为null
        // 添加活动进数据库
        result = activityService.addActivity(activity);
        // 添加领队，类似优惠规则添加，只是领队是必须选择的
        String leader = request.getParameter("leaders");
        if (leader != null && !leader.equals("")){
            String[] Str = leader .split(",");
            for (String s : Str){
                activityLeader.setId(UUIDUtil.createUUID());
                activityLeader.setActivityId(activity.getId());
                activityLeader.setLeaderId(s);
                result = activityService.insertLeader(activityLeader);
            }
        }
        // 将表格添加时创建的活动id保存进session，为了后面分块添加进同一个活动所用
        request.getSession().setAttribute("addActivityId", activity.getId());

        return result;
    }

    /**
     * 添加活动富文本
     * @param request
     * @return
     */
    @RequestMapping("addActivityUeditor")
    @ResponseBody
    public String addActivityUeditor(HttpServletRequest request){
        // 活动上面controller中存进session的活动id值
        String activityId = String.valueOf(request.getSession().getAttribute("addActivityId"));
        Activity activity = new Activity();
        activity.setId(activityId);
        // 获得三个富文本的值
        activity.setPriceIntroduce(request.getParameter("html_cost")); // 费用说明
        activity.setProductIntroduce(request.getParameter("html_introduce")); // 活动介绍
        activity.setRoute(request.getParameter("html_process")); // 活动行程介绍
        Condition condition = activityService.updateActivityUeditor(activity);
        return new Gson().toJson(condition);
    }

    /**
     * wifi
     * 跳转到活动修改界面
     * @param productId
     * @param activity
     * @param model
     * @return
     */
    @RequestMapping("/toActivityChange")
    public String toActivityChange(String productId,Activity activity,Model model){
        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            // 获得产品所属城市
            List<City> cities = cityService.selectCityProByProductId(productId);
            model.addAttribute("cityList",cities);

            // 获得全部领队信息
            List<User> userList = activityService.findLeaderList(null);
            model.addAttribute("leader",userList);

            // 获得全部优惠规则
            List<Promotion> promotionList = activityService.selectPromotions();
            model.addAttribute("promotionList",promotionList);

            Activity activity1 = activityService.getActivitiesAndLeadersByActivityId(activity);

            // 将数据库中用json格式存储的信息分解成list
            if (activity1.getDiscountRules() != null && !"".equals(activity1.getDiscountRules())){
                // 已选择的优惠规则
                List<Promotion> promotions = JsonUtils.jsonToList(activity1.getDiscountRules(),Promotion.class);
                model.addAttribute("promotions",promotions);
            }
            // 将出发时间、报名截止时间、返回时间设置成对应的时间日期
            if (activity1.getDepartTime() != null && !activity1.getDepartTime().equals("")){
                String[] Str = simpleDateFormat.format(activity1.getDepartTime()).split(" ");
                model.addAttribute("departYear",Str[0]);
                model.addAttribute("departClock",Str[1]);
            }
            if (activity1.getCloseTime() != null && !activity1.getCloseTime().equals("")){
                String[] Str = simpleDateFormat.format(activity1.getCloseTime()).split(" ");
                model.addAttribute("closeYear",Str[0]);
                model.addAttribute("closeClock",Str[1]);
            }
            if (activity1.getEndTime() != null && !activity1.getEndTime().equals("")){
                String[] Str = simpleDateFormat.format(activity1.getEndTime()).split(" ");
                model.addAttribute("endYear",Str[0]);
                model.addAttribute("endClock",Str[1]);
            }

            // 产品id
            model.addAttribute("productId",productId);
            // 活动所有信息
            model.addAttribute("activity",activity1);
            return "admin/activityMng-activityChange";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * wifi
     * 修改活动
     * @param request
     * @return
     */
    @RequestMapping("/updateActivity")
    public @ResponseBody int updateActivity(HttpServletRequest request)throws ParseException{
        Product product = new Product();
        List<Promotion> promotionList = new ArrayList<Promotion>();
        Gson gson = new Gson();
        String rulesJsons = null;
        Activity activity = new Activity();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        // 类似上面活动添加
        // 1 设置产品id
        product.setId(request.getParameter("productID"));
        activity.setProduct(product);
        // 2 设置活动id
        activity.setId(request.getParameter("id"));
        // 3 设置价格
        if (request.getParameter("price")!= null && !request.getParameter("price").equals(""))
            activity.setPrice(Integer.parseInt(request.getParameter("price")));
        // 4 设置成行人数
        if (request.getParameter("tripNumber") != null && !request.getParameter("tripNumber").equals(""))
            activity.setTripNumber(Integer.parseInt(request.getParameter("tripNumber")));
        // 5 设置总人数
        if (request.getParameter("totalNumber") != null && !request.getParameter("totalNumber").equals(""))
            activity.setTotalNumber(Integer.parseInt(request.getParameter("totalNumber")));
        // 6 设置活动优惠价格
        if (request.getParameter("onSalePrice") != null && !request.getParameter("onSalePrice").equals("0") && !request.getParameter("onSalePrice").equals("")){
            activity.setOnSalePrice(Integer.parseInt(request.getParameter("onSalePrice")));
        }
        // 7 设置活动修改者 + 时间
        activity.setUpdateUser((Admin)(request.getSession().getAttribute("admin")));
        activity.setUpdateTime(new Date());
        // 8 活动优惠规则
        String rules = request.getParameter("rules");
        if (rules != null && !rules.equals("")){
            String[] Str = rules .split(",");
            for (String s : Str){
                // 根据优惠规则id活动详细规则信息
                Promotion promotion = activityService.selectPromotionByPrimaryKey(s);
                promotionList.add(promotion);
            }
            rulesJsons = gson.toJson(promotionList);
        }
        activity.setDiscountRules(rulesJsons);
        // 9 设置集合地点
        activity.setGatherPlace(request.getParameter("gatherPlace"));
        // 10 设置出发时间
        activity.setDepartTime(simpleDateFormat.parse(request.getParameter("departTime")));
        // 11 设置报名截止时间
        activity.setCloseTime(simpleDateFormat.parse(request.getParameter("closeTime")));
        // 12 设置结束时间
        activity.setEndTime(simpleDateFormat.parse(request.getParameter("endTime")));
        // 13 设置产品介绍
        activity.setProductIntroduce(request.getParameter("productIntroduce"));
        // 14 设置活动行程介绍
        activity.setRoute(request.getParameter("route"));
        // 15 设置活动价格介绍
        activity.setPriceIntroduce(request.getParameter("priceIntroduce"));
        // 设置活动城市
        activity.setCity(request.getParameter("city"));
        // 16 修改活动
        int result = 0;
        result = activityService.updateByPrimaryKeySelective(activity);

        // 17 领队清空 + 添加
        result = activityService.deleteLeadersById(activity.getId());
        String leaders = request.getParameter("leaders");
        if (leaders != null && !"".equals(leaders)){
            String[] Str = leaders .split(",");
            for (String s : Str){
                ActivityLeader activityLeader = new ActivityLeader();
                activityLeader.setLeaderId(s);
                activityLeader.setId(UUIDUtil.createUUID());
                activityLeader.setActivityId(activity.getId());
                result = activityService.insertLeader(activityLeader);
            }
        }
        return result;
    }

    /**
     * wifi
     * 修改活动状态
     * 将未发布改成未成行
     * @param activityId
     * @param productId
     * @return
     */
    @RequestMapping("/changeActivityType")
    public String changeActivityType(String activityId,String productId){
        try {
            activityService.changeActivityType(activityId);
            return "redirect:/activity/showProductActivity?productId=" + productId;
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }
}
