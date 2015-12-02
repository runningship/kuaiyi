<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.kuaiyi.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%
 CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
 List<Menu> list1 = dao.listByParams(Menu.class, "from Menu where parentId is null ");
 List<Menu> list2 = dao.listByParams(Menu.class, "from Menu where parentId is not null ");
 request.setAttribute("list1", list1);
 request.setAttribute("list2", list2);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.all.yw.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">
function save(){
	var conts = ue.getContent();
    if (conts==null||conts=='') {
    	alert('内容不能为空');
    	return;
    };
    
    $('#parentId').val(getPrentId());
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/article/save',
	    data:a,
	    mysuccess: function(data){
	        alert('添加成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.reloadWindow();
			parent.layer.close(index); //再执行关闭   
	    }
    });
}


function getPrentId(){
	var parentId="";
	if($('#level_1').val()){
		parentId = $('#level_1').val();
	}
	if($('#level_2').val()){
		parentId = $('#level_2').val();
	}
	return parentId;
}

function topMenuChange(){
	$('#level_2 [pid]').css('display','none');
	$('#level_2 [pid='+$('#level_1').val()+']').css('display','');
	var arr = $('#level_2 [pid='+$('#level_1').val()+']');
	if(arr.length>0){
		$('#level_2').val(arr[0].value);
	}else{
		$('#level_2').val('');
	}
}

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}

var ue;
$(function(){
	ue = UE.getEditor('editor',{
        toolbars: [
            ['forecolor','source', 'simpleupload','emotion','spechars', 'attachment', '|', 'fontfamily', 'fontsize', 'bold','insertvideo','map',
             'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'formatmatch', 'pasteplain', '|', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'indent', 'rowspacingtop', 'rowspacingbottom', 'lineheight',
            ]
        ]
  });
	topMenuChange();
});

</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="save();">
		<input name="parentId" id="parentId" type="hidden" />

		<div class=" table">
			<div class="tr">
				<div class="th"><label class="label">标题</label></div>
				<div class="td" style="width:450px;"><input name="name" id="name" class="form-input" /></div>
			</div>
		</div>
		<div class=" table">
			<div class="tr">
				<div class="th"><label class="label">栏目</label></div>
				<div class="td">
					<select class="form-select" id="level_1" onchange="topMenuChange(this)">
						<option value="">无</option>
						<c:forEach items="${list1 }" var="menu" >
						<option value="${menu.id }">${menu.name}</option>
						</c:forEach>
					</select>
					<select class="form-select" id="level_2">
						<option value="">无</option>
						<c:forEach items="${list2 }" var="menu" >
							<option pid="${menu.parentId }" value="${menu.id }">${menu.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="th"><label class="label">排序</label></div>
				<div class="td"><input name="orderx" value="100" class="form-input" /></div>
			</div>
		</div>
		<div class="form-group">
			
			
		</div>
		<div class="form-group">
			
			
		</div>
		<div id="conts" class="form-group">
			<label class="label">文章内容</label>
	        <span id="editor" type="text/plain" name="conts" style="height:330px;width:98%;"></span>
		</div>
		
		<div class="form-group action hidden">
			<label class="label" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<div class="form-input btn-wrap" >
				<button onclick="save();return false;" class="form-button save">保&nbsp;&nbsp;存</button>
				<button onclick="closeThis();return false;" class="form-button cancel">取&nbsp;&nbsp;消</button>
			</div>
		</div>
	</form>
</body>
</html>