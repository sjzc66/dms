package com.sjzc.util;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/**
 * AES加密
 * @ClassName:  AESUtil   
 * @author: sjzc
 * @date:   2015年12月4日 下午12:36:38
 */
public class AESUtil {
	
	private static final Logger logger=LoggerFactory.getLogger(AESUtil.class); 
	
	private static final String KEY = "0415f531c6e4e17ba3d75ec645f119e1";
	
	private static boolean isValidKey(){
		if (!StringUtil.checkNotEmpty(KEY)) {
			logger.warn("Key为空");
			return false;
		}

		if (KEY.length() != 32) {
			logger.warn("Key长度不是32位");
			return false;
		}
		
		return true;
	}
	
	private static byte[] getSecretKey(){
		return Base64.decodeBase64(KEY);
	}

	/**
	 * 
	 * @param sSrc
	 * @return 解密
	 * @throws Exception
	 */
	public static String decrypt(String encrypted){
		try {
			if (!isValidKey()) {
				return null;
			}

			SecretKeySpec spec = new SecretKeySpec(getSecretKey(), "AES");
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.DECRYPT_MODE, spec);			
			byte[] original = cipher.doFinal(Base64.decodeBase64(encrypted));
			
			return new String(original);
		} catch (Exception e) {
			logger.error("Decrypt failed!", e);
		}
		return null;
	}

	/**
	 * 
	 * @param sSrc
	 * @return 加密
	 * @throws Exception
	 */
	public static String encrypt(String plain) throws Exception {
		if (!isValidKey()) {
			return null;
		}
		
		SecretKeySpec spec = new SecretKeySpec(getSecretKey(), "AES");
		Cipher cipher = Cipher.getInstance("AES");
		cipher.init(Cipher.ENCRYPT_MODE, spec);
		byte[] encrypted = cipher.doFinal(plain.getBytes());
		
		return new Base64().encodeToString(encrypted);
	}

	public static void main(String[] args) throws Exception {
		System.out.println(AESUtil.encrypt("951qaz"));
		System.out.println(AESUtil.decrypt(AESUtil.encrypt("951qaz")));
	}
}
