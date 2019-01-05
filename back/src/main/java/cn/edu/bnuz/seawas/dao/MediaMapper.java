package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Media;

import java.util.List;

/**
 * 媒体管理表DAO接口
 * Created by sjk on 2017-08-14.
 */
public interface MediaMapper {

    /**
     * 删除数据
     */
    int delete(Media media);

    /**
     * 插入数据
     */
    int insert(Media media);

    /**
     * 获取单条数据
     */
    Media get(Media media);

    /**
     * 更新数据
     */
    int update(Media media);

    /**
     * 列表查询
     */
    List<Media> findList(Media media);
}
