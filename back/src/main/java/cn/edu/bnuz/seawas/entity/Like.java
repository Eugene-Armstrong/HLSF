package cn.edu.bnuz.seawas.entity;

import java.util.Date;

/**
 * 点赞表Entity
 * Created by sjk on 2017-09-08.
 */
public class Like {

    private String id;

    private User user;  //点赞的用户

    private Photo photo;    //被赞的图片

    private Date createTime;    //点赞时间

    public Like() { }

    public Like(String id) {
        this.id = id;
    }

    public Like(User user, Photo photo) {
        this.user = user;
        this.photo = photo;
    }

    public Like(String id, User user, Photo photo, Date createTime) {
        this.id = id;
        this.user = user;
        this.photo = photo;
        this.createTime = createTime;
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

    public Photo getPhoto() {
        return photo;
    }

    public void setPhoto(Photo photo) {
        this.photo = photo;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Like{" +
                "id='" + id + '\'' +
                ", user=" + user +
                ", photo=" + photo +
                ", createTime=" + createTime +
                '}';
    }
}
