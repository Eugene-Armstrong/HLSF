package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.ClassificationProduct;

public interface ClassificationProductMapper {
    int deleteByPrimaryKey(String id);

    int insert(ClassificationProduct record);

    int insertSelective(ClassificationProduct record);

    ClassificationProduct selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ClassificationProduct record);

    int updateByPrimaryKey(ClassificationProduct record);

    /**
     * 通过分类id删除数据
     * @param classificationId 分类id
     */
    int deleteByClassId(String classificationId);

    /**
     * 通过产品id删除数据
     * @param productId 产品id
     */
    int deleteByProductId(String productId);
}