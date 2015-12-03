<%@page import="com.kuaiyi.entity.Feedback"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<Feedback> p = new Page<Feedback>();
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	p  = dao.findPage(p,"from Feedback where 1=1 order by id desc ");
	request.setAttribute("page", p);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
	function infoDel(id){
		layer.confirm('删除后将无法恢复，是否确定删除', {icon: 3}, function(index){
		    layer.close(index);
			YW.ajax({
			    type: 'POST',
			    url: '${projectName }/c/admin/feedback/delete?id='+id,
			    mysuccess: function(data){
			        alert('删除成功');
			        window.location.reload();
			    }
		    });
		});
	}

	function seeThis(id){
		layer.open({
	    	type: 2,
	    	title: '网友留言',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['500px', '400px'],
		    content: 'info.jsp?id='+id
		}); 
	}

</script>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<div class="title_bar">
						<h3>反馈列表</h3>
					</div>
					<table class="feedbacklist" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>内容</td>
							<td>联系人</td>
							<td>联系方式</td>
							<td>发布时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="feedback" varStatus="status">
						<c:set var="string1" value="${feedback.conts}"/>
						<c:set var="string2" value="${fn:substring(string1, 0, 20)}" />
						<tr class="statue_${status.index%2}">
							<td><a href="#" onclick="seeThis(${feedback.id})">${string2}...</a></td>
							<td>${feedback.name}</td> 
							<td>${feedback.contact}</td> 
							<td><fmt:formatDate value="${feedback.addtime }" pattern="yyyy-MM-dd HH:mm"/></td> 
							<td><c:if test="${session_auth_list.indexOf('$feedback_del')>-1 }"><a href="#" onclick="infoDel(${feedback.id})">删除</a></c:if></td>
						</tr>
						</c:forEach>
					</table>
				</div>

				<jsp:include page="../inc/pagination.jsp"></jsp:include>


			</div>
		</div>

	</div>
</body>
</html>