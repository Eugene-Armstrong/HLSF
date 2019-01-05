package cn.edu.bnuz.seawas.service.weChat.index;

import cn.edu.bnuz.seawas.dao.SignMapper;
import cn.edu.bnuz.seawas.entity.Sign;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wifi on 2017/9/23.
 */
@Service
public class SignService {

    @Autowired
    private SignMapper signMapper;

    /**
     * wifi
     * 添加报名人
     * @param sign
     * @return
     */
    public int insert(Sign sign){
        return signMapper.insert(sign);
    }
}
