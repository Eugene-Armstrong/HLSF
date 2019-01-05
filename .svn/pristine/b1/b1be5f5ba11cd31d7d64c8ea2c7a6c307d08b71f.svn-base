package cn.edu.bnuz.seawas.entity;

import java.util.Date;

/**
 * 相册表Entity
 * Created by sjk on 2017-09-05.
 */
public class Album {

    private String id; //uuid

    private User user; //用户

    private String name;  //相册名称

    private Date createTime;  //创建时间

    private Integer views;  //浏览次数

    private Boolean isExistUnAudit;     //是否存在待审核图片

    public Album() { }

    public Album(String id) {
        this.id = id;
    }

    public Album(User user) {
        this.user = user;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public Boolean getExistUnAudit() {
        return isExistUnAudit;
    }

    public void setExistUnAudit(Boolean existUnAudit) {
        isExistUnAudit = existUnAudit;
    }

    @Override
    public String toString() {
        return "Album{" +
                "id='" + id + '\'' +
                ", user=" + user +
                ", name='" + name + '\'' +
                ", createTime=" + createTime +
                ", views=" + views +
                ", isExistUnAudit=" + isExistUnAudit +
                '}';
    }
}
