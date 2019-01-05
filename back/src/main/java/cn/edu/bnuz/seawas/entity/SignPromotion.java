package cn.edu.bnuz.seawas.entity;

/**
 * 报名--优惠表
 */
public class SignPromotion {
    private String id;

    private String signUserID; // 报名人id

    private String promotionId; // 优惠id

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getSignUserID() {
        return signUserID;
    }

    public void setSignUserID(String signUserID) {
        this.signUserID = signUserID == null ? null : signUserID.trim();
    }

    public String getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(String promotionId) {
        this.promotionId = promotionId == null ? null : promotionId.trim();
    }
}