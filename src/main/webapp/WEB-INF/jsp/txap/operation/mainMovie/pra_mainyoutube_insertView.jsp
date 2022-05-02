<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<style>
label input[type=checkbox].checkbox+span, label input[type=radio].radiobox+span{z-index: 1}
</style>
<div id="content">
	<section id="widget-grid" >
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="" data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-lg fa-desktop"></i> </span>
						<h2>메인 영상 관리 </h2>
					</header> 
					<div class="jarviswidget-editbox"></div>
					
					<div class="widget-body">
						<form:form id="Form" name="Form" method="post" class="form-horizontal bv-form" novalidate="novalidate" enctype="multipart/form-data"><button type="submit" class="bv-hidden-submit" style="display: none; width: 0px; height: 0px;"></button>
							<input type="hidden" name="BM_KEYNO" id="BM_KEYNO" value="${banner.BM_KEYNO }">
							<input type="hidden" name="BM_REGNM" id="BM_REGNM" value="${userInfo.UI_ID }"/>
							<input type="hidden" name="BM_TYPE" id="BM_TYPE" value="M"/>
<%-- 							<input type="hidden" name="BM_FS_KEYNO" id="BM_FS_KEYNO" value="${banner.BM_FS_KEYNO }"/> --%>
							<legend>메인영상 등록</legend>
								<fieldset>
									<div class="bs-example necessT">
								         <span class="colorR fs12">*표시는 필수 입력 항목입니다.</span>
								     </div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label"><span class="nessSpan">*</span> 제목</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="BM_TITLE" name="BM_TITLE" data-bv-field="fullName" value="${banner.BM_TITLE }"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label"><span class="nessSpan">*</span> 홈페이지</label>
										<div class="col-md-6">
											<select class="form-control input-sm" id="BM_MN_KEYNO" name="BM_MN_KEYNO">
								              <option value="">적용 홈페이지 선택</option>
								              <c:forEach items="${homeDivList }" var="model">
								                <option value="${model.MN_KEYNO }" ${banner.BM_MN_KEYNO eq model.MN_KEYNO ? 'selected' : '' }>${model.MN_NAME }</option>
								              </c:forEach>
								            </select>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label"><span class="nessSpan">*</span>유튜브 링크</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="BM_URL" name="BM_URL" data-bv-field="fullName" value="${banner.BM_URL }"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
									<%-- <div class="form-group has-feedback">
										<label class="col-md-1 control-label">생성위치</label>
										<div class="col-md-6">
											<label class="radio radio-inline">
												<input type="radio" class="radiobox style-0" name="BM_TARGET" value="N" ${empty banner.BM_TARGET || banner.BM_TARGET eq 'N' ? 'checked' : ''}>
												<span>새창으로</span> 
											</label>
											<label class="radio radio-inline">
												<input type="radio" class="radiobox style-0" name="BM_TARGET" value="C" ${banner.BM_TARGET eq 'C' ? 'checked' : ''}>
												<span>현재창</span> 
											</label>
										</div>
									</div> --%>
<!-- 									<div class="form-group has-feedback"> -->
<!-- 										<label class="col-md-1 control-label">배너유형</label> -->
<!-- 										<div class="col-md-6"> -->
<!-- 											<label class="radio radio-inline"> -->
<%-- 												<input type="radio" class="radiobox style-0" name="BM_TYPE" value="B" ${empty banner.BM_TYPE || banner.BM_TYPE eq 'B' ? 'checked' : ''}> --%>
<!-- 												<span>기본배너</span>  -->
<!-- 											</label> -->
<!-- 											<label class="radio radio-inline"> -->
<%-- 												<input type="radio" class="radiobox style-0" name="BM_TYPE" value="S" ${banner.BM_TYPE eq 'S' ? 'checked' : ''}> --%>
<!-- 												<span>관련사이트</span>  -->
<!-- 											</label> -->
<!-- 										</div> -->
<!-- 									</div> -->
								</fieldset>
								
							
							
							<%-- <fieldset>
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> 배너 이미지</label>
									<div class="col-md-6 smart-form">
										<div class="input input-file">
											<span class="button"><input type="file" name="file" id="file" accept="image/*" onchange="cf_imgCheckAndPreview('file')">
											파일선택</span>
											<input type="text" name="file_text" id="file_text" placeholder="이미지 파일을 선택하세요" readonly="" value="${banner.FS_ORINM }">
										</div>
<!-- 										<div class="note">이미지 사이즈는 134 X 34 입니다 사이즈가 다를경우 이미지가 깨질 수 있습니다. </div> -->
									</div>
								</div>
							</fieldset> --%>
							
							
							<fieldset class="padding-10 text-right"> 
								<c:if test="${empty banner}">
								<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_BannerInsert()">	
									<i class="fa fa-floppy-o"></i> 저장
								</button>
								</c:if>
								<c:if test="${not empty banner}">
								<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_BannerUpdate()">	
									<i class="fa fa-save"></i> 수정
								</button>
								</c:if>
								<button class="btn btn-sm btn-default" id="Board_Delete" type="button" onclick="location.href='/txap/operation/mainYoutube.do'"> 
									<i class="fa fa-times"></i> 취소
								</button> 
							</fieldset>
							
						</form:form>

					</div>
				</div>
			</article>
		</div>
	</section>
</div>


<script type="text/javascript">
var status = false;
function pf_BannerInsert(){
	
	if(!Banner_check()){return false;}
// 	if(!$("#file").val()){
// 		cf_smallBox('error', '이미지를 선택해주세요.', 3000,'#d24158');
// 		status = false;
// 		return status;
// 	}
	
	if(status){
		$("#Form").attr("action", "/txap/operation/mainYoutube/insert.do?${_csrf.parameterName}=${_csrf.token}");
		$("#Form").submit();
	}
}

function pf_BannerUpdate(){
	
	if(!Banner_check()){return false;}
// 	if(!$("#file_text").val()){
// 		cf_smallBox('error', '이미지를 선택해주세요.', 3000,'#d24158');
// 		status = false;
// 		return status;
// 	}
	
	if(status){
		$("#Form").attr("action", "/txap/operation/mainYoutube/update.do?${_csrf.parameterName}=${_csrf.token}");
		$("#Form").submit();
	}
}

function Banner_check(){
	if(!pf_nullCheck(document.getElementById("BM_TITLE") , "제목"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("BM_MN_KEYNO") , "홈페이지"  , "select")) return;
	if(!pf_nullCheck(document.getElementById("BM_URL") , "링크URL"  , "text")) return;
	if( !( $('#BM_URL').val().startsWith('http://') || $('#BM_URL').val().startsWith('https://') ) ){
		cf_smallBox('error', '링크는 http:// 나 https:// 로 시작되어야됩니다.', 3000,'#d24158');
		$('#BM_URL').focus();
		return false;
	}
	
	status = true;
	return true;
}

//null check
function pf_nullCheck(obj, name, inputType){
	
	var str = "";
	
	if     (inputType == "text")	str = "입력";
	else if(inputType == "select")	str = "선택";
	if($.trim(obj.value) == ""){
		cf_smallBox('Form', name + "을(를) "+ str +"해주세요.", 3000,'#d24158');
		obj.value = "";
		obj.focus();
		
		return false;
	}else{
		return true;
	}
}
</script>