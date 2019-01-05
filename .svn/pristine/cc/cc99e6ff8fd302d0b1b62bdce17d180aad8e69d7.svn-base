package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.Sign;
import cn.edu.bnuz.seawas.vo.ProductCountVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wifi on 2017/7/29.
 */
public interface ProductCountMapper {

    /**
     * wifi
     * @return 城市信息
     */
    List<City> selectCityMessage();

    /**
     * wifi
     * 通过查询条件获取产品id
     * @param productCountVo
     * @return
     */
    List<ProductCountVo> selectProductId(ProductCountVo productCountVo);

    /**
     * wifi
     * 通过产品id获取产品统计信息
     * @param productId
     * @return
     */
    ProductCountVo selectProductCountMessageByProductId(@Param("productId") String productId);

    /**
     * wifi
     * @param productId
     * @return 通过产品id获得活动id
     */
    List<Activity> selectActivityIdByProductId(@Param("productId") String productId);

    /**
     * wifi
     * @param activityId
     * @return 通过活动id获得订单id
     */
    List<Orders> selectOrdersIdByActivityId(@Param("activityId") String activityId);

    /**
     * wifi
     * @param ordersId
     * @return 通过订单id获得报名的用户信息
     */
    List<Sign> selectSignsByOrdersId(@Param("ordersId") String ordersId);

    /**
     * wifi
     * @param sign
     * @return 通过报名人表id获取所有信息
     */
    List<Sign> selectSignBySignId(@Param("sign") List<Sign> sign);
}
