<%@page import="com.houyi.MakesiteConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//String authList = (String)request.getSession().getAttribute(MakesiteConstant.Session_Auth_List);
//request.setAttribute(MakesiteConstant.Session_Auth_List, authList);
%>
    <script type="text/javascript">
    $(function(){
    	var nav = getParam('nav');
    	$('a[data-id='+nav+']').addClass('selected');
    });
</script>
<div class="col_side">
	<div class="menu_box">
		 <dl class="menu no_extra">
			<dt class="menu_title">
				<i class="iconfont">&#xe60c;</i>
				信息发布
			</dt>
			<dd class="menu_item ">
				<a data-id="lmgl" href="${projectName }/admin/info/menu.jsp?nav=lmgl">栏目管理</a>
			</dd>
			<dd class="menu_item ">
				<a data-id="wzlb" href="${projectName }/admin/info/list3.jsp?nav=wzlb">文章列表</a>
			</dd>
		</dl>
		
		<dl class="menu no_extra">
			<dt class="menu_title">
				<i class="iconfont">&#xe60c;</i>
				产品管理
			</dt>
			<dd class="menu_item ">
				<a data-id="product" href="${projectName }/admin/product/list.jsp?nav=product">产品信息</a>
			</dd>
		</dl>
		
		<dl class="menu ">
			<dt class="menu_title clickable">
				<a data-id="me" href="${projectName }/admin/user/info.jsp?nav=me">
				<i class="iconfont">&#xe60f;</i>
				我的资料
				</a>
			</dt>
		</dl>
		<dl class="menu ">
			<dt class="menu_title">
				<i class="iconfont">&#xe601;</i>
				用户管理
			</dt>
			<dd class="menu_item ">
				<a data-id="zwqx" href="${projectName }/admin/role/roleList.jsp?nav=zwqx">职位权限</a>
			</dd>
			<dd class="menu_item ">
				<a data-id="yglb" href="${projectName }/admin/user/list.jsp?nav=yglb">员工列表</a>
			</dd>
		</dl>
	</div>

</div>