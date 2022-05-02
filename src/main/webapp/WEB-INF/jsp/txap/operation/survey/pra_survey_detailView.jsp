<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script type="text/javascript">
var addOptionCnt = ${fn:length(SQ)};
var columnCnt = ${fn:length(SQ)};
var modifybool = true;
var modifytextobj;

$(function(){
	pf_bogiShowHide('${SmDTO.SM_CNT_TYPE}');
	$('#SM_STARTDT').on('change',function(){
		$('#SM_ENDDT').datepicker('option', 'minDate', $(this).val());
	});
	$('#SM_ENDDT').on('change',function(){
		$('#SM_STARTDT').datepicker('option', 'maxDate', $(this).val());
	});
	
	$("#AddColumn").sortable({
		beforeStop: function( event, ui ) {
			resetColumnCnt();
		}
	});
})

function pf_bogiShowHide(type){
	if(type == 'S'){
		$(".bogiscore").show();
	}else{
		$(".bogiscore").hide();
	}
}

//게시판 타입 등록 처리 및 입력 폼 체크
function pf_smUpdate() {
	var state = false;
	if(!$("#SM_TITLE").val().trim()){
		alert("제목을 입력해 주세요");
		$("#SM_TITLE").focus();
		return state;
	}
	
 	if(!$("#SM_STARTDT").val()){
 		alert("시작일을 입력해 주세요");
 		$("#SM_STARTDT").focus();
 		return state;
 	}
	
 	if(!$("#SM_ENDDT").val()){
 		alert("종료일을 입력해 주세요");
 		$("#SM_ENDDT").focus();
 		return state;
 	}
	
	if(!$("#SM_EXP").val().trim()){
		alert("설명을 입력해 주세요");
		$("#SM_EXP").focus();
		return state;
	}
	
	if($("#AddColumn").find(".sq-column-row").length < 1){
		alert("컬럼을 추가해주세요");
		return state;
	}
	
	if(valcheck()){
		if(confirm("설문지를 수정 하시겠습니까?")){
			success();
		}else{
			exit();
		}
	}
}

//성공 콜백 함수   
function success() {
		
	$('.sq-column-row').each(function(){
		var divID = $(this).attr('id').replace('SQ','');
		if($(this).find('.sq_keyno').length > 0 ){
			//수정
			pf_columnUpdate(divID)
		}else{
			//추가
			pf_columnInsert(divID)
		}
		
	})
	$('#deleteColumnKeys').val(deleteColumnKeys.join(','));
	$('#deleteBogiKeys').val(deleteBogiKeys.join(','));
    cf_replaceTrim($("#Form"));
	$("#Form").attr("action", "/txap/operation/survey/update.do");
	$("#Form").submit();
	
}

//실패 콜백 함수   
function exit() {
	alert("취소되었습니다.");
	return false;
}

function pf_AddColumn(){
	addOptionCnt++;
	columnCnt++;
	var divID = "_row"+addOptionCnt;	
	var html 	= "";
		html   += "<div id='SQ"+divID+"' class='sq-column-row'>";
		
		html   += "<div class='row'>"; 
// 		html   += "<input type='hidden' name='BL_KEYNO' value=''>";
		html   += "<section class='col col-2'>";
		html   += "<label class='input'> <i class='icon-prepend fa fa-edit'></i> ";
		html   += "<input type='text' class='sq_num' name='SQ_NUM' id='SQ_NUM"+divID+"' value='"+columnCnt+"' readonly/>";
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
		html   += "<section class='col col-8' style='height: 32px; line-height: 32px; vertical-align: middle;'>";
		html   += "<span class='option_dp'>"
		html   += "<a href='javascript:;' onclick=pf_addOption('"+divID+"') class='btn btn-info btn-xs'>";
		html   += "옵션추가";
		html   += "</a> ";
		html   += "</span>"
		html   += "<a href='javascript:;' onclick=pf_columnDelete('"+divID+"','') class='btn btn-danger btn-xs' >";
		html   += "삭제하기";
		html   += "</a>";
		html   += "</section>";
		html   += "</div>";
		
		html   += "<div class='row'>";
		html   += "<section class='col col-12'>";
		html   += "<label class='input'> <i class='icon-prepend fa fa-edit'></i>";
		html   += "<input class='checkTrim' type='text' id='SQ_QUESTION"+divID+"' name='SQ_QUESTION' placeholder='질문 작성'  />";
		html   += "</label>";
		html   += "</section>";
		html   += "<div id='optiondialog_append_row"+divID+"' class='optiondialog_append_row'>"
		html   += "<div id='SQO"+divID+"' class='sqo-column-row'>"
		html   += "</div>"
		html   += "</div>"
		html   += "</div>";
		
		html   += "</div>";
	$("#AddColumn").append(html);
	
}

