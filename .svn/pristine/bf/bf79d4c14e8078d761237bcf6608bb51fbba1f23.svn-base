package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.ActivityLeader;
import cn.edu.bnuz.seawas.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wifi on 2017/8/8.
 */
public interface CalendarMapper {

    /**
     * wifi
     * 活动日历获得活动详情
     * @return
     */
    List<Activity> selectActivitiesDetailsOneStep(@Param("date") String date);

    /**
     * wifi
     * 活动id查询领队
     * @param activity
     * @return
     */
    List<ActivityLeader> selectActivitiesDetailsTwoStep(@Param("activityId") String activityId);

}
