package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.SignPromotion;

public interface SignPromotionMapper {
    int deleteByPrimaryKey(String id);

    int insert(SignPromotion record);

    int insertSelective(SignPromotion record);

    SignPromotion selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SignPromotion record);

    int updateByPrimaryKey(SignPromotion record);

    /**
     * 通过报名表id获取信息
     */
    SignPromotion getBySignId(String signId);
}