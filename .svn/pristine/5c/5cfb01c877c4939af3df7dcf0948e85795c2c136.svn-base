package cn.edu.bnuz.seawas.controller.weChat.user;

import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.service.weChat.index.UserService;
import cn.edu.bnuz.seawas.service.weChat.mine.AlbumService;
import cn.edu.bnuz.seawas.service.weChat.mine.LeaderManageActivityService;
import cn.edu.bnuz.seawas.service.weChat.mine.MineService;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import cn.edu.bnuz.seawas.vo.wechat.AlbumVo;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 用户操作Controller
 * Created by sjk on 2017-09-25.
 */
@Controller("wechatUserController")
@RequestMapping(value = "/wechat/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private MineService mineService;

    @Autowired
    private AlbumService albumService;

    @Autowired
    private LeaderManageActivityService leaderManageActivityService;

    /**
     * 显示用户主页
     */
    @RequestMapping(value = "/showUserIndex")
    public String showUserIndex(Model model, String userId, HttpServletRequest request) {
        try {
            City city = (City)request.getSession().getAttribute("currentCity");
            model.addAttribute("cityMessage",city);

            //获取用户信息
            User user = userService.get(new User(userId));
            model.addAttribute("user", user);

            //用户参加的活动
//            List<Activity> activities = mineService.selectActivityByUserId(userId);
//            model.addAttribute("activities", activities);
//            List<Orders> orders = mineService.findOrdersByUserId(user.getId());
//            model.addAttribute("orders", orders);

            //用户收藏的产品
            List<Product> products = mineService.selectProductByUserId(userId);
            model.addAttribute("collects", products);

            //相册数据
            List<AlbumVo> albumList = albumService.findList(new Album(user));
            model.addAttribute("albumList", albumList);

            //如果是领队，还需要传递领队带队活动数据
            if (user.getType().equals("2")) {
//                List<LeaderActivityVo> leaderActivityList = leaderManageActivityService.findLeaderActivity(user);
//                model.addAttribute("leaderActivityList", leaderActivityList);
            }

            return "wechat/others";
        } catch (Exception e) {
            e.printStackTrace();
            return "wechat/error";
        }
    }

    @RequestMapping(value = "/showOtherPageLeaderAct", produces = "application/json; charset=utf-8")
    @ResponseBody
    public List<LeaderActivityVo> showOtherPageLeaderAct(String userId) {
        User user = userService.get(new User(userId));

        List<LeaderActivityVo> leaderActivityList = leaderManageActivityService.findLeaderActivity(user);
        return leaderActivityList;
    }

    @RequestMapping(value = "/showOtherPageAct", produces = "application/json; charset=utf-8")
    @ResponseBody
    public List<Orders> showOtherPageLeaderact(String userId) {
        User user = userService.get(new User(userId));
        List<Orders> orders = mineService.findOrdersByUserId(user.getId());
        return orders;
    }



}
