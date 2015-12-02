<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="com.youwei.kuaiyi.ThreadSessionHelper"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.kuaiyi.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<Map> p = new Page<Map>();
	String currentPageNo =  request.getParameter("currentPageNo");
	String title =  request.getParameter("title");
	String sendName =  request.getParameter("sendName");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	StringBuilder hql = new StringBuilder("select n.title as title , n.addtime as addtime, n.id as id , u.name as sender ,nr.hasRead as hasRead ,nr.id as nrid from Notice n , NoticeReceiver nr ,  User u where n.id=nr.noticeId and u.id=nr.receiverId ");
	List<Object> params = new ArrayList<Object>();
	hql.append(" and nr.receiverId=?");
	params.add(ThreadSessionHelper.getUser().id);
	if(StringUtils.isNotEmpty(title)){
		hql.append(" and n.title like ?");
		params.add("%"+title+"%");
	}
	if(StringUtils.isNotEmpty(sendName)){
		hql.append(" and u.name like ?");
		params.add("%"+sendName+"%");
	}
	hql.append(" order by n.id desc");
	p  = dao.findPage(p, hql.toString(),true, params.toArray());
	request.setAttribute("page", p);

	request.setAttribute("title", title);
	request.setAttribute("sendName", sendName);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>收件箱</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
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


	function seeThis(id , nrid){
		layer.open({
	    	type: 2,
	    	title: '查看通知',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['600px', '600px'],
		    content: 'receiveInfo.jsp?id='+id+'&nrid='+nrid
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
					<form name="form1" type="form" method="post" action="inList.jsp?nav=sjx" style="">
						<span>标题: </span><input name="title" value="${title}"  style="height:26px;width:250px;">
						<span style="margin-left:50px;">发送人: </span><input name="sendName" value="${sendName}"  style="height:26px;width:200px;">
						<input style="margin-right:20px;float:right;margin-top:12px;height:28px;width:60px;cursor:pointer" type="submit" value="搜索"/>
					</form>
						</div>
					<table class="userList" cellspacing="0" style="width:100%">
						<tr style="background: aliceblue;">
							<td class="first">标题</td>
							<td width="100">发送人</td>
							<td width="180">发送时间</td>
						</tr>
						<c:forEach items="${page.result}" var="notice" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td class="first" <c:if test="${notice.hasRead==0 }">style="font-weight:bold"</c:if> >
									 <a href="#" onclick="seeThis(${notice.id} , ${notice.nrid })" >${notice.title}</a></td>
								<td>${notice.sender}</td>
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