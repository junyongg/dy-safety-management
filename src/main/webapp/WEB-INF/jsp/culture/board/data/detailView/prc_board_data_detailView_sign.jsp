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
		<div class="tab-in-box">
			<ul class="tab_ul tab-3">
				<li><a href="/jact/data/gongsi/budgetmg.do">업무추진비 사용내역</a></li>
				<li><a href="/jact/data/gongsi/cost.do">복리후생비 사용내역</a></li>
				<li class="active"><a href="/jact/data/gongsi/sign.do">조달계약실적</a></li>
			</ul>
		</div>
		<div class="board-detial-view">
			<!-- 제목부분 -->
			<div class="budget-table-wrap">
			<div class="row topRow">
				<div class="left">
					<ul class="in-nor-ul clearfix">
						<li><a href="javascript:;">전체</a></li>
						<li><a href="javascript:;">공사</a></li>
						<li class="active"><a href="javascript:;">용역</a></li>
						<li><a href="javascript:;">물품</a></li>
					</ul>
				</div>
			</div>
				<div class="rowTitle row">
					<h2>계약명 <span class="line">|</span> <c:out value="${BoardNotice.BN_TITLE}" escapeXml="true"/> </h2>
				</div>
			</div>
			
				<div class="budget-tbl-box ">
						<div class="data">
						<table class="tbl_budget">
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								<col width="30%">
							</colgroup>
							<tbody>
				<c:forEach items="${BoardColumnList }" var="bcl" varStatus="status" >
					<c:forEach items="${BoardColumnDataList }" var="model"  >
						<c:if test="${bcl.BL_KEYNO eq model.BD_BL_KEYNO}">
							<c:if test="${bcl.BL_COLUMN_LEVEL ne 5 and bcl.BL_COLUMN_LEVEL ne 7 and bcl.BL_COLUMN_LEVEL ne 9 and bcl.BL_COLUMN_LEVEL ne 11 and bcl.BL_COLUMN_LEVEL ne 13 and bcl.BL_COLUMN_LEVEL ne 17 and  bcl.BL_COLUMN_LEVEL ne 21 and  bcl.BL_COLUMN_LEVEL ne 23 and  bcl.BL_COLUMN_LEVEL ne 26}">
    							<tr>
   							</c:if>
								<c:choose>
									<c:when test="${bcl.BL_COLUMN_LEVEL eq 4 or bcl.BL_COLUMN_LEVEL eq 5 or bcl.BL_COLUMN_LEVEL eq 6 or bcl.BL_COLUMN_LEVEL eq 7 or bcl.BL_COLUMN_LEVEL eq 8 or bcl.BL_COLUMN_LEVEL eq 9 or bcl.BL_COLUMN_LEVEL eq 10 or bcl.BL_COLUMN_LEVEL eq 11 or bcl.BL_COLUMN_LEVEL eq 12 or bcl.BL_COLUMN_LEVEL eq 13 or bcl.BL_COLUMN_LEVEL eq 16 or bcl.BL_COLUMN_LEVEL eq 17 or bcl.BL_COLUMN_LEVEL eq 20 or bcl.BL_COLUMN_LEVEL eq 21 or bcl.BL_COLUMN_LEVEL eq 22 or bcl.BL_COLUMN_LEVEL eq 23 or bcl.BL_COLUMN_LEVEL eq 25 or bcl.BL_COLUMN_LEVEL eq 26 }">
										<th>
											<label>${model.COLUMN_NAME }</label>
										</th>
										<td>${model.BD_DATA } </td>
	    							</c:when>
	    							<c:otherwise>
										<th>
											<label>
												<c:if test="${model.COLUMN_NAME eq '제목' }">
													계약명
												</c:if>
												<c:if test="${model.COLUMN_NAME ne '제목' }">
													${model.COLUMN_NAME }
												</c:if>
											</label>
										</th>
										<td colspan="3">${model.BD_DATA }</td>
   									</c:otherwise>
								</c:choose>								
	       					<c:if test="${bcl.BL_COLUMN_LEVEL eq 5 or bcl.BL_COLUMN_LEVEL eq 7 or bcl.BL_COLUMN_LEVEL eq 9 or bcl.BL_COLUMN_LEVEL eq 11 or bcl.BL_COLUMN_LEVEL eq 13 or bcl.BL_COLUMN_LEVEL eq 17  or bcl.BL_COLUMN_LEVEL eq 21  or bcl.BL_COLUMN_LEVEL eq 23  or bcl.BL_COLUMN_LEVEL eq 26}">
       							</tr>
   							</c:if>
	       				</c:if>
					</c:forEach>
				</c:forEach>
				</tbody>
			</table>
		</div>
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
									<a href="javascript:;" onclick="cf_download('${fs.FS_KEYNO }')">
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
				<!-- 게시판내용 -->
				<div class="content-b">
						<p>
							내용: ${BoardNotice.BN_CONTENTS }
						</p>
				</div>
	
		
