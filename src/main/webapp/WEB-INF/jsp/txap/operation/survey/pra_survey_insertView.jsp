<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<style>
.option_dp{display: none;}
.column_size_dp{display: none;}
</style>
<div id="content">
	<form:form id="Form" name="Form" method="post" action="">
		<input type="hidden" name="SM_REGNM" value="${userInfo.UI_ID }" />
		<input type="hidden" name="SQ_REGNM" value="${userInfo.UI_NAME }" />
		<c:set var="SM_CNT_TYPE" value="${sm_cnt_type }"></c:set>
		<div class="row">
			<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
				<h1 class="page-title txt-color-blueDark">
					<i class="fa fa-table fa-fw "></i> 설문관리 <span>> 설문지 등록 </span>
				</h1>
			</div>
		</div>
		<section id="widget-grid">
			<div class="row">
				<article class="col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget jarviswidget-color-blueDark" id="" data-widget-editbutton="false"> 
						<header>
							<span class="widget-icon"> <i class="fa fa-table"></i>
							</span>
							<h2>설문지 등록</h2>
						</header>
							
						<div>
						<div class="widget-body-toolbar bg-color-white">
							<div class="alert alert-info no-margin fade in">
								<button type="button" class="close" data-dismiss="alert">×</button>
								새로운 설문지를 생성합니다.<br>
								<span style="color: red;">*표시는 필수 입력 항목입니다.</span>
							</div>
						</div>	
						
						<div class="widget-body no-padding smart-form">
								<fieldset>
									<div class="row"> 
										<section class="col col-12">
											<h6>설문 기초 정보 등록</h6>   
										</section> 
									</div>
									<div class="row"> 
										<section class="col col-6">
											<label class="col-md-2 control-label"><span class="nessSpan">*</span> 설문 제목</label>
											<div class="col-md-9">
											<label class="input"> <i class="icon-prepend fa fa-edit"></i> 
												<input class="checkTrim" type="text" id="SM_TITLE" name="SM_TITLE" placeholder="설문지 제목"  maxlength="50" value=""/>
											</label>
											</div>
										</section>
										<section class="col col-6">
											<label class="col-md-2 control-label"><span class="nessSpan">*</span> 홈페이지 선택</label>
											<div class="col-md-9">
												<select class="form-control input-sm" id="SM_MN_KEYNO" name="SM_MN_KEYNO">
													<option value="">홈페이지 선택</option>
													<c:forEach items="${homeDivList }" var="model"> 
		 								                <option value="${model.MN_KEYNO }">${model.MN_NAME }</option> 
		 								              </c:forEach>
												</select> 
											</div>
										</section>
										<section class="col col-6">
											<label class="col-md-2 control-label"><span class="nessSpan">*</span> 설문 시작일</label>
											<div class="input-group col-9">
												<input name="SM_STARTDT" id="SM_STARTDT" type="text" class="form-control datepicker" data-dateformat="yy-mm-dd" style="padding-left: 10px;">
												<span class="input-group-addon" style="position: relative; z-index: 1000;"><i class="fa fa-calendar"></i></span>
											</div>
										</section>
										<section class="col col-6">
											<label class="col-md-2 control-label"><span class="nessSpan">*</span> 설문 종료일</label>
											<div class="input-group col-9">
												<input name="SM_ENDDT" id="SM_ENDDT" type="text" class="form-control datepicker" data-dateformat="yy-mm-dd" style="padding-left: 10px;">
												<span class="input-group-addon" style="position: relative; z-index: 1000;"><i class="fa fa-calendar"></i></span>
											</div>
										</section>
										<section class="col col-12">
											<label class="col-md-1 control-label"><span class="nessSpan">*</span> 설문 내용</label>
											<div class="col-md-11">
											<label class="input"> 
												<textarea class="checkTrim" id="SM_EXP" name="SM_EXP" placeholder="  설문 기초 설명" rows="5" style="width:100%; resize: none;"></textarea>
											</label>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-2 control-label">실명 사용여부</label>
											<div class="col-sm-12 col-md-9">
												<label class="radio radio-inline no-margin">
												<input type="radio" name="SM_IDYN" value="Y" class="radiobox style-2" data-bv-field="rating">
												<span>사용</span> </label>
											
												<label class="radio radio-inline no-margin">
												<input type="radio" name="SM_IDYN" value="N" class="radiobox style-2" data-bv-field="rating" checked>
												<span>미사용</span> </label>
											</div>
										</section>
										<section class="col col-6">
											<label class="col-md-2 control-label">보기 배점방식</label>
											<div class="col-sm-12 col-md-9">
												<label class="radio radio-inline no-margin">
												<input type="radio" name="SM_CNT_TYPE" value="S" class="radiobox style-2" data-bv-field="rating">
												<span>점수</span> </label>
											
												<label class="radio radio-inline no-margin">
												<input type="radio" name="SM_CNT_TYPE" value="H" class="radiobox style-2" data-bv-field="rating" checked>
												<span>인원수</span> </label>
											</div>
										</section>
									</div>
								</fieldset>
								
								<fieldset>
									<div class="smart-form">
										<div class="row"> 
											<section class="col col-1">
												<h6>문항 등록</h6>   
											</section> 
											<section class="col col-3">
												<button class="btn btn-sm btn-primary" id="Board_Edit" type="button" onclick="pf_AddColumn()">	
												<i class="fa fa-floppy-o"></i> 문항추가
											</button>
											</section>
										</div>
										<div class="note" style="color: red;">* 설문 문항은 최소 한개 이상 존재해야 합니다.</div>
										<fieldset id="AddColumn">
											
										</fieldset>
									</div>
								</fieldset>
								<fieldset class="padding-10 text-right"> 
									<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_boardTypeInsert()">	
										<i class="fa fa-floppy-o"></i> 저장
									</button>
									<button class="btn btn-sm btn-default" id="Board_Delete" type="button" onclick="pf_back()"> 
										<i class="fa fa-times"></i> 취소
									</button> 
								</fieldset>
							</div>
						</div>
					</div>
				</article>
			</div>
		</section>
	</form:form>
