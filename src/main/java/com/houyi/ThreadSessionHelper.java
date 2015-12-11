package com.houyi;

import javax.servlet.http.HttpSession;

import org.bc.web.ThreadSession;

import com.houyi.entity.User;

public class ThreadSessionHelper {

	public static User getUser(){
    	HttpSession session = ThreadSession.getHttpSession();
    	User u = (User)session.getAttribute("user");
    	return u;
    }
}
