<%@page import="com.youwei.kuaiyi.cache.ConfigCache"%>
<%@page import="com.youwei.kuaiyi.MakesiteConstant"%>
<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.youwei.kuaiyi.ThreadSessionHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.kuaiyi.entity.SharedFile"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String download_prefix = ConfigCache.get("download_prefix", "");
	request.setAttribute("download_prefix", download_prefix);
	Page<Map> p = new Page<Map>();
	String currentPageNo =  request.getParameter("currentPageNo");
	String filename =  request.getParameter("filename");
	String sendName =  request.getParameter("sendName");
	String _site =  DataHelper.getServerName(request);
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	StringBuilder hql = new StringBuilder("select sf.name as name, sf.id as fid, sf.uid as uid, sf.uploadTime as uploadTime, sf.size as size, u.name as uname  ,sf.path as path, sf.publish as publish from SharedFile sf left join uc_user u on sf.uid = u.id where 1=1 ");
	List<Object> params = new ArrayList<Object>();
	if(StringUtils.isNotEmpty(filename)){
		hql.append(" and sf.name like ?");
		params.add("%"+filename+"%");
	}
	if(StringUtils.isNotEmpty(sendName)){
		hql.append(" and u.name like ?");
		params.add("%"+sendName+"%");
	}
	if(StringUtils.isNotEmpty(_site)){
		hql.append(" and sf._site = ?");
		params.add(_site);
	}
	String session_auth_list=(String)session.getAttribute(MakesiteConstant.Session_Auth_List);
	if(StringUtils.isEmpty(session_auth_list)  || !session_auth_list.contains("$file_shenhe")){
		//没有审核权限
		hql.append(" and (sf.uid = ? or sf.publish=1)");
		params.add(ThreadSessionHelper.getUser().id);
	}
	
	hql.append(" order by sf.id desc");
	p  = dao.findPageBySql(p, hql.toString(), params.toArray());
	request.setAttribute("page", p);
	request.setAttribute("filename", filename);
	request.setAttribute("sendName", sendName);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文件共享</title>

<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="../js/uploadify/uploadify.css">
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
	initUploadHouseImage('fileUploadBtn' , '${projectName}');
});

function fileDel(id){
	layer.confirm('删除后将无法恢复，是否确定删除', {icon: 3}, function(index){
	    layer.close(index);
		YW.ajax({
		    type: 'POST',
		    url: '${projectName }/c/admin/file/delete?id='+id,
		    mysuccess: function(data){
		        alert('删除成功');
		        window.location.reload();
		    }
	    });
	});
}
function fileShenHe(id , btn){
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/file/publish?id='+id,
	    mysuccess: function(data){
	        if(data.publish){
	        	$(btn).text('已公开');
	        }else{
	        	$(btn).text('未公开');
	        }
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
					<div class="title_bar" style="height:50px;line-height:50px;">
					<form name="form1" type="form" method="post" action="list.jsp?nav=wjgx" style="">
							<span>文件名: </span><input name="filename" value="${filename}"  style="height:26px;width:200px;">
							<span style="margin-left:20px;">上传人: </span><input name="sendName" value="${sendName}"  style="height:26px;width:200px;">
							<input style="margin-left:20px;margin-top:12px;height:28px;width:60px;cursor:pointer" type="submit" value="搜索"/>
							<button id="fileUploadBtn" style="float:right;margin-top:-35px;padding:5px;">上 &nbsp;传</button>
					</form>
						
					</div>
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>文件名</td>
							<td>文件大小</td>
							<td> 上传人</td>
							<td>上传时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="file" varStatus="status">
							<tr class="statue_${status.index%2}">
							<td><a href='${download_prefix }/upload/${file.path }' target="_blank "> ${file.name } </a></td> 
							<c:choose>
								<c:when test="${file.size/1000/1000 >=0.99}">  
									<td><fmt:formatNumber type="number" value="${file.size/1000/1000 }" maxFractionDigits="1"/>M</td>
							  	</c:when> 
  								<c:otherwise>  
									<td><fmt:formatNumber type="number" value="${file.size/1000}" maxFractionDigits="1"/>K</td>
								</c:otherwise> 
							</c:choose>
							<td>${file.uname}</td>
							<td><fmt:formatDate value="${file.uploadTime }" pattern="yyyy-MM-dd HH:mm"/></td>
							<td>
								<c:if test="${session_auth_list.indexOf('$file_shenhe')>-1 }">
								<a href="#"  onclick="fileShenHe(${file.fid} , this)"><c:if test="${file.publish ==1}">已公开</c:if><c:if test="${file.publish ==0}">未公开</c:if></a>
								</c:if>
								<c:if test="${session_auth_list.indexOf('$file_shenhe')>-1 || file.uid==user.id}"><a href="#"  onclick="fileDel(${file.fid})">删除</a></c:if>
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