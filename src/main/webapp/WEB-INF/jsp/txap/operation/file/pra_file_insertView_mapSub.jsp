<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/resources/api/uploadfile/uploadfile.css" rel="stylesheet">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<script src="/resources/api/uploadfile/jquery.uploadfile.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<style>

#uploadFileDiv .row {border: 1px solid black;margin: 0;padding: 15px;margin-bottom:20px;}
.txtDefault {
    min-height: 32px;
    padding: 3px 5px;
    font-size: 14px;
}
.width100Per {
    width: 90%;
}
input[type=text], input[type=number], input[type=password] {
    vertical-align: middle;
    border: 1px solid #cfcfcf;
    padding: 3px 10px;
    width: 80%;
}

.ajax-file-upload-statusbar {position:relative;}
.iconBox {position: absolute;top: 5px;right: 5px;}
.iconBox .material-icons {color: #999;border: 1px solid;font-size: 19px;}
.iconBox .material-icons:hover {color: #333;}
.fileCounter {color: #0ba1b5;font-size: 20px;}

</style>

<fieldset class="smart-form" >
	<div id="uploadFileDiv">
	    <div class="row">
			<section class="col col-9">
				<div id="IM_UPLOAD"> 
					<div id="previewupload">Upload</div>
	<!--        			<div id="extrabutton" class="ajax-file-upload-green">Start Upload</div> -->
					<input type="hidden" name="FM_KEYNO" id="FM_KEYNO" /> 
					<input type="hidden" name="FM_WHERE_KEYS" id="FM_WHERE_KEYS" /> 
					<input type="hidden" name="FM_COMMENTS" id="FM_COMMENTS" />
					<input type="hidden" name="deleteFileKeys" id="deleteFileKeys" />
				</div>
	       </section>
		</div>	 
	</div>
</fieldset>

<script>

var fileUpload;
var fileExt = '';

var isLoaded = false;
var deleteFileKeys = new Array();
$(function(){
	
	fileExt = '${BoardType.BT_FILE_EXT }'; 
	if(!fileExt){
		fileExt = '<spring:eval expression="@config.getProperty('file.ext')" />';
	}

	fileUpload = $("#previewupload").uploadFile({
		 url:"/async/MultiFile/uploadAjax.do",
		 autoSubmit:false,
		 fileName:"myfile",
		 showPreview:true,
		 maxFileCount: "${BoardType.BT_FILE_CNT_LIMIT }" || 5,
		 maxFileSize:1000*1024*"${BoardType.BT_FILE_SIZE_LIMIT }" || 1000*1024*200,
		 previewHeight: "100px",
		 previewWidth: "100px",
		 showDelete: true,
		 allowedTypes : fileExt,
		 dynamicFormData: function()
		 {
		 	var data =  { 
	 			FS_FM_KEYNO : $('#FM_KEYNO').val(),
	 			BT_FILE_IMG_WIDTH : '${BoardType.BT_FILE_IMAGE_WIDTH }',
	 			BT_FILE_IMG_HEIGHT : '${BoardType.BT_FILE_IMAGE_HEIGHT }'
		 	};
		 	return data;
		 },
		 onSelect:function(files)
		 {
			//$('.ajax-file-upload-statusbar').find('img').each(function(){
			//	 
			//})
		 },
		 onSuccess:function(files,data,xhr,pd)
		 {
		     //files: list of files
		     //data: response from server
		     //xhr : jquer xhr object
			  pd.statusbar.find('input[name="FS_KEYNO"]').val(data.FS_KEYNO)
			  if( !$('#FM_KEYNO').val() ){
				  $('#FM_KEYNO').val(data.FS_FM_KEYNO);
			  }
		 },
		 onSubmit:function(files)
		 {
		     //files : List of files to be uploaded
		     //return flase;   to stop upload
			 //pf_insert();
			
		 },
		 afterUploadAll:function(obj)
		 {
			 var length = $("span.ajax-file-upload-error").length;
			 if(length > 0){
				 fileCk = false;
			 }else{
				 fileCk = true;				 
			 }
			 $(".cancle_hidden").remove();
			 if(fileCk){
				  //첨부파일 정보 업데이트 후 success 호출
				 updateFileInfo(success);
			 }else{
				 alert('네트워크 장애 발생 페이지를 새로 고침합니다.')
				 location.reload();
			 }
			 
		 }
		 ,
		 onError:function(files,data,xhr){
		 }
		 ,
		 onLoad:function(obj)
	   	 {
			 
			 pf_fileUploadOnLoadSetting(obj);
				 
		 },
		 deleteCallback: function (data, pd) 
		 {
			var thisKey = $(pd.statusbar).find('input[name=FS_KEYNO]').val()
			deleteFileKeys.push(thisKey);

		 },
		 customProgressBar: function(obj,s)
		 {
            this.statusbar = $("<div class='ajax-file-upload-statusbar'></div>");
            this.preview = $("<img class='ajax-file-upload-preview' />").width(s.previewWidth).height(s.previewHeight).appendTo(this.statusbar).hide();
            this.filename = $("<div class='ajax-file-upload-filename'></div>").appendTo(this.statusbar);
            this.progressDiv = $("<div class='ajax-file-upload-progress'>").appendTo(this.statusbar).hide();
            this.progressbar = $("<div class='ajax-file-upload-bar'></div>").appendTo(this.progressDiv);
            this.abort = $("<div>" + s.abortStr + "</div>").appendTo(this.statusbar).hide();
            this.cancel = $("<div>" + s.cancelStr + "</div>").appendTo(this.statusbar).hide();
            this.done = $("<div>" + s.doneStr + "</div>").appendTo(this.statusbar).hide();
            this.download = $("<div>" + s.downloadStr + "</div>").appendTo(this.statusbar).hide();
            this.del = $("<div>" + s.deleteStr + "</div>").appendTo(this.statusbar).hide();

            this.abort.addClass("ajax-file-upload-red");
            this.done.addClass("ajax-file-upload-green");
            this.download.addClass("ajax-file-upload-green");            
            this.cancel.addClass("ajax-file-upload-red");
		 	if(isLoaded){
		 		$("<input type='hidden' value='취소' class='cancle_hidden' name='can'/>").appendTo(this.statusbar)
		 	}
            this.del.addClass("ajax-file-upload-red ajax-file-upload-del");
		 	
		 	$('<input type="hidden" name="FS_KEYNO" /> ').appendTo(this.statusbar)
		 	$('<input type="hidden" name="FS_ORDER" /> ').appendTo(this.statusbar)
		 	$('<input type="text" class="txtDefault width100Per" name="FS_ALT" placeholder="파일의 \'이름\'을 입력해 주세요." /> ').appendTo(this.statusbar)
		 	$('<input type="text" class="txtDefault width100Per" name="FS_COMMENTS" placeholder="파일의 \'설명\'을 입력해 주세요." /> ').appendTo(this.statusbar)
		 	
		 	var icons = '<div class="iconBox">';
		 	icons    += '	<a href="javascript:;" onclick="pf_settingFileOrder(this,\'down\')"><i class="material-icons">keyboard_arrow_down</i></a>';
	 		icons    += '	<a href="javascript:;" onclick="pf_settingFileOrder(this,\'up\')"><i class="material-icons">keyboard_arrow_up</i></a>';
	 		icons    += '</div>';
	 		$(icons).appendTo(this.statusbar);
	 		
	 		pf_settingFileOrder();
		 	
            return true;
		 }
	 }); 
	

});


function pf_settingFileOrder(obj,action){
	
	$statusbar = $('.ajax-file-upload-statusbar');
	var length = $statusbar.length;
	
	if(obj){
		
		$thisObj = $(obj).parents('.ajax-file-upload-statusbar');
		
		var index = $statusbar.index($thisObj);
		if(action == 'up'){
			if(index == 0){
				return false;
			}else{
				$statusbar.eq(index-1).before($statusbar.eq(index))
			}
		}else if(action == 'down'){
			if(index == length - 1){
				return false;
			}else{
				$statusbar.eq(index + 1).after($statusbar.eq(index))
			}
		} 
		
		
	}
	
	$('.fileCounter').each(function(i){
		$(this).text((length - i)+').');
	})
	
	$('input[name=FS_ORDER]').each(function(i){
		$(this).val(length - i);
	})
}

function pf_fileUploadOnLoadSetting(obj){
    var fsKeyno = new Array();
    var fsOrder = new Array();
    var alts = new Array();
    var comments = new Array();
    
	<c:forEach items="${FileSub}" var="model" varStatus="cnt">
	fs_key = "${model.FS_KEYNO}";
	obj.createProgress("${model.FS_ORINM }","/resources/img/upload/${model.FS_FOLDER}${model.FS_CHANGENM}.${model.FS_EXT}","${model.FS_FILE_SIZE}");
	fsKeyno.push('<c:out value="${model.FS_KEYNO}"/>');
	fsOrder.push('<c:out value="${model.FS_ORDER}"/>');
	alts.push('<c:out value="${model.FS_ALT}"/>');
	comments.push('<c:out value="${model.FS_COMMENTS}"/>');
	</c:forEach>
	
	pf_setFileValues(fsKeyno,"FS_KEYNO");
	pf_setFileValues(fsOrder,"FS_ORDER");
	pf_setFileValues(alts,"FS_ALT");
	pf_setFileValues(comments,"FS_COMMENTS");
	
	isLoaded = true;
	
}

function pf_setFileValues(array,name){
	array = array.reverse();
    for(var i in array){
      $('input[name='+name+']').eq(i).val(array[i])
    }
}

function newInsert(){
	fileUpload.startUpload();   	
}

function pf_errorFileDel(id){
	$("#"+id).closest(".ajax-file-upload-statusbar").remove();
	
}

function updateFileInfo(func){
	
	pf_settingFileOrder();
	
	var fsFormData = $('.ajax-file-upload-container').find('input').serializeArray();
	$.ajax({
     type   : "post",
     url    : "/async/file/info/uploadAjax.do",
     data   : fsFormData
   })
   .done(function(data){
       func();
    })
    .fail(function(jqXHR, textStatus, exception){
    	alert('error: '+textStatus+": "+exception);
    	cf_loading_out();
    })
}


//파일 업로드
function successFileUp(){
	var fn_length = '${fn:length(FileSub)}';
	if(fn_length > 0){
		successUpdateFile();
	}else{
		successNewFile();
	}
}

//기존파일 존재, 추가파일 업로드
function successUpdateFile(){
	$('#FM_KEYNO').val($('#MMS_FM_KEYNO').val());
	fileUpload.startUpload();
}


function successNewFile(){
	$.ajax({
		type   	: "post",   
		url    	: "/async/MultiFile/mainkey/select.do",
		success : function(result){
			$('#FM_KEYNO').val(result);
			fileUpload.startUpload();
		},
		error: function(jqXHR, exception) {
	       	cf_loading_out();
	       	alert('error')
		}
	});
}

//파일 삭제
function fn_fileSubDelete(fskey){
	
	var deleteResult = true;
	var errorMsg = '';
	if(deleteFileKeys.length > 0){
		$.ajax({
	        type   : "post",   
	        url    : "/async/MultiFile/fs/deleteAjax.do",
	       	data   : {deleteFileKeys : deleteFileKeys.join(",")},
	       	async  : false,
	       	success : function(data){
				if(data != 'S'){
					deleteResult = false;
					errorMsg = data;
				}
			},
	        error: function(jqXHR, exception) {
	        	
	        	deleteResult = false;
	        	errorMsg = '첨부파일 삭제중 에러';
	        }
		});
	}
	
	if(errorMsg){
		cf_loading_out();
		alert(errorMsg);
	}
	
	return deleteResult;
}

//첨부파일 포커스 들어올때
function onfocus_file(obj) {
    $(obj).closest('.ajax-file-upload').css('background-color','#f54a4a');
}

//첨부파일 포커스 아웃시
function onblur_file(obj) {
    $(obj).closest('.ajax-file-upload').css('background-color','#2f8ab9');
}
</script>