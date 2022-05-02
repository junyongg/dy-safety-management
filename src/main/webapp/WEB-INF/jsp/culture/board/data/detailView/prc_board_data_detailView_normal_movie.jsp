<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
	
<section id="sub-content">
	<div class="inner1200">
		<!-- 타이틀 -->
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
		<!-- 서브 컨텐츠 시작 -->
		<div id="sub-con-start">
			<div class="board-detial-view">
			<!-- 제목부분 -->
				<div class="top-b">
					<p class="sbj-t">
						<c:out value="${BoardNotice.BN_TITLE}" escapeXml="true"/>
					</p>
					<div class="data">
						<p class="name"><b>작성자</b> ${BoardNotice.BN_UI_NAME }</p>
						<p class="date"><b>작성일</b> ${fn:substring(BoardNotice.BN_REGDT,0,10) }</p>
						<p class="count"><b>조회</b> ${BoardNotice.BN_HITS }</p>
					</div>
				</div>
				 <c:forEach items="${BoardColumnList }" var="bcl">
        			<c:if test="${bcl.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE}">
					<c:forEach items="${BoardColumnDataList }" var="model">
	       				 <c:if test="${not empty model.BD_DATA && bcl.BL_KEYNO eq model.BD_BL_KEYNO}">
							<div class="data" style="margin-top: 40px;">
								<p>
<%-- 									<span>${model.COLUMN_NAME }</span> --%>
									<c:choose>
										<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK }">${fn:replace(model.BD_DATA,'|',',' ) }</c:when>
										<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">${fn:replace(model.BD_DATA,'|',',' ) }</c:when>
										<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_LINK}">
					           				<a href="${model.BD_DATA }" target="_blank"><c:out value="${model.BD_DATA }" escapeXml="true"/></a>
					           			</c:when>
										<c:otherwise>
											<c:set var="youtube_code" value="${fn:substring(model.BD_DATA ,fn:indexOf(model.BD_DATA,'.be/' ) + 4, fn:length(model.BD_DATA ))}"/>
											<iframe width="1198" height="700" src="https://www.youtube.com/embed/${youtube_code }" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
	 										</iframe>
										</c:otherwise>
									</c:choose>
								</p>
							</div>
						</c:if>
					</c:forEach>
					</c:if>
				</c:forEach>
				<!-- 첨부파일 -->
<%-- 				<c:if test="${BoardType.BT_UPLOAD_YN eq 'Y' && fn:length(FileSub) gt 0 }"> --%>
<!-- 				<div class="attach-b"> -->
<!-- 					<ul> -->
<%-- 					<c:forEach items="${FileSub}" var="fs"> --%>
<!-- 						<li> -->
<!-- 							<a href="javascript:;"> -->
<!-- 								<span class="icon"><i class="xi-folder-download-o"></i></span> -->
<!-- 								<span class="txt"> -->
<%-- 									<a href="javascript:;" onclick="cf_download('${fs.FS_KEYNO }')"> --%>
<%-- 										${fs.FS_ORINM } --%>
<%-- 									<c:if test="${fs.FS_FILE_SIZE / 1024  gt 1000}"> --%>
<%-- 										(<fmt:formatNumber value="${fs.FS_FILE_SIZE / 1024 / 1024 }" pattern=".0"/>M) --%>
<%-- 									</c:if> --%>
<%-- 									<c:if test="${fs.FS_FILE_SIZE / 1000  le 1000}"> --%>
<%-- 										(<fmt:formatNumber value="${fs.FS_FILE_SIZE / 1024 }" pattern=".0"/>K) --%>
<%-- 									</c:if> 	 --%>
<!-- 									</a> -->
<!-- 								</span> -->
<!-- 							</a> -->
<!-- 						</li> -->
<%-- 					</c:forEach> --%>
<!-- 					</ul> -->
<!-- 				</div> -->
<%-- 				</c:if> --%>
				<!-- 첨부파일 -->
				<c:if test="${BoardType.BT_UPLOAD_YN eq 'Y' && fn:length(FileSub) gt 0 }">
								<p style="margin-top: 50px;">
									<c:forEach items="${FileSub}" var="fs">
								 	<video width="1198px" height="700px" autoplay="autoplay" controls="controls">
								 		<source src="/resources/img/upload/${fs.FS_FOLDER}${fs.FS_CHANGENM }.${fs.FS_EXT}" type="video/mp4">
								 		 Sorry, your browser doesn't support embedded videos.
								 	</video>	
									</c:forEach>
								</p>
				</c:if>
				<!-- 게시판내용 -->
				<div class="content-b" style="padding-left: 0px;">
						<p>
							${BoardNotice.BN_CONTENTS }
						</p>
				</div>
	
		
