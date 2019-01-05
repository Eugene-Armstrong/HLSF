package cn.edu.bnuz.seawas.controller.admin.activity;

import cn.edu.bnuz.seawas.entity.Classification;
import cn.edu.bnuz.seawas.service.admin.CategoryService;
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
 * 分类管理Controller
 * Created by sjk on 2017-07-31.
 */
@Controller
@RequestMapping(value = "/admin/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    /**
     * 跳转到分类管理界面
     */
    @RequestMapping(value = "/")
    public String showCategoryPage(Model model) {
        try {
            model.addAttribute("categoryList", categoryService.findList());
            return "admin/activityMng-sort";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 删除分类
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(Classification classification) {
        try {
            Condition condition = categoryService.delete(classification);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 添加分类
     */
    @RequestMapping(value = "/save",
                    method = RequestMethod.POST)
    @ResponseBody
    public String save(Classification classification, MultipartFile pic) {
        try {
            Condition condition = categoryService.save(classification, pic);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
}
