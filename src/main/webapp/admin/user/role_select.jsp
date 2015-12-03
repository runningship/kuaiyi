<%@page import="com.kuaiyi.util.DataHelper"%>
<%@page import="com.kuaiyi.entity.UserRole"%>
<%@page import="com.kuaiyi.entity.Role"%>
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
	String ids =  request.getParameter("ids");
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	p  = dao.findPage(p,"from Role where isSystemRole=0 order by id desc");
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
var Ids=[];
var Roles=[];

function jiancha(a,id,name){
  if (a.checked) {
      Ids.push(id);
      Roles.push(name);
  }else {
    for(var i=0;i<Ids.length ;i++){
      if (Ids[i]==id) {
        Ids.splice(i,1);
        Roles.splice(i,1);
      };
    }
  }
}

function selectOver(){
  var ids = Ids.toString();
  var roles = Roles.toString();
  parent.setRoles(ids,roles);
  closeThis();
}


function closeThis(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}


$(function(){
	var ids = getParam('ids');
	ids = decodeURI(ids);
	var roles = getParam('names');
	roles = decodeURI(roles);
    if(ids!=""){
		Ids = ids.split("%2C");
		Roles = roles.split("%2C");
		for(var i=0;i<Ids.length ;i++){
			$('#'+Ids[i]).attr('checked',true);
		}
	}
});
</script>
<body style="background:white;">
	<div class="body2">
		<div class="cell_layout side_l">
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<table class="userList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>职位名称</td>
							<td>职位介绍</td>
							<td><a href="#" onclick="selectOver();">选择</a></td>
						</tr>
						<c:forEach items="${page.result}" var="role" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td id="name_${role.id}">${role.name}</td>
								<td>${role.duty}</td>
								<td>
									<input type="checkbox"  name="roleId" id="${role.id}"
									 value="${role.id}" onclick="jiancha(this,'${role.id}','${role.name}')" />
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