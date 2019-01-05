package cn.edu.bnuz.seawas.controller.weChat;

import cn.edu.bnuz.seawas.utils.AuthUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * 第一步：用户同意授权，获取code
 * Created by wifi on 2017/8/14.
 */
@RequestMapping("/wxLogin")
@Controller
public class WxLoginController extends HttpServlet{

    @RequestMapping("/login")
    public String login(){
        return "index";
    }

    @RequestMapping("/toCallBack")
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String backUrl = "http://mcsze.51vip.biz/seawas/callBack/getWxMessage"; // 回调地址：需要在公网可以访问，
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + AuthUtil.APPID
                + "&redirect_uri=" + URLEncoder.encode(backUrl)
                + "&response_type=code"
                + "&scope=snsapi_userinfo"
                + "&state=STATE#wechat_redirect";
        System.out.println("To call back");
        resp.sendRedirect(url);
    }
}
