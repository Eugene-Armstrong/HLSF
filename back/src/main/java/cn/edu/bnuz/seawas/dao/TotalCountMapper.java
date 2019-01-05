package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.dto.TotalCountData;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.vo.ProductOrderNumVo;
import cn.edu.bnuz.seawas.vo.UserOrderMoneyVo;

import java.util.List;

/**
 * Created by Zhong-Yan on 2017/8/9.
 */
public interface TotalCountMapper {
    TotalCountData dataCountInfo();

    List<User> dataCountUser();

    List<User> dataCountLeader();

    List<Product> dataCountProduct(City city);

    List<ProductOrderNumVo> dataCountTotalNum(City city);

    List<UserOrderMoneyVo> dataCountTotalMoney();

}
