package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.*;
import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.vo.ActivityDetailsVo;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wifi on 2017/8/4.
 */
@Service
public class ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private PromotionMapper promotionMapper;

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ActivityLeaderMapper activityLeaderMapper;

    @Autowired
    private CalendarMapper calendarMapper;

    /**
     * wifi
     * 通过产品id获得此产品下的所有活动详情 + 分页
     * @param pageNum
     * @param pageSize
     * @param activity
     * @return
     */
    public PageInfo<ActivityDetailsVo> selectActivitiesByProductId(Integer pageNum, Integer pageSize, Activity activity){
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<ActivityDetailsVo> activityPageInfo = new PageInfo<ActivityDetailsVo>(activityMapper.selectActivitiesByProductId(activity));

        // 获得每个活动已报名人数
        for (ActivityDetailsVo activityDetailsVo : activityPageInfo.getList()){
            // 通过：活动id-->订单id-->报名人数
            int signNum = activityMapper.getActivitySignNumber(activityDetailsVo.getId());
            activityPageInfo.getList().get(count).setSignNumber(signNum);
            count++;
        }
        return activityPageInfo;
    }

    /**
     * wifi
     * 通过活动id获得所有信息 + 获得创建活动、更改活动的完整信息
     * @param activity
     * @return
     */
    public Activity getActivityMessage(Activity activity){
        Activity act = activityMapper.get(activity);
        // 分别活动创建者和修改者的详细信息
        if (act.getCreateUser() != null && !"".equals(act.getCreateUser())){
            Admin admin = adminMapper.selectUsersByPrimaryKey(act.getCreateUser().getId());
            act.setCreateUser(admin);
        }
        if (act.getUpdateUser() != null && !"".equals(act.getUpdateUser())){
            Admin admin1 = adminMapper.selectUsersByPrimaryKey(act.getUpdateUser().getId());
            act.setUpdateUser(admin1);
        }
        return act;
    }

    /**
     * wifi
     * 通过活动id假删除活动
     * @param idSelected
     * @return
     */
    public int deleteActivityMessage(String idSelected){
        // 将传过来的字符串分解开
        String[] Str = idSelected.split(",");
        int result = 1;
        List<Activity> activityList = new ArrayList<Activity>();
        for (String s : Str){
            Activity activity = new Activity();
            activity.setId(s);
            activityList.add(activity);
        }
        // 多项删除
        result = activityMapper.deleteActivitiesByActivityId(activityList);
        return result;
    }

    /**
     * wifi
     * 获得所有优惠规则
     * @return
     */
    public List<Promotion> selectPromotions(){
        return promotionMapper.selectPromotions();
    }

    /**
     * wifi
     * 添加活动
     * @param activity
     * @return
     */
    public int addActivity(Activity activity){
        return activityMapper.insertSelective(activity);
    }

    /**
     * wifi
     * 通过优惠规则的id获取信息
     * @param proId
     * @return
     */
    public Promotion selectPromotionByPrimaryKey(String proId){
        return promotionMapper.selectByPrimaryKey(proId);
    }

    /**
     * wifi
     * 获得所有领队信息
     * @param user
     * @return
     */
    public List<User> findLeaderList(User user){
        return userMapper.findLeaderList(user);
    }

    /**
     * wifi
     * 添加领队
     * @param activityLeader
     * @return
     */
    public int insertLeader(ActivityLeader activityLeader){
        return activityLeaderMapper.insertLeader(activityLeader);
    }

    /**
     * wifi
     * 通过活动id获得此活动的所有信息
     * 用于修改活动
     * @param activity
     * @return
     */
    public Activity getActivitiesAndLeadersByActivityId(Activity activity){
        // 获得所选的活动
        Activity activity1 = activityMapper.get(activity);
        // 获得所选活动的领队信息
        List<ActivityLeader> activityLeaderList = calendarMapper.selectActivitiesDetailsTwoStep(activity1.getId());
        activity1.setActivityLeaderList(activityLeaderList);
        return activity1;
    }

    /**
     * wifi
     * 添加活动富文本
     * @param activity
     * @return
     */
    public Condition updateActivityUeditor(Activity activity){
        try {
            activityMapper.updateByPrimaryKeySelective(activity);
            return new Condition(Condition.SUCCESS_CODE,"添加成功");
        }catch (Exception e){
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE,"添加失败");
        }
    }

    /**
     * wifi
     * 修改活动信息
     * @param activity
     * @return
     */
    public int updateByPrimaryKeySelective(Activity activity){
        return activityMapper.updateByPrimaryKeySelective(activity);
    }

    /**
     * wifi
     * 批量删除领队
     * @param activityId
     * @return
     */
    public int deleteLeadersById(String activityId){
        return activityLeaderMapper.deleteByPrimaryKey(activityId);
    }

    PageInfo<LeaderActivityVo> selectActivitiesByLeaderId(User user, Integer pageNum, Integer pageSize){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<LeaderActivityVo> activityPageInfo = new PageInfo<LeaderActivityVo>(activityMapper.selectActivitiesByLeaderId(user));
        return activityPageInfo;
    }

    /**
     * 领队带领的活动（不包括超过报名时间的和已经结束的）
     * @param leaderId
     * @return
     */
    public  List<Activity> selectActivityByLeader(String leaderId,String city){
        return activityMapper.selectActivityByLeader(leaderId,city);
    }

    /**
     * wifi
     * 通过活动id获取活动状态
     * @param id
     * @return
     */
    public String getActivityStateById(String id){
        return activityMapper.getActivityStateById(id);
    }

    /**
     *
     * 通过用户id获取用户参与过的活动
     * @param pageNum
     * @param pageSize
     * @param userId
     * @return
     */
    public PageInfo<Activity> findActivityPageByUser(Integer pageNum, Integer pageSize,String userId){
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<Activity> activityPageInfo = new PageInfo<Activity>(activityMapper.selectActivityByUserId(userId));
        return activityPageInfo;
    }

    /**
     * 查询所有活动+领队信息
     * @return
     */
   public List<LeaderActivityVo> selectActivitiesWithLeader(String city){
     return activityMapper.selectActivitiesWithLeader(city);
    }

    /**
     * 通过活动结束时间查找活动
     */
    public List<Activity> findEndTimeActivity(String endTime) throws Exception {
        return activityMapper.findEndTimeActivity(endTime);
    }

    /**
     * wifi
     * 发布活动，将未发布改成未成行
     * @param activity
     * @return
     */
    public int changeActivityType(String activity){
        return activityMapper.changeActivityType(activity);
    }
}
