<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script>
	if (!window.jQuery.ui) {
		document.write('<script src="/resources/smartadmin/js/libs/jquery-ui-1.10.3.min.js"><\/script>');
	}
</script>
<script type="text/javascript">
//전역변수선언
var editor_object = [];
var action = '${action}';
var isAdmin = '${userInfo.isAdmin}'; 
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
//     nhn.husky.EZCreator.createInIFrame({
//         oAppRef: editor_object,
//         elPlaceHolder: "BN_CONTENTS",
//         sSkinURI: "/resources/smarteditor2/SmartEditor2Skin.html",
//         htParams : {
//             // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
//             	bUseToolbar : webEditUseYn,   
//             // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
//             bUseVerticalResizer : webEditUseYn,    
//             // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
//             bUseModeChanger : webEditUseYn
//         },
//         menuName : '${currentMenu.MN_NAME}' //본문에 이미지 저장시 사용되는 캡션
//     });
	
    
    if(action == 'update' || "${BoardType.BT_KEYNO}" == "${PreBoardType.BT_KEYNO}" ){
    	pf_initColumnData("${BoardNotice.BN_KEYNO }")
    	cf_radio_checked("BN_SECRET_YN", "${BoardNotice.BN_SECRET_YN }");
    	if(isAdmin == 'Y'){
    		cf_radio_checked("BN_IMPORTANT", "${BoardNotice.BN_IMPORTANT }");
    	}
    }
    
//     $("iframe").attr("title","네이버 에디터");
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
// 	editor_object.getById["BN_CONTENTS"].exec("UPDATE_CONTENTS_FIELD", []);

	
	
	var userInfo = '${userInfo}';
	if(!userInfo){ // 비회원일시
		if(!$("#BN_NAME").val()){
			alert('작성자를 입력하여주세요.')
			$("#BN_NAME").focus()
			return false;
		}else{
			$('#BN_REGNM').val($("#BN_NAME").val())
		}
		if(!$("#BN_PWD").val()){
			alert('비밀번호를 입력하여주세요.')
			$("#BN_PWD").focus()
			return false;
		}
	}
	
	var state = false;
// 	$('.BD_TYPE_VALIDATE').each(function(){ //필수 항목들 널체크
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
// 	});
	
	if(state){
		return false;
	}
	
	$('.BD_DATA_EMAIL').each(function(){ //이메일 형식 체크
		var value = $(this).val();
		
		if(!state && value && !/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i.test( value )){
			alert($(this).data('title')+'의 이메일 형식이 올바르지 않습니다.');
			$(this).focus();
			state = true;
		}
	});
	
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
		if( action == 'insert' || ((action == 'update' || action == 'move' ) && !$('#BN_THUMBNAIL').val()) ){
			//갤러리형
			if(!$("#thumbnail").val()){
				alert("썸네일 이미지를 선택해주세요");
				return false;
			}
		}
	}
	if("${BoardType.BT_SECRET_YN }" == "Y"){
		if(!cf_radio_check_val("BN_SECRET_YN")){
			alert("비밀글 사용여부를 선택해주세요");
			return false;
		}		
	}
	var BN_CONTENTS = $("#BN_CONTENTS").val()
// 	if( BN_CONTENTS == ""  || BN_CONTENTS == null || BN_CONTENTS == '&nbsp;' || BN_CONTENTS == '<p>&nbsp;</p>')  {
//          alert("내용을 입력하세요.");
//          editor_object.getById["BN_CONTENTS"].exec("FOCUS"); //포커싱
//          return false;
//     }
	console.log('${currentMenu.MN_GONGNULI_YN}')
	if('${currentMenu.MN_GONGNULI_YN}' == 'Y'){
		$('#BN_GONGNULI_TYPE').val($('input[name="rgt_type_code"]:checked').val())
		console.log($('input[name="rgt_type_code"]:checked').val())
	}
	
	return true;
}

function pf_boardDataInsert(){
	
// 	if(!pf_formCheck()){
// 		return false;
// 	}
	
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
		updateFileInfo(success);
	}else{
		success();
	}
}


