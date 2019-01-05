package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.DestinationProduct;

public interface DestinationProductMapper {
    int deleteByPrimaryKey(String id);

    int insert(DestinationProduct record);

    int insertSelective(DestinationProduct record);

    DestinationProduct selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(DestinationProduct record);

    int updateByPrimaryKey(DestinationProduct record);
}