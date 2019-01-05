package cn.edu.bnuz.seawas.entity;

import java.util.Date;

/**
 * 照片表Entity
 * Created by sjk on 2017-07-31.
 */
public class Photo {

    private String id;

    private Album album;

    private String picUrl; // 图片url

    private String state; // 状态

    private Date createTime; // 创建时间

    private Date auditTime; // 审核时间

    private Admin admin; // 审核人

    private Integer likes;   //被赞数量

    public Photo() { }

    public Photo(String id) {
        this.id = id;
    }

    public Photo(Album album) {
        this.album = album;
    }

    public Photo(String id, Album album, String picUrl, String state, Date createTime) {
        this.id = id;
        this.album = album;
        this.picUrl = picUrl;
        this.state = state;
        this.createTime = createTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Album getAlbum() {
        return album;
    }

    public void setAlbum(Album album) {
        this.album = album;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl == null ? null : picUrl.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }

    public Integer getLikes() {
        return likes;
    }

    public void setLikes(Integer likes) {
        this.likes = likes;
    }

    @Override
    public String toString() {
        return "Photo{" +
                "id='" + id + '\'' +
                ", album=" + album +
                ", picUrl='" + picUrl + '\'' +
                ", state='" + state + '\'' +
                ", createTime=" + createTime +
                ", auditTime=" + auditTime +
                ", admin=" + admin +
                ", likes=" + likes +
                '}';
    }
}