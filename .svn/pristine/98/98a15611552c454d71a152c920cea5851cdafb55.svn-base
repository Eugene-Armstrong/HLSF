package cn.edu.bnuz.seawas.controller.weChat.outdoor;

import cn.edu.bnuz.seawas.entity.Outdoor;
import cn.edu.bnuz.seawas.service.admin.OutdoorService;
import cn.edu.bnuz.seawas.utils.Condition;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Zrj on 2017/9/1.
 */
@Controller
@RequestMapping("/wechat/outdoor")
public class OutdoorController {
    @Autowired
    private OutdoorService outdoorService;
    @RequestMapping("/showOutdoorPage")
    public String showOutdoorPage(Model model,Outdoor outdoor,String type) throws Exception {

        outdoor.setType("1");
        List<Outdoor> outdoors = outdoorService.wechatfindList(outdoor);
       model.addAttribute("outdoors",outdoors);
        /*return new Gson().toJson(new Condition<List>(Condition.SUCCESS_CODE, "SUCCESS", outdoors));*/
      /*  outdoor.setType("2");
        List<Outdoor> gonglveList = outdoorService.wechatfindList(outdoor);
        model.addAttribute("gonglveList",gonglveList);

        outdoor.setType("3");
        List<Outdoor> sheyingList = outdoorService.wechatfindList(outdoor);
        model.addAttribute("sheyingList",sheyingList);*/
        return "wechat/outdoor";
    }
    @RequestMapping("/show")
    @ResponseBody
    public String show(Model model,Outdoor outdoor,String type) throws Exception {

        outdoor.setType(type);
        List<Outdoor> outdoors = outdoorService.wechatfindList(outdoor);

       /* model.addAttribute("ganhuoList",ganhuoList);*/
       System.out.println("json: "+new Gson().toJson(new Condition<List>(Condition.SUCCESS_CODE, "SUCCESS", outdoors)));
        return new Gson().toJson(new Condition<List>(Condition.SUCCESS_CODE, "SUCCESS", outdoors));
      /*  outdoor.setType("2");
        List<Outdoor> gonglveList = outdoorService.wechatfindList(outdoor);
        model.addAttribute("gonglveList",gonglveList);

        outdoor.setType("3");
        List<Outdoor> sheyingList = outdoorService.wechatfindList(outdoor);
        model.addAttribute("sheyingList",sheyingList);*/
        /*return "wechat/outdoor";*/
    }
}
