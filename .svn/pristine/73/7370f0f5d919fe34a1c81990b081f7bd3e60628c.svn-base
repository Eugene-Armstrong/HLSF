package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Album;
import cn.edu.bnuz.seawas.entity.Photo;
import cn.edu.bnuz.seawas.entity.User;

import java.util.List;

/**
 * 照片表DAO接口
 * Created by sjk on 2017-07-31.
 */
public interface PhotoMapper {

    /**
     * 删除数据
     * @param photo photo
     */
    int delete(Photo photo);

    /**
     * 插入数据
     * @param photo photo
     */
    int insert(Photo photo);

    /**
     * 非空插入
     * @param photo photo
     */
    int insertSelective(Photo photo);

    /**
     * 获取单条数据
     * @param photo photo
     */
    Photo get(Photo photo);

    /**
     * 非空更新
     * @param photo photo
     */
    int updateByPrimaryKeySelective(Photo photo);

    /**
     * 更新数据
     * @param photo photo
     */
    int update(Photo photo);

    /**
     * 列表查询
     * @param photo photo
     */
    List<Photo> findList(Photo photo);

    /**
     * 查找上传过图片的所有用户
     */
    List<User> findAllUser(Photo photo);

    /**
     * 查询某相册中的图片数量
     */
    Integer countPhotoNumByAlbum(String albumId);

    /**
     * 查找相册中最新的一张图片
     */
    Photo getLatestPhoto(String albumId);

    /**
     * 删除某相册下的所有图片
     */
    int deleteByAlbum(Album album);

    /**
     * 点赞
     */
    int getLike(Photo photo);

    /**
     * 查询相册中待审核图片数量
     */
    int countUnAudit(Album album);

    /**
     * 计算所有待审核图片数量
     */
    Integer countUncheck();
}