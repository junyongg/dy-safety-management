<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<style>
/* 페이지 넘버 */
.pageNumberBox {
	text-align: center;
	background: #fff;
	border: none;
	width: auto;
	padding-bottom: 13px;
	font-size: 13px;
	position: relative;
	font-weight: 700;
	font-style: italic;
	color: #969696;
}

.pageNumberUl {
	display: inline-block;
	margin: 0;
}

.pageNumberUl:after {
	visibility: hidden;
	display: block;
	font-size: 0;
	content: ".";
	clear: both;
	height: 0;
	*zoom: 1;
}

.pageNumberUl li {
	float: left;
	margin: 0 2px;
	padding: 3px;
	border: 1px solid #e5e6e5;
	vertical-align: middle;
	min-width: 30px;
}

.pageNumberUl li a {
	font-size: 13px;
	color: #58595b;
	display: inline-block;
	width: 100%;
	height: 100%;
	padding: 2px 5px 3px;
	text-align: center;
}

.pageNumberUl li.active {
	background-color: #58595b;
}

.pageNumberUl li.active a {
	color: #fff;
}

.pagetext {
	font-size: 15px;
}

#textAlign th {
	cursor: pointer;
}

@media all and (max-width:850px) {
	.pageNumberUl {
		margin-top: 10px;
	}
}
/* @media all and (min-width:800px){	
	.smart-form .inline-group .checkbox, .smart-form .inline-group .radio {margin-right:10px;}
	.smart-form .checkbox, .smart-form .radio {padding-left:5px;}
} */
.tblBoardBox {
	overflow-x: scroll;
}

.tblBoardBox th {
	min-width: 200px;
}

