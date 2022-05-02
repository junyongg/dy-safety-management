<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<section id="sub-content">
		<div class="inner1200"> <!--inner 시작 -->
			
			<!-- 서브 타이틀부분 -->
			<div class="sub-title-box">
				<h2>조직 및 직원소개</h2>
				<ul class="list_ul">
					<li class="home"><i class="xi-home"></i></li>
					<li>재단소개</li>
					<li>조직 및 직원소개</li>
				</ul>
			</div>
			


			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">
				
				<!-- 조직 및 직원소개 -->
				<div class="sub-vision-wrap">
					
					<p class="sub-in-yellow-title">조직도 <span class="sm">(기준:2020.7.)</span></p>
                  
                  
                  <!-- 조직도 -->
                <ul class="organization-box">
						
						<li class="one-top">
							<a href="javascript:;">이사장</a>
						</li>
						
						<li class="two-row">
							<div class="md-name orange">
								<a href="javascript:;">이사회</a>
							</div>
							<div class="md-name orange">
								<a href="javascript:;">감사</a>
							</div>
						</li>

						<li class="md-name blue">
							<a href="#aco1" onclick="btnEvent('aco1')">대표이사</a>
						</li>

						<ul class="md-name rb yellow">
							<li>
								<a href="#aco10" onclick="btnEvent('aco10')">국제수묵 비엔날레 사무국</a>
							</li>	
							<li>
								*정원 외 조직
							</li>
							
						</ul>
						<ul class="md-name green">
							<li class="mobile_loca"><a href="javascript:;">사무국장</a></li>
							<li class="box-size"><a href="javascript:;">총감독</a></li>
							
							<div class="green-md-name">
							<ul>
                           <li class="pp"><a href="javascript:;">기획부장</a>
                              <ul>
                                 <li><a href="#aco11" onclick="btnEvent('aco11')">기획<br>총무팀</a></li>
                                 <li><a href="#aco12" onclick="btnEvent('aco12')">홍보팀</a></li>
                                 
                              </ul>
                           </li>      
                           <li class="pp"><a href="javascript:;">운영부장</a>
                              <ul class="operation_wrap">
                                 <li><a href="#aco14" onclick="btnEvent('aco14')">전시<br>기획팀</a></li>   
                                  <li><a href="#aco13" onclick="btnEvent('aco13')">행사<br>운영팀</a></li>   
                                    
                              </ul>
                           </li>
                        </ul>
							</div>
						</ul>
						
							
						<ul class="mobile-main">
							<li class="md-name navy">
								<a href="#aco2" onclick="btnEvent('aco2')">사무처장</a>
							</li>

							<li class="sub-list-box">
								<ul>
									<li><a href="#aco3" onclick="btnEvent('aco3')">기획 <br>경영팀</a></li>
									<li><a href="#aco4" onclick="btnEvent('aco4')">문화 <br>사업팀</a></li>
									<li><a href="#aco5" onclick="btnEvent('aco5')">문화예술 <br>교육팀</a></li>
									<li><a href="#aco6" onclick="btnEvent('aco6')">공연예술 <br>진흥팀</a></li>
									<li><a href="#aco7" onclick="btnEvent('aco7')">문화재 <br>연구소</a></li>
									<!--<li><a href="javascript:;">관광 <br>마케팅팀</a></li>
									<li><a href="javascript:;">관광연구 <br>개발팀</a></li>-->
								</ul>
							</li>
						</ul>

					</ul>

					<!-- 조직도
					<div class="organization-box">
						
						<div class="one-top">
		                                     <a href="javascript:;" title="이사장">이사장</a>
						</div>

                                                <div class="two-row">
						        <div class="md-name orange">
							        <a href="javascript:;" title="이사회">이사회</a>
						        </div>
							<div class="md-name orange">
								<a href="javascript:;" title="감사">감사</a>
							</div>
						</div>

						<div class="md-name blue">
							<a href="#aco1" onclick="btnEvent('aco1')" title="대표이사">대표이사</a>
						</div>

						<div class="md-name rb yellow">
							<a href="#aco10" onclick="btnEvent('aco10')" title="국제수묵 비엔날레 사무국">국제수묵 비엔날레 사무국</a>
						</div>
						<ul class="md-namein-ul">
							<li><a href="javascript:;">* 정원 외 조직</a></li>
						</ul>

						<div class="md-name navy">
							<a href="#aco2" onclick="btnEvent('aco2')" title="사무처장">사무처장</a>
						</div>

						<div class="sub-list-box">
							<ul>
								<li><a href="#aco3" onclick="btnEvent('aco3')" title="기획경영팀">기획 <br>경영팀</a></li>
								<li><a href="#aco4" onclick="btnEvent('aco4')" title="문화사업팀">문화 <br>사업팀</a></li>
								<li><a href="#aco5" onclick="btnEvent('aco5')" title="문화예술교육팀">문화예술 <br>교육팀</a></li>
								<li><a href="#aco6" onclick="btnEvent('aco6')" title="공연예술진흥팀">공연예술 <br>진흥팀</a></li>
								<li><a href="#aco7" onclick="btnEvent('aco7')" title="문화재연구소">문화재 <br>연구소</a></li>
                         <li><a href="#aco11" onclick="btnEvent('aco11')" title="기획총무팀">기획 <br>총무팀</a></li>
								<li><a href="#aco12" onclick="btnEvent('aco12')" title="홍보팀">홍보팀</a></li>
								<li><a href="#aco13" onclick="btnEvent('aco13')" title="대외협력팀">대외 <br>협력팀</a></li>
								<li><a href="#aco14" onclick="btnEvent('aco14')" title="전시기획팀">전시<br>기획팀</a></li>
							</ul>
						</div>

					</div>
					 -->
                  

					<!-- 부서 및 주요업무 소개 -->
					<p class="sub-in-yellow-title">부서 및 주요업무 소개</p>

					<div class="organi-accodian-wrap"> <!-- 부서 아코디언 시작 -->

						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco1"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 대표이사</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>대표이사 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">대표이사 직무대행</th>
												<td>정명섭</td>
												<td>
													061-280-5801<br>
													(대표전화)
												</td>
												<td>cms4623@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>재단 경영 및 사업 총괄</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>

								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->


						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco2"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 사무처장</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>사무처장 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">사무처장</th>
												<td>이동명</td>
												<td>
													061-280-5803 <br>
													(대표전화)
												</td>
												<td>dm74@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>재단 행정 및 사무업무 총괄</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>

								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->


						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco3"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 기획경영팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>기획경영팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">팀장</th>
												<td>강기문</td>
												<td>061-280-5811	</td>
												<td>kkm8033@jncf.or.kr	</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>기획경영팀 업무 총괄</li>
                                                        <li>정책과제 연구.개발 업무</li>
                                                        <li>회계관직(지출원)</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">차장</th>
												<td>김은정</td>
												<td>061-280-5812</td>
												<td>hera616@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>예산 및 계약업무</li>
														<li>기금 조성 및 자금 관리</li>
                                                        <li>이사회 운영에 관한 업무</li>
                                                        <li>대표이사후보추천위원회 운영 업무</li>                                        
                                                        <li>세입・세출 外 업무</li>
													</ul>
												</td>
											</tr>
											<tr>
                                              <th class="tt">대리</th>
												<td>박하나</td>
												<td>061-280-5813</td>
												<td>hana@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                        <li>감사관련 업무 전반</li> 
                                                        <li>인사·채용·조직관리 업무</li>
													    <li>노무업무</li>
														<li>대외협력(유관기관 등), 도(도의회) 요구자료 관리 업무</li>
														<li>신규정책 및 교류사업 발굴 업무</li>
													</ul>
												</td>
											</tr>
											<tr>
                                              <th class="tt">대리</th>
												<td>채민미</td>
												<td></td>
												<td>205181@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>근무평가 후속조치<li>
                                                        <li>채용 감사 업무</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">대리</th>
												<td>나은희</td>
												<td>061-280-5815</td>
												<td>bluewings8@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>재단 경영평가</li>
														<li>사회적가치경영·고객만족경영 업무 </li>
                                                        <li>윤리·청렴·인권경영 업무 </li>
														<li>재단 제규정 및 규칙에 관한 업무</li>
                                                      <li>홍보업무</li>
                                                      <li>공공미술 프로젝트 운영</li>
                                                  </ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>김정화</td>
												<td>061-280-5814</td>
												<td>jhwa215@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>회계, 결산, 세무 업무</li>
														<li>신용카드 관리 업무</li>
                                                        <li>보수, 4대보험 업무</li>
                                                        <li>회계관직(출납원)</li>
                                                   </ul>
                                                  </td>
											</tr>
											<tr>
                                               <th class="tt">주임</th>
                                               <td>신혜민</td>
                                               <td>061-280-5819</td>
                                               <td>hyemin46@jncf.or.kr</td>
                                               <td class="textL">
                                                  <ul class="dot-ul-1">
                                                      <li>복무(가족친화, 복리후생 등) 관련 업무</li>
                                                      <li>직원 교육업무</li>
                                                      <li>홈페이지(SNS 등) 관리 업무</li>
                                                   </ul>                                                    
                                              </td>
                                          </tr>
                                        <tr>
                                               <th class="tt">주임</th>
                                               <td>이명희</td>
                                               <td>061-280-5820</td>
                                               <td>mh0914@jncf.or.kr</td>
                                               <td class="textL">
                                                  <ul class="dot-ul-1">
                                                      <li>공공미술프로젝트 사업 운영</li>
                                                   </ul>          
                                              </td>    
                                          </tr>
                                        <tr>
                                               <th class="tt">주임</th>
                                               <td>배아름</td>
                                               <td>061-280-5818</td>
                                               <td>zzxxzz002@jncf.or.kr</td>
                                               <td class="textL">                                          
                                                  <ul class="dot-ul-1">
                                                      <li>공공미술프로젝트 사업 운영</li>
                                                   </ul>  
                                              </td>   
                                          </tr>
                                      <tr>                                     
                                               <th class="tt">주임</th>        
                                               <td>문영석</td>                             
                                               <td>061-280-5817</td>                
                                               <td>youngsouk@jncf.or.kr</td>                          
                                               <td class="textL">                
                                                  <ul class="dot-ul-1">
                                                      <li>재단 사무실 운영(자산관리·보안) 및 시설관리 업무</li>
                                                      <li>재단 서무업무 전반</li>
                                                   </ul>  
                                              </td>   
                                          </tr>
                                          <tr>                                                                   
                                      </tbody>
									</table>
								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->


						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco4"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 문화사업팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>문화사업팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">팀장</th>
												<td>강수정</td>
												<td>061-280-5821	</td>
												<td>crystal@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
            											<li>문화사업팀 업무 총괄</li>
                                                        <li>도내·외 문화예술 협력네트워크</li>
                                                        <li>광주·전남 문화주간행사</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">차장</th>
												<td>정선재</td>
												<td>061-280-5822</td>
												<td>sunjae9@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>지역문화예술 특성화 지원사업 운영 전반<br>- 지역문화예술특성화 기획사업<br>- 레지던스프로그램</li>
                                                        <li>남도예술은행 운영 사업</li>
                                                        <li>남도사이버갤러리 운영</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">대리</th>
												<td>최상희</td>
												<td>061-280-5828</td>
												<td>edgeyagum@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
    									        		<li>온라인미디어예술활동지원</li>
                                                        <li>예술인 파견지원사업-예술로(路) 운영</li>
                                           			</ul>
												</td>
											</tr>
											<tr>
                                              <th class="tt">대리</th>
												<td>임범수</td>
												<td>061-280-5826</td>
												<td>beomsu@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                        <li>공연장상주단체육성지원사업 운영 전반</li>
                                                        <li>예술인 복지 서비스 플랫폼 운영</li>
                                                      	</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>김영재</td>
												<td>061-280-5825</td>
												<td>djkyj1993@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>지역문화예술 특성화 지원사업<br>- 청년예술가활동<br>- 우리마을아트페스티벌<br>- 지역문화예술육성(문학)</li>
                                           				<li>지원사업 영상기록화 및 아카이브 운영</li>
													</ul>
												</td>
											</tr>
											<tr>
                                              <th class="tt">주임</th>
                                               <td>이지현</td>
                                               <td>061-280-5824</td>
                                               <td>gojihyeon@jncf.or.kr</td>
                                               <td class="textL">
                                                    <ul class="dot-ul-1">
														<li>예술로 남도로 문화예술특구 조성사업</li>
                                                        <li>예술작품 멤버십 렌트사업</li>
                                                        <li>지역문화예술 특성화 지원사업<br>- 지역문화예술육성(시각예술)</li>
                                                    </ul>
                                              </td>
                                          </tr>
                                           <tr>
                                               <th class="tt">주임</th>
												<td>유라선</td>
												<td>061-280-5823</td>
												<td>yourasun@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                        <li>지역문화예술특성화지원사업<br>- 지원사업 현장평가 및 모니터링<br>- 문화예술해외교류<br>- 공연예술창작<br>- 지역문화예술육성(공연예술)</li>
													</ul>
												</td>
											</tr>
                                          <tr>     
                                      </tbody>
									</table>

								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->


						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco5"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 문화예술교육팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>문화예술교육팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">팀장</th>
												<td>김광훈</td>
												<td>061-280-5841</td>
												<td>artshow2000@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>문화예술교육팀 업무 총괄</li>
														<li>문화예술교육팀 추진사업 기획운〮영, 예산관리 총괄</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">차장</th>
												<td>서선숙</td>
												<td>061-280-5842</td>
												<td>1022sss@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
         												<li>문화예술교육 업무 관리 </li>
                                                        <li>세시풍속·마을문화 지원사업 운영</li>
                                                        <li>찾아가는 영화관 운영사업</li>
                                                       <li>지속가능 TF 업무</li>
                                                      <li>주요 요구자료 관리</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>김수재</td>
												<td>061-280-5843</td>
												<td>spoonkim@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>지역문화예술교육 기반구축<br>- 기획사업 '문화지소' 운영<br>- 문화예술교육 꾸러미 사업<br>- 비대면 문화예술교육 구축</li>
														<li>대내외 네트워크 협력사업 추진</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>차서연</td>
												<td>061-280-5844</td>
												<td>sy_mika@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                      <li>지역문화예술교육 기반구축<br>- 지역특성화문화예술교육 운영 <br>- 기획자 양성사업 'J-ACE'아카데미</li>
														<li>생애전환문화예술학교 운영</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>윤하람</td>
												<td>061-280-5845</td>
												<td>hle1204@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                      <li>지역문화예술교육 기반구축<br>- 문화예술교육 정보화 관리</li>
                                                      <li>예술동호회 활동지원 사업 운영 </li>
                                                      <li>문화예술교육사 현장 역량강화 사업 운영</li>
                                                      <li>찾아가는 예술캠프 운영</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>심현지</td>
												<td>061-280-5846</td>
												<td>ahha00@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>지역문화예술교육기반구축<br>- 꿈다락 토요문화학교 운영<br>- 문화예술교육 협력망 구축사업</li>
                                                      <li>유아문화예술교육사업 운영</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>서주현</td>
												<td>061-280-5847</td>
												<td>tjwngus27@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>통합문화이용권 사업 운영<br>- 사업예산 및 월별 이용대금 관리<br>- 문화누리카드 사업 관리 등<br>- 가맹점 발굴·관리 및 홍보<br>- 도내 22개 시·군 네트워크 및 교육</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>

								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->


						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco6"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 공연예술진흥팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>공연예술진흥팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">팀장</th>
												<td>임진호</td>
												<td>061-981-0281</td>
												<td>jnart@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>공연예술진흥팀 업무 총괄</li>
														<li>공연장 안전 총괄 관리</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">차장</th>
												<td>이지민</td>
												<td>061-981-6677</td>
												<td>jiwm2134@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                        <li>전남도립국악단 위탁사업 운영관리</li>
														<li>도립국악단 기획공연사업 운영관리</li>
                                                        <li>지속가능경영TF</li>
                                                        <li>부서성과관리 및 주요자료 작성 </li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>김선아</td>
												<td>061-981-0280</td>
												<td>ksh2002w@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>남도소리울림터 위탁사업 운영</li>
                                                        <li>남도소리울림터 수입금 운영관리</li>
														<li>남도소리울림터 기획·초청공연사업 운영</li>
                                                        <li>방방곡곡 문화공감 민간예술단체초청사업 운영</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>한승진</td>
												<td>061-981-6688</td>
												<td>sjin1014@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>전남 대표브랜드 공연 공동제작 배급사업</li>
                                                        <li>남도어린이페스타 운영</li>
														<li>대한민국 창극제 사업 운영<br>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">음향감독</th>
												<td>한정환</td>
												<td>061-981-0284</td>
												<td>enterhan@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>남도소리울림터 음향 운영관리</li>
                                                        <li>남도소리울림터 대관사업</li>
                                                        <li>공연장 영상 및 통신설비 유지관리</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">조명감독</th>
												<td>신동우</td>
												<td>061-981-0287</td>
												<td>dwshin@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>남도소리울림터 조명 운영관리</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">무대기계감독</th>                                          
												<td>송동연</td>                                              
												<td>061-981-0283</td>                                              
												<td>ddr0210@jncf.or.kr</td>                                              
												<td class="textL">                                              
                              			        	<ul class="dot-ul-1">                
												    	<li>남도소리울림터 무대기계 운영관리</li>                                              
  												    	<li>공연장 안전관리</li>                                            
 													    <li>남도소리울림터 재물관리</li>                                             
													</ul>						                                            
												</td>                                              
											</tr>
											<tr>                                          
                                              <th class="tt">주임</th>
                                                <td>양재봉</td>
												<td>061-981-0298</td>
												<td>qorvkffyd@jncf.or.kr </td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>남도소리울림터 건축 시설 운영관리</li>
														<li>하우스 매니저</li>
														<li>남도소리울림터 홈페이지 관리</li>
													</ul>
												</td>
											</tr>
                                                                                         <tr>
                                              <th class="tt">주임</th>
												<td>장동석</td>
												<td>061-981-0294</td>
												<td>wbcimf@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>남도소리울림터 시설물 운영관리<br>- 전기시설물 유지.관리 및 소방 관련 업무<br>- 승강기 유지 및 관리</li>
                                                        <li>공연장 안전.보안에 관한 사항</li>
                                                  </ul>
												</td>
											</tr>
                                                                                         <tr>
                                              <th class="tt">주임</th>                                                                                           
												<td>박윤권</td>                                                                                           
												<td>061-981-0294</td>                                                                                           
                                               <td>pyk1997@jncf.or.kr</td>                                                                                           
												<td class="textL">                                                                                           
													<ul class="dot-ul-1">                                                                                                                                                                         											                                    			<li>남도소리울림터 시설물 운영관리<br>- 기계, 설비, 시설물 운영관리<br>- 환경, 위생 관리</li>            
                                                        <li>공연장 안전.보안에 관한 사항</li>                                    
                                                  </ul>                                                                                           
												</td>                                                                                           
											</tr>
                                                                                         <tr>                                          
												<th class="tt">주임</th>
												<td>고선옥</td>
												<td>061-981-0298</td>
												<td>vndn105@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>남도소리울림터 환경․미화</li>
													</ul>
												</td>
											</tr>
                                                                                         <tr>
												<th class="tt">주임</th>
												<td>정미란</td>
												<td>061-981-0298</td>
												<td>jmr0900@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>남도소리울림터 환경․미화</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>

								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->


						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco7"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 문화재연구소</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>문화재 연구소 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">소장</th>
												<td>이범기</td>
												<td>061-287-6802</td>
												<td>baumki@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>부서 주요사업 계획 수립 및 추진 총괄</li>
												        <li>학술조사 및 조사현장 감독 · 관리 업무 총괄</li>
                                                        <li>문화재기관 및 유관기관 관리 및 업무 총괄</li>
														<li>보고서(조사, 총서, 논문집 등) 관리·감독 업무 총괄</li>
												</td>
											</tr>
											<tr>
												<th class="tt">책임 연구원</th>
												<td>곽명숙</td>
												<td>061-287-6803</td>
												<td>msmemory@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>학술조사 및 조사현장 운영</li>
														<li>발굴조사 보고서 발간 및 자료수집 담당</li>
														<li>부서 경영성과 보고서작성 및 지표관리</li>
                                                        <li>마한문화권 조사연구(마한 고분 발굴조사) 담당</li>
														<li>마한문화권 조사연구(취락 현황조사) 담당 </li>
                                                        <li>부서 예산 집행 및 관리 담당</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">책임 연구원</th>
												<td>송장선</td>
												<td>061-287-6804</td>
												<td>sjs5854@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>학술조사 및 조사현장 운영</li>
														<li>발굴조사 보고서 작성 및 자료수집 담당</li>
														<li>문화재청 조사기관 협업포털 관리<br>- 각종 현안자료 협업포털 관리</li>
														<li>문화재 학술용역 입찰 업무 담당<br>- 문화재 조사(지표·시굴·발굴·학술 등)</li>
                                                        <li>학술논문집(전남문화재) 운영 담당</li>                                                      
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">선임연구원</th>
												<td>이수경</td>
												<td>061-287-6806</td>
												<td>dream3713@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li> 마한문화권 관련 현안업무 담당<br>- 관련 보고서 작성·연구 및 자료수집<br>- 관련 연구 마스터플랜 수립 및 운영</li>
                                                        <li>마한문화 홍보 및 유관기관 업무협의 담당</li>
                                                        <li>국가귀속문화재 대장 작성 및 관리</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">연구원</th>
												<td>문종명</td>
												<td>061-287-6808</td>
												<td>malandro77@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>학술조사 및 조사현장 보조, 학술 서무 담당</li>
                                                        <li>발굴조사 보고서 작성 및 발간 보조<br>- 유물 실측, 유구·유물 도면 일러스트</li>
														<li>마한문화권 조사 연구(마한포럼) 담당</li>
														<li>지표조사 보고서 및 자료관리 담당</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">연구원</th>
												<td>김경애</td>
												<td>061-287-6810</td>
												<td>kka2028@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>보존처리실 운영·관리 및 보존처리 딤당<br>- 출토유물 보존처리 및 유물 관리<br>- 보존처리 기자재 및 관련 용품 관리</li>
                                                        <li>수장고 보안일지 및 출토유물 관리 담당</li>
														<li>부서 예산 집행 및 관리 담당</li>
														<li>국가귀속문화재 대장 작성 및 관리 보조</li>
														<li>문화재 학술용역 입찰 업무 보조<br>- 문화재 조사(지표·시굴·발굴·학술 등)</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">연구원</th>
												<td>이경민</td>
												<td>061-287-6809</td>
												<td>wldus071646@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>학술조사 및 조사현장 보조, 학술 서무 담당</li>
                                                        <li>발굴조사 보고서 작성 및 발간 보조<br>- 유물 실측, 유구·유물 도면 일러스트</li>
														<li>마한문화권 조사 연구(취락 현황조사) 보조</li>
														<li>조사장비 물품 관리 및 담당<br>- 자산관리 등록 및 조사용품 관리 운영</li>
														<li>도서 관리 및 등록·보고서 배포</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">연구원</th>
												<td>박홍준</td>
												<td>061-287-6807</td>
												<td>phjkhj73@jncf.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>학술조사 및 조사현장 보조, 학술 서무 담당</li>
                                                        <li>발굴조사 보고서 작성 및 발간 보조<br>- 유물 실측, 유구·유물 도면 일러스트</li>
														<li>학술논문집(전남문화재) 운영 보조</li>
                                                        <li>지표조사 보고서 및 자료관리 보조</li>
														<li>부서 연구도서 운영 및 구입 담당</li>
														<li>전산장비 및 관련 프로그램 관리.운영 담당</li>
													</ul>
												</td>
											</tr>
                                            <tr>
                                               <th class="tt">연구원</th>
                                               <td>이재언</td>
                                               <td>061-287-6805</td>
                                              <td>hersona@jncf.or.kr</td>
                                               <td class="textL">
                                                    <ul class="dot-ul-1">
														<li>학술조사 및 조사현장 보조, 학술 서무 담당</li>
                                                        <li>발굴조사 보고서 작성 및 발간 보조<br>- 유물 실측, 유구·유물 도면 일러스트</li>
                                                        <li>마한문화권 조사 연구(사적지정) 담당</li>
                                                        <li>마한문화권 조사 연구(취락 현황조사) 보조</li>
                                                        <li>마한문화권 조사 연구(마한포럼) 보조</li>
                                                  </ul>
                                              </td>
                                          </tr>
                                          <tr>
                                               <th class="tt">연구원</th>
                                               <td>모정진</td>
                                               <td>061-287-6812</td>                           
                                              <td>jeong8603@jncf.or.kr</td>                 
                                               <td class="textL">
                                                    <ul class="dot-ul-1">
														<li>학술조사 및 조사현장 보조, 학술 서무 담당</li>                      
														<li>발굴조사 보고서 작성 및 발간 보조<br>- 유물 실측, 유구·유물 도면 일러스트</li>
                                                        <li>도서 관리 및 등록·보고서 배포 보조</li>
                                                 </ul>
                                            </td>
                                          </tr>
                                          <tr>
                                               <th class="tt">주임</th>                  
                                               <td>정인철</td>
                                               <td>061-287-6811</td>
                                                <td>jic0910@jncf.or.kr</td>
                                               <td class="textL">
                                                    <ul class="dot-ul-1">               
														<li>마한문화권 관련 현안업무 보조<br>- 보고서 작성·연구 및 자료수집 보조<br>- 관련 연구 마스터플랜 수립 업무 보조</li>                             
                                                       <li>부서 연구도서 운영 및 구입 담당</li>
                                                      <li>부서 주간업무 작성 및 업무 협의회 보조</li>
                                                 </ul>
                                            </td>
                                          </tr>
                                   </tbody>
									</table>

								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->


						<!--<div class="row">
							<div class="title-b" id="aco8">
								<a href="javascript:;">
									<span class="txt">· 관광마케팅팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> 
								<div class="orga-department-box table_wrap_mobile"> 

									<table class="tbl_organi">
										<caption>관광마케팅 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">팀장</th>
												<td>이용식</td>
												<td>061-980-6851</td>
												<td>pro0090@jact.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>관광마케팅팀 업무 총괄</li>
                                                        <li>관광마케팅 네트워크 사업 추진</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">차장</th>
												<td>조한나</td>
												<td>061-980-6852</td>
												<td>hanna26@jact.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>일본․구미주․동남아 관광객 유치 마케팅<br>- 전세기, 크루즈, 기업인센티브 등</li>
														<li>해외 전남관광 인지도 제고를 위한 이벤트</li>
														<li>지역 MICE 산업 활성화 사업</li>
														
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>이그린</td>
												<td>061-980-5863</td>
												<td>rmfls1338@jact.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
													<li>의료웰니스관광 클러스터 사업 운영<br>- 전남의료관광 홍보 및 해외 마케팅<br>- 온.오프라인 홍보 및 콘텐츠 제작<br>- 의료기관&에이전시 마케팅 지원사업</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>조성제</td>
												<td>061-980-6853</td>
												<td>sjcho9003@jact.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>국제 크루즈 유치 마케팅</li>
														<li>해외관광객 유치 지정여행사 운영</li>
														<li>지역 MICE산업 활성화 사업</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주임</th>
												<td>전유미</td>
												<td>061-980-6854</td>
												<td>yumi@jact.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>중화권 관광객 유치 마케팅</li>
														<li>무안공항 활성화 및 여행사 인센티브 지원</li>
                                                        <li>MICE 유치 및 인센티브 지원</li>
														<li>지역 MICE산업 활성화 사업</li>
                                                      </ul>
												</td>
											</tr>
											<tr>
                                                <th class="tt">주임</th>
												<td>김훈정</td>
												<td>061-980-6857</td>
												<td>khj0227@jact.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>의료관광 통합지원센터 운영(부)</li>
                                                  </ul>
												</td>
											</tr>
										</tbody>
									</table>

								</div> 
							</div> 
						</div>  -->


					<!--	<div class="row"> 
							<div class="title-b" id="aco9"> 
								<a href="javascript:;">
									<span class="txt">· 관광연구개발팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b">
								<div class="orga-department-box table_wrap_mobile"> 

									<table class="tbl_organi">
										<caption>관광연구개발팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">팀장</th>
												<td>김용운</td>
												<td>061-980-5861</td>
												<td>kyw1052@jact.or.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>관광연구개발팀 업무 총괄</li>
														<li>대내외 협력업무 및 네트워크 사업 추진</li>
                                                        <li>전남 관광사업 활성화를 위한 공모사업 유치 총괄</li>
								    			  	 </ul>
												</td>
										  </tr>
										  <tr>
											  <th class="tt">대리</th>
                                              <td>최상희</td>
                                              <td>061-980-5862</td>
                                              <td>01041733662@jact.or.kr</td>
                                              <td class="textL">
                                                  <ul class="dot-ul-1">
                                                    <li>주민주도형 관광사업 활성화 인력 양성 및 주민사업체 육성 사업 운영<br>- 전남관광두레협력사업 운영</li>
                                                    <li>전남 관광사진 공모전 위탁사업 운영</li>
                                                 </ul>
                                             </td>
                                         </tr>
                                         <tr>
                                              <th class="tt">주임</th>
											  <td>김흥수</td>
											  <td>061-980-5864</td>
											  <td>hskim3212@jact.or.kr</td>
											  <td class="textL">
												  <ul class="dot-ul-1">
													<li>국내외 관광동향조사 및 실태 분석<br>- 전남 관광정책 연구사업 추진 및 자료집 발간</li>
													<li>도내 관광콘텐츠 발굴을 통합 대표상품 개발<br>- 남도고택 체험프로그램 운영<br>- 신규 여행상품 개발 사업 운영</li>
													<li>전남 관광산업 활성화를 위한 공모사업 발굴.운영</li>
                                                 </ul>
									    	</td>
									  </tr>
									</tbody>
								</table>

								</div> 
							</div> 
						</div> row END --> 


						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco10"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 국제수묵비엔날레사무국</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>국제수묵비엔날레 사무국 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th>직위</th>
												<th>이름</th>
												<th>전화번호</th>
												<th>e-mail	</th>
												<th>주요업무</th>
											</tr>
											<tr>
												<th class="tt">사무국장</th>
												<td>김성훈</td>
												<td>061-280-5860</td>
												<td>ksh0048@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>전남국제수묵비엔날레사무국 업무 총괄</li>
														
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">기획부장</th>
												<td>민순희</td>
												<td>061-280-5861</td>
												<td>min6938@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>전남국제수묵비엔날레사무국 기획부 업무 총괄</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">운영부장</th>
												<td>장영일</td>
												<td>061-280-5874</td>
												<td>naid012@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>전남국제수묵비엔날레사무국 운영부 업무 총괄</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>

								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->

						<div class="row"> <!-- row Start -->
							<div class="title-b" id="aco11"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 기획총무팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>기획총무팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th class="tt">팀장</th>
												<td>허상무</td>
												<td>061-280-5862</td>
												<td>jindo327@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>기획총무팀 업무 전반</li>
														<li>2021 비엔날레 기본·세부 실행계획 수립·총괄</li>
                                                        <li>조직 운영 전반에 관한 사항(인사,법규)</li>
                                                      <li>이사회·의회 등 각종 업무보고</li>														
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주무관</th>
												<td>유다연</td>
												<td>061-280-5863</td>
												<td>bs003255@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>2021 비엔날레 기본 · 세부 실행계획 수립 </li>
                                                        <li>자문·운영위원회 구성 및 운영</li>
                                                        <li>중앙정부 및 유관기관 협력체계 구축</li>
                                                        <li>지방재정 투자사업 중앙 심사 추진</li>
                                                        <li>종합 결과보고서 중앙 심사 추진</li>
                                                        <li>종합상황실 설치 및 운영</li>                                                      
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주무관</th>
												<td>이기훈</td>
												<td>061-280-5866</td>
												<td>hoon9652@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                        <li>조직 운영에 관한 사항 </li>
														<li>예산 편성 및 관리</li>
														<li>비엔날레 결산 및 정리</li>
                                                        <li>각종 용역 계약 추진</li>              
                                                        <li>수익금 정산</li> 
                                                        <li>유관기관 협의체 구성 및 운영</li>
                                                        <li>시군 간담회, 합동회의, 교육 등 운영</li> 
                                                        <li>비엔날레 백서 발간</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->
				
                      <div class="row"> <!-- row Start -->
							<div class="title-b" id="aco12"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 홍보팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>홍보팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th class="tt">팀장</th>
												<td>조성수</td>
												<td>061-280-5871</td>
												<td>sschol@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                      <li>홍보팀 업무 전반<br> - 국내·외 홍보활동 계획수립 및 시행<br> - 홍보대행사 총괄 관리<br> - 국내·외 관람객 유치<br> - 국내·국제 학술대회 계획 수립 및 시행<br> - 마케팅 종합계획 수립·조정 및 추진<br> - 휘장사업, 후원사 유치 등</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주무관</th>
												<td>김주희</td>
												<td>061-280-5872</td>
												<td>kjh2015@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                      <li>홍보기념품 제작, 홈페이지 및 SNS 관리</li>
                                                      <li>기자간담회, 프레스데이 및 프레스센터 운영, 중앙·지역 미술기자단 관리</li>
                                                      <li>명예홍보대사 위촉 및 홍보서포터즈 운영</li>      
                                                      <li>D-100일 행사 기획 및 추진</li>
                                                      <li>입장권 기본계획 수립, 입장권 대행사 선정·관리 및 입장권 정산</li>
                                                      <li>국내·국제 학술대회 계획 수립 및 시행</li>
                                                      <li>향우회·군의경·수학여행단·초중고대학생 유치</li>
                                                      <li>예산·회계 처리에 관한 사항</li>
													</ul>
												</td>
											</tr>
                                   <tr>
												<th class="tt">주무관</th>
												<td>노태형</td>
                        						<td>061-280-5870</td>
												<td>shxogud@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>홍보 예산 편성 및 관리</li>
														<li>홍보대행사 운영 및 관리</li>
														<li>국내·외 홍보활동 및 관람객 유치정책 수립</li>
                                                        <li>네이밍데이 행사 추진</li>
                                                        <li> TV, 라디오 광고 및 홍보 프로그램 제작, 지원</li>
                                                        <li>마케팅관련 실행계획 수립 및 추진</li>
                                                        <li>도록판매,  현금·현물·협찬 및 임대영업 시설 등 수익사업</li>
                                                        <li>국내외 미술협회 및 문화예술단체 등 관리</li>
													</ul>
												</td>
											</tr>
                                   <tr>
												<th class="tt">주무관</th>
												<td>이동현</td>   
                                                <td>061-280-5873</td>
                                                <td>donghyun0430@korea.kr</td>
                                         		<td class="textL">
                                                  	<ul class="dot-ul-1">
                                                       <li>옥외광고물,  홍보인쇄물 제작, 홍보관 운영</li>             
                                                       <li>홍보영상물 및 통화연결음 제작</li>
                                                       <li>언론홍보, 보도자료</li>
                                                       <li>SNS 카드뉴스 제작 및 1인 유튜버 운영</li>
                                                       <li>주한외교사절단 등 외국인 유치 및 해외기관 단체 통번역 지원</li>
                                                       <li>행사기간 중 국내외 주요인사 의전 관리</li>
                                                       <li>비엔날레 입장권 연계 할인 추진</li>
                                                       <li>국제행사 개최지역과 협력사업 추진</li>
                                                       <li>비엔날레 휘장사업자 선정 및 추진, 후원·기업 유치</li>
													</ul>            
												</td>
											</tr>
										</tbody>                                         
									</table>
								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->

                      
                      <div class="row"> <!-- row Start -->
							<div class="title-b" id="aco14"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 전시기획팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>
							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->
									<table class="tbl_organi">
										<caption>전시기획팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
												<tr>
												<th class="tt">팀장</th>
												<td>강남중</td>
												<td>061-280-5885</td>
												<td>kangnam@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>전시기획팀 업무 전반<br> - 전시연출 종합계획 수립·추진<br> - 프로그램, 이벤트 종합계획 수립·추진<br> - 총괄 대행사, 총감독 선정 관리 등</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주무관</th>
												<td>최민준</td>
												<td>061-280-5886</td>
												<td>freecmj@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                       <li>2021 시·군 기념전 개최 운영</li>
														<li>큐레이터 선임 및 운영·관리</li>
                                                        <li>국제레지던시 계획 수립·운영</li>
                                                        <li>서울·광주 수묵 특별전 운영</li>
                                                        <li>관람객 행사장 유인 대책 수립·운영</li>
                                                        <li>행사장 아트마켓·식음·휴게시설 등 관리</li>
														<li>총감독 관리 및 업무 지원</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주무관</th>
												<td>조재만</td>
												<td>061-280-5884</td>
												<td>wodoaks@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li> 목포문화예술회관 전시연출, 행사장 운영<br>- 작품선정, 시설구성, 작품운송·반송, 보험 포함</li>
                                                        <li>목포문화예술회관 공연동 프로그램 유치</li>
                                                        <li>총괄 대행사 운영·관리</li>
                                                        <li>미디어아트(총감독 주제관) 조성·운영</li>
                                                        <li>시민참여 사전이벤트, 개막식 추진</li>
                                                        <li>원도심 (특별전시관) 전시연출<br>- 시설 임차·보안, 작품선정, 작품운송·반송 등</li>
														<li>목포시 지역단체 주관 이벤트 운영</li>
                                                        <li>원도심 일원 목포시 주관행사 유치</li>
                                                        <li>기타 목포시 전시연출 협력에 관한 사항</li>
													</ul>
												</td>
											</tr>
                                    <tr>
												<th class="tt"></th>
												<td>이규연</td>
												<td>061-280-5878</td>
												<td>donghyun0430@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>교육・이벤트 프로그램 운영<br> - 청소년 수묵레지던시, 수묵 UCC 공모전, 인문학 콘서트</li>
														<li>AI 수묵미술전, 5G아트체험 사업지원<br> - 일본 등 해외 로봇작가 참여 유치 등</li>
														<li>도록,  전시홍보물 제작</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->
                        
                      <div class="row"> <!-- row Start -->
							<div class="title-b" id="aco13"> <!-- title -->
								<a href="javascript:;">
									<span class="txt">· 행사운영팀</span>
									<span class="icon"><i class="xi-angle-down-thin"></i></span>
								</a>
							</div>

							<div class="con-b"> <!-- con -->
								<div class="orga-department-box table_wrap_mobile"> <!-- tableBox -->

									<table class="tbl_organi">
										<caption>행사운영팀 부서 및 주요업무 소개</caption>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="40%">
										</colgroup>
										<tbody>
											<tr>
												<th class="tt">팀장</th>
												<td></td>
												<td></td>
												<td></td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li></li>
                    								</ul>
												</td>
											</tr>
											<tr>
												<th class="tt">주무관</th>
												<td>강유라</td>
												<td>061-280-5883</td>
												<td>rkddbfk72@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
                                                        <li>전야제 계획 수립·운영</li>
														<li>교육·이벤트 프로그램 운영<br> - 수묵놀이교실, 수묵 아카데미, 영호남예술인 날</li>
														<li>예산·회계, 각종 보고서 작성 등 운영부 총괄 서무에 관한 사항</li>
                                                        <li>셔틀버스 운영<br>- 시군 수묵기념전 연계 및 남도투어 등</li>
                                                        <li>도슨트·자원봉사자 선발 및 운영·관리</li>
                                                      <li>기타 운영부 업무지원에 관한 사항</li>
                                                   </ul>
												</td>
											</tr>
									       <tr>
                                                <th class="tt">주무관</th>
												<td>정영준</td>
												<td>061-280-5877</td>
												<td>seahama1@korea.kr</td>
												<td class="textL">
													<ul class="dot-ul-1">
														<li>AI수묵미술전, 5G아트체험 사업</li>
														<li>수묵 다큐멘터리 제작·반영</li>
                                                        <li>운림산방, 옥산미술관 전시연출<br>- 작품선정, 시설구성, 작품운송·보험 포함</li>
                                                        <li>옥산미술관 공연동 프로그램 유치</li>
                                                        <li>진도군 지역단체 주관 이벤트 운영</li>
                                                        <li>기타 진도군 전시연출 협력에 관한 사항</li>
                                                        <li>행사장 의료지원, 관람객 보험 관리</li>
                                                        <li>주차장, 교통, 환경, 소방, 보안, 안전 관리</li>
                                                     </ul>
												</td>
											</tr>
                                           <tr>
                                                <th class="tt">주무관</th>                                   
                                                <td>윤세훈</td>
                                                <td>061-280-5876</td>
                                                <td>ysh120@korea.kr</td>
                                                <td class="textL">
													<ul class="dot-ul-1">
														<li>'21년 중앙부처 공모사업 유치</li>
														<li>작품설명 어플 개발·운영</li>         
                                                        <li>유니폼 제작계획 수립 추진</li>
                                                        <li>안내소, 사인물, 입퇴장, 출입증 등 종합관리</li>
                                                     </ul>
												</td>
											</tr>
                                           <tr>                                          
										</tbody>
									</table>
								</div> <!-- tableBox END -->
							</div> <!-- con END -->
						</div> <!-- row END -->
                      
					</div> <!-- 아코디언 끝 -->

				</div>


			</div> <!-- 서브컨텐츠 끝 -->
<script type="text/javascript">
function workArccordionUp() {
    $('.organi-accodian-wrap .title-b').removeClass('active');
//    $('.organi-accodian-wrap .con-b').stop().slideUp();
 }

function btnEvent(btnId){
	var btnAco = document.getElementById(btnId);
    // if($(btnAco).is('.active')) {
    //     workArccordionUp();
    // } else {
    // }
	workArccordionUp()
	$(btnAco).addClass('active');
    // $(btnAco).next('.con-b').stop().slideDown();
	//	document.getElementById(btnId).scrollIntoView();
		setTimeout(function() {
		
	//	document.getElementById(btnId).scrollIntoView();
		document.getElementById(btnId).focus();
		document.getElementById(btnId).scrollIntoView();
			}, 300);
}
</script>


		</div> <!--inner 끝 -->
	</section><br><br><br>