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
				
				
				<div class="tab-in-box">
					<c:if test="${currentMenu.MN_MAINKEY eq 'MN_0000001598' }">
						<ul class="tab_ul tab-5">
							<li class="tab11"><a href="/culture/business/mahasa1.do">마한사 개괄</a></li>
							<li class="tab22"><a href="/culture/business/mahayungu.do">마한 연구동향</a></li>
							<li class="tab33"><a href="/culture/business/research.do">마한문화 정립·연구</a></li>
							<li class="tab44"><a href="/culture/business/excavation.do">마한 발굴조사</a></li>
							<li class="tab55"><a href="/culture/business/report.do">마한 학술대회</a></li>
							<li class="tab66 active"><a href="/culture/business/movie.do">영상자료</a></li>
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
				
				<div class="row t-bb">
					<div class="left">
						<p>
							<span class="icon"><i class="xi-file-o"></i> 총 <fmt:formatNumber
									value="${paginationInfo.totalRecordCount }" pattern="#,###" />
								건 ,</span> ${paginationInfo.currentPageNo } 페이지
						</p>
					</div>
				</div>
				
				<!-- 동영상 게시판 -->
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
						
						
						<c:forEach items="${BoardColumnList }" var="bcl">
							<c:if test="${bcl.BL_LISTVIEW_YN eq 'Y'}">
								<c:forEach items="${BoardColumnDataList }" var="bcdl">
							 		<c:if test="${model.BN_KEYNO eq bcdl.BD_BN_KEYNO && bcdl.BD_BL_KEYNO eq bcl.BL_KEYNO}">
								 		<c:if test="${bcdl.BD_BL_TYPE  eq 'SC_VEBHI'}">
												<c:set var="youtubelink" value="${bcdl.BD_DATA }"/>					 		
								 		</c:if>
							 		</c:if>
							 	</c:forEach>
						 	</c:if>
					 	</c:forEach>
						
						
						<!-- 기본 틀 -->
						<div class="one" style="font-size:26px;">
							<a href="javascript:;" style="font-size: 31px;" onclick="${detailFunction}">
<%-- 							<a href="javascript:;" style="font-size: 31px;" onclick="window.open('${youtubelink}')"> --%>
								<div class="img-b" style="font-size: 37px;">
								
								<c:if test="${model.THUMBNAIL_PATH ne null}">
										<img src="/resources/img/upload/${model.THUMBNAIL_PATH }" alt="이미지" style="font-size: 13px;">
								</c:if>
								<c:if test="${model.THUMBNAIL_PATH eq null}">
										<c:set var="youtube_code" value="${fn:substring(youtubelink ,fn:indexOf(youtubelink,'.be/' ) + 4, fn:length(youtubelink ))}"/>
										<img src="http://img.youtube.com/vi/${youtube_code }/mqdefault.jpg" alt="이미지" style="font-size: 13px;">								
								</c:if>
<%-- 								<c:set var="separator" value="${fn:substring(model.BN_CONTENTS ,0,15)}"/> --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${separator eq 'http://www.jact' }"> --%>
<!-- 									 mp4 -->
<%-- 									 	<c:set var="mp4_code" value="${fn:substring(model.BN_CONTENTS ,fn:indexOf(model.BN_CONTENTS,'movie/' )+6, fn:length(model.BN_CONTENTS ))}"/> --%>
<%-- 										 <img src="/resources/img/upload/201907122/1/${mp4_code }.jpg" alt="이미지" style="font-size: 13px;"> --%>
<%-- 									</c:when> --%>
<%-- 									<c:when test="${separator eq 'https://www.you' }"> --%>
<!-- 									옛날 유튜브 -->
<%-- 										<c:set var="youtube_code" value="${fn:substring(model.BN_CONTENTS ,fn:indexOf(model.BN_CONTENTS,'embed/' )+6, fn:length(model.BN_CONTENTS ))}"/> --%>
<%-- 										<img src="http://img.youtube.com/vi/${youtube_code }/mqdefault.jpg" alt="이미지" style="font-size: 13px;"> --%>
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<%-- 											<c:set var="youtube_code" value="${fn:substring(model.BN_CONTENTS ,fn:indexOf(model.BN_CONTENTS,'.be/' ) + 4, fn:length(model.BN_CONTENTS ))}"/> --%>
<%-- 											<img src="http://img.youtube.com/vi/${youtube_code }/mqdefault.jpg" alt="이미지" style="font-size: 13px;"> --%>
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
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
</section>
			