package com.sjzc.util;


/**
 * 工具类JdbcUtil,读配置文件建立连接池，当不方便再spring里或者ibaits时候,用我
 * 
 * @author: sjzc
 * @date 2015年11月2日 上午10:49:21
 */
public class JdbcUtil
{

    /**
     * 判断增删改是否成功
     * 
     * @param effectRowCount
     *        影响的行数
     * @return 行数大于零返回true，否则返回false
     * @author: sjzc
     * @date: 2015年11月2日上午10:48:32
     */
    public static boolean isSuccess(int effectRowCount)
    {
        if (effectRowCount > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
