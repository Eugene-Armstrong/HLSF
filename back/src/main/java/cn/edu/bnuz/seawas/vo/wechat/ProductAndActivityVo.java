package cn.edu.bnuz.seawas.vo.wechat;

import cn.edu.bnuz.seawas.entity.Activity;
import cn.edu.bnuz.seawas.entity.Product;

import java.util.List;

/**
 * Created by sjk on 2017-09-10.
 */
public class ProductAndActivityVo {

    private Product product;    //产品

    private List<Activity> activities;      //活动列表

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public void setActivities(List<Activity> activities) {
        this.activities = activities;
    }

    @Override
    public String toString() {
        return "ProductAndActivityVo{" +
                "product=" + product +
                ", activities=" + activities +
                '}';
    }
}
