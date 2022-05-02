<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>  
<div id="accessibility">
        <a href="#mcontent" class="skip">본문바로가기</a>
    </div>
  <div id="top_hdear">
		<div class="inner1200">
			
			<ul class="left_ul">
				<li><a href="/jact/index.do"><span class="icon icon02"></span> 전라남도 문화관광재단</a></li>
				<li><a href="https://www.jeonnam.go.kr" target="_blank"><span class="icon icon02"></span> 전라남도 도청</a></li>
				<li><a href="/culture/index.do"><span class="icon icon03"></span> HOME</a></li>
			</ul>

			<ul class="right_ul">
				<li><a href="javascript:;" class="m-sarch-btn"><span class="icon icon01"></span><b>검색</b></a></li>
				<li>
					<a href="javascript:;">
			            <button class="hamburger hamburger--collapse siteMapBtn" type="button">
			                <span class="hamburger-box">
			                  <span class="hamburger-inner"></span>
			                </span>
			            </button>
					</a>
				</li>
			</ul>
		</div>
	</div>
  <!-- 사이트맵 -->
  <%@ include file="/WEB-INF/jsp/publish/culture/include/sitemap.jsp" %>
  <!-- 사이트맵 끝 -->
  
  <header id="hd">
		<!-- 위에헤더 -->
		<div class="nav-wrap">
			<div class="inner1200">
				<div class="logo-b">
					<a href="/culture/index.do">
						<img src="/resources/culture/img/icon/img_top_logo2.png" alt="문화재 연구소 로고">
					</a>
				</div>

				<div class="nav-b">
					<ul class="m-gnb">
						<c:forEach items="${menuList}" var="model">
						<sec:authorize url="${model.MN_URL}">
							<c:if test="${model.MN_LEV eq '1' }">
								<c:if test="${model.MN_PAGEDIV_C eq 'SC_QXCFB' }">
									<li>
									<a href="javascript:;" onclick="pf_moveMenu('${model.MN_URL}','${model.MN_PAGEDIV_C }')" class="a1">${model.MN_NAME }</a>
										<div class="gnd-s-wrap">
											<ul class="subMenu">
												<c:forEach items="${menuList}" var="model2">
													<c:if test="${model.MN_KEYNO eq model2.MN_MAINKEY && model2.MN_LEV eq '2' }">
														<li>
															<a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }">${model2.MN_NAME }</a>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</div>
									</li>								
								</c:if>
								<c:if test="${model.MN_PAGEDIV_C ne 'SC_QXCFB' }">
									<li>
										<a href="javascript:;" onclick="pf_moveMenu('${model.MN_URL}','${model.MN_PAGEDIV_C }')" class="a1">${model.MN_NAME }</a>
									</li>
								</c:if>
							</c:if> <!--  1dp -->
							</sec:authorize>
						</c:forEach>
				 	</ul>
				</div>
				
				<!-- 모바일메뉴 버튼-->
				<div class="mo-menu-b-box">
					<button type="button" class="search-b"><i class="xi-search"></i></button>
					<button type="button" class="menu-b" onclick="mobileMenuShow()"><i class="xi-bars"></i></button>
				</div>

			</div>
		</div>
		
		<!-- 서브메뉴 -->
		<div class="subMenu-Wrap" style="display: none;">
			<div class="inner1200">
			</div>
		</div>

		<!-- 검색창 -->
		<div id="m-search-box">
			<span class="search-s">통합검색</span>
			<input type="text" class="search-txt" placeholder="검색어를 입력하세요"  id="searchHeaderId" onkeydown="if(event.keyCode == 13) pf_search('searchHeaderId');">
			<button type="button" class="search-b" onclick="pf_search('searchHeaderId')"><i class="xi-search"></i></button>
			<button type="button" class="close-b"><i class="xi-close-thin"></i></button>
		</div>

	</header>
  <!-- 블랙박스 -->
  <div id="black-box" onclick="mobileMenuHide()"></div>
  <!-- 모바일메뉴 -->
  <div id="mobile-menu-wrap">
		<div class="top-box">
			<button type="button" class="close-b" onclick="mobileMenuHide()"><i class="xi-close-thin"></i></button>
			<ul>
				<li><a href="/jact/index.do">전남문화관광재단</a></li>
                <li><a href="https://www.jeonnam.go.kr/">전라남도청</a></li>
			</ul>
		</div>
		<div class="con-box">
			<ul class="mob-gnb">
				<c:forEach items="${menuList}" var="model">
				<sec:authorize url="${model.MN_URL}">
					<c:if test="${model.MN_LEV eq '1' }">
						<li>
							<a href="javascript:;" onclick="pf_moveMenu('${model.MN_URL}','${model.MN_PAGEDIV_C }')" class="m-a1"><span>${model.MN_NAME }</span></a>
							<ul class="mob-s-gnb">
								<c:forEach items="${menuList}" var="model2">
									<c:if test="${model.MN_KEYNO eq model2.MN_MAINKEY && model2.MN_LEV eq '2' }">
										<li>
											<a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }">${model2.MN_NAME }</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
					</c:if> <!--  1dp -->
					</sec:authorize>
				</c:forEach>
		 	</ul>
		</div>
	</div>
	
	
<script>
  
function pf_search(id){
	if(!$('#'+id).val()){
		alert('검색어를 입력해주세요.');
		$('#'+id).focus();
		return false;
	}
	location.href="${tilesUrl}/use/search.do?searchKeyword="+$('#'+id).val();
}
  
  
function pf_moveMenu(URL,PAGEDIV){
	
	if(PAGEDIV == 'SC_QXCFB'){ // 소메뉴
		
// 		$.ajax({
// 			type: "POST",
// 			url: "/common/user/firstChildUrlAjax.do",
// 			data: "MN_URL="+URL,
// 			async:false,
// 			success : function(data){
			
// 				if(data){
// 					location.href=data;	
// 				}else{
// 					alert("하위 메뉴가 없습니다.");
// 				}
// 			},
// 			error: function(){
// 				alert('알수없는 링크. 관리자한테 문의하세요.')
// 				return false;
// 			}
// 		});
	}else if(PAGEDIV == 'SC_HFAIU'){ // 링크형
		window.open(URL)
	}else { 
		location.href=URL;
	}
}

</script>
  