package cn.edu.bnuz.seawas.controller.admin.product;

import cn.edu.bnuz.seawas.entity.Equipment;
import cn.edu.bnuz.seawas.service.admin.EquipmentService;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import com.foxinmy.weixin4j.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by wifi on 2017/7/28.
 * 装备管理
 */
@Controller
@RequestMapping(value = "/equip")
public class EquipmentController {

    @Autowired
    private EquipmentService equipmentService;

    /**
     * wifi
     * 跳转到装备界面
     * @param model
     * @return
     */
    @RequestMapping("/equipmentPage")
    public String equipmentPage(Model model){
        try {
            // 获取所有装备信息
            List<Equipment> equipmentList = equipmentService.selectEquipmentsMessage();
            // 将所有的装备信息按照一定的样式在前端显示
            String equipments = "";
            for (int i = 0;i < equipmentList.size();i++){
                equipments += equipmentList.get(i).getName() + "：" + DateUtil.formatFee2Yuan(equipmentList.get(i).getPrice())+ "元；";
            }
            // 传送到前端界面
            model.addAttribute("equipmentList",equipmentList);
            model.addAttribute("equipments",equipments);

            return "admin/activityMng-equip";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

    /**
     * wifi
     * 删除装备
     * @param equipSelected
     * @return
     */
    @RequestMapping("/deleteEquipment")
    public @ResponseBody
    int deleteEquipment(String equipSelected){
        int result = equipmentService.deleteByPrimaryKey(equipSelected);
        return result;
    }

    /**
     * wifi
     * 添加新的装备
     * @param request
     * @param equipPic 图片
     * @throws IOException
     */
    @RequestMapping("/addEquipment")
    public String addEquipment(HttpServletRequest request, MultipartFile equipPic) throws IOException {
        try {
            Equipment equipment = new Equipment();
            // 原始名称
            String originalFilename = equipPic.getOriginalFilename();
            if (equipPic != null && originalFilename != null && originalFilename.length() > 0){
                // 获得存储图片的物理路径
                String pic_path = PropertiesUtil.getProperty("equipment.realPath");
                // 创建新的图片名称
                String newfileName = UUIDUtil.createUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
                // 新图片
                File newFile = new File(pic_path + newfileName);
                if (!newFile.exists()) {
                    newFile.mkdirs();
                }
                // 将内存中的数据写入磁盘
                equipPic.transferTo(newFile);
                equipment.setPicUrl(newfileName);
            }
            equipment.setId(UUIDUtil.createUUID());
            equipment.setName(request.getParameter("equipName"));
            equipment.setPrice(Integer.parseInt(request.getParameter("equipPrice")));
            // 存入数据库
            equipmentService.insertSelective(equipment);
            return "redirect:/equip/equipmentPage";
        }catch (Exception e){
            e.printStackTrace();
            return "admin/error";
        }
    }

}
