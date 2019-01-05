package cn.edu.bnuz.seawas.controller.weChat.index;

import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Custom;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.service.admin.CustomService;
import cn.edu.bnuz.seawas.service.admin.user.UserService;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 企业定制Controller
 * Created by tomviss on 2017/9/26.
 */
@Controller
@RequestMapping(value = "/wechat/company")
public class CompanyController {
    @Autowired
    CustomService customService ;
    @Autowired
    CityService cityService;
    @RequestMapping("/show")
    public String show(Model model){
        try {
            List<City> cityList = cityService.findList();
            model.addAttribute("cityList", cityList);
            return "wechat/index/index-qydz";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    @RequestMapping("/addCompanyCustom")
    @ResponseBody
    public int addCompanyCustom(HttpServletRequest request,Model model) throws ParseException {
        try {
            Custom custom = new Custom();
            custom.setId(UUIDUtil.createUUID());

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userInfo");
            custom.setUser(user);

            custom.setType("0");//0表示企业定制，1表示约伴定制
            custom.setCreateTime(new Date());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟
            String dstr0 = request.getParameter("startTime");
            String dstr1 = dstr0.replace("年", "-");
            String dstr2 = dstr1.replace("月", "-");
            String dstr3 = dstr2.replace("日", "");
            System.out.println("time" + dstr3);
            Date date = sdf.parse(dstr3);
            custom.setStartTime(date);
            City city = new City();
            city.setId(request.getParameter("departCity"));
            custom.setDepartCity(city);

            custom.setNumber(Integer.parseInt(request.getParameter("number")));
            custom.setPrice(Double.parseDouble(request.getParameter("price")));
            custom.setName(request.getParameter("name"));
            System.out.println("age" + request.getParameter("averageAge"));
            custom.setAverageAge(Integer.parseInt(request.getParameter("averageAge")));
            custom.setManaName(request.getParameter("manaName"));
            custom.setManaTel(request.getParameter("manaTel"));
            custom.setAim(request.getParameter("aim"));
            custom.setRemark(request.getParameter("remark"));
            custom.setState("0");//0是未审核 1是审核通过 2是审核不通过

            int result = customService.insert(custom);
            if (result == 1)
                model.addAttribute("tips", "提交成功，工作人员会尽快与您联系，祝您生活愉快！");
            else
                model.addAttribute("tips", "提交失败，请稍后重试");

            model.addAttribute("result", result);

            return result;
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

}
