<%@page import="com.houyi.entity.Role"%>
<%@page import="com.houyi.entity.UserRole"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.houyi.entity.User"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	User user = dao.get(User.class, id);
	request.setAttribute("user", user);
	List<Map> result  = dao.listAsMap("select r.name as name , r.id as id from Role r , UserRole ur where ur.uid = ? and ur.roleId = r.id ",new Object[]{id});
	StringBuilder roleIds = new StringBuilder("");
	StringBuilder roleNames = new StringBuilder("");
	for(Map m : result){
		roleIds.append(m.get("id")).append(",");
		roleNames.append(m.get("name")).append(",");
	}
	String roleId = roleIds.toString();
	String roleName = roleNames.toString();
	if(!roleId.isEmpty()){
		roleId = roleId.substring(0,roleId.length()-1);
		roleName = roleName.substring(0,roleName.length()-1);
	}
	request.setAttribute("roleIds", roleId);
	request.setAttribute("roleName", roleName);
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
	if (account=="") {
		alert('用户账号不能为空');
		return;
	};
	if (name=="") {
		alert('用户名不能为空');
		return;
	};
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/user/update',
	    data:a,
	    mysuccess: function(data){
	        alert('修改成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.reloadWindow();
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

function setPWD(){
	$('#pwd').attr('disabled',false);
}

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}
</script>
<body style="background-color:white">
	<form name="form1" onsubmit="save();return false;" style="padding:20px">
	<input name="id" value="${user.id}" style="display:none" />
	<input name="roleIds" id="roleIds" value="${roleIds}" style="display:none" />
		<div class="form-group">
			<label>登录账号</label>
			<input name="account" id="account" value="${user.account}" class="form-input" />
		</div>
		<div class="form-group">
			<label>用户姓名</label>
			<input name="name" id="name" value="${user.name}" class="form-input"/>
		</div>
		<div class="form-group">
			<label>用户电话</label>
			<input name="tel" value="${user.tel}"  class="form-input"/>
		</div>
		<div class="form-group">
			<label>用户职位</label>
			<input name="roleName" id="roleName" readonly="readonly" class="form-input" value="${roleName}"/>
			<c:if test="${user.isSuperAdmin!=1 }"><a onclick="editRole();return false" href="#">设置</a></c:if>
		</div>
		<div class="form-group">
			<label>用户密码</label>
			<input type="password" name="pwd" id="pwd" class="form-input" placeholder="********************" disabled="disabled" />
			<a onclick="setPWD();return false" href="#">重置</a>
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