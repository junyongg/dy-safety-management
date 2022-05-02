<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<!-- 서브내용 시작 -->
	<section id="sub-content">
		<div class="inner1200"> <!--inner 시작 -->
			
			<!-- 서브 타이틀부분 -->
			<div class="sub-title-box">
				<h2>창작지원</h2>
				<ul class="list_ul">
					<li class="home"><i class="xi-home"></i></li>
					<li>사업안내</li>
					<li>창작지원</li>
				</ul>
			</div>
			


			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

				<!-- 사업안내 탭부분 -->
				<div class="tab-in-box">
					<ul class="tab_ul tab-2">
						<li class="active tab1"><a href="javascript:;" onclick="setTap(1)">지역문화 예술특성화지원</a></li>
						<li class="tab2"><a href="javascript:;" onclick="setTap(2)">공연장상주단체육성지원</a></li>
					</ul>
				</div>

				<!-- 사업안내 내용 부분 -->
				<div id="li1" class="sub-business-content">
					
					<div class="top-s-title">
						<ul>
							<li>문화예술창작지원사업</li>
							<li>지역문화 예술특성화지원 사업</li>
						</ul>
					</div>

					<div class="img-box">
						<img src="/resources/img/sub/img_s_busi_01_01.jpg" >
					</div>

					<div class="contents pdMore">
						
						<div class="one"> <!-- one -->
							<p class="title-num"><b>01</b> 지역문화예술육성지원사업</p>
							<div class="in">
								<p class="p-con">
									(전통예술) 전남의 전통문화를 소재로 하는 문화예술 활동(전통문화 보존, 육성, 창작 등) 지원<br>
									(시각·공연예술·문학) 단체(개인)의 시각·공연예술 및 문학활동 지원 <br>
									(문화예술연구) 전통문화예술 연구조사, 비평, 포럼 세미나 지원
								</p>
							</div>
						</div> <!-- one END -->

						<div class="one"> <!-- one -->
							<p class="title-num"><b>02</b> 문화예술해외교류지원사업</p>
							<div class="in">
								<p class="p-con">
									해외 또는 도내에서 진행되는 해외 국가(지역)와의 교류공연 및 교류전시 등 지원
								</p>
							</div>
						</div> <!-- one END -->
						
						<div class="one"> <!-- one -->
							<p class="title-num"><b>03</b> 공연예술작품제작지원사업</p>
							<div class="in">
								<p class="p-con">
									지역의 역사·문화자원 등을 활용한 창작공연 제작 · 발표 지원
								</p>
							</div>
						</div> <!-- one END -->
						
						<div class="one"> <!-- one -->
							<p class="title-num"><b>04</b> 공간연계형창작지원사업</p>
							<div class="in">
								<p class="p-con">
									창작, 소통, 향유 시스템을 통한 예술가 레지던스 프로그램 운영 및
									지역 신진예술가 발굴, 육성 및 교류 지원
								</p>
							</div>
						</div> <!-- one END -->
						
						<div class="one"> <!-- one -->
							<p class="title-num"><b>05</b> 남도문예르네상스기획사업</p>
							<div class="in">
								<p class="p-con">
									남도문예르네상스 비교우위자원을 소재로 하는 기획 사업을 발굴하여 전남만의 특화된 브랜드 개발 지원
								</p>
								<ul class="dot-ul-1 sm">
									<li>기획발굴(1단계) : 사업 기획활동(자료조사 등), 시범사업 수행</li>
									<li>사업실연(2단계) : 기획사업 수행 및 성과 확산 </li>
								</ul>
							</div>
						</div> <!-- one END -->
						
						<div class="one"> <!-- one -->
							<p class="title-num"><b>06</b> 청년예술가활동지원사업</p>
							<div class="in">
								<p class="p-con">
									청년 예술가의 창작 문화예술 활동 지원
								</p>
								<ul class="dot-ul-1 sm">
									<li>창작준비(1년차) : 창작준비 및 역량강화</li>
									<li>창작발표(2년차) : 창작활동·발표 및 역량강화</li>
								</ul>
							</div>
						</div> <!-- one END -->
						
						<div class="one"> <!-- one -->
							<p class="title-num"><b>07</b> 주민밀착형문화예술지원사업</p>
							<div class="in">
								<p class="p-con">
									전남의 지역여건과 문화적 특성을 반영한 주민밀착, 주민주도형 프로그램 지원
								</p>
							</div>
						</div> <!-- one END -->

					</div>


				</div>
				<!-- 사업안내 내용 부분 끝!!! -->
				<!-- 사업안내 내용 부분 -->
				<div id="li2" class="sub-business-content" style="display: none;">
					
					<div class="top-s-title">
						<ul>
							<li>문화예술창작지원사업</li>
							<li>공연장상주단체육성지원</li>
						</ul>
					</div>

					<div class="img-box">
						<img src="/resources/img/sub/img_s_busi_01_02.jpg" >
					</div>

					<div class="contents">
						
						<div class="one"> <!-- one -->
							<p class="title-line">사업개요</p>
							<ul class="nor-ul">
								<li>
									<b>기간/장소 :</b> ’19. 1. ~ 12.(12개월) / 도내 일원(공공 공연장)
								</li>
								<li>
									<b>사업비 :</b> 766백만원(국비 383, 도비 383) 
								</li>
								<li>
									<b>사업목적 :</b> 공연예술단체와 공연장 간 상생협력을 통한 창작역량 강화, 공연장 활성화 도모 및 지역주민 문화향수 기회 확대
								</li>
								<li>
									<b>지원대상 :</b> 전남소재 공공 공연장과 협약한 공연예술단체
								</li>
								<li>
									<b>지원규모 :</b> 상주단체 당 최소 80 ~ 200백만원 
								</li>
								<li>
									<b>지원내용 :</b> 창작 초연(1작품) 및 레퍼토리*(2작품) 공연, 상주사업을 위한 퍼블릭**(1회 이상) 프로그램 및 필수 경비 등 지원
								</li>
							</ul>							
						</div> <!-- one END -->

						
						<div class="one white"> <!-- one -->
							<p class="title-line">공모절차</p>
							<p class="sub-title1">상주단체가 주체가 되어 공연장과 사전 협약(MOU)체결 → 상주단체가 지원신청서 제출 → 상주단체 대상 심의 후 지원대상 및 지원금액 결정</p>

							<div class="table-box table_wrap_mobile">
								<table class="tbl_business">
									<caption>공모절차 테이블</caption>
									<colgroup>
										<col width="10%">
										<col width="30%">
										<col width="60%">
									</colgroup>
									<thead>
										<tr>
											<th colspan="2">구분</th>
											<th>사업내용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td rowspan="4">필수<br>프로<br>그램</td>
											<td>
												창작초연작품 개발 <br>
												(1작품)
											</td>
											<td class="txt">
												<b>[연극·무용]</b> : 창작초연(60분이상) 1편<br>
												<b>[음악]</b> : 창작초연(극, 음악 등 대작 1편 또는 단편 곡 각 5분 이상 6곡-30분)<br>
												<span class="purple-c">※ 지역의 인물·역사ㆍ문화자원 등을 활용하여 제작된 초연 창작작품에 한함</span>
											</td>
										</tr>
										<tr>
											<td class="b-l">
												레퍼토리공연
												(2작품)
											</td>
											<td class="txt">
												연중 단체의 레퍼토리 2작품 이상 공연 추진<br>
												<span class="purple-c">※1회에 한해 타지역 포함하여 단체 간 교류사업 가능</span>
											</td>
										</tr>
										<tr>
											<td class="b-l">
												퍼블릭 프로그램
											</td>
											<td class="txt">
												<p class="s-t">주민 참여형 문화예술 프로그램으로 진행</p>
												교육 : 지역민을 위한 예술 교육 프로그램<br>
												문화나눔 : 소외계층을 위한 각종 프로그램<br>
											</td>
										</tr>
										<tr>
											<td class="b-l">
												상주단체 간 <br>
												교류·협력사업
											</td>
											<td class="txt">
												상주단체 합동공연 또는 상주단체 페스티벌(통합 발표회) <br>참여로 교류·협력 확대 및 국민 문화향유기회 확대 사업 추진
											</td>
										</tr>
										<tr>
											<td colspan="2">
												권장프로그램
											</td>
											<td class="txt">
												<p class="s-t">단체 조직역량 강화</p>
												상주단체 단원의 예술적 역량 강화 프로그램
												공연장 및 상주단체 관계자 조직운영(기획, 홍보, 마케팅, 회계 등) 역량 강화 프로그램 운영
											</td>
										</tr>
									</tbody>
								</table>
							</div>

						</div> <!-- one END -->

					</div>


				</div>
				<!-- 사업안내 내용 부분 끝!!! -->

			</div>
            <!-- 서브컨텐츠1 끝!!!! -->




			
			<script>
			
			function setTap(tapId){
					
                    var li1 = document.getElementById('li1');
                    var li2 = document.getElementById('li2');

				if(tapId == 1){
				 $('.tab1').addClass('active');
                    $('.tab2').removeClass('active');
                    
                   $(li1).show();
                    $(li2).hide();
                    
				}else{
					 $('.tab1').removeClass('active');
                    $('.tab2').addClass('active');
                    
                   $(li1).hide();
                    $(li2).show();
				}
			}
			</script>	

		</div> <!--inner 끝 -->
	</section>