</div>
<div id="optiondialog_append">

</div>
<script type="text/javascript">
var addOptionCnt = 0;
var columnCnt = 0;
var modifybool = true;
var modifytextobj;
// 결과 계산 방식

$(function(){
	pf_AddColumn();
	$('#SM_STARTDT').on('change',function(){
		$('#SM_ENDDT').datepicker('option', 'minDate', $(this).val());
	});
	$('#SM_ENDDT').on('change',function(){
		$('#SM_STARTDT').datepicker('option', 'maxDate', $(this).val());
	});
})


//게시판 타입 등록 처리 및 입력 폼 체크
function pf_boardTypeInsert() {
	
	if(!$("#SM_TITLE").val().trim()){
		cf_smallBox('Form', '제목을 입력해 주세요.', 3000,'#d24158');
		$("#SM_TITLE").focus();
		return false;
	}
	
 	if(!$("#SM_STARTDT").val()){
 		cf_smallBox('Form', '시작일을 입력해 주세요.', 3000,'#d24158');
 		$("#SM_STARTDT").focus();
 		return false;
 	}
	
 	if(!$("#SM_ENDDT").val()){
 		cf_smallBox('Form', '종료일을 입력해 주세요.', 3000,'#d24158');
 		$("#SM_ENDDT").focus();
 		return false;
 	}
	
	if(!$("#SM_EXP").val().trim()){
		cf_smallBox('Form', '설명을 입력해 주세요.', 3000,'#d24158');
		$("#SM_EXP").focus();
		return false;
	}
	
// 	if(!cf_radio_check_val("SM_IDYN")){
// 		alert("비밀글 사용여부를 선택해주세요");
// 		return false;
// 	}
	
	if($("#AddColumn").find(".column-row").length < 1){
		cf_smallBox('Form', '문항을 추가해주세요.', 3000,'#d24158');
		return false;
	}

	
	if(valcheck()){
		if(confirm("새로운 설문지를 등록 하시겠습니까?")){
			success();
		}else{
			exit();
		}
	}
}

function pf_back(){
	location.href="/txap/operation/survey.do";
}

//성공 콜백 함수   
function success() {
	cf_replaceTrim($("#Form"));
	$("#Form").attr("action", "/txap/operation/survey/insert.do");
	$("#Form").submit();
}

