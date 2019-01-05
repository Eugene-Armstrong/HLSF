package cn.edu.bnuz.seawas.service.admin.totalCount;

import cn.edu.bnuz.seawas.dao.TotalCountMapper;
import cn.edu.bnuz.seawas.dto.TotalCountData;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Product;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.vo.ProductOrderNumVo;
import cn.edu.bnuz.seawas.vo.UserOrderMoneyVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Zhong-Yan on 2017/8/10.
 */
@Service(value = "TotalCountService")
public class TotalCountService {
    @Autowired
    TotalCountMapper totalCountMapper;

    public TotalCountData dataCountInfo(){
        return totalCountMapper.dataCountInfo();
    }

    public PageInfo<User> dataCountUser(Integer pageNum, Integer pageSize){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return  new PageInfo<User>(totalCountMapper.dataCountUser());
    }

    public PageInfo<User> dataCountLeader(Integer pageNum, Integer pageSize){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return  new PageInfo<User>(totalCountMapper.dataCountLeader());
    }
    public PageInfo<Product> dataCountProduct(Integer pageNum, Integer pageSize,City city){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return  new PageInfo<Product>(totalCountMapper.dataCountProduct(city));
    }

    public PageInfo<ProductOrderNumVo> dataCountTotalNum(Integer pageNum, Integer pageSize, City city){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return  new PageInfo<ProductOrderNumVo>(totalCountMapper.dataCountTotalNum(city));
    }

    public PageInfo<UserOrderMoneyVo> dataCountTotalMoney(Integer pageNum, Integer pageSize){
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 1 : pageSize;
        PageHelper.startPage(pageNum, pageSize);
        return  new PageInfo<UserOrderMoneyVo>(totalCountMapper.dataCountTotalMoney());
    }
}
