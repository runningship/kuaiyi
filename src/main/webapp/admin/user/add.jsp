<%@page import="com.youwei.kuaiyi.entity.Group"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String parentId = request.getParameter("groupId");
	request.setAttribute("groupName", "无");
	try{
	Group group = dao.get(Group.class, Integer.valueOf(parentId));
	if(group!=null){
		request.setAttribute("groupId", group.id);
		request.setAttribute("groupName", group.name);
	}
	}catch(Exception ex){
	}
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
	var account = $('#account').val();
	var name = $('#name').val();
	var pwd = $('#pwd').val();
	if (account=="") {
		alert('用户账号不能为空');
		return;
	};
	if (name=="") {
		alert('用户名不能为空');
		return;
	};
	if (pwd=="") {
		alert('密码不能为空');
		return;
	};
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/user/save',
	    data:a,
	    mysuccess: function(data){
	        alert('添加成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.window.location.reload();
			parent.layer.close(index); //再执行关闭   
	    }
    });
}

function setRoles(roleIds,roleNames){
	$('#roleIds').val(roleIds);
	$('#roleName').val(roleNames);
}

function editRole(){
	var ids = $('#roleIds').val();
	var names = $('#roleName').val();
	layer.open({
    	type: 2,
    	title: '选择职位',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['400px', '400px'],
	    content: 'role_select.jsp?ids='+ids+'&names='+names
	}); 
}

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}
</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="save();">
		<input type="hidden"  id="groupId" name="groupId" value="${groupId }"/>
		<input name="roleIds" id="roleIds" type="hidden" />
		<div class="form-group">
			<label class="label">部门名称</label>
			<input name="groupName" id="groupName" class="form-input"  value="${groupName }"/>
		</div>
		<div class="form-group">
			<label class="label">登录账号</label>
			<input name="account" id="account" class="form-input" />
		</div>
		<div class="form-group">
			<label class="label">用户姓名</label>
			<input name="name" id="name" class="form-input"/>
		</div>
		<div class="form-group">
			<label class="label">用户电话</label>
			<input name="tel"  id="tel" class="form-input"/>
		</div>
		<div class="form-group">
			<label class="label">用户职位</label>
			<input name="roleName" id="roleName" class="form-input"/>
			<a onclick="editRole();" href="#">设置</a>
		</div>
		<div class="form-group">
			<label class="label">用户密码</label>
			<input type="password" name="pwd" id="pwd" class="form-input" />
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