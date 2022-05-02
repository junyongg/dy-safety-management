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
		<div class="tab-in-box" style="font-size: 18px;">
			<ul class="tab_ul tab-4 video-tab" style="font-size: 22px;">
<!-- 				<li style="font-size: 26px;"><a href="/jact/archives/picture.do" style="font-size: 13px;">동영상 서비스</a></li> -->
				<li style="font-size: 26px;"><a href="/jact/archives/img.do" style="font-size: 13px;">이미지 서비스</a></li>
				<li style="font-size: 26px;"><a href="/jact/archives/reference.do" style="font-size: 13px;">카드뉴스</a></li>
				<li class="active"  style="font-size: 26px;"><a href="/jact/archives/letter.do" style="font-size: 13px;">E-BOOK</a></li>
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
					<div class="sele-b">
						<select class="list-b" id="select_views">
							<option value="eight" id="eight">8개 보기</option>
							<option value="twelve" id="twelve">12개 보기</option>
						</select>
						<button type="button" class="ok-btn" onclick="ch_views()">확인</button>
					</div>
				</div>
			</div>
			<!-- 발행물 발간물 -->
			<div class="board-publication-wrap">
			
			<c:forEach items="${BoardNoticeDataList }" var="model" varStatus="status">
				<div class="one">
				<!-- 썸네일 -->
					<div class="in">
						<div class="img-b">
							<c:if test="${model.THUMBNAIL_PATH ne null}">
								<img src="/resources/img/upload/${model.THUMBNAIL_PATH }" alt="이미지">
							</c:if>
						</div>
					<div class="letter-b">
					 <c:forEach items="${BoardColumnList }" var="bcl">
					 	<c:if test="${bcl.BL_LISTVIEW_YN eq 'Y'}">
							<c:set var="columnView" value="false" />
							<c:forEach items="${BoardColumnDataList }" var="bcdl">
					 			<c:if test="${model.BN_KEYNO eq bcdl.BD_BN_KEYNO && bcdl.BD_BL_KEYNO eq bcl.BL_KEYNO}">
									<c:set var="columnView" value="true" />
										<c:choose>
											<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_TITLE}">
												<!-- 제목일 경우 -->
												<h2>
													<c:forEach begin="1" end="${model.BN_DEPTH }">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
													
													<c:if test="${model.BN_DEL_YN eq 'N' }">
														<c:out value="${model.BN_TITLE}" escapeXml="true" />
													</c:if>
													
													<c:if test="${model.BN_DEL_YN eq 'Y' }">
														<span style="color: #c8c8c8; font-size: 13px;">삭제된
															게시물입니다.</span>
													</c:if>
													
													<c:if test="${model.BN_NEW eq '1' }">
														<img src="/resources/img/icon/icon_new.gif" alt="새글입니다.">
													</c:if>
												</h2>
											</c:when>
	
											<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK || bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
												<h2 class="sbj">${fn:replace(bcdl.BD_DATA,'|',',' ) }</h2>
											</c:when>
											<c:otherwise>
												<h2>
													<c:out value="${bcdl.BD_DATA }" escapeXml="true" />
												</h2>
											</c:otherwise>
										</c:choose>
										
					 			</c:if>
					 		</c:forEach>
					 	</c:if>
					 </c:forEach>
					 <c:if test="${columnView eq 'false' }">
						<!-- 데이터가 없을경우 공백 뿌려줌 -->
					 </c:if>
					 <c:choose>
					 	<c:when test="${not empty model.BN_FM_KEYNO }">
					 		<p class="date"><c:out value="${fn:substring(model.BN_REGDT,0,10) }"></c:out></p>
							<button type="button" class="btn-down" onclick="cf_downloadPDF('${model.BN_FM_KEYNO}')">PDF 다운받기</button>
					 	</c:when>
					 	<c:otherwise>
					 		<p class="date"><c:out value="${fn:substring(model.BN_REGDT,0,10) }"></c:out></p>
							<button type="button" class="btn-down" onclick="e_book('${model.BN_KEYNO}')">E-BOOK 보기</button>
					 	</c:otherwise>
					 </c:choose>
					 </div>	
					</div>
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
			<c:if test="${userInfo.isAdmin eq 'Y'}">
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









