<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<link href="/resources/publish/jact/css/sub.css" rel="stylesheet" type="text/css" />

<!-- 내용시작 -->
<section id="sub-content">
	<div class="inner1200" style="font-size: 13px;">
		<!--서브 타이틀 -->
		<div class="sub-title-box" style="font-size: 15px;">
			<h2 style="font-size: 38px;">지속가능경영</h2>
			<ul class="list_ul" style="font-size: 18px;">
				<li class="home" style="font-size: 13px;"><i class="xi-home" style="font-size: 15px;"></i></li>
<%-- 				<c:forEach items="${fn:split(currentMenu.MN_MAINNAMES,',') }" --%>
<!-- 					var="model"> -->
					<li style="font-size: 13px;">사업안내</li>
					<li style="font-size: 13px;">지역사회공헌 활동</li>
<%-- 				</c:forEach> --%>
			</ul>
		</div>
		<!-- 서브컨텐츠 -->
		<div class="sub-business-content" id="sub-con-start" style="font-size: 15px;">
			<!-- 동영상 이미지 탭부분 -->
			<div class="tab-in-box">
					<ul class="tab_ul tab-3">
						<li class="tab1"><a href="javascript:;" onclick="setTap(1)">지속가능경영비전</a></li>
						<li class="tab2"><a href="javascript:;" onclick="setTap(2)">사회 공헌 헌장</a></li>
					<li class="active tab3"><a href="javascript:;" onclick="setTap(3)">지역사회공헌 활동</a></li>
				</ul>
			</div>
			
			<!-- 사업안내 내용 부분 -->
				<div id="li1" class="sub-business-content">

					
					<div class="top-s-title">
						<ul>
							<li>지속가능경영</li>
							<li>지속가능경영비전</li>
						</ul>
					</div>

					<div class="contents">

						<div class="one liGray"> <!-- one -->
							

							<div class="busi-middle-white">
								<span class="txt1 purple-c">경영목표</span>
								<span class="txt2">오감만족 문화·관광 및 지속가능 경영안정 기반 구축</span>
							</div>

							<div class="busi-p-arrow-box">
								<img src="/resources/img/icon/icon_busi_arrow_04_large.png" alt="화살표">
							</div>
							



							<div class="busi-s-squre-wrap busi-sq1-2 b-2-5 row1 "> <!-- 사각형1 -->
								
								<div class="col1"> <!-- col1 -->
									<div class="iner">
										
										<div class="boxC box1 bgPur">
											<span class="txt">공헌전략</span>
											<span class="verti"></span>
										</div>

									</div>
								</div><!-- col1 END -->

								<div class="col3"> <!-- col4 -->
									<div class="iner">
										
										<div class="boxC box1 linePur">
											<span class="txt purple-c bold">공직사회 <br>사회적 가치 실현</span>
											<span class="verti"></span>
										</div>

									</div>
								</div> <!-- col4 END -->

								<div class="col3"> <!-- col4 -->
									<div class="iner">										
										<div class="boxC box1 linePur ano">
											<span class="txt purple-c bold">일하기 좋은 <br>조직문화 구축</span>
											<span class="verti"></span>
										</div>
									</div>
								</div> <!-- col4 END -->

								<div class="col3"> <!-- col4 -->
									<div class="iner">										
										<div class="boxC box1 linePur l-l">
											<span class="txt purple-c bold">도민만족도 향상</span>
											<span class="verti"></span>
										</div>
									</div>
								</div> <!-- col4 END -->

							</div> <!-- 사각형1 -->



							<div class="busi-s-squre-wrap busi-sq1-2 b-2-5 row2 "> <!-- 사각형1 -->
								
								<div class="col1"> <!-- col1 -->
									<div class="iner">
										
										<div class="boxC box2 bgPur">
											<span class="txt">전략방향</span>
											<span class="verti"></span>
										</div>

									</div>
								</div><!-- col1 END -->

								<div class="col2"> <!-- col4 -->
									<div class="iner">										
										<div class="boxC box2 linePur">
											<span class="txt sm">지속가능 <br>경영 기반 구축</span>
											<span class="verti"></span>
										</div>
									</div>
								</div> <!-- col4 END -->

								<div class="col2"> <!-- col4 -->
									<div class="iner">
										
										<div class="boxC box2 ">
											<span class="txt sm">전남 문화예술 역량 강화</span>
											<span class="verti"></span>
										</div>

									</div>
								</div> <!-- col4 END -->

								<div class="col2"> <!-- col4 -->
									<div class="iner">										
										<div class="boxC box2 ">
											<span class="txt sm">전남 관광산업 <br>기반 구축</span>
											<span class="verti"></span>
										</div>
									</div>
								</div> <!-- col4 END -->

								<div class="col2"> <!-- col4 -->
									<div class="iner">										
										<div class="boxC box2 linePur">
											<span class="txt sm">도민 문화서비스 강화</span>
											<span class="verti"></span>
										</div>
									</div>
								</div> <!-- col4 END -->

							</div> <!-- 사각형1 -->


							<div class="busi-p-arrow-box">
								<img src="/resources/img/icon/icon_busi_arrow_01.png" alt="화살표">
							</div>

							<div class="busi-middle-white">
								<span class="txt1 purple-c">공헌비전</span>
								<span class="txt2">지역사회공헌 및 책임·나눔 경영으로 사회적 가치 조기 실현</span>
							</div>

							<div class="busi-p-arrow-box">
								<img src="/resources/img/icon/icon_busi_arrow_04_large.png" alt="화살표">
							</div>






							<div class="busi-s-squre-wrap busi-sq1-2 b-2-5 row3"> <!-- 사각형3 -->
								
								<div class="col1"> <!-- col1 -->
									<div class="iner">
										
										<div class="boxC box3 bgPur">
											<span class="txt">공헌전략</span>
											<span class="verti"></span>
										</div>

									</div>
								</div><!-- col1 END -->

								<div class="col4"> <!-- col4 -->
									<div class="iner">
										
										<div class="boxC box3">
											<span class="txt purple-c">공공기관의 사회적 가치 실현 강화</span>
											<span class="verti"></span>
										</div>

									</div>
								</div> <!-- col4 END -->

								<div class="col4"> <!-- col4 -->
									<div class="iner">										
										<div class="boxC box3">
											<span class="txt purple-c">재단 특성에 맞는 사회공헌 활동 추진</span>
											<span class="verti"></span>
										</div>
									</div>
								</div> <!-- col4 END -->

							</div> <!-- 사각형3 -->
						

							<div class="busi-s-squre-wrap busi-sq1-2 b-2-5 row4"> <!-- 사각형4 -->
								
								<div class="col1"> <!-- col1 -->
									<div class="iner">
										
										<div class="boxC box4 bgPur">
											<span class="txt">지역사회 <br>공헌 <br>추진과제</span>
											<span class="verti"></span>
										</div>

									</div>
								</div><!-- col1 END -->

								<div class="col3"> <!-- col3 -->
									<div class="iner">										
										<div class="boxC box4 pdN">
											<div class="p-tt">공감·참여</div>
											<div class="con2">
												<ul class="pur-ul">
													<li>사회공헌 헌장 게시</li>
													<li>자원봉사활동 활성화</li>
													<li>자체 공헌활동(캠페인)</li>
												</ul>
												<span class="verti"></span>
											</div>
										</div>
									</div>
								</div> <!-- col3 END -->

								<div class="col3"> <!-- col3 -->
									<div class="iner">										
										<div class="boxC box4 pdN">
											<div class="p-tt">유관기관 협력</div>
											<div class="con2">
												<ul class="pur-ul">
													<li>지역사회 MOU</li>
													<li>환경정화활동 추진</li>
												</ul>
												<span class="verti"></span>
											</div>
										</div>
									</div>
								</div> <!-- col3 END -->

								<div class="col3"> <!-- col3 -->
									<div class="iner">										
										<div class="boxC box4 pdN">
											<div class="p-tt">나눔과 지원</div>
											<div class="con2">
												<ul class="pur-ul">
													<li>소외지역 찾아가는 문화활동</li>
													<li>소외계층 문화서비스 확대</li>
												</ul>
												<span class="verti"></span>
											</div>
										</div>
									</div>
								</div> <!-- col3 END -->

							</div> <!-- 사각형4 -->



						</div> <!-- one END -->


					</div>


				</div>
                                <!-- 내용끗 -->
                              <!-- 사업안내 내용 부분 -->
				<div id="li2" class="sub-business-content">
					
					<div class="top-s-title">
						<ul>
							<li>지속가능경영</li>
							<li>안전관리헌장</li>
						</ul>
					</div>

					<div class="contents">

						<div class="one liGray"> <!-- one -->
							
							<div class="prize-b-Wrap">
								<!-- 상장패턴 -->
								<div class="pattern">
									<div class="bg lt"><img src="/resources/img/sub/img_sub_prize_lt.jpg" alt=""></div>
									<div class="bg rt"><img src="/resources/img/sub/img_sub_prize_rt.jpg" alt=""></div>
									<div class="bg lb"><img src="/resources/img/sub/img_sub_prize_lb.jpg" alt=""></div>
									<div class="bg rb"><img src="/resources/img/sub/img_sub_prize_rb.jpg" alt=""></div>
								</div>
								<!-- 상장내용 -->
								<div class="inner">
									<h2>사회 공헌 헌장</h2>
									<h3>
										우리 전라남도문화관광재단 직원 일동은 공공기관으로서 사회적 책임을 깊이 인식하고, 지역사회와 상생하는 나눔경영을 실천하는데 최선을 다하고자 다음과 같이 다짐한다.
									</h3>
									<div class="gray-txt">
										<p>
											하나. 우리는 소외되고 도움의 손길이 필요한 이웃에게 사랑을 나누어 꿈과 희망을 심어주는데 앞장선다.
										</p>
										<p>
											하나, 우리는 차별화된 전문 역량을 발휘하여 지역 특성에 맞는 특화된 사회공헌 활동을 전개하여 지역주민의 삶의 질 향상에 기여한다.
										</p>
										<p>
											하나, 우리는 다양한 환경보전 활동을 실천하여 지역사회 녹색화에 앞장서고, 자연과 인간이 공존하는 살기좋은 지구환경 만들기에 노력한다.
										</p>
										<p>
											하나, 우리는 마음이 풍요롭고 건강한 사회를 만들기 위해 다양한 문화나눔 운동을 적극 추진한다.
										</p>
									</div>
									<h5>우리는 위와 같이 지속가능하고, 체계적인 사회공헌활동을 실천하기 위하여 세부실천계획을 수립하여 성실히 수행한다.</h5>

									<div class="date-bottom-box">
										<p class="date">재단법인 전라남도문화관광재단임직원 일동</p>
										<div class="logo-b">
											<img src="/resources/img/sub/img_sub_prize_inLogo.png" alt="문화관광재단 로고">
										</div>
									</div>
								</div>
							</div>


						</div>

					</div>


				</div>
				<!-- 사업안내 내용 부분 끝!!! -->
			
			
			
			<div id="li3" >
			<div class="top-s-title">
					<ul>
						<li>지속가능경영</li>
						<li>지역사회공헌 활동</li>
					</ul>
				</div>
			<!-- 게시판 -->
			<div class="board-s-box" style="font-size: 18px;">
				<!-- 페이지 갯수 -->
				<div class="left" style="font-size: 26px;">
					<p style="font-size: 13px;"><span class="icon" style="font-size: 15px;"><i class="xi-file-o" style="font-size: 14px;"></i>
					</span> 총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" pattern="#,###" /> 건 ,
					 ${paginationInfo.currentPageNo } 페이지
				</div>
				
				<!-- 검색부분 -->
				<div class="right wm100" style="font-size: 26px;">
					<div class="board-search-box bNo" style="font-size: 31px;">
						<select  name="searchCondition" id="searchCondition" class="b-s-select" style="font-size: 12px;">
							<c:forEach items="${BoardColumnList }" var="model">
								<c:if test="${model.BL_LISTVIEW_YN eq 'Y'}">
												<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE }">
										<c:set var="colTitle" value="${model.BL_COLUMN_NAME }" />
										<option style="font-size: 14px;" value="title" selected>${model.BL_COLUMN_NAME }</option>
									</c:if>
									<c:if test="${model.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE }">
										<option style="font-size: 14px;" value="${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</option>
									</c:if>
								</c:if>
							</c:forEach>
							<option style="font-size: 14px;" value="contents">${colTitle }+내용</option>
							<option style="font-size: 14px;" value="all">모두</option>
						</select>
						<input type="text" class="b-s-txt" placeholder="검색어를 입력하세요"  name="searchKeyword" id="searchKeyword"
						onkeydown="if(event.keyCode == 13) pf_boardSearch();"
						style="font-size: 12px;">
						<button type="button" class="btn-search"  onclick="pf_boardSearch()"  style="font-size: 12px;" ><i class="xi-search" style="font-size: 17px;"></i>
						</button>
					</div>
				</div>
				<!-- 이미지 게시판 -->
				<div class="board-video-wrap" style="font-size:22px;">
				
					<c:forEach items="${BoardNoticeDataList }" var="model" varStatus="status">
						<fmt:parseNumber value="${fn:substring(model.BN_KEYNO, 4, 20)}" var="BN_KEYNO_NUMBERTYPE" />
					
						<!-- 함수 -->
						<c:choose>
							<c:when test="${model.BN_DEL_YN eq 'Y' }">
								<c:set var="detailFunction" value="alert('삭제된 게시물입니다.')"/>
							</c:when>
							<c:when test="${BoardType.BT_SECRET_YN eq 'Y' && model.BN_SECRET_YN eq 'Y'}">
								<c:choose>
									<c:when test="${userInfo.isAdmin eq 'Y' || model.BN_REGNM eq userInfo.UI_KEYNO }">
										<c:set var="detailFunction" value="pf_DetailMove('${BN_KEYNO_NUMBERTYPE }')"/>
									</c:when>
									<c:when test="${not empty model.BN_PWD }">
										<c:set var="detailFunction" value="pf_openPWD('${BN_KEYNO_NUMBERTYPE}')"/>
									</c:when>
									<c:otherwise>
										<c:set var="detailFunction" value="pf_NotMyContents()"/>
									</c:otherwise>
								</c:choose>								 
							</c:when>
							<c:otherwise>
								<c:set var="detailFunction" value="pf_DetailMove('${BN_KEYNO_NUMBERTYPE }')"/>
							</c:otherwise>
						</c:choose>
						<!-- 기본 틀 -->
						<div class="one" style="font-size:26px;">
							<a href="javascript:;"onclick="${detailFunction}">
								<!-- 썸네일 -->
								<div class="img-b">
									<c:if test="${model.THUMBNAIL_PATH ne null}">
										<img src="/resources/img/upload/${model.THUMBNAIL_PATH }" alt="이미지">
									</c:if>
								</div>
								
								
								<div class="letter-b">
									<h2 ><c:out value="${model.BN_TITLE }" escapeXml="true"/></h2>
									<div class="c-t-row">
											<p class="date left"><c:out value="${fn:substring(model.BN_REGDT,0,11) }"/></p>
											<p class="count right">조회수 | <b>${model.BN_HITS }</b></p>
									</div>
									
								</div>
							</a>
						</div>
						<!-- 기본틀 끝 -->
						
					</c:forEach>
				</div>
			</div>
			<!-- 버튼 -->
			<c:if test="${userInfo.isAdmin eq 'Y'}">
				<div class="bor-btn-b" style="font-size: 18px;">
					<button type="button" class="btn-write" onclick="pf_RegistMove()" style="font-size: 13px;">글쓰기
					</button>
				</div>
			</c:if>

			<div class="page-box" >
				<ul class="page-ul">
					<ui:pagination paginationInfo="${paginationInfo }"
						type="normal_jact" jsFunction="pf_LinkPage" />
				</ul>
			</div>
		</div>
		</div>
	</div>
</section>

<script>
$(function(){
	 $(li1).hide();
	 $(li2).hide();
	 $(li3).show();
	
})

function setTap(tapId){
	
    var li1 = document.getElementById('li1');
    var li2 = document.getElementById('li2');
    var li3 = document.getElementById('li3');

if(tapId == 1){
 $('.tab1').addClass('active');
    $('.tab2').removeClass('active');
    $('.tab3').removeClass('active');
    
   $(li1).show();
    $(li2).hide();
    $(li3).hide();
    
}else if(tapId == 2){
	 $('.tab1').removeClass('active');
    $('.tab2').addClass('active');
    $('.tab3').removeClass('active');
    
   $(li1).hide();
    $(li2).show();
    $(li3).hide();
}else{
	 $('.tab1').removeClass('active');
	    $('.tab2').removeClass('active');
	    $('.tab3').addClass('active');
	    
	   $(li1).hide();
	    $(li2).hide();
	    $(li3).show();
}

}
</script>	
			