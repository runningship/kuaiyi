<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.kuaiyi.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
 List<Menu> list1 = dao.listByParams(Menu.class, "from Menu where parentId is null ");
 request.setAttribute("list1", list1);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.all.yw.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" href="add.css">
<style type="text/css">
select{
width: 98%;
  height: 30px;
}
.first{width:60px;}
</style>
</head>
<script type="text/javascript">
function save(){
	if (!$('#name').val()) {
    	alert('栏目名称不能为空');
    	return;
    }
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/menu/save',
	    data:a,
	    mysuccess: function(data){
	        alert('添加成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.reloadWindow();
			parent.layer.close(index); //再执行关闭   
	    }
    });
}

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}

$(function(){
});

</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="save();">
		<input type="hidden" name="isImgMenu" value="0"/>
		<table style="width:80%;  margin-right: auto;margin-left:auto;">
			<tr>
				<td class="first"><label >父栏目</label></td>
				<td><select name="parentId">
							<option value="">无</option>
							<c:forEach items="${list1 }" var="menu" >
							<option value="${menu.id }">${menu.name}</option>
							</c:forEach>
						</select>
				</td>
			</tr>
			<tr>
				<td class="first"><label>名&nbsp;称</label></td>
				<td><input name="name" id="name" class="form-input" /></td>
			</tr>
			<tr>
				<td class="first"><label >序&nbsp;号</label></td>
				<td><input name="orderx" value="100" class="form-input" /></td>
			</tr>
			<tr class="hidden">
				<td class="first"></td>
				<td ><button onclick="save();return false;" class="form-button fr save hand" style="margin-right:2%;margin-top:20px;">保&nbsp;&nbsp;存</button></td>
			</tr>
		</table>
		<div class="form-group">
		</div>
	</form>
</body>
</html>