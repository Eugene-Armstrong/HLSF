package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Album;

import java.util.List;

/**
 * 相册表DAO接口
 * Created by sjk on 2017-09-05.
 */
public interface AlbumMapper {

    /**
     * 添加数据
     */
    int insert(Album album);

    /**
     * 列表查询
     */
    List<Album> findList(Album album);

    /**
     * 删除数据
     */
    int delete(Album album);

    /**
     * 修改相册名
     */
    int updateAlbumName(Album album);

    /**
     * 获取单条数据
     */
    Album get(Album album);

    /**
     * 添加一次访问量
     */
    int addViews(Album album);
}
