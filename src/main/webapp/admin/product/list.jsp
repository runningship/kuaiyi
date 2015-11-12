<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.youwei.kuaiyi.entity.Menu"%>
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
	Page<Map> p = new Page<Map>();
	String currentPageNo =  request.getParameter("currentPageNo");
	String searchText =  request.getParameter("searchText");
	
	request.setAttribute("page", p);
	request.setAttribute("searchText", searchText);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文章目录</title>

<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
	topMenuChange();
	if('${erjiId}'){
		$('#level_2').val('${erjiId}');
	}
});

	function infoDel(id){
		layer.confirm('删除后将无法恢复，是否确定删除', {icon: 3}, function(index){
		    layer.close(index);
			YW.ajax({
			    type: 'POST',
			    url: '${projectName }/c/admin/article/delete?id='+id,
			    mysuccess: function(data){
			        alert('删除成功');
			        window.location.reload();
			    }
		    });
		});
	}

function reloadWindow(){
	window.location.reload();
}

	function editThis(id){
		layer.open({
	    	type: 2,
	    	title: '修改文章',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['800px', '700px'],
		    content: 'editw.jsp?id='+id,
		    btn: ['确定','取消'],
		    yes:function(index){
		    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
			    return false;
			}
		}); 
	}

var SearchId;
function setSearch(obj){
	SearchId = obj.value;
	if (SearchId=='') {
		$('.erji').show();
	}else{
		$('.erji').hide();
		$('option[type="'+SearchId+'"]').show();
	}
}

function openView(id){
	layer.open({
    	type: 2,
    	title: '文章预览',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['600px', '800px'],
	    content: 'view.jsp?id='+id
	}); 
}

function topMenuChange(){
	$('#level_2 [pid]').css('display','none');
	$('#level_2 [pid='+$('#level_1').val()+']').css('display','');
	var arr = $('#level_2 [pid='+$('#level_1').val()+']');
	$('#level_2').val('');
}

function openAdd(id){
	layer.open({
    	type: 2,
    	title: '添加文章',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['800px', '650px'],
	    content: 'add3.jsp?parentId='+id,
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
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
						<c:if test="${session_auth_list.indexOf('$info_article')>-1 }">
							<button style="float:left;margin-top: 11px;padding:5px;margin-right:20px;cursor:pointer;height: 30px; line-height: 20px;" onclick="openAdd();">添 &nbsp;加</button>
						</c:if>
					<form name="form1" type="form" method="post" action="list3.jsp?nav=wzlb" style="">
							<select name="yijiId" style="height:32px;width:120px;word-wrap: normal;" id="level_1" onchange="topMenuChange()">
								<option value="">全部</option>
							<c:forEach items="${yijiList }" var="first">
								<option <c:if test="${first.id==yijiId}"> selected </c:if>  value="${first.id}">${first.name}</option>
							</c:forEach>
							</select>
							<select name="erjiId" style="height:32px;width:120px;word-wrap: normal;" id="level_2">
								<option value="">全部</option>
								<c:forEach items="${erjiList }" var="second">
									<option class="erji" pid="${second.parentId}" value="${second.id}" >${second.name}</option>
								</c:forEach>
							</select>
							<input name="searchText" value="${searchText}"  style="margin-left:50px;height:26px;width:300px;" placeholder="标题名称">
							<input style="margin-right:20px;float:right;margin-top:12px;height:28px;width:60px;cursor:pointer" type="submit" value="搜索"/>
					</form>
						</div>
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>标题</td>
							<td>栏目名称</td>
							<td>排序</td>
							<td>发布时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="article" varStatus="status">
							<tr class="statue_${status.index%2}">
							<td> <a href="#" onclick="openView(${article.artId});">${article.name }</a> </td> 
							<td>${article.fname}</td>
							<td>${article.orderx }</td> 
							<td><fmt:formatDate value="${article.addtime }" pattern="yyyy-MM-dd HH:mm"/></td> 
							<td>
								<c:if test="${session_auth_list.indexOf('$info_article')>-1 }"><a href="#" onclick="editThis(${article.artId})">修改</a></c:if> 
							 	<c:if test="${session_auth_list.indexOf('$info_article')>-1 }"><a href="#" onclick="infoDel(${article.artId})">删除</a></c:if></td>
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