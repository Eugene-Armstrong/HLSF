package cn.edu.bnuz.seawas.controller.admin.activity;

import cn.edu.bnuz.seawas.entity.Promotion;
import cn.edu.bnuz.seawas.service.admin.PromotionService;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 优惠管理
 * Created by wifi on 2017/7/28.
 */
@Controller
@RequestMapping(value = "/discount")
public class DiscountController {

    @Autowired
    private PromotionService promotionService;

    /**
     * wifi
     * 跳转到优惠界面
     * @param model
     * @return
     */
    @RequestMapping("/discountPage")
    public String discountPage(Model model){
        try {
            // 活动所有的优惠规则
            List<Promotion> promotionList = promotionService.selectPromotions();
            // 将所有的优惠规则按照一定的样式在前端显示
            String promotions = "";
            for (int i = 0;i < promotionList.size();i++){
                promotions += promotionList.get(i).getDetail() + "：" + promotionList.get(i).getRule() + "；";
            }
            model.addAttribute("promotionList",promotionList);
            model.addAttribute("promotions",promotions);
            return "admin/activityMng-discount";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * wifi
     * 删除优惠规则
     * @param discountSelected
     * @return
     */
    @RequestMapping("/deleteDiscount")
    public @ResponseBody
    int deleteDiscount(String discountSelected){
        int result = promotionService.deleteByPrimaryKey(discountSelected);
        return result;
    }

    /**
     * wifi
     * 添加优惠规则
     * @param request
     * @return
     */
    @RequestMapping("/addDiscount")
    public String addDiscount(HttpServletRequest request){
        try {
            Promotion promotion = new Promotion();
            promotion.setId(UUIDUtil.createUUID());
            promotion.setDetail(request.getParameter("promoDetail"));
            promotion.setRule(Double.parseDouble(request.getParameter("promoRule")));
            promotionService.insertSelective(promotion);
            return "redirect:/discount/discountPage";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

}
