package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Orders;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 订单表DAO接口
 * Created by sjk on 2017-07-28.
 */
public interface OrdersMapper {

    /**
     * 逻辑删除
     * @param orders orders
     */
    int delete(Orders orders);

    /**
     *
     * 插入数据
     * @param orders orders
     */
    int insert(Orders orders);

    /**
     * 非空插入
     * @param orders orders
     */
    int insertSelective(Orders orders);

    /**
     * 获取单条数据
     * @param orders orders
     */
    Orders get(Orders orders);

    /**
     * 非空更新
     * @param orders orders
     */
    int updateByPrimaryKeySelective(Orders orders);

    /**
     * 更新数据
     * @param orders orders
     */
    int update(Orders orders);

    /**
     * 查询列表
     * @param orders orders
     */
    List<Orders> findList(Orders orders);

    /**
     * 根据商户号更新订单支付信息
     */
    int updateOrderPayInfo(Orders orders) throws Exception;

    /**
     * 查询下单超过30分钟的订单
     */
    List<Orders> findPass30MinOrders() throws Exception;

    /**
     * 通过用户id查找用户所有订单
     * @param userId
     * @return
     */
    List<Orders> findListByUserId(String userId);

    /**
     * 通过商户订单号获得订单id
     * @param MerOrderNum 商户订单号
     * @return
     */
    String findOrderIdByMerOrderNum(@Param("MerOrderNum") String MerOrderNum);

    /**
     * 通过活动id获得订单信息
     */
    List<Orders> findListByActivityId(@Param("activityId") String activityId, @Param("state") String state);

    /**
     * 通过活动id获得已支付的订单信息，包含昵称
     * @param activityId
     * @return
     */
    List<Orders> getListByActivityId(@Param("activityId") String activityId);

    /**
     * 查询7天前未评价的订单
     */
    List<Orders> find7DaysBeforeOeders();

    /*通过活动id用户id获取订单*/
    Orders  findOrderByActivityAndUser(@Param("activityId")String activityId, @Param("userId")String userId);

    /**
     * 查询退款申请中订单数量
     */
    Integer countRefundOrders() throws Exception;

    /**
     * 根据用户id和状态查询订单
     */
    List<Orders> findListByUserAndState(@Param("userId") String userId, @Param("state") String state);
}