<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>


<script type="text/javascript">
//전역변수선언
var editor_object = [];
var action = '${action}';
var plus = '<c:out value = "${BoardType.BT_HTMLMAKER_PLUS_YN}"/>';

$(function(){
	
	$('.BD_DATA_CALENDAR,#BN_IMPORTANT_DATE,.BD_DATA_CALENDAR_START,.BD_DATA_CALENDAR_END').datepicker(datepickerOption);
	
	if($('.BD_DATA_CALENDAR_START').length > 0){
		if($('.BD_DATA_CALENDAR_END').length > 0){
			$('.BD_DATA_CALENDAR_START').on('change', function(){
				$('.BD_DATA_CALENDAR_END').datepicker('option', 'minDate', $(this).val());
			});
		}
	}
	
	if($('.BD_DATA_CALENDAR_END').length > 0){
		if($('.BD_DATA_CALENDAR_START').length > 0){
			$('.BD_DATA_CALENDAR_END').on('change', function(){
				$('.BD_DATA_CALENDAR_START').datepicker('option', 'maxDate', $(this).val());
			});
		}
	}
	
	
	if(action == 'insert'){
		$('#BN_IMPORTANT_DATE').datepicker('option','minDate',cf_getToday());
	}
	var webEditUseYn = true; 
	if(plus == 'N'){
		webEditUseYn = false;
	}  
	
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "BN_CONTENTS",
        sSkinURI: "/resources/smarteditor2/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : webEditUseYn,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : webEditUseYn,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : webEditUseYn,
        },
        menuName : '${Menu.MN_NAME}' //본문에 이미지 저장시 사용되는 캡션
    });
    
	
    if(action == 'update' || "${BoardType.BT_KEYNO}" == "${PreBoardType.BT_KEYNO}" ){
    	pf_initColumnData("${BoardNotice.BN_KEYNO }")
    	cf_radio_checked("BN_SECRET_YN", "${BoardNotice.BN_SECRET_YN }");
    }
    

})


function pf_checkOption(obj){
	var checkval = "";
	var $checked = $(obj).parent().parent().find("input[type=checkbox]:checked");
	$checked.each(function(i){
		if(i < $checked.length-1){
			checkval += $(this).val() + "|";
		}else{
			checkval += $(this).val();
		}
	})
	$(obj).parent().parent().find("input[name='BD_DATA']").val(checkval)
}

function pf_radioOption(obj){
	$(obj).parent().parent().find("input[name='BD_DATA']").val($(obj).val())
}


function pf_formCheck(){
	//웹에디터 내용 textarea로 복사
	editor_object.getById["BN_CONTENTS"].exec("UPDATE_CONTENTS_FIELD", []);

	
	if($('input[name=BN_IMPORTANT_CHECK]').is(':checked')){
		if(!$("#BN_IMPORTANT_DATE").val()){
			alert("공지 종료일을 선택해주세요")
			return false;
		}
		$('#BN_IMPORTANT').val('Y')
	}else{
		$('#BN_IMPORTANT').val('N')
	}
	
	var state = false;
	var required = false;
	$('.BD_TYPE_VALIDATE').each(function(){
		required = true;
// 		if(!state){
// 			if($(this).data('type') == 'check' || $(this).data('type') == 'radio'){
// 				var length = $(this).parent().find('input[name^=BD_DATA]:checked').length;
// 				if(length < 1){
// 					alert($(this).data('title')+'을 선택하여주세요.');
// 					$(window).scrollTop($(this).parent().find('input[name^=BD_DATA]').eq(0).next().offset().top - 100)
// 					state = true;
// 				}
// 			}else if(!$(this).val().trim()){
// 				alert($(this).data('title')+'을 입력하여주세요.');
// 				$(this).focus();
// 				state = true;
// 			}
// 		}
	});
	
	if(state){
		return false;
	}
	
	$('.BD_DATA_EMAIL').each(function(){
		var value = $(this).val();
		
		if(!state && value && !/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i.test( value )){
			alert($(this).data('title')+'의 이메일 형식이 올바르지 않습니다.');
			$(this).focus();
			state = true;
		}
	})
	
	
	if(state){
		return false;
	}
	
	$('.BD_DATA_CALENDAR, .BD_DATA_CALENDAR_END, .BD_DATA_CALENDAR_START').each(function(){
		var value = $(this).val();
		if(!state && value && !/^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/.test( value )){
			alert($(this).data('title')+'의 날짜 형식이 올바르지 않습니다.(YYYY-MM-DD)');
			$(this).focus();
			state = true;
		}
	})
	
	if(state){
		return false;
	}
	
	if("${BoardType.BT_THUMBNAIL_YN}" == "Y"){
		if( action == 'insert' || ((action == 'update' || action == 'move') && !$('#BN_THUMBNAIL').val()) ){
			//갤러리형
// 			if(!$("#thumbnail").val()){
// 				alert("썸네일 이미지를 선택해주세요");
// 				return false;
// 			}
		}
	}
	if("${BoardType.BT_SECRET_YN }" == "Y"){
		if(!cf_radio_check_val("BN_SECRET_YN")){
			alert("비밀글 사용여부를 선택해주세요");
			return false;
		}		
	}
	var BN_CONTENTS = $("#BN_CONTENTS").val()
	if( BN_CONTENTS == ""  || BN_CONTENTS == null || BN_CONTENTS == '&nbsp;' || BN_CONTENTS == '<p>&nbsp;</p>')  {
         alert("내용을 입력하세요.");
         editor_object.getById["BN_CONTENTS"].exec("FOCUS"); //포커싱
         return false;
    }
	return true;
}

