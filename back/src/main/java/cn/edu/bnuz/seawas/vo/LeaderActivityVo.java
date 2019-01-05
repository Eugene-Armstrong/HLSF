package cn.edu.bnuz.seawas.vo;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.User;

/**
 * Created by Zrj on 2017/8/18.
 */
public class LeaderActivityVo extends Activity{
    String pro_name;
    private int signNumber;

    User leader;

    public int getSignNumber() {
        return signNumber;
    }

    public void setSignNumber(int signNumber) {
        this.signNumber = signNumber;
    }

    public String getPro_name() {
        return pro_name;
    }

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    public User getLeader() {
        return leader;
    }

    public void setLeader(User leader) {
        this.leader = leader;
    }

    @Override
    public String toString() {
        return "LeaderActivityVo{" +
                "pro_name='" + pro_name + '\'' +
                ", signNumber=" + signNumber +
                '}';
    }
}
