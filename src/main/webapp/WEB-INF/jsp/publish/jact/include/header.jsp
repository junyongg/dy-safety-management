<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>


<!------------------------------------------------------------------------
    		 HEADER START   헤더
	------------------------------------------------------------------------->


<div id="wrap">
    <div id="accessibility">
              	<c:choose>
      				<c:when test="${currentMenu.MN_URL eq '/jact'}"> <a  href="javascript:;" class="skip" onclick="bonmoon('main');">본문바로가기</a> </c:when>
     				<c:otherwise><a href="javascript:;" class="skip" onclick="bonmoon('sub');">본문바로가기</a> </c:otherwise>
   			   </c:choose>
    </div>
	
	<div id="top_hdear">
		<div class="inner1200  inner1400">
			
			<ul class="left_ul">
<!--                 <li><a href="http://blog.jact.or.kr/tour/"  target="_blank"><span class="icon icon01"></span> 관광블로그</a></li> -->
<!--                 <li><a href="https://www.jeonnam.go.kr/"  target="_blank"><span class="icon icon02"></span> 전라남도 도청</a></li> -->
				<li><a href="/"><span class="icon icon03"></span> HOME</a></li>
              <li><a href="/">
						KOREA
                </a></li>
					<li><a href="/eng/engpage.do">
						ENGLISH
					</a></li>
			</ul>

          <div style="float:right;height:100%;">
            
          
              <ul class="right_sns_ul">
				<li><a href="https://www.facebook.com/jact5800" target="_blank" title="전남문화재단 페이스북 새창열림"><img src="/resources/img/icon/icon_m_sns_01.png" alt="전남문화재단 페이스북으로 이동"></a></li>
				<li><a href="https://www.youtube.com/channel/UCCpPH4qc1xpanrUYpVEpWdg" target="_blank" title="전남문화재단유튜브 새창열림"><img src="/resources/img/icon/icon_m_sns_02.png" alt="전남문화재단 유튜브로 이동"></a></li>
				<li><a href="https://blog.naver.com/jact123" target="_blank" title="전남문화재단 블로그 새창열림"><img src="/resources/img/icon/icon_m_sns_03.png" alt="전남문화재단 블로그로 이동"></a></li>
				<li><a href="https://www.instagram.com/jncf5800/" target="_blank" title="전남문화재단 인스타그램 새창열림"><img src="/resources/img/icon/icon_m_sns_04.png" alt="전남문화재단 인스타그램으로 이동"></a></li>
			</ul>
			<ul class="right_ul">
				<li><a href="javascript:;" class="m-sarch-btn" title="통합검색어입력"><span class="icon icon01"></span><b>검색</b></a></li>
				  <li>
                    <a href="javascript:;" onclick="myPageMenuShow('${userInfo.UI_NAME}')" title="마이페이지"><span class="icon icon02"></span><b>마이페이지</b></a>
                    <ul class="mypage_ul">
                        <li><a href="/jact/mypage/info.do" title="마이페이지">마이페이지</a></li>
                      <c:if test="${userInfo.isAdmin eq 'Y' && userInfo ne null}">
					     <li><a href="/txap/index.do" title="관리자페이지">관리자페이지</a></li>
					   </c:if>
                        <li><a href="/jact/logout.do" title="로그아웃">로그아웃</a></li>
                    </ul>
                </li>
				<li>
                        <button style="display: block;height: 100%;width: 100%;text-align: center;margin-top:5px;" class="hamburger hamburger--collapse siteMapBtn" type="button" title="사이트맵">
                            <span class="hamburger-box">
                              <span class="hamburger-inner"></span>
                            </span>
                        </button>
                </li>
			</ul>
		</div>
	</div>
      </div>


    <!-- 사이트맵 -->
    <%@ include file="/WEB-INF/jsp/publish/jact/include/sitemap.jsp" %>
    <!-- 사이트맵 끝 -->

	<header id="hd">
		<!-- 위에헤더 -->
		<div class="nav-wrap">
			<div class="inner1200  inner1400">
				<div class="logo-b">
					<a href="/" title="전라남도 문화재단">
                    <h1 style="text-indent: -9999px;position: fixed;">전라남도 문화재단</h1>
						<img src="/resources/img/icon/img_top_logo.png" alt="전라남도 문화재단">
					</a>
				</div>

			<div class="nav-b">
					<ul class="m-gnb">
						<c:forEach items="${menuList}" var="model">
						<sec:authorize url="${model.MN_URL}">
							<c:if test="${model.MN_LEV eq '1' }">
								<li>
									<a href="javascript:;" class="a1">${model.MN_NAME }</a>
									<ul class="subMenu">
										<c:forEach items="${menuList}" var="model2" varStatus="status">
											<c:if test="${model.MN_KEYNO eq model2.MN_MAINKEY && model2.MN_LEV eq '2' }">
												<li>
													<c:choose>
														<c:when test="${model2.MN_NAME eq '문화예술인DB' }">
															<a href="javascript:;" onclick="alert('이 페이지에 접근할 권한이 없습니다.')" title="${model2.MN_NAME }">${model2.MN_NAME }</a>
														</c:when>
														<c:otherwise>
														
														</c:otherwise>
													</c:choose>
													<c:if test="${model2.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU }">
														<a href="javascript:;" onclick="plusBtnExe('plusB${status.count}')" title="${model2.MN_NAME }">${model2.MN_NAME }</a>
														<div class="subMoreBtn">
														<button class="more" id="plusB${status.count}" title="하위메뉴보기"><i class="xi-plus-thin"></i></button>
															<ul class="sub-subMenu">
																<c:forEach items="${menuList}" var="model3">
																	<c:if test="${model2.MN_KEYNO eq model3.MN_MAINKEY && model3.MN_LEV eq '3' }">
																		<li>
																			<a href="javascript:;" onclick="pf_moveMenu('${model3.MN_URL}','${model3.MN_PAGEDIV_C }')" title="${model3.MN_NAME }">${model3.MN_NAME }</a>
																		</li>
																	</c:if>
																</c:forEach>
															</ul>
														</div>
													</c:if>
													<c:if test="${model2.MN_PAGEDIV_C ne MENU_TYPE_SUBMENU }">
														<a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }">${model2.MN_NAME }</a>
													</c:if>
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
				
				<!-- 모바일메뉴 버튼-->
				<div class="mo-menu-b-box">
					<button type="button" class="search-b"><i class="xi-search"></i></button>
					<button type="button" class="menu-b" onclick="mobileMenuShow()"><i class="xi-bars"></i></button>
				</div>

			</div>
		</div>
		
		<!-- 서브메뉴 -->
		<div class="subMenu-Wrap">
			<div class="inner1200  inner1400">
				<!--<div class="pic-box">
					<img src="/resources/img/icon/icon_menu_logo_01.png" alt="전남문화관광재단 이미지">
					<h2>전라남도 문화예술 및 관광 진흥</h2>
				</div>-->

			</div>
		</div>

		<!-- 검색창 -->
		<div id="m-search-box">
			<span class="search-s">통합검색</span>
			<input type="text" class="search-txt" placeholder="검색어를 입력하세요"  id="searchHeaderId" onkeydown="if(event.keyCode == 13) pf_search('searchHeaderId');" title="통합검색">
			<button type="button" class="search-b" onclick="pf_search('searchHeaderId')" title="검색 아이콘"><i class="xi-search"></i></button>
			<button type="button" class="close-b" title="검색 닫기 버튼"><i class="xi-close-thin"></i></button>
		</div>

	</header>

	<!-- 블랙박스 -->
	<div id="black-box" onclick="mobileMenuHide()"></div>

	<!-- 모바일메뉴 -->
	<div id="mobile-menu-wrap">
		<div class="top-box">
			<button type="button" class="close-b" onclick="mobileMenuHide()"><i class="xi-close-thin"></i></button>
			<ul>
			                <li><a href="http://blog.jact.or.kr/tour/">관광블로그</a></li>
                <li><a href="https://www.jeonnam.go.kr/">전라남도청</a></li>
                <c:if test="${not empty userInfo }">
                    <li><a href="/jact/mypage/info.do">마이페이지</a></li>
                </c:if>
			</ul>
		</div>
		<div class="con-box">
			<ul class="mob-gnb">
				<c:forEach items="${menuList}" var="model">
					<c:if test="${model.MN_LEV eq '1' }">
						<li>
							<a href="javascript:;" class="m-a1">
								<span>${model.MN_NAME }</span>
								<button type="button" class="btn-depth1"><i class="xi-angle-down-thin"></i></button>
							</a>
							<ul class="mob-s-gnb">
								<c:forEach items="${menuList}" var="model2">
									<c:if test="${model.MN_KEYNO eq model2.MN_MAINKEY && model2.MN_LEV eq '2' }">
										<li>
											<c:if test="${model2.MN_PAGEDIV_C ne MENU_TYPE_SUBMENU }">
												<a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }">${model2.MN_NAME } </a>
											</c:if>
											
											<c:if test="${model2.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU }">
												<a href="javascript:;" class="m-a2"  title="${model2.MN_NAME }"><span>${model2.MN_NAME }</span>
												<button type="button" class="btn-mo-dep2"><i class="xi-plus-thin"></i></button> 
												</a>
													<ul class="mob-s-s-gnb">
														<c:forEach items="${menuList}" var="model3">
															<c:if test="${model2.MN_KEYNO eq model3.MN_MAINKEY && model3.MN_LEV eq '3' }">
																<li>
																	<a href="javascript:;" onclick="pf_moveMenu('${model3.MN_URL}','${model3.MN_PAGEDIV_C }')" title="${model3.MN_NAME }">${model3.MN_NAME }</a>
																</li>
															</c:if>
														</c:forEach>
													</ul>
											</c:if>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						   
						</li>
					</c:if> <!--  1dp -->
				</c:forEach>
			</ul>
		</div>
	</div>
	<!------------------------------------------------------------------------
    		 NAV END           
	------------------------------------------------------------------------->