function pf_boardDataInsert(){
	
	if(!pf_formCheck()){
		return false;
	}
	if(confirm("게시물을 생성하시겠습니까?")){
		cf_loading();
		var fCnt = $("#BN_UPLOAD .ajax-file-upload-statusbar").length
		if(fCnt > 0){
			successNewFile();
		}else{
			pf_checkFile();
		}
	}
	else{
		exit();
	}
}

function pf_boardDataUpdate(type){
	
	var msg = "";
	
	if(type == "move"){
		msg = "게시물을 이동하시겠습니까?";
	}else {
		msg = "게시물을 수정하시겠습니까?";
	}
	
	if(!pf_formCheck()){
		return false;
	}
	if(confirm(msg)){
		cf_loading();
		var fCnt = $("#BN_UPLOAD .cancle_hidden").length
		
		if($("input:radio[name='linkinsert']:checked").val() == "Y"){
			if(fCnt > 0){
				fCnt = 0
			}
		}
		
		if( typeof fn_fileSubDelete == 'function' && !fn_fileSubDelete() ){ // 첨부파일 삭제 있으면 삭제처리
			return false;
		} 
		
		if(fCnt > 0){
			successFileUp();
		}else{
			$('#FM_KEYNO').val($('#BN_FM_KEYNO').val());
			pf_checkFile();
		}
		
	}else{
		exit();
	}
}


function pf_checkFile(){
	if( typeof updateFileInfo == 'function' ) {
		if($("input:radio[name='linkinsert']:checked").val() == "N"){
			updateFileInfo(success);	
		}else{
			success();	
		}
	}else{
		success();
	}
}

function success(){
	cf_replaceTrim($("#Form"));
	if(action == 'insert'){
		$("#Form").attr("action", "/txap/Board/data/insert.do?${_csrf.parameterName}=${_csrf.token}");
	}else if(action == 'update'){
		$("#Form").attr("action", "/txap/Board/data/update.do?${_csrf.parameterName}=${_csrf.token}");
	}else if(action == 'move'){
		$("#Form").attr("action", "/txap/Board/data/move.do?${_csrf.parameterName}=${_csrf.token}");
	}else{
		alert('오류발생 : action값 없음');
		return false;
	}
	$("#Form").submit();
}
function exit(){
	alert("취소되었습니다.");
	return false;
}


