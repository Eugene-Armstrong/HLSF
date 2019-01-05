package cn.edu.bnuz.seawas.service.weChat;

import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * 微信端活动日历Service
 * Created by sjk on 2017-09-20.
 */
@Service
public class CalenderService {

    @Autowired
    private ActivityMapper activityMapper;

    /**
     * 查询有活动的日期
     */
    @Transactional(readOnly = true)
    public List<String> findAllActivityDate(String cityId) {
        return activityMapper.findAllDepartDate(cityId);
    }

    /**
     * 根据日期查询当天的所有活动
     */
    @Transactional(readOnly = true)
    public List<Activity> findActivityByDate(String date, String cityId) throws Exception {
        return activityMapper.findActivityByDate(date, cityId);
    }
}
