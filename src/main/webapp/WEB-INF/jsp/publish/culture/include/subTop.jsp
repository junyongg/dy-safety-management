<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<section id="subTop-con">
		<!-- 이미지 -->
<c:forEach items="${fn:split(currentMenu.MN_MAINNAMES,',') }" var="model" varStatus="status">
			<c:if test="${status.count eq 1 }"> 
			<c:choose>
				<c:when test="${model eq '연구소 소개'}"><div class="img-box subT01"></div></c:when>
				<c:when test="${model eq '연구소 소식'}"><div class="img-box subT02"></div></c:when>
				<c:when test="${model eq '조사의뢰안내'}"><div class="img-box subT03"></div></c:when>
				<c:when test="${model eq '조사현황'}"><div class="img-box subT04"></div></c:when>
				<c:when test="${model eq '정책 사업'}"><div class="img-box subT05"></div></c:when>
				<c:when test="${model eq '자료실'}"><div class="img-box subT06"></div></c:when>
				<c:when test="${model eq '커뮤니티'}"><div class="img-box subT07"></div></c:when>
				<c:otherwise><div class="img-box subT08"></div></c:otherwise>
			</c:choose>
<!-- 			<div class="txt-b"> -->
<%-- 				<c:forEach items="${fn:split(currentMenu.MN_MAINNAMES,',') }" var="model" varStatus="status"> --%>
<%-- 					<c:if test="${status.count eq 1 }"> --%>
<%-- 						<h2>${model }</h2> --%>
<%-- 					</c:if> --%>
<%-- 				</c:forEach> --%>
<!-- 				<div class="line"></div> -->
<!-- 				<h5>남도문화유산의 요람 전통문화자원을 발굴·복원하는 전남문화재연구소</h5> -->
<!-- 			</div> -->
		</c:if>
  </c:forEach>

		<!-- 서브메뉴 -->
		<div class="subMenu-b">
			<div class="inner1200">
				<div class="left">
					<ul class="subMenu_ul">
		            	<li class="home"><a href="/culture/index.do" class="a1"><i class="xi-home"><span class="tn">홈</span></i></a></li>
		            	<c:forEach items="${fn:split(currentMenu.MN_MAINNAMES,',') }" var="model" varStatus="status">
			            		<li>
									<a href="javascript:;" class="a1">
										<span class="txt">${model }</span> <span class="arrow"><i class="xi-caret-down"></i></span>
									</a>
									<c:if test="${status.count eq 1 }">
										<ul class="subMenu_in">
											<c:forEach items="${menuList }" var="menuList">
						            			<c:if test="${menuList.MN_LEV eq '1' }">
														<c:choose>
															<c:when test="${model eq menuList.MN_NAME }">
																<li class="active">
										            				<a href="javascript:;" onclick="menu_sub_list('${menuList.MN_URL}','${menuList.MN_PAGEDIV_C }')">${menuList.MN_NAME }</a>
										            				<c:set var="current_menuKey" value="${menuList.MN_KEYNO }"/>
										            				<c:set var="current_name" value="${menuList.MN_NAME }"/>
										            			</li>
															</c:when>
															<c:otherwise>
																<li>
										            				<a href="javascript:;" onclick="menu_sub_list('${menuList.MN_URL}','${menuList.MN_PAGEDIV_C }')">${menuList.MN_NAME }</a>
										            			</li>		
															</c:otherwise>
														</c:choose>
						            			</c:if>
						            		</c:forEach>		            	
						            	</ul>
					            	</c:if>
					            	<c:if test="${status.count eq 2 }">
					            		<ul class="subMenu_in" >
					            			<c:forEach items="${menuList }" var="menuList2">
						            			<c:if test="${model eq  menuList2.MN_NAME}">
						            				<c:set var="current_menukey2" value="${menuList2.MN_KEYNO }"/>
					            				</c:if>
						            			<c:if test="${menuList2.MN_LEV eq '2' && menuList2.MN_MAINKEY eq current_menuKey }">
							            			<c:choose>
														<c:when test="${model eq menuList2.MN_NAME}">
															<li class="active" >
									            				<a href="javascript:;" onclick="menu_sub_list('${menuList2.MN_URL}','${menuList2.MN_PAGEDIV_C }')">${menuList2.MN_NAME }</a>
									            			</li>
														</c:when>
														<c:otherwise>
															<li >
									            				<a href="javascript:;" onclick="menu_sub_list('${menuList2.MN_URL}','${menuList2.MN_PAGEDIV_C }')">${menuList2.MN_NAME }</a>
									            			</li>		
														</c:otherwise>
													</c:choose>
						            			</c:if>
						            		</c:forEach>
						            	</ul>
					            	</c:if>
					            	
					            	<c:if test="${status.count eq 3 }">
					            		<ul class="subMenu_in">
					            			<c:forEach items="${menuList }" var="menuList3">
					            				<c:if test="${menuList3.MN_LEV eq '3' }">
						            				<c:if test="${current_menukey2 eq menuList3.MN_MAINKEY}">
														<c:choose>
															<c:when test="${model eq menuList3.MN_NAME}">
																<li class="active">
										            				<a href="javascript:;" onclick="menu_sub_list('${menuList3.MN_URL}','${menuList3.MN_PAGEDIV_C }')">${menuList3.MN_NAME }</a>
										            			</li>
															</c:when>
															<c:otherwise>
																<li>
										            				<a href="javascript:;" onclick="menu_sub_list('${menuList3.MN_URL}','${menuList3.MN_PAGEDIV_C }')">${menuList3.MN_NAME }</a>
										            			</li>		
															</c:otherwise>
														</c:choose>
							            			</c:if>
						            			</c:if>
					            			</c:forEach>
						            	</ul>
					            	</c:if>
								</li>
								<c:set var="count" value="${status.count }"/>
		            	</c:forEach>
		            </ul>
				</div>

				<div class="right">
					<div class="s-icon-b">
						<button type="button" class="s-icon sns" title="각종사이트에 공유하기"><span></span></button>
						<div class="s-sns-wrap">
							<div class="row">
								<div class="tit">보내기</div>
								<ul class="sns-b-ul">
									<li title="페이스북"><a href="javascript:;"  title="페이스북" onclick="facebook()" ><span class="icon face"><span class="tn">페이스북</span></span></a></li>
									<li title="트위터"><a href="javascript:;"  title="트위터" onclick="twitter()"><span class="icon twitter"><span class="tn">트위터</span></span></a></li>
									<li title="카카오스토리"><a href="javascript:;" title="카카오스토리" onclick="cf_kakaoStroryShare2()"><span class="icon kakao"><span class="tn">카카오페이지</span></span></a></li>
									<li title="네이버밴드"><a href="javascript:;" title="밴드" onclick="band()"><span class="icon band"><span class="tn">밴드</span></span></a></li>
								</ul>
								<button type="button" class="clo-b"><i class="xi-close"><span class="tn">닫기</span></i></button>
							</div>
							<div class="row">
								<div class="tit">URL 주소</div>
								<div class="url-box" id="url_in"> 
							</div>
								<script>
