package cn.edu.bnuz.seawas.utils;

import sun.misc.BASE64Encoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.UnsupportedEncodingException;

/**
 * Created by wifi on 2017/8/1.
 * MD5加密
 */
public class MD5Util {

    /**
     * 利用MD5进行加密
     * @param str 待加密的字符串
     * @return 加密后的字符串
     * @throws NoSuchAlgorithmException
     * @throws UnsupportedEncodingException
     */
        public static String EncoderByMd5(String str)throws NoSuchAlgorithmException,UnsupportedEncodingException{
            // 确定计算方法
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            BASE64Encoder base64Encoder = new BASE64Encoder();
            // 加密后的字符串
            String newStr = base64Encoder.encode(md5.digest(str.getBytes("UTF-8")));
            return newStr;
        }

    /**
     * 判断用户密码是否正确
     * @param newPassword 用户输入的密码
     * @param oldPassword 数据库中存储的密码
     * @return
     * @throws NoSuchAlgorithmException
     * @throws UnsupportedEncodingException
     */
        public static boolean checkPassword(String newPassword,String oldPassword) throws NoSuchAlgorithmException,UnsupportedEncodingException{
            if (EncoderByMd5((newPassword)).equals(oldPassword))
                return true;
            else
                return false;
        }
}
