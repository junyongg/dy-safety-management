<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<div class="inner1200">

<form:form id="PageForm" >
	<fmt:parseNumber value="${fn:substring(currentMenu.MN_KEYNO,4,20)}" var="menuKey"/>
	<input type="hidden" name="TPS_MN_KEYNO" id="TPS_MN_KEYNO" value="${menuKey}"/>
	<input type="hidden" name="TPS_SCORE_NAME" id="TPS_SCORE_NAME"/>
	<c:set value="${(not empty currentMenu.MN_DU_KEYNO && currentMenu.MN_DU_KEYNO eq 'DU_0000000000') ? currentMenu.MN_MANAGER_DEP : currentMenu.PAGE_DEPARTMENT}" var="MANAGER_DEP"/>
	<c:set value="${(not empty currentMenu.MN_DU_KEYNO && currentMenu.MN_DU_KEYNO eq 'DU_0000000000') ? currentMenu.MN_MANAGER : currentMenu.PAGE_NAME }" var="MANAGER"/>
	<c:set value="${(not empty currentMenu.MN_DU_KEYNO && currentMenu.MN_DU_KEYNO eq 'DU_0000000000') ? currentMenu.MN_MANAGER_TEL : currentMenu.PAGE_TEL }" var="MANAGER_TEL"/>
	
	<article id="pageChk_Mod" style="
    margin-bottom: 100px;
    margin-top: -55px;">
				<div class="left">
					<p class="tit">이 페이지의 콘텐츠 안내 및 정보 제공에 만족하십니까?</p>
					<div class="star">
						<label>
							<input type="radio" name="TPS_SCORE" value="5">
							<span>
								<img src="/resources/img/icon/icon_goldStar5.png" alt="페이지 평가 별5개중 5개">
							</span>
						</label>

						<label>
							<input type="radio" name="TPS_SCORE" value="4"> 
							<span>
								<img src="/resources/img/icon/icon_goldStar4.png" alt="페이지 평가 별5개중 4개">
							</span>
						</label>

						<label>
							<input type="radio" name="TPS_SCORE" value="3"> 
							<span>
								<img src="/resources/img/icon/icon_goldStar3.png" alt="페이지 평가 별5개중 3개">
							</span>
						</label>

						<label>
							<input type="radio" name="TPS_SCORE" value="2"> 
							<span>
								<img src="/resources/img/icon/icon_goldStar2.png" alt="페이지 평가 별5개중 2개">
							</span>
						</label>

						<label>
							<input type="radio" name="TPS_SCORE" value="1"> 
							<span>
								<img src="/resources/img/icon/icon_goldStar.png" alt="페이지 평가 별5개중 1개">
							</span>
						</label>
					</div>
					<button type="button" class="btn-e-sum1" onclick="pf_insert()">제출</button>
				</div>

				<div class="right">
					<button type="button" class="btn-e-result1" onclick="surveyResultShow()">결과보기</button>
					
					
					<!-- 만족도 조사결과 -->
					<div class="survey-result-b-box">
						<div class="title-b">
							<p class="left">만족도 조사결과</p>
							<p class="right"><button type="button" onclick="surveyResultHide()"><i class="xi-close-thin"></i></button></p>
						</div>
						<div class="content-b">
<!-- 							<h3>대표이사인사 페이지</h3> -->
							<div class="tbl-box">
								<table class="tbl_in_re">
									<caption>만족도 조사 결과</caption>
									<colgroup>
										<col width="33.33%">
										<col width="33.33%">
										<col width="33.33%">
									</colgroup>
									<tbody>
									
										<tr>
											<th>매우만족</th>
											<td>${tps_scores.SCORE5 }</td>
											<td>${tps_scores.SCORE_DATA5 }%</td>
										</tr>
										<tr>
											<th>만족</th>
											<td>${tps_scores.SCORE4 }</td>
											<td>${tps_scores.SCORE_DATA4 }%</td>
										</tr>
										<tr>
											<th>보통</th>
											<td>${tps_scores.SCORE3 }</td>
											<td>${tps_scores.SCORE_DATA3 }%</td>
										</tr>
										<tr>
											<th>불만족</th>
											<td>${tps_scores.SCORE2 }</td>
											<td>${tps_scores.SCORE_DATA2 }%</td>
										</tr>
										<tr>
											<th>매우불만족</th>
											<td>${tps_scores.SCORE1 }</td>
											<td>${tps_scores.SCORE_DATA1 }%</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>	
			</article>
</form:form>


</div>

<script>
function pf_insert(){
	var checkval = $("input[type=radio][name=TPS_SCORE]:checked").val()
	if(checkval == "5")
		$("#TPS_SCORE_NAME").val("매우만족");
	if(checkval == "4")
		$("#TPS_SCORE_NAME").val("만족");
	if(checkval == "3")
		$("#TPS_SCORE_NAME").val("보통");
	if(checkval == "2")
		$("#TPS_SCORE_NAME").val("불만족");
	if(checkval == "1")
		$("#TPS_SCORE_NAME").val("매우불만족");
	
	var menu = $("#TPS_MN_KEYNO").val();
	var satisfaction = $("input[name=TPS_SCORE]:radio:checked").val();
	if(!satisfaction){
		alert("만족도를 선택하세요.");
		return false;
	}

	$.ajax({
	    type   : "POST",
	    url    : "/common/page/satisfaction/satisfactionInsert.do",
	    data   : $("#PageForm").serialize(),
	    async:false,
	    success:function(result){
// 	    	$("input:radio[name='TPS_SCORE']").removeAttr('checked');
	    	$(".textAreaHealing").val("");
	    	if(result == 1){
	    		alert("평가가 완료되었습니다.");
	    		window.location.reload();
// 	    		$("input[type=radio][name=TPS_SCORE][value='5']").prop('checked',true);
	    	}else if(result == 0){
	    		alert("평가는 하루에 한번씩만 가능합니다.");
	    	}
	    },
	    error: function() {
	    	alert("에러, 관리자에게 문의하세요.");
	    }
	});

}
</script>