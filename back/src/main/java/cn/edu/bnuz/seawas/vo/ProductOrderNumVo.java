package cn.edu.bnuz.seawas.vo;

import cn.edu.bnuz.seawas.entity.Product;

/**
 * Created by Zrj on 2017/10/6.
 */
public class ProductOrderNumVo extends Product {
    int vol;
    int volPrice;

    public int getVol() {
        return vol;
    }

    public void setVol(int vol) {
        this.vol = vol;
    }

    public int getVolPrice() {
        return volPrice;
    }

    public void setVolPrice(int volPrice) {
        this.volPrice = volPrice;
    }
}
