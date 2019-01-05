package cn.edu.bnuz.seawas.entity;

import cn.edu.bnuz.seawas.utils.UUIDUtil;

/**
 * 城市表Entity
 * Created by sjk on 2017-07-28.
 */
public class City {
    private String id;

    private String name; // 城市名称

    private String picUrl; // 城市图片url

    public City() {

    }

    public City(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl == null ? null : picUrl.trim();
    }

    //插入前手动调用
    public void preInsert() {
        this.id = UUIDUtil.createUUID();
    }
}