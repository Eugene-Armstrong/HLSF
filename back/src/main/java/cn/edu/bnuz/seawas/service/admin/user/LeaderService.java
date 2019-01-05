package cn.edu.bnuz.seawas.service.admin.user;

import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.dao.UserMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.utils.DownloadUtil;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import com.foxinmy.weixin4j.util.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

/**
 * Created by Zrj on 2017/7/31.
 */
@Service(value = "LeaderService")
public class LeaderService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ActivityMapper activityMapper;

    public List<User> findLeaderList(User user){
        return userMapper.findLeaderList(user);
    }

    /**
     * 查询领队列表：分页
     * @param pageNum 当前页
     * @param pageSize 每页的数量
     * @param user 查询条件
     */
    public PageInfo<User> showLeaderPage(Integer pageNum, Integer pageSize, User user) {
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<User>(userMapper.findLeaderList(user));
    }

    /**
     * 获取领队详细信息
     * @param user
     * @return 领队全部信息
     */
    public User getLeaderdetail(User user){
        return userMapper.getLeaderdetail(user);
    }

    /**
     * 剔除一个领队
     * @param user
     * @return
     */
    public int deleteLeader(User user){
        return  userMapper.deleteLeader(user);
    }

    public PageInfo<LeaderActivityVo> selectActivitiesByLeaderId(Integer pageNum, Integer pageSize,User user){
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        PageInfo<LeaderActivityVo> activityPageInfo = new PageInfo<LeaderActivityVo>(activityMapper.selectActivitiesByLeaderId(user));
        for (LeaderActivityVo leaderActivityVo : activityPageInfo.getList()){
            // 通过：活动id-->订单id-->报名人数
            int signNum = activityMapper.getActivitySignNumber(leaderActivityVo.getId());
            activityPageInfo.getList().get(count).setSignNumber(signNum);
            count++;
        }
        return activityPageInfo;
    }

    /**
     * 获取领队带领的所有活动
     * (用于领队信息显示)
     * @param leaderId
     * @return
     */
    public  List<Activity> getActivityFromLeader(String leaderId, String city){
        if (leaderId!=null){
            return activityMapper.selectActivityByLeader(leaderId,city);
        }
        return null;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<byte[]> downloadAllLeaderExcel() throws Exception {
        User user = new User();
        List<User> userList = userMapper.findLeaderList(user);
        // 将字符串分割
        int i = 0;

        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("领队信息");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        HSSFCell cell = row.createCell(0);
        cell.setCellValue("真实姓名");
        cell.setCellStyle(style);

        cell = row.createCell(1);
        cell.setCellValue("性别");
        cell.setCellStyle(style);

        cell = row.createCell(2);
        cell.setCellValue("年龄");
        cell.setCellStyle(style);

        cell = row.createCell(3);
        cell.setCellValue("手机号码");
        cell.setCellStyle(style);

        cell = row.createCell(4);
        cell.setCellValue("评分");
        cell.setCellStyle(style);

        cell = row.createCell(5);
        cell.setCellValue("带队次数");
        cell.setCellStyle(style);


        for (User leader : userList) {
            row = sheet.createRow(i + 1);
            //第四步，创建单元格，并设置值
            if (leader.getRealName() != null)
                row.createCell(0).setCellValue(leader.getRealName());
            if (leader.getSex().equals("1")){
                row.createCell(1).setCellValue("男");
            }else if (leader.getSex().equals("2")){
                row.createCell(1).setCellValue("女");
            }
            if (leader.getAge() != null)
                row.createCell(2).setCellValue(leader.getAge());
            if (leader.getPhone() != null)
                row.createCell(3).setCellValue(leader.getPhone());
            if (leader.getScore() != null)
                row.createCell(4).setCellValue(leader.getScore());
            if (leader.getLeaderNum() != null)
                row.createCell(5).setCellValue(leader.getLeaderNum());
            i++;
        }
        //命名文件
        String fileName = "领队信息.xls";
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

}
