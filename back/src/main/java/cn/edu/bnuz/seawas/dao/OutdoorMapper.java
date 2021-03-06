package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Outdoor;

import java.util.List;

/**
 * 户外学堂DAO接口
 * Created by sjk on 2017-11-24.
 */
public interface OutdoorMapper {

    /**
     * 获取单条数据
     */
    Outdoor get(Outdoor outdoor);

    /**
     * 列表查询
     */
    List<Outdoor> findList(Outdoor outdoor);

    /**
     * 插入数据
     */
    int insert(Outdoor outdoor);

    /**
     * 更新数据
     */
    int update(Outdoor outdoor);

    /**
     * 删除数据
     */
    int delete(Outdoor outdoor);
}
