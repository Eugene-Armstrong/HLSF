package cn.edu.bnuz.seawas.utils;

import cn.edu.bnuz.seawas.dao.ActivityMapper;
import cn.edu.bnuz.seawas.dao.FollowMapper;
import cn.edu.bnuz.seawas.dao.ProductCommentMapper;
import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.User;
import cn.edu.bnuz.seawas.vo.LeaderActivityVo;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import org.apache.commons.lang3.StringUtils;

import java.util.List;


/**
 * 自定义工具类
 * Created by tomviss on 2017/7/24.
 */
public class TagUtils {

    private  static WeixinProxy weixinProxy = new WeixinProxy();
    private  static ProductCommentMapper productCommentMapper = SpringContextHolder.getBean(ProductCommentMapper.class);
    private  static ActivityMapper activityMapper = SpringContextHolder.getBean(ActivityMapper.class);
    private  static FollowMapper followMapper =SpringContextHolder.getBean(FollowMapper.class);
    /**
     * 判断评论是否已被管理员回复
     * @param id
     * @return
     */
    public static boolean isReplyByMng(String id){
        if(StringUtils.isNotBlank(id) && productCommentMapper.isReply(id) != null){
            return true;
        }
        else  return false;

    }

    /**
     * state数字转文字
     * @param state
     * @return
     */
    public static String travelNoteState(String state){
        if (StringUtils.isNotBlank(state)){
            if (state.equals("0")){
                return "未审核";
            }
            else if(state.equals("1")){
                return "审核通过";
            }
            else if(state.equals("2")){
                return "审核不通过";
            }
        }
        return "";
    }

    /**
     * 获取领队带领的所有活动
     * (用于领队信息显示)
     * @param leaderId
     * @return
     */
    public static List<Activity> getActivityFromLeader(String leaderId,String city){
        if (leaderId!=null){
            return activityMapper.selectActivityByLeader(leaderId,city);
        }
       return null;
    }

    /**
     * 长链接转短链接
     */
    public static String longToShort(String url)throws WeixinException {
        return weixinProxy.getShorturl(url);
    }
}
