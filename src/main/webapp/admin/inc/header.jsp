<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<% 
	//String projectName=request.getServletContext().getServletContextName();
	//request.setAttribute("projectName", projectName);
	System.out.println(request.getAttribute("projectName"));
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="${projectName }/admin/style/head.css">
<link rel="stylesheet" type="text/css" href="${projectName }/admin/style/base.css">
<link rel="stylesheet" href="${projectName }/admin/style/pageIndex.css">
<link rel="stylesheet" href="${projectName }/admin/style/pagination.css">
<script type="text/javascript" src="${projectName }/admin/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${projectName }/admin/js/buildHtml.js"></script>
<script type="text/javascript" src="${projectName }/admin/js/json2.js"></script>
<script type="text/javascript" src="${projectName }/admin/js/layer-v1.9.3/layer/layer.js"></script>