function success(){
	if(action == 'insert'){
		$("#Form").attr("action", "${tilesUrl }/BoardData/insert.do?${_csrf.parameterName}=${_csrf.token}");
	}else if(action == 'update'){
		$("#Form").attr("action", "${tilesUrl }/BoardData/update.do?${_csrf.parameterName}=${_csrf.token}");
	}else if(action == 'move'){
		$("#Form").attr("action", "${tilesUrl }/Board/data/move.do?${_csrf.parameterName}=${_csrf.token}");
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
		type: "GET",
		url: "${tilesUrl }/BoardData/updateView/listAjax.do",
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
	location.href="${mirrorPage }";
}

function pf_ClipBoard(obj){
	var select_input = $(obj).parent().parent().find(".column_data");
	
	if(cf_copyToClipboard(select_input.val())){
		alert("값이 복사되었습니다.")
	}else{
		alert("복사하기 기능을 지원하지 않는 브라우저 입니다.")
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


<article id="container" class="container_sub clearfix">
	<div class="inner">
		<div class="conSub01_bottomBox">
			<div class="innerContainer clearfix">
				<c:if test="${BoardHtml.BIH_DIV_LOCATION eq 'T' }">
					<div id="html_contents">${BoardHtml.BIH_CONTENTS }</div>
				</c:if>
				<form:form id="Form" name="Form" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="BD_BT_KEYNO"
						value="${BoardType.BT_KEYNO }">
					<input type="hidden" name="BT_EMAIL_YN"
						value="${BoardType.BT_EMAIL_YN }">
					<input type="hidden" name="BT_EMAIL_ADDRESS"
						value="${BoardType.BT_EMAIL_ADDRESS }">
					<input type="hidden" name="BN_MN_KEYNO" value="${Menu.MN_KEYNO }">
					<input type="hidden" name="MN_KEYNO" value="${Menu.MN_KEYNO }">

					<c:if test="${currentMenu.MN_GONGNULI_YN eq 'Y'}">
						<input type="hidden" name="BN_GONGNULI_TYPE" id="BN_GONGNULI_TYPE"
							value="${not empty BoardNotice.BN_GONGNULI_TYPE ? BoardNotice.BN_GONGNULI_TYPE : currentMenu.MN_GONGNULI_TYPE }">
					</c:if>
					<c:if test="${not empty BoardNotice}">
						<input type="hidden" name="BN_MAINKEY" id="BN_MAINKEY"
							value="${BoardNotice.BN_MAINKEY }">
						<input type="hidden" name="BN_PARENTKEY" id="BN_PARENTKEY"
							value="${BoardNotice.BN_KEYNO}">
						<input type="hidden" name="BN_SEQ" id="BN_SEQ"
							value="${BoardNotice.BN_SEQ }">
						<input type="hidden" name="BN_DEPTH" id="BN_DEPTH"
							value="${BoardNotice.BN_DEPTH}">
					</c:if>
					<c:if test="${action eq 'insert' }">
						<input type="hidden" name="BN_REGNM" id="BN_REGNM"
							value="${userInfo.UI_KEYNO }">
					</c:if>
					
					<c:if test="${action eq 'update' || action eq 'move'  }">
						<input type="hidden" name="BN_KEYNO" value="${BoardNotice.BN_KEYNO }">
						<input type="hidden" name="BN_MODNM" value="${userInfo.UI_KEYNO }">
						<input type="hidden" name="BN_THUMBNAIL" id="BN_THUMBNAIL" value="${BoardNotice.BN_THUMBNAIL }">
					</c:if>
					<c:if test="${action eq 'move' }">
						<input type="hidden" name="BN_MOVE_MEMO"
							value="${BoardNotice.BN_MOVE_MEMO }">
						<input type="hidden" name="BT_KEYNO"
							value="${PreBoardType.BT_KEYNO }">
					</c:if>

					<c:if test="${action eq 'move' }">
						<div class="boardUploadWrap">
							<h3>이전 게시물 컬럼 데이터</h3>
							<c:if
								test="${action eq 'move' && BoardType.BT_KEYNO ne PreBoardType.BT_KEYNO }">
								<c:forEach items="${PreBoardColumnData }" var="model">
									<c:if test="${model.BD_BL_TYPE ne BOARD_COLUMN_TYPE_TITLE and !empty model.BD_DATA}">
										<div class="row">
											<p class="titleBox">
												<label>${model.COLUMN_NAME }</label>
											</p>
											<p class="formBox">
												<input class="txtDefault txtWmiddle_1 column_data"
													type="text" value="${model.BD_DATA }" readonly="readonly">
												<select id="BD_DATA${model.BD_KEYNO }"
													class="txtDefault txtWmiddle_1">
													<option value="">선택하세요</option>
													<c:forEach items="${BoardColumnList }" var="model2">
														<c:if test="${model.BD_BL_TYPE eq model2.BL_TYPE }">
															<option value="${model2.BL_KEYNO }">${model2.BL_COLUMN_NAME }</option>
														</c:if>
													</c:forEach>
												</select> <input class="btn btnSmall_01" type="button" value="적용하기"
													onclick="pf_adjust('BD_DATA${model.BD_KEYNO }', '${model.BD_BL_TYPE}', '${model.BD_DATA}');">
												<a class="btn btn-default btn-xs" href="#"
													onclick="pf_ClipBoard(this);"> <!-- <i class="fa fa-copy"></i> -->
												</a>
											</p>
										</div>
									</c:if>
								</c:forEach>
							</c:if>
						</div>
					</c:if>

					<section id="sub-content">
						<div class="inner1200">
							<!-- 타이틀 -->
							<div class="sub-title-box">
								<h2>${currentMenu.MN_NAME }</h2>

								<ul class="list_ul">
									<li class="home"><i class="xi-home"></i></li>
									<c:forEach items="${fn:split(currentMenu.MN_MAINNAMES,',') }" var="model">
										<li>${model }</li>
									</c:forEach>
								</ul>
							</div>

							<!-- 서브컨텐츠 시작 -->
							<div class="sub-con-start">

								<!-- 게시판 글쓰기 -->
								<div class="board-write-box">
									<!-- 글쓰기 테이블 -->
									<div class="table-box">
										<table class="tbl_budget">
													<colgroup>
														<col width="20%">
														<col width="30%">
														<col width="20%">
														<col width="30%">
													</colgroup>
													<caption>게시판</caption>
													<thead>
													</thead>
													<tbody>
											<c:forEach items="${BoardColumnList }" var="model" varStatus="status">
												<input type="hidden" name="BD_BL_TYPE" value="${model.BL_TYPE }">
												<input type="hidden" name="BD_BL_KEYNO" value="${model.BL_KEYNO }">
												<input type="hidden" id="BD_KEYNO${model.BL_KEYNO }" name="BD_KEYNO" value="공고중|종료&결과">
												<c:set var="BL_VALIDATE" value="" />
												<c:if test="${model.BL_VALIDATE eq 'Y' }">
													<c:set var="BL_VALIDATE" value="BD_TYPE_VALIDATE" />
												</c:if>
														
												<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE }">
													<tr>
														<th>
															<label for="BD_DATA${model.BL_KEYNO }">계약명 </label>
														</th>
														<td colspan="3"><c:if test="${not empty BoardNotice }">
																<c:if test="${action eq 'insert' }">
																	<input type="text"	class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }"
																		id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="RE:${BoardNotice.BN_TITLE}" maxlength="70">
																</c:if>
																<c:if test="${action eq 'update' || action eq 'move' }">
																	<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }" 
																	id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="${BoardNotice.BN_TITLE}" maxlength="70">
																</c:if>
															</c:if> 
															<c:if test="${empty BoardNotice }">
																<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }"
																	id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
															</c:if>
														</td>
													</tr>
													<c:set var="checkTitle" value="true" />
												</c:if>
											
												
											<!-- 텍스트 형일때 -->	
										<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TEXT }">
											<c:if test="${model.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE }">	
												<c:if test="${model.BL_COLUMN_LEVEL ne 5 and model.BL_COLUMN_LEVEL ne 7 and model.BL_COLUMN_LEVEL ne 9 and model.BL_COLUMN_LEVEL ne 11 and model.BL_COLUMN_LEVEL ne 13 and model.BL_COLUMN_LEVEL ne 17 and  model.BL_COLUMN_LEVEL ne 21 and  model.BL_COLUMN_LEVEL ne 23 and  model.BL_COLUMN_LEVEL ne 26}">
													<tr>
												</c:if>
													<c:choose>
														<c:when test="${model.BL_COLUMN_LEVEL eq 4 or model.BL_COLUMN_LEVEL eq 5 or model.BL_COLUMN_LEVEL eq 6 or model.BL_COLUMN_LEVEL eq 7 or model.BL_COLUMN_LEVEL eq 8 or model.BL_COLUMN_LEVEL eq 9 or model.BL_COLUMN_LEVEL eq 10 or model.BL_COLUMN_LEVEL eq 11 or model.BL_COLUMN_LEVEL eq 12 or model.BL_COLUMN_LEVEL eq 13 or model.BL_COLUMN_LEVEL eq 16 or model.BL_COLUMN_LEVEL eq 17 or model.BL_COLUMN_LEVEL eq 20 or model.BL_COLUMN_LEVEL eq 21 or model.BL_COLUMN_LEVEL eq 22 or bcl.BL_COLUMN_LEVEL eq 23 or model.BL_COLUMN_LEVEL eq 25 or model.BL_COLUMN_LEVEL eq 26 }">
															<th>
																<label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME } </label>
															</th>
															<td>
																<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1"	data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
															</td>
														</c:when>
														<c:otherwise>
															<th>
																<label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label>
															</th>
															<td colspan="3">
																<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1"	data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
															</td>
														</c:otherwise>
													</c:choose>
												<c:if test="${model.BL_COLUMN_LEVEL eq 5 or model.BL_COLUMN_LEVEL eq 7 or model.BL_COLUMN_LEVEL eq 9 or model.BL_COLUMN_LEVEL eq 11 or model.BL_COLUMN_LEVEL eq 13 or model.BL_COLUMN_LEVEL eq 17  or model.BL_COLUMN_LEVEL eq 21  or model.BL_COLUMN_LEVEL eq 23  or model.BL_COLUMN_LEVEL eq 26}">
													</tr>
												</c:if>
											</c:if>
										</c:if>	
												
										
												
												
										<!-- 링크형일때 -->
