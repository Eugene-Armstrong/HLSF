package cn.edu.bnuz.seawas.controller.weChat.index;

import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Media;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.service.weChat.IndexService;
import cn.edu.bnuz.seawas.service.weChat.WxLoginService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.vo.wechat.ProductAndActivityVo;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.foxinmy.weixin4j.mp.message.TemplateMessage;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 微信端首页展示Controller
 * Created by sjk on 2017-08-31.
 */
@Controller
@RequestMapping(value = "/wechat/index")
public class IndexController {

    private Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    private IndexService indexService;

    @Autowired
    private CityService cityService;

    @Autowired
    private WxLoginService wxLoginService;

    /**
     * 跳转到首页
     * 获取用户信息等实际操作由拦截器完成
     */
    @RequestMapping(value = "/")
    public String index() {
        return "redirect:/wechat/index/show";
    }

    /**
     * 显示首页
     * @param cityId 城市id
     * @return
     * cityList 城市列表
     * currentCity 当前城市信息
     * mediaList 媒体列表
     */
    @RequestMapping(value = "/show")
    public String index(String cityId, Model model, HttpServletRequest request){
        try {
            //获取城市列表
            List<City> cityList = cityService.findList();

            //如果没有选择城市
            if (StringUtils.isBlank(cityId)) {
                cityId = cityList.get(0).getId();
            }

            City currentCity = cityService.get(cityId);

            //根据城市列表查询首页信息
            List<Media> mediaList = indexService.index(cityId);

            //设置数据
            model.addAttribute("cityList", cityList);
            model.addAttribute("currentCity", currentCity);
            model.addAttribute("mediaList", mediaList);

            request.getSession().setAttribute("currentCity", currentCity);

            logger.info("userInfo={}", request.getSession().getAttribute("userInfo"));

            if (request.getSession().getAttribute("userInfo") == null) {
                String openId = "o4TB6wu_6VtCpRmKOA1YkS0wLx8Y";
                User sessionUser = wxLoginService.selectUserByOpenid(openId);
                request.getSession().setAttribute("userInfo", sessionUser);
                logger.info("将用户：" +
                        sessionUser.toString() +
                        " 存进session中");
            }
            return "wechat/index";
        }catch (Exception e) {
            e.printStackTrace();
            return "/wechat/error";
        }
    }

    /**
     * 获取所有城市列表
     */
    @RequestMapping(value = "/getCityList")
    @ResponseBody
    public String getCityList() {
        try {
            List<City> cityList = cityService.findList();
            System.out.println("cityList->>>" + cityList);
            return new Gson().toJson(new Condition<List>(Condition.SUCCESS_CODE, "成功", cityList));
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 跳转到首页的二级页面
     */
    @RequestMapping(value = "/showSecondPage")
    public String showSecondPage(Model model, Media media) {
        try {

            List<ProductAndActivityVo> productAndActivityVoList = indexService.showSecondPageInfo(media);

            model.addAttribute("productAndActivityList", productAndActivityVoList);

            model.addAttribute("media", media);

            return "wechat/index/index-sndx";
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
