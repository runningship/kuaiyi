<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

function prePage(currentPageNo){
	currentPageNo--;
	window.location = window.location.pathname+"?currentPageNo="+currentPageNo;
}

function nextPage(currentPageNo){
	currentPageNo++;
	window.location = window.location.pathname+"?currentPageNo="+currentPageNo;
}

function jumpPage(totalPageCount){
	currentPageNo = $('#currentPageNo').val();
	if (currentPageNo>totalPageCount||currentPageNo<=0) {
		alert('请输入正确的页码!');
		return;
	};
	window.location = window.location.pathname+"?currentPageNo="+currentPageNo;
}
</script>

<div class="pagination_wrp">
	<div class="pagination">
		<span class="page_nav_area">
			<c:if test="${page.currentPageNo!=1}">
				<a onclick="prePage(${page.currentPageNo});" href="javascript:void(0);" class="btn page_prev" > <i class="arrow"></i></a> 
			</c:if>
			<span class="page_num"> <label>${page.currentPageNo }</label> <span class="num_gap">/</span> <label>${page.totalPageCount }</label></span>
			 <c:if test="${page.currentPageNo<page.totalPageCount}">
				<a href="javascript:void(0);" class="btn page_next" onclick="nextPage(${page.currentPageNo});" > <i class="arrow"></i></a>
			</c:if>
		</span> 
		<span class="goto_area"> <input type="text" id="currentPageNo"> <a onclick="jumpPage(${page.totalPageCount})" href="javascript:void(0);" class="btn page_go">跳转</a>
		</span>
	</div>
</div>