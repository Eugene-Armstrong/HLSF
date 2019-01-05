package cn.edu.bnuz.seawas.service.weChat.mine;

import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.dao.OrdersMapper;
import cn.edu.bnuz.seawas.dao.ProductMapper;
import cn.edu.bnuz.seawas.dao.UserMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.Orders;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.entity.User;
import com.foxinmy.weixin4j.payment.mch.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Zrj on 2017/9/1.
 */
@Service
public class MineService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private  ProductMapper productMapper;
    @Autowired
    private OrdersMapper ordersMapper;

    //获取到用户详细信息
    public User getUserinfo(String id){
        return userMapper.selectByPrimaryKey(id);
    }

    //获取用户参与的所有活动
    public List<Activity> selectActivityByUserId(String userId){
     return activityMapper.selectActivityByUserId(userId);
    }

    //获取用户收藏的所有产品
    public List<Product> selectProductByUserId(String userId){
        return productMapper.selectProductByUserId(userId);
    }

    //获取用户的所有订单
    public List<Orders> findOrdersByUserId(String userId){
       return ordersMapper.findListByUserId(userId);
    }
}