.tblBoardBox td.boardSubject {
	min-width: 350px;
}
</style>
<section id="sub-content">
	<div class="inner1200">
		<!-- 타이틀  -->
		<div class="sub-title-box">
			<h2>${currentMenu.MN_NAME }</h2>

			<ul class="list_ul">
				<li class="home"><i class="xi-home"></i></li>
				<c:forEach items="${fn:split(currentMenu.MN_MAINNAMES,',') }"
					var="model">
					<li>${model }</li>
				</c:forEach>
			</ul>
		</div>
		
		
		<c:if test="${currentMenu.MN_KEYNO eq 'MN_0000001518' }">
		<div id="sub-con-start">
				<!-- 2019.08.23 정보공개청구 -->
				<div class="sub-release-info-w">
					
					<p class="sub-in-yellow-title">정보공개제도는?</p>
					<div class="in">
						<div class="re-sub-img">
							<img src="/resources/img/sub/img_sub_release_01.jpg" alt="정보공개">
						</div>

						<div class="re-sub-txt">
							<p class="pp">
								국가기관·지방자치단체 등 공공기관에서 어떤 일을 하고 있고 예산을 어떻게 집행하고 있는지 국민들이 알 수 있도록 공공기관이 보유·관리하는 정보를 국민에게 공개하는 것을 말합니다. 국민의 알권리를 보장함으로써 더 많은 정보를 바탕으로 국정운영에 참여할 수 있도록 하기 위한 제도입니다. 
							</p>
							<button type="button" class="btn-go-release" onclick="window.open('https://www.open.go.kr/')">
								<span class="txt">정보공개시스템 바로가기</span>
								<span class="icon"><i class="xi-external-link"></i></span>
							</button>
						</div>
					</div>

					<div class="gab60"></div>
					
					<p class="sub-in-yellow-title">정보공개 청구절차</p>
					<div class="in">
						<div class="sub-release-step-box">
							<div class="row">
								<div class="one-b">
									<div class="circle">
										<h4>STEP</h4>
										<h2>01</h2>
									</div>
								</div>
								<div class="txt-b">정보공개 청구인은 원하는 정보가 있을 경우 정보공개 시스템(www.open.go.kr)에서 원문을 조회하거나 이를 보유 · 관리하는 공공기관에 정보공개 청구서를 기재하여 제출합니다. 청구를 받은 공공기관은 정보공개처리 대장에 기록하고 청구인에게 접수증을 교부하고, 접수부서는 이를 담당부서 또는 소관기관에 이송하게 됩니다.</div>
							</div>
							<div class="arrow"><img src="/resources/img/icon/icon_arrow_orange_down.png" ></div>
							<div class="row">
								<div class="one-b">
									<div class="circle">
										<h4>STEP</h4>
										<h2>02</h2>
									</div>
								</div>
								<div class="txt-b">공개여부의 결정공공기관은 청구를 받은 날부터 "10일" 이내에 공개여부를 결정해야 하며, 부득이한 경우 10일의 범위내에서 연장할 수 있습니다. 공공기관은 청구정보가 제3자와 관련이 있는 경우 제3자에게 통보하고 필요한 경우 그 의견을 청취하여 결정하게 됩니다. 청구를 받은 공공기관은 정보공개처리대장에 기록하고 청구인에게 접수증을 교부하고, 접수부서는 이를 담당부서 또는 소관기관에 이송하게 됩니다.</div>
							</div>
							<div class="arrow"><img src="/resources/img/icon/icon_arrow_orange_down.png" ></div>
							<div class="row">
								<div class="one-b">
									<div class="circle">
										<h4>STEP</h4>
										<h2>03</h2>
									</div>
								</div>
								<div class="txt-b">공개여부의 결정공공기관이 정보의 공개를 결정한 때에는 공개일시 · 공개장소 등을 명시하여 청구인 에게 통지하되, 공개를 결정한 날로부터 "10일" 이 내에 공개해야 합니다. <br>
								공공기관이 정보를 비공개로 결정한 때에는 비공개사유·불복방법 등을 명시하여 청구인에게 지체 없이 문서로 통지하여야 합니다.</div>
							</div>
						</div>
					</div>


					<div class="gab60"></div>

					<p class="sub-in-yellow-title">정보공개 방법</p>
					<div class="in">
						<div class="sub-release-squre-box">
							<div class="one">
								<div class="icon"><img src="/resources/img/sub/icon_sub_release_01.png" ></div>
								<h2>문서, 도면, 카드, 사진 등</h2>
								<div class="line"></div>
								<h5>
									열람 또는 <br>
									사본의 교부
								</h5>
							</div>

							<div class="one">
								<div class="icon"><img src="/resources/img/sub/icon_sub_release_02.png" ></div>
								<h2>필름, 녹음 · 녹화테이프</h2>
								<div class="line"></div>
								<h5>
									시청 또는 <br>
									인화물 · 복제물 교부
								</h5>
							</div>

							<div class="one">
								<div class="icon"><img src="/resources/img/sub/icon_sub_release_03.png"></div>
								<h2>마이크로필름, 슬라이드</h2>
								<div class="line"></div>
								<h5>
									시청·열람 또는 <br>
									사본 · 복제본의 교부
								</h5>
							</div>

							<div class="one">
								<div class="icon"><img src="/resources/img/sub/icon_sub_release_04.png" ></div>
								<h2>전자적 형태로 보유·관리하는 정보</h2>
								<div class="line"></div>
								<h5>
									파일을 복제하여 정보통신망을 
									활용한 정보공개시스템으로 송부, 
									매체에 저장하여 제공, 열람·시청 
									또는 사본·출력물의 제공
								</h5>
							</div>
						</div>
					</div>

					<div class="gab60"></div>
					<p class="sub-in-yellow-title">정보공개 업무</p>
					<div class="in">
						<p class="release-nor"><b>정보공개 담당부서</b> 정책기획실 경영지원팀 (061 - 280 - 5816)</p>
						<br>
					</div>

				</div>
				<!-- 2019.08.23 정보공개청구 끝!! -->
			</div>
		</c:if>
		
		<c:if test="${currentMenu.MN_KEYNO eq 'MN_0000001557' }">
			<div class="one-one-top-intro">
					<div class="row_1 clearfix">
						<div class="l-b">
							<p class="t-p">
								<span class="txt">STEP <b>01</b></span>
								<span class="icon"><img src="/resources/img/icon/icon_sub_one_01.png"></span>
							</p>
							<p class="s-p">민원접수 처리과정<b>(민원 발생시)</b></p>
						</div>
						<div class="r-b box">
							<div class="one">
								<h2>민원접수</h2>
							</div>
							<div class="arrow"><img src="/resources/img/icon/icon_arrow_orange_up.png"></div>
							<div class="one">
								<h2>관련부서 이관</h2>
							</div>
							<div class="arrow"><img src="/resources/img/icon/icon_arrow_orange_up.png" ></div>
							<div class="one">
								<h2>내부검토</h2>
							</div>
							<div class="arrow"><img src="/resources/img/icon/icon_arrow_orange_up.png" ></div>
							<div class="one">
								<h2>처리결과 통보</h2>
							</div>
						</div>
					</div>

					<div class="row_2 clearfix">
						<div class="l-b">
							<p class="t-p">
								<span class="txt">STEP <b>02</b></span>
								<span class="icon"><img src="/resources/img/icon/icon_sub_one_01.png"></span>
							</p>
							<p class="s-p">민원처리 환류 프로세스<b>(반기별)</b></p>
						</div>
						<div class="r-b box">
							<div class="one">
								<h2>공유</h2>
								<h4>접수 민원 공유</h4>
							</div>
							<div class="arrow"><img src="/resources/img/icon/icon_arrow_orange_up.png" ></div>
							<div class="one">
								<h2>분석</h2>
								<h4>잦은 민원 선정</h4>
							</div>
							<div class="arrow"><img src="/resources/img/icon/icon_arrow_orange_up.png" ></div>
							<div class="one">
								<h2>통계</h2>
								<h4>월별, 분기별, 연도별 <br>분석 및 전체 공지</h4>
							</div>
							<div class="arrow"><img src="/resources/img/icon/icon_arrow_orange_up.png" ></div>
							<div class="one">
								<h2>보상</h2>
								<h4>민원 처리부서 시상</h4>
							</div>
						</div>
					</div>
				</div>
		</c:if>
		
		
		
		
		
		
		<!-- 					검색부분 -->
		<fieldset>
			<div class="board-search-box">
				<select name="searchCondition" id="searchCondition"
					class="b-s-select" title="검색 할 내용 선택">
					<c:forEach items="${BoardColumnList }" var="model">
						<c:if test="${model.BL_LISTVIEW_YN eq 'Y'}"> --%>
										<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE }">
								<c:set var="colTitle" value="${model.BL_COLUMN_NAME }" />
								<option value="title" selected>${model.BL_COLUMN_NAME }</option>
							</c:if>
							<c:if test="${model.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE }">
								<option value="${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</option>
							</c:if>
						</c:if>
					</c:forEach>
					<option value="contents">${colTitle }+내용</option>
					<option value="writer">작성자</option>
					<option value="all">모두</option>
				</select> <input type="text" class="b-s-txt" placeholder="검색어를 입력하세요"
					title="검색어를 입력하세요" name="searchKeyword" id="searchKeyword"
					onkeydown="if(event.keyCode == 13) pf_boardSearch();">
				<button type="button" class="btn-search" onclick="pf_boardSearch()">
					<i class="xi-search"></i>
				</button>
			</div>
		</fieldset>
		
		<c:if test="${currentMenu.MN_KEYNO eq 'MN_0000001545'}">
		<!--  탭부분 -->
		<div class="sub-con-start">
			<div class="tab-in-box">
				<ul class="tab_ul tab-3">
					<li class="active"><a href="/jact/data/gongsi/budgetmg.do" title="업무추진비 사용내역">업무추진비 사용내역</a></li>
					<li><a href="/jact/data/gongsi/cost.do" title="복리후생비 사용내역">복리후생비 사용내역</a></li>
					<li><a href="/jact/data/gongsi/sign.do" title="조달계약실적">조달계약실적</a></li>
				</ul>
			</div>
		</div>
		
		</c:if>
		<c:if test="${currentMenu.MN_KEYNO eq 'MN_0000001566' }">
			<div class="sub-con-start">
				<div class="tab-in-box">
					<ul class="tab_ul tab-3">
						<li ><a href="/jact/data/gongsi/budgetmg.do" title="업무추진비 사용내역">업무추진비 사용내역</a></li>
						<li class="active"><a href="/jact/data/gongsi/cost.do" title="복리후생비 사용내역">복리후생비 사용내역</a></li>
						<li><a href="/jact/data/gongsi/sign.do" title="조달계약실적">조달계약실적</a></li>
					</ul>
				</div>
			</div>
		</c:if>
		
		<!-- 				페이지, 최신순, 과거순, 리스트, 기사형 확인하기	 -->
		<div class="board-s-box">
			<div class="row t-bb">
				<div class="left">
					<p>
						<span class="icon"><i class="xi-file-o"></i> 총 <fmt:formatNumber
								value="${paginationInfo.totalRecordCount }" pattern="#,###" />
							건 ,</span> ${paginationInfo.currentPageNo } 페이지
					</p>
				</div>

				<div class="right">
					<ul class="old_ul">
						<li name="new_li" id="new_li1"><a href="javascript:;"
							onclick="pf_boardSearch(this,'A')" title="가장 나중에 올린 순서대로 정렬합니다.">최신순</a></li>
						<li name="new_li" id="old_ul1"><a href="javascript:;"
							onclick="pf_boardSearch(this,'C')" title="가장 먼저 올린 순서대로 정렬합니다.">과거순</a></li>
					</ul>
					<div class="sele-b" id="menu_show" title="게시물 타입 선택하기">
						<select class="list-b">
							<option value="list" id="menu_list">리스트형 보기</option>
							<option value="card" id="menu_card">기사형 보기</option>
						</select>
						<button type="button" class="ok-btn" onclick="pf_changePage()" title="설정하신 대로 게시판을 보여줍니다.">확인</button>
					</div>
				</div>
			</div>





			<!-- <button Style="float:right;" onclick="rss_maker()">RSS</button> -->
			<!-- 리스트 -->
			<div class="table-box" id="lists">
				<table class="tbl_board_1">
					<colgroup>
						<col width="10%">
						<col width="50%">
						<col width="20%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<caption>게시판 -  ${currentMenu.MN_NAME }</caption>
					<thead>
						<tr>
							<th class="no"><span>No</span></th>
							<c:forEach items="${BoardColumnList }" var="model">
								<c:if test="${model.BL_LISTVIEW_YN eq 'Y'}">
									<th
										class="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE ? 'sbj':'' }">
										<span>${model.BL_COLUMN_NAME }</span>
									</th>
								</c:if>
							</c:forEach>
							<th class="name"><span>작성자</span></th>
							<c:if test="${currentMenu.MN_MAINKEY ne 'MN_0000000278' }">
								<!-- 경영공시쪽 게시판은 작성일 X -->
								<th class="date"><span>작성일</span></th>
							</c:if>
							<th class="count"><span>조회</span></th>
						</tr>
					</thead>
					<tbody>
						<c:set var="noticeCount" value="0" />
						<c:forEach items="${BoardNoticeDataList }" var="model" varStatus="status">
							<fmt:parseNumber value="${fn:substring(model.BN_KEYNO, 4, 20)}"
								var="BN_KEYNO_NUMBERTYPE" />


							<c:choose>
								<c:when test="${model.BN_DEL_YN eq 'Y' }">
									<c:set var="detailFunction" value="alert('삭제된 게시물입니다.')" />
								</c:when>
								<c:when test="${BoardType.BT_SECRET_YN eq 'Y' && model.BN_SECRET_YN eq 'Y'}">
									<c:choose>
										<c:when test="${userInfo.isAdmin eq 'Y' || model.BN_REGNM eq userInfo.UI_KEYNO  || (model.WRITE_ID  eq userInfo.UI_KEYNO && userInfo ne null)}">
												<c:set var="detailFunction" value="pf_DetailMove('${BN_KEYNO_NUMBERTYPE }')" />										
										</c:when>
