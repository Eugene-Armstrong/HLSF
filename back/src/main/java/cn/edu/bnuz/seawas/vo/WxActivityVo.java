package cn.edu.bnuz.seawas.vo;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.ActivityLeader;
import cn.edu.bnuz.seawas.entity.Sign;

import java.util.List;

/**
 * Created by wifi on 2017/9/1.
 */
public class WxActivityVo extends Activity{
    private List<Sign> signList; // 活动对应的报名人
    //private List<ActivityLeader> activityLeaderList; // 活动对应的领队
    private int num; // 已报名人数 = 领队数 + 报名人数

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<Sign> getSignList() {
        return signList;
    }

    public void setSignList(List<Sign> signList) {
        this.signList = signList;
    }
}
