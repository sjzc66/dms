package com.sjzc.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 
 * @ClassName:  MD5Coding   
 * @author: sjzc
 * @date:   2015年11月4日 下午2:08:28
 */
public class MD5Coding
{
    private static final Logger logger = LoggerFactory.getLogger(MD5Coding.class);

    /**
     * 用MD5算法加密字节数组
     * 
     * @param bytes
     *        要加密的字节
     * @return byte[] 加密后的字节数组，若加密失败，则返回null
     */
    public static byte[] encode(byte[] bytes)
    {
        try
        {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            digest.update(bytes);
            byte[] digesta = digest.digest();
            return digesta;
        }
        catch (Exception e)
        {
            return null;
        }
    }

    /**
     * 用MD5算法加密后再转换成hex String
     *
     * @param bytes
     * @return String
     */
    public static String encode2HexStr(byte[] bytes)
    {
        return HexUtil.bytes2HexStr(MD5Coding.encode(bytes));
    }

    /**
     * 用MD5算法加密后再转换成BASE64编码的字符串
     *
     * @param bytes
     * @return String
     */
    public static String encode2Base64(byte[] bytes)
    {
        return BASE64Coding.encode(MD5Coding.encode(bytes));
    }

    /**
     * 计算文件的md5
     *
     * @param filePath
     *        文件路径
     * @return md5结果，若加密失败，则返回null
     */
    public static byte[] encodeFile(String filePath)
    {
        try
        {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            FileInputStream fis = new FileInputStream(filePath);
            byte[] buffer = new byte[1024];
            byte[] digesta = null;
            int readed = -1;
            try
            {
                while ((readed = fis.read(buffer)) != -1)
                {
                    digest.update(buffer, 0, readed);
                }
                digesta = digest.digest();
            }
            catch (IOException e)
            {
                MD5Coding.logger.error("IOException:" + filePath, e);
            }
            finally
            {
                try
                {
                    fis.close();
                }
                catch (IOException e)
                {
                    MD5Coding.logger.error("IOException:" + filePath, e);
                }
            }
            return digesta;
        }
        catch (FileNotFoundException e)
        {
            MD5Coding.logger.error("file not found:" + filePath, e);
            return null;
        }
        catch (NoSuchAlgorithmException e)
        {
            MD5Coding.logger.error("NoSuchAlgorithmException:MD5", e);
            return null;
        }
    }

    /**
     * 计算文件的md5,转换成hex String
     * 
     * @param filePath
     *        文件路径
     * @return md5结果，若加密失败，则返回null
     */
    public static String encodeFile2HexStr(String filePath)
    {
        return HexUtil.bytes2HexStr(MD5Coding.encodeFile(filePath));
    }

    /**
     * 计算文件的md5,转换成Base64 string
     * 
     * @param filePath
     *        文件路径
     * @return md5结果，若加密失败，则返回null
     */
    public static String encodeFile2Base64(String filePath)
    {
        byte[] bytes = MD5Coding.encodeFile(filePath);
        if (bytes == null)
        {
            return null;
        }
        return BASE64Coding.encode(bytes);
    }

    // 仅为微信支付相关使用
    public final static String encodeForWx(String s)
    {
        char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
        try
        {
            byte[] btInput = s.getBytes();
            // 获得MD5摘要算法的 MessageDigest 对象
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            mdInst.update(btInput);
            // 获得密文
            byte[] md = mdInst.digest();
            // 把密文转换成十六进制的字符串形式
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++)
            {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return null;
        }
    }
    
}
