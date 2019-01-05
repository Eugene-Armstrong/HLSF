package cn.edu.bnuz.seawas.controller.admin.product;

import cn.edu.bnuz.seawas.entity.Destination;
import cn.edu.bnuz.seawas.service.admin.product.DestinationService;
import cn.edu.bnuz.seawas.utils.Condition;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by Zrj on 2017/11/5.
 */
@Controller
@RequestMapping("/admin/destination")
public class DestinationController {
    @Autowired
    DestinationService destinationService;

    /**
     * 目的地页面显示
     * @param model
     * @return
     */
    @RequestMapping("/")
    public String destinationPage(Model model){
        try {
            model.addAttribute("destinationList", destinationService.findList());
            return "admin/productMng/activityMng-dist";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 删除分类
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(Destination destination) {
        try {
            Condition condition = destinationService.delete(destination);

            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 添加分类
     */
    @RequestMapping(value = "/add",
            method = RequestMethod.POST)
    @ResponseBody
    public String save(Destination destination, MultipartFile pic) {
        try {
            Condition condition = destinationService.addNewDestination(destination, pic);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
}
