package cn.edu.bnuz.seawas.vo.wechat;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.Product;

import java.util.List;

/**
 * Created by Zrj on 2017/11/20.
 */
public class ProductForSort extends Product{
    private List<Activity> activities;

    public List<Activity> getActivities() {
        return activities;
    }

    public void setActivities(List<Activity> activities) {
        this.activities = activities;
    }
}
