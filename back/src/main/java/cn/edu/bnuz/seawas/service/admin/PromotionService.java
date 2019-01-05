package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.PromotionMapper;
import cn.edu.bnuz.seawas.entity.Promotion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wifi on 2017/7/28.
 */
@Service
public class PromotionService {

    @Autowired
    private PromotionMapper promotionMapper;

    /**
     * wifi
     * 获取优惠规则
     * @return
     */
    public List<Promotion> selectPromotions(){
        return promotionMapper.selectPromotions();
    }

    /**
     * wifi
     * 删除优惠规则
     */
    public int deleteByPrimaryKey(String id){
        return promotionMapper.deleteByPrimaryKey(id);
    }

    /**
     * wifi
     * 添加优惠规则
     */
    public int insertSelective(Promotion promotion){
        return promotionMapper.insertSelective(promotion);
    }
}
