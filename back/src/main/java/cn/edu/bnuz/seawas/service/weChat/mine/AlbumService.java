package cn.edu.bnuz.seawas.service.weChat.mine;

import cn.edu.bnuz.seawas.dao.AlbumMapper;
import cn.edu.bnuz.seawas.dao.PhotoMapper;
import cn.edu.bnuz.seawas.dao.UserMapper;
import cn.edu.bnuz.seawas.entity.Album;
import cn.edu.bnuz.seawas.entity.Photo;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import cn.edu.bnuz.seawas.vo.wechat.AlbumVo;
import com.foxinmy.weixin4j.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 微信端相册操作Service
 * Created by sjk on 2017-09-05.
 */
@Service
public class AlbumService {

    @Autowired
    private AlbumMapper albumMapper;

    @Autowired
    private PhotoMapper photoMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 添加相册
     */
    @Transactional(readOnly = false)
    public Condition<Album> addAlbum(Album album) {
        try {
            album.setId(UUIDUtil.createUUID());
            album.setCreateTime(new Date());
            albumMapper.insert(album);
            return new Condition<>(Condition.SUCCESS_CODE, "创建成功", album);
        } catch (Exception e) {
            e.printStackTrace();
            return new Condition<>(Condition.ERROR_CODE, "系统繁忙", null);
        }
    }

    /**
     * 删除相册
     */
    @Transactional(readOnly = false)
    public Condition deleteAlbum(Album album) {
        try {

            //查询相册中的所有图片
            List<Photo> photos = photoMapper.findList(new Photo(album));

            //删除服务器上的图片
            for (Photo photo : photos) {
                if (StringUtil.isNotBlank(photo.getPicUrl())) {
                    File file = new File(PropertiesUtil.getProperty("photo.realPath") + photo.getPicUrl());
                    if (file.exists() && file.isFile()) {
                        file.delete();
                    }
                }
            }

            //删除照片表中的数据
            photoMapper.deleteByAlbum(album);

            //删除相册表中的数据
            albumMapper.delete(album);

            return new Condition(Condition.SUCCESS_CODE, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }

    /**
     * 修改相册名称
     */
    @Transactional(readOnly = false)
    public Condition updateName(Album album) {
        try {
            albumMapper.updateAlbumName(album);
            return new Condition(Condition.SUCCESS_CODE, "修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }

    /**
     * 显示用户的所有相册、每个相册的图片数量
     */
    @Transactional(readOnly = true)
    public List<AlbumVo> findList(Album album) {

        List<AlbumVo> albumVoList = new ArrayList<AlbumVo>();

        //找出该用户的所有相册
        List<Album> albumList = albumMapper.findList(album);

        for (int i = 0; i < albumList.size(); i++) {

            albumVoList.add(i, new AlbumVo());

            //设置相册信息
            albumVoList.get(i).setAlbum(albumList.get(i));

            //计算相册当中的图片数量
            albumVoList.get(i).setPhotoCount(photoMapper.countPhotoNumByAlbum(albumList.get(i).getId()));

            //查找最新的一张图片
            albumVoList.get(i).setLatestPhoto(photoMapper.getLatestPhoto(albumList.get(i).getId()));
        }

        return albumVoList;
    }

    /**
     * 获取单个相册信息
     */
    @Transactional(readOnly = true)
    public Album get(Album album) {
        Album result = albumMapper.get(album);
        result.setUser(userMapper.get(result.getUser()));
        return result;
    }

    /**
     * 增加一次访问量
     */
    @Transactional(readOnly = true)
    public void addViews(Album album) { albumMapper.addViews(album); }
}
