<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    if ($('#type').val()=='conts') {
    	if (conts==null||conts=='') {
	    	alert('此条件下内容不能为空');
	    	return;
	    }
    };
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/menu/save',
	    data:a,
	    mysuccess: function(data){
	        alert('添加成功');
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

function showConts(sel){
	var index = parent.layer.getFrameIndex(window.name);
	if(sel==1){
		$('#conts').css('display','');
		parent.layer.style(index, {
		    width: '800px',
		    height:'700px'
		}); 
	}else{
		$('#conts').css('display','none');
		parent.layer.style(index, {
		    width: '400px',
		    height:'300px'
		}); 
	}
}

var ue;
$(function(){
	ue = UE.getEditor('editor',{
        toolbars: [
            ['forecolor', 'simpleupload','emotion','spechars', 'attachment', '|', 'fontfamily', 'fontsize', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'formatmatch', 'pasteplain', '|', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'indent', 'rowspacingtop', 'rowspacingbottom', 'lineheight',
            ]
        ]
  });
});

</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="save();">
		<div class="form-group">
			<label class="label">&nbsp;&nbsp;标&nbsp;&nbsp;题</label>
			<input name="name" id="name" class="form-input" />
		</div>
		<div class="form-group">
			<label class="label">&nbsp;&nbsp;排&nbsp;&nbsp;序</label>
			<input name="orderx" value="100" class="form-input" />
		</div>
		<div class="form-group" >
			<label class="label">项目种类</label>
            <label class="btn btn-default " style="margin: 6px;">
                <input type="radio" value="menu" name="type" onclick="showConts(0)" autocomplete="off" > 有子栏目
            </label>
            <label class="btn btn-default">
                <input type="radio" value="conts" name="type" onclick="showConts(1)" autocomplete="off" checked="checked"> 无子栏目
            </label>
		</div>
		<div id="conts" class="form-group" style="">
			<label class="label">文章内容</label>
	        <span id="editor" type="text/plain" name="conts" style="height:330px;width:98%;"></span>
		</div>
		
		<div class="form-group action">
			<label class="label" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<div class="form-input btn-wrap" >
				<button onclick="save();return false;" class="form-button save">保&nbsp;&nbsp;存</button>
				<button onclick="closeThis();return false;" class="form-button cancel">取&nbsp;&nbsp;消</button>
			</div>
		</div>
	</form>
</body>
</html>