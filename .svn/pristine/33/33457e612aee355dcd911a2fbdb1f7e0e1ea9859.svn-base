package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Sign;

import java.util.List;

public interface SignMapper {
    int deleteByPrimaryKey(String id);

    int insert(Sign record);

    int insertSelective(Sign record);

    Sign selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Sign record);

    int updateByPrimaryKey(Sign record);

    /**
     * 统计某一订单中报名人数
     */
    Integer countNumByOrderId(String orderId) throws Exception;

    /**
     * 通过订单删除报名数据
     */
    int deleteByOrder(String orderId) throws Exception;

    /**
     * 通过订单物理删除报名数据
     */
    int realDeleteByOrder(String orderId);

    /**
     * 获取订单中的报名信息
     */
    List<Sign> findSignByOrder(String orderId);
}