package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Destination;

import java.util.List;

public interface DestinationMapper {
    int deleteByPrimaryKey(String id);

    int insert(Destination record);

    int insertSelective(Destination record);

    Destination selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Destination record);

    int updateByPrimaryKey(Destination record);

    /*
    查询目的地列表
     */
    List<Destination> findList();
}