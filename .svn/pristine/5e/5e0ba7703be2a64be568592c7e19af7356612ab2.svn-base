package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    /**
     * 通过主键查找用户
     * @param id
     * @return 查找用户
     */
    User selectByPrimaryKey(String id);

    /**
     * 通过主键逻辑删除用户
     * @param id
     * @return
     */
    int deleteByPrimaryKey(String id);

    /**
     * 新用户
     * @param record
     * @return
     */
    int insert(User record);

    /**
     * 有选择的新增用户
     * @param record
     * @return
     */
    int insertSelective(User record);

    /**
     * 有选择的更新用户
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(User record);

    /**
     * 更新用户
     * @param record
     * @return
     */
    int updateByPrimaryKey(User record);

    /**
     * 获取单条数据
     */
    User get(User user);

    /**
     * 查找用户列表
     * @param user
     * @return用户列表
     */
    List<User> findList(User user);

    /**
     *查找领队列表
     * @param user
     * @return领队列表
     */
    List<User> findLeaderList(User user);

    /**
     * 获取领队详细信息
     * @param user
     * @return 领队全部信息
     */
    User getLeaderdetail(User user);

    /**
     * 剔除一个领队
     * @param user
     * @return
     */
    int deleteLeader(User user);

    /**
     * 查找可以成为领队的用户
     * @param user
     * @return 返回普通用户
     */
    List<User> findCommUserList(User user);

    /**
     * 提拔普通用户为领队
     * @param user 普通用户信息+工号+初始分数
     */
    int updateUsertoLeader(User user);

    /**
     * wifi
     * 通过openID查找用户信息
     * @param openid
     * @return
     */
    User selectUserByOpenid(@Param("openid") String openid);

    /**
     * 领队带队次数+1
     */
    int updateLeaderNum(User user);

    /**
     * 领队带队次数+1
     */
    int changeLeaderScore(User user);
}