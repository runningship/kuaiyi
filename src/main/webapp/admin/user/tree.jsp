<%@page import="org.bc.sdak.Page"%>
<%@page import="com.kuaiyi.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>组织架构</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link href="../js/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<link href="../js/zTree_v3/css/div.css" rel="stylesheet">
<script type="text/javascript" src="../js/zTree_v3/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
var parentGroupId='';
var parentGroupName='';
var currentUid='';
var showMenu;
var setting = {
  view: {
    showIcon: false,
    addDiyDom: addDiyDom,
    dblClickExpand: false
  },
  data: {
  },
  callback: {
    onClick: OnRightClick
  },
  check:{
    enable:false
  }
};

$(function(){
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/user/getUserTree',
	    mysuccess: function(data){
			$.fn.zTree.init($("#treeDemo"), setting ,data);
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	 		treeObj.expandAll2();
	    }
    });
	
	document.oncontextmenu=function(){
		window.event.returnValue=false;
		return false;
	};
});

function addDiyDom(treeId, treeNode) {
	  console.log(treeId);
	  var aObj = $("#" + treeNode.tId + "_a");
	  aObj.css('display','inline');

	  aObj.parent().addClass('a_'+treeNode.type);
	  if(treeNode.type=='group'){
		  aObj.prepend('<span class="group"></span>');  
	  }else{
		  aObj.prepend('<span class="user"></span>');
	  }
	  if(treeNode.cnum!=null){
	    var cnumStr = '<span class="">'+ treeNode.cnum +' </span>';
	    aObj.prepend(cnumStr);  
	  }
	}
	
function zTreeBeforeAsync(treeId, treeNode) {
	if(treeNode){
		parentGroupId = treeNode.id;
	}
};

function onCheck(event, treeId, treeNode){
  console.log(treeNode.id);
}

function banUser(){
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/user/banUser?groupId='+parentGroupId+'&uid='+currentUid,
	    mysuccess: function(data){
	        alert('移出成功');
			window.location.reload();
	    }
    });
}

function deleteGroup(){
	layer.confirm('删除后将无法恢复，是否确定删除', {icon: 3}, function(index){
	    layer.close(index);
		YW.ajax({
		    type: 'POST',
		    url: '${projectName }/c/admin/group/delete?id='+parentGroupId,
		    mysuccess: function(data){
		        alert('删除成功');
				window.location.reload();
		    }
	    });
	});
}

function sendNotice(){
	window.location="${projectName }/admin/notice/add.jsp?nav=ftz&groupId="+parentGroupId;
}

function addTopGroup(){
	layer.open({
    	type: 2,
    	title: '添加部门',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['400px', '210px'],
	    content: '../group/add.jsp',
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
		}
	}); 
}
function addGroup(){
	layer.open({
    	type: 2,
    	title: '添加部门',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['400px', '210px'],
	    content: '../group/add.jsp?parentId='+parentGroupId+'&parentName='+parentGroupName,
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
		}
	}); 
}

function editGroup(){
	layer.open({
    	type: 2,
    	title: '修改部门',
	    shadeClose: false,
	    shade: 0.5,
		area: ['400px', '210px'],
	    content: '../group/edit.jsp?groupId='+parentGroupId,
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
		}
	}); 
}

function addUser(){
	layer.open({
    	type: 2,
    	title: '添加新用户',
	    shadeClose: false,
	    shade: 0.5,
		area: ['500px', '420px'],
	    content: 'add.jsp?groupId='+parentGroupId,
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
		}
	}); 
}

function editUser(id){
	layer.open({
    	type: 2,
    	title: '修改用户',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['500px', '500px'],
	    content: 'edit.jsp?id='+currentUid,
	    btn: ['确定','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
		}
	}); 
}

function inviteUser(){
	layer.open({
    	type: 2,
    	title: '添加已有用户',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['600px', '636px'],
	    content: 'selectUser.jsp?groupId='+parentGroupId,
	    btn: ['加入','取消'],
	    yes:function(index){
	    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
		    return false;
		}
	}); 
}

