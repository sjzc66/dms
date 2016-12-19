package com.sjzc.util;

import com.sjzc.exception.ServiceException;

import java.util.Collection;
import java.util.Map;

/**
 * Created by zhishuo on 9/28/16.
 */
public class ServiceValidate {
    
    private static final String DEFAULT_MSG = "服务器异常"; 

    public ServiceValidate() {
        super();
    }

    public static void isTrue(boolean expression,String msg) {
        if (expression == false) {
            throw new ServiceException(msg);
        }
    }

    public static void isTrue(boolean expression) {
        if (expression == false) {
            throw new ServiceException(DEFAULT_MSG);
        }
    }

    public static <T> T notNull(T object) {
        return notNull(object, DEFAULT_MSG);
    }

    public static <T> T notNull(T object, String msg) {
        if (object == null) {
            throw new ServiceException(msg);
        }
        return object;
    }

    public static <T> T[] notEmpty(T[] array, String msg) {
        if (array == null) {
            throw new ServiceException(msg);
        }
        if (array.length == 0) {
            throw new ServiceException(msg);
        }
        return array;
    }

    public static <T> T[] notEmpty(T[] array) {
        return notEmpty(array, DEFAULT_MSG);
    }

    public static <T extends Collection<?>> T notEmpty(T collection, String msg) {
        if (collection == null) {
            throw new ServiceException(msg);
        }
        if (collection.isEmpty()) {
            throw new ServiceException(msg);
        }
        return collection;
    }

    public static <T extends Collection<?>> T notEmpty(T collection) {
        return notEmpty(collection, DEFAULT_MSG);
    }

    public static <T extends Map<?, ?>> T notEmpty(T map, String msg) {
        if (map == null) {
            throw new ServiceException(msg);
        }
        if (map.isEmpty()) {
            throw new ServiceException(msg);
        }
        return map;
    }

    public static <T extends Map<?, ?>> T notEmpty(T map) {
        return notEmpty(map, DEFAULT_MSG);
    }

    public static <T extends CharSequence> T notEmpty(T chars, String msg) {
        if (chars == null) {
            throw new ServiceException(msg);
        }
        if (chars.length() == 0) {
            throw new ServiceException(msg);
        }
        return chars;
    }

}
