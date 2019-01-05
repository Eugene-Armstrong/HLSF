package cn.edu.bnuz.seawas.controller.weChat.index;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.service.weChat.CalenderService;
import cn.edu.bnuz.seawas.utils.Condition;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 微信端活动日历Controller
 * Created by sjk on 2017-09-20.
 */
@Controller
@RequestMapping(value = "/wechat/calender")
public class CalenderController {

    @Autowired
    private CityService cityService;

    @Autowired
    private CalenderService calenderService;

    /**
     * 显示活动日历页面
     */
    @RequestMapping(value = "/show")
    public String show(Model model, String cityId) {
        try {
            //设置城市信息
            model.addAttribute("currentCity", cityService.get(cityId));
            //设置活动日历信息
            model.addAttribute("activityDate", calenderService.findAllActivityDate(cityId));
            //显示当天日期的活动
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String date = simpleDateFormat.format(new Date());

            model.addAttribute("todayActivity", calenderService.findActivityByDate(date, cityId));
            return "wechat/index/index-calender";
        } catch (Exception e) {
            e.printStackTrace();
            return "wechat/error";
        }
    }

    /**
     * 按照时间查询活动
     */
    @RequestMapping(value = "/findByDate")
    @ResponseBody
    public String findByDate(String cityId, String date) {
        try {
            List<Activity> list = calenderService.findActivityByDate(date, cityId);
            return new Gson().toJson(new Condition<List>(Condition.SUCCESS_CODE, "成功", list));
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙，请稍后再试"));
        }
    }
}
