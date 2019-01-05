package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.TravelComment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TravelCommentMapper {
    int deleteByPrimaryKey(String id);

    int insert(TravelComment record);

    int insertSelective(TravelComment record);

    TravelComment selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TravelComment record);

    int updateByPrimaryKey(TravelComment record);
    /*条件查询*/
    List<TravelComment> selectAllSelective(TravelComment travelComment);

    /*批量删除游记评论*/
    int deleteJourneyComments(@Param("comments") List<TravelComment> comments);//@param是必须的
}