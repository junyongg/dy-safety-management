<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>




<div id="logo-group" style="line-height:49px;padding-left:10px;cursor: pointer;">
    <!-- <a href="/"  target="_blank" style="color:#fff;">홈페이지 이동</a> -->
    <div class="btn-group-vertical" style="background-color: #d24158; width: 100%">
        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="background-color: #d24158; border: 0px; box-shadow: none; color: white; width: 80%; text-align: left;">
            홈페이지 이동
            <i class="fa fa-caret-down"></i>
        </button>
        <ul class="dropdown-menu" style="width: 80%; padding: 6px 12px;">
            <c:forEach items="${headerHomeDivList }" var="model">
            <c:if test="${model.MN_URL ne '/txap' }">
            <li>
                <a href="${model.MN_FORWARD_URL }" target="_blank">${model.MN_NAME }</a>
            </li>
            </c:if>
            </c:forEach>
        </ul>
    </div>
</div>

<a href="/txap/index.do" id="dms_title">관리자페이지</a>
<style>
	#dms_title {
		display:inline-block;color:#B2C1D5;font-size:1.2em;line-height:49px;padding-left:20px;
	}
	@media all and (max-width:979px){
		#dms_title {color:#fff;}
	}
	@media all and (max-width:500px){
		#dms_title {display:none;}
	}
</style>
<div class="pull-right">
	<!-- 최근 접속 페이지 -->
	<div class="project-context hidden-xs">

		<span class="label"></span> <span
			class="project-selector dropdown-toggle" data-toggle="dropdown">최근 
			접속페이지 <i class="fa fa-angle-down"></i>
		</span>
	
		<ul class="dropdown-menu">
			<li class="dontRemove divider"></li>
			<li class="dontRemove"><a href="javascript:pf_clearPageListCookie();"><i class="fa fa-power-off"></i> 리스트 삭제</a></li>
		</ul>
	</div>
	<!-- 메뉴 감추기 -->
	<div id="hide-menu" class="btn-header pull-right">
		<span> <a href="javascript:void(0);" data-action="toggleMenu"
			title="Collapse Menu"><i class="fa fa-reorder"></i></a>
		</span>
	</div>
	
	<c:if test="${not empty userInfo }">
	<!-- 로그아웃 -->
	<div id="logout" class="btn-header transparent pull-right">
		<span> 
			<a href="/txap/logout.do" title="로그아웃" data-action="userLogout" data-logout-msg="로그아웃 이후에 이 열린 브라우저를 닫아 보안을 강화할 수 있습니다.">
			<i class="fa fa-sign-out"></i></a>
		</span>
	</div>
	</c:if>

	<!-- fullscreen  -->
	<div id="fullscreen" class="btn-header transparent pull-right">
		<span> <a href="javascript:void(0);"
			data-action="launchFullscreen" title="Full Screen"><i
				class="fa fa-arrows-alt"></i></a>
		</span>
	</div>
	
</div>


<script>

/* 최근 접속페이지 쿠키에 저장해서 불러오는 처리 */
$(function(){
	
	var getPageData = cf_getCookie('pageList');
	var pageList;
	if(getPageData != ''){
		pageList = JSON.parse(getPageData);
		var count = 0;
		$.each(pageList,function(i){
			count++
		})
		//10개 이상 쌓이지 않도록 10개 넘어가면 기존 데이터 삭제처리
		$.each(pageList,function(i){
			if(count > 10){
				delete pageList[i];
				count--
			}else{
				$('.project-context ul').prepend('<li><a href="'+pageList[i].menuUrl+'">'+pageList[i].menuName+'    - '+pageList[i].nowTime+'</a></li>')	
			}
		})
	}else{
		pageList = new Object();
	}
	
	
	var currentMenu = '${currentMenu.MN_NAME}';
	if(currentMenu != ''){
		var page = new Object();
		
		var d = new Date();
		var nowTime = d.getFullYear()+"."+(d.getMonth()+1)+"."+d.getDate()+". "+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
		
		
		page.menuName = '${currentMenu.MN_NAME}';
		page.menuUrl = '${currentMenu.MN_URL}';
		page.nowTime = nowTime;
		pageList[nowTime]=page;
		page = new Object();
		cf_setCookie('pageList',JSON.stringify(pageList));
	} 
	
})



function pf_clearPageListCookie(){
	
	$('.project-context ul li:not(.dontRemove)').remove();
	
	var expireDate = new Date();
	  
    //어제 날짜를 쿠키 소멸 날짜로 설정한다.
    expireDate.setDate( expireDate.getDate() - 1 );
    document.cookie = "pageList= " + "; expires=" + expireDate.toGMTString() + "; path=/";
}


</script>
