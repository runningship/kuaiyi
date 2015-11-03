<%@page import="com.youwei.kuaiyi.entity.NoticeReceiver"%>
<%@page import="com.youwei.kuaiyi.entity.User"%>
<%@page import="com.youwei.kuaiyi.entity.Notice"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	Notice notice = dao.get(Notice.class, id);
	Integer nrid = Integer.valueOf(request.getParameter("nrid"));
	NoticeReceiver nr = dao.get(NoticeReceiver.class, nrid);
	nr.hasRead = 1;
	dao.saveOrUpdate(nr);
	User user = dao.get(User.class, notice.senderId);
	request.setAttribute("Notice", notice);
	request.setAttribute("Sender", user);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}

$(function(){
});

</script>
<body style="background-color:white">
	<form name="form1">
		<div class="form-group">
			<label class="label title">${Notice.title}</label>
		</div>
		<div class="form-group">
			<label class="label send">发件人：<span >${Sender.name}</span>|<fmt:formatDate value="${Notice.addtime}" pattern="yyyy-MM-dd HH:mm"/></label>
	        
		</div>
		<div class="form-conts">
			<label class="conts">${Notice.conts}</label>
		</div>
	</form>
</body>
</html>