package com.houyi.util;

import org.json.JSONObject;

import com.tencent.xinge.Message;
import com.tencent.xinge.XingeApp;

public class XingeHelper {

	public static String secretKey = "c3f4107749a1911a8e11f8908faa4de4";
	
	public static long accessId = 2100166619;
	
	public static JSONObject pushSingleAccountMsg(String account , String text) {
		XingeApp xinge = new XingeApp(accessId, secretKey);
		Message message = new Message();
		message.setExpireTime(86400);
//		message.setTitle("title");
		message.setContent(text);
		message.setType(Message.TYPE_MESSAGE);
		JSONObject ret = xinge.pushSingleAccount(0, account, message);
		return (ret);
	}
}
