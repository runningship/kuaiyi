package com.youwei.kuaiyi;

import javax.servlet.http.HttpSession;

import org.bc.web.ThreadSession;

import com.youwei.kuaiyi.entity.User;

public class ThreadSessionHelper {

	public static User getUser(){
    	HttpSession session = ThreadSession.getHttpSession();
    	User u = (User)session.getAttribute("user");
    	return u;
    }
}
