<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<section id="sub-content">
		<div class="inner1200"> <!--inner 시작 -->
			
			<!-- 서브 타이틀부분 -->
			<div class="sub-title-box">
				<h2>찾아오시는 길</h2>
				<ul class="list_ul">
					<li class="home"><i class="xi-home"></i></li>
					<li>재단소개</li>
					<li>찾아오시는 길</li>
				</ul>
			</div>
			


			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

				<!-- 찾아오시는길 -->	
				<div class="come-map-wrap">
					 <div id="map" style="width:100%;height:350px;"></div>
				</div>
				
				<div class="come-info-box">
					<p class="sub-in-yellow-title">연락처</p>
					<div class="line"></div>
					<div class="info-b">
						<div class="icon-box"><img src="/resources/img/sub/icon_come_01.png"></div>
						<div class="txt-box">
							<div class="col-2">
								<ul class="dot-ul1">
									<li>명칭 : (재) 전라남도문화관광재단</li>
									<li>
										주소 : 전라남도 무안군 삼향읍 후광대로 242 전남개발빌딩 13층 <br>
						                (재)전라남도문화관광재단 (우) 58566 (534-821)
									</li>
									<li>전화 : 061-280-5800</li>
								</ul>
							</div>
							<div class="col-2">
								<ul class="dot-ul1">
									<li>명칭 : 전남문화재연구소 </li>
									<li>주소 : 전라남도 무안군 삼향읍 후광대로 242 전남개발빌딩 13층</li>
									<li>전화 : 061-287-6803</li>
									<li>팩스 : 061-287-6801</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="come-info-box">
					<p class="sub-in-yellow-title">대중교통 이용안내</p>
					<div class="line"></div>
					<div class="info-b">
						<div class="icon-box"><img src="/resources/img/sub/icon_come_02.png"></div>
						<div class="txt-box">
							<p class="sub-arrow-title">연구원 경유 목포시내버스 안내</p>
							<div class="in-b">								
								<ul class="dot-ul1">
									<li>1-1번 : 해양대학교 → 목포역 → 버스터미널 → 전남도청 앞 정류장 하차(70분 간격)</li>
									<li>해양대후문 → 2호광장 → 3호광장 → 기독병원 → 전남도청 앞 정류장 하차(13분간격)</li>
									<li>삼학도 → 목포역 → 버스터미널 → 시민문화체육센터 → 전남도청앞 정류장 하차(28분간격)</li>
								</ul>
							</div>
							<p class="sub-arrow-title">시외버스 안내</p>
							<div class="in-b">								
								<ul class="dot-ul1">
									<li>1-1번 : 해양대학교 → 목포역 → 버스터미널 → 전남도청 앞 정류장 하차(70분 간격)</li>
									<li>해양대후문 → 2호광장 → 3호광장 → 기독병원 → 전남도청 앞 정류장 하차(13분간격)</li>
									<li>삼학도 → 목포역 → 버스터미널 → 시민문화체육센터 → 전남도청앞 정류장 하차(28분간격)</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
			</div> <!-- 서브컨텐츠 끝 -->

		</div> <!--inner 끝 -->
	</section>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6415ea8c2cee8bb76bdce65bdf6a6bda"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(34.814051,126.458307), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 

//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(34.814051,126.458307); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);


var iwContent = '<div style="padding:5px; width:207px;"><b>전남 무안군 삼향읍 후광대로 242</b></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
iwPosition = new kakao.maps.LatLng(34.814051,126.458307); //인포윈도우 표시 위치입니다

//인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
position : iwPosition, 
content : iwContent 
});

//마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
</script>
	