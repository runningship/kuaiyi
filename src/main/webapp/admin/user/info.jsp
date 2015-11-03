<%@page import="com.youwei.kuaiyi.ThreadSessionHelper"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.kuaiyi.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	List<Map> result  = dao.listAsMap("select r.name as name , r.id as id from Role r , UserRole ur where ur.uid = ? and ur.roleId = r.id ",new Object[]{ThreadSessionHelper.getUser().id});
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
<title>我的资料</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">
function modifyPwd(){
	layer.open({
    	type: 2,
    	title: '修改密码',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['400px', '310px'],
	    content: 'pwd.jsp?uid='+${user.id},
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
		}
	}); 
}

function save(){
	var name = $('#name').val();
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
				<div class="mp_news_area notices_box" style="margin-top:20px;">
					<form name="form1" onsubmit="return false;" style="padding:20px">
					<input name="id" value="${user.id}" style="display:none" />
						<div class="form-group">
							<label>登录账号</label>
							<input name="account" id="account"  value="${user.account}" class="form-input" />
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
						</div>
						<div class="form-group">
							<label>用户密码</label>
							<input type="password" name="pwd" class="form-input"  disabled="disabled" value="******************" placeholder="无需修改请不用填写" /><a onclick="modifyPwd();" href="#">修改密码</a>
						</div>
						<div class="form-group action">
							<label class="label" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
							<div class="form-input btn-wrap" >
								<button onclick="save();return false;" class="form-button" style="float:right;cursor:pointer;height: 30px;  line-height: 20px;">保&nbsp;&nbsp;存</button>
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>

	</div>
</body>
</html>