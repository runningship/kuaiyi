<%@page import="com.youwei.kuaiyi.util.DataHelper"%>
<%@page import="com.youwei.kuaiyi.entity.Article"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String[] params = {"name"};
	Article art = dao.getUniqueByParams(Article.class, params , new Object[] {"contact"});
	request.setAttribute("art", art);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>联系我们</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<link href="../js/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<link href="../js/zTree_v3/css/div.css" rel="stylesheet">
<script type="text/javascript" src="../js/zTree_v3/js/jquery.ztree.all-3.5.js"></script>
<link rel="stylesheet" href="add.css">
<style type="text/css">
.group{background:url(../js/zTree_v3/css/zTreeStyle/img/diy/group.png) 0 0 no-repeat;padding-right:16px;}
.user{background:url(../js/zTree_v3/css/zTreeStyle/img/diy/user.png) 0 0 no-repeat;padding-right:16px;}
</style>
</head>
<script type="text/javascript">
function send(){
	var conts = ue.getContent();
    if (conts==null||conts=='') {
    	alert('内容不能为空');
    	return;
    };
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/article/save',
	    data:a,
	    mysuccess: function(data){
	        alert('发送成功');
	    }
    });
}


var ue;
$(function(){
	ue = UE.getEditor('editor',{
        toolbars: [
            ['forecolor','source', 'simpleupload','emotion','spechars', 'attachment', '|', 'fontfamily', 'fontsize', 'map' , 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'insertvideo',
             'superscript', 'subscript', 'formatmatch', 'pasteplain', '|', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify',
             'indent', 'rowspacingtop', 'rowspacingbottom', 'lineheight',
            ]
        ]
  });
    ue.addListener( 'ready', function( editor ) {
        ue.setContent($('#menu_conts').html());
    });
});

$(function(){
	
});

	
</script>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<form name="form1" class="add-form" onsubmit="return false;">
						<input type="hidden" name="id" value="${art.id }" />
						<input type="hidden" name="parentId" value="-1" />
						<input type="hidden" name="name" value="contact" />
						<table style="width:100%" >
							<tr class="form-group">
								<td style="vertical-align: top;text-align:left;"><label class="label">正文</label></td>
								<td><span id="editor" type="text/plain" name="conts" style="height:700px;width:100%;"></span></td>
							</tr>
							<tr>
							<td colspan="2">
								<button onclick="send();return false;" class="form-button save" style="float:right;cursor:pointer">保&nbsp;&nbsp;&nbsp;存</button>
							</td>
							</tr>
						</table>
		<div id="menu_conts" style="display:none">${art.conts}</div>
					</form>
				</div>
			</div>
		</div>

	</div>
</body>
</html>