<script>

var keywordList = new Array();
<c:forEach items="${keywordList}" var="model">
keywordList.push('${model.SK_KEYWORD}')
</c:forEach>
$(function(){
	
	$('#searchHeaderId').autocomplete({
		source: keywordList,
		focus: function( event, ui ) {
			return false; 
		}
	});
})

function plusBtnExe(clickId){
		var mythis = document.getElementById(clickId);
		if($(mythis).hasClass('active')){ //active가 있으면
			//active 지우기
			$(mythis).removeClass('active');
			$(mythis).find('i').removeClass('xi-minus-thin').addClass('xi-plus-thin'); //마이너스바꾸기
          $(mythis).attr('title','하위메뉴보기');
		} else { //active가 없으면
			//초기화
			$('.subMoreBtn .more').removeClass('active');
			$('.subMoreBtn .more').find('i').removeClass('xi-minus-thin').addClass('xi-plus-thin'); //플러스바꾸기
			//active 추가
			$(mythis).addClass('active');
			$(mythis).find('i').removeClass('xi-plus-thin').addClass('xi-minus-thin'); //마이너스바꾸기
          $(mythis).attr('title','하위메뉴접기');
		}
	}

// function pf_search(id){
// 	alert($('#'+id).val());
// 	if(!$('#'+id).val()){
// 		alert('검색어를 입력하여주세요.');
// 		$('#'+id).focus();
// 		return false;
// 	}
// 	location.href="/jact/use/search.do?searchKeyword="+encodeURI($('#'+id).val());
// }

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
		
/*		$.ajax({
			type: "POST",
			url: "/common/user/firstChildUrlAjax.do",
			data: "MN_URL="+URL,
			async:false,
			success : function(data){
			
				if(data){
					location.href=data;	
				}else{
					alert("하위 메뉴가 없습니다.");
				}
			},
			error: function(){
				alert('알수없는 링크. 관리자한테 문의하세요.')
				return false;
			}
		});*/
	}else if(PAGEDIV == 'SC_HFAIU'){ // 링크형
		window.open(URL)
	}else { 
		location.href=URL;
	}
}

  function bonmoon(a){
    if(a=="main"){
      location.href = "#main-slide-box"
      $('#prebutton').focus();
    }else{
      location.href="#subTop-con"
      $("#homea1").focus();
    }
  }
</script>