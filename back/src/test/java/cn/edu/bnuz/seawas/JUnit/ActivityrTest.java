package cn.edu.bnuz.seawas.JUnit;

import cn.edu.bnuz.seawas.dao.ActivityLeaderMapper;
import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.dao.OrdersMapper;
import cn.edu.bnuz.seawas.dao.UserMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.ActivityLeader;
import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.service.SignService;
import cn.edu.bnuz.seawas.service.admin.ActivityService;
import cn.edu.bnuz.seawas.service.weChat.CalenderService;
import cn.edu.bnuz.seawas.service.weChat.WCommentService;
import cn.edu.bnuz.seawas.service.weChat.WxOrderService;
import cn.edu.bnuz.seawas.service.weChat.index.UserService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityDetailService;
import cn.edu.bnuz.seawas.service.weChat.index.WxActivityService;
import cn.edu.bnuz.seawas.service.weChat.mine.LeaderManageActivityService;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import com.foxinmy.weixin4j.payment.WeixinPayProxy;
import com.foxinmy.weixin4j.util.DateUtil;
import com.google.gson.Gson;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by sjk on 2017-09-20.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/applicationContext-*.xml"})
public class ActivityrTest {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private CalenderService calenderService;

    @Autowired
    private LeaderManageActivityService leaderManageActivityService;

    @Autowired
    private WxOrderService orderService;

//    @Autowired
//    private WeixinPayProxy weixinPayProxy;

    @Autowired
    private UserService userService;

    @Autowired
    private WxActivityService activityService;

    @Autowired
    private WxActivityDetailService activityDetailService;

    @Autowired
    private SignService signService;

    @Autowired
    private ActivityService actService;

    @Autowired
    private WCommentService commentService;

    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private ActivityLeaderMapper activityLeaderMapper;

    @Autowired
    private UserMapper userMapper;

    /*@Test
    public void findAllDepartDateTest() throws Exception {

        List<String> list = activityMapper.findAllDepartDate();

        for (String a : list) {
            System.out.println(a);
        }
    }*/

    /*@Test
    public void findAllActivityDateTest() throws Exception {
        calenderService.findAllActivityDate();
    }*/

    /*@Test
    public void findActivityByDateTest() throws Exception {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = simpleDateFormat.parse("2017-08-13");
        List<Activity> list = activityMapper.findActivityByDate(date);
        for (Activity activity : list) {
            System.out.println("activity>>>>>>>>>>>>>>>>>>>>>>>" + new Gson().toJson(activity));
        }
    }*/

    @Test
    public void findLeaderActivityTest() throws Exception {
        List<LeaderActivityVo> data = leaderManageActivityService.findLeaderActivity(new User("1302dbb5-70a2-437e-9db4-88353eda52c2"));
        for (LeaderActivityVo a : data) {
            System.out.println("data>>>>>>>>>>>>>" + a.toString());
        }
    }

    @Test
    public void test() throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        //查询出已经到了结束时间的活动
//        List<Activity> activityList = activityMapper.findEndTimeActivity(sdf.format(new Date()));
        List<Activity> activityList = actService.findEndTimeActivity("2017-10-28 23:30");

        //遍历活动列表进行相应操作
        for (Activity activity : activityList) {

            //改变活动状态
            activityMapper.changeActivityState(activity.getId(), "已结束");

            //查询本次活动带队的领队
            List<ActivityLeader> activityLeaderList = activityLeaderMapper.findList(new ActivityLeader(activity.getId(), null));
            //更新领队带队次数
            for (ActivityLeader activityLeader : activityLeaderList) {
                userMapper.updateLeaderNum(new User(activityLeader.getLeaderId()));
            }

            //查询本次活动中的订单,且订单状态为已支付
            List<Orders> orderList = ordersMapper.findListByActivityId(activity.getId(), "2");
            //将积分、经验值添加进用户账户
            for (Orders order : orderList) {
                User user = order.getUser();
                user = userMapper.get(user);
                user.setIntegral(user.getIntegral() + DateUtil.formatFee2Yuan(order.getPrice()));
                user.setExperValue(user.getExperValue() + DateUtil.formatFee2Yuan(order.getPrice()));
                userMapper.updateByPrimaryKeySelective(user);
            }
        }
    }
}
