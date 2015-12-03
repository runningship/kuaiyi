<%@page import="com.kuaiyi.entity.ProductItem"%>
<%@page import="com.kuaiyi.entity.Product"%>
<%@page import="com.kuaiyi.entity.Article"%>
<%@page import="com.kuaiyi.entity.User"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String qrCode = request.getParameter("qrCode");
	ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
	Product product = dao.get(Product.class, item.productId);
	request.setAttribute("product", product);
	request.setAttribute("item", item);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>产品信息</title>
<%-- <jsp:include page="../inc/header.jsp"></jsp:include> --%>
<style type="text/css">
form p{font-size:2.5em}
form h2{font-size:4em}
.conts img{width:100%;}
</style>
<link rel="stylesheet" href="admin/info/add.css">
</head>
<script type="text/javascript">

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}

$(function(){
});

</script>
<body style="background-color:white">
	<form name="form1" style="text-align:center;">
		<h2 style="text-align:center;">${product.title }</h2>
		<p style="margin: 10px 0;color: #999999;  background-color: #f4f4f4;  line-height: 36px">${product.addtime }</p>
		
		<div style="width:96%;text-align:left;    text-align: left;    margin-left: auto;    margin-right: auto;">
		<p>生产商   : ${product.vender }</p>
		<p>产地信息: ${product.verderPlace }</p>
		<p>规格信息: ${product.spec }</p>
		<p>批 次 号 : ${item.pici }</p>
		<p>产品编号 : ${item.qrCode }</p>
		<p>兑奖状态 : <c:if test="${item.lotteryActive==1 }">已兑奖</c:if> <c:if test="${item.lotteryActive!=1 }">未兑奖</c:if></p>
		</div>
		<div>
		<img alt="" src="youhui.jpg" style="width:96%;z-index:9999;height:auto;">
		
		<div class="conts" style="  width: 100%;  margin-left: auto;  margin-right: auto;">
			${product.conts}
		</div>
	</form>
	
</body>
</html>