package cn.edu.bnuz.seawas.service.weChat.index;

import cn.edu.bnuz.seawas.dao.UserMapper;
import cn.edu.bnuz.seawas.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wifi on 2017/9/23.
 */
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public int update(User user) throws Exception{
        return userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 通过id查询用户信息
     */
    @Transactional(readOnly = true)
    public User get(User user) { return userMapper.get(user); }
}
