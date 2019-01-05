package cn.edu.bnuz.seawas.controller.admin;

import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.service.SignService;
import cn.edu.bnuz.seawas.service.admin.OrderService;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.WebUtil;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * 订单管理Controller
 * Created by sjk on 2017-07-31.
 */
@Controller
@RequestMapping(value = "/admin/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private SignService signService;

    /**
     * 跳转到订单管理页面
     */
    @RequestMapping(value = "/")
    public String orderList(Model model, Orders orders,HttpServletRequest request) {
        try {
            //设置默认时间范围，默认当前月
            if (orders.getBeginDate() == null) {
                orders.setBeginDate(DateUtils.setDays(DateUtils.parseDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"), "yyyy-MM-dd"), 1));
            }
            if (orders.getEndDate() == null) {
                orders.setEndDate(DateUtils.addMonths(orders.getBeginDate(), 1));
            }

            //默认显示已支付的订单
            if (StringUtils.isBlank(orders.getState())) {
                orders.setState("2");
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
            PageInfo<Orders> pageInfo = orderService.showOrdersPage(pageNum, pageSize, orders);

            //向前端传输数据
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("orders",orders);
            return "admin/orderMng";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 查看订单详情
     */
    @RequestMapping(value = "/show")
    public String orderDetail(Model model, Orders orders) {
        try {
            Orders orders1 = orderService.get(orders);
            //订单信息
            model.addAttribute("order", orderService.get(orders));
            //报名信息
            model.addAttribute("signs", signService.findSignByOrder(orders.getId()));
            return "admin/orderMng-detail";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 批量删除订单
     */
    @RequestMapping(value = "/delete")
    public String delete(String[] orderIds) {
        try {
            //循环删除
            for (String orderId : orderIds) {
                orderService.delete(new Orders(orderId));
            }
            return "redirect:/admin/order/";
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * 订单退款处理
     */
    @RequestMapping(value = "/refund",
            method = RequestMethod.POST)
    @ResponseBody
    public String refund(Orders orders, HttpServletRequest request, String refundPrices, String password) {

        Condition condition = orderService.dealRefund(orders, request, refundPrices, password);

        return new Gson().toJson(condition);
    }

    /**
     * 导出订单中报名人信息Excel
     */
    @RequestMapping(value = "/exportExcel")
    public ResponseEntity<byte[]> exportExcel(String orderId) {
        try {
            return orderService.downloadSignExcel(orderId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
