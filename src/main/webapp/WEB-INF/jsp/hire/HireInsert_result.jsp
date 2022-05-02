<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<form:form id="form" action="" method="post">
<section id="sub-content">
	<input type="hidden" name="THC_KEYNO" id="THC_KEYNO" value="${hirecontentDTO.THC_KEYNO}">
	<input type="hidden" name="TH_KEYNO" id="TH_KEYNO" value="${hirecontentDTO.THC_USERKEY}">
	<input type="hidden" name="BN_DATE" id="BN_DATE" value="${bndate.BN_REGDT}">
	<input type="hidden" name="BN_TITLE" id="BN_TITLE" value="${bndate.BN_TITLE}">
	<input type="hidden" name="BN_KEYNO" id="BN_KEYNO" value="${hire.TH_BNKEYNO}">
        <div class="inner1200"> <!--inner 시작 -->
            
            <!-- 서브 타이틀부분 -->
            <div class="sub-title-box">
                <h2>지원서 작성</h2>
                <ul class="list_ul">
                    <li class="home"><i class="xi-home"></i></li>
                    <li>열린광장</li>
                    <li>채용공고</li>
                    <li>지원서 작성</li>
				</ul>
            </div>


			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

                <!-- 지원서 작성 탑 부분 탭 -->
                <div class="employ_tab_box">
					<ul class="employ_tab_ul">
						<li class="active">
							<span class="icon n01"></span>
							<span class="txt">약관동의 및 기본정보입력</span>
						</li>
						<li class="active">
							<span class="icon n02"></span>
							<span class="txt">지원서&amp;자기소개서 입력</span>
						</li>
						<li class="active">
							<span class="icon n03"></span>
							<span class="txt">최종제출</span>
						</li>
					</ul>
				</div>
                <!-- // 지원서 작성 탑 부분 탭 -->

				<!-- 지원서 제출 -->
				<div class="employ_submission_box">
					<div class="icon_box"><img src="resources/img/sub/icon_employ_last.png" alt=""></div>
					<div class="txt_box">
						<h2>${hirecontentDTO.THC_NAME }님 지원서가 <b>제출</b>되었습니다.</h2>
					</div>
					<div class="txt2_box">
						<div class="p_bol">
							※ 서류심사 기간 전까지 지원서를 수정 하실 수 있습니다.<br>
							※ 입사지원서류 작성 시 기재착오, 내용누락으로 인한 불이익은 지원자 본인의 책임이므로 유의하여 작성하시기 바랍니다.<br>
							<span class="gray">(허위 내용 또는 결격사유 발생시 언제든지 합격 또는 취소됨을 안내드립니다.)</span>
						</div>
					</div>
				</div>
				<!-- // 지원서 제출 -->

				<div class="gab50"></div>

				<div class="textC">
					<button type="button" class="btn_support purple" title="지원서 수정" onclick="loginPage()">지원서 수정</button>
					<button type="button" class="btn_support purple" title="응시표 출력" onclick="PrintPage()">응시표 출력</button>
					<button type="button" class="btn_support gray" onclick="location.href='/jact/open/hire.do'" title="홈으로">홈으로</button>
				</div>
				
				<!-- // 약관동의 -->


            </div>

		</div> <!--inner 끝 -->
	</section>
</form:form>
	
<script>
	function loginPage(){
		$("#form").attr('action','/jact/hire/login.do');
		$("#form").submit();
	}
	
	function PrintPage(){
		$("#form").attr('action','/jact/hire/printPage.do');
		$("#form").submit();
	}
</script>