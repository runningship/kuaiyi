<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="com.youwei.kuaiyi.entity.Role"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<Role> p = new Page<Role>();
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	p  = dao.findPage(p,"from Role where isSystemRole=0 and _site = ? order by id desc",DataHelper.getServerName(request));
	request.setAttribute("page", p);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>职位权限</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
	function roleAdd(){
		layer.open({
	    	type: 2,
	    	title: '添加职位',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['400px', '250px'],
		    content: 'add.jsp',
		    btn: ['确定','取消'],
		    yes:function(index){
		    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
			    return false;
			}
		}); 
	}

	function roleEdit(id){
		layer.open({
	    	type: 2,
	    	title: '修改职位',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['400px', '250px'],
		    content: 'edit.jsp?id='+id,
		    btn: ['确定','取消'],
		    yes:function(index){
		    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
			    return false;
			}
		}); 
	}

	function authEdit(id){
		layer.open({
	    	type: 2,
	    	title: '编辑权限',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['397px', '700px'],
		    content: 'authList.jsp?roleId='+id
		}); 
	}

function reloadWindow(){
	window.location.reload();
}

	function roleDel(id){
		layer.confirm('删除后将无法恢复，是否确定删除', {icon: 3}, function(index){
		    layer.close(index);
			YW.ajax({
			    type: 'POST',
			    url: '${projectName }/c/admin/role/delete?id='+id,
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
						<button style="float:left;margin-top: 12px;padding:5px;cursor:pointer;height: 30px;  line-height: 20px;" onclick="roleAdd();">添加职位</button>
					</div>
					<table class="userList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>职位名称</td>
							<td>职位介绍</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result}" var="role" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td>${role.name}</td>
								<td>${role.duty}</td>
								<td>
									<a href="#" onclick="roleEdit('${role.id}');return false">修改</a>
									<a href="#" onclick="authEdit('${role.id}');return false">权限</a>
									<a href="#" onclick="roleDel('${role.id}');return false">删除</a>
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