package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.OrdersMapper;
import cn.edu.bnuz.seawas.dao.SignMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.Admin;
import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.Sign;
import cn.edu.bnuz.seawas.service.SignService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityDetailService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityService;
import cn.edu.bnuz.seawas.utils.*;
import cn.edu.bnuz.seawas.vo.WxProductDetailVo;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.foxinmy.weixin4j.mp.message.TemplateMessage;
import com.foxinmy.weixin4j.payment.WeixinPayProxy;
import com.foxinmy.weixin4j.payment.mch.RefundResult;
import com.foxinmy.weixin4j.type.IdQuery;
import com.foxinmy.weixin4j.type.IdType;
import com.foxinmy.weixin4j.util.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.List;

/**
 * 管理员端订单管理Service
 * Created by sjk on 2017-07-31.
 */
@Service
public class OrderService {

    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private SignMapper signMapper;

    @Autowired
    private SignService signService;

    @Autowired
    private WeixinPayProxy weixinPayProxy;

    @Autowired
    private WeixinProxy weixinProxy;

    @Autowired
    private WxActivityService activityService;

    @Autowired
    private WxActivityDetailService activityDetailService;

    @Autowired
    private ActivityService actService;

    /**
     * 通过活动id获得订单信息
     * @param activityId
     * @return
     */
    public List<Orders> findListByActivityId(String activityId){
        return ordersMapper.findListByActivityId(activityId, null);
    }

    /**
     * 通过活动id获得已支付的订单信息，包含昵称
     * @param activityId
     * @return
     */
    public List<Orders> getListByActivityId(String activityId){
        return ordersMapper.getListByActivityId(activityId);
    }

    /**
     * 通过活动id获得订单信息（分页）
     * @param pageNum
     * @param pageSize
     * @param activityId
     * @return
     */
    public PageInfo<Orders> getListByActivityIdPageInfo(Integer pageNum,Integer pageSize,String activityId){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<Orders>(ordersMapper.getListByActivityId(activityId));
    }

    /**
     * 查询订单列表：分页
     *
     * @param pageNum  当前页
     * @param pageSize 每页的数量
     * @param orders   查询条件
     */
    @Transactional(readOnly = true)
    public PageInfo<Orders> showOrdersPage(Integer pageNum, Integer pageSize, Orders orders) {
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<Orders>(ordersMapper.findList(orders));
    }

    /**
     * 查询订单信息
     */
    @Transactional(readOnly = true)
    public Orders get(Orders orders) { return ordersMapper.get(orders); }

    /**
     * 删除订单
     */
    @Transactional(readOnly = false)
    public void delete(Orders orders) throws Exception {
        //逻辑删除订单表数据
        ordersMapper.delete(orders);
        //物理删除报名表数据
        signMapper.realDeleteByOrder(orders.getId());
    }

    /**
     * 订单退款处理
     */
    @Transactional(readOnly = false)
    public Condition dealRefund(Orders orders, HttpServletRequest request, String refundPrice, String password) {
        try {

            Admin admin = (Admin) request.getSession().getAttribute("admin");

            //如果同意退款
            if ("4".equals(orders.getState())) {

                //校验身份权限
                if (admin == null || admin.getIsSuperAdmin().equals("0")) {
                    return new Condition(Condition.NOALLOW_CODE, "只有超级管理员才能退款！！！");
                }

                orders = ordersMapper.get(orders);

                //校验密码
                if (!MD5Util.checkPassword(password, admin.getPassword())) {
                    return new Condition(Condition.NOALLOW_CODE, "密码错误");
                }

                //检验退款金额
                if (Double.parseDouble(refundPrice) > DateUtil.formatFee2Yuan(orders.getPrice())) {
                    return new Condition(Condition.NOALLOW_CODE, "退款金额无法大于订单金额");
                }

                //商户退款订单号
                String refundNumber = UUIDUtil.createOrderId();

                RefundResult refundResult = weixinPayProxy.applyRefund(new IdQuery(orders.getWechatOrderNum(), IdType.TRANSACTIONID),
                        refundNumber, DateUtil.formatFee2Yuan(orders.getPrice()),
                        Double.parseDouble(refundPrice), null, null, null);

                if (!refundResult.getResultCode().equals("SUCCESS")) {
                    return new Condition(Condition.ERROR_CODE, "退款发起失败");
                }

                //设置状态为退款
                orders.setState("4");
                //设置退款时间
                orders.setAuditTime(new Date());
                //设置审核人
                orders.setAdmin(admin);
                //设置商户退款订单号
                orders.setMerRefundNumber(refundNumber);
                //设置微信退款订单号
                orders.setWechatRefundNumber(refundResult.getRefundId());
                //设置退款金额
                orders.setRefundPrice(refundResult.getRefundFee());

                //更新订单表
                ordersMapper.updateByPrimaryKeySelective(orders);

                //更新报名表
                signMapper.deleteByOrder(orders.getId());

                //获取本订单的报名人数
                Integer orderNum = signService.countSign(orders.getId());
                //获取本活动已报名的人数
                WxProductDetailVo temp = activityDetailService.getWxProductActivityDetails(orders.getActivity().getProduct().getId(), orders.getActivity().getId());
                Integer activityNum = temp.getActivityVoList().get(0).getNum();

                Activity activity = activityService.getActivityDetail(orders.getActivity().getId());
                //设置活动状态
                if ((activityNum - orderNum) >= activity.getTotalNumber()) {
                    activity.setState("已满人");
                } else if ((activityNum - orderNum) >= activity.getTripNumber()) {
                    activity.setState("已成行");
                } else {
                    activity.setState("未成行");
                }

                //更新活动表信息
                actService.updateByPrimaryKeySelective(activity);

                //发送微信消息提示
                try {
                    sendTmplMessage(orders);
                } catch (WeixinException e) {
                    //若用户未关注公众号，则无法接收提示，微信会抛出异常，用户未关注不影响业务，此处照样返回退款已发起
                    return new Condition(Condition.SUCCESS_CODE, "退款已发起");
                }

                return new Condition(Condition.SUCCESS_CODE, "退款已发起");

            } else if ("2".equals(orders.getState())) {
                //如果不同意退款
                ordersMapper.updateByPrimaryKeySelective(orders);

                return new Condition(Condition.SUCCESS_CODE, "已拒绝退款");

            } else {
                return new Condition(Condition.NOALLOW_CODE, "非法操作");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "退款失败");
        }
    }

