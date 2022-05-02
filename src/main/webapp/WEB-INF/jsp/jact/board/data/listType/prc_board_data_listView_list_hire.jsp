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

<fmt:parseNumber value="${toDay.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
<fmt:parseNumber value="${toDay.time }" integerOnly="true" var="nowDate2"></fmt:parseNumber>

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
						<c:if test="${model.BL_LISTVIEW_YN eq 'Y'}"> --%>
							<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE }">
								<c:set var="colTitle" value="${model.BL_COLUMN_NAME }" />
								<option value="title" selected>${model.BL_COLUMN_NAME }</option>
							</c:if>
<%-- 							<c:if test="${model.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE }"> --%>
<%-- 								<option value="${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</option> --%>
<%-- 							</c:if> --%>
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
					<div class="sele-b" id="menu_show">
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
				<table class="tbl_board_1 tbl_employ_list">
					<colgroup>
						<col width="10%">
						<col width="50%">
						<col width="20%">
						<col width="10%">
<!-- 						<col width="10%"> -->
					</colgroup>
					<caption>게시판</caption>
					<thead>
						<tr>
							<th class="no"><span>No</span></th>
							<c:forEach items="${BoardColumnList }" var="model">
								<c:if test="${model.BL_LISTVIEW_YN eq 'Y'}">
									<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE}">
										<th
											class="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE ? 'sbj':'' }">
											<span>${model.BL_COLUMN_NAME }</span>
										</th>
									</c:if>
								</c:if>
							</c:forEach>
							<th class="name"><span>진행상황</span></th>
							<c:if test="${currentMenu.MN_MAINKEY ne 'MN_0000000278' }">
								<!-- 경영공시쪽 게시판은 작성일 X -->
								<th class="date"><span>등록일</span></th>
							</c:if>
<!-- 							<th class="count"><span>조회</span></th> -->
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

							<tr class="${model.BOARD_TYPE eq 'NOTICE' ? 'boardNotice_Row':''}">
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
									</c:choose>
								</td>
									<td class="sbj">
									<a href="javascript:;" onclick="${detailFunction}" style="float: left;"> 
								
								<c:set var="Preday" value="0"/>
								<c:set var="TommorrowDay" value="-1"/>
								<c:set var="STDT" value="${fn:substring(model.BN_REGDT,0,10)}"/>
								
								<c:forEach items="${BoardColumnList }" var="bcl">
									<c:if test="${bcl.BL_LISTVIEW_YN eq 'Y'}">
										<c:set var="columnView" value="false" />
										<c:forEach items="${BoardColumnDataList }" var="bcdl">
											<c:if test="${model.BN_KEYNO eq bcdl.BD_BN_KEYNO && bcdl.BD_BL_KEYNO eq bcl.BL_KEYNO}">
												<c:set var="columnView" value="true" />
												<c:choose>
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_TITLE}">
														<!-- 제목일 경우 -->
															<c:forEach begin="1" end="${model.BN_DEPTH }">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
																<c:if test="${BoardType.BT_SECRET_YN eq 'Y' && model.BN_SECRET_YN eq 'Y' }">
																	<img src="/resources/img/icon/icon_lock.gif" alt="비밀글입니다.">
																</c:if> 
																<c:if test="${model.BN_DEPTH gt 0 }">
																	<img src="/resources/img/icon/icon_reply.gif" alt="답글입니다.">
																</c:if> 
																<c:if test="${model.BN_DEL_YN eq 'N' }">
																	<c:if test="${fn:length(model.BN_TITLE) > 35 }">
																		${fn:substring(model.BN_TITLE,0,35) }...
																	</c:if>
																	<c:if test="${fn:length(model.BN_TITLE) <= 35 }">
 																		<c:out value="${model.BN_TITLE}" escapeXml="true" /> 
																	</c:if>
																</c:if> 
																<c:if test="${model.BN_DEL_YN eq 'Y' }">
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
														
													</c:when>
													<c:when	test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK || bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
														<td>${fn:replace(bcdl.BD_DATA,'|',',' ) }</td>
													</c:when>
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_LINK}">
														<td><a href="${bcdl.BD_DATA }" target="_blank">
														<c:out value="${bcdl.BD_DATA }" escapeXml="true" /></a></td>
													</c:when>
													
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_START}">
														<c:set var="STDT" value="${bcdl.BD_DATA }"/>
														
														<fmt:parseDate var="date_st" value="${bcdl.BD_DATA }" pattern="yyyy-MM-dd HH:mm"/>
														<fmt:parseNumber value="${date_st.time }" integerOnly="true" var="startDate"></fmt:parseNumber>
														<c:set var="Preday" value="${startDate - nowDate2}"/>
													</c:when>
													
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_END}">
														<c:set var="ENDT" value="${bcdl.BD_DATA }"/>
														<fmt:parseDate var="date_ed" value="${bcdl.BD_DATA }" pattern="yyyy-MM-dd HH:mm"/>
														<fmt:parseNumber value="${date_ed.time}" integerOnly="true" var="endDate2"></fmt:parseNumber>
														<c:set var="TommorrowDay" value="${endDate2 - nowDate2}"/>
														
														<fmt:parseNumber value="${date_ed.time/ (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
														<c:set var="Dday" value="${(endDate+1) - nowDate}"/>
													</c:when>
													
													<c:otherwise>
