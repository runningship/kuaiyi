
function initUploadHouseImage(id , projectName){
  $('#'+id).uploadify({
      'swf'      : projectName+'/admin/js/uploadify/uploadify.swf',
      'uploader' :projectName+'/c/admin/file/upload',
      'buttonText': '上传文件',
      'removeTimeout': 0.5,
      'fileSizeLimit' : '500MB',
      'height':35,
      'width':100,
      'onUploadError' : function(file, errorCode, errorMsg, errorString){
          //console.log('The file ' + file.name + ' could not be uploaded: ' + errorString);
      },
      'onUploadComplete':function(file){
          console.log('finish:'+file);
      },
      'onUploadSuccess' : function(file, data, response) {
        var json = JSON.parse(data);
        if(json['result']!=0){
          $('#' + file.id).find('.data').html('文件上传失败,'+json['msg']);
        }else{
        }
      },
      'onQueueComplete' : function(queueData) {
    	//刷新页面
        console.log(queueData);
        window.location.reload();
      }
  });
}


