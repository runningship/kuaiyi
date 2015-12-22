<%@page import="com.houyi.util.DataHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.houyi.entity.Menu"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
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
	if(StringUtils.isNotEmpty(currentPageNo)){
		p.currentPageNo = Integer.valueOf(currentPageNo);	
	}
	String searchText =  request.getParameter("searchText");
	p = dao.findPage(p, "select id as id ,  title as title from Product where 1=1", true , new Object[]{});
	request.setAttribute("page", p);
	request.setAttribute("searchText", searchText);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>产品目录</title>
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
			    url: '${projectName }/c/admin/product/delete?id='+id,
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
	    	title: '编辑产品信息',
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

function topMenuChange(){
	$('#level_2 [pid]').css('display','none');
	$('#level_2 [pid='+$('#level_1').val()+']').css('display','');
	var arr = $('#level_2 [pid='+$('#level_1').val()+']');
	$('#level_2').val('');
}

function openAdd(id){
	layer.open({
    	type: 2,
    	title: '添加产品',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['800px', '650px'],
	    content: 'add.jsp',
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
							<form class="pageform" name="form1" type="form" method="post" action="list.jsp?nav=product" style="">
									<input type="hidden" name="currentPageNo" class="pageNo" value="${ page.currentPageNo}" />
									<input name="searchText" value="${searchText}"  style="margin-left:50px;height:26px;width:300px;margin-top: 12px;" placeholder="名称">
									<input style="margin-right:20px;float:right;margin-top:12px;height:28px;width:60px;cursor:pointer" type="submit" value="搜索"/>
							</form>
						</div>
						
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>标题</td>
							<td></td>
						</tr>
						<c:forEach items="${page.result }" var="product" varStatus="status">
						<tr class="statue_${status.index%2}">
							<td> <a href="#" onclick="editThis(${product.id});">${product.title }</a> </td> 
							<td style="width:80px;"> <a href="itemList.jsp?productId=${product.id }" >二维码</a> </td> 
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