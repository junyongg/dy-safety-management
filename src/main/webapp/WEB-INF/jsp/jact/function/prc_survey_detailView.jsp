<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script type="text/javascript">

$(function(){
// 	pf_AddColumn();
})

var survey_sum = 0;

//게시판 타입 등록 처리 및 입력 폼 체크
function pf_surveyInsert(){
	
	if(valcheck()){
		if(confirm("설문결과를  등록하시겠습니까?")){
			success();
		}else{
			exit();
		}
	}
}

function pf_back(){
	location.href="/cf/function/servey.do";
}

//성공 콜백 함수   
function success() {
	$("#Form").attr("action", "/cf/function/servey/insert.do");
	$("#Form").submit();
}

//실패 콜백 함수   
function exit() {
	alert("취소되었습니다.");
	return false;
}

// 주관식 결과 데이터 담기
function pf_dataInput(sqID){
	var data = $("#SQ_DATA_"+sqID).val();
	$("#SQ_OPTION_DATA_"+sqID).val(data)
}

// 보기 결과 데이터 담기
function pf_optionRadioClick(sqID,sqo_keyno,sqo_value){
	var data = sqo_keyno+":"+sqo_value;
	$("#SQ_OPTION_DATA_"+sqID).val(data)
	survey_sum
}

// 보기 결과 데이터 담기
function pf_optionCheckBoxClick(sqID,sqo_keyno,sqo_value){
	var arr = [];
    var data= "";
    $.each($('input[name=SQO_OPTION_1]'),function(k,v){
    	if($(this).prop("checked")){
		   	 arr[arr.length] = $(v).val();
    	} 
    })
	$("#SQ_OPTION_DATA_"+sqID).val(arr)
	survey_sum
}

// 보기 문항 선택 체크
function valcheck(){
	var bool = true;
	var lang = ${fn:length(sq_list)};
	for(var i = 1; i<=lang; i++){
	var type = $("#SQ_ST_TYPE_"+i).val();
		if(type == 'T'){
			if($("#SQ_DATA_"+i).val()==""){
				alert("주관식 내용을 모두 작성해 주세요");
				$("#SQ_DATA_"+i).focus();
	 			bool = false;
	 			return false;
			}
		}else if(type == 'R' || type == 'C'){
			if(!$("input[name='SQO_OPTION_"+i+"']").is(':checked')){
				alert("객관식 내용을 모두 작성해 주세요");
				$("input[name='SQO_OPTION_"+i+"']").eq(0).focus();
	 			bool = false;
	 			return false;
			}
		}
	}
	return true;
}

</script>
<style>
.sq_row{margin-bottom: 25px;}
.sqo_row{margin: 5px 0px 0px 15px;}
.sqo_row textarea{width:100%}
.sq_main {margin-top:30px;}
</style>



<form:form id="Form" name="Form" method="post" action="">
	<input type="hidden" id="SM_KEYNO" name="SM_KEYNO" value="${SmDTO.SM_KEYNO }"/>
	<input type="hidden" id="SM_IDYN" name="SM_IDYN" value="${SmDTO.SM_IDYN }"/>
	<h2>${SmDTO.SM_TITLE }</h2>
	<br>
					
	<p>설문기간 : ${SmDTO.SM_STARTDT } ~ ${SmDTO.SM_ENDDT }</p><br>
	<c:if test="${SmDTO.SM_IDYN eq 'Y' }">
	<p>작성자 : ${userInfo.UI_ID }</p>
	</c:if>
	<p>설명 : 
	<pre style="padding-left:20px;">${SmDTO.SM_EXP }</pre>
	</p>
	
	
	<div class="sq_main">
		<c:forEach items="${sq_list }" var="sq" varStatus="sqc">
			<div class="sq_row">
				<input type="hidden" name="SQ_KEYNO" value="${sq.SQ_KEYNO }">
				<input type="hidden" name="SQ_ST_TYPE" id="SQ_ST_TYPE_${sqc.count }" value="${sq.SQ_ST_TYPE }">
				<input type="hidden" name="SQ_OPTION_DATA" id="SQ_OPTION_DATA_${sqc.count }" >
				<span>${sq.SQ_NUM }</span>. <span>${sq.SQ_QUESTION }</span><br>
				
				<div class="sqo_main">
					<c:if test="${sq.SQ_ST_TYPE eq 'T' }">
						<div class="sqo_row">
							<textarea name="SQ_DATA" id="SQ_DATA_${sqc.count }" onchange="pf_dataInput('${sqc.count }')"  rows="3"></textarea>
						</div>
					</c:if>
					<c:if test="${sq.SQ_ST_TYPE eq 'R' }">
						<div class="inline-group">
							<c:forEach items="${sqo_list }" var="sqo" varStatus="sqoc">
								<c:if test="${sq.SQ_KEYNO eq sqo.SQO_SQ_KEYNO }">
									<div class="sqo_row">
										<label class="radio">
										<input type="radio" name="SQO_OPTION_${sqc.count }" id="SQO_OPTION_${sqc.count }:${sqoc.count}"
												value="${sqo.SQO_KEYNO }:${sqo.SQO_VALUE}" onclick="pf_optionRadioClick('${sqc.count }','${sqo.SQO_KEYNO }','${sqo.SQO_VALUE}')">
										<i></i>${sqo.SQO_NUM}.${sqo.SQO_OPTION }
										</label> 
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
					<c:if test="${sq.SQ_ST_TYPE eq 'C' }">
						<div class="inline-group">
							<c:forEach items="${sqo_list }" var="sqo" varStatus="sqoc">
								<c:if test="${sq.SQ_KEYNO eq sqo.SQO_SQ_KEYNO }">
									<div class="sqo_row">
										<label class="checkbox">
										<input type="checkbox" name="SQO_OPTION_${sqc.count }" id="SQO_OPTION_${sqc.count }:${sqoc.count}"
												value="${sqo.SQO_KEYNO }:${sqo.SQO_VALUE}" onclick="pf_optionCheckBoxClick('${sqc.count }','${sqo.SQO_KEYNO }','${sqo.SQO_VALUE}')">
										<i></i>${sqo.SQO_NUM}.${sqo.SQO_OPTION }
										</label> 
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</div>
		
	<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_surveyInsert()">	
		 설문 결과 전송
	</button>
	<button class="btn btn-sm btn-default" id="Board_Delete" type="button" onclick="pf_back()"> 
		 설문 작성 취소
	</button> 
</form:form>
