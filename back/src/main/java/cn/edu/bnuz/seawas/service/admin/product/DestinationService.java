package cn.edu.bnuz.seawas.service.admin.product;

import cn.edu.bnuz.seawas.dao.DestinationMapper;
import cn.edu.bnuz.seawas.entity.Destination;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

/**
 * Created by Zrj on 2017/11/5.
 */
@Service(value = "DestinationService")
public class DestinationService {
    @Autowired
    DestinationMapper destinationMapper;

    /**
     * 查询目的地列表
     * @return 目的地列表
     */
    public List<Destination> findList() {
        return destinationMapper.findList();
    }

    /**
     * 添加目的地
     */
    public Condition addNewDestination(Destination destination, MultipartFile pic){
        try {
            //数据校验
            if (StringUtils.isBlank(destination.getName()) || StringUtils.isBlank(pic.getOriginalFilename())) {
                return new Condition(Condition.ERROR_CODE, "请填写分类信息");
            }

            //重命名上传的图片
            String newFileName = UUIDUtil.createUUID().toString() + pic.getOriginalFilename().substring(pic.getOriginalFilename().lastIndexOf("."));

            //上传图片
            File file = new File(PropertiesUtil.getProperty("dist.realPath") + newFileName);
            if (!file.exists()) {
                file.mkdirs();
            }
            pic.transferTo(file);

            //保存数据库
            destination.setId(UUIDUtil.createUUID());
            destination.setPicUrl(newFileName);
            destinationMapper.insertSelective(destination);

            return new Condition(Condition.SUCCESS_CODE, "添加成功");

        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }

    /**
     * 删除目的地
     */
    public Condition delete(Destination destination) {
        try {
            //数据校验
            if (StringUtils.isBlank(destination.getId())) {
                return new Condition(Condition.ERROR_CODE, "请选择要删除的分类");
            }

            //删除图片
            Destination temp = destinationMapper.selectByPrimaryKey(destination.getId());
            File file = new File(PropertiesUtil.getProperty("dist.realPath") + temp.getPicUrl());
            if (!file.isFile() && !file.exists()) {
                return new Condition(Condition.ERROR_CODE, "系统繁忙");
            } else {
                //删除文件
                if (file.delete()) {
                    //删除分类表的数据
                    destinationMapper.deleteByPrimaryKey(destination.getId());
                    //删除分类产品表的数据
                    return new Condition(Condition.SUCCESS_CODE, "删除分类成功");
                } else {
                    return new Condition(Condition.ERROR_CODE, "系统繁忙");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }
}
