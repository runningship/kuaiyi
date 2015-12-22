<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.houyi.entity.Product"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="com.houyi.entity.ProductItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
String qrCode = request.getParameter("qrCode");
if(StringUtils.isEmpty(qrCode)){
	qrCode = (String)request.getAttribute("qrCode");
}
ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
if(item==null){
	//404
	out.println("没有找打商品信息");
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
<link href="/public/mobile/css/reset.css" rel="stylesheet">
<link href="/public/mobile/css/style.css?2" rel="stylesheet">
<style type="text/css">
.conts img{width:100%;}
.product .bodyer .duijiang .img {height:140pt;}
.product .bodyer .duijiang .code{bottom:1pt;}
.product .bodyer .duijiang .code .erweima{height:70pt;}
.product .bodyer .duijiang .value{top:79pt;}
.product .bodyer .duijiang .value p{font-size:11pt;padding-top: 5pt;}
</style>
<script type="text/javascript">
window.onload=function(){
	//document.getElementById('qrCode').innerText=qrCode;
	//document.getElementById('lottery').innerText=lottery+'元';
}
</script>
</head>

<body class="product">
	<div class="bodyer">
		<h2 class="title"  id="title">${product.title }</h2>
		<div class="ads" >(平台由安徽厚易科技有限公司提供)</div>
		<p class="addtime" id="addtime">${product.addtime }</p>
		
		<div class="field">
		<p>生产商   : <span id="vender">${product.vender }</span></p>
		<p>产地信息: <span id="verderPlace">${product.verderPlace }</span></p>
		<p>规格信息: <span id="spec">${product.spec }</span></p>
		<p>批 次 号 : <span id="pici">${item.pici }</span></p>
		<p style="word-break: break-all;">产品编号 : <span id="qrCode">${item.qrCode }</span></p>
<!-- 		<p>奖券金额 : <span id="lottery">10</span></p> -->
		</div>
		<div>
		
		<div class="duijiang">
			<c:if test="${item.lottery >0 }">
			<img class="img" src="/public/youhuiquan.png"/>
			<div class="value" ><span id="value">${item.lottery}</span><SUP class=""><i class="iconfont unit">&#xe6d8;</i></SUP>
				<p>下载快易扫，千万优惠券等你来拿哦！</p>
			</div>
			</c:if>
			<div class="app" >
				<img class="erweima" src="/public/erweima.jpg?123"/>
			</div>
		</div>
		
		<div class="conts" style="  width: 100%;  margin-left: auto;  margin-right: auto;">
			<p id="conts">${product.conts }</p>
		</div>

		</div>
</div>
</body></html>