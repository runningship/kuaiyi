<%@page import="com.kuaiyi.util.DataHelper"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.kuaiyi.ThreadSessionHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kuaiyi.entity.Notice"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<Notice> p = new Page<Notice>();
	String currentPageNo =  request.getParameter("currentPageNo");
	String title =  request.getParameter("title");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	StringBuilder hql = new StringBuilder("from Notice ");
	List<Object> params = new ArrayList<Object>();
	hql.append(" where senderId = ?");
	params.add(ThreadSessionHelper.getUser().id);
	if(StringUtils.isNotEmpty(title)){
		hql.append(" and title like ?");
		params.add("%"+title+"%");
	}
		hql.append(" order by id desc");
	p  = dao.findPage(p, hql.toString(), params.toArray());
	request.setAttribute("page", p);

	request.setAttribute("title", title);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>已发送</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
<style type="text/css">
.first{padding-left:10px;}
</style>
</head>
<script type="text/javascript">
	function userAdd(){
		layer.open({
	    	type: 2,
	    	title: '添加用户',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['400px', '350px'],
		    content: 'add.jsp'
		}); 
	}

	function userEdit(id){
		layer.open({
	    	type: 2,
	    	title: '修改用户',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['400px', '350px'],
		    content: 'edit.jsp?id='+id
		}); 
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

	function seeThis(id){
		layer.open({
	    	type: 2,
	    	title: '查看通知',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['600px', '600px'],
		    content: 'sendInfo.jsp?id='+id
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
					<form name="form1" type="form" method="post" action="outList.jsp?nav=fjx" style="">
						<span>标题: </span><input name="title" value="${title}"  style="height:26px;width:250px;">
						<input style="margin-right:20px;float:right;margin-top:12px;height:28px;width:60px;cursor:pointer" type="submit" value="搜索"/>
					</form>
					</div>
					<table class="userList" cellspacing="0" style="width:100%">
						<tr style="background: aliceblue;">
							<td class="first">标题</td>
							<td width="180">发送时间</td>
						</tr>
						<c:forEach items="${page.result}" var="notice" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td class="first"><a href="#" onclick="seeThis(${notice.id})">${notice.title}</a></td>
								<td><fmt:formatDate value="${notice.addtime }" pattern="yyyy-MM-dd HH:mm"/></td>
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