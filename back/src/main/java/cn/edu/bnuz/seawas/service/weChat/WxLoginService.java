package cn.edu.bnuz.seawas.service.weChat;

import cn.edu.bnuz.seawas.dao.UserMapper;
import cn.edu.bnuz.seawas.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wifi on 2017/8/15.
 */
@Service
public class WxLoginService {
    @Autowired
    private UserMapper userMapper;

    /**
     * wifi
     * 通过openID查找用户信息
     * @param openid
     * @return
     */
    public User selectUserByOpenid(String openid){
        return userMapper.selectUserByOpenid(openid);
    }

    /**
     * wifi
     * 添加新用户
     * @param user
     * @return
     */
    public int insertSelective(User user){
        return userMapper.insertSelective(user);
    }

    /**
     * 更新用户信息
     */
    public int updateSelective(User user) { return userMapper.updateByPrimaryKeySelective(user); }
}
