package com.sjzc.dms.common;


public class JsonResult {

	private String msg;
	private boolean success;
	private Object result;

	public static JsonResult createSuccess() {
		JsonResult jp = new JsonResult();
		jp.setSuccess(true);
		return jp;
	}

	public static JsonResult createSuccess(Object extParams) {
		JsonResult jp = new JsonResult();
		jp.setResult(extParams);
		jp.setSuccess(true);
		return jp;
	}

	public static JsonResult createErrorMsg(String msg) {
		JsonResult jp = new JsonResult();
		jp.setMsg(msg);
		return jp;
	}

	public static JsonResult createSuccessMsg(String msg) {
		JsonResult jp = new JsonResult();
		jp.setMsg(msg);
		jp.setSuccess(true);
		return jp;
	}

	public static JsonResult createMsg(boolean success, String msg) {
		JsonResult jp = new JsonResult();
		jp.setMsg(msg);
		jp.setSuccess(success);
		return jp;
	}

    public static JsonResult createSuccess(Object obj, String msg) {
        JsonResult jp = new JsonResult();
        jp.setMsg(msg);
        jp.setSuccess(Boolean.TRUE);
        jp.setResult(obj);
        return jp;
    }

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Object getResult() {
		return result;
	}

	public void setResult(Object result) {
		this.result = result;
	}

	@Override
	public String toString() {
		return "JsonResult [msg=" + msg + ", success=" + success + ", result=" + result + "]";
	}

}
