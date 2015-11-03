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
	Page<Map> p = new Page<Map>();
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	List<Map> groups  = dao.listSqlAsMap("select g.name as name ,ug.gid as gid from uc_group g left join UserGroup ug on g.id=ug.gid order by gid desc");
	request.setAttribute("groups", groups);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>部门信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
	function userAdd(){
		layer.open({
	    	type: 2,
	    	title: '添加部门',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['400px', '200px'],
		    content: 'add.jsp'
		}); 
	}

	function userEdit(id){
		layer.open({
	    	type: 2,
	    	title: '修改部门',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['400px', '200px'],
		    content: 'edit.jsp?id='+id
		}); 
	}

function reloadWindow(){
	window.location.reload();
}

	function userDel(id){
		YW.ajax({
		    type: 'POST',
		    url: '${projectName }/c/admin/user/delete?id='+id,
		    mysuccess: function(data){
		        alert('删除成功');
		        window.location.reload();
		    }
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
						<h3>用户列表</h3>
						<button onclick="userAdd();return false;" class="add">添 &nbsp;加</button>
					</div>
					<table class="groupList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>名称</td>
							<td>人数</td>
							<td>创建人</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${groups}" var="group" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td>${group.name}</td>
								<td>12</td>
								<td>22333</td>
								<td>
									<a href="#" onclick="userEdit('${group.gid}');return false">修改</a>
									<a href="#" onclick="userDel('${group.gid}');return false">删除</a>
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