package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.Follow;
import org.apache.ibatis.annotations.Param;

public interface FollowMapper {
    int deleteByPrimaryKey(String id);

    int insert(Follow record);

    int insertSelective(Follow record);

    Follow selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Follow record);

    int updateByPrimaryKey(Follow record);

    /*判断是否已关注*/
    int isFollow( @Param("userId")String userId, @Param("followUserId") String followUserId);

    /*获取用户粉丝量*/
    int fansCount(@Param("followUserId") String followUserId);
}