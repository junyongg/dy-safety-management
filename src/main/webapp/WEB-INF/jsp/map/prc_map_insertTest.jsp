<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:800px;"></div>
<div id="clickLatlng"></div>
<select id="area" name="area" value="${area }">
	<option value="0" ${area eq '0'?'selected':'' } >전체</option>
	<option value="1" ${area eq '1'?'selected':'' }>영광</option>
	<option value="2" ${area eq '2'?'selected':'' }>장성</option>
	<option value="3" ${area eq '3'?'selected':'' }>담양</option>
	<option value="4" ${area eq '4'?'selected':'' }>곡성</option>
	<option value="5" ${area eq '5'?'selected':'' }>구례</option>
	<option value="6" ${area eq '6'?'selected':'' }>광양</option>
	<option value="7" ${area eq '7'?'selected':'' }>여수</option>
	<option value="8" ${area eq '8'?'selected':'' }>순천</option>
	<option value="9" ${area eq '9'?'selected':'' }>고흥</option>
	<option value="10" ${area eq '10'?'selected':'' }>보성</option>
	<option value="11" ${area eq '11'?'selected':'' }>화순</option>
	<option value="12" ${area eq '12'?'selected':'' }>나주</option>
	<option value="13" ${area eq '13'?'selected':'' }>장흥</option>
	<option value="14" ${area eq '14'?'selected':'' }>영암</option>
	<option value="15" ${area eq '15'?'selected':'' }>강진</option>
	<option value="16" ${area eq '16'?'selected':'' }>해남</option>
	<option value="17" ${area eq '17'?'selected':'' }>진도</option>
	<option value="18" ${area eq '18'?'selected':'' }>완도</option>
	<option value="19" ${area eq '19'?'selected':'' }>신안</option>
	<option value="20" ${area eq '20'?'selected':'' }>목포</option>
	<option value="21" ${area eq '21'?'selected':'' }>무안</option>
	<option value="22" ${area eq '22'?'selected':'' }>함평</option>
</select>
<input type="text" name="text" id="text">
<select id="img" name="img">
	<option value="/resources/map/img/icon/icon_btn_red.png">빨강</option>
	<option value="/resources/map/img/icon/icon_btn_yellow.png" >노랑</option>
	<option value="/resources/map/img/icon/icon_btn_blue.png">파랑</option>
</select>
<button type="button" onclick="InsertMarker()">마커 등록</button>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e7849c0dae6357d65f32168ce249e4d5"></script>


<script>
var xLocation = [];
var yLocation = [];
var MapText = [];
</script>

<c:forEach items="${marker }" var="m" varStatus="v">
	<script>
	xLocation.push('${marker[v.index].mapx}');
	yLocation.push('${marker[v.index].mapy }');
	MapText.push('${marker[v.index].mapText }');
	</script>
</c:forEach>


<script>
var x = "";
var y = "";

var checking = false;


var paths = new Array(); //path와 여러 hole을 넣기 위함
var polygons=[];                //function 안 쪽에 지역변수로 넣으니깐 폴리곤 하나 생성할 때마다 배열이 비어서 클릭했을 때 전체를 못 없애줌.  그래서 전역변수로 만듦.

var polygon

var path = [
	new kakao.maps.LatLng( 44.33512915664864, 115.0587723662637 ),
	new kakao.maps.LatLng(44.18587165301932, 139.95634144177177),
	new kakao.maps.LatLng( 31.038700138229466, 137.80185030986112),
	new kakao.maps.LatLng(31.14848562572545, 117.09878158324054)
];
paths.push(path);
var points = [];        //중심좌표 구하기 위한 지역구 좌표들



var mapContainer = document.getElementById('map'),
mapOption = { 
	center: new kakao.maps.LatLng(35.160120436910596, 126.85143288281274), // 지도의 중심좌표
	level: 8 // 지도의 확대 레벨
};
var map = new kakao.maps.Map(mapContainer, mapOption);    


for(var i=0;i<xLocation.length;i++){
	marker(xLocation[i],yLocation[i]);
	CustomOverlay(xLocation[i],yLocation[i],MapText[i]);
}

//기본 마커 생성
var DefaultMarker = "";