// 									var url = encodeURIComponent(document.URL);
									$("#url_in").html(document.URL);
								</script>
								<button type="button" class="btn-copy" id="clipboard" title="주소복사하기">복사</button>
							</div>
						</div>
					</div>
					<div class="s-icon-b">
						<button type="button" class="s-icon print" onclick="cf_print()" title="인쇄버튼"><span></span></button>						
					</div>
					<div class="font-icon">
						<ul class="font-ul">
							<li><button type="button" class="btn-f" onclick="pf_resizeFont('sub-content','increase')" title="폰트크게하기"><i class="xi-plus"><span class="tn">폰트크게</span></i></button></li>
							<li><button type="button" class="btn-f" onclick="pf_resizeFont('sub-content','initial')" title="폰트 기본"><span class="txt">기본</span></button></li>
							<li><button type="button" class="btn-f" onclick="pf_resizeFont('sub-content','decrease')" title="폰트작게하기"><i class="xi-minus"><span class="tn">폰트작게</span></i></button></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
<script> 
window.onload = function(){
    $(document).ready(function(){
    	
        var clipboard = new Clipboard('#clipboard', {
            text: function(trigger) {
                return location.href;
            }
        });
        $('#clipboard').on('click',function(){
        	if(isMobile.iOS()){
        		alert('아이폰에서는 지원하지 않습니다.')
        	}else{
	        	alert('클립보드로 현재 주소('+location.href+')가 복사되었습니다.')
        	}
        })
    });
};

//<![CDATA[
  // // 사용할 앱의 JavaScript 키를 설정해 주세요.
  Kakao.init('eabacb1e3bdc76d1351d4233e18e30ef');
  // // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
  function pf_kakao() {
	  
	  
	  var title = '';
	  var desc = '';
	  var image = '';
	  var url = location.href;
	  if('${SNSInfo}'){
		  title = '<c:out value="${SNSInfo.TITLE}" />';
		  desc = '<c:out value="${SNSInfo.DESC}" />';
		  if('${SNSInfo.IMG }'){
			  image = '${domain}/resources/img/upload/${SNSInfo.IMG }';
		  }else{
			  image = '${domain}/resources/img/sns/gjcf_sns.jpg';  
		  }
		  
	  }else{
		  title = '광주문화재단 - <c:out value="${currentMenu.MN_NAME}" />';
		  desc = '';
		  image = '${domain}/resources/img/sns/gjcf_sns.jpg'; 
	  }
	  
    Kakao.Link.sendDefault({
      objectType: 'feed',
      content: {
          title: title,
          description: desc,
          imageUrl: image,
          link: {
        	  mobileWebUrl: url,
              webUrl: url
          }
        },
      buttons: [
        {
          title: '웹으로 보기',
          link: {
            mobileWebUrl: url,
            webUrl: url
          }
        }
      ]
    });
  }

//]]>

function menu_sub_list(URL,PAGEDIV){
	if(URL == '/jact/archives/articledb.do'){
		alert("이 페이지에 접근할 권한이 없습니다.");
		return false;
	}
	
	
	if(PAGEDIV == 'SC_QXCFB'){ // 소메뉴
		
		$.ajax({
			type: "POST",
			url: "/common/user/firstChildUrlAjax.do",
			data: "MN_URL="+URL,
			async:false,
			success : function(data){
				if(data){
					if(data == '/jact/archives/articledb.do'){
						data = '/jact/archives/picture.do'
					}
					location.href=data;	
				}else{
					alert("하위 메뉴가 없습니다.");
				}
			},
			error: function(){
				alert('알수없는 링크. 관리자한테 문의하세요.')
				return false;
			}
		});
	}else if(PAGEDIV == 'SC_HFAIU'){ // 링크형
		window.open(URL)
	}else { 
		location.href=URL;
	}
}
</script>