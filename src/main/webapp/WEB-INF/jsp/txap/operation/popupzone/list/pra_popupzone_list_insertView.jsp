<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<%@ include file="/WEB-INF/jsp/common/CodeMirror_Include.jsp" %>

<style>
.columnTitle {
	text-align: center;
	word-break: keep-all;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ccc;
	padding: 5px 0
}

.columnTitle section {
	margin-bottom: 0
}

.option_dp, .selectCodeWrap, .column_size_dp {
	display: none;
}

.column_ul .column_li label{
	width: 20%;
}

.column_ul .column_li input{
	padding-left:10px;
	width: 50%;
}

.column_ul .column_li a{
	margin-left: 20px;
}

label input[type=checkbox].checkbox+span, label input[type=radio].radiobox+span{z-index: 1}

</style>

<script type="text/javascript">

var editor = null;
var img_yn = "";
var width = 150;
var height = 37;

$(function() {
	
	if('update' === '${type}') {
		if($('#TCGM_IMG_YN').val() == 'Y') {
			$('.imgResizeYN').show();
			
			if($('#TCGM_IMG_RESIZE_YN').val() == 'Y') {
				$('.imgResizeValue').show();
			}
		}
	}
	
	if("${type}" == "insert"){
		$('.input-img-info').hide();
	}else {
		if("${TLM_DATA.TCGM_IMG_YN}" == "Y") {
			if("${TLM_DATA.TCGM_IMG_RESIZE_YN}" == "Y") {
				width = "${TLM_DATA.TCGM_IMG_WIDTH}";
				height = "${TLM_DATA.TCGM_IMG_HEIGHT}";
				$('#span_width').text(width);					
				$('#span_height').text(height);	
				$('#WIDTH').val(width);
				$('#HEIGHT').val(height);
			} else {
				$('#span_width').text(width);					
				$('#span_height').text(height);		
				$('#WIDTH').val(width);
				$('#HEIGHT').val(height);
			}
			$('.input-img-info').show();
		} else {
			$('.input-img-info').hide();
		}
	}
	
});

function pf_listInsert(){
		
	if(!pf_checkForm()) { return false; }
	
	if(img_yn == "Y") {
		if(!$("#file").val()){
// 			cf_smallBox('error', '이미지를 선택해주세요.', 3000,'#d24158');
			alert("이미지를 선택해주세요.");
			status = false;
			return status;
		}
	}
	
	if(status){
// 		$("#Form").attr("action", "/txap/operation/banner/insert.do?${_csrf.parameterName}=${_csrf.token}");
// 		$("#Form").submit();
		if(confirm("리스트를 생성하시겠습니까?")){
			cf_replaceTrim($("#Form"));
			$("#Form").attr("action", "/txap/operation/popupzone/list/insert.do?${_csrf.parameterName}=${_csrf.token}");
			$("#Form").submit();
		}
	}
}
function pf_checkForm(){
	if(!pf_nullCheck(document.getElementById("TLM_TCGM_KEYNO") , "카테고리"  , "select")) return;
	if(!pf_nullCheck(document.getElementById("TLM_COMMENT") , "코멘트"  , "text")) return;
	// 공백제외하고 링크가 입력되있으면 http || https로 시작하는지 확인
	if($('#TLM_URL').val().trim() != "") {
		if( !( $('#TLM_URL').val().startsWith('http://') || $('#TLM_URL').val().startsWith('https://') ) ){
// 			cf_smallBox('error', '링크는 http:// 나 https:// 로 시작되어야됩니다.', 3000,'#d24158');
			alert("링크는 http:// 나 https:// 로 시작되어야됩니다.");
			$('#TLM_URL').focus();
			return false;
		}
	}
	
	status = true;
	return true;
}

function pf_nullCheck(obj, name, inputType){
	
	var str = "";
	
	if(inputType == "text")	
		str = "입력";
	else if(inputType == "select")	
		str = "선택";
	
	if($.trim(obj.value) == ""){
// 		cf_smallBox('Form', name + "을(를) "+ str +"해주세요.", 3000,'#d24158');
		alert(name + "을(를) "+ str +"해주세요.");
		obj.value = "";
		obj.focus();
		
		return false;
	}else{
		return true;
	}
}

function pf_getCategoryInfo() {
	
	$.ajax({
	    type   : "post",
	    url    : "/txap/operation/popupzone/list/categoryInfoAjax.do",
	    data   : {"TCGM_KEYNO" : $("#TLM_TCGM_KEYNO").val()},
	    async  : false ,
	    success:function(data){
// 	    	alert(data.TCGM_TITLE);
			if(data.TCGM_IMG_YN == 'Y') {
				img_yn = "Y"
				if(data.TCGM_IMG_RESIZE_YN == 'Y') {
					width = data.TCGM_IMG_WIDTH;
					height = data.TCGM_IMG_HEIGHT;
					$('#span_width').text(width);					
					$('#span_height').text(height);
					$('#WIDTH').val(width);
					$('#HEIGHT').val(height);
				} else {
					$('#span_width').text(width);					
					$('#span_height').text(height);
					$('#WIDTH').val(width);
					$('#HEIGHT').val(height);
				}
				$('.input-img-info').show();
			} else {
				img_yn = "N"
				$('.input-img-info').hide();
			}
	    },
	    error: function(jqXHR, textStatus, exception) {
	    	alert('error: '+textStatus+": "+exception);
	    }
	});
	
}

