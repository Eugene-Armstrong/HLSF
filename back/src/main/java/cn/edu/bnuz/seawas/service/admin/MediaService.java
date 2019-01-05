package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.MediaMapper;
import cn.edu.bnuz.seawas.dao.ProductMapper;
import cn.edu.bnuz.seawas.entity.Media;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 媒体管理Service
 * Created by sjk on 2017-08-14.
 */
@Service
public class MediaService {

    @Autowired
    private MediaMapper mediaMapper;

    @Autowired
    private ProductMapper productMapper;

    /**
     * 查询城市下的媒体显示信息
     */
    @Transactional(readOnly = true)
    public List<Media> findList(Media media) { return mediaMapper.findList(media); }

    /**
     * 获取可选产品列表
     */
    @Transactional(readOnly = true)
    public List<Product> findProduct(Media media) { return productMapper.findMediaProductList(media); }

    /**
     * 设置媒体管理
     */
    @Transactional(readOnly = false)
    public Condition save(Media data) {

        if (data.getCity() == null || StringUtils.isBlank(data.getCity().getId())) {
            return new Condition(Condition.ERROR_CODE, "请选择城市");
        }

        if (data.getProduct() == null || StringUtils.isBlank(data.getProduct().getId())) {
            return new Condition(Condition.ERROR_CODE, "请选择产品");
        }

        try {
            data.setId(UUIDUtil.createUUID());
            mediaMapper.insert(data);
            return new Condition(Condition.SUCCESS_CODE, "修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }

    /**
     * 删除媒体图
     */
    @Transactional(readOnly = false)
    public Condition delete(Media media) {
        try {
            mediaMapper.delete(media);
            return new Condition(Condition.SUCCESS_CODE, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }
}
