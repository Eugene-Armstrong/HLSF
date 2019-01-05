package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Custom;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 定制表DAO接口
 * Created by sjk on 2017-07-28.
 */
public interface CustomMapper {

    /**
     * 逻辑删除
     * @param custom custom
     */
    int delete(Custom custom);

    /**
     * 插入数据
     * @param custom custom
     */
    int insert(Custom custom);

    /**
     * 非空插入
     * @param custom custom
     */
    int insertSelective(Custom custom);

    /**
     * 获取单条数据
     * @param custom custom
     */
    Custom get(Custom custom);

    /**
     * 非空更新
     * @param custom custom
     */
    int updateByPrimaryKeySelective(Custom custom);

    /**
     * 更新数据
     * @param custom custom
     */
    int update(Custom custom);

    /**
     * 列表查询
     * @param custom custom
     */
    List<Custom> findList(Custom custom);

    /**
     * 条件查询
     * @param custom
     * @return
     */
    List<Custom> selectCustomSelective(Custom custom);

    /*批量删除*/
    int deleteCustoms(@Param("customs") List<Custom> customs);
}