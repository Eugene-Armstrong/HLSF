package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.ActivityLeader;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ActivityLeaderMapper {
    /**
     * wifi
     * 添加领队
     * @param record
     * @return
     */
    int insertLeader(ActivityLeader record);

    /**
     * wifi
     * 删除领队
     * @param actId
     * @return
     */
    int deleteByPrimaryKey(String actId);

    int insertSelective(ActivityLeader record);

    ActivityLeader selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ActivityLeader record);

    int updateByPrimaryKey(ActivityLeader record);

    List<ActivityLeader> findList(ActivityLeader activityLeader);

    /**
     * 查询领队带队活动
     * 剔除已下架的产品
     */
    List<LeaderActivityVo> selectActivitiesByLeaderId(User user);
}