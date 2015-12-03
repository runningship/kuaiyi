<%@page import="java.util.Map"%>
<%@page import="com.kuaiyi.entity.NoticeReceiver"%>
<%@page import="com.kuaiyi.entity.User"%>
<%@page import="com.kuaiyi.entity.Notice"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	Notice notice = dao.get(Notice.class, id);
	List<Map> result = dao.listAsMap("select u.name as rname from NoticeReceiver nr , User u where nr.receiverId = u.id and nr.noticeId = ?", notice.id);
	StringBuilder users = new StringBuilder("");
	for(Map m : result){
		users.append(m.get("rname")).append(",");
	}
	request.setAttribute("Notice", notice);
	request.setAttribute("Sender", users);
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
			<label class="label2">标&nbsp;&nbsp;题：</label>
	        <span >${Notice.title}</span>
		</div>
		<div class="form-group">
			<label class="label2">收件人：</label>
	        <span >${Sender}</span>
		</div>
		<div class="form-group">
			<label class="label2">内&nbsp;&nbsp;容：</label>
	        <span >${Notice.conts}</span>
		</div>
	</form>
</body>
</html>