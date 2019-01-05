package cn.edu.bnuz.seawas.service.admin.user;


import cn.edu.bnuz.seawas.dao.UserMapper;
import cn.edu.bnuz.seawas.entity.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Zhong-Yan on 2017/7/21.
 */
@Service(value = "UserService")
public class UserService {
    @Autowired
    private UserMapper userMapper;

    /**
     * 查找可以成为领队的用户
     * @param user
     * @return 返回普通用户
     */
    public List<User> findCommUserList(User user){
        return userMapper.findCommUserList(user);
    }

    /**
     * 查询非领队用户列表：分页
     * @param pageNum 当前页
     * @param pageSize 每页的数量
     * @param user 查询条件
     */
    public PageInfo<User> showCommUserPage(Integer pageNum, Integer pageSize, User user) {
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<User>(userMapper.findCommUserList(user));
    }

    /**
     * 提拔普通用户为领队
     * @param user 普通用户信息+工号+初始分数
     */
    public int updateUsertoLeader(User user){
            return  userMapper.updateUsertoLeader(user);
    }


    public int updateByPrimaryKeySelective(User record){
        return  userMapper.updateByPrimaryKeySelective(record);
    }

    /**
     * 获取用户列表+分页
     * @param user
     * @return
     */
    public PageInfo<User> findUsersPage(Integer pageNum, Integer pageSize,User user){
        int count = 0;
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 10 : pageSize;
        PageHelper.startPage(pageNum,pageSize);
        PageInfo<User> userPageInfo = new PageInfo<User>(userMapper.findList(user));

        return userPageInfo;
    }

}
