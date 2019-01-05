package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Appreciation;

public interface AppreciationMapper {
    int deleteByPrimaryKey(String id);

    int insert(Appreciation record);

    int insertSelective(Appreciation record);

    Appreciation selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Appreciation record);

    int updateByPrimaryKey(Appreciation record);

    int selectByUserIdAndTravelnoteId(Appreciation record);
}