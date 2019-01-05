package cn.edu.bnuz.seawas.service.weChat.index;

import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wifi on 2017/9/23.
 */
@Service
public class WxActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    /**
     * wifi
     * 通过活动id获取单个活动的信息
     * @param activityId
     * @return
     */
    public Activity getActivityDetail(String activityId){
        return activityMapper.getActivityDetail(activityId);
    }

    /**
     * wifi
     * 更改活动状态
     * @param id
     * @param state
     * @return
     */
    public int changeActivityState(String id,String state){
        return activityMapper.changeActivityState(id,state);
    }

    /**
     * 更改
     */
}