//실패 콜백 함수   
function exit() {
	cf_smallBox('cencel', '취소되었습니다.', 3000,'#d24158');
	return false;
}
function pf_AddColumn(){
	addOptionCnt++;
	columnCnt++;
	var divID = "column-row"+addOptionCnt;	
	var html 	= "";
		html   += "<div id='"+divID+"' class='column-row'>";
		
		html   += "<div class='row'>"; 
// 		html   += "<input type='hidden' name='BL_KEYNO' value=''>";
		html   += "<input type='hidden' id='SQ_OPTION_DATA"+divID+"' name='SQ_OPTION_DATA' value=''>";
		html   += "<section class='col col-2'>";
		html   += "<label class='input'> <i class='icon-prepend fa fa-edit'></i> ";
		html   += "<input type='text' name='SQ_NUM' value='"+columnCnt+"' readonly/>";
		html   += "</label>"; 
		html   += "</section>";
		html   += "<section class='col col-2'>";
		html   += "<label class='select'>";
		html   += "<select name='SQ_ST_TYPE' id='SQ_ST_TYPE"+divID+"' onchange=pf_surveyTypeChange('"+divID+"')>";
		html   += "<option value=''>문제 타입 선택</option>";
		html   += "<option value='T'>주관식(텍스트박스)</option>";
		html   += "<option value='R'>객관식(라디오)</option>";
		html   += "<option value='C'>객관식(체크박스)</option>";
		html   += "</select>";
		html   += "<i></i>";
		html   += "</label>";
		html   += "</section>";
		html   += "<section class='col col-2' style='height: 32px; line-height: 32px; vertical-align: middle;'>";
		html   += "<section class='col-12' style='height: 32px; line-height: 32px; vertical-align: middle;'>";
		html   += "<a href='javascript:;' onclick='pf_columnDelete(\""+divID+"\")' class='btn btn-danger btn-xs sqDelBtn' >";
		html   += "삭제하기";
		html   += "</a>";
		html   += "<span class='option_dp'>"
		html   += "&nbsp;";
		html   += "<a href='javascript:;' onclick=pf_optiondialog_open('"+divID+"') class='btn btn-info btn-xs'>";
		html   += "옵션관리";
		html   += "</a> ";
		html   += "</span>"
		html   += "</section>";
		html   += "</section>";
		html   += "</div>";
		
		html   += "<div class='row'>";
		html   += "<section class='col col-12'>";
		html   += "<label class='input'> <i class='icon-prepend fa fa-edit'></i>";
		html   += "<input class='checkTrim' type='text' name='SQ_QUESTION' placeholder='질문 작성'  maxlength='200'  />";
		html   += "</label>";
		html   += "</section>";
		html   += "</div>";
		
		html   += "</div>";
	$("#AddColumn").append(html);
	optionhtml(divID);
	
}
function pf_optiondialog_open(divID){
	var sm_cnt_type = $("input:radio[name='SM_CNT_TYPE']:checked").val();
	if(sm_cnt_type == "H"){
		$("#Addoption_dialog_" + divID).find("#option_score_" + divID).val(1);
		$("#Addoption_dialog_" + divID).find("#option_score_" + divID).attr("readonly","true");
		$(".bogiscore").hide();
	}else{
		$("#Addoption_dialog_" + divID).find("#option_score_" + divID).removeAttr("readonly");
		$(".bogiscore").show();
	}
	$("#Addoption_dialog_" + divID).dialog("open");
}

function pf_columnDelete(val){
	var cnt = $("#AddColumn").find(".column-row").length;
	if(cnt <= 1){
		cf_smallBox('alert', '문항은 최소 한개이상 존재해야 합니다.', 3000,'#d24158');
		return false;
	}
	$("#"+val).remove();
	$("#Addoption_dialog_"+val).remove();
	$("input[name=SQ_NUM]").each(function(i){
		$(this).val(i+1);		
	});
	resetColumnCnt();
}


//컬럼 순서 리셋
function resetColumnCnt(){
	$row = $("#AddColumn").find(".column-row");
	$row.each(function(i){
		$(this).find('.sq_num').val(i+1)
	})
	columnCnt = $row.length; 
}