    /**
     * wifi
     * 添加订单
     * @param orders
     * @return
     */
    public int insert(Orders orders){
        return ordersMapper.insert(orders);
    }

    /**
     * 下载订单报名表信息
     */
    @Transactional(readOnly = true)
    public ResponseEntity<byte[]> downloadSignExcel(String orderId) throws Exception {

        List<Sign> signList = signService.findSignByOrder(orderId);

        Orders order = ordersMapper.get(new Orders(orderId));

        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("报名人信息");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        HSSFCell cell = row.createCell(0);
        cell.setCellValue("订单号");
        cell.setCellStyle(style);

        cell = row.createCell(1);
        cell.setCellValue("用户姓名");
        cell.setCellStyle(style);

        cell = row.createCell(2);
        cell.setCellValue("用户性别");
        cell.setCellStyle(style);

        cell = row.createCell(3);
        cell.setCellValue("用户年龄");
        cell.setCellStyle(style);

        cell = row.createCell(4);
        cell.setCellValue("手机号码");
        cell.setCellStyle(style);

        cell = row.createCell(5);
        cell.setCellValue("身份证");
        cell.setCellStyle(style);

        cell = row.createCell(6);
        cell.setCellValue("购买价格");
        cell.setCellStyle(style);

        cell = row.createCell(7);
        cell.setCellValue("优惠规则");
        cell.setCellStyle(style);

        cell = row.createCell(8);
        cell.setCellValue("优惠比例");
        cell.setCellStyle(style);

        cell = row.createCell(9);
        cell.setCellValue("集合地点");
        cell.setCellStyle(style);

        cell = row.createCell(10);
        cell.setCellValue("备注");
        cell.setCellStyle(style);

        // 第五步，写入实体数据 实际应用中这些数据从数据库得到，
        for (int i = 0; i < signList.size(); i++) {
            row = sheet.createRow(i + 1);
            Sign CS = signList.get(i);
            System.out.println("cs>>>>>>>>>>" + CS.toString());
            // 第四步，创建单元格，并设置值
            row.createCell(0).setCellValue(order.getMerOrderNumber());
            row.createCell(1).setCellValue(CS.getName());
            if (CS.getSex().equals("1")){
                row.createCell(2).setCellValue("男");
            }else if (CS.getSex().equals("2")){
                row.createCell(2).setCellValue("女");
            }
            row.createCell(3).setCellValue(CS.getAge());
            row.createCell(4).setCellValue(CS.getPhone());
            row.createCell(5).setCellValue(CS.getCertId());
            row.createCell(6).setCellValue(DateUtil.formatFee2Yuan(CS.getPrice()));
            if (CS.getPromotion() != null) {
                row.createCell(7).setCellValue(CS.getPromotion().getDetail());
                row.createCell(8).setCellValue(CS.getPromotion().getRule());
            }
            row.createCell(9).setCellValue(order.getGatherPlace());
            row.createCell(10).setCellValue(order.getRemark());

        }

        //命名文件
        String fileName = "订单号" + order.getMerOrderNumber() + "报名表信息.xls";
        String filePath = PropertiesUtil.getProperty("temp.realPath") + "/";

        //判断是否存在临时文件夹
        File filePa = new File(filePath);
        if (!filePa.exists()) {
            filePa.mkdirs();
        }

        //生成Excel
        FileOutputStream outputStream = new FileOutputStream(filePath + fileName);
        wb.write(outputStream);
        outputStream.close();

        ResponseEntity<byte[]> excel = DownloadUtil.downloadFile(filePath + fileName, null);

        //删除临时文件
        File file = new File(filePath + fileName);
        if (file.exists() && file.isFile()) {
            file.delete();
        }

        return excel;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<byte[]> downloadAllOrdersSignExcel(String orderId) throws Exception {
        // 将字符串分割
        String[] Str = orderId.split(",");
        int i = 0;

        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("报名人信息");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        HSSFCell cell = row.createCell(0);
        cell.setCellValue("用户姓名");
        cell.setCellStyle(style);

        cell = row.createCell(1);
        cell.setCellValue("用户性别");
        cell.setCellStyle(style);

        cell = row.createCell(2);
        cell.setCellValue("用户年龄");
        cell.setCellStyle(style);

        cell = row.createCell(3);
        cell.setCellValue("手机号码");
        cell.setCellStyle(style);

        cell = row.createCell(4);
        cell.setCellValue("身份证");
        cell.setCellStyle(style);

        cell = row.createCell(5);
        cell.setCellValue("购买价格");
        cell.setCellStyle(style);

        cell = row.createCell(6);
        cell.setCellValue("优惠规则");
        cell.setCellStyle(style);

        cell = row.createCell(7);
        cell.setCellValue("优惠比例");
        cell.setCellStyle(style);

        cell = row.createCell(8);
        cell.setCellValue("集合地点");
        cell.setCellStyle(style);

        cell = row.createCell(9);
        cell.setCellValue("备注");
        cell.setCellStyle(style);

        for (String s1 : Str) {
            List<Sign> signs = signService.findSignByOrder(s1);
            Orders order = ordersMapper.get(new Orders(s1));

            for (Sign s2 :signs) {
                row = sheet.createRow(i + 1);
                // 第四步，创建单元格，并设置值
                row.createCell(0).setCellValue(s2.getName());
                if (s2.getSex().equals("1")){
                    row.createCell(1).setCellValue("男");
                }else if (s2.getSex().equals("2")){
                    row.createCell(1).setCellValue("女");
                }
                row.createCell(2).setCellValue(s2.getAge());
                row.createCell(3).setCellValue(s2.getPhone());
                row.createCell(4).setCellValue(s2.getCertId());
                row.createCell(5).setCellValue(DateUtil.formatFee2Yuan(s2.getPrice()));
                if (s2.getPromotion() != null) {
                    row.createCell(6).setCellValue(s2.getPromotion().getDetail());
                    row.createCell(7).setCellValue(s2.getPromotion().getRule());
                }
                row.createCell(8).setCellValue(order.getGatherPlace());
                row.createCell(9).setCellValue(order.getRemark());
                i++;
            }
        }
        //命名文件
        String fileName = "报名表信息.xls";
        String filePath = PropertiesUtil.getProperty("temp.realPath") + "/";

        //判断是否存在临时文件夹
        File filePa = new File(filePath);
        if (!filePa.exists()) {
            filePa.mkdirs();
        }

        //生成Excel
        FileOutputStream outputStream = new FileOutputStream(filePath + fileName);
        wb.write(outputStream);
        outputStream.close();

        ResponseEntity<byte[]> excel = DownloadUtil.downloadFile(filePath + fileName, null);

        //删除临时文件
        File file = new File(filePath + fileName);
        if (file.exists() && file.isFile()) {
            file.delete();
        }
        return excel;
    }

    private void sendTmplMessage(Orders orders) throws WeixinException {

        TemplateMessage templateMessage = new TemplateMessage(orders.getUser().getOpenid(), PropertiesUtil.getProperty("Refund.TmplMessage"), null);
        templateMessage.pushHead("您好，您的退款申请审核成功");
        templateMessage.pushTail("如您使用的是微信零钱支付，退款会退至您的微信零钱包；其他支付方式的款项会再1-3个工作日内原来返回");
        templateMessage.pushItem("keyword1", String.valueOf(DateUtil.formatFee2Yuan(orders.getRefundPrice())) + "元");
        templateMessage.pushItem("keyword2", orders.getActivity().getProduct().getName());
        templateMessage.pushItem("keyword3", orders.getMerOrderNumber());
        weixinProxy.sendTmplMessage(templateMessage);
    }

    public Orders findOrderByActivityAndUser(String activityId,String userId){
        return ordersMapper.findOrderByActivityAndUser(activityId,userId);
    }

    /**
     * 查询是否存在申请退款中的订单
     */
    @Transactional(readOnly = true)
    public Boolean isExistRefundOrders() throws Exception {
        Integer count = ordersMapper.countRefundOrders();
        return count != 0;
    }
}
