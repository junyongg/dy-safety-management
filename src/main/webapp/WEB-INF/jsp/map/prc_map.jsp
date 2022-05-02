<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<form id="Form" acion="" method="post">
	<input type="hidden" name="area">
	<input type="hidden" name="type">
</form>

<!-- 헤더 -->
<header id="hd">
    <div class="logo_l"><a href="javascript:;" title="전라남도 문화재단"><img src="/resources/map/img/icon/logo_top.png" alt=""></a></div>
    <div class="center_b">
        <div class="selec_box">
            <span class="tit">지역</span>
            <select id="area" onchange="" class="sel2">
				<option value="all" ${area eq 'all' ||empty area ?'selected':'' } >전체</option>
				<option value="영광" ${area eq '영광'?'selected':'' }>영광</option>
				<option value="장성" ${area eq '장성'?'selected':'' }>장성</option>
				<option value="담양" ${area eq '담양'?'selected':'' }>담양</option>
				<option value="곡성" ${area eq '곡성'?'selected':'' }>곡성</option>
				<option value="구례" ${area eq '구례'?'selected':'' }>구례</option>
				<option value="광양" ${area eq '광양'?'selected':'' }>광양</option>
				<option value="여수" ${area eq '여수'?'selected':'' }>여수</option>
				<option value="순천" ${area eq '순천'?'selected':'' }>순천</option>
				<option value="고흥" ${area eq '고흥'?'selected':'' }>고흥</option>
				<option value="보성" ${area eq '보성'?'selected':'' }>보성</option>
				<option value="화순" ${area eq '화순'?'selected':'' }>화순</option>
				<option value="나주" ${area eq '나주'?'selected':'' }>나주</option>
				<option value="장흥" ${area eq '장흥'?'selected':'' }>장흥</option>
				<option value="영암" ${area eq '영암'?'selected':'' }>영암</option>
				<option value="강진" ${area eq '강진'?'selected':'' }>강진</option>
				<option value="해남" ${area eq '해남'?'selected':'' }>해남</option>
				<option value="진도" ${area eq '진도'?'selected':'' }>진도</option>
				<option value="완도" ${area eq '완도'?'selected':'' }>완도</option>
				<option value="신안" ${area eq '신안'?'selected':'' }>신안</option>
				<option value="목포" ${area eq '목포'?'selected':'' }>목포</option>
				<option value="무안" ${area eq '무안'?'selected':'' }>무안</option>
				<option value="함평" ${area eq '함평'?'selected':'' }>함평</option>
			</select>
        </div>
        <div class="selec_box">
            <span class="tit">작품분류</span>
            <select class="sel2" id="type">
                <option value="all" ${type eq 'all' ||empty type? 'selected':'' }>전체</option>
                <option value="벽화" ${type eq '벽화' ? 'selected':'' }>벽화</option>
                <option value="설치" ${type eq '설치' ? 'selected':'' }>설치</option>
                <option value="기타" ${type eq '기타' ? 'selected':'' }>기타</option>
            </select>
        </div>
        <div class="btn_box">
            <button type="button" class="btn_hd_t" title="검색" onclick="Movemap();"><i class="xi-search"></i> 검색</button>
            <button type="button" class="btn_hd_t" title="초기화" onclick="Reset();">초기화</button>
        </div>
    </div>
</header>
<!-- // 헤더 -->

<!-- 메인 컨텐츠 -->
<div class="contents">
	<div id="map" style="width: 100%;height: 880px;"></div>
	
	<!-- 상세페이지 -->
	<div id="detailView">
	</div>
	
</div>
<!-- 메인 컨텐츠 -->


<!-- <input type="text" name="text" id="text">
<button type="button" onclick="InsertMarker()">마커 등록</button> -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6415ea8c2cee8bb76bdce65bdf6a6bda"></script>


<script>
var xLocation = [];
var yLocation = [];
var types = [];
</script>

<c:forEach items="${marker }" var="m" varStatus="v">
	<script>
	xLocation.push('${marker[v.index].MMA_X_LOCATION }');
	yLocation.push('${marker[v.index].MMA_Y_LOCATION }');
	types.push('${marker[v.index].MMS_TYPE }');
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
	level: 9 // 지도의 확대 레벨
};
var map = new kakao.maps.Map(mapContainer, mapOption);    


for(var i=0;i<xLocation.length;i++){
	marker(xLocation[i],yLocation[i],types[i]);
}

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
        strokeWeight : 4,
        strokeColor : '#f3bb08',
        strokeOpacity : 2,
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
	location.href="/map/prc_map.do?area="+value	
}

function marker(x,y,t){
	var imageSrc = "";
	
	if(t == '벽화'){
		imageSrc = "/resources/map/img/icon/icon_btn_red.png";
	}else if(t == '설치'){
		imageSrc = "/resources/map/img/icon/icon_btn_yellow.png";
	}else{
		imageSrc = "/resources/map/img/icon/icon_btn_blue.png";
	}
	
    imageSize = new kakao.maps.Size(36, 55), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    markerPosition = new kakao.maps.LatLng(x, y); // 마커가 표시될 위치입니다
	
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(x,y); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition,
	    image: markerImage
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map)
	
	// 마커에 클릭이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'click', function() {
		DetailPage(x,y,t);
	});
}

function Movemap(){
	$("input[name=area]").val($("#area").val());
	$("input[name=type]").val($("#type").val());
	$("#Form").attr("action","/map/prc_map.do?${_csrf.parameterName}=${_csrf.token}");
	$("#Form").submit();
}

function DetailPage(x,y,t){
	if('${type}' == 'all'){
		t = 'all';
	}
	
	$.ajax({
		type	:	"post",
		url		:	"/detailAjax.do?${_csrf.parameterName}=${_csrf.token}",
		data	:	{
			"xlocation" : x,
			"ylocation" : y,
			"type" 		: t
		},
		success:function(data){
			$("#detailView").html(data);
		},
		error:function(){
			alert("상세페이지 에러");
		}
	});
}


function detail2(){
	$.ajax({
		type	:	"post",
		url		:	"/detailAjax2.do?${_csrf.parameterName}=${_csrf.token}",
		data	:	{
			"key" : $("#MMS_KEYNO").val()
		},
		success:function(data){
			$("#detailView").html(data);
		},
		error:function(){
			alert("상세페이지 에러");
		}
	});
	
}

function Reset(){
	$("#area").val("all");
	$("#type").val("all");
}

</script>
