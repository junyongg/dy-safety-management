<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script src="/resources/api/mask/jquery.mask.js"></script>


<script type="text/javascript">
//전역변수선언
var editor_object = [];
var action = '${action}';

$(function(){
	
	TypeSelect('${resultData.MMS_TYPE}');
	
});


function pf_formValidate(id,msg){
	
	if(!$("#"+id).val()){
		cf_smallBox('validate', msg, 3000,'#d24158');
		$("#"+id).focus();
		return false;
	}
	return true;
}

function pf_formCheck(){
	var state = true;
	
	if(!pf_formValidate('MMS_TITLE','제목을 입력하세요.')){
		state = false;
		return state;
	}

	if(!pf_formValidate('MMS_TYPE','작품 분류를 입력하세요.')){
		state = false;
		return state;
	}
    
	return state;
}

function TypeSelect(type){
	if(type == '기타'){
		$(".hideA").hide();
		$(".hideB").show();
	}else{
		$(".hideB").hide();
		$(".hideA").show();
	}
}


function pf_Action(){
	var type = $('#insertForm').find('#action').val();
	
	var msg = "";
	if(type == "insert"){
		msg = "등록하시겠습니까?";
	}else if(type == "update"){
		msg = "수정하시겠습니까?";
	}
	
	if(!pf_formCheck()){
		return false;
	}
	
	if(confirm(msg)){
		cf_loading();
		if(type == "insert"){
			var fCnt = $("#IM_UPLOAD .ajax-file-upload-statusbar").length;
			if(fCnt > 0){
				successNewFile();
			}else{
				pf_checkFile();
			}
		}else if(type == "update"){
			var fCnt = $("#IM_UPLOAD .cancle_hidden").length
			if( typeof fn_fileSubDelete == 'function' && !fn_fileSubDelete() ){ // 첨부파일 삭제 있으면 삭제처리
				return false;
			} 
			if(fCnt > 0){
				successFileUp();
			}else{
				$('#FM_KEYNO').val($('#fmKeyno').val());
				pf_checkFile();
			}
		}
	}
	else{
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
	$('#MMS_FM_KEYNO').val($('#FM_KEYNO').val());
// 	cf_replaceTrim($("#insertForm"));
	if(action == 'insert' || action == 'update'){
		$("#insertForm").attr("action", "/txap/map/mapSubAction.do?${_csrf.parameterName}=${_csrf.token}");
	}else{
		cf_smallBox('error', '오류발생 : action값 없음', 3000,'gray');
		return false;
	}
	$("#pageIndex2").val($("#pageIndex").val());
	$("#insertForm").submit();
}
function exit(){
	cf_smallBox('cancel', '취소되었습니다', 3000,'gray');
	return false;
}

function pf_back(){
	$("#insertForm").attr("action", "/txap/map.do?${_csrf.parameterName}=${_csrf.token}");
	$("#insertForm").submit();
}
</script>

<input type="hidden" name="action" id="action" value="${action}"/>
<input type="hidden" name="MMA_KEYNO" id="MMA_KEYNO" value="${resultData.MMA_KEYNO}"/>
<input type="hidden" name="MMS_KEYNO" id="MMS_KEYNO" value="${resultData.MMS_KEYNO}"/>
<input type="hidden" name="MMS_FM_KEYNO" id="MMS_FM_KEYNO" value="${resultData.MMS_FM_KEYNO}"/>
<input type="hidden" name="pageIndex" id="pageIndex2" value=""/>
<input type="hidden" name="MMS_DELYN" id="MMS_DELYN" value="N"/>


<div class="widget-body-toolbar bg-color-white">
	<div class="alert alert-info no-margin fade in">
		<button type="button" class="close" data-dismiss="alert">×</button>
		전자지도 상세정보를 등록/수정합니다.<br>
		<font color="red"></font>
	</div> 
</div>
<fieldset>
	<legend> 
		<div class="col-sm-9 text-align-left">
		</div>	
		<div class="col-sm-6 col-md-3 text-align-right">
			<div class="btn-group">  
				<button class="btn btn-sm btn-primary" type="button" onclick="pf_Action()">
					<i class="fa fa-save"></i> 저장
				</button> 
			</div>
			<c:if test="${action eq 'update'}">
				<button class="btn btn-sm btn-danger" type="button" onclick="pf_delete()">
					<i class="glyphicon glyphicon-ok"></i> 삭제
				</button>
			</c:if>
		</div>
	</legend>
	
	<legend>서브_기본정보</legend>
	
	
	<div class="form-group except-update categoryDiv"> 
 		<label class="col-md-2 control-label"><span class="nessSpan">*</span>프로젝트 명</label> 
 		<div class="col-md-10"> 
 			<div class="input-group">
				<select id="MMS_MMA_KEYNO" name="MMS_MMA_KEYNO">
					<c:forEach items="${MainList }" var="ml">
						<option value="${ml.MMA_KEYNO }">${ml.MMA_TITLE }</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-md-2 control-label"><span class="nessSpan">*</span>제목</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요." 
						name="MMS_TITLE" id="MMS_TITLE" maxlength="50" onkeyup="pf_checkLength('MMS_TITLE',50)"
						value="${resultData.MMS_TITLE }">
				<span class="input-group-addon length" id="MMS_TITLE_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-md-2 control-label"><span class="nessSpan">*</span>분류</label>
		<div class="col-md-10">
			<div class="input-group">
				<select name="MMS_TYPE" id="MMS_TYPE" onchange="TypeSelect(this.value);">
					<option value="">선택하세요</option>
					<option value="벽화" ${resultData.MMS_TYPE eq '벽화'?'selected':'' }>벽화</option>
					<option value="설치" ${resultData.MMS_TYPE eq '설치'?'selected':'' }>설치</option>
					<option value="기타" ${resultData.MMS_TYPE eq '기타'?'selected':'' }>기타</option>
				</select>
			</div>
		</div>
	</div>
	
	
	<div class="form-group">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>유튜브 링크</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요." 
				name="MMS_YOUTUBE" id="MMS_YOUTUBE"  maxlength="50" onkeyup="pf_checkLength('MMA_LINK',50)" 
				value="${resultData.MMS_YOUTUBE }">
				<span class="input-group-addon length" id="MMA_LINK_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	
	
	<div class="form-group except-update categoryDiv hideA">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>규격</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMS_SIZE',50)"  name="MMS_SIZE" id="MMS_SIZE" value="${resultData.MMS_SIZE }">
				<span class="input-group-addon length" id="MMS_SIZE_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	<div class="form-group except-update categoryDiv hideA">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>소재</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요." maxlength="50" onkeyup="pf_checkLength('MMS_MATERIAL',50)"  name="MMS_MATERIAL" id="MMS_MATERIAL" value="${resultData.MMS_MATERIAL }">
				<span class="input-group-addon length" id="MMS_MATERIAL_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	<div class="form-group except-update categoryDiv">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>상세주소</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMS_ADDRESS',50)" name="MMS_ADDRESS" id="MMS_ADDRESS" value="${resultData.MMS_ADDRESS }">
				<span class="input-group-addon length" id="MMS_ADDRESS_length">(0/50자)</span>
			</div>
		</div>
	</div>
			
	<div class="form-group except-update categoryDiv hideA">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>설치일</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMS_INSTALL',50)"  name="MMS_INSTALL" id="MMS_INSTALL" value="${resultData.MMS_INSTALL }">
				<span class="input-group-addon length" id="MMA_STDT_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	<div class="form-group except-update categoryDiv hideB">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>기간</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMS_TIME',50)"  name="MMS_TIME" id="MMS_TIME" value="${resultData.MMS_TIME }">
				<span class="input-group-addon length" id="MMS_TIME_length">(0/50자)</span>
			</div>
		</div>
	</div>

	<div class="form-group except-update categoryDiv hideB">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>참여작가</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMS_AUTHOR',50)"  name="MMS_AUTHOR" id="MMS_AUTHOR" value="${resultData.MMS_AUTHOR }">
				<span class="input-group-addon length" id="MMS_AUTHOR_length">(0/10자)</span>
			</div>
		</div>
	</div>
	
	
	<div class="form-group except-update categoryDiv">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>홈페이지</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMS_URL',50)"  name="MMS_URL" id="MMS_URL" value="${resultData.MMS_URL }">
				<span class="input-group-addon length" id="MMS_URL_length">(0/50자)</span>
			</div>
		</div>
	</div>

<!-- 	<div class="form-group except-update categoryDiv"> -->
<!-- 		<label class="col-md-2 control-label"><span class="nessSpan">*</span>마커</label> -->
<!-- 		<div class="col-md-10"> -->
<!-- 			<div class="input-group"> -->
<!-- 				<select id="MMA_MARKER" name="MMA_MARKER"> -->
<%-- 					<option value="/resources/map/img/icon/icon_btn_red.png" ${resultData.MMA_MARKER eq '/resources/map/img/icon/icon_btn_red.png'?'selected':'' }>빨강</option> --%>
<%-- 					<option value="/resources/map/img/icon/icon_btn_yellow.png" ${resultData.MMA_MARKER eq '/resources/map/img/icon/icon_btn_yellow.png'?'selected':'' }>노랑</option> --%>
<%-- 					<option value="/resources/map/img/icon/icon_btn_blue.png" ${resultData.MMA_MARKER eq '/resources/map/img/icon/icon_btn_blue.png'?'selected':'' }>파랑</option> --%>
<!-- 				</select> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
	<div class="form-group">
		<label class="col-md-2 control-label">설명</label>
		<div class="col-md-10">
		<div class="">
			<textarea class="form-control" placeholder="입력하여주세요." rows="4" name="MMS_CONTENT" id="MMS_CONTENT" maxlength="500" onkeyup="pf_checkLength('MMS_CONTENT',500)">${resultData.MMS_CONTENT }</textarea>
		</div>
		<p class="help-block length" id="MMS_CONTENT_length">(0/500자)</p>
		</div>
	</div>
	
	<div class="form-group">
		<div class="form-group has-feedback">
			<label class="col-md-2 control-label">첨부파일</label>
			<div class="col-md-7">
				<%@ include file="/WEB-INF/jsp/txap/operation/file/pra_file_insertView_mapSub.jsp"%>
				<c:if test="${action eq 'update'}">
					<input type="hidden" name="fsSize" id="fsSize" value="${fn:length(FileSub) }">
					<input type="hidden" name="fmKeyno" id="fmKeyno" value="${resultData.MMS_FM_KEYNO }">
				</c:if>
			</div>
		</div>
	</div>
	
</fieldset>

