package cn.edu.bnuz.seawas.controller.weChat.index;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 模块消息跳转
 * Created by wifi on 2017/9/30.
 */
@Controller
@RequestMapping("/showRounte")
public class ShowRounteController {

    /**
     * wifi
     * 模块消息跳转
     * @param rounte
     * @param model
     * @return
     */
    @RequestMapping("/toRounte")
    public String toRounte(String rounte, Model model){
        model.addAttribute("rounte",rounte);
        return "/wechat/activity-prepare";
    }
}
