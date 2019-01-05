package cn.edu.bnuz.seawas.service;

import cn.edu.bnuz.seawas.dao.PromotionMapper;
import cn.edu.bnuz.seawas.dao.SignMapper;
import cn.edu.bnuz.seawas.dao.SignPromotionMapper;
import cn.edu.bnuz.seawas.entity.Sign;
import cn.edu.bnuz.seawas.entity.SignPromotion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 通用报名表操作Service
 * Created by sjk on 2017-09-24.
 */
@Service("sysSignService")
public class SignService {

    @Autowired
    private SignMapper signMapper;

    @Autowired
    private SignPromotionMapper signPromotionMapper;

    @Autowired
    private PromotionMapper promotionMapper;

    /**
     * 统计某订单中报名人数
     */
    @Transactional(readOnly = true)
    public Integer countSign(String orderId) throws Exception {
        return signMapper.countNumByOrderId(orderId);
    }

    /**
     * 删除数据
     */
    @Transactional(readOnly = false)
    public void deleteByOrder(String orderId) throws Exception { signMapper.deleteByOrder(orderId); }

    /**
     * 获取订单中的报名信息
     */
    @Transactional(readOnly = true)
    public List<Sign> findSignByOrder(String orderId) throws Exception {

        //获取报名信息
        List<Sign> signs = signMapper.findSignByOrder(orderId);

        //遍历报名信息，查找优惠信息
        for (Sign sign : signs) {

            //获取报名人与优惠表关系
            SignPromotion signPromotion = signPromotionMapper.getBySignId(sign.getId());
            if (signPromotion != null) {
                sign.setPromotion(promotionMapper.selectByPrimaryKey(signPromotion.getPromotionId()));
            }
        }

        return signs;
    }
}
