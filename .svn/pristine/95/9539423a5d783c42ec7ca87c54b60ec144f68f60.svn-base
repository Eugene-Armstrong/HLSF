package cn.edu.bnuz.seawas.controller.weChat.index;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.Album;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.admin.ActivityService;
import cn.edu.bnuz.seawas.service.admin.user.LeaderService;
import cn.edu.bnuz.seawas.service.weChat.index.LeaderMsgService;
import cn.edu.bnuz.seawas.service.weChat.mine.AlbumService;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by tomviss on 2017/9/20.
 * 微信端领队资料Controller
 */
@Controller
@RequestMapping(value = "/wechat/leader")
public class LeaderMsgController {

    @Autowired
    LeaderService leaderService;
    @Autowired
    ActivityService activityService;
    @Autowired
    AlbumService albumService;
    @Autowired
    LeaderMsgService leaderMsgService;

    /**
     * 显示所有领队和领队的活动
     * @param user
     * @param model
     * @return
     */
    @RequestMapping("/show")
    public String show(User user, Model model,HttpServletRequest request){
        HttpSession session = request.getSession();
        City city = (City)session.getAttribute("currentCity");

        List<User> userList = leaderService.findLeaderList(user);
        List<LeaderActivityVo> leaderActivitys = activityService.selectActivitiesWithLeader(city.getId());
       /* Map<User , List<Activity>> leader_activities = new HashMap<User , List<Activity>>();;
        for(User u : userList){
            List<Activity> activityList = leaderService.getActivityFromLeader(u.getId(),cityId);
            leader_activities.put(u,activityList);
        }*/

      model.addAttribute("leaders",userList);
      model.addAttribute("leaderActivitys",leaderActivitys);
     //   model.addAttribute("leader_act",leader_activities);
        return "wechat/index/index-leaderList";
    }

    /**
     * 显示领队个人资料
     * @param leaderId
     * @param model
     * @return
     */
    @RequestMapping("/showLeader")
    public String showLeader(HttpServletRequest request,String leaderId,Model model,String city){
        User user =  new User();
        user.setId(leaderId);
        user = leaderService.getLeaderdetail(user);

        List<Activity> activity = activityService.selectActivityByLeader(leaderId,city);

        HttpSession session = request.getSession();
        User localUser = (User) session.getAttribute("userInfo");
        //是否已关注
        int isFollow = leaderMsgService.isFollow(localUser.getId(),leaderId);
        model.addAttribute("isFollow",isFollow);

        //关注量
        int count = leaderMsgService.fansCount(leaderId);
        model.addAttribute("fansCount",count);


        //相册
        model.addAttribute("albumList", albumService.findList(new Album(user)));

        model.addAttribute("cityId",city);
        model.addAttribute("leader",user);
        model.addAttribute("activities",activity);

        return "wechat/index/index-leader";
    }

    /**
     * 加关注
     * @param leaderId
     * @return
     */
    @RequestMapping("/addFollow")
    public @ResponseBody int addFollow(String leaderId, HttpServletRequest request){
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("userInfo");
        return  leaderMsgService.addFollow(leaderId,user.getId());
    }


}