function pf_listUpdate(){
	
	if(!pf_checkForm()) { return false; }
	
	if(img_yn == "Y") {
		if(!$("#file").val()){
// 			cf_smallBox('error', '이미지를 선택해주세요.', 3000,'#d24158');
			alert("이미지를 선택해주세요.");
			status = false;
			return status;
		}
	}
	
	if(status){
// 		$("#Form").attr("action", "/txap/operation/banner/insert.do?${_csrf.parameterName}=${_csrf.token}");
// 		$("#Form").submit();
		if(confirm("리스트를  수정하시겠습니까?")){
			cf_replaceTrim($("#Form"));
			$("#Form").attr("action", "/txap/operation/popupzone/list/update.do?${_csrf.parameterName}=${_csrf.token}");
			$("#Form").submit();
		}
	}
	
}

function pf_listDelete(){
	if(confirm("리스트를 삭제하시겠습니까?")){
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/operation/popupzone/list/delete.do");
		$("#Form").submit();
	}
}


function pf_back(){
	history.go(-1);
}

</script>

<div id="content">

	<section id="widget-grid">
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="" data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-table"></i>
						</span>
						<c:if test="${type eq 'insert' }">
						<h2>리스트 등록</h2>
						</c:if>
						<c:if test="${type eq 'update' }">
						<h2>리스트 수정</h2>
						</c:if>
					</header>

					<div class="widget-body">

						<form:form id="Form" class="form-horizontal" name="Form" method="post" enctype="multipart/form-data">
							<input type="hidden" name="TLM_REGNM" value="${userInfo.UI_ID }" />
							<input type="hidden" name="TLM_KEYNO" value="${TLM_DATA.TLM_KEYNO }" />
							<input type="hidden" name="TLM_FS_KEYNO" value="${TLM_DATA.TLM_FS_KEYNO }" />
							<input type="hidden" name="WIDTH" id="WIDTH" value="" />
							<input type="hidden" name="HEIGHT" id="HEIGHT" value="" />
							
							<legend>
								<c:if test="${type eq 'insert' }">
								<h2>리스트 등록하기 </h2>
								</c:if>
								<c:if test="${type eq 'update' }">
								<h2>리스트 수정하기 </h2>
								</c:if>
							</legend>
							
							<fieldset>
								<div class="bs-example necessT">
									<span class="colorR fs12">*표시는 필수 입력 항목입니다.</span>
								</div>
								
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> 카테고리</label>
									<div class="col-md-6">
										<select class="form-control input-sm" id="TLM_TCGM_KEYNO" name="TLM_TCGM_KEYNO" onchange="pf_getCategoryInfo();">
							              <option value="">카테고리 선택</option>
							              <c:forEach items="${categoryList }" var="model">
							                <option value="${model.TCGM_KEYNO }" ${TLM_DATA.TLM_TCGM_KEYNO eq model.TCGM_KEYNO ? 'selected' : '' } >${model.FORM_NAME }</option>
							              </c:forEach>	
							            </select>
									</div>
								</div>
								
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> 코멘트</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="TLM_COMMENT" name="TLM_COMMENT" value="${TLM_DATA.TLM_COMMENT }">
									</div>
								</div>
								
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"> 링크</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="TLM_URL" name="TLM_URL" value="${TLM_DATA.TLM_URL }">
									</div>
								</div>
								
								<fieldset class="input-img-info">
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label"><span class="nessSpan">*</span> 리스트 이미지</label>
										<div class="col-md-6 smart-form">
											<div class="input input-file">
												<span class="button"><input type="file" name="file" id="file" accept="image/*" onchange="cf_imgCheckAndPreview('file')">
												파일선택</span>
												<input type="text" name="file_text" id="file_text" placeholder="이미지 파일을 선택하세요" readonly="" value="${TLM_DATA.FS_ORINM }">
											</div>
											<div class="note">이미지 사이즈는 <span id="span_width">${TLM_DATA.TCGM_IMG_WIDTH }</span> X <span id="span_height">${TLM_DATA.TCGM_IMG_HEIGHT }</span> 입니다 사이즈가 다를경우 이미지가 깨질 수 있습니다. </div>
										</div>
									</div>
									
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label"> 부연설명(ALT)</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="TLM_ALT" name="TLM_ALT" value="${TLM_DATA.TLM_ALT }">
										</div>
									</div>
								</fieldset>
								
								<div class="form-actions">
									<div class="row">
										<div class="col-md-12">
											<c:if test="${type eq 'insert' }">
												<button class="btn btn-sm btn-primary" type="button" onclick="pf_listInsert()">저장</button>
											</c:if>
											<c:if test="${type eq 'update' }">
												<button class="btn btn-sm btn-primary" type="button" onclick="pf_listUpdate()">수정</button>
												<button class="btn btn-sm btn-danger" type="button" onclick="pf_listDelete()">삭제</button>
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