function optionhtml(divID){
	var html	= "";
		html   += "<div id='Addoption_dialog_"+divID+"' title='보기 관리'>";
		
		html   += "<fieldset>";
		html   += "<div class='bs-example necessT'>";
		html   += "<span class='colorR fs12'>*표시는 필수 입력 항목입니다.</span>";
		html   += "</div>";
		html   += "<div class='form-group'>";
		html   += "<input class='form-control' placeholder='보기 입력' type='text' id='option_data_"+divID+"'  maxlength='100' onkeyup=enterkey('"+divID+"')>";
		html   += "<input class='form-control' placeholder='배점 입력' type='number' id='option_score_"+divID+"' maxlength='3' onkeyup=enterkey('"+divID+"')>";
		html   += "</div>";
		
		html   += "<div class='form-group no-margin' >";
		html   += "<label id='option_Msg_"+divID+"'></label>";
		html   += "</div>";
		
		html   += "<div class='form-group'>";
		html   += "<button class='btn btn-success pull-left' onclick=pf_option_action('"+divID+"')>";
		html   += "<i class='fa fa-save'></i>&nbsp; 보기 저장";
		html   += "</button>";
		html   += "</div>";
		
		html   += "<div class='form-group' >";
		html   += "<label id='option_Msg_"+divID+"'></label>";
		html   += "</div>";
		
		html   +="<div style='clear:both'></div>"
		html   += "<div class='form-group '>";
		html   += "<label><i class='fa fa-th-list'></i>보기 목록</label> <br/>";
		html   += "<label id='Addoption_dialog_ContentsBox_"+divID+"'>";
		html   += "</label>";
		html   += "</div>";
		
		html   += "</fieldset>";
		
		html   += "</div>";
		
	$("#optiondialog_append").append(html);
	
	
	$("#Addoption_dialog_"+divID).dialog({
		autoOpen 	: false,
		width 		: 800,  
		resizable 	: true,
		modal 		: true,
		close		: function( event, ui ) {
			var data = "";
			leng = $("#Addoption_dialog_ContentsBox_"+divID).find('.atext').length;
			$("#Addoption_dialog_ContentsBox_"+divID).find('.atext').each(function(i){
				data += $(this).find('.option_value').val();
				data += "_";
				data += $(this).find('.option_score').val();
				//alert(data);
				if(i+1 < leng){
					data += "/";
				}
				
				$("#"+divID).find('#SQ_OPTION_DATA'+divID).val(data)
			})
// 			alert(data)
			modifybool = true;
			modifytextobj = null;
			$("#option_data_" + divID).val("");
			$("#option_score_" + divID).val("");
		}
	});
}

// 문제타입 선택에 따른 옵션
function pf_surveyTypeChange(divID){
	var ChangeSelectBox = $("#SQ_ST_TYPE" + divID).val();
	if(ChangeSelectBox == 'R' || ChangeSelectBox == 'C'){
		$("#"+divID).find('.option_dp').show();
	}else{
		$("#"+divID).find('.option_dp').hide();
	}
}

