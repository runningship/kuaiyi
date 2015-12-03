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
	Integer id = Integer.valueOf(request.getParameter("id"));
	Article article = dao.get(Article.class, id);
	request.setAttribute("article", article);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文章预览</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<!-- <link href="../js/video-js/video-js.css" rel="stylesheet">   -->
<!-- <script src="../js/video-js/video.js" rel="stylesheet"></script>  -->
<style type="text/css">
.edui-upload-video{margin-left:auto;margin-right:auto;}
</style>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}

$(function(){
	// $('#_html5_api').trigger('play');
	//$('video').trigger('play');
	//setTimeout(function (){$('video').trigger('pause');},100);
	/* $('.video-js').each(function(index,obj){
		videojs(obj).ready(function(){
		  var myPlayer = this;
		  myPlayer.play();
		  setTimeout(function(){
			  myPlayer.pause();
		  },300);
		  //myPlayer.pause();
		});
	}); */
	
});

</script>
<body style="background-color:white">
	<form name="form1">
		<h2 style="text-align:center;">${article.name }</h2>
		<p style="margin: 10px 0;  text-align: center;  color: #999999;  background-color: #f4f4f4;  line-height: 36px">${article.addtime }</p>
		<div style="  width: 94%;  margin-left: auto;  margin-right: auto;">
			${article.conts}
		</div>
	</form>
</body>
</html>