package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Promotion;

import java.util.List;

public interface PromotionMapper {

    /**
     * wifi
     * 获取优惠规则所有信息
     * @return
     */
    List<Promotion> selectPromotions();

    /**
     * wifi
     * 删除优惠
     * @param id
     * @return
     */
    int deleteByPrimaryKey(String id);

    /**
     * wifi
     * 新增优惠
     * @param record
     * @return
     */
    int insertSelective(Promotion record);

    /**
     * wifi
     * 通过优惠规则的id获取信息
     * @param id
     * @return
     */
    Promotion selectByPrimaryKey(String id);

    int insert(Promotion record);

    int updateByPrimaryKeySelective(Promotion record);

    int updateByPrimaryKey(Promotion record);
}