//옵션 정보 등록,수정 처리
function pf_option_action(divID){
	var HtmlContents = "";
	var sm_cnt_type = $("input:radio[name='SM_CNT_TYPE']:checked").val();
	if(modifybool){
		//입력 정보 검사
		if(!$("#option_data_" + divID).val().trim()){
			cf_smallBox('alert', '보기를 입력해 주세요.', 3000,'#d24158');
			$("#option_data_" + divID).focus();
			return false;
		}
		if(sm_cnt_type == "S"){
			if(!$("#option_score_" + divID).val().trim()){
				cf_smallBox('alert', '배점을 입력해 주세요.', 3000,'#d24158');
				$("#option_score_" + divID).focus();
				return false;
			}
		}
		
		// 등록할 보기 정보 삽입
// 		cnt++
		HtmlContents += "<div class='col col-1'>";
		HtmlContents += "<a href='javascript:;' class='atext' onclick='pf_modify_view(this,\""+divID+"\")'>";
// 		HtmlContents += "<span>"+cnt+"</span>.&nbsp;&nbsp;";
		HtmlContents += "<span class='BOGI'>"+$("#option_data_"+divID).val().trim()+"</span>&nbsp;";
		HtmlContents += "<span class='bogiscore'>(배점: <span>"+$("#option_score_"+divID).val()+"</span>)</span>";
		HtmlContents += "<input class='option_value' type='hidden' id='SQO_OPTION_"+divID+"' value='"+$("#option_data_"+divID).val().trim()+"'>";
		HtmlContents += "<input class='option_score' type='hidden' id='SQO_VALUE_"+divID+"' value='"+$("#option_score_"+divID).val()+"'>";
		HtmlContents += "</a>";
		HtmlContents += "&nbsp;&nbsp;<a href='javascript:;'><i class='fa fa-times-circle' onclick='pf_option_delete(this)' ></i></a>";
// 		HtmlContents += "<input type='hidden' name='SQO_NUM"+divID+"' value='"+$("#option_num_"+divID).val()+"'>";
		
		HtmlContents +=  "</div>";

		$("#Addoption_dialog_ContentsBox_" + divID).html( 
		$("#Addoption_dialog_ContentsBox_" + divID).html() + HtmlContents);
		
		if(sm_cnt_type == 'S'){
			$(".bogiscore").css('display', 'inline-block');
		}else{
			$(document).find(".bogiscore").css('display', 'none');
		}
		
	}else{
		HtmlContents += "<span class='BOGI'>"+$("#option_data_"+divID).val().trim()+"</span>&nbsp;";
		HtmlContents += "<span class='bogiscore'>(배점: <span>"+$("#option_score_"+divID).val()+"</span>)</span>";
		HtmlContents += "<input class='option_value' type='hidden' id='SQO_OPTION_"+divID+"' value='"+$("#option_data_"+divID).val().trim()+"'>";
		HtmlContents += "<input class='option_score' type='hidden' id='SQO_VALUE_"+divID+"' value='"+$("#option_score_"+divID).val()+"'>";
		if(sm_cnt_type == 'S'){
			$(".bogiscore").css('display', 'block');
		}else{
			$(".bogiscore").css('display', 'none');
		}
		$(modifytextobj).html(HtmlContents)
		modifybool = true;
	}
	$("#option_data_" + divID).focus();
	$("#option_data_" + divID).val("");
	if(sm_cnt_type == "H"){
		$("#option_score_" + divID).val(1);
	}else if(sm_cnt_type == "S"){
		$("#option_score_" + divID).val("");
	}
}


function pf_modify_view(obj, divID){
	var modify_obj = $(obj).parent();
	$("#option_data_" + divID).val(modify_obj.find("#SQO_OPTION_"+divID).val());
	$("#option_score_" + divID).val(modify_obj.find("#SQO_VALUE_"+divID).val());
	$("#SQO_OPTION_"+divID).val($(obj).find(".BOGI").text());
	modifybool = false;
	modifytextobj = obj;
}	
	
// function pf_ColumnViewYN(divID){
// 	var ChangeSelectBox = $("#BL_LISTVIEW_YN" + divID).val();
// 	if(ChangeSelectBox == 'Y'){
// 		$("#"+divID).find('.column_size_dp').show();
// 	}else{
// 		$("#"+divID).find('.column_size_dp').hide();
// 	}
// }

function pf_option_delete(obj){
	$(obj).parent().parent().remove();
}

function valcheck(){
	var bool = true;
	var num = 0;
	$("#AddColumn").find(".column-row").each(function(i){
		num = i+1;
		if($(this).find("select[name='SQ_ST_TYPE']").val()==""){
			cf_smallBox('Form', '문제 타입을 입력해주세요.', 3000,'#d24158');
			bool = false;
			return false;
		}else if(!$(this).find("input[name='SQ_QUESTION']").val().trim()){
			cf_smallBox('Form', '질문을 작성해 주세요.', 3000,'#d24158');
			bool = false;
			return false;
		}else if($(this).find("select[name='SQ_ST_TYPE']").val()=="R"){
			if($("#Addoption_dialog_ContentsBox_column-row"+num).find("a").text()==""){
				cf_smallBox('Form', '객관식 보기를 입력해주세요.', 3000,'#d24158');
				bool = false;
				return false;
			}
		}
	})	
	return bool;
}


function enterkey(divID) {
	if (window.event.keyCode == 13) {
         // 엔터키가 눌렸을 때 실행할 내용
		pf_option_action(divID);
    }
}
</script>