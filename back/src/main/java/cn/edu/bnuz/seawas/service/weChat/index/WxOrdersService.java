package cn.edu.bnuz.seawas.service.weChat.index;

import cn.edu.bnuz.seawas.dao.OrdersMapper;
import cn.edu.bnuz.seawas.entity.Orders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wifi on 2017/9/23.
 */
@Service
public class WxOrdersService {

    @Autowired
    private OrdersMapper ordersMapper;

    /**
     * wifi
     * 获取订单信息
     * @param orders
     * @return
     */
    public Orders getOrdersById(Orders orders){
        return ordersMapper.get(orders);
    }

    /**
     * wifi
     * 通过商户订单号获得订单id
     * @param MerOrderNum
     * @return
     */
    public Orders findOrderIdByMerOrderId(String MerOrderNum){
        String orderId = ordersMapper.findOrderIdByMerOrderNum(MerOrderNum);
        Orders orders = new Orders();
        orders.setId(orderId);
        return ordersMapper.get(orders);
    }
}
