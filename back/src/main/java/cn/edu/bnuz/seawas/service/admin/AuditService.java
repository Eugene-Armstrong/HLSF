package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.AlbumMapper;
import cn.edu.bnuz.seawas.dao.PhotoMapper;
import cn.edu.bnuz.seawas.entity.Admin;
import cn.edu.bnuz.seawas.entity.Album;
import cn.edu.bnuz.seawas.entity.Photo;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.List;

/**
 * 管理员端审核Service
 * Created by sjk on 2017-07-31.
 */
@Service
public class AuditService {

    @Autowired
    private PhotoMapper photoMapper;

    @Autowired
    private AlbumMapper albumMapper;

    /**
     * 显示上传过照片的用户：分页
     * 根据审核状态查询
     */
    @Transactional(readOnly = true)
    public PageInfo<User> showPhotoUserPage(Integer pageNum, Integer pageSize, Photo photo) {
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<User>(photoMapper.findAllUser(photo));
    }

    /**
     * 查看用户名下的相册
     */
    @Transactional(readOnly = true)
    public PageInfo<Album> showAlbumPage(Integer pageNum, Integer pageSize, Album album) {

        //配置分页
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);

        //查询相册
        List<Album> albumList = albumMapper.findList(album);

        //遍历相册，相册中是否存在待审核的图片
        for (Album albumInfo : albumList) {

            Integer unAuditCount = photoMapper.countUnAudit(albumInfo);

            if (unAuditCount > 0) {
                albumInfo.setExistUnAudit(true);
            } else {
                albumInfo.setExistUnAudit(false);
            }
        }

        //设置分页

        return new PageInfo<>(albumList);
    }

    /**
     * 根据用户查询该用户上传的图片
     */
    @Transactional(readOnly = true)
    public List<Photo> findPhotoByAlbum(Photo photo) { return photoMapper.findList(photo); }

    /**
     * 审核照片
     */
    @Transactional
    public void auditPhoto(Photo photo, HttpServletRequest request, String state) throws Exception {

        //如果审核通过
        if ("2".equals(state)) {
            //更新数据库
            photo.setState("2");
            photo.setAuditTime(new Date());
            photo.setAdmin((Admin) request.getSession().getAttribute("admin"));
            photoMapper.updateByPrimaryKeySelective(photo);
        }

        //如果审核不通过
        if ("1".equals(state)) {
            //获取图片路径
            String filePath = PropertiesUtil.getProperty("photo.realPath") + photoMapper.get(photo).getPicUrl();

            //删除文件
            File file = new File(filePath);
            if (file.exists() && file.isFile()) {
                if (file.delete()) {
                    //数据库操作
                    photoMapper.delete(photo);
                }
            }
        }
    }

    /**
     * 查询是否存在待审核的照片
     */
    @Transactional(readOnly = true)
    public Boolean isExistUncheckPhoto() throws Exception {
        Integer count = photoMapper.countUncheck();
        return count != 0;
    }
}