// 신규 문항 등록하기
function pf_columnInsert(divID){
	
		pf_optionAppend(divID)
		
		$.ajax({
		    type   : "post",
		    url    : "/txap/operation/survey/sq/insertAjax.do",
		    data   : {	
		    			 "SQ_SM_KEYNO" 		: $("#SM_KEYNO").val() 
	    				,"SQ_NUM"			: $("#SQ_NUM"+divID).val()
		    			,"SQ_ALIGN"			: $("#SQ_NUM"+divID).val()
						,"SQ_ST_TYPE"		: $("#SQ_ST_TYPE"+divID).val()
						,"SQ_QUESTION"		: $("#SQ_QUESTION"+divID).val()
						,"SQ_OPTION_DATA"	: $("#SQ_OPTION_DATA").val()
		    		 },
    		async : false,
		    success:function(data){
		    	
		    },
		    error: function(jqXHR, textStatus, exception) {
		    	alert('error: '+textStatus+": "+exception);
		    }
		  });
	
}

//문항 수정
function pf_columnUpdate(divID){
	
	pf_optionAppend(divID);
	$.ajax({
	    type   : "post",
	    url    : "/txap/operation/survey/sq/updataAjax.do",
	    data   : {	
	    			 "SQ_KEYNO" 		: $("#SQ_KEYNO"+divID).val() 
	    			,"SQ_QUESTION" 		: $("#SQ_QUESTION"+divID).val()
	    			,"SQ_ST_TYPE" 		: $("#SQ_ST_TYPE"+divID).val()
	    			,"SQ_OPTION_DATA"	: $("#SQ_OPTION_DATA").val()
	    			,"SQ_NUM"			: $("#SQ_NUM"+divID).val()
	    		 },
   		async : false,
	    success:function(data){
	    	
	    },
	    error: function(jqXHR, textStatus, exception) {
	    	alert('error: '+textStatus+": "+exception);
	    }
	  });
}

// 보기 추가
function pf_addOption(divID){
	var sm_cnt_type = $("input[type=radio][name=SM_CNT_TYPE]:checked").val();
	var getLast 	 = $("#SQO"+divID).find(".option .num").filter(":last").text();
	console.log(getLast);
	var num		 = getLast*1 +1; 
	var param_div = "_row"+num;
	var html	 = "";
		html	+="<div class='option' id='option_row"+num+"'>";
		html	+="<span class='num'>"+num+"</span>";
// 		html	+="<input type='text' name='sqo_question' class='sqo_question' id='SQ_QUESTION"+param_div+"' >";
		html	+="<input type='text' name='sqo_option' class='sqo_option' id='SQO_OPTION"+param_div+"' maxlength='250'>";
		html	+="<span class='bogiscore'>배점:<input type='number' class='sqo_value' name='sqo_value' id='SQ_VALUE"+param_div+"' maxlength='3'></span>";
		html	+="<button class='btn btn-xs btn-default' id='Board_Delete' type='button' onclick=pf_optionDel('"+divID+"','"+param_div+"')>"; 
		html	+="<i class='fa  fa-times-circle'></i>";
		html	+="</button>";
		html	+="</div>";
	
	$("#SQO"+divID).append(html);
	pf_bogiShowHide(sm_cnt_type);
	if(sm_cnt_type == "H"){
		$("#SQ_VALUE"+param_div).val(1);
		$("#SQ_VALUE"+param_div).attr("readonly","true");
	}
	
}

