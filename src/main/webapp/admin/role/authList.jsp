<%@page import="java.util.ArrayList"%>
<%@page import="com.kuaiyi.entity.RoleAuth"%>
<%@page import="java.io.File"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.kuaiyi.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String roleId = request.getParameter("roleId");
	try {
		String text = FileUtils.readFileToString(new File(request.getServletContext().getRealPath("/")+File.separator+"auths.json"), "utf8");
		JSONArray jarr = JSONArray.fromObject(text);
		request.setAttribute("list", jarr);
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	List<RoleAuth> result  = dao.listByParams(RoleAuth.class, "from RoleAuth where roleId=?", Integer.valueOf(roleId));
	StringBuilder sb = new StringBuilder("");
	for(RoleAuth auth : result){
		sb.append(auth.authId).append(",");
	}
	request.setAttribute("authIds", sb.toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>职位授权</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
var roleId;
function saveAuth(id){
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/role/addRoleAuth?roleId='+roleId+'&authId='+id,
	    mysuccess: function(data){
	    }
    });
}
	
function deleteAuth(id){
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/role/deleteRoleAuth?roleId='+roleId+'&authId='+id,
	    mysuccess: function(data){
	    }
    });
}
	
function jiancha(a,id){
  if (a.checked) {
  	saveAuth(id);
  }else {
  	deleteAuth(id);
  }
}

$(function(){
	roleId = getParam('roleId');
});
</script>
<body>
	<div class="body2">
		<div class="container_box cell_layout side_l">
			<div class="col_main">
				<div class=" notices_box">
					<form name="form1">
					<table class="roleList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>描述</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${list}" var="auth" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td>${auth.module}</td>
								<td>
									<input type="checkbox"  name="authId"
									 value="${auth.id}" <c:if  test="${fn:contains(authIds, auth.id.concat(','))}" >checked </c:if> onclick="jiancha(this,'${auth.id}')" />
								</td>
							</tr>
						</c:forEach>
					</table>
					</form>
				</div>
			</div>
		</div>

	</div>
</body>
</html>