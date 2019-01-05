package cn.edu.bnuz.seawas.controller.admin.user;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.admin.ActivityService;
import cn.edu.bnuz.seawas.service.admin.OrderService;
import cn.edu.bnuz.seawas.service.admin.user.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Zhong-Yan on 2017/7/21.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private ActivityService activityService;
    @Autowired
    private OrderService orderService;

    //显示可以成为领队的用户
    @RequestMapping("/showPrepareLeader")
    public String showPrepareLeader(Model model, User user,HttpServletRequest request) {
        // 获取预备领队信息
//        List<User> userList = userService.findCommUserList(user);

        try {
            if (user == null){
                user = new User();
            }
            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
                pageNum = Integer.parseInt(request.getParameter("pageNumber"));
            }
            if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }

            //查询数据
            PageInfo<User> pageInfo = userService.showCommUserPage(pageNum, pageSize, user);

            //向前端传输数据
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("user",user);

            return "admin/leaderMng/leaderMng-add";
        } catch (Exception e) {
            //异常跳转
            e.printStackTrace();
            return "admin/error";
        }
    }

    // 更新用户为领队
    @RequestMapping("/updatetoLeader")
    public String updatetoLeader(User user) throws Exception {
        userService.updateUsertoLeader(user);
        return "redirect:/user/showPrepareLeader";

    }

    //用户管理页面显示
    @RequestMapping("/admin/showUser")
    public String showUser(String realName,String phone,Model model,HttpServletRequest request){
        User u = new User();
        if ((realName!=null&&!(realName.equals("")))||(phone!=null&&!(phone.equals("")))){
             u.setRealName(realName);
             u.setPhone(phone);
        }
        //-----------------------------------分页开始------------------------------------------------------
        // 默认当前页为1，每页数量为2
        int pageNum = 1;
        int pageSize = 10;

        //分页信息获取
        if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }

        u.setDelFlag("0");
        PageInfo<User> userPageInfo = userService.findUsersPage(pageNum,pageSize,u);
//------------------------------------分页结束-------------------------------------------------------

        model.addAttribute("users",userPageInfo);
        model.addAttribute("phone",phone);
        model.addAttribute("realName",realName);
        return "admin/userMng";
    }

    //用户参与过的活动
    @RequestMapping("/admin/userGone")
    public String userGone(Model model,HttpServletRequest request,String userId){
        /*try {*/

            //-----------------------------------分页开始---------P---------------------------------------------
            // 默认当前页为1，每页数量为2
            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
                pageNum = Integer.parseInt(request.getParameter("pageNumber"));
            }
            if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }
//------------------------------------分页结束-------------------------------------------------------
            PageInfo<Activity> activityPageInfo = activityService.findActivityPageByUser(pageNum, pageSize, userId);
            model.addAttribute("activityPageInfo",activityPageInfo);
            model.addAttribute("userId",userId);
            return "admin/userMng-activity";
       /* }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }*/
    }

    /*通过用户id和活动id查找订单详情*/
    @RequestMapping("/admin/order")
    public String findUserActivityOrder(Model model,String activityId,String userId){
        Orders o = orderService.findOrderByActivityAndUser(activityId, userId);
        model.addAttribute("order",o);
        return "admin/userMng-order";

    }

/*显示活动详情*/
    @RequestMapping("/admin/showActivityDetail")
    public String showActivityDetail(String activityId,Model model){
        try {
            Activity activity = new Activity();
            activity.setId(activityId);
            Activity activity1 = activityService.getActivityMessage(activity);
            model.addAttribute("act",activity1);
            return "admin/activityMng-activityDetail";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

}