function pf_initColumnData(BN_KEYNO){
	cf_loading();
	$.ajax({
		type: "POST",
		url: "/txap/BoardData/updateView/listAjax.do",
		data: "BD_BN_KEYNO="+BN_KEYNO,
		success : function(result){
			cf_loading_out();
			for(var i = 0; i < result.length; i++){
				$("#BD_KEYNO"+result[i].BD_BL_KEYNO).val(result[i].BD_KEYNO);
				if(result[i].BD_BL_TYPE == '${BOARD_COLUMN_TYPE_CHECK}' || result[i].BD_BL_TYPE == '${BOARD_COLUMN_TYPE_CHECK_CODE}'){
					cf_checkbox_checked("BD_DATA"+result[i].BD_BL_KEYNO, result[i].BD_DATA.split('|'))
				}else if(result[i].BD_BL_TYPE == '${BOARD_COLUMN_TYPE_RADIO}' || result[i].BD_BL_TYPE == '${BOARD_COLUMN_TYPE_RADIO_CODE}'){
					cf_radio_checked("BD_DATA"+result[i].BD_BL_KEYNO, result[i].BD_DATA)
				}else if(result[i].BD_BL_TYPE == '${BOARD_COLUMN_TYPE_CHECK_CODE}'){
					cf_radio_checked("BD_DATA"+result[i].BD_BL_KEYNO, result[i].BD_DATA)
				}
				$("#BD_DATA"+result[i].BD_BL_KEYNO).val(result[i].BD_DATA)
			}
		},
		error: function(){
			cf_loading_out();
			cf_alert("예상치못한 오류가 발생했습니다.");
			return false;
		}
	});
}

function pf_back(){
	$("#Form").attr("action", "/txap/Board/dataView.do?${_csrf.parameterName}=${_csrf.token}");
	$("#Form").submit();
}

//링크확인
function pf_link(id){
	window.open($('#'+id).val())
}

function pf_ClipBoard(obj){
	var select_input = $(obj).parent().parent().find(".column_data");
	
	if(cf_copyToClipboard(select_input.val())){
		cf_smallBox('success', "값이 복사되었습니다.", 3000);
	}else{
		cf_smallBox('error', "복사하기 기능을 지원하지 않는 브라우저 입니다.", 3000,'#d24158');
	}
}

function pf_adjust(id, bl_type, data){
	var bl_keyno = $('#'+id).val();
	
	if(bl_keyno){
		if(bl_type == '${BOARD_COLUMN_TYPE_CHECK}' || bl_type == '${BOARD_COLUMN_TYPE_CHECK_CODE}'){
			cf_checkbox_checked_prop("BD_DATA"+bl_keyno, data.split('|'))
		}else if(bl_type == '${BOARD_COLUMN_TYPE_RADIO}' || bl_type == '${BOARD_COLUMN_TYPE_RADIO_CODE}'){
			cf_radio_checked("BD_DATA"+bl_keyno, data)
		}else if(bl_type == '${BOARD_COLUMN_TYPE_CHECK_CODE}'){
			cf_radio_checked("BD_DATA"+bl_keyno, data)
		}
		$("#BD_DATA"+bl_keyno).val(data)
	}else{
		alert("선택된 데이터가 없습니다.");
	}
}


