<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script type="text/javascript">
function chk_file_imgtype(obj){
	var file_kind = obj.value.lastIndexOf('.');
	var file_name = obj.value.substring(file_kind+1,obj.length);
	var file_type = file_name.toLowerCase();
	
	var check_file_type = ['jpg','gif','png','jpeg','bmp'];
	
	if(check_file_type.indexOf(file_type)==-1){
	 	alert('이미지 파일만 선택할 수 있습니다.');
	 	var parent_Obj = obj.parentNode
	 	var node = parent_Obj.replaceChild(obj.cloneNode(true),obj);
	 	$("input[name=MM_THUMBTEXT]").val("");
	 	return false;
	}else{
		$("input[name=MM_THUMBTEXT]").val(obj.value);
	}
}

function pf_boardDataUpdate(){
	if(!$("#MM_TITLE").val()){
		alert("제목을 입력해주세요");
		return false;
	}
	if(!$("#MM_THUMBTEXT").val()){
		alert("이미지를 선택해주세요");
		return false;
	}
	var checkYN = $("input[name=file_resize]").prop("checked");
	if(checkYN){
		$("#resize").val("Y");
	}else{
		$("#resize").val("N");		
	}
	success();
}
function pf_boardDataDelete(){
	if(confirm("슬라이드를 삭제하시겠습니까?")){
		$("#Form").attr("action", "/txap/mainPage/slide/delete.do?${_csrf.parameterName}=${_csrf.token}");
		$("#Form").submit();
	}
}
function success(){
	$("#Form").attr("action", "/txap/mainPage/slide/update.do?${_csrf.parameterName}=${_csrf.token}");
	$("#Form").submit();
}
function exit(){
	alert("취소되었습니다.");
	return false;
}

function pf_back(){
	location.href="/txap/mainPage/slide.do";
}
</script>
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
							<input type="hidden" name="MM_MODNM" id="MM_MODNM" value="${MainSlide.MM_REGNM }"/>
							<input type="hidden" name="MM_KEYNO" id="MM_KEYNO" value="${MainSlide.MM_KEYNO }"/>
							<input type="hidden" name="MM_USE_YN" id="MM_USE_YN" value="${MainSlide.MM_USE_YN }"/>
							<input type="hidden" name="MM_LEVEL" id="MM_LEVEL" value="${MainSlide.MM_LEVEL }"/>
							<input type="hidden" name="MM_FS_KEYNO" value="${MainSlide.MM_FS_KEYNO }">
							<input type="hidden" id="resize" name="resize" value="Y">
							<input type="hidden" name="filecnt" value="0" />
							<legend>슬라이드 등록</legend>
								<fieldset>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">제목</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="MM_TITLE" name="MM_TITLE" value="${MainSlide.MM_TITLE }" data-bv-field="fullName"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">코멘트</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="MM_COMMENT" name="MM_COMMENT" value="${MainSlide.MM_COMMENT }" data-bv-field="fullName"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">링크 URL</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="MM_URL" name="MM_URL" value="${MainSlide.MM_URL }" data-bv-field="fullName"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
								</fieldset>
								
							
							
							<fieldset>
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label">슬라이드 이미지</label>
									<div class="col-md-6 smart-form">
										<div class="input input-file">
											<span class="button"><input type="file" id="exampleInputFile1" name="thumbnail" accept="image/*" onchange="chk_file_imgtype(this)"/>
											파일선택</span>
											<input type="text" name="MM_THUMBTEXT" id="MM_THUMBTEXT" value="${MainSlide.THUMBNAIL_ORINM }" placeholder="이미지 파일을 선택하세요" readonly/>
										</div>
										<div class="note">이미지 사이즈는 1080 X 308 입니다 사이즈가 다를경우 이미지가 깨질수있습니다. </div>
									</div>
									 <section class="col-md-2 smart-form">
							         	<label class="checkbox" style="padding-top:0">
										<input type="checkbox" name="file_resize" value="Y" checked="checked"/>
										<i></i>자동 리사이즈 여부</label>
							         </section>
								</div>
							</fieldset>
							
							<fieldset class="padding-10 text-right"> 
								<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_boardDataUpdate()">	
									<i class="fa fa-floppy-o"></i> 수정
								</button>
								<c:if test="${MainSlide.MM_USE_YN == 'Y' }">
								<button class="btn btn-sm btn-danger" id="Board_Delete" type="button" onclick="pf_boardDataDelete()">	
									<i class="fa fa-floppy-o"></i> 삭제
								</button>
								</c:if>
								<button class="btn btn-sm btn-default" id="Board_Back" type="button" onclick="pf_back()"> 
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
