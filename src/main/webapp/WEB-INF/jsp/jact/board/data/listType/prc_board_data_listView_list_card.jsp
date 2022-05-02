<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<jsp:useBean id="Today" class="java.util.Date"/>
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

		<!-- 					검색부분 -->
		<fieldset>
			<div class="board-search-box">
				<select name="searchCondition" id="searchCondition"
					class="b-s-select" title="검색 할 내용 선택">
					<c:forEach items="${BoardColumnList }" var="model">
						<c:if test="${model.BL_LISTVIEW_YN eq 'Y'}">
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
				</select> 
				<input type="text" class="b-s-txt" placeholder="검색어를 입력하세요" title="검색어를 입력하세요" name="searchKeyword" id="searchKeyword" 
					onkeydown="if(event.keyCode == 13) pf_boardSearch();">
				<button type="button" class="btn-search" onclick="pf_boardSearch()">
					<i class="xi-search"></i>
				</button>
			</div>
		</fieldset>

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
							onclick="pf_boardSearch(this,'A')">최신순</a></li>
						<li name="new_li" id="old_ul1"><a href="javascript:;"
							onclick="pf_boardSearch(this,'C')">과거순</a></li>
					</ul>
					<div class="sele-b" id="menu_show">
						<select class="list-b">
							<option value="list" id="menu_list">리스트형 보기</option>
							<option value="card" id="menu_card">기사형 보기</option>
						</select>
						<button type="button" class="ok-btn" onclick="pf_changePage()">확인</button>
					</div>
				</div>
			</div>
			<!-- <button Style="float:right;" onclick="rss_maker()">RSS</button> -->
			<!-- 카드형 -->
			<div class="board-card-wrap employ_card_list" id="cards">
				<c:set var="noticeCount" value="0" />
				<c:forEach items="${BoardNoticeDataList }" var="model"
					varStatus="status">
					<!-- 			숫자포맷 -->
					<fmt:parseNumber value="${fn:substring(model.BN_KEYNO, 4, 20)}"
						var="BN_KEYNO_NUMBERTYPE" />

					<!-- 			클릭시 상세페이지로 들어가는 부분 -->
					<c:choose>
						<c:when test="${model.BN_DEL_YN eq 'Y' }">
							<c:set var="detailFunction" value="alert('삭제된 게시물입니다.')" />
						</c:when>
						<c:when
							test="${BoardType.BT_SECRET_YN eq 'Y' && model.BN_SECRET_YN eq 'Y'}">
							<c:choose>
								<c:when
									test="${userInfo.isAdmin eq 'Y' || model.BN_REGNM eq userInfo.UI_KEYNO  || model.WRITE_ID  eq userInfo.UI_KEYNO}">
									<c:set var="detailFunction"
										value="pf_DetailMove('${BN_KEYNO_NUMBERTYPE }')" />
								</c:when>
								<c:when test="${not empty model.BN_PWD }">
									<c:set var="detailFunction"
										value="pf_openPWD('${BN_KEYNO_NUMBERTYPE}')" />
								</c:when>
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

					<div class="one">
						<a href="javascript:;" onclick="${detailFunction}">
							<div class="inner">
								<c:if test="${model.BOARD_TYPE eq 'NOTICE'}">
									<p class="notice">공지</p>
									<c:set var="noticeCount" value="${noticeCount + 1 }" />
								</c:if>

								<c:forEach items="${BoardColumnList }" var="bcl">
									<c:if test="${bcl.BL_LISTVIEW_YN eq 'Y'}">
										<c:set var="columnView" value="false" />
										<c:forEach items="${BoardColumnDataList }" var="bcdl">
											<c:if
												test="${model.BN_KEYNO eq bcdl.BD_BN_KEYNO && bcdl.BD_BL_KEYNO eq bcl.BL_KEYNO}">
												<c:set var="columnView" value="true" />
												<c:choose>
													<c:when
														test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_TITLE}">
														<!-- 제목일 경우 -->
														<p class="sbj">
															<%-- 				            						<a href="javascript:;" onclick="${detailFunction}"> --%>
															<c:forEach begin="1" end="${model.BN_DEPTH }">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
															<c:if
																test="${BoardType.BT_SECRET_YN eq 'Y' && model.BN_SECRET_YN eq 'Y' }">
																<img src="/resources/img/icon/icon_lock.gif"
																	alt="비밀글입니다.">
															</c:if>
															<c:if test="${model.BN_DEPTH gt 0 }">
																<img src="/resources/img/icon/icon_reply.gif"
																	alt="답글입니다.">
															</c:if>

															<c:if test="${model.BN_DEL_YN eq 'N' }">
																<c:out value="${model.BN_TITLE}" escapeXml="true" />
															</c:if>
															<c:if test="${model.BN_DEL_YN eq 'Y' }">
																<span style="color: #c8c8c8; font-size: 13px;">삭제된
																	게시물입니다.</span>
															</c:if>
															<c:if test="${BoardType.BT_COMMENT_YN eq 'Y' }">
																(${model.BN_BC_COUNT})
															</c:if>
															<c:if test="${model.BN_NEW eq '1' }">
																<img src="/resources/img/icon/icon_new.gif" alt="새글입니다.">
															</c:if>
															<c:if test="${model.BN_LINK gt 0 }">
																<img src="/resources/img/icon/icon_link.gif"
																	alt="링크입니다.">
															</c:if>
															<c:if
																test="${BoardType.BT_UPLOAD_YN eq 'Y' && FILE_COUNT > 0}">
																<img src="/resources/img/icon/icon_file.gif" alt="첨부파일">
															</c:if>
															<!-- 												</a> -->
														</p>
													</c:when>

													<c:when
														test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK || bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
														<p class="sbj">${fn:replace(bcdl.BD_DATA,'|',',' ) }</p>
													</c:when>
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_LINK}">
														<p class="sbj">
															<a href="${bcdl.BD_DATA }" target="_blank"><c:out
																	value="${bcdl.BD_DATA }" escapeXml="true" /></a>
														</p>
													</c:when>
													<c:otherwise>
														<p class="sbj">
															
															<c:if test="${currentMenu.MN_MAINKEY eq 'MN_0000001508' }">
																  <fmt:formatDate var="now" value="${Today }" pattern="yyyyMMdd"/>
																  <fmt:parseDate var="dates" value="${bcdl.BD_DATA }" pattern="yyyy-MM-dd"/>
																  <fmt:formatDate var="date" value="${dates }" pattern="yyyyMMdd"/>
																  <fmt:formatDate var="date1" value="${dates }" pattern="yyyy-MM-dd"/>
																  <c:set var="Dday" value="${date - now}"/>
																  
																  <c:if test="${currentMenu.MN_URL eq '/jact/open/hire.do' }">
																	  <c:choose>
																	  		<c:when test="${Dday > 1 }">
																	  			<b style="color: purple;"> D - <c:out value="${Dday }"/> </b>
																	  		</c:when>
																	  		<c:when test="${Dday == 0 }">
																	  			<b class="prog orange">오늘마감</b>
																	  		</c:when>
																	  		<c:otherwise>
																	  			<b class="prog gray">종료</b>
																	  		</c:otherwise>
																	  </c:choose>
																  </c:if>
																  <c:if test="${currentMenu.MN_URL ne '/jact/open/hire.do' }">
																	  <c:if test="${ Dday < 15 && Dday > 0 }">
																		  <b style="color: purple;"> D - <c:out value="${Dday }"/> </b>
																	  </c:if>							
																  </c:if>
															</c:if>
															<c:if test="${currentMenu.MN_MAINKEY ne 'MN_0000001508' }">
																<c:out value="${bcdl.BD_DATA }" escapeXml="true" />	
															</c:if>
														</p>
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

								<p class="date">
									<c:if test="${not empty date }">
										${fn:substring(model.BN_REGDT,0,10) } ~ ${date1 }										
									</c:if>
									<c:if test="${empty date }">
										<c:out value="${fn:substring(model.BN_REGDT,0,10) }"></c:out>
									</c:if>
								</p>
								<button type="button" class="btn-more">자세히 보기</button>
							</div>
						</a>
					</div>
				</c:forEach>

				<c:if test="${paginationInfo.totalRecordCount eq 0}">
					<div class="one">
						<a>
							<div class="inner">
								<p class="sbj">내용 없음</p>
							</div>
						</a>
					</div>
					<script>
						$(
								function() {
									$('.tbl_board_nodata').attr('colspan',
											$('.tbl_board_1 th').length);
								})
					</script>
				</c:if>

			</div>

			<c:if test="${userInfo.isAdmin eq 'Y' || currentMenu.MN_MAINKEY eq 'MN_0000001523' }">
				<div class="bor-btn-b">
					<button type="button" class="btn-write" onclick="pf_RegistMove()">글쓰기
					</button>
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









