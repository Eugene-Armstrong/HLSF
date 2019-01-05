package cn.edu.bnuz.seawas.entity;

import java.util.Date;

/**
 * 订单表Entity
 * Created by sjk on 2017-07-28.
 */
public class Orders {
    private String id;

    private Activity activity; // 活动表

    private User user; // 用户

    private Admin admin; // 审核人

    private String state; // 订单状态

    private Integer price; // 订单金额

    private Date createTime; // 订单创建时间

    private String payment; // 支付方式

    private String message; // 订单状态返回给用户的信息

    private String number; // 订单号

    private Date auditTime; // 审核时间

    private String remark; // 备注

    private String equipment;   //装备信息

    private City city;  //出发城市

    private String merOrderNumber; // 商户订单号

    private String merRefundNumber; // 商户退款订单号

    private Integer refundPrice; // 退款金额

    private String wechatOrderNum; // 微信支付订单号

    private Date payTime;   //支付时间

    private Double integral;    //订单积分

    private Date applyRefundTime;   //申请退款时间

    private String delFlag = "0"; // 删除标记

    private Date beginDate;		// 开始日期

    private Date endDate;		// 结束日期

    private String isComment = "0"; //是否评论

    private String wechatRefundNumber;  //微信退款单号

    private String gatherPlace; // 集合地点

    public String getGatherPlace() {
        return gatherPlace;
    }

    public void setGatherPlace(String gatherPlace) {
        this.gatherPlace = gatherPlace;
    }

    public String getIsComment() {
        return isComment;
    }

    public void setIsComment(String isComment) {
        this.isComment = isComment;
    }

    public Orders() { }

    public Orders(String id) {
        this.id = id;
    }

    public Orders(String merOrderNumber, String state) {
        this.merOrderNumber = merOrderNumber;
        this.state = state;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment == null ? null : payment.trim();
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message == null ? null : message.trim();
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number == null ? null : number.trim();
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag == null ? null : delFlag.trim();
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getEquipment() {
        return equipment;
    }

    public void setEquipment(String equipment) {
        this.equipment = equipment;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public String getMerOrderNumber() {
        return merOrderNumber;
    }

    public void setMerOrderNumber(String merOrderNumber) {
        this.merOrderNumber = merOrderNumber;
    }

    public String getMerRefundNumber() {
        return merRefundNumber;
    }

    public void setMerRefundNumber(String merRefundNumber) {
        this.merRefundNumber = merRefundNumber;
    }

    public Integer getRefundPrice() {
        return refundPrice;
    }

    public void setRefundPrice(Integer refundPrice) {
        this.refundPrice = refundPrice;
    }

    public String getWechatOrderNum() {
        return wechatOrderNum;
    }

    public void setWechatOrderNum(String wechatOrderNum) {
        this.wechatOrderNum = wechatOrderNum;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public Double getIntegral() {
        return integral;
    }

    public void setIntegral(Double integral) {
        this.integral = integral;
    }

    public Date getApplyRefundTime() {
        return applyRefundTime;
    }

    public void setApplyRefundTime(Date applyRefundTime) {
        this.applyRefundTime = applyRefundTime;
    }

    public String getWechatRefundNumber() {
        return wechatRefundNumber;
    }

    public void setWechatRefundNumber(String wechatRefundNumber) {
        this.wechatRefundNumber = wechatRefundNumber;
    }
}