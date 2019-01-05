package cn.edu.bnuz.seawas.entity;

import java.util.Date;

public class Appreciation {
    private String id;

    private String userId;

    private String travelnoteId;

    private Date appreciatdTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getTravelnoteId() {
        return travelnoteId;
    }

    public void setTravelnoteId(String travelnoteId) {
        this.travelnoteId = travelnoteId == null ? null : travelnoteId.trim();
    }

    public Date getAppreciatdTime() {
        return appreciatdTime;
    }

    public void setAppreciatdTime(Date appreciatdTime) {
        this.appreciatdTime = appreciatdTime;
    }
}