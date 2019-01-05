package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.vo.ActivityDetailsVo;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 活动表DAO接口
 * Created by sjk on 2017-07-28.
 */
public interface ActivityMapper {

    /**
     * wifi
     * 通过活动id获取活动状态
     * @param id
     * @return
     */
    String getActivityStateById(@Param("id") String id);

    /**
     * wifi
     * 更改活动状态
     * @param id 活动id
     * @param state 活动状态
     * @return
     */
    int changeActivityState(@Param("id") String id,@Param("state") String state);

    /**
     * wifi
     * 通过活动id获取单个活动的信息
     * @param activityId
     * @return
     */
    Activity getActivityDetail(@Param("activityId") String activityId);

    /**
     * wifi
     * 通过产品id获取此产品下的所有活动
     * @param activity
     * @return
     */
    List<ActivityDetailsVo> selectActivitiesByProductId(Activity activity);

    /**
     * wifi
     * 通过：活动id-->订单id-->报名人数
     * @param activityId
     * @return
     */
    int getActivitySignNumber(@Param("activityId") String activityId);

    /**
     * wifi
     * 批量删除活动（假删除）
     * @param activities
     * @return
     */
    int deleteActivitiesByActivityId(@Param("activity") List<Activity> activities);

    /**
     * wifi
     * 非空插入
     * @param activity activity
     */
    int insertSelective(Activity activity);

    /**
     * 获取单条数据
     * @param activity activity
     */
    Activity get(Activity activity);

    /**
     * 逻辑删除
     * @param activity activity
     */
    int delete(Activity activity);

    /**
     * 插入数据
     * @param activity activity
     */
    int insert(Activity activity);

    /**
     * 非空更新
     * @param activity activity
     */
    int updateByPrimaryKeySelective(Activity activity);

    /**
     * 更新数据
     * @param activity activity
     */
    int updateByPrimaryKey(@Param("activity") Activity activity);

    /**
     * wifi
     * 发布活动，将未发布改成未成行
     * @param id
     * @return
     */
    int changeActivityType(@Param("id") String id);

    /**
     * 列表查询
     * @param activity activity
     */
    List<Activity> findList(Activity activity);

    /**
     * 领队所带活动查询
     * @param user 领队id
     * @return
     */
    List<LeaderActivityVo> selectActivitiesByLeaderId(User user);


    /**
     * 查询所有活动+领队信息
     * @return
     */
    List<LeaderActivityVo> selectActivitiesWithLeader(@Param("city") String city);
    /**
     * 通过用户id获取用户参与过的活动
     * @param userId
     * @return
     */
    List<Activity> selectActivityByUserId (String userId);

    /**
     * 查询所有活动的出发日期
     * 主要用于微信端的活动日历
     */
    List<String> findAllDepartDate(String cityId);

    /**
     * 查询根据日期查询当天的活动
     */
    List<Activity> findActivityByDate(@Param("date") String date, @Param("cityId") String cityId);

    /**
     * 查找领队带领的活动（不包括已结束和报名时间超过的）
     * @param leaderId
     * @return
     */
    List<Activity> selectActivityByLeader(@Param("leaderId") String leaderId,@Param("city") String city);


    /**
     * 列表查询通过天数
     * @param activity activity
     */
    List<Activity> findListByDays(Activity activity);

    /**
     * 查询已经到了活动结束时间的活动
     * 主要用于计时器
     */
    List<Activity> findEndTimeActivity(String endTime) throws Exception;


}