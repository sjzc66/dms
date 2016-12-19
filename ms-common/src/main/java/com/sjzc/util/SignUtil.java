package com.sjzc.util;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;

/**
 * 签名工具类
* @ClassName: SignUtil  
* @author sjzc
* @date 2016年9月22日 下午4:30:49
*/
public class SignUtil {

	@SuppressWarnings("rawtypes")
	public static String createSign(SortedMap<Object, Object> parameters, String key) {
		StringBuffer buffer = new StringBuffer();  
        Set es = parameters.entrySet(); 
        Iterator it = es.iterator();  
        while(it.hasNext()) {  
            Map.Entry entry = (Map.Entry)it.next();  
            String k = (String)entry.getKey();  
            Object v = entry.getValue();  
            if(null != v && !"".equals(v)   
                    && !"sign".equals(k) && !"key".equals(k)) {  
            	buffer.append(k + "=" + v + "&");  
            }  
        }  
        
        buffer.append("key="+key);  
        String sign = MD5Coding.encodeForWx(buffer.toString()).toUpperCase();
        
        return sign;  
	}
}
