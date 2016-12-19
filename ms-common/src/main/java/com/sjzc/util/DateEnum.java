package com.sjzc.util;

/**
 * @author sjzc
 */
public enum DateEnum {
    DATE_FORMAT("yyyy-MM-dd HH:mm:ss"), DATE_SIMPLE("yyyy-MM-dd"),
    DATE_MIN("yy-MM-dd"), DATE_SIMPLE_MIN("yyyyMMdd"),
    DATE_CHINESE("yyyy年MM月dd日"), DATE_TIME_MIN("HHmmss"),
    DATE_BANK_SEQ("yyyyMMddHHmmssSSS"),
    DATE_SPLIT_SEQ("yyyy-MM-dd HH:mm:ss.sss");
    private String text;

    private DateEnum(String text) {
        this.text = text;
    }

    public String getText() {
        return this.text;
    }

    public void setText(String text) {
        this.text = text;
    }

}