<%-- 										<c:when test="${not empty model.BN_PWD }"> --%>
<%-- 											<c:set var="detailFunction" --%>
<%-- 												value="pf_openPWD('${BN_KEYNO_NUMBERTYPE}')" /> --%>
<%-- 										</c:when> --%>
										<c:otherwise>
											<c:set var="detailFunction" value="pf_NotMyContents()" />
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:set var="detailFunction"
										value="pf_DetailMove('${BN_KEYNO_NUMBERTYPE }')" />
								</c:otherwise>
							</c:choose>

							<tr
								class="${model.BOARD_TYPE eq 'NOTICE' ? 'boardNotice_Row':''}">
								<td class="number"><c:choose>
										<c:when test="${model.BOARD_TYPE eq 'NOTICE'}">
											<span class="notice">공지</span>
											<c:set var="noticeCount" value="${noticeCount + 1 }" />
										</c:when>
										<c:otherwise>
											<fmt:parseNumber var="numbers" integerOnly="true"
												value="${model.NUM }" />
								${numbers }
							</c:otherwise>
									</c:choose></td>
								<c:forEach items="${BoardColumnList }" var="bcl">

									<c:if test="${bcl.BL_LISTVIEW_YN eq 'Y'}">
										<c:set var="columnView" value="false" />
										<c:forEach items="${BoardColumnDataList }" var="bcdl">
											<c:if
												test="${model.BN_KEYNO eq bcdl.BD_BN_KEYNO && bcdl.BD_BL_KEYNO eq bcl.BL_KEYNO}">
												<c:set var="columnView" value="true" />
												<c:choose>
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_TITLE}">
														<!-- 제목일 경우 -->
														<td class="sbj"><a href="javascript:;" onclick="${detailFunction}"> 
															<c:forEach begin="1" end="${model.BN_DEPTH }">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
																<c:if test="${BoardType.BT_SECRET_YN eq 'Y' && model.BN_SECRET_YN eq 'Y' }">
																	<img src="/resources/img/icon/icon_lock.gif" alt="비밀글입니다.">
																</c:if> <c:if test="${model.BN_DEPTH gt 0 }">
																	<img src="/resources/img/icon/icon_reply.gif" alt="답글입니다.">
																</c:if> <c:if test="${model.BN_DEL_YN eq 'N' }">
																	<c:out value="${model.BN_TITLE}" escapeXml="true" />
																</c:if> <c:if test="${model.BN_DEL_YN eq 'Y' }">
																	<span style="color: #c8c8c8; font-size: 13px;">삭제된 게시물입니다.</span>
																</c:if> <c:if test="${BoardType.BT_COMMENT_YN eq 'Y' }">
																	(${model.BN_BC_COUNT})
																</c:if> <c:if test="${model.BN_NEW eq '1' }">
																	<img src="/resources/img/icon/icon_new.gif"
																		alt="새글입니다.">
																</c:if> <c:if test="${model.BN_LINK gt 0 }">
																	<img src="/resources/img/icon/icon_link.gif"
																		alt="링크입니다.">
																</c:if> <c:if test="${BoardType.BT_UPLOAD_YN eq 'Y' && FILE_COUNT > 0}">
																	<img src="/resources/img/icon/icon_file.gif" alt="첨부파일">
																</c:if>
														</a></td>
													</c:when>
													<c:when
														test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK || bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
														<td>${fn:replace(bcdl.BD_DATA,'|',',' ) }</td>
													</c:when>
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_LINK}">
														<td><a href="${bcdl.BD_DATA }" target="_blank"><c:out
																	value="${bcdl.BD_DATA }" escapeXml="true" /></a></td>
													</c:when>
													<c:otherwise>
														<td><c:out value="${bcdl.BD_DATA }" escapeXml="true" /></td>
													</c:otherwise>
												</c:choose>
											</c:if>
										</c:forEach>
										<c:if test="${columnView eq 'false' }">
											<!-- 데이터가 없을경우 공백 뿌려줌 -->
											<td></td>
										</c:if>
									</c:if>
								</c:forEach>


								<td class="name"><c:out value="${model.BN_UI_NAME}">123</c:out></td>
								<c:if test="${currentMenu.MN_MAINKEY ne 'MN_0000000278' }">
									<!-- 경영공시쪽 게시판은 작성일 X -->
									<td class="date"><c:out
											value="${fn:substring(model.BN_REGDT,0,10) }"></c:out></td>
								</c:if>
								<td class="count"><c:out value="${model.BN_HITS}"></c:out></td>
							</tr>
							<%-- <tr class="tbl_board_con"
					id="tbl_contents_tr_${BN_KEYNO_NUMBERTYPE }"
					style="display: none;">
					<td></td>
				</tr> --%>
						</c:forEach>
						<c:if test="${paginationInfo.totalRecordCount eq 0}">
							<tr>
								<td class="tbl_board_nodata" colspan="5"
									style="color: #777; text-align: center;">내용없음</td>
							</tr>
							<script>
								$(
										function() {
											$('.tbl_board_nodata')
													.attr(
															'colspan',
															$('.tbl_board_1 th').length);
										})
							</script>
						</c:if>
					</tbody>
				</table>
			</div>


			<c:if test="${userInfo.isAdmin eq 'Y' || (currentMenu.MN_MAINKEY eq 'MN_0000001523'&& userInfo ne null) }">
				<div class="bor-btn-b">
					<button type="button" class="btn-write" onclick="pf_RegistMove()" title="글쓰기">글쓰기</button>
				</div>
			</c:if>


			<div class="page-box">
				<ul class="page-ul">
					<ui:pagination paginationInfo="${paginationInfo }"
						type="normal_jact" jsFunction="pf_LinkPage" />
				</ul>
			</div>
		</div>
</section>









