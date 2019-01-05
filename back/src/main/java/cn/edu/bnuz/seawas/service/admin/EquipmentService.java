package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.EquipmentMapper;
import cn.edu.bnuz.seawas.entity.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by PVer on 2017/7/28.
 */
@Service("equip")
public class EquipmentService {

    @Autowired
    private EquipmentMapper equipmentMapper;

    /**
     * wifi
     * 获取装备信息
     * @return
     */
    public List<Equipment> selectEquipmentsMessage(){
        return equipmentMapper.selectEquipmentsMessage();
    }

    /**
     * wifi
     * 删除装备信息
     */
    public int deleteByPrimaryKey(String id){
        return equipmentMapper.deleteByPrimaryKey(id);
    }

    /**
     * wifi
     * 添加装备信息
     */
    public int insertSelective(Equipment equipment){
        return equipmentMapper.insertSelective(equipment);
    }

    /**
     * 通过list查找装备列表
     * @param list
     * @return
     */
    public List<Equipment> selectByIdBatch(List<String> list){
        return  equipmentMapper.selectByIdBatch(list);
    }
}
