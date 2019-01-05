package cn.edu.bnuz.seawas.controller.admin.TotalCount;

import cn.edu.bnuz.seawas.dto.TotalCountData;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.service.admin.totalCount.TotalCountService;
import cn.edu.bnuz.seawas.vo.ProductOrderNumVo;
import cn.edu.bnuz.seawas.vo.UserOrderMoneyVo;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Zhong-Yan on 2017/7/18.
 */
@Controller
@RequestMapping("/admin/totalCount")
public class TotalCountController {
    @Autowired
    private TotalCountService totalCountService;
    @Autowired
    private CityService cityService;

    @RequestMapping("/showTotalCount")
    public String ShowStatistics(Model model){
        TotalCountData totalCountData = totalCountService.dataCountInfo();
        model.addAttribute("totalCountData",totalCountData);
        return "admin/totalCount/dataCount";
    }

    @RequestMapping("/showDataCountLeaders")
    public String showDataCountLeaders(Model model,HttpServletRequest request){
        //设置分页设置
        int pageNum = 1;
        int pageSize = 10;

        //分页信息获取
        if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }

        PageInfo<User> leaderList = totalCountService.dataCountLeader(pageNum, pageSize);
        model.addAttribute("pageInfo",leaderList);
        return "admin/totalCount/dataCount-leaders";
    }

    /**
     * 产品数量统计
     * @param model
     * @param request
     * @param city
     * @return
     */
    @RequestMapping("/showDataCountProduct")
    public String showDataCountProduct(Model model,HttpServletRequest request,City city){
        //设置分页设置
        int pageNum = 1;
        int pageSize = 10;
        //分页信息获取
        if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }


        PageInfo<Product> productList = totalCountService.dataCountProduct(pageNum, pageSize, city);
        model.addAttribute("pageInfo",productList);
        model.addAttribute("city",city);
        model.addAttribute("cityList",cityService.findList());
        return "admin/totalCount/dataCount-product";
    }

    @RequestMapping("/showDataCountUsers")
    public String ShowdataCountUsers(Model model,HttpServletRequest request){
        //设置分页设置
        int pageNum = 1;
        int pageSize = 10;

        //分页信息获取
        if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }

        PageInfo<User> userList = totalCountService.dataCountUser(pageNum, pageSize);
        model.addAttribute("pageInfo",userList);
        return "admin/totalCount/dataCount-users";
    }

    /**
     *     总成交金额统计
     */
    @RequestMapping("/showDataCountTotalMoney")
    public String showDataCountTotalMoney(Model model,HttpServletRequest request){
        //设置分页设置
        int pageNum = 1;
        int pageSize = 10;

        //分页信息获取
        if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }

        PageInfo<UserOrderMoneyVo> userList = totalCountService.dataCountTotalMoney(pageNum, pageSize);
        model.addAttribute("pageInfo",userList);
        return "admin/totalCount/dataCount-totalMoney";
    }

    /**
     *     总成交量
     */
    @RequestMapping("/showDataCountTotalNum")
    public String showdataCountTotalNum(Model model,HttpServletRequest request,City city){
        //设置分页设置
        int pageNum = 1;
        int pageSize = 10;
        //分页信息获取
        if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
            pageNum = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }

        PageInfo<ProductOrderNumVo> productList = totalCountService.dataCountTotalNum(pageNum, pageSize, city);
        model.addAttribute("pageInfo",productList);
        model.addAttribute("city",city);
        model.addAttribute("cityList",cityService.findList());
        return "admin/totalCount/dataCount-totalNum";
    }


}
