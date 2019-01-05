package cn.edu.bnuz.seawas.dto;

import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;

/**
 * 产品添加Dto
 * Created by Zhong-Yan on 2017/8/4.
 */
public class AddProductDto {

    private String name;
    private String customizedId;
    private String score;
    private String[] city;
    private String type;
    private String[] sort;
    private String degreeDifficulty;
    private String[] equip;
    private MultipartFile file;
    private String disclaimer;
    private String picUrl;
    private String destinationId;

    public String getDestinationId() {
        return destinationId;
    }

    public void setDestinationId(String destinationId) {
        this.destinationId = destinationId;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public String getDisclaimer() {
        return disclaimer;
    }

    public void setDisclaimer(String disclaimer) {
        this.disclaimer = disclaimer;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCustomizedId() {
        return customizedId;
    }

    public void setCustomizedId(String customizedId) {
        this.customizedId = customizedId;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String[] getCity() {
        return city;
    }

    public void setCity(String[] city) {
        this.city = city;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String[] getSort() {
        return sort;
    }

    public void setSort(String[] sort) {
        this.sort = sort;
    }

    public String getDegreeDifficulty() {
        return degreeDifficulty;
    }

    public void setDegreeDifficulty(String degreeDifficulty) {
        this.degreeDifficulty = degreeDifficulty;
    }

    public String[] getEquip() {
        return equip;
    }

    public void setEquip(String[] equip) {
        this.equip = equip;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    @Override
    public String toString() {
        return "AddProductDto{" +
                "name='" + name + '\'' +
                ", score='" + score + '\'' +
                ", city=" + Arrays.toString(city) +
                ", type='" + type + '\'' +
                ", sort=" + Arrays.toString(sort) +
                ", degreeDifficulty='" + degreeDifficulty + '\'' +
                ", equip=" + Arrays.toString(equip) +
                ", file=" + file +
                '}';
    }
}
