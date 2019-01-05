package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.CalendarMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.ActivityLeader;
import cn.edu.bnuz.seawas.entity.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wifi on 2017/8/8.
 */
@Service
public class CalendarService {
    @Autowired
    private CalendarMapper calendarMapper;

    /**
     * wifi
     * 活动日历获得活动详情
     * 根据日期获得活动信息
     * @param pageNum 当前页
     * @param pageSize 每页数量
     * @param date
     * @return
     */
    public PageInfo<Activity> selectActivitiesDetailsPage(Integer pageNum,Integer pageSize,String date){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<Activity> activityPageInfo = new PageInfo<Activity>(calendarMapper.selectActivitiesDetailsOneStep(date));
        return activityPageInfo;
    }

    /**
     * wifi
     * 活动id获得领队信息
     * @param activityId
     * @return
     */
    public List<ActivityLeader> selectActivitiesDetailsTwoStep(String activityId){
        return calendarMapper.selectActivitiesDetailsTwoStep(activityId);
    }
}
