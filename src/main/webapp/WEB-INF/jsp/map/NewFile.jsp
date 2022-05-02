<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<html>
<head>
    <meta charset="utf-8">
    <title>지도 생성하기</title>
    
</head>
<body>
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:800px;"></div>
<div id="clickLatlng"></div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e7849c0dae6357d65f32168ce249e4d5"></script>
<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(35.160120436910596, 126.85143288281274), // 지도의 중심좌표
    level: 10 // 지도의 확대 레벨
};

var path = [
	new kakao.maps.LatLng( 44.33512915664864, 115.0587723662637 ),
	new kakao.maps.LatLng(44.18587165301932, 139.95634144177177),
	new kakao.maps.LatLng( 31.038700138229466, 137.80185030986112),
	new kakao.maps.LatLng(31.14848562572545, 117.09878158324054)
];

var hole = [
	new kakao.maps.LatLng(35.464020174631, 127.03045012009714 ),
	 new kakao.maps.LatLng(35.45931724796559, 127.00273502914737),
	 new kakao.maps.LatLng(35.43956195369177, 126.99118707458497),
	 new kakao.maps.LatLng(35.4245070462118, 126.97040075637265),
	 new kakao.maps.LatLng(35.405684454300044, 126.97386514274139),
	 new kakao.maps.LatLng(35.397212853569286, 126.9369116881417),
	 new kakao.maps.LatLng(35.41791963919076, 126.91381577901689),
	 new kakao.maps.LatLng(35.441443619220095, 126.90111302899825),
	 new kakao.maps.LatLng(35.466841798647444, 126.84914723346742),
	 new kakao.maps.LatLng(35.49035148213918, 126.83067050616759),
	 new kakao.maps.LatLng(35.483769463812656, 126.81796775614897),
	 new kakao.maps.LatLng(35.46778231798839, 126.8110389834115),
	 new kakao.maps.LatLng(35.468722826330186, 126.76946634698686),
	 new kakao.maps.LatLng(35.453673373033595, 126.74406084694958),
	 new kakao.maps.LatLng(35.418098752392645, 126.74969471949014),
	 new kakao.maps.LatLng(35.400795082388555, 126.7243812448524),
	 new kakao.maps.LatLng(35.3675083538763, 126.72274811745642),
	 new kakao.maps.LatLng(35.35152584616244, 126.66640522229507),
	 new kakao.maps.LatLng(35.332875589163926, 126.64272487505333),
	 new kakao.maps.LatLng(35.333541743899474, 126.59781387166383),
	 new kakao.maps.LatLng(35.32421507797689, 126.579849470308),
	 new kakao.maps.LatLng(35.30355934577822, 126.582299161402),
	 new kakao.maps.LatLng(35.30622489795791, 126.53167221212658),
	 new kakao.maps.LatLng(35.35885155490013, 126.51207468337479),
	 new kakao.maps.LatLng(35.38445590619063, 126.47944918323326),
	 new kakao.maps.LatLng(35.40852421818193, 126.49180880198969),
	 new kakao.maps.LatLng(35.43090689490265, 126.47738924677387),
	 new kakao.maps.LatLng(35.42307366540776, 126.43138399918058),
	 new kakao.maps.LatLng(35.39229288952134, 126.40117159777604),
	 new kakao.maps.LatLng(35.37605829338095, 126.412844571046),
	 new kakao.maps.LatLng(35.323973589650414, 126.37645236026326),
	 new kakao.maps.LatLng(35.294836320569736, 126.38263216488133),
	 new kakao.maps.LatLng(35.266809822564085, 126.34074679020685),
	 new kakao.maps.LatLng(35.24101687890778, 126.33800020826101),
	 new kakao.maps.LatLng(35.242699277568185, 126.30572787039708),
	 new kakao.maps.LatLng(35.21297176340787, 126.30229464296472),
	 new kakao.maps.LatLng(35.20118992463912, 126.34623995409859),
	 new kakao.maps.LatLng(35.20231207817191, 126.37645235550313),
	 new kakao.maps.LatLng(35.179304832064396, 126.35585299090913),
	 new kakao.maps.LatLng(35.15629107003344, 126.34418001379697),
	 new kakao.maps.LatLng(35.14674686930769, 126.2713955922315),
	 new kakao.maps.LatLng(35.14562394856473, 126.14436617723511),
	 new kakao.maps.LatLng(35.100132639614046, 126.04754915954494),
	 new kakao.maps.LatLng(35.10181795590316, 126.01527682168101),
	 new kakao.maps.LatLng(35.08102995351768, 126.0173367581404),
	 new kakao.maps.LatLng(35.05180542576451, 126.05716219340978),
	 new kakao.maps.LatLng(35.03325366463435, 126.14024629812612),
	 new kakao.maps.LatLng(35.00794902144775, 126.09767427796514),
	 new kakao.maps.LatLng(34.99051237877727, 126.11690035158622),
	 new kakao.maps.LatLng(34.95281404119274, 126.12239351547797),
	 new kakao.maps.LatLng(34.93592856375616, 126.05922212976246),
	 new kakao.maps.LatLng(34.8734220796398, 125.96858492399059),
	 new kakao.maps.LatLng(34.83905141618831, 126.05647554619432),
	 new kakao.maps.LatLng(34.82721557069848, 126.04480257292438),
	 new kakao.maps.LatLng(34.80635779894586, 125.99811067984464),
	 new kakao.maps.LatLng(34.779291200517, 125.89305392041521),
	 new kakao.maps.LatLng(34.73698185649058, 125.88618746283969),
	 new kakao.maps.LatLng(34.67279504290671, 125.9220461585892),
	 new kakao.maps.LatLng(34.63445258895047, 125.95214912273381),
	 new kakao.maps.LatLng(34.621667830114276, 125.79677898521322),
	 new kakao.maps.LatLng(34.59689175449814, 125.80357642872974),
	 new kakao.maps.LatLng(34.596581885835015, 125.83174053437504),
	 new kakao.maps.LatLng(34.45857181200265, 126.03851495604262),
	 new kakao.maps.LatLng(34.40090322633983, 126.03463070260462),
	 new kakao.maps.LatLng(34.348005416382826, 126.02686219784171),
	 new kakao.maps.LatLng(34.31272165526182, 125.9511192558004),
	 new kakao.maps.LatLng(34.21320580293198, 126.04239921781232),
	 new kakao.maps.LatLng(34.2164178290163, 126.05405197812637),
	 new kakao.maps.LatLng(34.34479841018674, 126.16086894767177),
	 new kakao.maps.LatLng(34.492537075747784, 126.38689275108923),
	 new kakao.maps.LatLng(34.468523106616374, 126.45486718909213),
	 new kakao.maps.LatLng(34.34834964337475, 126.46069356924916),
	 new kakao.maps.LatLng(34.271348081611244, 126.52478375097638),
	 new kakao.maps.LatLng(34.21836855566442, 126.55003139886684),
	 new kakao.maps.LatLng(34.186243529209406, 126.47623058354456),
	 new kakao.maps.LatLng(34.10426932614209, 126.51313099120571),
	 new kakao.maps.LatLng(34.09140341231069, 126.58304755308997),
	 new kakao.maps.LatLng(34.10909353954931, 126.6723853821643),
	 new kakao.maps.LatLng(34.18785007126199, 126.70540153638743),
	 new kakao.maps.LatLng(34.292209638647556, 126.63354284778416),
	 new kakao.maps.LatLng(34.29702310989747, 126.68598026919734),
	 new kakao.maps.LatLng(34.27776757065177, 126.7986236247561),
	 new kakao.maps.LatLng(34.31948232907967, 126.89378783398747),
	 new kakao.maps.LatLng(34.31467014744774, 127.0996532751981),
	 new kakao.maps.LatLng(34.40284966927027, 127.12684304926418),
	 new kakao.maps.LatLng(34.460516912439665, 127.24531277912365),
	 new kakao.maps.LatLng(34.44770540988238, 127.32688210898952),
	 new kakao.maps.LatLng(34.41566805207112, 127.51526840073325),
	 new kakao.maps.LatLng(34.45090847101949, 127.55799519978108),
	 new kakao.maps.LatLng(34.57573195783644, 127.49390501805385),
	 new kakao.maps.LatLng(34.601313653955714, 127.59489560744223),
	 new kakao.maps.LatLng(34.54374376422689, 127.6686964227645),
	 new kakao.maps.LatLng(34.42688252502015, 127.78328189918595),
	 new kakao.maps.LatLng(34.41887234128287, 127.81824018012807),
	 new kakao.maps.LatLng(34.50054019461126, 127.81629805340908),
	 new kakao.maps.LatLng(34.57573195783644, 127.75026574496282),
	 new kakao.maps.LatLng(34.586924919001774, 127.80464529309502),
	 new kakao.maps.LatLng(34.7243153478768, 127.77357127011899),
	 new kakao.maps.LatLng(34.784950155419004, 127.75415000292892),
	 new kakao.maps.LatLng(35.00636619529638, 127.79299253688647),
	 new kakao.maps.LatLng(35.06838282672491, 127.75415000238556),
	 new kakao.maps.LatLng(35.24146153334467, 127.61237475189803),
	 new kakao.maps.LatLng(35.36350602759674, 127.45894673584385),
	 new kakao.maps.LatLng(35.309638949023814, 127.38320379380258),
	 new kakao.maps.LatLng(35.328654958991315, 127.1831647417448),
	 new kakao.maps.LatLng(35.31914751476805, 127.05498436724176),
	 new kakao.maps.LatLng(35.46164174772257, 127.02973671989466),
	 new kakao.maps.LatLng(35.464020174631, 127.03045012009714)
];


 var map = new kakao.maps.Map(mapContainer, mapOption),
     customOverlay = new kakao.maps.CustomOverlay({}),
     infowindow = new kakao.maps.InfoWindow({removable: true});

//다각형을 생성하고 지도에 표시합니다
var polygon = new kakao.maps.Polygon({
	map: map,
    path: [path, hole], // 좌표 배열의 배열로 하나의 다각형을 표시할 수 있습니다
    strokeWeight: 2,
    strokeColor: '#9E9E9E',
    strokeOpacity: 0.8,
    fillColor: '#9E9E9E',
    fillOpacity: 0.7 
});
kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
	alert("영역이외에 등록은 불가능 합니다.");
	marker.setMap(null);
});

//지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter() 
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);

// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng; 
    
    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);
    
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    
    var resultDiv = document.getElementById('clickLatlng'); 
    resultDiv.innerHTML = message;
    
});

</script>

</body>
</html>