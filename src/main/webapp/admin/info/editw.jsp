<%@page import="com.youwei.kuaiyi.entity.Article"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	Article art = dao.get(Article.class, id);
	request.setAttribute("art", art);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.all.min.js"> </script>
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
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/article/update',
	    data:a,
	    mysuccess: function(data){
	        alert('修改成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.reloadWindow();
			parent.layer.close(index); //再执行关闭   
	    }
    });
}

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}

var ue;
$(function(){
	ue = UE.getEditor('editor',{
        toolbars: [
            ['forecolor','source', 'simpleupload','emotion','spechars', 'attachment', '|', 'fontfamily', 'fontsize','insertvideo','map',
             'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'formatmatch', 'pasteplain', '|', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'indent', 'rowspacingtop', 'rowspacingbottom', 'lineheight',
            ]
        ]
  });
    ue.addListener( 'ready', function( editor ) {
        ue.setContent($('#menu_conts').html());
    });
});

</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="save();">
		<input name="id" value="${art.id}" style="display:none">
		<div class="form-group">
			<input name="name" value="${art.name}" class="form-input" />
		</div>
		<div id="conts" class="form-group">
	        <span id="editor" type="text/plain" name="conts" style="height:370px;width:98%;"></span>
		</div>

        <div class="FormGroup">
            <h3>文章参数设置</h3>
            <div class=" table">
                <div class="tr">
                    <div class="th"><label class="label">排序</label></div>
                    <div class="td"><input name="orderx" value="${art.orderx}" class="form-input" /></div>
                </div>
            </div>
        </div>
		
		<div class="form-group action hidden">
			<label class="label" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<div class="form-input btn-wrap" >
				<button onclick="save();return false;" class="form-button save">保&nbsp;&nbsp;存</button>
				<button onclick="closeThis();return false;" class="form-button cancel">取&nbsp;&nbsp;消</button>
			</div>
		</div>
		<div id="menu_conts" style="display:none">${art.conts}</div>
	</form>
</body>
</html>