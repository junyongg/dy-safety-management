<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<section id="sub-content">
		<div class="inner1200"> <!--inner 시작 -->
			
			<!-- 서브 타이틀부분 -->
			<div class="sub-title-box">
				<h2>지표조사</h2>
				<ul class="list_ul">
					<li class="home"><i class="xi-home"></i></li>
					<li>조사의뢰안내</li>
					<li>지표조사</li>
				</ul>
			</div>
			


			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

				<!-- 탭부분 -->
				<div class="tab-in-box">
					<ul class="tab_ul tab-3">
						<li class="active"><a href="/culture/Guid/indi.do">지표조사</a></li>
						<li><a href="/culture/Guid/exca.do">발굴조사</a></li>
						<li><a href="/culture/Guid/institution.do">소규모 발굴 및 지표조사 지원제도</a></li>
					</ul>
				</div>
				

				<div class="lab_in_con_box sub_survey_info">
					
					<div class="gray_box">
						<p>
							지표조사는 일정한 지역 안에 유적ㆍ유물이 있는지 없는지, 있다면 얼마나 어떻게 분포되어 있는지를 그 지역의 지형을 훼손시키지 않고 확인하는 조사방법이다. 지표상에 드러난 유적ㆍ유물은 조사지역 유적들이 어떤 성격인지 판단할 수 있는 기준이 되기 때문입니다. 
						</p>
					</div>
					

					<p class="sub-in-yellow-title">지표조사의 대상(매장문화재 보호 및 조사에 관한 법률 제 7조 제 3항)</p>
					<div class="in">
						<p class="sub_in_tx">
							지형변경을 수반하는 3만제곱미터 이상의 공사 또는 문화재 분포 가능성이 예상되며 해당 지방 자치단체장이 조사하여야 할 것으로 결정한 공사가 <br>해당된다. 
						</p>
					</div>


					<div class="gab40"></div>


					<p class="sub-in-yellow-title">지표조사의 대상(매장문화재 보호 및 조사에 관한 법률 제 7조 제 3항)</p>
					<div class="in">
						<p class="sub_in_tx">
							지표에 드러난 문화재 또는 매장문화재의 징후를 지형을 훼손시키지 않는 채 조사, 해당지역의 문화재 존재 여부 및 그 성격을 확인하는 행위
						</p>

						<div class="img-box2">
							<img src="/resources/culture/img/sub/img_sub_survey_01.png" alt="지표조사 도표">
						</div>

						<ul class="dot-ul-1">
							<li>사업계획에 포함된 부지 전체 사업면적 3만 제곱미터 이상의 건설공사</li>
							<li>지방자치단체장(또는 관할지역 지방자치단체의 장)이 지표조사 인 허가를 명하는 건설공사</li>
							<li>문화재보호법 시행일 이전부터 추진 중이거나 시행 중인 사업</li>
							<li>타 법령 등에 의해 지표조사를 실시하도록 한 사업</li>
						</ul>
					</div>

					<div class="gab40"></div>

					<p class="sub-in-yellow-title">조사비용의 산출</p>
					<div class="in">
						<p class="sub_in_tx">
							조사용역 대가의 기준을 토대로 조사기관에서 산출하며, 사업시행자와 조사기관간의 용역계약에 의해 결정된다. 발굴비용은 유적의 성격에 따라 차이가 있으며, 세부사항은 조사기관과 협의하여야 한다. 
						</p>						
					</div>

					<div class="gab40"></div>

					<p class="sub-in-yellow-title">지표조사 의뢰</p>
					<div class="in">
						<p class="sub_in_tx">
							조사기관이 선정되면 조사지역의 위치도 및 세부평면도(1/5,000이상), 사업개요를 첨부하여 문서에 의한 조사의뢰를 하면 조속히 처리된다.
						</p>

						<button type="button" class="btn-surDown" onclick=" file_download('img/upload/download/investigation.hwp','investigation.hwp')">
							<span class="txt">문화재 지표조사 의뢰서</span>
							<span class="down">DOWNLOAD</span>
						</button>
					</div>

					<div class="gab40"></div>

					<p class="sub-in-yellow-title">참고</p>
					<div class="in">
						<p class="sub_in_tx">
							자세한 사항은 다음의 지표조사의 방법 및 절차 등에 관한 규정을 참고하면 된다.
						</p>

						<button type="button" class="btn-surDown" onclick=" file_download('img/upload/download/investigation2.hwp','investigation2.hwp')">
							<span class="txt">지표조사의 방법 및 절차 등에 관한 규정</span>
							<span class="down">DOWNLOAD</span>
						</button>
					</div>
					

				</div>


			</div>
			<!-- 서브컨텐츠 끝!!!! -->



		</div> <!--inner 끝 -->
	</section>
	
	
<script>
function file_download(path,name){
    location.href="/async/file/download.do?filepath="+path+"&filename="+name;
}

</script>