package cn.edu.bnuz.seawas.service.weChat.index;

import cn.edu.bnuz.seawas.dao.FollowMapper;
import cn.edu.bnuz.seawas.entity.Follow;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.apache.http.impl.conn.SystemDefaultDnsResolver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 *领队信息Service
 * Created by tomviss on 2017/9/20.
 */
@Service
public class LeaderMsgService {
    @Autowired
    private FollowMapper followMapper;

    /*加关注*/
    public int addFollow(String userId,String followUserId){
        int count = followMapper.isFollow(userId, followUserId);
        if(count == 1){
            return -1;//已关注 提醒不能重复关注
        }
        else {
            Follow follow = new Follow();
            follow.setId(UUIDUtil.createUUID());
            follow.setId(userId);
            follow.setFollowUserId(followUserId);
            follow.setCreateTime(new Date());
            return followMapper.insert(follow);
        }
    }

    /*判断是否已关注*/
    public  int isFollow(String userId,String followUserId){
        int count = followMapper.isFollow(userId,followUserId);
        System.out.println("count"+userId+" "+followUserId+" "+count);
        if(count==1){
            return 1;
        }
        else return 0;
    }

    /*统计粉丝数量*/
    public int fansCount(String followUserId){
        int count = followMapper.fansCount(followUserId);
        return count;
    }
}
