<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>


<!-- 헤더 -->
<header id="hd">
    <div class="center_b"><a href="javascript:;" title="전라남도 문화재단">
    <img src="/resources/map/img/icon/logo_top.png" alt=""></a></div>
</header>
<!-- // 헤더 -->
<form id="Form" acion="" method="post">
	<input type="hidden" name="area">
	<input type="hidden" name="type">
</form>
<!-- 메인 컨텐츠 -->
<div class="main_contents">
    <div class="inner">
        <div class="txt_box">
            <h5>전남 공공미술 프로젝트</h5>
            <h2>우리동네 미술품을 검색하세요</h2>
        </div>
        <div class="search_box">
			<select id="area" onchange="">
				<option value="all">전체</option>
				<option value="영광">영광</option>
				<option value="장성">장성</option>
				<option value="담양">담양</option>
				<option value="곡성">곡성</option>
				<option value="구례">구례</option>
				<option value="광양">광양</option>
				<option value="여수">여수</option>
				<option value="순천">순천</option>
				<option value="고흥">고흥</option>
				<option value="보성">보성</option>
				<option value="화순">화순</option>
				<option value="나주">나주</option>
				<option value="장흥">장흥</option>
				<option value="영암">영암</option>
				<option value="강진">강진</option>
				<option value="해남">해남</option>
				<option value="진도">진도</option>
				<option value="완도">완도</option>
				<option value="신안">신안</option>
				<option value="목포">목포</option>
				<option value="무안">무안</option>
				<option value="함평">함평</option>
			</select>
            <select name="type" id="type">
				<option value="all">전체</option>
                <option value="벽화">벽화</option>
                <option value="설치">설치</option>
                <option value="기타">기타</option>
            </select>
            <button type="button" class="btn_search_ma" title="검색" onclick="Movemap();"><i class="xi-search"></i>검색</button>
        </div>
        <div class="main_slide_nav">
            <nav></nav>
            <button type="button" class="btn_pause" title="멈춤"><i class="xi-pause"></i></button>
        </div>
    </div>
    <div class="img_slide_box swiper-container">
        <div class="slide_box swiper-wrapper">
            <div class="one swiper-slide"><span class="img_s" style="background-image:url('/resources/map/img/bg/mainbg01.jpg');"></span></div>
            <div class="one swiper-slide"><span class="img_s" style="background-image:url('/resources/map/img/bg/mainbg02.jpg');"></span></div>
            <div class="one swiper-slide"><span class="img_s" style="background-image:url('/resources/map/img/bg/mainbg03.jpg');"></span></div>
        </div>
    </div>
</div>
<!-- 메인 컨텐츠 -->


<script>
function Movemap(){
	$("input[name=area]").val($("#area").val());
	$("input[name=type]").val($("#type").val());
	$("#Form").attr("action","/map/prc_map.do?${_csrf.parameterName}=${_csrf.token}");
	$("#Form").submit();
}
</script>