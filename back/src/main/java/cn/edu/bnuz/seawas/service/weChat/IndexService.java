package cn.edu.bnuz.seawas.service.weChat;

import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.dao.MediaMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.Media;
import cn.edu.bnuz.seawas.utils.DateUtils;
import cn.edu.bnuz.seawas.vo.wechat.ProductAndActivityVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 微信端首页展示Service
 * Created by sjk on 2017-08-31.
 */
@Service
public class IndexService {

    @Autowired
    private MediaMapper mediaMapper;

    @Autowired
    private ActivityMapper activityMapper;

    /**
     * 显示首页信息
     * @param cityId 城市id
     * @return media列表
     */
    @Transactional(readOnly = true)
    public List<Media> index(String cityId) {
        try {
            Media media = new Media();
            media.setCity(new City(cityId));

            return mediaMapper.findList(media);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 查找首页的二级页面
     * 查询产品和活动列表
     */
    @Transactional(readOnly = true)
    public List<ProductAndActivityVo> showSecondPageInfo(Media media) {

        //查询二级页面里面的所有产品
        List<Media> mediaList = mediaMapper.findList(media);

        List<ProductAndActivityVo> productAndActivityVoList = new ArrayList<>();

        productAndActivityVoList = getProductAndActivityVoList(mediaList,media.getCity().getId());

        return productAndActivityVoList;
    }

    private List<ProductAndActivityVo> getProductAndActivityVoList(List<Media> mediaList,String cityId){
        List<ProductAndActivityVo> productAndActivityVoList = new ArrayList<>();
        int k = 0;
        for (int i = 0; (i + k) < mediaList.size(); i++) {
            Activity searchKey = new Activity();
            //筛选产品下的活动
            searchKey.setProduct(mediaList.get(i + k).getProduct());

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
                productAndActivityVoList.get(i).setProduct(mediaList.get(i + k).getProduct());

                //设置活动信息
                productAndActivityVoList.get(i).setActivities(activities);
            }
        }
        return productAndActivityVoList;
    }
}
