package cn.edu.bnuz.seawas.vo;

import cn.edu.bnuz.seawas.entity.Product;

/**
 * Created by zrj on 2017/7/25.
 */
public class ProductVo extends Product {
    private String searchtxt; //查找文本

    private String cityId;

    private String classId;

    private Integer days;   //活动天数

    private String media;   //媒体管理中相应的位置

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public String getSearchtxt() {
        return searchtxt;
    }

    public void setSearchtxt(String searchtxt) {
        this.searchtxt = searchtxt;
    }

    public String getCityId() {
        return cityId;
    }

    public void setCityId(String cityId) {
        this.cityId = cityId;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }
}
