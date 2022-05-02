<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<section id="sub-content">
		<div class="inner1200"> <!--inner 시작 -->
			
			<!-- 서브 타이틀부분 -->
			<div class="sub-title-box">
				<h2>연구소소개</h2>
				<ul class="list_ul">
					<li class="home"><i class="xi-home"></i></li>
					<li>연구소소개</li>
					<li>연구소소개</li>
				</ul>
			</div>
			
			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

				<!-- 탭부분 -->
				<div class="tab-in-box">
					<ul class="tab_ul tab-2">
						<li class="active"><a href="/culture/intro/introduce.do">연구소소개</a></li>
						<li><a href="/culture/intro/goal.do">설립목적 및 연혁</a></li>
					</ul>
				</div>
				

				<div class="lab_in_con_box lab_intro_box">
					
					<div class="txt-b">
						<h2>전남 문화유산의 가치를 키우겠습니다.</h2>
						<h5>
							저희 전남문화재연구소는 문화재 보존・보호의 효율적 수행을 위한 조사・연구기관으로 문화유산에 대한 실질적인 가치 창조를 도모하고자 설립되었습니다. 전남의 역사와 문화유산을 연구하고, 보존하며, 우리 지역의 문화적 특성과 정체성을 정립함으로써 도민들이 자긍심을 느끼도록 자료를 제공하는 연구기관입니다.  또한 전통문화 선양, 문화유산 애호, 문화컨텐츠 개발, 성실한 조사연구 등 매장문화재 조사와 연구를 주요 업무로 하고 있습니다. <br>
							문화재연구소는 철저한 현장조사, 확실한 자료화, 분석력 높은 보고서 발간 등 각자 전문분야를 업무를 충실히 수행하여 우리의 고대문화를 복원하고 지켜나가는 파수꾼의 역할을 다하겠습니다. 직원 일동은 전남의 역사와 문화유산을 지키고 연구하며 교육, 홍보를 통해 남도의 문화 등불을 환히 밝힐 수 있도록 노력하겠습니다.
							 <br> <br>
							감사합니다.
						</h5>
						<div class="btn-b">
							<button type="button" class="btn-more" onclick="show_intro('on')">연구원 소개</button>
						</div>
					</div>
					
					<div class="img-box">
						<div class="img-b"><img src="/resources/culture/img/sub/img_intro_01.jpg" alt="함평 금산리 방대형 고분 앞에서"></div>
						<p class="sub-txt">2014.김병택, 함평 금산리 방대형 고분 앞에서</p>
					</div>

				</div>
			</div>
			<!-- 서브컨텐츠 끝!!!! -->
<style>
 .title {display: block; font-size: 30px; color: #000; font-weight: bold;}
 table {border-collapse:collapse; border:1px solid #ddd;}
 table th, table td {padding:0 10px; border:1px solid #ddd}
 thead th {padding: 15px 20px; background: #f8f8f8; font-size: 14px; font-weight: 700; border-top: 1px solid #6093f0; color: #000;}
 tbody td {text-align: center; line-height: 35px; background: #fff; font-size:14px;}
 
 .intro_popup {position: absolute; top: calc(50% - 255px); left: calc(50% - 255px);width: 620px; height: 700px; border: 1px solid #ddd; z-index: 9100;background-color: #fff }
 .table_intro tr td {padding : 10px 20px};
 

 
 </style>
   
   
   
<div class="intro_popup" style="display: none">
<div class="title_121" style="
    margin-top: 35px;
    margin-left: 20px;
"> 문화재연구소 연구원 소개 </div>
  
  <div class="table_wrap_mobile">
  	<table align="center" width="92%" summary="연구원 조직표" style="margin-top: 18px;margin-left:23px;" class="table_intro">
	 <caption class="bind">연구원 조직표</caption> 
	<thead>
		<tr>
			<th>직위</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>e-mail</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>조사단장</td>
			<td>이범기</td>
			<td>061-287-6802</td>
			<td>baumki@jact.or.kr</td>
		</tr>
		<tr>
			<td>책임연구원</td>
			<td>곽명숙</td>
			<td>061-287-6803</td>
			<td>msmemory@jact.or.kr</td>
		</tr>
		<tr>
			<td>선임연구원</td>
			<td>송장선</td>
			<td>061-287-6804</td>
			<td>sjs5854@jact.or.kr</td>
		</tr>
		
		<tr>
			<td>연구원</td>
			<td>이수경</td>
			<td>061-287-6806</td>
			<td>dream3713@jact.or.kr</td>
		</tr>
		<tr>
			<td>연구원</td>
			<td>문종명</td>
			<td>061-287-6808</td>
			<td>malandro77@jact.or.kr</td>
		</tr>
		<tr>
			<td>연구원</td>
			<td>이경민</td>
			<td>061-287-6809</td>
			<td>wldus071646@jact.or.kr</td>
		</tr>
		<tr>
			<td>연구원</td>
			<td>박홍준</td>
			<td>061-287-6807</td>
			<td>phjkhj73@jact.or.kr</td>
		</tr>
		<tr>
			<td>연구원</td>
			<td>김경애</td>
			<td>061-287-6810</td>
			<td>kka2028@jact.or.kr</td>
		</tr>
	</tbody>
   </table>
  </div>
   <div class="lab_intro_box">
   		<div class="txt-b">
   			<div class="btn-b textC">
				<button type="button" class="btn-more" style=" margin-top: 16px; margin-right: 246px;" onclick="show_intro('off')">닫기</button>
			</div>		
   		</div>
   </div>
</div>
		</div> <!--inner 끝 -->
	</section>
	
<script>
function show_intro(on){
	if(on == "on"){
		$(".intro_popup").show();	
	}else{
		$(".intro_popup").hide();
	}
	
}


</script>