function OnRightClick(event, treeId, treeNode) {
  var treeObj = $.fn.zTree.getZTreeObj(treeId);
  treeObj.selectNode(treeNode);
  if(treeNode.type=='group'){
	  $('#userMenu').hide();
	  $('#groupMenu').show();
	  parentGroupId = treeNode.id;
	  parentGroupName = treeNode.name;
  }else{
	  parentGroupId = treeNode.getParentNode().id;
	  parentGroupName = treeNode.getParentNode().name;
	  currentUid = treeNode.id;
	  $('#groupMenu').hide();
	  $('#userMenu').show();
  }
  
  // blockAlert(event.target.offsetTop);
  // showRMenu(treeNode.type, event.clientX, event.target.parentElement.parentElement.offsetTop+10);
  var Y = event.clientY;
  // if(Y+250>$('#sideCont')[0].clientHeight){
  //   Y-=250;
  // }
  showRMenu(treeNode.type, event.clientX, Y);
  showMenu=true;
}
function showRMenu(type, x, y) {
	var rMenu = $("#rMenu");
   $("#rMenu a").show();
  // if(type=="comp"){
  //   $('#m_edit_group1').hide();
  // }
  var menuHeight = rMenu[0].clientHeight;
  rMenu.css({"top":y+"px", "left":x+"px", "display":"block" , "visibility":"visible"});
}
function hideRMenu() {
	if(showMenu){
		showMenu = false;
		return;
	}
   $("#rMenu").css({"visibility": "hidden"});
}
</script>
<style type="text/css">
.list-group-item {
  position: relative;
  display: block;
  padding: 10px 15px;
  margin-bottom: -1px;
  background-color: #fff;
  border: 1px solid #ddd;
}
div#rMenu {
  width: 150px;
  text-align: left;
}
#rMenu.list-group {
  box-shadow: 0px 2px 10px #999;
  padding: 0;
  width:140px;
}
#rMenu.list-group a:hover{
background: #428bca;
  color: white;
}
.group{background:url(../js/zTree_v3/css/zTreeStyle/img/diy/group.png) 0 0 no-repeat;padding-right:16px;}
.user{background:url(../js/zTree_v3/css/zTreeStyle/img/diy/user.png) 0 0 no-repeat;padding-right:16px;}
</style>
</head>

<body onclick="hideRMenu();">
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<c:if test="${session_auth_list.indexOf('$user_org_group')>-1 }">
					<div class="title_bar" style="height:50px;line-height:50px;">
						
						<button style="float:left;margin-right:20px;margin-top:12px;height: 30px;  line-height: 20px;cursor:pointer" onclick="addTopGroup();return false;" class="add">添加部门</button>
						
					</div>
					</c:if>
					<div class="zTreeDemoBackground left">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>

			</div>
		</div>

	</div>
	
</body>
<div id="rMenu"   class="list-group" style="position:absolute;z-index:999;display:none;" onclick="hideRMenu();">
	<span id="groupMenu">
	
  <c:if test="${session_auth_list.indexOf('$user_org_group')>-1 }"><a href="javascript:void(0)" id="m_edit_comp" onclick="addGroup();" class="list-group-item">添加部门</a></c:if>
  <c:if test="${session_auth_list.indexOf('$user_org_group')>-1 }"><a href="javascript:void(0)" id="m_edit_comp" onclick="editGroup();" class="list-group-item">修改部门</a></c:if>
    <c:if test="${session_auth_list.indexOf('$user_org_user')>-1 }"><a href="javascript:void(0)"  id="m_del_comp" onclick="addUser()" class="list-group-item">加入新用户</a></c:if>
    <c:if test="${session_auth_list.indexOf('$user_org_user')>-1 }"><a href="javascript:void(0)"  id="m_del_comp" onclick="inviteUser()" class="list-group-item">加入已有用户</a></c:if>
    <c:if test="${session_auth_list.indexOf('$user_org_group')>-1 }"><a href="javascript:void(0)"  id="m_del_comp" onclick="deleteGroup()" class="list-group-item">删除部门</a></c:if>
    <a href="javascript:void(0)"  id="m_del_comp" onclick="sendNotice()" class="list-group-item">发送通知</a>
  </span>
  <span id="userMenu">
  <c:if test="${session_auth_list.indexOf('$user_org_user')>-1 }"><a href="javascript:void(0)"  id="m_del_comp" onclick="banUser()" class="list-group-item">移出部门</a></c:if>
  <c:if test="${session_auth_list.indexOf('$user_org_user')>-1 }"><a href="javascript:void(0)"  id="m_del_comp" onclick="editUser()" class="list-group-item">编辑</a></c:if>
  </span>
</div>
</html>