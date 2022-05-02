<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


<!-- 내용시작 -->
<section id="sub-content">
	<div class="inner1200" style="font-size: 13px;">
		<!--서브 타이틀 -->
		<div class="sub-title-box" style="font-size: 15px;">
			<h2 style="font-size: 38px;">${currentMenu.MN_NAME }</h2>
			<ul class="list_ul" style="font-size: 18px;">
				<li class="home" style="font-size: 13px;"><i class="xi-home" style="font-size: 15px;"></i></li>
				<c:forEach items="${fn:split(currentMenu.MN_MAINNAMES,',') }"
					var="model">
					<li style="font-size: 13px;">${model }</li>
				</c:forEach>
			</ul>
		</div>
		<!-- 서브컨텐츠 -->
		<div id="sub-con-start" style="font-size: 15px;">
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
							<a href="javascript:;" style="font-size: 31px;" onclick="${detailFunction}">
								<!-- 썸네일 -->
								<div class="img-b" style="font-size: 37px;">
									<c:if test="${model.THUMBNAIL_PATH ne null}">
										<img src="/resources/img/upload/${model.THUMBNAIL_PATH }" alt="이미지" style="font-size: 13px;">
									</c:if>
								</div>
								
								
								<div class="letter-b" style="font-size: 13px;">
									<h2 style="font-size: 13px;"><c:out value="${model.BN_TITLE }" escapeXml="true"/></h2>
									<p class="date" style="font-size: 13px;"><c:out value="${fn:substring(model.BN_REGDT,0,19) }"/></p>
								</div>
							</a>
						</div>
						<!-- 기본틀 끝 -->
						
					</c:forEach>

					
				</div>
			</div>
			<!-- 버튼 --><!-- 이미지 게시파?  -->
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
</section>
			