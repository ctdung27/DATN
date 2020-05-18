package com.example.util;

import com.example.constant.SystemConstant;

import java.util.HashMap;
import java.util.Map;

public class MessageResponseUtils {

    public static Map<String, String> getMessage(String message) {
        Map<String, String> results = new HashMap<>();
        if (message.equals(SystemConstant.INSERT_SUCCESS)) {
            results.put(SystemConstant.ALERT, "success");
            results.put(SystemConstant.MESSAGE_RESPONSE, "insert success");
        } else if (message.equals(SystemConstant.UPDATE_SUCCESS)) {
            results.put(SystemConstant.ALERT, "success");
            results.put(SystemConstant.MESSAGE_RESPONSE, "Update success");
        } else if (message.equals(SystemConstant.DELETE_SUCCESS)) {
            results.put(SystemConstant.ALERT, "success");
            results.put(SystemConstant.MESSAGE_RESPONSE, "Delete success");
        } else if (message.equals(SystemConstant.ERROR_SYSTEM)) {
            results.put(SystemConstant.ALERT, "danger");
            results.put(SystemConstant.MESSAGE_RESPONSE, "Error system");
        }
        return results;
    }
}
