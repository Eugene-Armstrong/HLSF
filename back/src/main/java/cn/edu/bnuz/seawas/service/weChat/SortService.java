package cn.edu.bnuz.seawas.service.weChat;

import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.dao.ProductMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.utils.DateUtils;
import cn.edu.bnuz.seawas.vo.ProductVo;
import cn.edu.bnuz.seawas.vo.wechat.ProductAndActivityVo;
import cn.edu.bnuz.seawas.vo.wechat.ProductForSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Zrj on 2017/9/19.
 * 更多分类相关Service
 */

@Service
public class SortService {
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private ProductMapper productMapper;

    /**
     * 通过分类进入更多分类
     * @param productVo
     * @return
     */
    public List<ProductAndActivityVo> showSecondPageInfoBySort(ProductVo productVo) {
        //通过城市和分类查找到相应产品
        List<ProductVo> productVoList = productMapper.findAllProductBySort(productVo);
        List<ProductAndActivityVo> productAndActivityVoList = new ArrayList<>();

        productAndActivityVoList = getProductAndActivityVoList(productVoList,productVo.getCityId());

        return productAndActivityVoList;
    }

    /**
     * 通过难度进入更多分类
     * @param productVo
     * @return
     */
    public List<ProductAndActivityVo> showSecondPageInfoByDiff(ProductVo productVo) {
        //通过城市和难度查找到相应产品
        List<ProductVo> productVoList = productMapper.findAllProductByDiff(productVo);
        List<ProductAndActivityVo> productAndActivityVoList = new ArrayList<>();

        productAndActivityVoList = getProductAndActivityVoList(productVoList,productVo.getCityId());

        return productAndActivityVoList;
    }

    /**
     * 通过天数进入更多分类
     * @param productVo
     * @return
     */
    public List<ProductAndActivityVo> showSecondPageInfoByDay(ProductVo productVo) {
        //通过城市和难度查找到相应产品
        List<ProductVo> productVoList = productMapper.findAllProductBySort(productVo);
        List<ProductAndActivityVo> productAndActivityVoList = new ArrayList<>();

        int k = 0;
        for (int i = 0; (i + k) < productVoList.size(); i++) {
            Activity searchKey = new Activity();
            //筛选产品下的活动
            searchKey.setProduct(productVoList.get(i + k));
            searchKey.setCity(productVo.getCityId());

            //筛选在当前时间之后出发的活动
            searchKey.setDepartTime(new Date());
            searchKey.setDays(productVo.getDays());
            //获取产品下的活动
            List<Activity> activities = activityMapper.findListByDays(searchKey);
            if (activities.size() == 0) {
                k++;
                i--;
            } else {
                //计算活动天数
                for (Activity activity : activities) {
                    activity.setDays(DateUtils.daysBetween(activity.getDepartTime(), activity.getEndTime()) + 1);
                }
                productAndActivityVoList.add(i, new ProductAndActivityVo());

                //设置产品信息
                productAndActivityVoList.get(i).setProduct(productVoList.get(i + k));

                //设置活动信息
                productAndActivityVoList.get(i).setActivities(activities);

            }
        }
        return productAndActivityVoList;
    }



    /**
     * 通过目的地进入更多分类
     * @param productVo
     * @return
     */
    public List<ProductForSort> showSecondPageInfoByDist(ProductVo productVo) {
        //通过城市和难度查找到相应产品
        List<ProductForSort> productAndActivityVoList = productMapper.findAllProductByDist(productVo);
        return productAndActivityVoList;
    }


    //重构的方法
    private List<ProductAndActivityVo> getProductAndActivityVoList(List<ProductVo> productVoList,String cityId){
        List<ProductAndActivityVo> productAndActivityVoList = new ArrayList<>();
        int k = 0;
        for (int i = 0; (i + k) < productVoList.size(); i++) {
            Activity searchKey = new Activity();
            //筛选产品下的活动
            searchKey.setProduct(productVoList.get(i + k));

            //筛选在当前时间之后出发的活动
            searchKey.setDepartTime(new Date());
            searchKey.setCity(cityId);

            //获取产品下的活动
            List<Activity> activities = activityMapper.findList(searchKey);
            if (activities.size() == 0) {
                k++;
                i--;
            } else {
                //计算活动天数
                for (Activity activity : activities) {
                    activity.setDays(DateUtils.daysBetween(activity.getDepartTime(), activity.getEndTime()) + 1);
                }
                productAndActivityVoList.add(i, new ProductAndActivityVo());

                //设置产品信息
                productAndActivityVoList.get(i).setProduct(productVoList.get(i + k));

                //设置活动信息
                productAndActivityVoList.get(i).setActivities(activities);

            }
        }
        return productAndActivityVoList;
    }

}
