<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
<style>
.tbl_board_Write tbody tr th{vertical-align: middle;}
.tbl_board_Write .newsDiv{position: relative; display: block; font-weight: 400;}
.tbl_board_Write .newsSpan{color:#ffffff; position: absolute; top: 4px; right: 4px; float: none; height: 22px;  padding: 0 14px; font-size: 13px; line-height: 22px;    background-color: #3276B1; opacity: .8;  width: 100px; text-align: center;}
.tbl_board_Write .newsInput1{position: absolute; top: 0; right: 0; cursor: pointer; opacity: 0; width: 100%; height: 100%;}
.tbl_board_Write .newsInput2{width: 100%; height: 32px; line-height: 32px; padding: 5px 10px; font: 13px/16px 'Open Sans',Helvetica,Arial,sans-serif;}
</style>
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
var MenuType = '${Menu.MN_KEYNO}'; 
var Menuinquire = '${BOARD_INQUIRE}'; 
var plus = '<c:out value = "${BoardType.BT_HTMLMAKER_PLUS_YN}"/>';
$(function(){
	$('.BD_DATA_CALENDAR').datepicker(datepickerOption);
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
            bUseModeChanger : webEditUseYn
        },
        menuName : '${currentMenu.MN_NAME}' //본문에 이미지 저장시 사용되는 캡션
    });
	
    if(action == 'update'){
    	pf_initColumnData("${BoardNotice.BN_KEYNO }")
    	cf_radio_checked("BN_SECRET_YN", "${BoardNotice.BN_SECRET_YN }");
    	if(isAdmin == 'Y'){
    		cf_radio_checked("BN_IMPORTANT", "${BoardNotice.BN_IMPORTANT }");
    	}
    }
    $("iframe").attr("title","네이버 에디터");
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

	var userInfo = '${userInfo}';
	
	if(!userInfo && action == 'insert'){ // 비회원일시
		if(!$("#BN_NAME").val()){
			alert('작성자를 입력해주세요.')
			$("#BN_NAME").focus()
			return false;
		}else{
			$('#BN_REGNM').val($("#BN_NAME").val())
		}
		if(!$("#BN_PWD").val()){
			alert('비밀번호를 입력해주세요.')
			$("#BN_PWD").focus();
			return false;
		}else{
			if($("#BN_PWD").val().length < 4){
				alert("4자리이상 입력해주세요.");
				$("#BN_PWD").focus();
				return false;
			}
		}
		if(!$("#BN_PWD2").val()){
			alert('비밀번호 확인을 입력해주세요.');
			$("#BN_PWD2").focus();
			return false;
		}else{
			if($("#BN_PWD").val() != $("#BN_PWD2").val()){
				alert("비밀번호가 일치하지 않습니다.");
				$("#BN_PWD2").val('');
				$("#BN_PWD2").focus();
				return false;
			}
		}
	}
	
	if(isAdmin == 'Y' && MenuType != '${BOARD_INQUIRE}'){
		
		if(!cf_radio_check_val("BN_IMPORTANT")){
			alert("공지사용을 선택해주세요");
			return false;
		}
		if($("input:radio[name=BN_IMPORTANT]:checked").val() == 'Y' && !$("#BN_IMPORTANT_DATE").val()){
			alert('공지종료일을 입력해주세요.')
			$("#BN_IMPORTANT_DATE").focus()
			return false;
		}
	}
	var state = false;
	$('.BD_TYPE_VALIDATE').each(function(){ //필수 항목들 널체크
		if(!state && !$(this).val()){
			alert($(this).data('title')+'을 입력해주세요.');
			$(this).focus();
			state = true;
		}
	});
	
	$('.BD_DATA_EMAIL').each(function(){ //이메일 형식 체크
		if(!state && $(this).val()){
			var pattern = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!pattern.test($(this).val())){
				alert($(this).data('title')+'의 이메일 형식이 올바르지 않습니다.');
				$(this).focus();
				state = true;	
			}
		} 
		
	});
	
	if(state){
		return false;
	}
	
	
	if("${BoardType.BT_THUMBNAIL_YN}" == "Y"){
		if( action == 'insert' || (action == 'update' && !$('#BN_THUMBNAIL').val()) ){
			//갤러리형
			if(!$("#thumbnail").val()){
				alert("썸네일 이미지를 선택해주세요");
				return false;
			}
		}
	}
	if("${BoardType.BT_SECRET_YN }" == "Y" && "${userInfo.isAdmin}" != "Y"){
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

function pf_boardDataUpdate(){
	
	if(!pf_formCheck()){
		return false;
	}
	if(confirm("게시물을 수정하시겠습니까?")){
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
	}else{
		alert('오류발생 : action값 없음');
		return false;
	}
	if(MenuType == Menuinquire && (isAdmin != 'Y' || !isAdmin)){
		grecaptcha.execute();
	}else{
		$("#Form").submit();
	}
}
function exit(){
	alert("취소되었습니다.");
	return false;
}

function onSubmit(){
	$("#Form").submit();
}

function pf_initColumnData(BN_KEYNO){
	cf_loading();
	$.ajax({
		type: "POST",
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



</script>
<article id="container" class="container_sub clearfix">
	<div class="inner">
		<div class="conSub01_bottomBox">
			<div class="innerContainer clearfix">
				<c:if test="${BoardHtml.BIH_DIV_LOCATION eq 'T' }">
				<div id="html_contents">${BoardHtml.BIH_CONTENTS }</div>
				</c:if>
				<form:form id="Form" name="Form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="BT_EMAIL_YN" value="${BoardType.BT_EMAIL_YN }">
						<input type="hidden" name="BT_EMAIL_ADDRESS" value="${BoardType.BT_EMAIL_ADDRESS }">
						<input type="hidden" name="BN_MN_KEYNO" value="${Menu.MN_KEYNO }">
						<input type="hidden" name="MN_KEYNO" value="${Menu.MN_KEYNO }">
						<c:if test="${not empty BoardNotice}">
						<input type="hidden" name="BN_MAINKEY" id="BN_MAINKEY" value="${BoardNotice.BN_MAINKEY }">
						<input type="hidden" name="BN_PARENTKEY" id="BN_PARENTKEY" value="${BoardNotice.BN_KEYNO}">
						<input type="hidden" name="BN_SEQ" id="BN_SEQ" value="${BoardNotice.BN_SEQ }">
						<input type="hidden" name="BN_DEPTH" id="BN_DEPTH" value="${BoardNotice.BN_DEPTH}">
						</c:if>
						<c:if test="${action eq 'insert' }">
							<input type="hidden" name="BN_REGNM" id="BN_REGNM" value="${userInfo.UI_KEYNO }">
						</c:if>
						<c:if test="${action eq 'update' }">
							<input type="hidden" name="BN_KEYNO" value="${BoardNotice.BN_KEYNO }">
							<input type="hidden" name="BN_MODNM" value="${userInfo.UI_KEYNO }">
							<input type="hidden" name="BN_THUMBNAIL" id="BN_THUMBNAIL" value="${BoardNotice.BN_THUMBNAIL }">
						</c:if>
<!-- 본문 시작 -->
<div class="subContentInner">
    <div class="boardWriteBox"> <!-- 글 작성 시작 -->
		
			<table class="tbl_board_Write" summary="${currentMenu.MN_NAME } 게시물을 등록하거나 수정합니다.">
             	<colgroup>
                 	<col width="15%">
                 	<col width="35%">
                 	<col width="15%">
                 	<col width="35%">
                 </colgroup>
                 <caption>${currentMenu.MN_NAME }</caption>
                 <thead></thead>
                 <tbody>
                 	<c:if test="${(action eq 'insert' && Menu.MN_KEYNO eq BOARD_INQUIRE) && userInfo.isAdmin ne 'Y'}">
	                 	<!--  && empty userInfo -->
	                 	<tr>
	                     	<th scope="row"><label for="BN_NAME"><span><i class="fal fa-check"></i></span> 작성자</label></th>
	                         <td colspan="3">
	                         	<input type="text"  class=" txtDefault txtWUploadM" name="BN_NAME" id="BN_NAME" maxlength="10">
	                         </td>
	                    </tr>
	                 	<tr>
	                     	<th scope="row"><label for="BN_PWD"><span><i class="fal fa-check"></i></span> 비밀번호입력</label></th>
	                         <td>
	                         	<input type="password" class="txtDefault txtWUploadPwd" name="BN_PWD" id="BN_PWD" maxlength="10">
	                         	<p class="passParaph">(4자리이상 입력해주세요.)</p>
	                         </td>
	                     	<th scope="row"><label for="BN_PWD2"><span class="redSpan"><i class="fal fa-check"></i></span> 비밀번호확인</label></th>
	                         <td>
	                         	<input type="password" class="txtDefault txtWUploadPwd" name="BN_PWD2" id="BN_PWD2" maxlength="10">
	                         </td>
	                     </tr>
                     </c:if> 
                	<c:if test="${userInfo.isAdmin eq 'Y' && Menu.MN_KEYNO ne BOARD_INQUIRE }">
						<tr>
	                     	<th scope="row"><label for="BN_IMPORTANT"><span><i class="fal fa-check"></i></span> 공지사용</label></th>
	                        <td>
	                         	<label><input type="radio" class="radioDefault" name="BN_IMPORTANT" value="Y">공지(상단에 항상 노출)</label>
								<label><input type="radio" class="radioDefault" name="BN_IMPORTANT" value="N" checked>일반글</label>
	                        </td>
	                     	<th scope="row"><label for="BN_IMPORTANT_DATE"><span><i class="fal fa-check"></i></span> 공지 종료일</label></th>
	                        <td>
	                         	<input style="width: 60%;" type="text" name="BN_IMPORTANT_DATE"  placeholder="공지글일 경우 종료날짜 선택" class="txtDefault txtWlong_1" id="BN_IMPORTANT_DATE" maxlength="10" readonly value="${BoardNotice.BN_IMPORTANT_DATE }"> <img src="/resources/img/icon/icon_calendar_01.png" alt="작성일선택">
	                        </td>
	                    </tr>
						<script>
						$(function(){
							$('#BN_IMPORTANT_DATE').datepicker(datepickerOption);
						})
						</script>
					</c:if>

						<c:if test="${BoardType.BT_SECRET_YN == 'Y' && userInfo.isAdmin ne 'Y'}">
						<tr>
	                     	<th scope="row"><label for="txtUpSubject">비밀글 여부</label></th>
	                         <td colspan="3">
	                         	<label><input type="radio" class="radioDefault" name="BN_SECRET_YN" value="Y">비밀글</label>
								<label><input type="radio" class="radioDefault" name="BN_SECRET_YN" value="N" checked>일반글</label>
	                         </td>
	                    </tr>
	                    </c:if>
	                    
	                     <c:forEach items="${BoardColumnList }" var="model" varStatus="status">
								<input type="hidden" name="BD_BL_TYPE" value="${model.BL_TYPE }">
								<input type="hidden" name="BD_BL_KEYNO" value="${model.BL_KEYNO }">
								<input type="hidden" id="BD_KEYNO${model.BL_KEYNO }" name="BD_KEYNO" value="">
								<c:set var="BL_VALIDATE" value=""/>
								<c:if test="${model.BL_VALIDATE eq 'Y' }">
									<c:set var="BL_VALIDATE" value="BD_TYPE_VALIDATE"/>
								</c:if>
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE }">
									<tr>
	                     				<th scope="row"><label for="BD_DATA${model.BL_KEYNO }"><span><i class="fal fa-check"></i></span> ${model.BL_COLUMN_NAME }</label></th>
							        	<td colspan="3">	
										<c:if test="${not empty BoardNotice }">
											<c:if test="${action eq 'insert' }">
											<input type="text" class="${BL_VALIDATE} txtDefault txtWUploadL" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="RE:${BoardNotice.BN_TITLE}" maxlength="70">
											</c:if>
											<c:if test="${action eq 'update' }">
											<input type="text" class="${BL_VALIDATE} txtDefault txtWUploadL" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="${BoardNotice.BN_TITLE}" maxlength="70">
											</c:if>
										</c:if>
										<c:if test="${empty BoardNotice }">
											<input type="text" class="${BL_VALIDATE} txtDefault txtWUploadL" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
										</c:if>
										</td>
									</tr>	
									<c:set var="checkTitle" value="true"/>
								</c:if>
								
								<c:if test="${checkTitle && BoardType.BT_THUMBNAIL_YN eq 'Y' }">
									<c:set var="checkTitle" value="false"/>
									<tr>
	                     				<th scope="row"><label for="thumbnail">썸네일</label></th>
								      	<td colspan="3">	
											<img style="width:${BoardType.BT_THUMBNAIL_WIDTH }px;height:${BoardType.BT_THUMBNAIL_HEIGHT }px;margin:5px 0;" onerror="this.style.display='none';" src="/resources/img/upload/${BoardNotice.THUMBNAIL_PATH }" id="thumbnail_img" alt="썸네일"/>
											<div class="clear"></div>
												<div class="input input-file newsDiv">
					                         	<span class="button newsSpan">
					                         		<label for="thumbnail" class="blind">파일선택</label>
													<input id="thumbnail" class="newsInput1" type="file" name="thumbnail" onchange="cf_imgCheckAndPreview('thumbnail')">파일선택
												</span>
												<label for="thumbnail_text" class="blind">이미지를 선택해주세요</label>
												<input type="text" class="newsInput2" name="thumbnail_text" id="thumbnail_text" placeholder="이미지를 선택해주세요." readonly="readonly" value="<c:out value='${File.FS_ORINM }'/>">
				                         	</div>
											<p class="thumbnailNote">사이즈 :: ${BoardType.BT_THUMBNAIL_WIDTH } X ${BoardType.BT_THUMBNAIL_HEIGHT } 사이즈가 다를시 자동 리사이즈 됩니다.</p>
											<input type="hidden" name="BT_THUMBNAIL_WIDTH" value="${BoardType.BT_THUMBNAIL_WIDTH }">
											<input type="hidden" name="BT_THUMBNAIL_HEIGHT" value="${BoardType.BT_THUMBNAIL_HEIGHT  }">
										</td>
									</tr>	
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_NOTICE_NUMBER }">
									<!-- 공지번호 부여 -->
									<%-- <c:if test="${not empty noticeNumber.Cnt}">
										<c:set var="Cnt" value="${fn:split(noticeNumber.Cnt,'-')[2] }" />
										<fmt:formatNumber var="noticeCnt" value="${fn:split(noticeNumber.Cnt,'-')[2] +1}" pattern="000"/>
									</c:if>
									<c:if test="${empty noticeNumber.Cnt || noticeNumber.Cnt eq ''}">
										<fmt:formatNumber var="noticeCnt" value="1" pattern="000"/>
									</c:if> --%>
									<c:set var="now" value="<%=new java.util.Date()%>" />
									<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
									<tr>
	                     				<th scope="row"><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label></th>
	                     				<c:if test="${action eq 'insert' }">
											<c:set var="gonggobunho" value="${sysYear}-${NoticeType}-${noticeNumber}"/>
										</c:if>
										<td colspan="3">
											<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="${gonggobunho }" maxlength="70">
										</td>
									</tr>	
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TEXT }">
									<tr>
	                     				<th scope="row"><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">	
											<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
										</td>
									</tr>	
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_LINK }">
									<tr>
	                     				<th scope="row"><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
											<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="70">
											<button type="button" class="btn btnSmall_01" onclick="pf_link('BD_DATA${model.BL_KEYNO }')">링크 확인</button>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR }">
									<tr>
	                     				<th scope="row"><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
											<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1 BD_DATA_CALENDAR" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="10" readonly>  <img src="/resources/img/icon/icon_calendar_01.png" alt="작성일선택">
										</td>
									</tr>
								</c:if>
								
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_PWD }">
									<tr>
	                     				<th scope="row"><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label></th>
								        </p>
								        <td colspan="3">
											<input type="password" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="20">
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_EMAIL }">
									<tr>
	                     				<th scope="row"><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
											<input type="text" class="${BL_VALIDATE} txtDefault txtWlong_1 BD_DATA_EMAIL" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" maxlength="30">
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_NUMBER }">
									<tr>
	                     				<th scope="row"><label for="BD_DATA${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
											<input type="number" class="${BL_VALIDATE} txtDefault txtWlong_1 BD_DATA_NUMBER" data-title="${model.BL_COLUMN_NAME }" id="BD_DATA${model.BL_KEYNO }" name="BD_DATA" value="" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="11">
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CHECK }">
									<tr>
	                     				<th scope="row"><label>${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
											<input type="hidden" name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" value=""  class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }">
											<c:set var="checkData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
											<c:forEach items="${checkData }" var="OPTIONDATA" varStatus="c">
												<label><input type="checkbox" name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA }" onchange="pf_checkOption(this)">
												${OPTIONDATA }</label>
											</c:forEach>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_RADIO }">
									<tr>
	                     				<th scope="row"><label>${model.BL_COLUMN_NAME }</label></th>
								        </p>
								        <p class="formBox">
										<input type="hidden" name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" value="" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }">
										<c:set var="checkData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
										<c:forEach items="${checkData }" var="OPTIONDATA" varStatus="c">
											<label><input type="radio" name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA }" onchange="pf_radioOption(this)">
											${OPTIONDATA }</label>
										</c:forEach>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_SELECT }">
									<tr>
	                     				<th scope="row"><label>${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
											<select name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }">
												<option value="">선택하세요</option>
												<c:set var="selectData" value="${fn:split(model.BL_OPTION_DATA, '|') }"></c:set>
												<c:forEach items="${selectData }" var="OPTIONDATA">
													<option value="${OPTIONDATA }">${OPTIONDATA }</option>
												</c:forEach>
											</select>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
									<tr>
	                     				<th scope="row"><label>${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
										<input type="hidden" name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" value=""  class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }">
										<c:forEach items="${BoardColumnCodeList }" var="OPTIONDATA" varStatus="c">
											<c:if test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
											<label><input type="checkbox" name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA.SC_KEYNO }" onchange="pf_checkOption(this)">
											${OPTIONDATA.SC_CODENM }</label>
											</c:if>
										</c:forEach>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_RADIO_CODE }">
									<tr>
	                     				<th scope="row"><label>${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
										<input type="hidden" name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" value="" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }">
										<c:forEach items="${BoardColumnCodeList }" var="OPTIONDATA" varStatus="c">
											<c:if test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
											<label><input type="radio" name="BD_DATA${model.BL_KEYNO }" value="${OPTIONDATA.SC_KEYNO }" onchange="pf_radioOption(this)">
											${OPTIONDATA.SC_CODENM }</label>
											</c:if>
										</c:forEach>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_SELECT_CODE }">
									<tr>
	                     				<th scope="row"><label>${model.BL_COLUMN_NAME }</label></th>
								        <td colspan="3">
											<select name="BD_DATA" id="BD_DATA${model.BL_KEYNO }" class="${BL_VALIDATE} txtDefault txtWlong_1" data-title="${model.BL_COLUMN_NAME }">
												<option value="">선택하세요</option>
												<c:forEach items="${BoardColumnCodeList }" var="OPTIONDATA">
													<c:if test="${OPTIONDATA.MC_KEYNO eq model.BL_OPTION_DATA }">
													<option value="${OPTIONDATA.SC_KEYNO }">${OPTIONDATA.SC_CODENM }</option>
													</c:if>
												</c:forEach>
											</select>
										</td>
									</tr>
								</c:if>
								
							</c:forEach>
						<tr>
	                     	 <th scope="row" style="vertical-align:top;"><label for="txtUpName"><span><i class="fal fa-check"></i></span> 내용</label></th>
	                         <td colspan="3" class="contentBox">
	                         	<c:if test="${action eq 'insert' }">
									<textarea name="BN_CONTENTS" id="BN_CONTENTS" rows="5" style="width:100%;height:400px;min-width:260px;" title="내용을 입력해주세요"></textarea>
								</c:if>
								<c:if test="${action eq 'update' }">
									<textarea name="BN_CONTENTS" id="BN_CONTENTS" rows="5" style="width:100%;height:400px;min-width:260px;" title="내용을 입력해주세요">${BoardNotice.BN_CONTENTS }</textarea>
								</c:if>
	                         </td>
	                    </tr>
	                    <c:if test="${BoardType.BT_UPLOAD_YN == 'Y' && not empty userInfo}">
	                    	<tr>
		                     	 <th scope="row"><label for="txtUpSubject">첨부파일</label></th>
		                         <td colspan="3">
		                         	<%@ include file="/WEB-INF/jsp/txap/operation/file/pra_file_insertView.jsp"%>
									<c:if test="${action eq 'update'}">
										<input type="hidden" name="fsSize" id="fsSize" value="${fn:length(FileSub) }">
										<c:if test="${fn:length(FileSub) > 0}">
												<input type="hidden" name="BN_FM_KEYNO" id="BN_FM_KEYNO" value="${BoardNotice.BN_FM_KEYNO }">
										</c:if>
									</c:if>
		                         </td>
		                    </tr>
						</c:if>
						<%-- <c:if test="${Menu.MN_KEYNO eq BOARD_INQUIRE }">
							<tr>
	                         	<th><label for="txtAutoPrevent"><span><i class="fal fa-check"></i></span> 자동입력방지</label></th>
	                             <td colspan="3" class="autoPrevent">
	                             	<p class="autoPreventPara">
	                                 	전남문화산업진흥원은 스팸성 게시물을 방지하기 위해서 보안절차를 거치고 있습니다.<br>
	                                	보이는 순서대로 숫자 및 문자를 모두 입력해 주세요.
	                                 </p>
	                                 <div class="autoDivBox">
	                                 	<label style="display: inline-block; padding-bottom: 3px;">자동입력방지</label>
	                                     <input type="text" id="txtAutoPrevent" class="txtDefault" placeholder="자동등록방지 숫자 입력"  id="stopJoin" >
	                                     <button type="button" class="btn btn_autoUpload mgR15" onclick="audioCaptcha();">
					              			<img src="/resources/img/icon/icon_speak_01.png" alt="자동등록방지">
					              		</button>
	                                     <button type="button" class="btnImgNew" onclick="changeCaptcha();"><i class="fal fa-redo"></i> 이미지 새로고침</button>
	                                 </div>
	                             </td>
	                         </tr>
						</c:if> --%>
                 </tbody>
                 <tfoot></tfoot>
             </table>
             
             <c:if test="${(userInfo.isAdmin ne 'Y' || empty userInfo.isAdmin) && currentMenu.MN_KEYNO eq BOARD_INQUIRE }">
				<div class="g-recaptcha" data-sitekey="6LcaaGIUAAAAAB-WWZ_j9DqI1RKdj6oZ775muxFw" data-callback="onSubmit" data-size="invisible"></div>
             </c:if>
			
			<div class="btnUploadBox">
				<c:if test="${action eq 'insert' }">
				<button type="button" class="btnDefault bg_gray_01 btnSizeM_3" onclick="pf_boardDataInsert()">글쓰기</button>
				</c:if>
				<c:if test="${action eq 'update' }">
				<button type="button" class="btnDefault bg_gray_01 btnSizeM_3" onclick="pf_boardDataUpdate()">수정</button>
				</c:if>
				<button type="button" class="btnDefault btnWhiteLine btnSizeM_3" onclick="pf_back()">취소</button>
			</div>
			</form:form>
				
			<c:if test="${BoardHtml.BIH_DIV_LOCATION eq 'B' }">
			<div id="html_contents">${BoardHtml.BIH_CONTENTS }</div>
			</c:if>
    </div> <!-- 글 작성 끝 -->
</div>
<!-- 본문 끝 -->
			</div>
		</div>
	</div>
</article>

