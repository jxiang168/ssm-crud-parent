package org.jxiang.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * General return object from api
 *
 * @author Jxiang
 * @version 1.0
 * @create 2022-06-28 6:36
 */
public class Msg {
    // 100 success, 200 fail
    private int code;
    private String msg;
    private Map<String, Object> extend;

    public static Msg success() {
        return new Msg(100,"处理成功!",new HashMap<String, Object>());
    }

    public static Msg fail() {
        return new Msg(200,"处理失败!",new HashMap<String, Object>());
    }

    public Msg add(String key, Object value) {
        extend.put(key,value);
        return this;
    }

    public Msg(int code, String msg, Map<String, Object> extend) {
        this.code = code;
        this.msg = msg;
        this.extend = extend;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public Msg() {
    }
}
