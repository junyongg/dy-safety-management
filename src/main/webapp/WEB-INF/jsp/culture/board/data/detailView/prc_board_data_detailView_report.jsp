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
		
		
			<!-- 탭부분 -->
				<div class="tab-in-box">
					<c:if test="${currentMenu.MN_MAINKEY eq 'MN_0000001598' }">
						<ul class="tab_ul tab-3">
							<li class="tab11 active"><a href="/culture/business/research.do">마한문화 정립·연구</a></li>
							<li class="tab22"><a href="/culture/business/excavation.do">마한 발굴조사</a></li>
							<li class="tab33"><a href="/culture/business/report.do">마한 학술대회</a></li>
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
		
			<div class="report-bo-content-wrap">
			<!-- 이미지 -->
			<div class="img-box" style="background-image:url('/resources/img/upload/${BoardNotice.THUMBNAIL_PATH }');"></div>
			
			<!-- 컨텐츠 -->
			<div class="content-box">
				<div class="title"><c:out value="${BoardNotice.BN_TITLE}" escapeXml="true"/></div>
				
					<c:forEach items="${BoardColumnList }" var="bcl">
						<c:if test="${bcl.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE}">
							<c:forEach items="${BoardColumnDataList }" var="model">
								<c:if test="${not empty model.BD_DATA && bcl.BL_KEYNO eq model.BD_BL_KEYNO}">
									<div class="publish">
										<div class="bold">${model.COLUMN_NAME }</div>
										<div class="con"><c:out value="${model.BD_DATA }" escapeXml="true"/></div>
									</div>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				
				<div class="content1">							
					<div class="bold">내용</div>
					<div class="con">
						<pre>${BoardNotice.BN_CONTENTS }</pre>
					</div>
				</div>
				<div class="info">
					<div class="left">
						<div class="col">							
							<div class="bold">작성자</div>
							<div class="con">${BoardNotice.BN_UI_NAME }</div>
						</div>
					</div>
					<div class="right">
						<div class="col">
							<div class="bold">날짜</div>
							<div class="con">${fn:substring(BoardNotice.BN_REGDT,0,10) }</div>
						</div>
						<div class="col">
							<div class="bold">조회</div>
							<div class="con">${BoardNotice.BN_HITS }회</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
			<!-- 첨부파일 -->
			
			<c:if test="${BoardType.BT_UPLOAD_YN eq 'Y' && fn:length(FileSub) gt 0 }">
				<div class="report-bo-attach-wrap">
					<c:forEach items="${FileSub}" var="fs">
						<div class="left title">
							<a href="javascript:;" onclick="cf_download('${fs.FS_KEYNO }')">
								${fs.FS_ORINM }
								<c:if test="${fs.FS_FILE_SIZE / 1024  gt 1000}">
									(<fmt:formatNumber value="${fs.FS_FILE_SIZE / 1024 / 1024 }" pattern=".0"/>M)
								</c:if>
								<c:if test="${fs.FS_FILE_SIZE / 1000  le 1000}">
									(<fmt:formatNumber value="${fs.FS_FILE_SIZE / 1024 }" pattern=".0"/>K)
								</c:if> 
							</a>
						</div>
						<div class="right info">
							<span class="col-in">${fs.FS_DOWNCNT}회 다운로드</span>
							<span class="col-in">DATE : ${fn:substring(fs.FS_REGDT,0,10) }</span>
						</div>
					</c:forEach>
				</div>
				</c:if>
				<!-- 게시판내용 -->
<!-- 				<div class="content-b"> -->
<!-- 						<p> -->
<%-- 							<pre>${BoardNotice.BN_CONTENTS }</pre> --%>
<!-- 						</p> -->
<!-- 				</div> -->
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
			$('.tab11').removeClass('active');
			$('.tab22').removeClass('active');
			$('.tab33').removeClass('active');
			
			if('${currentMenu.MN_NAME }' == '마한 발굴조사'){
				$('.tab22').addClass('active');
			}else if('${currentMenu.MN_NAME }' == '마한 학술대회'){
				$('.tab33').addClass('active');
			}else{
				$('.tab11').addClass('active');
			}
		}
	});
</script>	
		
