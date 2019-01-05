package cn.edu.bnuz.seawas.controller.weChat.mine;

import cn.edu.bnuz.seawas.common.annotation.LeaderAuthority;
import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.service.admin.user.UserService;
import cn.edu.bnuz.seawas.service.weChat.WxOrderService;
import cn.edu.bnuz.seawas.service.weChat.mine.AlbumService;
import cn.edu.bnuz.seawas.service.weChat.mine.LeaderManageActivityService;
import cn.edu.bnuz.seawas.service.weChat.mine.MineService;
import cn.edu.bnuz.seawas.service.weChat.mine.PhotoService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import cn.edu.bnuz.seawas.vo.wechat.PhotoVo;
import com.foxinmy.weixin4j.payment.mch.Order;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Zrj on 2017/8/31.
 */
@Controller
@RequestMapping("/wechat/mine")
public class MineController {
    @Autowired
    private MineService mineService;

    @Autowired
    private AlbumService albumService;

    @Autowired
    private PhotoService photoService;

    @Autowired
    private UserService userService;

    @Autowired
    private LeaderManageActivityService leaderManageActivityService;

    @Autowired
    private WxOrderService orderService;

    @Autowired
    private cn.edu.bnuz.seawas.service.weChat.index.UserService wxUserService;

    private Logger logger = LoggerFactory.getLogger(MineController.class);

    /*
    显示个人资料页面
     */
    @RequestMapping("/showMinePage")
    public String showMinePage(Model model, HttpServletRequest request){
        try {

            HttpSession session = request.getSession();

            User user = (User) session.getAttribute("userInfo");

            User refreshUser = wxUserService.get(user);

            City city = (City) session.getAttribute("currentCity");
            model.addAttribute("cityMessage",city);

            session.setAttribute("userInfo", refreshUser);

            //显示用户已参加的活动
       /* List<Activity> activities = mineService.selectActivityByUserId(user.getId());
        model.addAttribute("activities",activities);*/
//            List<Orders> orders = mineService.findOrdersByUserId(user.getId());
//            model.addAttribute("orders", orders);

            //显示用户收藏的所有产品
            List<Product> products = mineService.selectProductByUserId(user.getId());
            model.addAttribute("collects", products);


            //相册数据
            model.addAttribute("albumList", albumService.findList(new Album((User) session.getAttribute("userInfo"))));

            //如果是领队，还需要传递领队带队活动的数据
            if (user.getType().equals("2")) {
                logger.info("You are a leader");
//                List<LeaderActivityVo> leaderActivityList = leaderManageActivityService.findLeaderActivity(user);
//                model.addAttribute("leaderActivityList", leaderActivityList);
            } else {
                model.addAttribute("leaderActivityList", null);
            }

            logger.info("You are not a leader");

            return "wechat/mine";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 参与活动
     */
    @RequestMapping(value = "/showMineAct", produces = "application/json; charset=utf-8")
    @ResponseBody
    public List<Orders> showMineAct(String userId,HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        List<Orders> orders = mineService.findOrdersByUserId(user.getId());
        return orders;
    }



    /**
     * 带队信息
     */
    @RequestMapping(value = "/showMineLeaderAct", produces = "application/json; charset=utf-8")
    @ResponseBody
    public List<LeaderActivityVo> showMineLeaderAct(String userId,HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        List<LeaderActivityVo> leaderActivityList = leaderManageActivityService.findLeaderActivity(user);

        return leaderActivityList;
    }



    /*
    显示个人相册
     */
    @RequestMapping("/showMinePhoto")
    public String showMinePhoto(Model model, Photo photo, HttpServletRequest request){

        //相册中的所有图片
        List<PhotoVo> photoList = photoService.findList(photo, request);

        //相册信息
        Album album = albumService.get(photo.getAlbum());

        //如果不是自己的相册，则添加一个相册的访问量
        User currentUser = (User) request.getSession().getAttribute("userInfo");
        if (!currentUser.getId().equals(album.getUser().getId())) {
            albumService.addViews(album);
        }

        model.addAttribute("photoList", photoList);
        model.addAttribute("album", album);
        model.addAttribute("photoNum", photoList.size());

        return "wechat/mine/mine-photo";
    }

    /*
    设置个人信息的页面
     */
    @RequestMapping("/showMineSettings")
    public String showMineSettings(String id, Model model){
        User user = new User();
        user = mineService.getUserinfo(id);
        model.addAttribute("userdetail",user);
        return "wechat/mine/mine-settings";
    }

    /*
    修改个人信息
     */
    @RequestMapping("/editUserSetting")
    public String editUserSetting(Model model,User user){
        userService.updateByPrimaryKeySelective(user);
        return "redirect:/wechat/mine/showMinePage";
    }

    /**
     * 活动群二维码设置
     * 从微信服务器上面下载已经上传的图片
     */
    @RequestMapping(value = "/setQRCode")
    @LeaderAuthority
    @ResponseBody
    public String setQRCode(String actId, String mediaId) {
        Condition condition = leaderManageActivityService.setQRCode(actId, mediaId);
        return new Gson().toJson(condition);
    }

    /**
     * 修改活动状态
     */
    @RequestMapping(value = "/changeActivityState")
    @LeaderAuthority
    @ResponseBody
    public String changeActivityState(String actId, String state) {
        Condition condition = leaderManageActivityService.setActivityState(actId, state);
        return new Gson().toJson(condition);
    }

    /**
     * 申请退款
     */
    @RequestMapping(value = "/applyRefund")
    @ResponseBody
    public String applyRefund(HttpServletRequest request, String orderId) {
        try {
            Condition condition = orderService.applyRefund((User) request.getSession().getAttribute("userInfo"), orderId);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

}