<%-- 															<fmt:formatDate var="now" value="${toDay }" pattern="yyyy-MM-dd"/> --%>
<%-- 															<fmt:formatDate var="date" value="${date1 }" pattern="yyyy-MM-dd"/> --%>
															<%-- <fmt:parseNumber value="${toDay.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber> --%>
															<%--  <c:if test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_START}">
																<fmt:parseDate var="date_st" value="${bcdl.BD_DATA }" pattern="yyyy-MM-dd"/>
																<fmt:parseNumber value="${date_st.time / (1000*60*60*24)}" integerOnly="true" var="startDate"></fmt:parseNumber>
																<c:set var="Preday" value="${nowDate - startDate}"/>
															</c:if>

															<c:if test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_END}">
																<fmt:parseDate var="date_ed" value="${bcdl.BD_DATA }" pattern="yyyy-MM-dd"/>
																<fmt:parseNumber value="${date_ed.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
																<c:set var="Dday" value="${(endDate+1) - nowDate}"/>
															</c:if>  --%>
													</c:otherwise>
												</c:choose>
											</c:if>
										</c:forEach>
										
										<c:if test="${columnView eq 'false' }">
											<!-- 데이터가 없을경우 공백 뿌려줌 -->
<!-- 											<td></td> -->
										</c:if>
									</c:if>
								</c:forEach>
										<c:choose>
											<c:when test="${empty ENDT }">
												<c:set var="current" value="오프라인"/>
												<c:set var="classname" value="prog cherry"/>
											</c:when>
											<c:when test="${Preday > 0 }">
												<c:set var="current" value="접수예정"/>
												<c:set var="classname" value="prog orange"/>
												<b style=" color: purple; font-size: 14px; font-weight: 700;"> D - <c:out value="${Dday }"/> </b>
<%-- 												<p class="sbj_date1">${fn:substring(model.BN_REGDT,0,10) } ~ ${bcdl.BD_DATA } </p> --%>
												<p class="sbj_date1">${fn:substring(STDT,0,10) } ~ ${fn:substring(ENDT,0,10) } </p>
											</c:when>
											<c:when test="${TommorrowDay > 0 }">
												<c:set var="current" value="접수중"/>
												<c:set var="classname" value="prog purple"/>
												<b style=" color: purple; font-size: 14px; font-weight: 700;"> D - <c:out value="${Dday }"/> </b>
												<p class="sbj_date1">${empty STDT? fn:substring(model.BN_REGDT,0,10):fn:substring(STDT,0,10)  } ~ ${fn:substring(ENDT,0,10) } </p>
											</c:when>
											<c:when test="${TommorrowDay == 0 }">
												<c:set var="current" value="지금 마감"/>
												<c:set var="classname" value="prog sky"/>
												<b style=" color: purple; font-size: 14px; font-weight: 700;"> D - day </b>
												<p class="sbj_date1">${empty STDT? fn:substring(model.BN_REGDT,0,10):fn:substring(STDT,0,10)  } ~ ${fn:substring(ENDT,0,10) } </p>
											</c:when>
											<c:otherwise>
												<c:set var="current" value="종료"/>
												<c:set var="classname" value="prog gray"/>
											</c:otherwise>
										</c:choose> 
								</a>
						</td>
								<td class="name"><span class="${classname }">${current }</span></td>
								<c:if test="${currentMenu.MN_MAINKEY ne 'MN_0000000278' }">
									<!-- 경영공시쪽 게시판은 작성일 X -->
									<td class="date"><c:out
											value="${fn:substring(model.BN_REGDT,0,10) }"></c:out></td>
								</c:if>
<%-- 								<td class="count"><c:out value="${model.BN_HITS}"></c:out></td> --%>
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
					<button type="button" class="btn-write" onclick="pf_RegistMove()">글쓰기</button>
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









