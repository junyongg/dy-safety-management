<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<link href="/resources/publish/jact/css/sub.css" rel="stylesheet" type="text/css" />

<!-- 내용시작 -->
<section id="sub-content">
	<div class="inner1200" style="font-size: 13px;">
		<!--서브 타이틀 -->
		
		<c:choose>
			<c:when test="${currentMenu.MN_URL eq '/jact/operation/active.do' }">
					<div class="sub-title-box" style="font-size: 15px;">
						<h2 style="font-size: 45px; font-weight: 600px;">지속가능경영</h2>
						<ul class="list_ul" style="font-size: 18px;">
							<li class="home" style="font-size: 13px;"><i class="xi-home" style="font-size: 15px;"></i></li>
								<li style="font-size: 15px;font-weight: 500px;">사회책임경영</li>
								<li style="font-size: 15px;font-weight: 500px;">지속가능경영</li>
						</ul>
					</div>
					
					
					<!-- 서브컨텐츠 -->
					<div class="sub-business-content" id="sub-con-start" style="font-size: 15px;">
						
						<!-- 동영상 이미지 탭부분 -->
						<div class="tab-in-box">
							<ul class="tab_ul tab-3">
								<li ><a href="/jact/operation/Sustainability.do" >지속가능경영비전</a></li>
								<li ><a href="/jact/operation/Sustainability.do?step=2">사회 공헌 헌장</a></li>
								<li class="active"><a>지역사회공헌 활동</a></li>
							</ul>
						</div>
						
						<div id="li3" >
							
							<div class="top-s-title">
								<ul>
									<li>지속가능경영</li>
									<li>지역사회공헌 활동</li>
								</ul>
							</div>
			</c:when>
			<c:when test="${currentMenu.MN_URL eq '/jact/operation/ingun.do' }">
				<div class="sub-title-box" style="font-size: 15px;">
					<h2 style="font-size: 45px; font-weight: 600px;">인권경영</h2>
					<ul class="list_ul" style="font-size: 18px;">
						<li class="home" style="font-size: 13px;"><i class="xi-home" style="font-size: 15px;"></i></li>
							<li style="font-size: 15px;font-weight: 500px;">사회책임경영</li>
							<li style="font-size: 15px;font-weight: 500px;">인권경영</li>
					</ul>
				</div>
				
				
				<!-- 서브컨텐츠 -->
				<div class="sub-business-content" id="sub-con-start" style="font-size: 15px;">
					
					<!-- 동영상 이미지 탭부분 -->
					<div class="tab-in-box">
						<ul class="tab_ul tab-3 tab-4">
							<li ><a href="/jact/operation/private.do" >인권경영 비전 및 전력체계</a></li>
							<li ><a href="/jact/operation/private.do?step=2">인권경영 헌장</a></li>
							<li ><a href="/jact/operation/private.do?step=3">인권 침핵의 구제</a></li>
							<li class="active"><a>인권경영 활동</a></li>
						</ul>
					</div>
					
					<div id="li3" >
						
						<div class="top-s-title">
							<ul>
								<li>인권경영</li>
								<li>인권경영 활동</li>
							</ul>
						</div>
			
			</c:when>
			<c:when test="${currentMenu.MN_URL eq '/jact/operation/unri.do' }">
				<div class="sub-title-box" style="font-size: 15px;">
					<h2 style="font-size: 45px; font-weight: 600px;">윤리경영</h2>
					<ul class="list_ul" style="font-size: 18px;">
						<li class="home" style="font-size: 13px;"><i class="xi-home" style="font-size: 15px;"></i></li>
							<li style="font-size: 15px;font-weight: 500px;">사회책임경영</li>
							<li style="font-size: 15px;font-weight: 500px;">윤리경영</li>
					</ul>
				</div>
				
				
				<!-- 서브컨텐츠 -->
				<div class="sub-business-content" id="sub-con-start" style="font-size: 15px;">
					
					<!-- 동영상 이미지 탭부분 -->
					<div class="tab-in-box">
						<ul class="tab_ul tab-3 tab-4">
							<li ><a href="/jact/operation/management.do" >고객만족 전략</a></li>
							<li ><a href="/jact/operation/management.do?step=2">윤리헌장</a></li>
							<li ><a href="/jact/operation/management.do?step=3">부조리 통합신고센터</a></li>
							<li class="active"><a>윤리경영 활동</a></li>
						</ul>
					</div>
					
					<div id="li3" >
						
						<div class="top-s-title">
							<ul>
								<li>윤리경영</li>
								<li>윤리경영 활동</li>
							</ul>
						</div>
			</c:when>
			<c:otherwise>
				<div class="sub-title-box" style="font-size: 15px;">
					<h2 style="font-size: 45px; font-weight: 600px;">안전제일경영</h2>
					<ul class="list_ul" style="font-size: 18px;">
						<li class="home" style="font-size: 13px;"><i class="xi-home" style="font-size: 15px;"></i></li>
							<li style="font-size: 15px;font-weight: 500px;">사회책임경영</li>
							<li style="font-size: 15px;font-weight: 500px;">안전제일경영</li>
					</ul>
				</div>
				
				
				<!-- 서브컨텐츠 -->
				<div class="sub-business-content" id="sub-con-start" style="font-size: 15px;">
					
					<!-- 동영상 이미지 탭부분 -->
					<div class="tab-in-box">
						<ul class="tab_ul tab-3">
							<li ><a href="/jact/operation/safety.do" >안전제일경영 비전</a></li>
							<li ><a href="/jact/operation/safety.do?step=2">안전관리헌장</a></li>
							<li class="active"><a>안전제일경영 활동</a></li>
						</ul>
					</div>
					
					<div id="li3" >
						
						<div class="top-s-title">
							<ul>
								<li>안전제일경영</li>
								<li>안전제일경영 활동</li>
							</ul>
						</div>
			</c:otherwise>
		</c:choose>
				
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
							<a href="javascript:;"onclick="${detailFunction}">
								<!-- 썸네일 -->
								<div class="img-b">
									<c:if test="${model.THUMBNAIL_PATH ne null}">
										<img src="/resources/img/upload/${model.THUMBNAIL_PATH }" alt="">
									</c:if>
								</div>
								
								
								<div class="letter-b">
									<h2 ><c:out value="${model.BN_TITLE }" escapeXml="true"/></h2>
									<div class="c-t-row">
											<p class="date left"><c:out value="${fn:substring(model.BN_REGDT,0,11) }"/></p>
											<p class="count right">조회수 | <b>${model.BN_HITS }</b></p>
									</div>
									
								</div>
							</a>
						</div>
						<!-- 기본틀 끝 -->
						
					</c:forEach>
				</div>
				<c:if test="${empty BoardNoticeDataList }">
					등록된 데이터가 없습니다.
				</c:if>
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
	</div>
</section>

<script>
// $(function(){
// 	 $(li1).hide();
// 	 $(li2).hide();
// 	 $(li3).show();
	
// })

// function setTap(tapId){
	
//     var li1 = document.getElementById('li1');
//     var li2 = document.getElementById('li2');
//     var li3 = document.getElementById('li3');

// if(tapId == 1){
//  $('.tab1').addClass('active');
//     $('.tab2').removeClass('active');
//     $('.tab3').removeClass('active');
    
//    $(li1).show();
//     $(li2).hide();
//     $(li3).hide();
    
// }else if(tapId == 2){
// 	 $('.tab1').removeClass('active');
//     $('.tab2').addClass('active');
//     $('.tab3').removeClass('active');
    
//    $(li1).hide();
//     $(li2).show();
//     $(li3).hide();
// }else{
// 	 $('.tab1').removeClass('active');
// 	    $('.tab2').removeClass('active');
// 	    $('.tab3').addClass('active');
	    
// 	   $(li1).hide();
// 	    $(li2).hide();
// 	    $(li3).show();
// }

// }
</script>	
			