package cn.edu.bnuz.seawas.service.admin;

import cn.edu.bnuz.seawas.dao.CityMapper;
import cn.edu.bnuz.seawas.dao.CityProMapper;
import cn.edu.bnuz.seawas.entity.City;
import cn.edu.bnuz.seawas.entity.CityPro;
import cn.edu.bnuz.seawas.utils.Condition;
import cn.edu.bnuz.seawas.utils.UUIDUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 城市管理Service
 * Created by sjk on 2017-07-31.
 */
@Service
public class CityService {

    @Autowired
    private CityMapper cityMapper;

    @Autowired
    private CityProMapper cityProMapper;

    /**
     * 查询已添加的城市列表
     */
    @Transactional(readOnly = true)
    public List<City> findList() { return cityMapper.findList(new City()); }

    /**
     * 添加新的城市
     */
    @Transactional
    public Condition saveNewCity(String newCity) {
        try {
            //数据校验
            if (StringUtils.isBlank(newCity)) {
                return new Condition(Condition.ERROR_CODE, "请输入城市名称");
            }

            City city = new City();
            city.setName(newCity);
            city.preInsert();

            //录入数据库
            cityMapper.insert(city);

            return new Condition(Condition.SUCCESS_CODE, "添加城市成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }

    /**
     * 删除城市
     */
    @Transactional
    public Condition deleteCity(String cityId) {
        try {
            //数据校验
            if (StringUtils.isBlank(cityId)) {
                return new Condition(Condition.ERROR_CODE, "请选择城市");
            }
            //删除城市表的数据
            cityMapper.delete(new City(cityId));
            //删除城市产品表的数据
            cityProMapper.deleteByCityId(cityId);

            return new Condition(Condition.SUCCESS_CODE, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "系统繁忙");
        }
    }

    /**
     * 为产品设置城市
     */
    public void addProductCity(String[] citys,String productId){
        CityPro city = new CityPro();
        for (int i = 0;i < citys.length;i++){
            city.setCityId(citys[i]);
            city.setProductId(productId);
            city.setId(UUIDUtil.createUUID());
            cityProMapper.insertSelective(city);
        }

    }

    /**
     * 获取城市信息
     */
    @Transactional(readOnly = true)
    public City get(String id) {
        return cityMapper.get(new City(id));
    }

    /**
     * wifi
     * 根据产品id获取城市信息
     * @param productId
     * @return
     */
    public List<City> selectCityProByProductId(String productId){
        return cityProMapper.selectCityProByProductId(productId);
    }
}
