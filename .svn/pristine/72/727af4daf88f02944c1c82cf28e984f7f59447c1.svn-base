package cn.edu.bnuz.seawas.controller.admin.user;

import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.admin.user.LeaderService;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Zhong-Yan on 2017/7/17.
 * 领队相关的操作
 */
@Controller
@RequestMapping("/leader")
public class LeaderController {

    @Autowired
    private LeaderService leaderService;

    //显示领队列表
    @RequestMapping("/showIndex")
    public String showIndex(Model model, User user, HttpServletRequest request) {
//        // 获取领队信息
//        List<User> leadersList = leaderService.findLeaderList(user);
//        model.addAttribute("leadersList",leadersList);
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
            PageInfo<User> pageInfo = leaderService.showLeaderPage(pageNum, pageSize, user);

            //向前端传输数据
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("user",user);

            return "admin/leaderMng/leaderMng";
        } catch (Exception e) {
            //异常跳转
            e.printStackTrace();
            return "admin/error";
        }
    }

    //提拔普通用户为领队
    @RequestMapping("/addLeader")
    public String addLeader(Model model) {
        return "admin/leaderMng/leaderMng-add";
    }

    //查看领队详细信息
    @RequestMapping("/showDetail")
    public String showLeaderDetail(Model model,HttpServletRequest request) {
        String userId = request.getParameter("userId");
        User getUser = new User();
        getUser.setId(userId);

        User user = leaderService.getLeaderdetail(getUser);
        model.addAttribute("leader",user);

        return "admin/leaderMng/leaderMng-detail";
    }

    // 批量剔除领队
    @RequestMapping("/deleteLeader")
    public String deleteLeader(String[] user_id) throws Exception {

        User user = new User();
        for(int i = 0;i< user_id.length;i++){
            user.setId(user_id[i]);
            leaderService.deleteLeader(user);
        }

        return "redirect:/leader/showIndex";

    }

    /**
     * 显示领队活动
     */
    @RequestMapping("/leaderActivity")
    public String leaderActivity(Model model, User user, HttpServletRequest request){
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
            PageInfo<LeaderActivityVo> pageInfo = leaderService.selectActivitiesByLeaderId(pageNum, pageSize, user);

            //向前端传输数据
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("user",user);

            return "admin/leaderMng/leaderMng-activity";
        } catch (Exception e) {
            //异常跳转
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 将领队的数据导出Excel表格
     */
    @RequestMapping("/getLeaderExcel")
    public ResponseEntity<byte[]> putSignMessageExcel(){
        try {
            return leaderService.downloadAllLeaderExcel();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
