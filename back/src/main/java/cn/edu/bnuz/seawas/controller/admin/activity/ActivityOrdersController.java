package cn.edu.bnuz.seawas.controller.admin.activity;

import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.service.admin.OrderService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 订单管理
 * Created by wifi on 2017/9/26.
 */
@Controller
@RequestMapping("/admin/activityOrders")
public class ActivityOrdersController {

    @Autowired
    private OrderService orderService;

    /**
     * wifi
     * 获取此活动下的所有订单
     * @param model
     * @param activityId
     * @return
     */
    @RequestMapping("/toActivityOrders")
    public String toActivityOrders(Model model,String activityId,HttpServletRequest request){
        try {
            // 默认当前页为1，每页数量为2
            int pageNum = 1;
            int pageSize = 10;

            //分页信息获取
            if (request.getParameter("pageNumber") != null && !"".equals(request.getParameter("pageNumber"))) {
                pageNum = Integer.parseInt(request.getParameter("pageNumber"));
            }
            if (request.getParameter("pageSize") != null && !"".equals(request.getParameter("pageSize"))) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }

            // 获取活动下的所有订单信息
            List<Orders> ordersList = orderService.getListByActivityId(activityId);

            // 获取活动下的分页信息
            PageInfo<Orders> ordersPageInfo = orderService.getListByActivityIdPageInfo(pageNum,pageSize,activityId);

            model.addAttribute("activityId",activityId);
            model.addAttribute("ordersList",ordersList);
            model.addAttribute("pageInfo",ordersPageInfo);

            return "/admin/productMng-activityOrder";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }


    }

    /**
     * wifi
     * 导出订单中报名人信息Excel
     */
    @RequestMapping("/exportExcel")
    public ResponseEntity<byte[]> exportExcel(String orderId) {
        try {
            return orderService.downloadAllOrdersSignExcel(orderId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
