package com.youwei.kuaiyi.util;

import org.bc.sdak.GException;
import org.bc.sdak.SimpDaoTool;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;

import com.youwei.kuaiyi.MakesiteConstant;
import com.youwei.kuaiyi.entity.TelVerifyCode;

public class VerifyCodeHelper {

	public static void verify(String yzm){
		if(yzm==null){
			yzm="";
		}
		String session_yzm = (String)ThreadSession.getHttpSession().getAttribute(MakesiteConstant.Session_Attr_YZM);
		if(session_yzm==null){
			return;
		}
		if(!yzm.toUpperCase().equals(session_yzm)){
			throw new GException(PlatformExceptionType.BusinessException,"验证码不正确。");
		}
		ThreadSession.getHttpSession().removeAttribute(MakesiteConstant.Session_Attr_YZM);
	}
	
	public static TelVerifyCode verifySMSCode(String tel , String code){
		TelVerifyCode tvc = SimpDaoTool.getGlobalCommonDaoService().getUniqueByParams(TelVerifyCode.class, new String[]{"tel","code" },  new Object[]{tel , code});
		if(tvc==null){
			//验证码不正确
			throw new GException(PlatformExceptionType.BusinessException,"验证码不正确");
		}
		if(tvc.verifyTime!=null){
			//验证码已经过期
			throw new GException(PlatformExceptionType.BusinessException,"验证码已经过期");
		}
		if(System.currentTimeMillis() - tvc.sendtime.getTime()>300*1000){
			//验证码已经过期
			throw new GException(PlatformExceptionType.BusinessException,"验证码已经过期");
		}
		return tvc;
	}
}
