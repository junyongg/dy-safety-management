<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- <link type="text/css" rel="stylesheet" href="/resources/jcia/css/board.css"> -->
<style>
</style>
<form:form id="Form" name ="Form" action="">
<div>	
	<select class="form-control input-sm" name="jspselect" id="jspselect" onchange="change123(this.value);">
	       	<c:forEach items="${result}" var="result">
				<option value="${result.PC_PI_KEYNO }">${result.PC_MAINKEY }</option>
			</c:forEach>						                
	</select>
</div>
<div id="show">
</div>
</form:form>
<script>

$(function() {
	change123("UI_JUN");
});

//링크확인
function pf_link(id){
	window.open($('#'+id).val())
}


function change123(value){
	
	$.ajax({
		url: "/sfa/safeAdmin/safefunAjax.do?${_csrf.parameterName}=${_csrf.token}",
		type: "post",
		data: {
			"PC_PI_KEYNO" : value
		},
		async: false,
		success : function(data){
			
			$("#show").html(data)
		}
		
	});
	
}


</script>