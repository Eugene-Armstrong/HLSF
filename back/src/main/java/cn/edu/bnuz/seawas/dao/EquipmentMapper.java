package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Equipment;

import java.util.List;

public interface EquipmentMapper {

    /**
     * wifi
     * 装备查询
     * @return
     */
    List<Equipment> selectEquipmentsMessage();

    /**
     * wifi
     * 装备删除
     */
    int deleteByPrimaryKey(String id);

    /**
     * wifi
     * 添加装备
     */
    int insertSelective(Equipment record);

    int insert(Equipment record);

    Equipment selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Equipment record);

    int updateByPrimaryKey(Equipment record);

    List<Equipment> selectByIdBatch(List<String> list);
}