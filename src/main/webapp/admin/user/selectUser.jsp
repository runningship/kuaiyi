<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.kuaiyi.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<User> p = new Page<User>();
	String groupId = request.getParameter("groupId");
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	int gid = Integer.valueOf(groupId);
	p  = dao.findPage(p,"from User where id not in (select distinct(uid) from UserGroup where gid=?)" , new Object[]{gid});
	request.setAttribute("page", p);
	request.setAttribute("groupId", groupId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
	
	function addToGroup(){
		var ids = '';
		$('input[name=ids]').each(function(){
			if(this.checked){
				ids+=','+this.value;
			}
		});
		
		YW.ajax({
		    type: 'POST',
		    url: '${projectName }/c/admin/user/addToGroup?groupId=${groupId}',
		    data:"ids="+ids,
		    mysuccess: function(data){
		        alert('添加成功');
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.window.location.reload();
				parent.layer.close(index); //再执行关闭   
		    }
	    });
	}
</script>
<body>
	<div>
		<div class="container_box cell_layout side_l" style="min-height:400px;height:550px;;">
			<div class="col_main" style="min-height:400px;height:550px;;">
				<div class="mp_news_area notices_box">
					<table class="userList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td></td>
							<td>账号</td>
							<td>手机号</td>
							<td>姓名</td>
						</tr>
						<c:forEach items="${page.result}" var="user" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td><input type="checkbox" name="ids" value="${user.id }"/></td>
								<td>${user.account}</td>
								<td>${user.tel}</td>
								<td>${user.name}</td>
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