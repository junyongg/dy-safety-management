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
				 <c:forEach items="${BoardColumnList }" var="bcl">
        			<c:if test="${bcl.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE}">
					<c:forEach items="${BoardColumnDataList }" var="model">
	       				 <c:if test="${not empty model.BD_DATA && bcl.BL_KEYNO eq model.BD_BL_KEYNO}">
							<div class="data2" style="color: #777;font-size: 14px;margin-top: 7px;">
								<p>
<%-- 									<span>${model.COLUMN_NAME }</span> --%>
									<c:choose>
										<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK }">${fn:replace(model.BD_DATA,'|',',' ) }</c:when>
										<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">${fn:replace(model.BD_DATA,'|',',' ) }</c:when>
										<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_LINK}">
					           				<a href="${model.BD_DATA }" target="_blank"><c:out value="${model.BD_DATA }" escapeXml="true"/></a>
					           			</c:when>
					           			<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_SELECT}">
					           				<input type="hidden" id="classType" value="${model.BD_DATA }">
					           				<c:set var="Ctype" value="${model.BD_DATA}"/>
					           			</c:when>
					           			<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_RADIO }"></c:when>
					           			<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_START }">
											<fmt:parseNumber value="${toDay.time }" integerOnly="true" var="nowDate2"></fmt:parseNumber>
											
											<fmt:parseDate var="date_st" value="${model.BD_DATA }" pattern="yyyy-MM-dd HH:mm"/>
											<fmt:parseNumber value="${date_st.time }" integerOnly="true" var="startDate"></fmt:parseNumber>
											<c:set var="Preday" value="${startDate - nowDate2}"/>
					           			</c:when>
					           			<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CALENDAR_END }">
					           				<fmt:parseDate var="date1" value="${model.BD_DATA }" pattern="yyyy-MM-dd HH:mm"/>
					           				<fmt:parseNumber value="${toDay.time }" integerOnly="true" var="nowDate2"></fmt:parseNumber>
					           				<fmt:parseNumber value="${date1.time}" integerOnly="true" var="endDate2"></fmt:parseNumber>
											<c:set var="TommorrowDay" value="${endDate2 - nowDate2}"/>
											<fmt:parseNumber value="${toDay.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
											<fmt:parseNumber value="${date1.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>

											<c:set var="Dday" value="${endDate + 1 - nowDate}"/>
											<%-- <c:if test="${Dday >= 0 }">
												*현재기준으로 종료일<b> <c:out value="${fn:substring(model.BD_DATA,0,11) }" escapeXml="true"/></b>까지  <b>${Dday }일</b> 남았습니다.
											</c:if> --%>	
					           			</c:when>
									</c:choose>
								</p>
							</div>
						</c:if>
					</c:forEach>
					</c:if>
				</c:forEach>
				</div>
				<!-- 첨부파일 -->
				<c:if test="${BoardType.BT_UPLOAD_YN eq 'Y' && fn:length(FileSub) gt 0 }">
				<div class="attach-b">
					<ul>
					<c:forEach items="${FileSub}" var="fs">
						<li>
							<a href="javascript:;">
								<span class="icon"><i class="xi-folder-download-o"></i></span>
								<span class="txt">
									<a href="javascript:;" onclick="cf_download('${fs.FS_KEYNO }')" title="${fs.FS_ORINM }">
										${fs.FS_ORINM }
									<c:if test="${fs.FS_FILE_SIZE / 1024  gt 1000}">
										(<fmt:formatNumber value="${fs.FS_FILE_SIZE / 1024 / 1024 }" pattern=".0"/>M)
									</c:if>
									<c:if test="${fs.FS_FILE_SIZE / 1000  le 1000}">
										(<fmt:formatNumber value="${fs.FS_FILE_SIZE / 1024 }" pattern=".0"/>K)
									</c:if> 	
									</a>
<!-- 									<div> -->
<%-- 										첨부파일 조회 : ${fs.FS_DOWNCNT} --%>
<!-- 									</div> -->
								</span>
							</a>
						</li>
					</c:forEach>
					</ul>
				</div>
				</c:if>
				<c:if test="${empty Preday }">
					<c:set var="Preday" value="0"/>
				</c:if>
				<c:if test="${TommorrowDay >= 0 &&  Preday <= 0}">
					<div class="btn_support_box">
						<c:if test="${not empty Ctype }">
							<c:if test="${empty BoardNotice.BN_HIRE_KEY }">
								<button type="button" type="button" class="btn_support purple"  onclick="hireInsert();" title="지원서 작성"><i class="xi-pen"></i> 지원서 작성</button>
								<button type="button" type="button" class="btn_support gray" onclick="hireUpdate();" title="지원서 수정"><i class="xi-external-link"></i> 지원서 수정</button>
								<button type="button" type="button" class="btn_support gray" onclick="hireDelete();" title="지원 취소"><i class="xi-alarm-clock-off"></i> 지원 취소</button>
							</c:if>
							<c:if test="${not empty BoardNotice.BN_HIRE_KEY }">
								<button type="button" type="button" class="btn_support purple" onclick="hireResult();" title="지원서 수정"><i class="xi-external-link"></i> 합격 확인</button>
							</c:if>
						</c:if>
					</div>
				</c:if>
				<!-- 게시판내용 -->
				<div class="content-b">
						<p>
							${BoardNotice.BN_CONTENTS }
						</p>
				</div>
	
		
