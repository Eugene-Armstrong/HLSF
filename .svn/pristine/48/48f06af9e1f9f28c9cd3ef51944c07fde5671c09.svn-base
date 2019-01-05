package cn.edu.bnuz.seawas.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * Created by Zhong-Yan on 2017/7/17.
 */
public class UUIDUtil {
    //生成UUID
    public static String createUUID(){
        String uuid = UUID.randomUUID().toString();
        return uuid.replaceAll("\\-", "");
    }

    /**
     * 生成HashCode的UUID商户订单号
     */
    public static String createOrderId() {
        Integer hashCodeV = UUID.randomUUID().toString().hashCode();
        if (hashCodeV < 0) {
            hashCodeV = -hashCodeV;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        return sdf.format(new Date()) + String.format("%015d", hashCodeV);
    }

    public static void main(String[] args) {
        System.out.println(createUUID());
    }
}
