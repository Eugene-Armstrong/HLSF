package cn.edu.bnuz.seawas.entity;

import cn.edu.bnuz.seawas.utils.UUIDUtil;

import java.util.Date;
import java.util.List;

/**
 * 活动表
 * Created by sjk on 2017-07-28.
 */
public class Activity {

    private String id;

    private Product product; // 产品

    private Integer price; // 产品价格

    private Date departTime; // 出发时间

    private String gatherPlace; // 集合地点

    private Integer tripNumber; // 成行人数

    private Integer totalNumber; // 参与总人数

    private String state; // 活动状态

    private String QRCode; // 活动群二维码

    private Date createTime; // 创建时间

    private Admin createUser; // 创建者

    private Date updateTime; // 活动修改时间

    private Admin updateUser; // 活动修改者

    private Date endTime; // 活动结束时间

    private Date closeTime; // 活动截止报名时间

    private Integer onSalePrice; // 活动优惠价格

    private String discountRules; // 活动优惠规则

    private String priceIntroduce; // 费用说明

    private String route; // 活动行程

    private String productIntroduce; // 活动介绍

    private String delFlag = "0"; // 删除标记

    private Integer days;   //活动天数

    private String city; // 活动城市

    private List<ActivityLeader> activityLeaderList;

    public Activity() { }

    public Activity(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Admin getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Admin createUser) {
        this.createUser = createUser;
    }

    public Admin getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(Admin updateUser) {
        this.updateUser = updateUser;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Date getDepartTime() {
        return departTime;
    }

    public void setDepartTime(Date departTime) {
        this.departTime = departTime;
    }

    public String getGatherPlace() {
        return gatherPlace;
    }

    public void setGatherPlace(String gatherPlace) {
        this.gatherPlace = gatherPlace == null ? null : gatherPlace.trim();
    }

    public Integer getTripNumber() {
        return tripNumber;
    }

    public void setTripNumber(Integer tripNumber) {
        this.tripNumber = tripNumber;
    }

    public Integer getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(Integer totalNumber) {
        this.totalNumber = totalNumber;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getQRCode() {
        return QRCode;
    }

    public void setQRCode(String QRCode) {
        this.QRCode = QRCode == null ? null : QRCode.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Date closeTime) {
        this.closeTime = closeTime;
    }

    public Integer getOnSalePrice() {
        return onSalePrice;
    }

    public void setOnSalePrice(Integer onSalePrice) {
        this.onSalePrice = onSalePrice;
    }

    public String getDiscountRules() {
        return discountRules;
    }

    public void setDiscountRules(String discountRules) {
        this.discountRules = discountRules == null ? null : discountRules.trim();
    }

    public String getPriceIntroduce() {
        return priceIntroduce;
    }

    public void setPriceIntroduce(String priceIntroduce) {
        this.priceIntroduce = priceIntroduce == null ? null : priceIntroduce.trim();
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route == null ? null : route.trim();
    }

    public String getProductIntroduce() {
        return productIntroduce;
    }

    public void setProductIntroduce(String productIntroduce) {
        this.productIntroduce = productIntroduce == null ? null : productIntroduce.trim();
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag == null ? null : delFlag.trim();
    }

    public List<ActivityLeader> getActivityLeaderList() {
        return activityLeaderList;
    }

    public void setActivityLeaderList(List<ActivityLeader> activityLeaderList) {
        this.activityLeaderList = activityLeaderList;
    }

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    //插入前手动调用
    public void preInsert() {
        this.id = UUIDUtil.createUUID();
        this.createTime = new Date();
    }

    //更新前手动调用
    public void preUpdate() {

    }

    @Override
    public String toString() {
        return "Activity{" +
                "id='" + id + '\'' +
                ", product=" + product +
                ", price=" + price +
                ", departTime=" + departTime +
                ", gatherPlace='" + gatherPlace + '\'' +
                ", tripNumber=" + tripNumber +
                ", totalNumber=" + totalNumber +
                ", state='" + state + '\'' +
                ", QRCode='" + QRCode + '\'' +
                ", createTime=" + createTime +
                ", createUser=" + createUser +
                ", updateTime=" + updateTime +
                ", updateUser=" + updateUser +
                ", endTime=" + endTime +
                ", closeTime=" + closeTime +
                ", onSalePrice=" + onSalePrice +
                ", discountRules='" + discountRules + '\'' +
                ", priceIntroduce='" + priceIntroduce + '\'' +
                ", route='" + route + '\'' +
                ", productIntroduce='" + productIntroduce + '\'' +
                ", delFlag='" + delFlag + '\'' +
                ", days=" + days +
                ", activityLeaderList=" + activityLeaderList +
                '}';
    }
}