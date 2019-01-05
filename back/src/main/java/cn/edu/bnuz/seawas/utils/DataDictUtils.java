package cn.edu.bnuz.seawas.utils;

import cn.edu.bnuz.seawas.dao.DictMapper;
import cn.edu.bnuz.seawas.entity.Dict;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * Created by Ayakura Yuki on 2017/7/10.<br />
 * 数据字典工具类
 */
public class DataDictUtils {

    private static DictMapper DictMapper = SpringContextHolder.getBean(DictMapper.class);

    private static final String CACHE_DICT_MAP = "DictMapCache";

    /**
     * 缓存字典列表
     *
     * @param type 字典类型
     * @return 所属类型的结果集合
     */
    public static List<Dict> getDictList(String type) {
        // 从缓存获取数据字典内容
        @SuppressWarnings("unchecked")
        Map<String, List<Dict>> dictMap = (Map<String, List<Dict>>) CacheUtils.get(CACHE_DICT_MAP);
        // 如果没有获取到内容，从数据库全局查询
        if (dictMap == null) {
            dictMap = Maps.newHashMap();
            // 查询到的结果类型为 List<DataDict>
            for (Dict dict : DictMapper.findList(null)) {
                // 检查缓存内容有没有对应类型的数据存在
                List<Dict> dictList = dictMap.get(dict.getType());
                if (dictList != null) { // 有，直接加入内容
                    dictList.add(dict);
                } else { //没有，创建对应类型的list并存入
                    dictMap.put(dict.getType(), Lists.newArrayList(dict));
                }
            }
            // 放入缓存
            CacheUtils.put(CACHE_DICT_MAP, dictMap);
        }
        // 如果缓存命中，从数据字典中找到相应类型的List
        List<Dict> dictList = dictMap.get(type);
        // 如果还找不到，我觉得一般不会走到这个if语句体里面，但不排除不命中的可能。 ——Aiden Wei
        if (dictList == null) {
            dictList = Lists.newArrayList();
        }
        return dictList;
    }

    /**
     * 获取标签
     *
     * @param type         字典类型
     * @param value        目标对象的value值
     * @param defaultValue 定义找不到结果的时候将会显示的内容
     * @return 返回找到的标签值，如果找不到，会显示默认值
     */
    public static String getDictLabel(String type, String value, String defaultValue) {
        if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(value)) {
            for (Dict dict : getDictList(type)) {
                if (type.equals(dict.getType()) && value.equals(dict.getValue()))
                    return dict.getLabel();
            }
        }
        return defaultValue;
    }

    /**
     * 获取某一类型的所有标签
     *
     * @param type         字典类型
     * @param values       目标对象的values集，逗号分割
     * @param defaultValue 定义找不到结果的时候将会显示的内容
     * @return 返回找到的标签值，如果找不到，会显示默认值
     */
    public static String getDictLabels(String type, String values, String defaultValue) {
        if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(values)) {
            List<String> valueList = Lists.newArrayList();
            for (String value : StringUtils.split(values, ",")) {
                valueList.add(getDictLabel(type, value, defaultValue));
            }
            return StringUtils.join(valueList, ",");
        }
        return defaultValue;
    }

    /**
     * 获取字典值
     *
     * @param label        目标对象的标签
     * @param type         字典类型
     * @param defaultLabel 定义找不到结果的时候将会显示的内容
     * @return 返回找到的值，如果找不到，会显示默认值
     */
    public static String getDictValue(String label, String type, String defaultLabel) {
        if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(label)) {
            for (Dict dict : getDictList(type)) {
                if (type.equals(dict.getType()) && label.equals(dict.getLabel())) {
                    return dict.getValue();
                }
            }
        }
        return defaultLabel;
    }

    /**
     * 返回字典列表 by JSON
     *
     * @param type 字典类型
     * @return 集合的JSON化参数
     */
    public static String getDictListJson(String type) {
        return JsonMapper.toJsonString(getDictList(type));
    }


}
