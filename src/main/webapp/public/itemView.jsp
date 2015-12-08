<%@page import="com.kuaiyi.entity.Product"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="com.kuaiyi.entity.ProductItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
String qrCode = request.getParameter("qrCode");
ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
if(item==null){
	//404
	return;
}
request.setAttribute("item", item);

Product product = dao.get(Product.class, item.productId);
request.setAttribute("product", product);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
<title>产品信息</title>

<style type="text/css">
.conts img{width:100%;}
</style>
<script type="text/javascript">
window.onload=function(){
	//document.getElementById('qrCode').innerText=qrCode;
	//document.getElementById('lottery').innerText=lottery+'元';
}
</script>
</head>

<body style="background-color:white">
	<form name="form1" style="text-align:center;">
		<h2 style="text-align:center;">${product.title }</h2>
		<div style="color: #aaa;font-size: 1.0em;">(平台由安徽厚易科技有限公司提供)</div>
		<p style="margin: 10px 0;color: #999999;  background-color: #f4f4f4;  line-height: 36px">${product.addtime }</p>
		
		<div style="width:96%;text-align:left;    text-align: left;    margin-left: auto;    margin-right: auto;">
		<p>生产商   : ${product.vender }</p>
		<p>产地信息: ${product.verderPlace }</p>
		<p>规格信息: ${product.spec }</p>
		<p>批 次 号 : <span id="pici">${item.pici }</span></p>
		<p>产品编号 : <span id="qrCode">${item.qrCode}</span></p>
		<p>奖券金额 : <span id="lottery">10</span></p>
		<p>兑奖状态 :  未兑奖</p>
		</div>
		<div>
		<div style="position: relative;">
			<img src="youhuiquan.png" style="width:100%;z-index:9999;height:250pt;"/>
			<div style="    position: absolute;    top: 90pt;    font-size: 60pt;    left: 30%;    width: 40%;    text-align: center;color:#C19511;"><SUP style="font-size:25pt;color:chocolate;">￥</SUP>10</div>
			<div style="position:absolute; bottom: 10pt;width: 70%; left: 15%;height: 78pt; border: 2px solid red; line-height: 78pt;">
				<span>请输入兑奖码: </span><input style="height: 25pt;line-height: 25pt;font-size: 14pt;" /> <span style="padding: 8pt 10pt; background: rgb(255,72,92); color: white; font-weight: bold;">立即领取</span>
			</div>
		</div>
		
		<div class="conts" style="  width: 100%;  margin-left: auto;  margin-right: auto;">
			<p>${product.conts }</p>
		</div>

		</div>
</form>
</body></html>