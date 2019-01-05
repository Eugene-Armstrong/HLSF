package cn.edu.bnuz.seawas.controller.admin.activity;

import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.utils.Condition;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 城市管理Controller
 * Created by sjk on 2017-07-31.
 */
@Controller
@RequestMapping(value = "/admin/city")
public class CityController {

    @Autowired
    private CityService cityService;

    /**
     * 跳转到城市管理页面
     */
    @RequestMapping(value = "/")
    public String showCityPage(Model model) {
        try {
            model.addAttribute("cityList", cityService.findList());
            return "admin/activityMng-city";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 添加新的旅游城市
     * @param newCity 城市名称
     * @return json数据
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public String saveCity(String newCity) {

        try {

            Condition condition = cityService.saveNewCity(newCity);

            return new Gson().toJson(condition);

        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 删除城市
     * @param cityId 城市名称
     * @return json数据
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public String deleteCity(String cityId) {

        try {

            Condition condition = cityService.deleteCity(cityId);

            return new Gson().toJson(condition);

        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
}
