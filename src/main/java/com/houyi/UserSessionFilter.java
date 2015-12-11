package com.houyi;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bc.sdak.GException;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;

import com.houyi.entity.User;
import com.houyi.util.DataHelper;

public class UserSessionFilter implements Filter {

	// Filter注销方法
	@Override
	public void destroy() {

	}

	// filter要实现的功能
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req  = (HttpServletRequest)request;
		req.setAttribute("_site", DataHelper.getServerName(req));
		ThreadSession.setHttpSession(req.getSession());
		HttpSession session = ThreadSession.getHttpSession();
		String path = req.getServletPath();
		if(path.contains("login") || path.contains("/js/") || path.contains("feedback")){
			chain.doFilter(request, response);
			return;
		}
    	User u = (User)session.getAttribute("user");
    	if(u==null){
    		try {
    			HttpServletResponse resp = (HttpServletResponse)response;
    			resp.setHeader("userOffline", "true");
    			resp.setContentType("text/html");
    			boolean ajax = "XMLHttpRequest".equals( req.getHeader("X-Requested-With") );
    	        String ajaxFlag = null == req.getParameter("ajax") ?  "false": req.getParameter("ajax") ;
    	        boolean isAjax = ajax || ajaxFlag.equalsIgnoreCase("true");
    	        if(isAjax){
    	        	String str = "window.top.location='"+req.getServletContext().getContextPath()+"/login/login.jsp'";
        			response.getOutputStream().write(str.getBytes());
    	        }else{
    	        	String str = "<script type='text/javascript'>window.location='"+req.getServletContext().getContextPath()+"/login/login.jsp'</script>";
        			response.getOutputStream().write(str.getBytes());
    	        }
    			
    		} catch (IOException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    		return;
    	}
    	List<String> urls = (List<String>) session.getAttribute(MakesiteConstant.Session_Auth_Urls);
    	if(urls!=null && urls.contains(path)){
    		response.getOutputStream().write("您的权限不能访问该页面".getBytes());
    		return;
    	}
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println();
	}

}
