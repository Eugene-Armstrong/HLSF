package cn.edu.bnuz.seawas.service.weChat.index;

import cn.edu.bnuz.seawas.dao.EquipOrdersMapper;
import cn.edu.bnuz.seawas.entity.EquipOrders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wifi on 2017/9/21.
 */
@Service
public class EquipOrdersService {

    @Autowired
    private EquipOrdersMapper equipOrdersMapper;

    /**
     * wifi
     * 批量添加订单装备
     * @param equipOrders
     * @return
     */
    public int insertList(List<EquipOrders> equipOrders){
        return equipOrdersMapper.insertList(equipOrders);
    }
}
