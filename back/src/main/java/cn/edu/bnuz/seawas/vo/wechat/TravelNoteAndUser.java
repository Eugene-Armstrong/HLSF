package cn.edu.bnuz.seawas.vo.wechat;

import cn.edu.bnuz.seawas.entity.TravelNote;
import cn.edu.bnuz.seawas.entity.User;

/**
 * Created by Zrj on 2017/11/23.
 */
public class TravelNoteAndUser extends TravelNote{
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
