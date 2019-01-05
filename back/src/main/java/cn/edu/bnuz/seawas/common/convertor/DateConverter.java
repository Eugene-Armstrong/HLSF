package cn.edu.bnuz.seawas.common.convertor;

import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日期转换器
 * Created by sjk on 2017-07-26.
 */
public class DateConverter implements Converter<String, Date> {

    public Date convert(String s) {
        SimpleDateFormat simpleDateFormat;
        try {
            //匹配 "yyyy-MM-dd" 格式
            if (s.matches("^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$")) {
                simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                return simpleDateFormat.parse(s);
            }
            //匹配 "yyyy-MM-dd hh:mm:ss" 格式
            else if (s.matches("^(((20[0-3][0-9]-(0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|(20[0-3][0-9]-(0[2469]|11)-(0[1-9]|[12][0-9]|30))) (20|21|22|23|[0-1][0-9]):[0-5][0-9]:[0-5][0-9])$")) {
                simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                return simpleDateFormat.parse(s);
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
}
