package cn.edu.bnuz.seawas.controller.weChat.society;

import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Media;
import cn.edu.bnuz.seawas.service.weChat.IndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Zrj on 2017/8/31.
 */
@Controller
@RequestMapping("/wechat/society")
public class SocietyController {

    @Autowired
    private IndexService indexService;

    @RequestMapping("showSocietyPage")
    public String showSocietypage(Model model, HttpServletRequest request){

        //获取当前城市
        City currentCity = (City) request.getSession().getAttribute("currentCity");

        //查找该城市下的媒体列表
        List<Media> tempList = indexService.index(currentCity.getId());

        //筛选出旅游活动
        List<Media> mediaList = new ArrayList<>();
        for (Media media : tempList) {
            if (media.getLocation().equals("2") && media.getModule().equals("10")) {
                mediaList.add(media);
            }
        }
        model.addAttribute("mediaList", mediaList);

        return "wechat/society";
    }
}
