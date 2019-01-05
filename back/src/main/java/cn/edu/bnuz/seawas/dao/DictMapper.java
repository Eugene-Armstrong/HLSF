package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Dict;

import java.util.List;

public interface DictMapper {
    int deleteByPrimaryKey(String id);

    int insert(Dict record);

    int insertSelective(Dict record);

    Dict selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Dict record);

    int updateByPrimaryKey(Dict record);

    /**
     * 根据类型获取列表
     */
    List<Dict> findList(Dict dict);
}