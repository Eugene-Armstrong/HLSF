package cn.edu.bnuz.seawas.service.weChat.index;

import cn.edu.bnuz.seawas.dao.SignPromotionMapper;
import cn.edu.bnuz.seawas.entity.SignPromotion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wifi on 2017/9/23.
 */
@Service
public class SignPromotionService {

    @Autowired
    private SignPromotionMapper signPromotionMapper;

    /**
     * wifi
     * 添加报名人使用的优惠详情
     * @param signPromotion
     * @return
     */
    public int insert(SignPromotion signPromotion){
        return signPromotionMapper.insert(signPromotion);
    }
}
