package cn.sharetimes.utils;


import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by sharetimes on 2017/5/12.
 */
public class EncryptUtils {
    public static String encode(String oldStr) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("md5");
            byte[] afterStr = md5.digest(oldStr.getBytes());
            BigInteger bigInt = new BigInteger(1, afterStr);
            return bigInt.toString(16);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
/**
 * 将字符串转成MD5值
 *
 * @param string
 * @return
 */
        public static String stringToMD5(String string) {
            byte[] hash;

            try {
                hash = MessageDigest.getInstance("MD5").digest(string.getBytes("UTF-8"));
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
            StringBuilder hex = new StringBuilder(hash.length * 2);
            for (byte b : hash) {
                if ((b & 0xFF) < 0x10) {
                    hex.append("0");
                }
                hex.append(Integer.toHexString(b & 0xFF));
            }

            return hex.toString();
        }



}
