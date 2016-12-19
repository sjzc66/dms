package com.sjzc.common;

import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName:  ReturnCode   
 * @author: sjzc
 * @date:   2016年2月23日 下午2:16:35
 */
public enum ReturnCode {
	
	ACTIVE_EXCEPTION(-1, "异常"),
    ACTIVE_SUCCESS(01, "操作成功"),
    ACTIVE_FAILURE(02, "操作失败"),
    ERROR_PARAMS_NOT_NULL(03, "参数不能为空"),
    ERROR_HEADER_NOT_NULL(04, "请求头不能为空"),
    REQUEST_SUCCESS(200,"请求成功"),
    ERROR_PARAMS(400, "参数不完整"),
    ERROR_DUPLICATE(401, "重复操作"),
    ERROR_PARAMS_DECRYPT(402, "参数解密失败"),
    ERROR_SWITCH_CLOSED(403, "开关已关闭"),
    ERROR_RESOURCES(404, "请求资源不存在"),
    ERROR_PARAMS_FORMAT(500, "参数格式错误"),
    ERROR_SERVER(503, "系统异常"),
    ERROR_USER_TYPE_ERROR(1111, "用户类型参数错误");
	
	private int code;
	
	private String msg;
	
	private ReturnCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public static ReturnCode codeToEnum(int code) {

        ReturnCode[] values = ReturnCode.values();
        for (ReturnCode returnCode : values) {
            if (returnCode.code == code) {
                return returnCode;
            }
        }
        return ACTIVE_EXCEPTION;
    }

    public int code() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String msg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, ?> Map() {
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("code", this.code);
        hashMap.put("msg", this.msg);
        return hashMap;
    }

    public Map<String, ?> Map(int code) {
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("code", code);
        hashMap.put("msg", this.msg);
        return hashMap;
    }

    public Map<String, ?> Map(Object msg) {
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("code", this.code);
        hashMap.put("msg", msg);
        return hashMap;
    }

    public Map<String, ?> Map(int code, Object msg) {
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("code", code);
        hashMap.put("msg", msg);
        return hashMap;
    }

    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder();
        sb.append("{\"code\":").append(this.code).append(",");
        sb.append("\"msg\":\"").append(this.msg).append("\"}");

        return sb.toString();
    }
	

}
