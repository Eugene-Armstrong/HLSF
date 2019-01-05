package cn.edu.bnuz.seawas.service.weChat.index;

import cn.edu.bnuz.seawas.dao.WxActivityDetailMapper;
import cn.edu.bnuz.seawas.entity.CollectionActivity;
import cn.edu.bnuz.seawas.entity.Contact;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.vo.WxActivityVo;
import cn.edu.bnuz.seawas.vo.WxProductDetailVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wifi on 2017/9/1.
 */
@Service
public class WxActivityDetailService {

    @Autowired
    private WxActivityDetailMapper wxActivityDetailMapper;

    /**
     * wifi
     * 获取产品下有几个正在运作的活动
     * @param productId
     * @return
     */
    public int getWxActivityNumber(String productId,String cityId){
        return wxActivityDetailMapper.getWxActivityNumber(productId,cityId);
    }

    /**
     * wifi
     * 微信获取产品信息
     * @param productId
     * @return
     */
    public WxProductDetailVo getWxProductDetails(String productId){
        return wxActivityDetailMapper.getWxProductDetails(productId);
    }

    /**
     * wifi
     * 微信获取产品详情--->购买界面
     * @return
     */
    public WxProductDetailVo getWxProductActivitiesDetails(String productId,String cityId){
        int count = 0;
        WxProductDetailVo wxProductDetailVo = wxActivityDetailMapper.getWxProductActivitiesDetails(productId,cityId);
        // 通过活动id获取此活动已报名的人数
        if (wxProductDetailVo.getActivityVoList().size() > 0){
            for (WxActivityVo wxActivityVo : wxProductDetailVo.getActivityVoList()){
                int total = wxActivityDetailMapper.getSignNumber(wxActivityVo.getId()) + wxActivityVo.getActivityLeaderList().size();
                wxProductDetailVo.getActivityVoList().get(count).setNum(total);
                count++;
            }
        }
        return wxProductDetailVo;
    }

    /**
     * wifi
     * 微信获取获得单个产品-单个活动-多个领队信息--->购买确认界面
     * @param productId
     * @param activityId
     * @return
     */
    public WxProductDetailVo getWxProductActivityDetails(String productId,String activityId) throws Exception{
        WxProductDetailVo wxProductDetailVo = wxActivityDetailMapper.getWxProductActivityDetails(productId,activityId);
        // 通过活动id获取此活动已报名的人数
        int total = wxActivityDetailMapper.getSignNumber(wxProductDetailVo.getActivityVoList().get(0).getId()) + wxProductDetailVo.getActivityVoList().get(0).getActivityLeaderList().size();
        wxProductDetailVo.getActivityVoList().get(0).setNum(total);
        return wxProductDetailVo;
    }

    /**
     * wifi
     * 获取活动已报名的用户信息
      * @param activityId
     * @return
     */
    public List<User> getWxParticipantsUsers(String activityId){
        return wxActivityDetailMapper.getWxParticipantsUsers(activityId);
    }

    /**
     * wifi
     * 通过活动id获得带队的领队信息
     * @param activityId
     * @return
     */
    public List<User> getWxParticipantsLeaders(String activityId){
        return wxActivityDetailMapper.getWxParticipantsLeaders(activityId);
    }

    /**
     * wifi
     * 通过openId获得用户的常用人信息
     * @param openId
     * @return
     */
    public List<Contact> getWxUsersContacts(String openId){
        return wxActivityDetailMapper.getWxUsersContacts(openId);
    }

    /**
     * wifi
     * 浏览产品->产品浏览次数加一
     * @param productId
     */
    public void updateProductReadNumber(String productId){
        wxActivityDetailMapper.updateProductReadNumber(productId);
    }

    /**
     * wifi
     * 浏览产品获取用户是否收藏
     * @param openId
     * @param productId
     * @return
     */
    public int getCollectionType(String openId,String productId){
        return wxActivityDetailMapper.getCollectionType(openId,productId);
    }

    /**
     * wifi
     * 收藏产品
     * @param collectionActivity
     * @return
     */
    public int changeCollectionTypeTrue(CollectionActivity collectionActivity){
        return wxActivityDetailMapper.changeCollectionTypeTrue(collectionActivity);
    }

    /**
     * wifi
     * 取消收藏产品
     * @param userId
     * @param productId
     * @return
     */
    public int changeCollectionTypeFalse(String userId,String productId){
        return wxActivityDetailMapper.changeCollectionTypeFalse(userId,productId);
    }


}
