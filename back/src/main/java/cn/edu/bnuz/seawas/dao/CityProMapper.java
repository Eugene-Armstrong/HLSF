package cn.edu.bnuz.seawas.dao;

import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.CityPro;
import org.apache.ibatis.annotations.Param;

import java.util.List;

//城市产品表
public interface CityProMapper {
    int deleteByPrimaryKey(String id);

    int insert(CityPro record);

    int insertSelective(CityPro record);

    CityPro selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(CityPro record);

    int updateByPrimaryKey(CityPro record);

    /**
     * 通过城市id删除数据
     * @param cityId 城市id
     */
    int deleteByCityId(String cityId);

    /**
     *
     * @param productId 产品id通过产品id删除数据
     */
    int deleteByProductId(String productId);

    /**
     * wifi
     * 根据产品id获取城市信息
     * @param productId
     * @return
     */
    List<City> selectCityProByProductId(@Param("productId") String productId);

}