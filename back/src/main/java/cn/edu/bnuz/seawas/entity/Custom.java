package cn.edu.bnuz.seawas.entity;

import java.util.Date;

/**
 * 定制表
 * Created by sjk on 2017-07-28.
 */
public class Custom {
    private String id;

    private User user; // 用户id

    private String type; // 定制类型

    private Date startTime; // 出发时间

    private City departCity; // 出发城市

    private Integer number; // 参与人数

    private Integer averageAge; // 平均年龄

    private Double price; // 价格

    private String name; // 企业名称

    private String manaName; // 联系人

    private String manaTel; // 联系方式

    private String aim; // 目的

    private String remark; // 备注

    private String state; // 状态（已审核、未审核）

    private Date createTime; // 申请时间

    private Admin admin; // 审核人id

    private String delFlag = "0"; // 删除标记

    public Custom() { }

    public Custom(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public City getDepartCity() {
        return departCity;
    }

    public void setDepartCity(City departCity) {
        this.departCity = departCity;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Integer getAverageAge() {
        return averageAge;
    }

    public void setAverageAge(Integer averageAge) {
        this.averageAge = averageAge;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getManaName() {
        return manaName;
    }

    public void setManaName(String manaName) {
        this.manaName = manaName == null ? null : manaName.trim();
    }

    public String getManaTel() {
        return manaTel;
    }

    public void setManaTel(String manaTel) {
        this.manaTel = manaTel == null ? null : manaTel.trim();
    }

    public String getAim() {
        return aim;
    }

    public void setAim(String aim) {
        this.aim = aim == null ? null : aim.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
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

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag == null ? null : delFlag.trim();
    }
}