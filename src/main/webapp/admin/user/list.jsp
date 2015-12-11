<%@page import="com.houyi.util.DataHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.houyi.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<User> p = new Page<User>();
	String currentPageNo =  request.getParameter("currentPageNo");
	String userName =  request.getParameter("userName");
	String userTel =  request.getParameter("userTel");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	StringBuilder hql = new StringBuilder("from User where 1=1 ");
	List<Object> params = new ArrayList<Object>();
	if(StringUtils.isNotEmpty(userName)){
		hql.append(" and name like ?");
		params.add("%"+userName+"%");
	}
	if(StringUtils.isNotEmpty(userTel)){
		hql.append(" and tel like ?");
		params.add("%"+userTel+"%");
	}
	hql.append(" order by id desc");
	p  = dao.findPage(p, hql.toString(), params.toArray());
	request.setAttribute("page", p);

	request.setAttribute("userName", userName);
	request.setAttribute("userTel", userTel);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">

function userEdit(id){
		layer.open({
	    	type: 2,
	    	title: '修改用户',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['500px', '500px'],
		    content: 'edit.jsp?id='+id,
		    btn: ['确定','取消'],
		    yes:function(index){
		    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
			    return false;
			}
		}); 
	}

function reloadWindow(){
	window.location.reload();
}

	function userDel(id){
		layer.confirm('删除后将无法恢复，是否确定删除', {icon: 3}, function(index){
		    layer.close(index);
			YW.ajax({
			    type: 'POST',
			    url: '${projectName }/c/admin/user/delete?id='+id,
			    mysuccess: function(data){
			        alert('删除成功');
			        window.location.reload();
			    }
		    });
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
					<div class="title_bar" style="height:50px;line-height:50px;">
					<form name="form1" type="form" method="post" action="list.jsp?nav=yglb" style="">
							<span>用户名: </span><input name="userName" value="${userName}" style="margin-top: 10px;height:26px;width:100px;">
							<span style="margin-left:50px;">联系电话: </span><input name="userTel" value="${userTel}"  style="margin-top: 10px;height:26px;width:200px;">
							<input style="margin-right:20px;float:right;margin-top:12px;height:28px;width:60px;cursor:pointer" type="submit" value="搜索"/>
					</form>
					</div>
					<table class="userList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>账号</td>
							<td>手机号</td>
							<td>姓名</td>
							<td>最后登录时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result}" var="user" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td>${user.account}</td>
								<td>${user.tel}</td>
								<td>${user.name}</td>
								<td><fmt:formatDate value="${user.lasttime }" pattern="yyyy-MM-dd HH:mm"/></td>
								<td>
									<c:if test="${session_auth_list.indexOf('$user')>-1 }"><a href="#" onclick="userEdit('${user.id}');return false">修改</a></c:if>
									<c:if test="${session_auth_list.indexOf('$user')>-1 && user.isSuperAdmin==0}"><a href="#" onclick="userDel('${user.id}');return false">删除</a></c:if>
								</td>
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