package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.CollectionActivity;
import cn.edu.bnuz.seawas.entity.Contact;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.vo.WxProductDetailVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wifi on 2017/9/1.
 */
public interface WxActivityDetailMapper {

    /**
     * wifi
     * 获取产品下有几个正在运作的活动
     * @param productId
     * @return
     */
    int getWxActivityNumber(@Param("productId") String productId,@Param("cityId") String cityId);

    /**
     * wifi
     * 微信获取产品信息
     * @param productId
     * @return
     */
    WxProductDetailVo getWxProductDetails(@Param("productId") String productId);

    /**
     * wifi
     * 微信获取获得单个产品-多个活动-多个领队信息--->购买预览界面
     * @return
     */
    WxProductDetailVo getWxProductActivitiesDetails(@Param("productId") String productId,@Param("cityId") String cityId);

    /**
     * wifi
     * 通过活动id--->获取已报名人数
     * @param actId
     * @return
     */
    Integer getSignNumber(@Param("actId") String actId);

    /**
     * wifi
     * 微信获取获得单个产品-单个活动-多个领队信息--->购买确认界面
     * @param productId
     * @param activityId
     * @return
     */
    WxProductDetailVo getWxProductActivityDetails(@Param("productId") String productId,@Param("activityId") String activityId);

    /**
     * wifi
     * 通过活动id获得已经报名的用户信息
     * @param activity
     * @return
     */
    List<User> getWxParticipantsUsers(@Param("activityId") String activity);

    /**
     * wifi
     * 通过活动id获得带队的领队信息
     * @param activity
     * @return
     */
    List<User> getWxParticipantsLeaders(@Param("activityId") String activity);

    /**
     * wifi
     * 通过openId获得用户的常用人信息
     * @param openId
     * @return
     */
    List<Contact> getWxUsersContacts(@Param("openId") String openId);

    /**
     * wifi
     * 浏览产品->产品浏览次数加一
     * @param productId
     */
    void updateProductReadNumber(@Param("productId") String productId);

    /**
     * wifi
     * 浏览产品获取用户是否收藏
     * @param openId
     * @param productId
     * @return
     */
    int getCollectionType(@Param("openId") String openId,@Param("productId") String productId);

    /**
     * wifi
     * 收藏产品
     * @param collectionActivity
     * @return
     */
    int changeCollectionTypeTrue(CollectionActivity collectionActivity);

    /**
     * wifi
     * 取消收藏产品
     * @param userId
     * @param productId
     * @return
     */
    int changeCollectionTypeFalse(@Param("userId") String userId,@Param("productId") String productId);
}
