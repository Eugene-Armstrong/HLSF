package cn.edu.bnuz.seawas.vo;

/**
 * Created by wifi on 2017/7/25.
 */
public class ProductCountVo {

    private String productId;// 产品id

    private String productName;// 产品名称

    private Integer productReadNumber;// 产品浏览次数

    private Integer productCollectionNumber;// 产品收藏次数

    private Integer productBuyNumber;// 产品购买次数

    private double productSumMoney; // 产品交易额

    private String searchtxt; // 查询文本

    private String cityId; // 查询城市

    private String media; // 查询分类

    private String orders; // 排序

    public String getSearchtxt() {
        return searchtxt;
    }

    public void setSearchtxt(String searchtxt) {
        this.searchtxt = searchtxt;
    }

    public String getCityId() {
        return cityId;
    }

    public void setCityId(String cityId) {
        this.cityId = cityId;
    }

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

    public String getOrders() {
        return orders;
    }

    public void setOrders(String orders) {
        this.orders = orders;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getProductReadNumber() {
        return productReadNumber;
    }

    public void setProductReadNumber(Integer productReadNumber) {
        this.productReadNumber = productReadNumber;
    }

    public Integer getProductCollectionNumber() {
        return productCollectionNumber;
    }

    public void setProductCollectionNumber(Integer productCollectionNumber) {
        this.productCollectionNumber = productCollectionNumber;
    }

    public Integer getProductBuyNumber() {
        return productBuyNumber;
    }

    public void setProductBuyNumber(Integer productBuyNumber) {
        this.productBuyNumber = productBuyNumber;
    }

    public double getProductSumMoney() {
        return productSumMoney;
    }

    public void setProductSumMoney(double productSumMoney) {
        this.productSumMoney = productSumMoney;
    }
}
