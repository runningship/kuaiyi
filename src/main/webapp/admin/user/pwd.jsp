<%@page import="com.youwei.kuaiyi.entity.Group"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String uid = request.getParameter("uid");
	try{
	Group user = dao.get(Group.class, Integer.valueOf(uid));
	request.setAttribute("user", user);
	}catch(Exception ex){
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>修改密码</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="add.css">
<style type="text/css">
#pwd-table .form-input{width:240px;;}
.save{margin-right:15px;float:right;margin-top:30px;}
</style>
</head>
<script type="text/javascript">
function save(){
	var oldPwd = $('#oldPwd').val();
	var newPwd = $('#newPwd').val();
	var newPwd2 = $('#newPwd2').val();
	if (oldPwd=="") {
		alert('请输入原密码');
		return;
	};
	if (newPwd=="") {
		alert('请输入新密码');
		return;
	};
	if (newPwd.length<6) {
		alert('密码必须六位以上');
		return;
	};
	if (newPwd2=="") {
		alert('请再次输入新密码');
		return;
	};
	if (newPwd2!=newPwd) {
		alert('两次输入的密码不一样，请重新输入');
		return;
	};
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/user/modifyPwd',
	    data:a,
	    mysuccess: function(data){
	        alert('密码修改成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭   
	    }
    });
}
</script>
<body style="background-color:white">
	
	<form name="form1" class="add-form" onsubmit="save();">
		<input type="hidden"  name="uid" value="${user.id }"/>
		<table id="pwd-table">
			<tr class="form-group">
				<td><label class="label">原密码</label></td>
				<td><input type="password" name="oldPwd" id="oldPwd" class="form-input"  /></td>
			</tr>
			<tr class="form-group">
				<td><label class="label">新密码</label></td>
				<td><input type="password" name="newPwd" id="newPwd" class="form-input" /></td>
			</tr>
			<tr class="form-group">
				<td><label class="label">重复新密码</label></td>
				<td><input type="password" name="newPwd2" id="newPwd2" class="form-input"/></td>
			</tr>
			<tr style="display:none">
				<td colspan="2"><button onclick="save();return false;" class="form-button save">确&nbsp;&nbsp;定</button></td>
			</tr>
		</table>
	</form>
</body>
</html>