<%-- 										<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_LINK }"> --%>
<%-- 											<c:if test="${model.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE }">	 --%>
<%-- 												<c:if test="${bcl.BL_COLUMN_LEVEL ne 5 and bcl.BL_COLUMN_LEVEL ne 7 and bcl.BL_COLUMN_LEVEL ne 9 and bcl.BL_COLUMN_LEVEL ne 11 and bcl.BL_COLUMN_LEVEL ne 13 and bcl.BL_COLUMN_LEVEL ne 17 and  bcl.BL_COLUMN_LEVEL ne 21 and  bcl.BL_COLUMN_LEVEL ne 23 and  bcl.BL_COLUMN_LEVEL ne 26}"> --%>
<!-- 													<tr> -->
<%-- 												</c:if> --%>
<%-- 													<c:choose> --%>
<%-- 														<c:when test="${bcl.BL_COLUMN_LEVEL eq 4 or bcl.BL_COLUMN_LEVEL eq 5 or bcl.BL_COLUMN_LEVEL eq 6 or bcl.BL_COLUMN_LEVEL eq 7 or bcl.BL_COLUMN_LEVEL eq 8 or bcl.BL_COLUMN_LEVEL eq 9 or bcl.BL_COLUMN_LEVEL eq 10 or bcl.BL_COLUMN_LEVEL eq 11 or bcl.BL_COLUMN_LEVEL eq 12 or bcl.BL_COLUMN_LEVEL eq 13 or bcl.BL_COLUMN_LEVEL eq 16 or bcl.BL_COLUMN_LEVEL eq 17 or bcl.BL_COLUMN_LEVEL eq 20 or bcl.BL_COLUMN_LEVEL eq 21 or bcl.BL_COLUMN_LEVEL eq 22 or bcl.BL_COLUMN_LEVEL eq 23 or bcl.BL_COLUMN_LEVEL eq 25 or bcl.BL_COLUMN_LEVEL eq 26 }"> --%>
<!-- 															<th> -->
<%-- 																<label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }3</label> --%>
<!-- 															</th> -->
<!-- 															<td> -->
<%-- 																<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1"	data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70"> --%>
<!-- 															</td> -->
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<!-- 															<th> -->
<%-- 																<label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }4</label> --%>
<!-- 															</th> -->
<!-- 															<td colspan="3"> -->
<%-- 																<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1"	data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70"> --%>
<!-- 															</td> -->
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose> --%>
<%-- 												<c:if test="${bcl.BL_COLUMN_LEVEL eq 5 or bcl.BL_COLUMN_LEVEL eq 7 or bcl.BL_COLUMN_LEVEL eq 9 or bcl.BL_COLUMN_LEVEL eq 11 or bcl.BL_COLUMN_LEVEL eq 13 or bcl.BL_COLUMN_LEVEL eq 17  or bcl.BL_COLUMN_LEVEL eq 21  or bcl.BL_COLUMN_LEVEL eq 23  or bcl.BL_COLUMN_LEVEL eq 26}"> --%>
<!-- 													</tr> -->
<%-- 												</c:if> --%>
<%-- 											</c:if>	 --%>
<%-- 										</c:if> --%>
												
												
											<!-- 캘린더1 -->
											<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR }">
											<c:if test="${model.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE }">
												<c:if test="${model.BL_COLUMN_LEVEL ne 5 and model.BL_COLUMN_LEVEL ne 7 and model.BL_COLUMN_LEVEL ne 9 and model.BL_COLUMN_LEVEL ne 11 and model.BL_COLUMN_LEVEL ne 13 and model.BL_COLUMN_LEVEL ne 17 and  model.BL_COLUMN_LEVEL ne 21 and  model.BL_COLUMN_LEVEL ne 23 and  model.BL_COLUMN_LEVEL ne 26}">
													<tr>
												</c:if>
													<c:choose>
														<c:when test="${model.BL_COLUMN_LEVEL eq 4 or model.BL_COLUMN_LEVEL eq 5 or model.BL_COLUMN_LEVEL eq 6 or model.BL_COLUMN_LEVEL eq 7 or model.BL_COLUMN_LEVEL eq 8 or model.BL_COLUMN_LEVEL eq 9 or model.BL_COLUMN_LEVEL eq 10 or model.BL_COLUMN_LEVEL eq 11 or model.BL_COLUMN_LEVEL eq 12 or model.BL_COLUMN_LEVEL eq 13 or model.BL_COLUMN_LEVEL eq 16 or model.BL_COLUMN_LEVEL eq 17 or model.BL_COLUMN_LEVEL eq 20 or model.BL_COLUMN_LEVEL eq 21 or model.BL_COLUMN_LEVEL eq 22 or bcl.BL_COLUMN_LEVEL eq 23 or model.BL_COLUMN_LEVEL eq 25 or model.BL_COLUMN_LEVEL eq 26 }">
															<th>
																<label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label>
															</th>
															<td>
																<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1 BD_DATA_CALENDAR" data-title="${model.BL_COLUMN_NAME }"
																id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="10" readonly> <img
																src="/resources/img/icon/icon_calendar_01.png" alt="작성일선택">
															</td>
														</c:when>
														<c:otherwise>
															<th>
																<label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label>
															</th>
															<td colspan="3">
																<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1 BD_DATA_CALENDAR" data-title="${model.BL_COLUMN_NAME }"
																id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="10" readonly> <img
																src="/resources/img/icon/icon_calendar_01.png" alt="작성일선택">
															</td>
														</c:otherwise>
													</c:choose>
												<c:if test="${model.BL_COLUMN_LEVEL eq 5 or model.BL_COLUMN_LEVEL eq 7 or model.BL_COLUMN_LEVEL eq 9 or model.BL_COLUMN_LEVEL eq 11 or model.BL_COLUMN_LEVEL eq 13 or model.BL_COLUMN_LEVEL eq 17  or model.BL_COLUMN_LEVEL eq 21  or model.BL_COLUMN_LEVEL eq 23  or model.BL_COLUMN_LEVEL eq 26}">
													</tr>
												</c:if>
											</c:if>
											</c:if>
												
												
												
												<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_START }">
													<tr>
														<th><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label>
														</th>
														<td><input type="text"
															class="${BL_VALIDATE} txtDefault txtWlong_1 BD_DATA_CALENDAR_START"
															data-title="${model.BL_COLUMN_NAME }"
															id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value=""
															maxlength="10" readonly> <img
															src="/resources/img/icon/icon_calendar_01.png"
															alt="작성일선택"></td>
													</tr>
												</c:if>
												<c:if
													test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_END }">
													<tr>
														<th><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label>
														</th>
														<td><input type="text"
															class="${BL_VALIDATE} txtDefault txtWlong_1 BD_DATA_CALENDAR_END"
															data-title="${model.BL_COLUMN_NAME }"
															id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value=""
															maxlength="10" readonly> <img
															src="/resources/img/icon/icon_calendar_01.png"
															alt="작성일선택"></td>
													</tr>
												</c:if>
												<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_PWD }">
													<tr>
														<th><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label>
														</th>
														<td><input type="password"
															class="${BL_VALIDATE} txtDefault txtWlong_1"
															data-title="${model.BL_COLUMN_NAME }"
															id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value=""
															maxlength="20"></td>
													</tr>
												</c:if>
												<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_EMAIL }">
													<tr>
														<th><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label>
														</th>
														<td><input type="text"
															class="${BL_VALIDATE} txtDefault txtWlong_1 BD_DATA_EMAIL"
															data-title="${model.BL_COLUMN_NAME }"
															id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value=""
															maxlength="30"></td>
													</tr>
												</c:if>
												<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CHECK }">
													<tr>
														<th><label>${model.BL_COLUMN_NAME }</label></th>
														<td><input type="hidden" name="BD_DATA"
															id="BD_DATA${model.BL_KEYNO }" value=""
															class="${BL_VALIDATE} txtDefault txtWlong_1"
															data-type="check" data-title="${model.BL_COLUMN_NAME }">
															<c:set var="checkData"
																value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
															<c:forEach items="${checkData }" var="OPTIONDATA"
																varStatus="c">
																<label><input type="checkbox"
																	name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA }"
																	onchange="pf_checkOption(this)"> ${OPTIONDATA }</label>
															</c:forEach></td>
													</tr>
												</c:if>
												<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_RADIO }">
													<tr>
														<th><label>${model.BL_COLUMN_NAME }</label></th>
														<td><input type="hidden" name="BD_DATA"
															id="BD_DATA${model.BL_KEYNO }" value=""
															class="${BL_VALIDATE} txtDefault txtWlong_1"
															data-type="radio" data-title="${model.BL_COLUMN_NAME }">
															<c:set var="checkData"
																value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
															<c:forEach items="${checkData }" var="OPTIONDATA"
																varStatus="c">
																<label><input type="radio"
																	name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA }"
																	onchange="pf_radioOption(this)"> ${OPTIONDATA }</label>
															</c:forEach></td>
													</tr>
												</c:if>
												<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_SELECT }">
													<tr>
														<th><label>${model.BL_COLUMN_NAME }</label></th>
														<td><select name="BD_DATA"
															id="BD_DATA${model.BL_KEYNO }"
															class="${BL_VALIDATE} txtDefault txtWlong_1"
															data-title="${model.BL_COLUMN_NAME }">
																<option value="">선택하세요</option>
																<c:set var="selectData"
																	value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
																<c:forEach items="${selectData }" var="OPTIONDATA">
																	<option value="${OPTIONDATA }">${OPTIONDATA }</option>
																</c:forEach>
														</select></td>
													</tr>
												</c:if>
												<c:if
													test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
													<tr>
														<th><label>${model.BL_COLUMN_NAME }</label></th>
														<td><input type="hidden" name="BD_DATA"
															id="BD_DATA${model.BL_KEYNO }" value=""
															class="${BL_VALIDATE} txtDefault txtWlong_1"
															data-type="check" data-title="${model.BL_COLUMN_NAME }">
															<c:forEach items="${BoardColumnCodeList }"
																var="OPTIONDATA" varStatus="c">
																<c:if
																	test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
																	<label><input type="checkbox"
																		name="BD_DATA${model.BL_KEYNO }"
																		value="${OPTIONDATA.SC_KEYNO }"
																		onchange="pf_checkOption(this)">
																		${OPTIONDATA.SC_CODENM }</label>
																</c:if>
															</c:forEach></td>
													</tr>
												</c:if>
												<c:if
													test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_RADIO_CODE }">
													<tr>
														<th><label>${model.BL_COLUMN_NAME }</label></th>
														<td><input type="hidden" name="BD_DATA"
															id="BD_DATA${model.BL_KEYNO }" value=""
															class="${BL_VALIDATE} txtDefault txtWlong_1"
															data-type="radio" data-title="${model.BL_COLUMN_NAME }">
															<c:forEach items="${BoardColumnCodeList }"
																var="OPTIONDATA" varStatus="c">
																<c:if
																	test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
																	<label><input type="radio"
																		name="BD_DATA${model.BL_KEYNO }"
																		value="${OPTIONDATA.SC_KEYNO }"
																		onchange="pf_radioOption(this)">
																		${OPTIONDATA.SC_CODENM }</label>
																</c:if>
															</c:forEach></td>
													</tr>
												</c:if>

												<c:if
													test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_SELECT_CODE }">
													<tr>
														<th><label>${model.BL_COLUMN_NAME }</label></th>
														<td><select name="BD_DATA"
															id="BD_DATA${model.BL_KEYNO }"
															class="${BL_VALIDATE} txtDefault txtWlong_1"
															data-title="${model.BL_COLUMN_NAME }">
																<option value="">선택하세요</option>
																<c:forEach items="${BoardColumnCodeList }"
																	var="OPTIONDATA">
																	<c:if
																		test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
																		<option value="${OPTIONDATA.SC_KEYNO }">${OPTIONDATA.SC_CODENM }</option>
																	</c:if>
																</c:forEach>
														</select></td>
													</tr>
												</c:if>
											</c:forEach> 
