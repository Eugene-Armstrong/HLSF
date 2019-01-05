package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.OrdersMapper;
import cn.edu.bnuz.seawas.dao.ProductCountMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.Sign;
import cn.edu.bnuz.seawas.utils.DownloadUtil;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.vo.ProductCountVo;
import com.foxinmy.weixin4j.util.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by wifi on 2017/7/29.
 */
@Service(value = "ProductCountService")
public class ProductCountService {

    @Autowired
    private ProductCountMapper productCountMapper;

    @Autowired
    private OrdersMapper ordersMapper;

    /**
     * wifi
     * @return 城市信息
     */
    public List<City> selectCityMessage(){
        return productCountMapper.selectCityMessage();
    }

    /**
     * wifi
     * 获取产品统计信息 + 分页
     * @param pageNum 当前页
     * @param pageSize 每页的数量
     * @param productCountVo 查询条件
     * @return
     */
    public PageInfo<ProductCountVo> selectProductCountVoMessagePageInfo(Integer pageNum, Integer pageSize, ProductCountVo productCountVo){
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);

        // 通过查询条件获取产品id + 分页
        PageInfo<ProductCountVo> pageInfo = new PageInfo<ProductCountVo>(productCountMapper.selectProductId(productCountVo));

        // 根据产品id，分步获取统计信息后添加进pageInfo中
        if (pageInfo.getList() == null || pageInfo.getList().size() == 0){
            pageInfo.setIsLastPage(true);
        }else {
            // 通过产品id完善产品基本信息
            for (ProductCountVo productCountVo2:pageInfo.getList()){
                ProductCountVo getProductCountVo = productCountMapper.selectProductCountMessageByProductId(productCountVo2.getProductId());
                pageInfo.getList().get(count).setProductName(getProductCountVo.getProductName());
                pageInfo.getList().get(count).setProductReadNumber(getProductCountVo.getProductReadNumber());
                pageInfo.getList().get(count).setProductCollectionNumber(getProductCountVo.getProductCollectionNumber());
                pageInfo.getList().get(count).setProductBuyNumber(getProductCountVo.getProductBuyNumber());
                pageInfo.getList().get(count).setProductSumMoney(getProductCountVo.getProductSumMoney());
                count++;
            }
        }
        return pageInfo;
    }

    /**
     * wifi
     * 获取某个产品下的所有购买者信息
     * @param productId
     * @return
     */
    public List<Sign> selectSignsByOrdersId(String productId){
        // 通过产品id获取活动id
        List<Activity> activityList = productCountMapper.selectActivityIdByProductId(productId);

        // 通过活动id获取对应的所有的订单id
        List<Orders> ordersList = new ArrayList<Orders>();
        for (Activity activity:activityList){
            List<Orders> orders = productCountMapper.selectOrdersIdByActivityId(activity.getId());
            ordersList.addAll(orders);
        }

        // 通过订单id获取对应的所有用户信息
        List<Sign> signList = new ArrayList<Sign>();
        for (Orders orders:ordersList){
            List<Sign> signs = productCountMapper.selectSignsByOrdersId(orders.getId());
            signList.addAll(signs);
        }

        return signList;
    }

    /**
     * wifi
     * 通过报名人表id获取全部信息
     * @param signId
     * @return
     */
    public ResponseEntity<byte[]> selectSignBySignId(String signId) throws Exception{
        // 将字符串分割
        String[] Str = signId.split(",");
        List<Sign> signList = new ArrayList<Sign>();
        for (String s : Str){
            Sign sign = new Sign();
            sign.setId(s);
            signList.add(sign);
        }
        // 获取报名表具体信息
        List<Sign> signs = productCountMapper.selectSignBySignId(signList);

        // 返回Excel表格导出结果
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("报名人信息");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        HSSFCell cell = row.createCell((short) 0);
        cell.setCellValue("订单号");
        cell.setCellStyle(style);

        cell = row.createCell((short) 1);
        cell.setCellValue("用户姓名");
        cell.setCellStyle(style);

        cell = row.createCell((short) 2);
        cell.setCellValue("用户性别");
        cell.setCellStyle(style);

        cell = row.createCell((short) 3);
        cell.setCellValue("用户年龄");
        cell.setCellStyle(style);

        cell = row.createCell((short) 4);
        cell.setCellValue("手机号码");
        cell.setCellStyle(style);

        cell = row.createCell((short) 5);
        cell.setCellValue("身份证");
        cell.setCellStyle(style);

        cell = row.createCell((short) 6);
        cell.setCellValue("购买价格");
        cell.setCellStyle(style);

        // 第五步，写入实体数据 实际应用中这些数据从数据库得到，
        for (int i = 0; i < signs.size(); i++) {
            row = sheet.createRow((int) i + 1);
            Sign CS = signs.get(i);
            // 第四步，创建单元格，并设置值
            row.createCell((short) 0).setCellValue(ordersMapper.get(new Orders(CS.getOrdersId())).getMerOrderNumber());
            row.createCell((short) 1).setCellValue(CS.getName());
            if (CS.getSex().equals("1")){
                row.createCell((short) 2).setCellValue("男");
            }else if (CS.getSex().equals("2")){
                row.createCell((short) 2).setCellValue("女");
            }
            row.createCell((short) 3).setCellValue(CS.getAge());

            row.createCell((short) 4).setCellValue(CS.getPhone());
            row.createCell((short) 5).setCellValue(CS.getCertId());
            row.createCell((short) 6).setCellValue(DateUtil.formatFee2Yuan(CS.getPrice()));
        }

        // 第六步，将文件存到EXCEL表格临时存储位置
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat(
                "yyyy-MM-dd-HH-mm-ss");
        String dateString = formatter.format(currentTime);
        String fileName = "报名人数据统计" + dateString + ".xls";
        String deskPath = PropertiesUtil.getProperty("temp.realPath") + "/" + fileName;
        FileOutputStream fout = new FileOutputStream(deskPath);
        wb.write(fout);
        fout.close();

        ResponseEntity<byte[]> excel = DownloadUtil.downloadFile(deskPath, null);

        //删除临时文件
        File file = new File(deskPath);
        if (file.exists()) {
            file.delete();
        }

        return excel;
    }
}