//문항삭제
var deleteColumnKeys = new Array();
function pf_columnDelete(divID,sq_keyno){
	
	if(confirm("문항을 삭제하시겠습니까?")){
		if(sq_keyno){
			deleteColumnKeys.push(sq_keyno);
		}
		$("#SQ"+divID).remove();
		$("#SQO"+divID).remove();
		
		resetColumnCnt();

	}
}

//문항 순서 리셋
function resetColumnCnt(){
	$row = $('.sq-column-row').not('.ui-sortable-placeholder');
	$row.each(function(i){
		$(this).find('.sq_num').val(i+1)
	})
	columnCnt = $row.length; 
}

// 보기 삭제
var deleteBogiKeys = new Array();
function pf_optionDel(divNum, sqoDivID){
	if(confirm("보기를 삭제하시겠습니까?")){
		if($("#SQO"+divNum).find("#SQO_KEYNO"+sqoDivID).length > 0){
			var sqo_keyno = $("#SQ"+divNum).find("#SQO_KEYNO"+sqoDivID).val();
			if(sqo_keyno){
				deleteBogiKeys.push(sqo_keyno);
			}
		}
		$("#SQ"+divNum).find("#option"+sqoDivID).remove();
		
		resetBogiCnt(divNum);
	}
}

//보기 순서 리셋
function resetBogiCnt(num){
	$row = $("#SQO"+num).find(".option");
	$row.each(function(i){
		$(this).find('.num').text(i+1)
	})
}

// 보기 문항 하나로 묶기
function pf_optionAppend(divID){
	var data = "";
	var lang = $("#SQO"+divID).find(".option").length;
	var type = $("input[type=radio][name=SM_CNT_TYPE]:checked").val();
	$("#SQO"+divID).find(".option").each(function(i){
		data += $(this).find(".sqo_keyno").val();
		data += ":";
		data += $(this).find(".sqo_option").val();
		data += ":";
		if(type == 'S'){
		data += $(this).find(".sqo_value").val();
		}else{
		data += 1;
		}
		if(i+1 < lang){
			data += "/";
		}
	});
	$("#SQ_OPTION_DATA").val(data)
	
	var sq_num = $('#SQ'+divID).find('.sq_num').val();
	$('#SQ_NUM').val(sq_num)
}

// 보기 문항 체크
function valcheck(){
	var bool = true;
	$("#AddColumn").find(".sq-column-row").each(function(){
		
		if($(this).find("select[name='SQ_ST_TYPE']").val()==""){
			alert("문제 타입을 입력해주세요");
			$(this).find("select[name='SQ_ST_TYPE']").focus();
			bool = false;
			return bool;
		}
			
		if(!$(this).find("input[name='SQ_QUESTION']").val().trim()){
			alert("질문을 작성해 주세요");
			$(this).find("input[name='SQ_QUESTION']").focus();
			bool = false;
			return bool;
		}
		
		if($(this).find("select[name='SQ_ST_TYPE']").val()=='R'){
			if($(this).find(".option").length < 1){
				alert("보기는 최소 한개 이상 존재해야합니다.");
				bool = false;
				return bool;
			}else{
				$(this).find(".optiondialog_append_row .option").each(function(){
					if($(this).find("input[name='sqo_option']").val()==""){
						alert("보기를 작성해 주세요");
						$(this).find("input[name='sqo_option']").focus();
						bool = false;
						return bool;
					}
					var type = $("input[type=radio][name=SM_CNT_TYPE]:checked").val();
					if(type == 'S'){
						if($(this).find("input[name='sqo_value']").val()==""){
							alert("배점을 작성해 주세요");
							$(this).find("input[name='sqo_value']").focus();
							bool = false;
							return bool;
						}
					}
				})
			}
		}
	});
	return bool;
}

