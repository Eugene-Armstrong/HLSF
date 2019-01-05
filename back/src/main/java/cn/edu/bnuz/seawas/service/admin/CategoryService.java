package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.ClassificationMapper;
import cn.edu.bnuz.seawas.dao.ClassificationProductMapper;
import cn.edu.bnuz.seawas.entity.Classification;
import cn.edu.bnuz.seawas.entity.ClassificationProduct;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.PropertiesUtil;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

/**
 * 分类管理Service
 * Created by sjk on 2017-07-31.
 */
@Service
public class CategoryService {

    @Autowired
    private ClassificationMapper classificationMapper;

    @Autowired
    private ClassificationProductMapper classificationProductMapper;

    /**
     * 查询分类列表
     */
    @Transactional(readOnly = true)
    public List<Classification> findList() { return classificationMapper.findList(new Classification()); }

    /**
     * 删除分类
     */
    @Transactional(readOnly = false)
    public Condition delete(Classification classification) {
        try {
            //数据校验
            if (StringUtils.isBlank(classification.getId())) {
                return new Condition(Condition.ERROR_CODE, "请选择要删除的分类");
            }

            //删除图片
            Classification temp = classificationMapper.get(classification);
            File file = new File(PropertiesUtil.getProperty("sort.realPath") + temp.getPicUrl());
            if (!file.isFile() && !file.exists()) {
                return new Condition(Condition.ERROR_CODE, "系统繁忙");
            } else {
                //删除文件
                if (file.delete()) {
                    //删除分类表的数据
                    classificationMapper.delete(classification);
                    //删除分类产品表的数据
                    classificationProductMapper.deleteByClassId(classification.getId());
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

    /**
     * 添加新的分类
     */
    @Transactional(readOnly = false)
    public Condition save(Classification classification, MultipartFile pic) {
        try {
            //数据校验
            if (StringUtils.isBlank(classification.getName()) || StringUtils.isBlank(pic.getOriginalFilename())) {
                return new Condition(Condition.ERROR_CODE, "请填写分类信息");
            }

            //重命名上传的图片
            String newFileName = UUIDUtil.createUUID() + pic.getOriginalFilename().substring(pic.getOriginalFilename().lastIndexOf("."));

            //上传图片
            File file = new File(PropertiesUtil.getProperty("sort.realPath") + newFileName);
            if (!file.exists()) {
                file.mkdirs();
            }
            pic.transferTo(file);

            //保存数据库
            classification.setId(UUIDUtil.createUUID());
            classification.setPicUrl(newFileName);
            classificationMapper.insert(classification);

            return new Condition(Condition.SUCCESS_CODE, "添加成功");

        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }
    /**
     * 为产品设置分类
     */
    public void addProductSort(String[] sorts,String productId){
        ClassificationProduct classificationProduct = new ClassificationProduct();
        Classification classification = new Classification();
        Product product = new Product();
        for (int i = 0;i < sorts.length;i++){
            classification.setId(sorts[i]);
            product.setId(productId);
            classificationProduct.setProduct(product);
            classificationProduct.setClassification(classification);
            classificationProduct.setId(UUIDUtil.createUUID());
            classificationProductMapper.insertSelective(classificationProduct);
        }

    }
}
