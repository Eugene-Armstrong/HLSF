package cn.edu.bnuz.seawas.controller.weChat.index;

import cn.edu.bnuz.seawas.entity.Classification;
import cn.edu.bnuz.seawas.entity.Destination;
import cn.edu.bnuz.seawas.service.admin.CategoryService;
import cn.edu.bnuz.seawas.service.admin.product.DestinationService;
import cn.edu.bnuz.seawas.service.weChat.SortService;
import cn.edu.bnuz.seawas.vo.ProductVo;
import cn.edu.bnuz.seawas.vo.wechat.ProductAndActivityVo;
import cn.edu.bnuz.seawas.vo.wechat.ProductForSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Zrj on 2017/9/18.
 * 微信端的更多分类
 */

@Controller
@RequestMapping(value = "/wechat/sort")
public class SortController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    SortService sortService;
    @Autowired
    DestinationService destinationService;

    /**
     * 显示页面
     */
    @RequestMapping("/ShowSortindex")
    public String ShowSortindex(Model model,String cityId){
        //获取分类列表
        List<Classification> sortList = categoryService.findList();
        //获取目的地列表
        List<Destination> destinationList = destinationService.findList();
        model.addAttribute("cityId",cityId);
        model.addAttribute("sortList",sortList);
        model.addAttribute("destinationList",destinationList);
        return "wechat/index/index-sort";
    }


    /**
     * 进入二级页面通过分类数据
     */
    @RequestMapping("/ShowProductBySortInfo")
    @ResponseBody
    public List<ProductAndActivityVo> ShowProductBySortInfo(Model model, ProductVo productVo){
        try {

            List<ProductAndActivityVo> productAndActivityVoList = sortService.showSecondPageInfoBySort(productVo);

//            return "wechat/index/index-sort-project";
            return productAndActivityVoList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    /**
     * 进入二级页面通过分类数据
     */
    @RequestMapping("/ShowProductBySort")
    public String ShowProductBySort(Model model, ProductVo productVo){
        try {
            //获取分类列表
            List<Classification> sortList = categoryService.findList();
            model.addAttribute("cityId",productVo.getCityId());
            model.addAttribute("sortList",sortList);

            return "wechat/index/index-sort-project";
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    /**
     * 进入二级页面通过难度等级页面
     */
    @RequestMapping("/ShowProductByDif")
    public String ShowProductByDif(Model model,ProductVo productVo){
        try {
        //获取分类列表
        model.addAttribute("cityId",productVo.getCityId());

        return "wechat/index/index-sort-level";
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 进入二级页面通过难度数据
     */
    @RequestMapping("/ShowProductByDifInfo")
    @ResponseBody
    public List<ProductAndActivityVo> ShowProductByDifInfo(ProductVo productVo){
        try {

            List<ProductAndActivityVo> productAndActivityVoList = sortService.showSecondPageInfoByDiff(productVo);

            return productAndActivityVoList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    /**
     * 进入二级页面通过天数页面
     */
    @RequestMapping("/ShowProductByDay")
    public String ShowProductByDay(Model model,ProductVo productVo){
            //获取分类列表
            model.addAttribute("cityId",productVo.getCityId());
            return "wechat/index/index-sort-day";
    }

    /**
     * 进入二级页面通过天数数据
     */
    @RequestMapping("/ShowProductByDayInfo")
    @ResponseBody
    public List<ProductAndActivityVo> ShowProductByDayInfo(ProductVo productVo){
        try {
            List<ProductAndActivityVo> productAndActivityVoList = sortService.showSecondPageInfoByDay(productVo);
            return productAndActivityVoList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 进入二级页面通过目的地页面
     */
    @RequestMapping("/ShowProductByDist")
    public String ShowProductByDist(Model model,ProductVo productVo){
        //获取分类列表
        model.addAttribute("cityId",productVo.getCityId());
        List<Destination> destinationList = destinationService.findList();
        model.addAttribute("destinationList",destinationList);
        return "wechat/index/index-sort-province";
    }

    /**
     * 进入二级页面通过目的地数据
     */
    @RequestMapping("/ShowProductByDistInfo")
    @ResponseBody
    public List<ProductForSort> ShowProductByDistInfo(ProductVo productVo){
        try {
            List<ProductForSort> productAndActivityVoList = sortService.showSecondPageInfoByDist(productVo);
            return productAndActivityVoList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