//문제타입 선택에 따른 옵션 T:주 , R:객(라)
function pf_surveyTypeChange(divID){	
	var ChangeSelectBox = $("#SQ_ST_TYPE" + divID).val();
	if(ChangeSelectBox == 'R' || ChangeSelectBox == 'C'){
		$("#SQ"+divID).find('.option_dp').show();
	}else{
		$("#SQ"+divID).find('.option_dp').hide();
	}
}

function pf_back(){
	location.href="/txap/operation/survey.do";
}

// 설문삭제
function pf_smDelete(){
	if(confirm("설문을 삭제하시겠습니까?")){
		$("#Form").attr("action", "/txap/operation/survey/sm/delete.do");
		$("#Form").submit();
	}
}

</script>
<style>
.option_dp{display: none;}
.column_size_dp{display: none;}
.option{margin-left:15px; margin-top: 5px;}
.option .num{margin-right: 15px;}
.option .sqo_option{margin-right: 15px; width:500px;}
.option .sqo_value{margin-left:5px; width:100px;}
.optiondialog_append_row{margin-bottom: 10px;}
.sq-column-row {padding:20px 0 10px;border-top:1px solid #777;}

</style>
<div id="content">
	<form:form id="Form" name="Form" method="post" action="">
		<input type="hidden" name="SM_REGNM" value="${userInfo.UI_ID }" />
		<input type="hidden" id="SM_KEYNO" name="SM_KEYNO" value="${SmDTO.SM_KEYNO }"/>
		
		<input type="hidden" id="SQ_KEYNO" name="SQ_KEYNO"/>
		<input type="hidden" id="SQ_OPTION_DATA" name="SQ_OPTION_DATA">
		<input type="hidden" name="SQ_REGNM" value="${userInfo.UI_NAME }" />
		<input type="hidden" id="deleteColumnKeys" name="deleteColumnKeys">
		<input type="hidden" id="deleteBogiKeys" name="deleteBogiKeys">
		
		 
		<div class="row">
			<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
				<h1 class="page-title txt-color-blueDark">
					<i class="fa fa-table fa-fw "></i> 설문관리 <span> 설문지 등록 </span>
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
							<h2>설문지 상세보기</h2>
						</header>
							
						<div>
						<div class="widget-body-toolbar bg-color-white">
							<div class="alert alert-info no-margin fade in">
								<button type="button" class="close" data-dismiss="alert">×</button>
								작성된 설문지를 확입합니다.
								<br>
								<span style="color:red;">*표시는 필수 입력 항목입니다.</span>
							</div>
						</div>	
						
						<div class="widget-body no-padding smart-form">
								<fieldset>
									<div class="row"> 
										<section class="col col-12">
											<h6>설문지 상세보기</h6>   
										</section> 
									</div>
								
									<div class="row"> 
										<section class="col col-6">
											<label class="col-md-2 control-label"><span class="nessSpan">*</span> 설문 제목</label>
											<div class="col-md-9">
											<label class="input"> <i class="icon-prepend fa fa-edit"></i> 
												<input class="checkTrim" type="text" id="SM_TITLE" name="SM_TITLE" placeholder="설문지 제목"  maxlength="50" value="${SmDTO.SM_TITLE }"/>
											</label>
											</div>
										</section>
										<section class="col col-6">
											<label class="col-md-2 control-label"><span class="nessSpan">*</span> 홈페이지 선택</label>
											<div class="col-md-9">
												<select class="form-control input-sm" id="SM_MN_KEYNO" name="SM_MN_KEYNO">
													<option value="">홈페이지 선택</option>
													<c:forEach items="${homeDivList }" var="model"> 
		 								                <option value="${model.MN_KEYNO }" ${model.MN_KEYNO eq SmDTO.SM_MN_KEYNO ? 'selected' : ''}>${model.MN_NAME }</option> 
		 								              </c:forEach>
												</select> 
											</div>
										</section>
										<section class="col col-6">
											<label class="col-md-2 control-label"><span class="nessSpan">*</span> 설문 시작일</label>
											<div class="input-group col-9">
												<input name="SM_STARTDT" id="SM_STARTDT" type="text" class="form-control datepicker" data-dateformat="yy-mm-dd" value="${SmDTO.SM_STARTDT }" maxlength="10">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</section>
										<section class="col col-6">
											<label class="col-md-2 control-label"><span class="nessSpan">*</span> 설문 종료일</label>
											<div class="input-group col-9">
												<input name="SM_ENDDT" id="SM_ENDDT" type="text" class="form-control datepicker" data-dateformat="yy-mm-dd" value="${SmDTO.SM_ENDDT }" maxlength="10">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</section>
										<section class="col col-12">
											<label class="col-md-1 control-label"><span class="nessSpan">*</span> 설문 내용</label>
											<div class="col-md-11">
											<label class="input"> 
												<textarea class="checkTrim" id="SM_EXP" name="SM_EXP" placeholder="  설문 기초 설명" rows="5" style="width:100%; resize: none;" maxlength="2000">${SmDTO.SM_EXP }</textarea>
											</label>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-2 control-label">실명 사용여부</label>
											<div class="col-sm-12 col-md-9">
												<label class="radio radio-inline no-margin">
												<input type="radio" name="SM_IDYN" value="Y" class="radiobox style-2" data-bv-field="rating" ${SmDTO.SM_IDYN eq 'Y' ? 'checked':''}>
												<span>사용</span> </label>
											
												<label class="radio radio-inline no-margin">
												<input type="radio" name="SM_IDYN" value="N" class="radiobox style-2" data-bv-field="rating" ${SmDTO.SM_IDYN eq 'N' ? 'checked':''}>
												<span>미사용</span> </label>
											</div>
										</section>
										<section class="col col-6">
											<label class="col-md-2 control-label">보기배점방식</label>
											<div class="col-sm-12 col-md-9">
												<label class="radio radio-inline no-margin">
												<input type="radio" name="SM_CNT_TYPE" value="S" class="radiobox style-2" data-bv-field="rating" ${SmDTO.SM_CNT_TYPE eq 'S' ? 'checked':''} onclick="pf_bogiShowHide('S');">
												<span>점수</span> </label>
											
												<label class="radio radio-inline no-margin">
												<input type="radio" name="SM_CNT_TYPE" value="H" class="radiobox style-2" data-bv-field="rating" ${SmDTO.SM_CNT_TYPE eq 'H' ? 'checked':''} onclick="pf_bogiShowHide('H');">
												<span>인원수</span> </label>
											</div>
										</section>
									</div>
								</fieldset>
								
								<fieldset>
									<div class="smart-form">
										<div class="row"> 
											<section class="col col-1">
												<h6>문항 목록</h6>   
											</section> 
											<section class="col col-3">
												<button class="btn btn-sm btn-primary" id="Board_Edit" type="button" onclick="pf_AddColumn()">	
												<i class="fa fa-floppy-o"></i> 문항추가
											</button>
											</section>
										</div>
										<div class="note" style="color: red;">* 설문 문항은 최소 한개 이상 존재해야 합니다.</div>
										<fieldset id="AddColumn">
											<c:forEach items="${SQ }" var="sq" varStatus="status">
												<div id="SQ_row${status.count }" class="sq-column-row">
													<input type="hidden" class="sq_keyno" id="SQ_KEYNO_row${status.count }" value="${sq.SQ_KEYNO }">
													<div class='row'> 
													<section class="col col-2">
														<label class="input"> <i class="icon-prepend">No.</i> 
														<input type="text" class="sq_num" name="SQ_NUM_row${status.count }" value="${status.count }" readonly/>
														</label> 
													</section>
													<section class="col col-2">
														<label class="select">
														<select name="SQ_ST_TYPE" id="SQ_ST_TYPE_row${status.count }" onchange="pf_surveyTypeChange('_row${status.count}');">
															<option value="">문제 타입 선택</option>
															<option value="T" ${fn:trim(sq.SQ_ST_TYPE) eq 'T' ? 'selected' : '' }>주관식(텍스트박스)</option>
															<option value="R" ${fn:trim(sq.SQ_ST_TYPE) eq 'R' ? 'selected' : ''}>객관식(라디오)</option>
													 		<option value="C" ${fn:trim(sq.SQ_ST_TYPE) eq 'C' ? 'selected' : ''}>객관식(체크박스)</option>
														</select>
														<i></i>
														</label>
													</section>
													<section class="col col-8" style="height: 32px; line-height: 32px; vertical-align: middle;">
															<c:if test="${sq.SQ_ST_TYPE eq 'R' }">
															<a href="javascript:;" onclick="pf_addOption('_row${status.count }')" class="btn btn-info btn-xs">옵션추가</a> 
															</c:if>
															<span class='option_dp'>
															<a href="javascript:;" onclick="pf_addOption('_row${status.count }')" class="btn btn-info btn-xs">옵션추가</a> 
															</span>
															<a href="javascript:;" onclick="pf_columnDelete('_row${status.count }','${sq.SQ_KEYNO }')" class="btn btn-danger btn-xs" >삭제하기</a>
													</section>
													</div>
													
													<div class="row">
														<section class="col col-12">
															<label class="input"> <i class="icon-prepend ">Q</i>
																<input class="checkTrim" type="text" id="SQ_QUESTION_row${status.count }" name="SQ_QUESTION" value="${sq.SQ_QUESTION }" maxlength="200"  />
															</label>
														</section>
														<div id="optiondialog_append_row${status.count }" class="optiondialog_append_row">
															<div id="SQO_row${status.count }" class="sqo-column-row">
																<c:forEach items="${SQO }" var="sqo" varStatus="sqoc">
																	<c:if test="${sq.SQ_KEYNO == sqo.SQO_SQ_KEYNO }">
																		<div class="option" id="option_row${sqo.SQO_NUM}">
																			<input type="hidden" class="sqo_keyno" name="sqo_keyno" id="SQO_KEYNO_row${sqo.SQO_NUM }" value="${sqo.SQO_KEYNO }">
																			<span class="num">${sqo.SQO_NUM}</span>
																			<input type="text" class="sqo_option" name="sqo_option" id="SQ_OPTION_row${sqo.SQO_NUM }" value="${sqo.SQO_OPTION }" maxlength="250">
																			<span class="bogiscore">배점:<input type="number" class="sqo_value" name="sqo_value" id="SQ_VALUE_row${sqo.SQO_NUM }" value="${sqo.SQO_VALUE }" oninput="cf_maxLengthCheck(this)" max="999" maxlength="3"></span>
																			<button class="btn btn-xs btn-default" id="Board_Delete" type="button" onclick="pf_optionDel('_row${status.count }','_row${sqo.SQO_NUM }')"> 
																			<i class="fa  fa-times-circle"></i>
																			</button>
																		</div>
																	</c:if>
																</c:forEach>
															</div>
														</div>	
													</div>
												</div>
												
											</c:forEach>
										</fieldset>
									</div>
								</fieldset>
								<div class="text-right" style="padding: 20px;"> 
									<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_smUpdate()">	
										<i class="fa fa-floppy-o"></i> 설문지 수정
									</button>
									<button class="btn btn-sm btn-danger" id="Board_Edit"	type="button" onclick="pf_smDelete()">	
										<i class="fa fa-floppy-o"></i> 설문지 삭제
									</button>
									<button class="btn btn-sm btn-default" id="Board_Delete" type="button" onclick="pf_back()"> 
										<i class="fa fa-times"></i> 취소
									</button> 
								</div>
							</div>
						</div>
					</div>
				</article>
			</div>
		</section>
	</form:form>
</div>
<!-- <div id="optiondialog_append"> -->

<!-- </div> -->