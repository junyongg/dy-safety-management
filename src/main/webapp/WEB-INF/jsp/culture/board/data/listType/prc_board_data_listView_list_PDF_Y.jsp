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
		<!-- 탭부분 -->
				<div class="tab-in-box">
					<c:if test="${currentMenu.MN_MAINKEY eq 'MN_0000001598' }">
						<ul class="tab_ul tab-5">
							<li class="tab11"><a href="/culture/business/mahasa1.do">마한사 개괄</a></li>
							<li class="tab22"><a href="/culture/business/mahayungu.do">마한 연구동향</a></li>
							<li class="tab33"><a href="/culture/business/research.do">마한문화 정립·연구</a></li>
							<li class="tab44"><a href="/culture/business/excavation.do">마한 발굴조사</a></li>
							<li class="tab55"><a href="/culture/business/report.do">마한 학술대회</a></li>
							<li class="tab66"><a href="/culture/business/movie.do">영상자료</a></li>
						</ul>
					</c:if>
					<c:if test="${currentMenu.MN_MAINKEY eq 'MN_0000001573' }">					
						<ul class="tab_ul tab-4">
							<li class="tab1 active"><a href="/culture/refer/report.do">학술보고서</a></li>
							<li class="tab2"><a href="/culture/refer/semina.do">학술세미나</a></li>
							<li class="tab3"><a href="/culture/refer/paper.do">학술논문집</a></li>
							<li class="tab4"><a href="/culture/refer/cul.do">무형문화재</a></li>
						</ul>
					</c:if>
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
			<!-- 학술리포트 리스트 -->
			<div class="table-box report-board-list-w">
			
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
				
				
				<div class="one">
				<!-- 썸네일 -->
<!-- 					<div class="in"> -->
						<a href="javascript:;" onclick="${detailFunction}">
						<c:if test="${model.THUMBNAIL_PATH ne null}">
							<div class="img-b" style="background-image: url('/resources/img/upload/${model.THUMBNAIL_PATH }');"></div>
						</c:if>
						<div class="letter-box">
							 <c:forEach items="${BoardColumnList }" var="bcl">
							 	<c:if test="${bcl.BL_LISTVIEW_YN eq 'Y'}">
									<c:set var="columnView" value="false" />
									<c:forEach items="${BoardColumnDataList }" var="bcdl">
							 			<c:if test="${model.BN_KEYNO eq bcdl.BD_BN_KEYNO && bcdl.BD_BL_KEYNO eq bcl.BL_KEYNO}">
											<c:set var="columnView" value="true" />
												<c:choose>
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_TITLE}">
														<!-- 제목일 경우 -->
														<p class="title">
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
														</p>
													</c:when>
			
													<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK || bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
														<p class="sbj">${fn:replace(bcdl.BD_DATA,'|',',' ) }</p>
													</c:when>
													<c:otherwise>
														<p>
															<c:out value="${bcdl.BD_DATA }" escapeXml="true" />
														</p>
													</c:otherwise>
												</c:choose>
												
							 			</c:if>
							 		</c:forEach>
							 	</c:if>
							 </c:forEach>
							 <c:if test="${columnView eq 'false' }">
								<!-- 데이터가 없을경우 공백 뿌려줌 -->
							 </c:if>
								 <p class="name">${model.BN_UI_NAME}</p>
								 <p class="count">조회수 :${model.BN_HITS } </p>
							 </div>
							 <div class="btn-b">
								<button type="button" class="btn-report1" onclick="${detailFunction}">자세히 보기<span class="icon"><i class="xi-plus-thin"></i></span></button>							 
							 </div>	
							 </a>
<!-- 					</div> -->
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
			<!-- 자료실들  -->
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

<script>
	$(function(){
		
		if('${currentMenu.MN_MAINKEY}' == 'MN_0000001573'){
			$('.tab1').removeClass('active');
			$('.tab2').removeClass('active');
			$('.tab3').removeClass('active');
			$('.tab4').removeClass('active');
			$('.tab5').removeClass('active');
			
			if('${currentMenu.MN_NAME }' == '학술세미나'){
				$('.tab2').addClass('active');
			}else if('${currentMenu.MN_NAME }' == '학술논문집'){
				$('.tab3').addClass('active');
			}else if('${currentMenu.MN_NAME }' == '무형문화재'){
				$('.tab4').addClass('active');
			}else{
				$('.tab1').addClass('active');
			}
		}
		
		if('${currentMenu.MN_MAINKEY}' == 'MN_0000001598'){
			$('.tab33').removeClass('active');
			$('.tab44').removeClass('active');
			$('.tab55').removeClass('active');
			
			if('${currentMenu.MN_NAME }' == '마한 발굴조사'){
				$('.tab44').addClass('active');
			}else if('${currentMenu.MN_NAME }' == '마한 학술대회'){
				$('.tab55').addClass('active');
			}else{
				$('.tab33').addClass('active');
			}
		}
	});
</script>