<%-- 											<c:if test="${BoardType.BT_UPLOAD_YN == 'Y'  && not empty userInfo}"> --%>
<!-- 												<tr> -->
<!-- 													<th><label>첨부파일</label></th> -->
<%-- 													<td><%@ include --%>
<%-- 															file="/WEB-INF/jsp/txap/operation/file/pra_file_insertView.jsp"%> --%>

<%-- 														<c:if test="${action eq 'update' || action eq 'move'}"> --%>
<%-- 															<input type="hidden" name="fsSize" id="fsSize" value="${fn:length(FileSub) }"> --%>
														
<%-- 														<c:if test="${fn:length(FileSub) > 0}"> --%>
<%-- 															<input type="hidden" name="BN_FM_KEYNO" id="BN_FM_KEYNO" value="${BoardNotice.BN_FM_KEYNO }"> --%>
<%-- 														</c:if> --%>
														
<%-- 														</c:if></td> --%>
<!-- 												</tr> -->
<%-- 											</c:if>  --%>
											<c:if test="${BoardType.BT_SECRET_YN == 'Y'}">
												<tr>
													<th><label>비밀글 여부</label></th>
													<td><label><input type="radio"
															class="radioDefault" name="BN_SECRET_YN" value="Y">비밀글</label>
														<label><input type="radio" class="radioDefault"
															name="BN_SECRET_YN" value="N" checked>일반글</label></td>
												</tr>
											</c:if>
