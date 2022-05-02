<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script src="/resources/api/mask/jquery.mask.js"></script>


<script type="text/javascript">
//전역변수선언
var editor_object = [];
var action = '${action}';

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
	
	if(!pf_formValidate('MMA_TITLE','제목을 입력하세요.')){
		state = false;
		return state;
	}
    
	return state;
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
	$('#MMA_FM_KEYNO').val($('#FM_KEYNO').val());
// 	cf_replaceTrim($("#insertForm"));
	if(action == 'insert' || action == 'update'){
		$("#insertForm").attr("action", "/txap/map/mapAction.do?${_csrf.parameterName}=${_csrf.token}");
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
<input type="hidden" name="MMA_FM_KEYNO" id="MMA_FM_KEYNO" value="${resultData.MMA_FM_KEYNO}"/>
<input type="hidden" name="pageIndex" id="pageIndex2" value=""/>
<input type="hidden" name="MMA_DELYN" id="MMA_DELYN" value="N"/>


<div class="widget-body-toolbar bg-color-white">
	<div class="alert alert-info no-margin fade in">
		<button type="button" class="close" data-dismiss="alert">×</button>
		지도에 저장된 정보를 등록/수정합니다.<br>
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
				<!-- <button class="btn btn-sm btn-default" type="button" onclick="SubMove();">
					서브 등록
				</button> -->
				<button class="btn btn-sm btn-danger" type="button" onclick="pf_delete()">
					<i class="glyphicon glyphicon-ok"></i> 삭제
				</button>
			</c:if>
		</div>
	</legend>
	
	<legend>메인_기본정보</legend>
	
	<div class="form-group">
		<label class="col-md-2 control-label"><span class="nessSpan">*</span>프로젝트 명</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요." 
						name="MMA_TITLE" id="MMA_TITLE" maxlength="50" onkeyup="pf_checkLength('MMA_TITLE',50)"
						value="${resultData.MMA_TITLE }">
				<span class="input-group-addon length" id="MMA_TITLE_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-md-2 control-label"><span class="nessSpan">*</span>유튜브 링크</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요." 
				name="MMA_LINK" id="MMA_LINK"  maxlength="50" onkeyup="pf_checkLength('MMA_LINK',50)" 
				value="${resultData.MMA_LINK }">
				<span class="input-group-addon length" id="MMA_LINK_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	<div class="form-group except-update categoryDiv">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>규격</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMA_SIZE',50)"  name="MMA_SIZE" id="MMA_SIZE" value="${resultData.MMA_SIZE }">
				<span class="input-group-addon length" id="MMA_SIZE_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	<div class="form-group except-update categoryDiv">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>소재</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요." maxlength="50" onkeyup="pf_checkLength('MMA_TYPE',50)"  name="MMA_TYPE" id="MMA_TYPE" value="${resultData.MMA_TYPE }">
				<span class="input-group-addon length" id="MMA_TYPE_length">(0/50자)</span>
			</div>
		</div>
	</div>
	
	<div class="form-group except-update categoryDiv">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>상세주소</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMA_ADDRESS',50)" name="MMA_ADDRESS" id="MMA_ADDRESS" value="${resultData.MMA_ADDRESS }">
				<span class="input-group-addon length" id="MMA_ADDRESS_length">(0/50자)</span>
			</div>
		</div>
	</div>
			
	<div class="form-group except-update categoryDiv">
		<label class="col-md-2 control-label"><span class="nessSpan"></span>홈페이지</label>
		<div class="col-md-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="입력하세요."  maxlength="50" onkeyup="pf_checkLength('MMA_URL',50)"  name="MMA_URL" id="MMA_URL" value="${resultData.MMA_URL }">
				<span class="input-group-addon length" id="MMA_URL_length">(0/50자)</span>
			</div>
		</div>
	</div>

	<div class="form-group except-update categoryDiv">
		<label class="col-md-2 control-label"><span class="nessSpan">*</span>지역</label>
		<div class="col-md-10">
			<div class="input-group">
				<select id="area" name="MMA_AREA" onchange="">
					<option value="all" ${resultData.MMA_AREA eq 'all' ||empty area ?'selected':'' } >전체</option>
					<option value="영광" ${resultData.MMA_AREA eq '영광'?'selected':'' }>영광</option>
					<option value="장성" ${resultData.MMA_AREA eq '장성'?'selected':'' }>장성</option>
					<option value="담양" ${resultData.MMA_AREA eq '담양'?'selected':'' }>담양</option>
					<option value="곡성" ${resultData.MMA_AREA eq '곡성'?'selected':'' }>곡성</option>
					<option value="구례" ${resultData.MMA_AREA eq '구례'?'selected':'' }>구례</option>
					<option value="광양" ${resultData.MMA_AREA eq '광양'?'selected':'' }>광양</option>
					<option value="여수" ${resultData.MMA_AREA eq '여수'?'selected':'' }>여수</option>
					<option value="순천" ${resultData.MMA_AREA eq '순천'?'selected':'' }>순천</option>
					<option value="고흥" ${resultData.MMA_AREA eq '고흥'?'selected':'' }>고흥</option>
					<option value="보성" ${resultData.MMA_AREA eq '보성'?'selected':'' }>보성</option>
					<option value="화순" ${resultData.MMA_AREA eq '화순'?'selected':'' }>화순</option>
					<option value="나주" ${resultData.MMA_AREA eq '나주'?'selected':'' }>나주</option>
					<option value="장흥" ${resultData.MMA_AREA eq '장흥'?'selected':'' }>장흥</option>
					<option value="영암" ${resultData.MMA_AREA eq '영암'?'selected':'' }>영암</option>
					<option value="강진" ${resultData.MMA_AREA eq '강진'?'selected':'' }>강진</option>
					<option value="해남" ${resultData.MMA_AREA eq '해남'?'selected':'' }>해남</option>
					<option value="진도" ${resultData.MMA_AREA eq '진도'?'selected':'' }>진도</option>
					<option value="완도" ${resultData.MMA_AREA eq '완도'?'selected':'' }>완도</option>
					<option value="신안" ${resultData.MMA_AREA eq '신안'?'selected':'' }>신안</option>
					<option value="목포" ${resultData.MMA_AREA eq '목포'?'selected':'' }>목포</option>
					<option value="무안" ${resultData.MMA_AREA eq '무안'?'selected':'' }>무안</option>
					<option value="함평" ${resultData.MMA_AREA eq '함평'?'selected':'' }>함평</option>
				</select>
			</div>
		</div>
	</div>
	<%-- <div class="form-group except-update categoryDiv">
		<label class="col-md-2 control-label"><span class="nessSpan">*</span>마커</label>
		<div class="col-md-10">
			<div class="input-group">
				<select id="MMA_MARKER" name="MMA_MARKER">
					<option value="/resources/map/img/icon/icon_btn_red.png" ${resultData.MMA_MARKER eq '/resources/map/img/icon/icon_btn_red.png'?'selected':'' }>빨강</option>
					<option value="/resources/map/img/icon/icon_btn_yellow.png" ${resultData.MMA_MARKER eq '/resources/map/img/icon/icon_btn_yellow.png'?'selected':'' }>노랑</option>
					<option value="/resources/map/img/icon/icon_btn_blue.png" ${resultData.MMA_MARKER eq '/resources/map/img/icon/icon_btn_blue.png'?'selected':'' }>파랑</option>
				</select>
			</div>
		</div>
	</div> --%>
	
	<div class="form-group">
		<label class="col-md-2 control-label">내용</label>
		<div class="col-md-10">
		<div class="">
			<textarea class="form-control" placeholder="입력하여주세요." rows="4" name="MMA_TEXT" id="MMA_TEXT" maxlength="500" onkeyup="pf_checkLength('MMA_TEXT',500)">${resultData.MMA_TEXT }</textarea>
		</div>
		<p class="help-block length" id="MMA_TEXT_length">(0/500자)</p>
		</div>
	</div>
	
	<div class="form-group">
		<div class="form-group has-feedback">
			<label class="col-md-2 control-label">첨부파일</label>
			<div class="col-md-7">
				<%@ include file="/WEB-INF/jsp/txap/operation/file/pra_file_insertView_map.jsp"%>
				<c:if test="${action eq 'update'}">
					<input type="hidden" name="fsSize" id="fsSize" value="${fn:length(FileSub) }">
					<input type="hidden" name="fmKeyno" id="fmKeyno" value="${resultData.MMA_FM_KEYNO }">
				</c:if>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-md-2 control-label">주소</label>
		<div class="col-md-10">
			<div class="row">
				<div class="col-sm-12">
					<div class="input-group">
						<div class="input-group" style="width: 100%;">
							<div class="row">
								<div class="col-sm-12">
									<div class="input-group">
										<input type="text" class="form-control addrInput" placeholder="우편번호" name="MMA_POST" id="MMA_POST" value="${resultData.MMA_POST }">
										<div class="input-group-btn">
											<button class="btn btn-primary" type="button" onclick="pf_execDaumPostcode('MMA_POST','MMA_ADDR1')">
												<i class="fa fa-search"></i>
												검색
											</button>
										</div>
									</div>
								</div>
								<div class="col-sm-12">
									<div class="input-group">
										<input type="text" class="form-control addrInput" placeholder="주소" name="MMA_ADDR1" id="MMA_ADDR1" value="${resultData.MMA_ADDR1 }">
										<div class="input-group-btn">
											<button class="btn btn-default" type="button" onclick="pf_deleteAddr()">
												<i class="fa fa-eraser"></i>
												삭제
											</button>
										</div>
									</div>
								</div>
								<div class="col-sm-12">
									<div class="input-group">
										<input type="text" class="form-control addrInput" placeholder="상세주소" 
												name="MMA_ADDR2" id="MMA_ADDR2" maxlength="100" onkeyup="pf_checkLength('MMA_ADDR2',100)"
												value="${resultData.MMA_ADDR2 }">
										<span class="input-group-addon length" id="TC_ADDR2_length">(0/100자)</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-md-2 control-label"><span class="nessSpan">*</span> 위치</label>
		<div class="col-md-10">
			<div class="row">
				<div class="col-sm-12">
					<div class="input-group" style="width: 100%;">
						<div class="row">
							<div class="col-sm-6 inputWidth50">
								<div class="input-group">
									<input type="text" class="form-control" placeholder="위도" name="MMA_X_LOCATION" id="MMA_X_LOCATION" maxlength="30" readonly value="${resultData.MMA_X_LOCATION }">
									<span class="input-group-addon">위도</span>
								</div>
							</div>
							<div class="col-sm-6 inputWidth50">
								<div class="input-group">
									<input type="text" class="form-control" placeholder="경도" name="MMA_Y_LOCATION" id="MMA_Y_LOCATION" maxlength="30" readonly value="${resultData.MMA_Y_LOCATION }">
									<span class="input-group-addon">경도</span>
								</div>
							</div>
						</div>
					</div>
					<div class="map">
						<div id="moveMapBtnBox">
							<button id="moveMapBtn" class="btn btn-primary" type="button" onclick="pf_moveMap('MMA_ADDR1','MMA_ADDR2','MMA_X_LOCATION','MMA_Y_LOCATION');">주소 위치로 이동</button>
						</div>
						<div id="MMA_LOCATION" style="width:100%;height:100%;"></div>
					</div>
					<p class="help-block">
						* 지도에서 클릭시 해당 위치의 위도/경도 값이 저장됩니다.
					</p>
				</div>
			</div>
		</div>
	</div>
	
</fieldset>

<%@ include file="/WEB-INF/jsp/txap/map/pra_map_script.jsp"%>

<script type="text/javascript">

$(function(){
	pf_setMap('${resultData.MMA_X_LOCATION}','${resultData.MMA_Y_LOCATION}','MMA_LOCATION','MMA_X_LOCATION','MMA_X_LOCATION');
});

</script>

