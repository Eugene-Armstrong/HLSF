package cn.edu.bnuz.seawas.entity;

import cn.edu.bnuz.seawas.utils.UUIDUtil;

import java.util.Date;

/**
 * 用户表
 */
public class User {

    private String id;

    private String openid; // 微信用户标识

    private String realName; // 真实姓名

    private String nickName; // 昵称

    private String sex; // 性别

    private Integer age; // 年龄

    private String phone; // 手机号码

    private String certId; // 身份证

    private String headImgUrl; // 头像url

    private String hobby; // 兴趣爱好

    private String experience; // 个人经历

    private String tag; // 标签

    private String motto; // 座右铭

    private Double integral; // 积分

    private Date lastLoginTime; // 最后登录时间

    private Double experValue; // 经验值

    private String type; // 用户标识、用户类型

    private Double score; // 评分、领队分数

    private Integer leaderNum; // 带队次数

    private String workNo; // 工号

    private Integer opinionNum; // 评价次数、用于计算分数

    private Date createTime; // 注册时间

    private String delFlag; // 删除标记

    public User() { }

    public User(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid == null ? null : openid.trim();
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName == null ? null : realName.trim();
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName == null ? null : nickName.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getCertId() {
        return certId;
    }

    public void setCertId(String certId) {
        this.certId = certId == null ? null : certId.trim();
    }

    public String getHeadImgUrl() {
        return headImgUrl;
    }

    public void setHeadImgUrl(String headImgUrl) {
        this.headImgUrl = headImgUrl == null ? null : headImgUrl.trim();
    }

    public String getHobby() {
        return hobby;
    }

    public void setHobby(String hobby) {
        this.hobby = hobby == null ? null : hobby.trim();
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience == null ? null : experience.trim();
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag == null ? null : tag.trim();
    }

    public String getMotto() {
        return motto;
    }

    public void setMotto(String motto) {
        this.motto = motto == null ? null : motto.trim();
    }

    public Double getIntegral() {
        return integral;
    }

    public void setIntegral(Double integral) {
        this.integral = integral;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public Double getExperValue() {
        return experValue;
    }

    public void setExperValue(Double experValue) {
        this.experValue = experValue;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Integer getLeaderNum() {
        return leaderNum;
    }

    public void setLeaderNum(Integer leaderNum) {
        this.leaderNum = leaderNum;
    }

    public String getWorkNo() {
        return workNo;
    }

    public void setWorkNo(String workNo) {
        this.workNo = workNo == null ? null : workNo.trim();
    }

    public Integer getOpinionNum() {
        return opinionNum;
    }

    public void setOpinionNum(Integer opinionNum) {
        this.opinionNum = opinionNum;
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

    //插入前手动调用
    public void preInsert() {
        this.id = UUIDUtil.createUUID();
        this.createTime = new Date();
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", openid='" + openid + '\'' +
                ", realName='" + realName + '\'' +
                ", nickName='" + nickName + '\'' +
                ", sex='" + sex + '\'' +
                ", age=" + age +
                ", phone='" + phone + '\'' +
                ", certId='" + certId + '\'' +
                ", headImgUrl='" + headImgUrl + '\'' +
                ", hobby='" + hobby + '\'' +
                ", experience='" + experience + '\'' +
                ", tag='" + tag + '\'' +
                ", motto='" + motto + '\'' +
                ", integral=" + integral +
                ", lastLoginTime=" + lastLoginTime +
                ", experValue=" + experValue +
                ", type='" + type + '\'' +
                ", score=" + score +
                ", leaderNum=" + leaderNum +
                ", workNo='" + workNo + '\'' +
                ", opinionNum=" + opinionNum +
                ", createTime=" + createTime +
                ", delFlag='" + delFlag + '\'' +
                '}';
    }
}