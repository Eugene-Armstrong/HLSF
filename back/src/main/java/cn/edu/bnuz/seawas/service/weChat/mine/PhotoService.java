package cn.edu.bnuz.seawas.service.weChat.mine;

import cn.edu.bnuz.seawas.dao.AlbumMapper;
import cn.edu.bnuz.seawas.dao.LikeMapper;
import cn.edu.bnuz.seawas.dao.PhotoMapper;
import cn.edu.bnuz.seawas.entity.Album;
import cn.edu.bnuz.seawas.entity.Like;
import cn.edu.bnuz.seawas.entity.Photo;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import cn.edu.bnuz.seawas.vo.wechat.PhotoVo;
import com.foxinmy.weixin4j.model.media.MediaDownloadResult;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.foxinmy.weixin4j.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 微信端相片操作Service
 * Created by sjk on 2017-09-05.
 */
@Service
public class PhotoService {

    @Autowired
    private PhotoMapper photoMapper;

    @Autowired
    private AlbumMapper albumMapper;

    @Autowired
    private LikeMapper likeMapper;

    @Autowired
    private WeixinProxy weixinProxy;

    /**
     * 查看相册图片
     */
    @Transactional(readOnly = true)
    public List<PhotoVo> findList(Photo photo, HttpServletRequest request) {

        HttpSession session = request.getSession();

        //获取当前登陆的用户信息
        User currentLoginUser = (User) session.getAttribute("userInfo");

        List<PhotoVo> photoVoList = new ArrayList<>();

        //只查询审核通过的图片
        photo.setState("2");

        List<Photo> photoList = photoMapper.findList(photo);

        for (int i = 0; i < photoList.size(); i++) {

            photoVoList.add(i, new PhotoVo());

            //获取图片信息
            photoVoList.get(i).setPhoto(photoList.get(i));

            //判断是否已经点赞
            if (likeMapper.getByUserAndPhoto(new Like(currentLoginUser, photoList.get(i))) != null) {
                photoVoList.get(i).setLike(true);
            } else {
                photoVoList.get(i).setLike(false);
            }
        }

        return photoVoList;
    }

    /**
     * 删除图片
     */
    @Transactional(readOnly = false)
    public void deletePhoto(Photo photo) throws Exception {

        //获取图片信息
        photo = photoMapper.get(photo);

        //删除服务器上的图片
        if (StringUtil.isNotBlank(photo.getPicUrl())) {
            File file = new File(PropertiesUtil.getProperty("photo.realPath") + photo.getPicUrl());
            if (file.exists() && file.isFile()) {
                file.delete();
            }
        }

        //删除数据库中的数据
        photoMapper.delete(photo);
    }

    /**
     * 批量上传图片
     * @param album 相册信息
     * @param mediaIds 需要下载的图片的mediaId
     * @return 上传结果
     */
    @Transactional(readOnly = false)
    public Condition uploadPhoto(Album album, String[] mediaIds) {

        //数据校验
        if (mediaIds == null) {
            return new Condition(Condition.NOTFOUND_CODE, "请选择图片");
        }
        if (mediaIds.length == 0) {
            return new Condition(Condition.NOTFOUND_CODE, "请选择图片");
        }

        MediaDownloadResult downloadResult;

        try {
            //获取相册详细信息
            album = albumMapper.get(album);

            for (String mediaId : mediaIds) {

                FileOutputStream fileOutputStream = null;
                BufferedOutputStream bufferedOutputStream = null;

                try {

                    //从微信服务器下载图片
                    downloadResult = weixinProxy.downloadMedia(mediaId, false);

                    //重命名上传的图片
                    String newPicName = UUIDUtil.createUUID() + "_" + System.currentTimeMillis() + downloadResult.getFileName().substring(downloadResult.getFileName().lastIndexOf("."));

                    //上传图片
                    fileOutputStream = new FileOutputStream(PropertiesUtil.getProperty("photo.realPath") + newPicName);
                    bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
                    bufferedOutputStream.write(downloadResult.getContent());

                    //保存进数据库
                    photoMapper.insert(new Photo(UUIDUtil.createUUID(), album, newPicName, "1", new Date()));

                } catch (Exception e) {

                    e.printStackTrace();

                    return new Condition(Condition.ERROR_CODE, "系统繁忙");

                } finally {

                    if (bufferedOutputStream != null) {
                        bufferedOutputStream.close();
                    }
                    if (fileOutputStream != null) {
                        fileOutputStream.close();
                    }
                }
            }

            return new Condition(Condition.SUCCESS_CODE, "上传成功");

        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }

    /**
     * 用户点赞
     */
    @Transactional(readOnly = false)
    public Condition like(Photo photo, User user) {
        try {
            //更新相册表
            photoMapper.getLike(photo);
            //更新点赞表
            likeMapper.insert(new Like(UUIDUtil.createUUID(), user, photo, new Date()));

            return new Condition(Condition.SUCCESS_CODE, "成功");
        } catch (Exception e) {
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }
}
