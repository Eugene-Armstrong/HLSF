package cn.edu.bnuz.seawas.controller.admin.product;

import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Media;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.service.admin.CityService;
import cn.edu.bnuz.seawas.service.admin.MediaService;
import cn.edu.bnuz.seawas.service.admin.product.ProductService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.vo.ProductDetail;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 媒体管理Controller
 * Created by sjk on 2017-08-07.
 */
@Controller
@RequestMapping(value = "/admin/media")
public class MediaController {

    @Autowired
    private MediaService mediaService;

    @Autowired
    private CityService cityService;

    @Autowired
    private ProductService productService;

    /**
     * 跳转到媒体管理界面
     */
    @RequestMapping(value = "/list")
    public String list(Model model, Media media) {
        try {
            //判断是否是首次进入页面
            if (media != null) {
                if (media.getCity() != null) {
                    if (StringUtils.isNotBlank(media.getCity().getId())) {
                        List<Media> mediaList = mediaService.findList(media);
                        model.addAttribute("mediaList", mediaList);
                        model.addAttribute("mediaCity", media);
                    }
                }
            }
            List<City> cityList = cityService.findList();
            model.addAttribute("cityList", cityList);
            return "admin/media";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 选择产品列表
     */
    @RequestMapping(value = "/getProduct")
    @ResponseBody
    public String getProduct(Media media) {
        try {
            List<Product> list = mediaService.findProduct(media);
            return new Gson().toJson(new Condition<List>(Condition.SUCCESS_CODE, "成功", list));
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 保存设置
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public String save(Media data) {
        Condition condition = mediaService.save(data);
        return new Gson().toJson(condition);
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(Media media) {
        Condition condition = mediaService.delete(media);
        return new Gson().toJson(condition);
    }

    /**
     * 获取单条产品信息
     */
    @RequestMapping(value = "/productInfo")
    @ResponseBody
    public String productInfo(String id) {
        try {
            ProductDetail product = productService.selectProductById(id);
            return new Gson().toJson(new Condition<ProductDetail>(Condition.SUCCESS_CODE, "成功", product));
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
}
