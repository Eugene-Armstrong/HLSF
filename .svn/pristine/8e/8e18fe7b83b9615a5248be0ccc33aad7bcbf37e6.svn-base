package cn.edu.bnuz.seawas.controller.admin;

import cn.edu.bnuz.seawas.entity.Outdoor;
import cn.edu.bnuz.seawas.service.admin.OutdoorService;
import cn.edu.bnuz.seawas.utils.Condition;
import com.foxinmy.weixin4j.util.StringUtil;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

/**
 * 户外学堂Controller
 * Created by sjk on 2017-11-23.
 */
@Controller(value = "PCOutdoorController")
@RequestMapping(value = "/admin/outdoor")
public class OutdoorController {

    @Autowired
    private OutdoorService outdoorService;

    /**
     * 显示户外学堂设置页面
     */
    @RequestMapping(value = "/list")
    public String list(Model model, Outdoor outdoor, HttpServletRequest request) {
        try {
            //默认显示栏目为户外干货
            if (StringUtil.isBlank(outdoor.getType())) {
                outdoor.setType("1");
            }

            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
                pageNum = Integer.parseInt(request.getParameter("pageNumber"));
            }
            if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }

            //查询数据
            PageInfo<Outdoor> pageInfo = outdoorService.findList(pageNum, pageSize, outdoor);

            model.addAttribute("outdoor", outdoor);
            model.addAttribute("pageInfo", pageInfo);

            return "admin/outdoor/outdoor";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 跳转到添加页面
     */
    @RequestMapping(value = "/addPage")
    public String add(Outdoor outdoor, Model model) {
        model.addAttribute("outdoor", outdoor);
        return "admin/outdoor/outdoor-add";
    }

    /**
     * 跳转到修改页面
     */
    @RequestMapping(value = "/updatePage")
    public String update(Outdoor outdoor, Model model) {
        try {
            outdoor = outdoorService.get(outdoor);
            model.addAttribute("outdoor", outdoor);
            return "admin/outdoor/outdoor-change";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 添加推送
     */
    @RequestMapping(value = "/add")
    @ResponseBody
    public String add(Outdoor outdoor, @RequestParam(value = "file") MultipartFile file) {
        try {
            Condition condition = outdoorService.add(outdoor, file);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 修改推送
     */
    @RequestMapping(value = "/update")
    @ResponseBody
    public String update(Outdoor outdoor, @RequestParam(value = "file") MultipartFile file) {
        try {
            Condition condition = outdoorService.update(outdoor, file);
            return new Gson().toJson(condition);
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }

    /**
     * 删除推送
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(String[] outdoorId) {
        try {
            for (String id : outdoorId) {
                outdoorService.delete(new Outdoor(id));
            }
            return new Gson().toJson(new Condition(Condition.SUCCESS_CODE, "删除成功"));
        } catch (Exception e) {
            e.printStackTrace();
            return new Gson().toJson(new Condition(Condition.ERROR_CODE, "系统繁忙"));
        }
    }
}
