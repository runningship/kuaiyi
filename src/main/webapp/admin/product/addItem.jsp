<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.kuaiyi.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%
	String productId =  request.getParameter("productId");
 	request.setAttribute("productId", productId);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>二维码</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.all.yw.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">
function save(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/product/addItems',
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

</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="save();">
		<input name="productId" id="productId" value="${productId }" type="hidden" />

		<div class=" table">
			<div class="tr">
				<div class="th"><label class="label">数量</label></div>
				<div class="td" style="width:450px;"><input name="count"  class="form-input" /></div>
			</div>
			
			<div class="tr">
				<div class="th"><label class="label">奖券金额</label></div>
				<div class="td" style="width:450px;"><input name="lottery"   class="form-input" /></div>
			</div>
			
			<div class="tr">
				<div class="th"><label class="label">批次号</label></div>
				<div class="td" style="width:450px;"><input name="pici" class="form-input" /></div>
			</div>
			
		</div>
		
		<div class="form-group">
			
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