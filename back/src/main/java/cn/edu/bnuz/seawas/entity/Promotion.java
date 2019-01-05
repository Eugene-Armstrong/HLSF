package cn.edu.bnuz.seawas.entity;

/**
 * 优惠表
 */
public class Promotion {
    private String id;

    private String detail; // 优惠详情

    private Double rule; // 优惠规则

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail == null ? null : detail.trim();
    }

    public Double getRule() {
        return rule;
    }

    public void setRule(Double rule) {
        this.rule = rule;
    }
}