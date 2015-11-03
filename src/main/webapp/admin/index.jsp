<%@page import="com.youwei.kuaiyi.user.UserService"%>
<%@page import="com.youwei.kuaiyi.ThreadSessionHelper"%>
<%@page import="com.youwei.kuaiyi.entity.Menu"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
long yiji = dao.countHql("SELECT COUNT(*) FROM Menu where parentId is null and _site = ?" , DataHelper.getServerName(request));
request.setAttribute("yiji", yiji);

long erji = dao.countHql("SELECT COUNT(*) FROM Menu where parentId is not null and _site = ?" , DataHelper.getServerName(request));
request.setAttribute("erji", erji);

long Artcount = dao.countHql("SELECT COUNT(*) FROM Article where  _site = ?" , DataHelper.getServerName(request));
request.setAttribute("Artcount", Artcount);

long ucount = dao.countHql("SELECT COUNT(*) FROM User where  _site = ?" , DataHelper.getServerName(request));
request.setAttribute("ucount", ucount);

long nrcount = dao.countHql("SELECT COUNT(*) FROM NoticeReceiver where receiverId = ?" ,ThreadSessionHelper.getUser().id);
request.setAttribute("nrcount", nrcount);

long ncount = dao.countHql("SELECT COUNT(*) FROM Notice where senderId = ? and _site = ?" ,ThreadSessionHelper.getUser().id , DataHelper.getServerName(request));
request.setAttribute("ncount", ncount);

long filecount = dao.countHql("SELECT COUNT(*) FROM SharedFile where _site = ?" , DataHelper.getServerName(request));
request.setAttribute("filecount", filecount);

Integer uonline = UserService.onlineUserCountMap.get(DataHelper.getServerName(request));
request.setAttribute("uonline", uonline);

request.setAttribute("domainSize",DataHelper.getDiskSize(DataHelper.getServerName(request)));
%>
<!DOCTYPE html>
<html>
<head>
<title>管理后台</title>
<jsp:include page="inc/header.jsp"></jsp:include>
<script type="text/javascript">
function openWin(){
	layer.open({
	    type: 2,
	    area: ['700px', '530px'],
	    fix: false, //不固定
	    maxmin: true,
	    content: 'http://www.baidu.com'
	});
}
</script>
<style type="text/css">
.mp_news_item a{color:#459ae9}
</style>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<a href="#" ></a>
					<div class="title_bar">
						<h3>系统信息</h3>
					</div>
					<ul class="mp_news_list">

						<li class="mp_news_item"><a > <strong>一级栏目数
							</strong> <span class="read_more">${yiji}个</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>二级栏目数
							</strong> <span class="read_more">${erji}个</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>文章数量
							</strong> <span class="read_more">${Artcount}篇</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>用户数
							</strong> <span class="read_more">${ucount}人</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>在线用户数
							</strong> <span class="read_more">${uonline}人</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>收到的通知
							</strong> <span class="read_more">${nrcount}条</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>我发的通知
							</strong> <span class="read_more">${ncount}条</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>共享文件数
							</strong> <span class="read_more">${filecount}条</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>占用磁盘空间</strong> 
							<c:choose>
								<c:when test="${domainSize/1024/1024 >=0.99}">  
									<span class="read_more"><fmt:formatNumber type="number" value="${domainSize/1024/1024 }" maxFractionDigits="1"/>M
							  	</c:when> 
  								<c:otherwise>  
									<span class="read_more"><fmt:formatNumber type="number" value="${domainSize/1024}" maxFractionDigits="1"/>K</span>
								</c:otherwise> 
							</c:choose>
						</a></li>
					</ul>

				</div>

			</div>
		</div>

	</div>
	<div class="foot"></div>

</body>
</html>