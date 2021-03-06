package cn.edu.bnuz.seawas.controller.admin;

import cn.edu.bnuz.seawas.entity.Admin;
import cn.edu.bnuz.seawas.entity.Tips;
import cn.edu.bnuz.seawas.service.admin.AdminService;
import cn.edu.bnuz.seawas.service.admin.AuditService;
import cn.edu.bnuz.seawas.service.admin.OrderService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.MD5Util;
import cn.edu.bnuz.seawas.utils.NetworkUtil;
import cn.edu.bnuz.seawas.vo.AdminCheckVo;
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
import java.util.Date;

/**
 * Created by tomviss on 2017/7/29.
 */
@Controller
public class LoginController {

    private Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    public AdminService adminService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private AuditService auditService;

    @RequestMapping(value = "/")
    public String welcome() { return "welcome"; }

    @RequestMapping(value = {"/a/login", "/a"})
    public String login(){
        try {
            return "admin/login";
            //return "redirect:/wechat/index/show";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }


    @RequestMapping("/doLogin")
    public String doLogin(Admin admin, HttpServletRequest request, Model model) throws Exception {
        try {

            String sb = "IP地址: " + request.getRemoteAddr() +
                    " 请求登陆后台管理系统" +
                    "\tUser: " +
                    admin.getLoginName();

            logger.info(sb);

            // 将获取的登录密码加密后与数据库的密码对比
            admin.setPassword(MD5Util.EncoderByMd5(admin.getPassword()));
            Admin a = adminService.checkUser(admin);

            if (a != null) {
                request.getSession().setAttribute("admin", a);//将管理员的信息存入session
                Date date = new Date();
                a.setLoginDate(date);//最后登录的时间
                a.setLoginIp(NetworkUtil.getIp(request));//获取ip地址

                adminService.updateByPrimaryKeySelective(a);

                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(180 * 60);

                return "redirect:/admin/forwardToSuperIndex";

            } else {
                Tips tips = new Tips();
                tips.setMessage("账号或密码错误！");
                model.addAttribute("tips", tips);

                return "admin/login";
            }
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }

    }

    @RequestMapping("/admin/forwardToSuperIndex")
    public String forwardToSuperIndex(Model model){
        try {
            //检测是否存在申请退款的订单
            model.addAttribute("refundOrders", orderService.isExistRefundOrders());

            return "admin/index-super";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    @RequestMapping("/admin/logout")
    public String logout(HttpServletRequest request){
        try {
            request.getSession().invalidate();
            return "redirect:/a/login";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 检测是否有需要处理的内容（订单、相册等）
     */
    @RequestMapping("/admin/check")
    @ResponseBody
    public String check() {
        try {
            AdminCheckVo adminCheckVo = new AdminCheckVo();
            adminCheckVo.setExistUncheckOrder(orderService.isExistRefundOrders());
            adminCheckVo.setExistUncheckPhoto(auditService.isExistUncheckPhoto());
            return new Gson().toJson(new Condition<AdminCheckVo>(Condition.SUCCESS_CODE, "success", adminCheckVo));
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
}
