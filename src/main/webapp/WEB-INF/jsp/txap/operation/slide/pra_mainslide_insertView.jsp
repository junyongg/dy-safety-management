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
						<h2>메인슬라이드 관리 </h2>
					</header> 
					<div class="jarviswidget-editbox"></div>
					
					<div class="widget-body">
						<form:form id="Form" name="Form" method="post" class="form-horizontal bv-form" novalidate="novalidate" enctype="multipart/form-data"><button type="submit" class="bv-hidden-submit" style="display: none; width: 0px; height: 0px;"></button>
							<input type="hidden" name="MM_REGNM" id="MM_REGNM" value="${userInfo.UI_ID }"/>
							<input type="hidden" name="MM_KEYNO" id="MM_KEYNO" value="${slide.MM_KEYNO }"/>
							<input type="hidden" name="MM_FS_KEYNO" id="MM_FS_KEYNO" value="${slide.MM_FS_KEYNO }"/>
							<input type="hidden" name="resize" id="resize" value="N"/>
							<legend>메인 슬라이드 등록</legend>
								<fieldset>
									<div class="bs-example necessT">
								         <span class="colorR fs12">*표시는 필수 입력 항목입니다.</span>
								     </div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label"><span class="nessSpan">*</span> 제목</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="MM_TITLE" name="MM_TITLE" data-bv-field="fullName" value="${slide.MM_TITLE }"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label"><span class="nessSpan">*</span> 홈페이지</label>
										<div class="col-md-6">
											<select class="form-control input-sm" id="MM_MN_KEYNO" name="MM_MN_KEYNO">
								              <option value="">적용 홈페이지 선택</option>
								              <c:forEach items="${homeDivList }" var="model">
								                <option value="${model.MN_KEYNO }" ${slide.MM_MN_KEYNO eq model.MN_KEYNO ? 'selected' : '' }>${model.MN_NAME }</option>
								              </c:forEach>
								            </select>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">슬라이드 위치</label>
										<div class="col-md-6">
											<div class="smart-form">
												<div class="inline-group">
													<label class="radio">
														<input type="radio" name="MM_LOCATION" value="H" ${slide.MM_LOCATION eq 'H' ? 'checked':'' }>
														<i style="margin-top: 7px;"></i>상단</label>
													<label class="radio">
														<input type="radio" name="MM_LOCATION" value="M" ${slide.MM_LOCATION eq 'M' ? 'checked':'' }>
														<i style="margin-top: 7px;"></i>중단</label>
													<label class="radio">
														<input type="radio" name="MM_LOCATION" value="L" ${slide.MM_LOCATION eq 'L' ? 'checked':'' }>
														<i style="margin-top: 7px;"></i>하단</label>
													<label class="radio">
														<input type="radio" name="MM_LOCATION" value="N" ${(empty slide || slide.MM_LOCATION eq 'N') ? 'checked':'' }>
														<i style="margin-top: 7px;"></i>지정안함</label>
												</div>
											</div>
										</div>
									</div>
									
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">코멘트</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="MM_COMMENT" name="MM_COMMENT" data-bv-field="fullName" value="${slide.MM_COMMENT }"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">링크 URL</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="MM_URL" name="MM_URL" data-bv-field="fullName" value="${slide.MM_URL }"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
								</fieldset>
								
							
							
							<fieldset>
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> 슬라이드 이미지</label>
									<div class="col-md-6 smart-form">
										<div class="input input-file">
											<span class="button"><input type="file" id="file" name="file" accept="image/*" onchange="cf_imgCheckAndPreview('file')">
											파일선택</span>
											<input type="text" name="file_text" id="file_text" placeholder="이미지 파일을 선택하세요" value="${slide.FS_ORINM }" readonly>
										</div>
										<div class="note">이미지 사이즈는 1920 X 500 입니다 사이즈가 다를경우 이미지가 깨질수있습니다. </div>
									</div>
									 <section class="col-md-2 smart-form">
							         	<label class="checkbox" style="padding-top:0">
										<input type="checkbox" name="file_resize" value="Y" checked="checked">
										<i></i>자동 리사이즈 여부</label>
							         </section>
								</div>
							</fieldset>
							
							
							<fieldset class="padding-10 text-right"> 
								<c:if test="${empty slide}">
								<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_SlideInsert()">	
									<i class="fa fa-floppy-o"></i> 저장
								</button>
								</c:if>
								<c:if test="${not empty slide}">
								<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_SlideUpdate()">	
									<i class="fa fa-save"></i> 수정
								</button>
								</c:if>
								<button class="btn btn-sm btn-default" id="Board_Delete" type="button" onclick="location.href='/txap/operation/slide.do'"> 
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
function pf_SlideInsert(){
	
	if(!Slide_check()){return false;}
	if(!$("#file").val()){
		cf_smallBox('error', '이미지를 선택해주세요.', 3000,'#d24158');
		status = false;
		return status;
	}
	
	if(status){
		$("#Form").attr("action", "/txap/mainPage/slide/insert.do?${_csrf.parameterName}=${_csrf.token}");
		$("#Form").submit();
	}
	
}

function pf_SlideUpdate(){
	
	if(!Slide_check()){return false;}
	if(!$("#file_text").val()){
		cf_smallBox('error', '이미지를 선택해주세요.', 3000,'#d24158');
		status = false;
		return status;
	}
	
	if(status){
		$("#Form").attr("action", "/txap/mainPage/slide/update.do?${_csrf.parameterName}=${_csrf.token}");
		$("#Form").submit();
	}
	
}

function Slide_check(){
	if(!pf_nullCheck(document.getElementById("MM_TITLE") , "제목"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("MM_MN_KEYNO") , "홈페이지"  , "select")) return;
	
	if($('#MM_URL').val() != null && $('#MM_URL').val() != ''){
		if( !( $('#MM_URL').val().startsWith('http://') || $('#MM_URL').val().startsWith('https://') ) ){
			cf_smallBox('error', '링크는 http:// 나 https:// 로 시작되어야됩니다.', 3000,'#d24158');
			$('#MM_URL').focus();
			return false;
		}
	}
	
	var checkYN = $("input[name=file_resize]").prop("checked");
	if(checkYN){$("#resize").val("Y");}
	
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