package cn.edu.bnuz.seawas.service.weChat;

import cn.edu.bnuz.seawas.dao.*;
import cn.edu.bnuz.seawas.entity.*;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import cn.edu.bnuz.seawas.vo.ChangeProductGrade;
import cn.edu.bnuz.seawas.vo.ProductCommentVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Zrj on 2017/9/24.
 */
@Service
public class WCommentService {
    @Autowired
    private ProductCommentMapper productCommentMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private OrdersMapper ordersMapper;
    @Autowired
    private ActivityLeaderMapper activityLeaderMapper;
    @Autowired
    private LeaderScoreMapper leaderScoreMapper;

    public PageInfo<ProductComment> selectAllPCSelective(Integer pageNum, Integer pageSize,ProductComment productComment){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        List<ProductComment> productCommentList = productCommentMapper.selectAllSelective(productComment);
        for (int i = 0; i < productCommentList.size(); i++) {
            User user = new User();
            user.setId(productCommentList.get(i).getUserId());
            user = userMapper.get(user);
            productCommentList.get(i).setUser(user);
            Activity activity = new Activity();
            activity.setId(productCommentList.get(i).getActivityId());
            activity = activityMapper.get(activity);
            productCommentList.get(i).setActivity(activity);
        }
        return new PageInfo<ProductComment>(productCommentList);
    }

    public Orders getOrder(Orders orders){
        return ordersMapper.get(orders);
    }

    public int insertSelective(ProductComment record){
        return productCommentMapper.insertSelective(record);
    }

    public int addLeaderScore(String userId,String activityId,int Score){
        ActivityLeader activityLeader = new ActivityLeader();
        activityLeader.setActivityId(activityId);
        List<ActivityLeader> activityLeaderList = activityLeaderMapper.findList(activityLeader);
        for (ActivityLeader act:
             activityLeaderList) {
            LeaderScore leaderScore = new LeaderScore();
            leaderScore.setId(UUIDUtil.createUUID());
            leaderScore.setActivityId(activityId);
            leaderScore.setCreateTime(new Date());
            leaderScore.setLeaderId(act.getLeaderId());
            leaderScore.setGrade(Score);
            leaderScore.setUserId(userId);
            leaderScoreMapper.insertSelective(leaderScore);

            User user = new User();
            user.setId(act.getLeaderId());
            userMapper.changeLeaderScore(user);

        }
        return  1;
    }

    public ProductComment selectByUserIdAndActId(ProductComment productComment){
        return productCommentMapper.selectByUserIdAndActId(productComment);
    }

    public int updateProductScore(ChangeProductGrade changeProductGrade){
        return productCommentMapper.updateProductScore(changeProductGrade);
    }
}
