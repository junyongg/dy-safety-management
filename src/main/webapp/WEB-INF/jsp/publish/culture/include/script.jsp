<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<!--[if lt IE 9]>
<script>
//IE8 이하 브라우저 업그레이드 권고
alert("브라우저의 버전이 너무 낮습니다.\n보안을 위해 브라우저의 버전을 업그레이드 해야합니다.");
location.href="/no_IELess9.jsp";
</script>
<![endif]-->



<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
  <script type="text/javascript" src="/resources/culture/js/jquery-2.0.2.min.js"></script>
<script type="text/javascript" src="/resources/culture/js/html5shiv-printshiv.js"></script>
<script type="text/javascript" src="/resources/culture/js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="/resources/culture/js/wow.min.js"></script>
<script type="text/javascript" src="/resources/culture/js/respond.min.js"></script>
<script type="text/javascript" src="/resources/culture/js/slick.js"></script>
<script>
	if (!window.jQuery) {
		document.write('<script src="/resources/smartadmin/js/libs/jquery-2.1.1.min.js"><\/script>');
	}
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script>
	if (!window.jQuery.ui) {
		document.write('<script src="/resources/smartadmin/js/libs/jquery-ui-1.10.3.min.js"><\/script>');
	}
</script>

<script type="text/javascript" src="/resources/cf/js/html5shiv-printshiv.js"></script>
<script type="text/javascript" src="/resources/tour/js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="/resources/tour/js/slick.js"></script>
<script type="text/javascript" src="/resources/cf/js/respond.min.js"></script>

<!-- 클립보드 복사 -->
<script type="text/javascript" src="/resources/api/clipboard/clipboard.min.js"></script>

<!-- validation -->
<script type="text/javascript" src="/resources/js/common/validation/jquery.validate.js"></script>


<!-- 카카오톡 -->
<script src="/resources/js/sns/kakao.min.js"></script>
<!-- 구글플러스 -->
<script src="https://apis.google.com/js/platform.js" async defer>{lang: 'ko'}</script>


<!-- JS적용 -->
<c:forEach items="${jsList }" var="jsCommon">
	<script src="${jsCommon.RM_PATH }"></script>
</c:forEach>

		
<script>
/**
 * 로그인 체크
 * @returns
 */
function cf_checkLogin(){
	
	var id = '${userInfo.UI_ID}';
	if(!id){
		if(confirm('로그인이 필요합니다. 로그인 하시겠습니까?')){
			cf_login();
		}
		return false;
		
	}
	return true;
	
}

/**
 * 로그인
 */
function cf_login(url){
	
	if(url == 'main'){ // main 이면 로그인후 메인으로 보냄
		cf_postSend('${tilesUrl}/member/login.do',{
			'${_csrf.parameterName}':'${_csrf.token}'
		})
	}else if(url){ // url이 있으면 url값으로 보냄
		cf_postSend('${tilesUrl}/member/login.do',{
			'customReturnPage':url,
			'${_csrf.parameterName}':'${_csrf.token}'
		})
	}else{ //url이 없으면 현재 페이지로 보냄
		cf_postSend('${tilesUrl}/member/login.do',{
			'customReturnPage':document.location.pathname,
			'${_csrf.parameterName}':'${_csrf.token}'
		})
	}
}

</script>
  