<!-- 											<tr> -->
<!-- 												<th><label>내용</label></th> -->
<%-- 												<td><c:if test="${action eq 'insert' }"> --%>
<!-- 														<textarea name="BN_CONTENTS" id="BN_CONTENTS" rows="5" -->
<!-- 															style="width: 100%; height: 400px; min-width: 260px;" -->
<!-- 															title="내용을 입력해주세요"></textarea> -->
<%-- 													</c:if> <c:if test="${action eq 'update' || action eq 'move'}"> --%>
<!-- 														<textarea name="BN_CONTENTS" id="BN_CONTENTS" rows="5" -->
<!-- 															style="width: 100%; height: 400px; min-width: 260px;" -->
<%-- 															title="내용을 입력해주세요">${BoardNotice.BN_CONTENTS }</textarea> --%>
<%-- 													</c:if></td> --%>
<!-- 											</tr> -->
										</tbody>
									</table>
									</div>
									<div class="btn-box-1">
										<c:if test="${currentMenu.MN_GONGNULI_YN eq 'Y' && currentMenu.MN_GONGNULI_TYPE eq '0'}">
										<div>
											<%@ include	file="/WEB-INF/jsp/common/prc_gong_nuli_insert.jsp"%>
										</div>
									</c:if>
										<div class="btnBox textC">
											<c:if test="${action eq 'insert' }">
												<button type="button" class="btn-upload wh"
													onclick="pf_boardDataInsert()">등록하기</button>
											</c:if>
											<c:if test="${action eq 'update' }">
												<button type="button" class="btn-upload wh"
													onclick="pf_boardDataUpdate()">수정</button>
											</c:if>
											<c:if test="${action eq 'move' }">
												<button type="button" class="btn btnBig_02 btn-default"
													onclick="pf_boardDataUpdate('${action}')">이동</button>
											</c:if>
											<button type="button" class="btn-upload bk"
												onclick="pf_back()">취소</button>
										</div>

										<c:if test="${BoardHtml.BIH_DIV_LOCATION eq 'B' }">
											<div id="html_contents">${BoardHtml.BIH_CONTENTS }</div>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</section>
				</form:form>
			</div>
		</div>
	</div>
</article>