</script>
<style>
label input[type=checkbox].checkbox+span, label input[type=radio].radiobox+span{z-index: 1}
.checkbox-inline, .radio-inline {margin-left:10px;}
.input-group-addon {background:#fff;}
.fa-lock {width:14px;}
</style>
<div id="content">
	<section id="widget-grid" >
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="" data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-lg fa-desktop"></i> </span>
						<c:if test="${action eq 'insert' }">
						<h2>게시물 등록하기 </h2>
						</c:if>
						<c:if test="${action eq 'update' }">
						<h2>게시물 수정하기 </h2>
						</c:if>
						<c:if test="${action eq 'move' }">
						<h2>게시물 이동하기 </h2>
						</c:if>
					</header> 
					
					<div class="jarviswidget-editbox"></div>
					
					<div class="widget-body">
	
	<form:form id="Form" class="form-horizontal" name="Form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="BD_BT_KEYNO" value="${BoardType.BT_KEYNO } ">
		<input type="hidden" name="BN_MN_KEYNO" value="${Menu.MN_KEYNO }">
		<input type="hidden" name="MN_KEYNO" value="${Menu.MN_KEYNO }">
		<input type="hidden" name="BN_IMPORTANT" id="BN_IMPORTANT" value="${BoardNotice.BN_IMPORTANT }">
		<c:if test="${not empty BoardNotice}">
		
		<input type="hidden" name="BN_MAINKEY" id="BN_MAINKEY" value="${BoardNotice.BN_MAINKEY }">
		<input type="hidden" name="BN_PARENTKEY" id="BN_PARENTKEY" value="${BoardNotice.BN_KEYNO}">
		<input type="hidden" name="BN_SEQ" id="BN_SEQ" value="${BoardNotice.BN_SEQ }">
		<input type="hidden" name="BN_DEPTH" id="BN_DEPTH" value="${BoardNotice.BN_DEPTH}">
		</c:if>
		<c:if test="${action eq 'insert' }">
			<input type="hidden" name="BN_REGNM" id="BN_REGNM" value="${userInfo.UI_KEYNO }">
		</c:if>
		<c:if test="${action eq 'update' || action eq 'move' }">
			<input type="hidden" name="BN_KEYNO" value="${BoardNotice.BN_KEYNO }">
			<input type="hidden" name="BN_MODNM" value="${userInfo.UI_KEYNO }">
			<input type="hidden" name="BN_THUMBNAIL" id="BN_THUMBNAIL" value="${BoardNotice.BN_THUMBNAIL }">
		</c:if>
		<c:if test="${action eq 'move' }">
			<input type="hidden" name="BN_MOVE_MEMO" value="${BoardNotice.BN_MOVE_MEMO }">
			<input type="hidden" name="BT_KEYNO" value="${PreBoardType.BT_KEYNO }">
		</c:if>
		<legend>
			<c:if test="${action eq 'insert' }">
			<h2>게시물 등록하기 </h2>
			</c:if>
			<c:if test="${action eq 'update' }">
			<h2>게시물 수정하기 </h2>
			</c:if>
			<c:if test="${action eq 'move' }">
			<h2>게시물 이동하기 </h2>
			</c:if>
		</legend>
		
		<c:if test="${action eq 'move' }">
		<legend>
			<fieldset>
				<h3>이전 게시물 컬럼 데이터</h3>
				<c:if test="${action eq 'move' && BoardType.BT_KEYNO ne PreBoardType.BT_KEYNO }">
					<c:forEach items="${PreBoardColumnData }" var="model">
						<c:if test="${model.BD_BL_TYPE ne BOARD_COLUMN_TYPE_TITLE and !empty model.BD_DATA}">
						<div class="row">
							<div class="form-group has-feedback">
								<label class="col-md-2 control-label">${model.COLUMN_NAME }</label>
								<div class="col-md-3">
									<input class="form-control column_data" type="text" value="${model.BD_DATA }" readonly="readonly">
								</div>
								
								<div class="col-md-2">
									<select id="BD_DATA${model.BD_KEYNO }" class="form-control">
										<option value="">선택하세요</option>
										<c:forEach items="${BoardColumnList }" var="model2">
											<c:if test="${model.BD_BL_TYPE eq model2.BL_TYPE }">
												<option value="${model2.BL_KEYNO }">${model2.BL_COLUMN_NAME }</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
								
								<div class="col-md-1">
									<input class="form-control" type="button" value="적용하기" onclick="pf_adjust('BD_DATA${model.BD_KEYNO }', '${model.BD_BL_TYPE}', '${model.BD_DATA}');">
								</div>
								
								<div class="col-md-1">
									<a class="btn btn btn-default btn-xs" href="#" onclick="pf_ClipBoard(this);">
										<i class="fa fa-copy"></i>
									</a>
									<!-- <input class="form-control" type="button" value="복사하기" onclick="pf_ClipBoard(this);"> -->
								</div>
								
							</div>
						</div>
						</c:if>
					</c:forEach>
				</c:if>
			</fieldset>
		</legend>
		</c:if>
		
		<fieldset>
			<div class="row">
			<div class="form-group has-feedback">
				<label class="col-md-2 control-label">공지사용</label>
				<div class="col-md-2">
					<label class="checkbox checkbox-inline no-margin">
					<input type="checkbox" value="Y" name="BN_IMPORTANT_CHECK" id="BN_IMPORTANT_CHECK" class="checkbox style-2" data-bv-field="rating" ${BoardNotice.BN_IMPORTANT eq 'Y' ? 'checked':'' }>
					<span>사용</span> </label>
				</div>
				
				<div class="col-md-4">
					<label class="col-md-4 control-label">공지 종료일</label>
					<div class="input-group">
						<input name="BN_IMPORTANT_DATE" id="BN_IMPORTANT_DATE" type="text" class="form-control" readonly="readonly" value="${BoardNotice.BN_IMPORTANT_DATE }" >
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>

				<div class="col-md-2">
					<div class="bs-example necessT">
			         <span class="colorR fs12">*표시는 필수 입력 항목입니다.</span>
			   	    </div>
				</div>

			</div>
			</div>
		
		
		<div class="row">
			<div class="form-group has-feedback">
				<label class="col-md-2 control-label"><span>*</span>동영상 입력방법</label>
				<div class="col-md-6">
				<div class="input-group">
					<input type="radio" name="linkinsert" id="linkinsert1" value="Y" checked> 유튜브 링크
					<input type="radio" name="linkinsert" id="linkinsert2" value="N" > 파일로 등록
				</div>
			</div>
			</div>
		</div>
		
		<c:forEach items="${BoardColumnList }" var="model" varStatus="status">
			<input type="hidden" name="BD_BL_TYPE" value="${model.BL_TYPE }">
			<input type="hidden" name="BD_BL_KEYNO" value="${model.BL_KEYNO }">
			<input type="hidden" id="BD_KEYNO${model.BL_KEYNO }" name="BD_KEYNO" value="">
			<c:set var="BL_VALIDATE" value=""/>
			<c:if test="${model.BL_VALIDATE eq 'Y' }">
				<c:set var="BL_VALIDATE" value="BD_TYPE_VALIDATE"/>
			</c:if>
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE }">
				<div class="row">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label"> <c:if test="${model.BL_VALIDATE eq 'Y' }"><span>*</span></c:if> ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<div class="input-group">
							<c:if test="${not empty BoardNotice }">
								<c:if test="${action eq 'insert' }">
								<input type="text" class="form-control ${BL_VALIDATE} checkTrim" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="RE:${BoardNotice.BN_TITLE}" maxlength="70">
								</c:if>
								<c:if test="${action eq 'update' || action eq 'move'}">
								<input type="text" class="form-control ${BL_VALIDATE} checkTrim" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="${BoardNotice.BN_TITLE}" maxlength="70">
								</c:if>
							</c:if>
							<c:if test="${empty BoardNotice }">
								<input type="text" class="form-control ${BL_VALIDATE} checkTrim" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
							</c:if>
							<span class="input-group-addon"><i class="fa fa-bold"></i></span>
							</div>
						</div>
					</div>
				</div>
				<c:set var="checkTitle" value="true"/>
			</c:if>
			
			<c:if test="${checkTitle && BoardType.BT_THUMBNAIL_YN eq 'Y' }">
				<c:set var="checkTitle" value="false"/>
				<div class="row" id="thumnail_Y">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label"><span>*</span> 썸네일</label>
						<div class="col-md-6 smart-form">
							<img style="width:${BoardType.BT_THUMBNAIL_WIDTH }px;height:${BoardType.BT_THUMBNAIL_HEIGHT }px;margin:5px 0;" onerror="this.style.display='none';this" src="/resources/img/upload/${BoardNotice.THUMBNAIL_PATH }" id="thumbnail_img" alt="썸네일"/>
							<div class="input input-file">
								<span class="button">
									<input id="thumbnail" type="file" name="thumbnail" onchange="cf_imgCheckAndPreview('thumbnail')">파일선택
								</span>
								<input type="text" name="thumbnail_text" id="thumbnail_text" placeholder="이미지를 선택하여주세요.">
							</div>
							<p class="note">사이즈 :: ${BoardType.BT_THUMBNAIL_WIDTH } X ${BoardType.BT_THUMBNAIL_HEIGHT } 사이즈가 다를시 자동 리사이즈 됩니다.</p>
							<input type="hidden" name="BT_THUMBNAIL_WIDTH" value="${BoardType.BT_THUMBNAIL_WIDTH }">
							<input type="hidden" name="BT_THUMBNAIL_HEIGHT" value="${BoardType.BT_THUMBNAIL_HEIGHT  }">
						</div>
					</div>
				</div>
			</c:if>
			
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TEXT }">
				<div class="row" id="youtubelink">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' } ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<input type="text" class="form-control ${BL_VALIDATE} checkTrim" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_LINK }">
				<div class="row">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<input type="text" class="form-control ${BL_VALIDATE}" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
						</div>
						<div class="col-md-4">
							<button type="button" class="btn btn-primary" onclick="pf_link('BD_DATA${model.BL_KEYNO }')">링크 확인</button>
						</div>
						<div class="col-md-2"></div>
						<div class="col-md-10">
							<p style="color:red;">외부 url의 경우 http:// 나 https:// 로 시작되어야됩니다.</p>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR }">
				<div class="row">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<div class="input-group">
								<input type="text" class="form-control ${BL_VALIDATE} BD_DATA_CALENDAR datepicker" data-dateformat="yy-mm-dd" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="10" readonly="readonly">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_START }">
				<div class="row">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<div class="input-group">
								<input type="text" class="form-control ${BL_VALIDATE} BD_DATA_CALENDAR_START datepicker" data-dateformat="yy-mm-dd" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="10" readonly="readonly">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_END }">
				<div class="row">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<div class="input-group">
								<input type="text" class="form-control ${BL_VALIDATE} BD_DATA_CALENDAR_END datepicker" data-dateformat="yy-mm-dd" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="10" readonly="readonly">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_PWD }">
				<div class="row">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<div class="input-group">
								<input type="password" class="form-control ${BL_VALIDATE}" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="20">
								<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_EMAIL }">
				<div class="row">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<label class="input-group"> 
								<input type="text" class="form-control ${BL_VALIDATE} BD_DATA_EMAIL" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="30">
								<span class="input-group-addon"><i class="fa fa-envelope-o"></i></span>
							</label>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_NUMBER }">
				<div class="row">
					<div class="form-group has-feedback">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<label class="input-group"> 
								<input type="number" class="form-control ${BL_VALIDATE} BD_DATA_NUMBER" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="11">
								<span class="input-group-addon"><i class="fa fa-cube"></i></span>
							</label>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CHECK }">
				<div class="row">
					<div class="form-group">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<input type="hidden" name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" value=""  class="${BL_VALIDATE}" data-type="check" data-title="${model.BL_COLUMN_NAME }">
							<c:set var="checkData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
							<c:forEach items="${checkData }" var="OPTIONDATA" varStatus="c">
								<label class="checkbox-inline">
									<input type="checkbox" class="checkbox style-0" name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA }" onchange="pf_checkOption(this)">
									<span>${OPTIONDATA }</span>
								</label>
							</c:forEach>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_RADIO }">
				<div class="row">
					<div class="form-group">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<input type="hidden" name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" value=""  class="${BL_VALIDATE}" data-type="radio" data-title="${model.BL_COLUMN_NAME }">
							<c:set var="checkData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
							<c:forEach items="${checkData }" var="OPTIONDATA" varStatus="c">
								<label class="radio radio-inline">
									<input type="radio" class="radiobox style-0" name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA }" onchange="pf_radioOption(this)">
									<span>${OPTIONDATA }</span>
								</label>
							</c:forEach>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_SELECT }">
				<div class="row">
					<div class="form-group">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<select name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" class="form-control ${BL_VALIDATE}" data-title="${model.BL_COLUMN_NAME }">
								<option value="">선택하세요</option>
								<c:set var="selectData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
								<c:forEach items="${selectData }" var="OPTIONDATA">
									<option value="${OPTIONDATA }">${OPTIONDATA }</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
				<div class="row">
					<div class="form-group">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<input type="hidden" name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" value=""  class="${BL_VALIDATE}" data-type="check" data-title="${model.BL_COLUMN_NAME }">
							<c:set var="checkData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
							<c:forEach items="${BoardColumnCodeList }" var="OPTIONDATA" varStatus="c">
								<c:if test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
								<label class="checkbox-inline">
									<input type="checkbox" class="checkbox style-0" name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA.SC_KEYNO }" onchange="pf_checkOption(this)">
									<span>${OPTIONDATA.SC_CODENM }</span>
								</label>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_RADIO_CODE }">
				<div class="row">
					<div class="form-group">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<input type="hidden" name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" value=""  class="${BL_VALIDATE}" data-type="radio" data-title="${model.BL_COLUMN_NAME }">
							<c:set var="checkData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
							<c:forEach items="${BoardColumnCodeList }" var="OPTIONDATA" varStatus="c">
								<c:if test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
								<label class="radio radio-inline">
									<input type="radio" class="radiobox style-0" name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA.SC_KEYNO }" onchange="pf_radioOption(this)">
									<span>${OPTIONDATA.SC_CODENM }</span>
								</label>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_SELECT_CODE }">
				<div class="row">
					<div class="form-group">
						<label class="col-md-2 control-label">${model.BL_VALIDATE eq 'Y' ?'<span>*</span>':'' }  ${model.BL_COLUMN_NAME }</label>
						<div class="col-md-6">
							<select name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" class="form-control ${BL_VALIDATE}" data-title="${model.BL_COLUMN_NAME }">
								<option value="">선택하세요</option>
								<c:set var="selectData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
								<c:forEach items="${BoardColumnCodeList }" var="OPTIONDATA">
									<c:if test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
									<option value="${OPTIONDATA.SC_KEYNO }">${OPTIONDATA.SC_CODENM }</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
			</c:if>
			
		</c:forEach>
		
		<c:if test="${BoardType.BT_UPLOAD_YN == 'Y' && not empty userInfo}">
			<div class="row" id="file_Y">
				<div class="form-group has-feedback">
					<label class="col-md-2 control-label">첨부파일</label>
					<div class="col-md-6">
						<%@ include file="/WEB-INF/jsp/txap/operation/file/pra_file_insertView.jsp"%>
						<c:if test="${action eq 'update' || action eq 'move'}">
							<input type="hidden" name="fsSize" id="fsSize" value="${fn:length(FileSub) }">
							<c:set var="filecnt" value="${fn:length(FileSub) }"/>
							<c:if test="${fn:length(FileSub) > 0}">
									<input type="hidden" name="BN_FM_KEYNO" id="BN_FM_KEYNO" value="${BoardNotice.BN_FM_KEYNO }">
							</c:if>
						</c:if>
					</div>
				</div>
			</div>
		</c:if>
		
		<c:if test="${BoardType.BT_SECRET_YN == 'Y'}">
			<div class="row">
				<div class="form-group">
					<label class="col-md-2 control-label">비밀글 여부</label>
					<div class="col-md-6">
						<label class="radio radio-inline">
							<input type="radio" class="radiobox style-0" name="BN_SECRET_YN" value="Y">
							<span>비밀글</span>
						</label>
						<label class="radio radio-inline">
							<input type="radio" class="radiobox style-0" name="BN_SECRET_YN" value="N" checked>
							<span>일반글</span>
						</label>
					</div>
				</div>
			</div>
		</c:if>
		
		<div class="row">
			<div class="form-group has-feedback">
				<label class="col-md-2 control-label"><span>*</span> 내용</label>
				<div class="col-md-8">
					<c:if test="${action eq 'insert' }">
					<textarea name="BN_CONTENTS" id="BN_CONTENTS" rows="5" style="width:100%;height:400px;min-width:260px;"></textarea>
					</c:if>
					<c:if test="${action eq 'update' || action eq 'move'}">
					<textarea name="BN_CONTENTS" id="BN_CONTENTS" rows="5" style="width:100%;height:400px;min-width:260px;">${BoardNotice.BN_CONTENTS }</textarea>
					</c:if>
				</div>
			</div>
		</div>
		
		
		<div class="form-actions">
			<div class="row">
				<div class="col-md-12">
					<c:if test="${action eq 'insert' }">
						<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_boardDataInsert()">등록</button>
					</c:if>
					<c:if test="${action eq 'update' }">
						<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_boardDataUpdate()">수정</button>
					</c:if>
					<c:if test="${action eq 'move' }">
						<button class="btn btn-sm btn-primary" type="button" onclick="pf_boardDataUpdate('${action}')">이동</button>
					</c:if>
						<button class="btn btn-sm btn-default" id="Board_Delete" type="button" onclick="pf_back();">취소</button> 
				</div>
			</div>
		</div>
		</fieldset>
		
	</form:form>
					</div>
				</div>
			</article>
		</div>
	</section>
</div>

<script>
$("#file_Y").hide();	
$("#thumnail_Y").hide();	

$("input:radio[name='linkinsert']").click(function(){
	if($("input:radio[name='linkinsert']:checked").val() == "Y"){
		$("#youtubelink").show();
		$("#file_Y").hide();	
		$("#thumnail_Y").hide();	
	}else{
		$("#youtubelink").hide();
		$("#file_Y").show();	
		$("#thumnail_Y").show();	
	}	
	});
	
	
if("${action}" == "update" ){
	if("${filecnt}" >= 1 ){
		$("#linkinsert2").attr("checked","checked");
		$("#youtubelink").hide();
		$("#file_Y").show();	
		$("#thumnail_Y").show();	
	}else{
		$("#linkinsert1").attr("checked","checked");
		$("#youtubelink").show();
		$("#file_Y").hide();	
		$("#thumnail_Y").hide();	
	}
}

</script>