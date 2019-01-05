package cn.edu.bnuz.seawas.entity;

/**
 * 领队--活动表
 */
public class ActivityLeader {
    private String id;

    private String activityId; // 活动表id

    private String leaderId; // 领队id

    private User user;

    public ActivityLeader() { }

    public ActivityLeader(String id) { this.id = id; }

    public ActivityLeader(String activityId, String leaderId) {
        this.activityId = activityId;
        this.leaderId = leaderId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId == null ? null : activityId.trim();
    }

    public String getLeaderId() {
        return leaderId;
    }

    public void setLeaderId(String leaderId) {
        this.leaderId = leaderId == null ? null : leaderId.trim();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "ActivityLeader{" +
                "id='" + id + '\'' +
                ", activityId='" + activityId + '\'' +
                ", leaderId='" + leaderId + '\'' +
                ", user=" + user +
                '}';
    }
}