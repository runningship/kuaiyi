<%@page import="com.houyi.entity.Group"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String id = request.getParameter("groupId");
	Group group = dao.get(Group.class, Integer.valueOf(id));
	Group parent = dao.get(Group.class, group.parentId);
	request.setAttribute("group", group);
	request.setAttribute("parent", parent);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">
function save(){
	var account = $('#name').val();
	if (account=="") {
		alert('部门名不能为空');
		return;
	};
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/group/update',
	    data:a,
	    mysuccess: function(data){
	        alert('修改成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.window.location.reload();
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
		<input type="hidden"  id="id" name="id" value="${group.id }"/>
		<div class="form-group">
			<label class="label">上级部门</label>
			<input class="form-input" value="${parent.name }" disabled="disabled"/>
		</div>
		<div class="form-group">
			<label class="label">部门名称</label>
			<input name="name" id="name" class="form-input" value="${group.name }" />
		</div>
		
		<div class="form-group action hidden">
			<label class="label" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<div class="form-input btn-wrap" >
				<button onclick="save();return false;" class="form-button save">保&nbsp;&nbsp;存</button>
				<button onclick="closeThis();return false;" class="form-button cancel">取&nbsp;&nbsp;消</button>
			</div>
		</div>
	</form>
</body>
</html>