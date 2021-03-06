package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.OutdoorMapper;
import cn.edu.bnuz.seawas.entity.Outdoor;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import com.foxinmy.weixin4j.util.StringUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Date;
import java.util.List;

/**
 * PC端户外学堂Service
 * Created by sjk on 2017-11-24.
 */
@Service("PCOutdoorService")
public class OutdoorService {

    @Autowired
    private OutdoorMapper outdoorMapper;

    /**
     * 获取单条数据
     */
    @Transactional(readOnly = true)
    public Outdoor get(Outdoor outdoor) throws Exception {
        return outdoorMapper.get(outdoor);
    }

    /**
     * 列表查询+分页
     */
    @Transactional(readOnly = true)
    public PageInfo<Outdoor> findList(Integer pageNum, Integer pageSize, Outdoor outdoor) throws Exception {
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<>(outdoorMapper.findList(outdoor));
    }

    /**
     * 列表查询+无分页wechat用
     */
    public List<Outdoor> wechatfindList(Outdoor outdoor) throws Exception {
        return outdoorMapper.findList(outdoor);
    }
    /**
     * 添加推送
     */
    @Transactional(readOnly = false)
    public Condition add(Outdoor outdoor, MultipartFile pic) throws Exception {
        //数据校验
        if (StringUtil.isBlank(outdoor.getTitle())) {
            return new Condition(Condition.ERROR_CODE, "请填写标题");
        }
        if (StringUtil.isBlank(outdoor.getWebURL())) {
            return new Condition(Condition.ERROR_CODE, "请填写链接");
        }

        //重命名上传的图片
        String newFileName = UUIDUtil.createUUID() + pic.getOriginalFilename().substring(pic.getOriginalFilename().lastIndexOf("."));

        //上传图片
        File file = new File(PropertiesUtil.getProperty("Outdoor.realPath") + newFileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        pic.transferTo(file);

        //存进数据库
        outdoor.setId(UUIDUtil.createUUID());
        outdoor.setPic(newFileName);
        outdoor.setCreateTime(new Date());
        outdoorMapper.insert(outdoor);

        return new Condition(Condition.SUCCESS_CODE, "添加成功");
    }

    /**
     * 修改推送
     */
    @Transactional(readOnly = false)
    public Condition update(Outdoor outdoor, MultipartFile pic) throws Exception {

        //数据校验
        if (StringUtil.isBlank(outdoor.getTitle())) {
            return new Condition(Condition.ERROR_CODE, "请填写标题");
        }
        if (StringUtil.isBlank(outdoor.getWebURL())) {
            return new Condition(Condition.ERROR_CODE, "请填写链接");
        }

        if (pic != null && StringUtil.isNotBlank(pic.getOriginalFilename())) {
            //获取更新前的数据
            Outdoor oldData = outdoorMapper.get(outdoor);
            //删除之前的图片
            if (StringUtil.isNotBlank(oldData.getPic())) {
                File temp = new File(PropertiesUtil.getProperty("Outdoor.realPath") + oldData.getPic());
                if (temp.exists() && temp.isFile()) {
                    temp.delete();
                }
            }

            //重命名上传的图片
            String newFileName = UUIDUtil.createUUID() + pic.getOriginalFilename().substring(pic.getOriginalFilename().lastIndexOf("."));

            //上传图片
            File file = new File(PropertiesUtil.getProperty("Outdoor.realPath") + newFileName);
            if (!file.exists()) {
                file.mkdirs();
            }
            pic.transferTo(file);

            outdoor.setPic(newFileName);
        }

        outdoorMapper.update(outdoor);

        return new Condition(Condition.SUCCESS_CODE, "更新成功");
    }

    /**
     * 删除推送
     */
    @Transactional(readOnly = false)
    public Condition delete(Outdoor outdoor) throws Exception {
        outdoor = this.get(outdoor);
        if (StringUtil.isNotBlank(outdoor.getPic())) {
            File file = new File(PropertiesUtil.getProperty("Outdoor.realPath") + outdoor.getPic());
            if (file.exists() && file.isFile()) {
                file.delete();
            }
        }
        outdoorMapper.delete(outdoor);
        return new Condition(Condition.SUCCESS_CODE, "删除成功");
    }
}
