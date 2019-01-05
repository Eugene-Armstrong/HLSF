package cn.edu.bnuz.seawas.entity;

import java.util.Date;

/**
 * 产品表Entity
 * Created by sjk on 2017-07-28.
 */
public class Product {
    private String id;

    private Custom customized; // 定制信息

    private String type; // 产品类型

    private String name; // 产品名称

    private String picUrl; // 产品主页图片

    private Integer degreeDifficulty; // 难度级别

    private Date createTime; // 产品创建时间

    private Admin createUser; // 产品创建者

    private Date updateTime; // 产品更新时间

    private Admin updateUser; // 产品更新人

    private Integer readNumber; // 产品浏览次数

    private Double productAvgVote; // 产品平均分数

    private Integer vote1; // 1星次数

    private Integer vote2; // 2星次数

    private Integer vote3; // 3星次数

    private Integer vote4; // 4星次数

    private Integer vote5; // 5星次数

    private Integer voteNumber; // 产品评分总人数

    private String delFlag = "0"; // 删除标记

    private String equipmentMessage; // 对应的装备

    private String disclaimer; // 免责声明

    private String destinationId;//目的地id

    public String getDestinationId() {
        return destinationId;
    }

    public void setDestinationId(String destinationId) {
        this.destinationId = destinationId;
    }

    public String getDisclaimer() {
        return disclaimer;
    }

    public void setDisclaimer(String disclaimer) {
        this.disclaimer = disclaimer;
    }

    public Product() {
    }

    public Product(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
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

    public Integer getDegreeDifficulty() {
        return degreeDifficulty;
    }

    public void setDegreeDifficulty(Integer degreeDifficulty) {
        this.degreeDifficulty = degreeDifficulty;
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

    public Custom getCustomized() {
        return customized;
    }

    public void setCustomized(Custom customized) {
        this.customized = customized;
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

    public Integer getReadNumber() {
        return readNumber;
    }

    public void setReadNumber(Integer readNumber) {
        this.readNumber = readNumber;
    }

    public Double getProductAvgVote() {
        return productAvgVote;
    }

    public void setProductAvgVote(Double productAvgVote) {
        this.productAvgVote = productAvgVote;
    }

    public Integer getVote1() {
        return vote1;
    }

    public void setVote1(Integer vote1) {
        this.vote1 = vote1;
    }

    public Integer getVote2() {
        return vote2;
    }

    public void setVote2(Integer vote2) {
        this.vote2 = vote2;
    }

    public Integer getVote3() {
        return vote3;
    }

    public void setVote3(Integer vote3) {
        this.vote3 = vote3;
    }

    public Integer getVote4() {
        return vote4;
    }

    public void setVote4(Integer vote4) {
        this.vote4 = vote4;
    }

    public Integer getVote5() {
        return vote5;
    }

    public void setVote5(Integer vote5) {
        this.vote5 = vote5;
    }

    public Integer getVoteNumber() {
        return voteNumber;
    }

    public void setVoteNumber(Integer voteNumber) {
        this.voteNumber = voteNumber;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag == null ? null : delFlag.trim();
    }

    public String getEquipmentMessage() {
        return equipmentMessage;
    }

    public void setEquipmentMessage(String equipmentMessage) {
        this.equipmentMessage = equipmentMessage == null ? null : equipmentMessage.trim();
    }
}