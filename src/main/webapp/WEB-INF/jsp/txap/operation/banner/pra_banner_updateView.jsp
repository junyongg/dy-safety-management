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
	 	$("input[name=BM_THUMBTEXT]").val("");
	 	$("input[name=filecnt]").val(0);
	 	return false;
	}else{
		$("input[name=BM_THUMBTEXT]").val(obj.value);
		$("input[name=filecnt]").val(1);
	}
}

function pf_boardDataUpdate(){
	if(!$("#BM_TITLE").val()){
		alert("제목을 입력해주세요");
		return false;
	}
	if(!$("#BM_THUMBTEXT").val()){
		alert("이미지를 선택해주세요");
		return false;
	}
	success();
}
function pf_boardDataDelete(){
	if(confirm("배너를 삭제하시겠습니까?")){
		$("#Form").attr("action", "/txap/mainPage/banner/delete.do?${_csrf.parameterName}=${_csrf.token}");
		$("#Form").submit();
	}
}
function success(){
	$("#Form").attr("action", "/txap/mainPage/banner/update.do?${_csrf.parameterName}=${_csrf.token}");
	$("#Form").submit();
}
function exit(){
	alert("취소되었습니다.");
	return false;
}

function pf_back(){
	location.href="/txap/mainPage/banner.do";
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
							<input type="hidden" name="BM_MODNM" id="BM_MODNM" value="${MainBanner.BM_REGNM }"/>
							<input type="hidden" name="BM_KEYNO" id="BM_KEYNO" value="${MainBanner.BM_KEYNO }"/>
							<input type="hidden" name="BM_USE_YN" id="BM_USE_YN" value="${MainBanner.BM_USE_YN }"/>
							<input type="hidden" name="BM_LEVEL" id="BM_LEVEL" value="${MainBanner.BM_LEVEL }"/>
							<input type="hidden" name="BM_FS_KEYNO" value="${MainBanner.BM_FS_KEYNO }">
							<input type="hidden" name="filecnt" value="0" >
							<legend>슬라이드 등록</legend>
								<fieldset>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">제목</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="BM_TITLE" name="BM_TITLE" value="${MainBanner.BM_TITLE }" data-bv-field="fullName"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">링크 URL</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="BM_URL" name="BM_URL" value="${MainBanner.BM_URL }" data-bv-field="fullName"><i class="form-control-feedback" data-bv-icon-for="fullName" style="display: none;"></i>
										</div>
									</div>
								</fieldset>
								
							
							
							<fieldset>
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label">슬라이드 이미지</label>
									<div class="col-md-6 smart-form">
										<div class="input input-file">
											<span class="button"><input type="file" id="exampleInputFile1" name="thumbnail" accept="image/*" onchange="chk_file_imgtype(this)">
											파일선택</span>
											<input type="text" name="BM_THUMBTEXT" id="BM_THUMBTEXT" value="${MainBanner.THUMBNAIL_ORINM }" placeholder="이미지 파일을 선택하세요" readonly>
										</div>
										<div class="note">이미지 사이즈는 134 X 34 입니다 사이즈가 다를경우 이미지가 깨질수있습니다. </div>
									</div>
								</div>
							</fieldset>
							
							<fieldset class="padding-10 text-right"> 
								<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_boardDataUpdate()">	
									<i class="fa fa-floppy-o"></i> 수정
								</button>
								<c:if test="${MainBanner.BM_USE_YN == 'Y' }">
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