//지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	if(DefaultMarker != ""){
		DefaultMarker.setMap(null);
	}
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng; 
    
  	x = "";
  	y = "";
    
    DefaultMarker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(latlng.getLat(), latlng.getLng())
    });
    
    if(!checking){
	    x = latlng.getLat();
	    y = latlng.getLng();
	    DefaultMarker.setMap(map);
    }
    checking = false;
    /* var resultDiv = document.getElementById('clickLatlng'); 
    resultDiv.innerHTML = message; */
    console.log("["+latlng.getLng()+","+ latlng.getLat()+"]");
    
});

var geojsonurl = "/resources/json/${url}";
//행정구역 구분
$.getJSON(geojsonurl, function(geojson) {

	var data = geojson.features;
    var coordinates = [];    //좌표 저장할 배열
    var name = '';            //행정 구 이름
 
    $.each(data, function(index, val) {
 
        coordinates = val.geometry.coordinates;
		name = val.properties.SIG_ENG_NM;
		
		if(coordinates.length > 1){
			for(var i=0;i<coordinates.length;i++){
				var templist = [];
				templist.push(coordinates[i])
				setting(templist, i);
			} 
			displayArea(paths);
		}else{
			setting(coordinates, 0);
			displayArea(paths);
		}
    })
})

function setting(a, num){
	if(num == 0){
		var hole = [];
	}else{
		eval("var hole"+num+"=[];");
	}
	
    $.each(a[0], function(index, coordinate) {        //console.log(coordinates)를 확인해보면 보면 [0]번째에 배열이 주로 저장이 됨.  그래서 [0]번째 배열에서 꺼내줌.
    	var point = new Object(); 
        point.x = coordinate[1];
        point.y = coordinate[0];
        if(num == 0){
        	hole.push(new daum.maps.LatLng(coordinate[1], coordinate[0]));            //new daum.maps.LatLng가 없으면 인식을 못해서 path 배열에 추가
        	points.push(point);
    	}else{
    		eval("hole"+num+".push(new daum.maps.LatLng(coordinate[1], coordinate[0]));");
    	}
    })
    if(num == 0){
    	paths.push(hole);	
	}else{
		eval("paths.push(hole"+num+");");
	}
}


//행정구역 폴리곤
function displayArea(paths) {
    // 다각형을 생성합니다 
    polygon = new daum.maps.Polygon({
        map : map, // 다각형을 표시할 지도 객체
        path : paths,
        strokeWeight : 2,
        strokeColor : '#9E9E9E',
        strokeOpacity : 0.8,
        fillColor :'#9E9E9E',
        fillOpacity : 0.7
    });
    
    polygons.push(polygon);            //폴리곤 제거하기 위한 배열
 	
	var moveLatLon = centroid(points);
	
    kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
        checking = true;
    });
	
    map.setCenter(moveLatLon);   
}
	

function centroid (points) {
    var i, j, len, p1, p2, f, area, x, y;
 
    area = x = y = 0;
 
    for (i = 0, len = points.length, j = len - 1; i < len; j = i++) {
            p1 = points[i];
            p2 = points[j];
 
            f = p1.y * p2.x - p2.y * p1.x;
            x += (p1.x + p2.x) * f;
            y += (p1.y + p2.y) * f;
            area += f * 3;
    }
    return new daum.maps.LatLng(x/area, y/area);
}


function changeArea(value){
	location.href="/testmap.do?area="+value	
}

function InsertMarker(){
	if(x != ""){
		$.ajax({
			type: "POST",
			url: "/insertMarkerAjax.do",
			data: {
				xLocation : x,
				yLocation : y,
				text : $("#text").val(),
				img : $("#img").val()
			},
			success:function(){
				alert("성공")
			},
			error: function(){
				alert("에러");
			}
		});
	}else{
		alert("마커 위치 없음");
	}
}


function marker(x,y){

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(x,y); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map)
}

function CustomOverlay(x,y,text){
	// 커스텀 오버레이에 표시할 내용입니다     
	// HTML 문자열 또는 Dom Element 입니다 
	var content = '<div class ="label"><span class="left"></span><span class="center">'+text+'</span><span class="right"></span></div>';

	// 커스텀 오버레이가 표시될 위치입니다 
	var position = new kakao.maps.LatLng(x,y);  

	// 커스텀 오버레이를 생성합니다
	var customOverlay = new kakao.maps.CustomOverlay({
	    position: position,
	    content: content,
	    yAnchor: 2.5// 컨텐츠의 y 위치
	});

	// 커스텀 오버레이를 지도에 표시합니다
	customOverlay.setMap(map);
}

</script>
