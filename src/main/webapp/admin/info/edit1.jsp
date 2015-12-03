<%@page import="com.kuaiyi.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	Menu menu = dao.get(Menu.class, id);
	request.setAttribute("menu", menu);
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
</head>
<script type="text/javascript">
var index = parent.layer.getFrameIndex(window.name), //获取窗口索引
id=${menu.id};
function save(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/menu/update',
	    data:a,
	    mysuccess: function(data){
	        alert('修改成功');
	        //parent.('#tr'+)
			parent.reloadWindow();
			parent.layer.close(index); //再执行关闭   
	    }
    });
}

function closeThis(){
	parent.layer.close(index); //再执行关闭   
}
function a(){
	alert(1)
}

$(function(){
});

</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="return false;">
	<input name="id" value="${menu.id}" style="display:none">
		<table style="width:80%;  margin-right: auto;margin-left:auto;">
			<tr>
				<td class="first"><label>名&nbsp;称</label></td>
				<td><input name="name" id="name" value="${menu.name}" class="form-input" /></td>
			</tr>
			<tr>
				<td class="first"><label >序&nbsp;号</label></td>
				<td><input name="orderx" value="${menu.orderx}" class="form-input" /></td>
			</tr>
		</table>
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