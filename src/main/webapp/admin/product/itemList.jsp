<%@page import="com.kuaiyi.entity.Product"%>
<%@page import="com.kuaiyi.entity.ProductItem"%>
<%@page import="com.kuaiyi.util.DataHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.kuaiyi.entity.Menu"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<ProductItem> p = new Page<ProductItem>();
	String currentPageNo =  request.getParameter("currentPageNo");
	String productId =  request.getParameter("productId");
	Product product = dao.get(Product.class, Integer.valueOf(productId));
	String qrCode =  request.getParameter("qrCode");
	p = dao.findPage(p, "from ProductItem where productId=?", new Object[]{Integer.valueOf(productId)});
	request.setAttribute("page", p);
	request.setAttribute("productId", productId);
	request.setAttribute("qrCode", qrCode);
	request.setAttribute("product", product);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>产品目录</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
});

function infoDel(id){
	layer.confirm('删除后将无法恢复，是否确定删除', {icon: 3}, function(index){
	    layer.close(index);
		YW.ajax({
		    type: 'POST',
		    url: '${projectName }/c/admin/product/delete?id='+id,
		    mysuccess: function(data){
		        alert('删除成功');
		        window.location.reload();
		    }
	    });
	});
}

function reloadWindow(){
	window.location.reload();
}

function editThis(id){
	layer.open({
    	type: 2,
    	title: '编辑产品信息',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['800px', '700px'],
	    content: 'editw.jsp?id='+id,
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
		}
	}); 
}

function openAdd(id){
	layer.open({
    	type: 2,
    	title: '添加二维码',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['500px', '270px'],
	    content: 'addItem.jsp?productId=${productId}',
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
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
				<div class="mp_news_area notices_box">
						<div class="title_bar" style="height:50px;line-height:50px;">
							<c:if test="${session_auth_list.indexOf('$info_article')>-1 }">
								<button style="float:left;margin-top: 11px;padding:5px;margin-right:20px;cursor:pointer;height: 30px; line-height: 20px;" onclick="openAdd();">添 &nbsp;加</button>
							</c:if>
							<form name="form1" type="form" method="post" action="list3.jsp?nav=wzlb" style="">
									<input name="qrCode" value="${qrCode}"  style="margin-left:50px;height:26px;width:300px;margin-top: 12px;" placeholder="二维码(唯一码)">
									<input style="margin-right:20px;float:right;margin-top:12px;height:28px;width:60px;cursor:pointer" type="submit" value="搜索"/>
							</form>
						</div>
						<div style="font-size: 21px;    height: 50px;    line-height: 50px;    text-align: center;    color: #888;">
							${product.title}
						</div>
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>唯一码</td>
							<td>防伪码</td>
							<td>奖券金额</td>
							<td>批次号</td>
							<td>兑奖状态</td>
							<td>二维码</td>
						</tr>
						<c:forEach items="${page.result }" var="item" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td> ${item.qrCode } </td> 
								<td> ${item.verifyCode }</td>
								<td> ${item.lottery }元</td>
								<td> ${item.pici }</td>
								<td><c:if test="${item.lotteryActive==1 }">已兑奖</c:if> <c:if test="${item.lotteryActive!=1 }">未兑奖</c:if></td> 
								<td><a href="${projectName }/public/qrtest.jsp?id=${item.id}" target="_blank">查看</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<jsp:include page="../inc/pagination.jsp"></jsp:include>

			</div>
		</div>

	</div>
</body>
</html>