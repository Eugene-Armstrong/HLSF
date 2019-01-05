package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.EquipOrders;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EquipOrdersMapper {
    int deleteByPrimaryKey(String id);

    int insert(EquipOrders record);

    int insertSelective(EquipOrders record);

    EquipOrders selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(EquipOrders record);

    int updateByPrimaryKey(EquipOrders record);

    int insertList(@Param("equipOrders")List<EquipOrders> equipOrders);
}