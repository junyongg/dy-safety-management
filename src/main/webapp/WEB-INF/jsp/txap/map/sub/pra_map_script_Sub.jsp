<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<style>
.map {
    position: relative;
    width: 100%;
    height: 400px;
    border: 1px solid #eee;
    padding: 5px;
}
.map #moveMapBtnBox {
    position: absolute;
    right: 5px;
    top: 5px;
    z-index: 10;
}
</style>

<script type="text/javascript">

var map = "";

function pf_setMap(lat,lng,mapID,latID,lngID){

	var isDefault = !(lat && lng);
	
	
	var lat = lat || "34.81642997793263";
	var lng = lng || "126.46295638457634";
	
	var container = document.getElementById(mapID);
	
	var options = {
		center: new kakao.maps.LatLng(lat, lng),
		level: 8
	};

	map = new kakao.maps.Map(container, options);
	
	marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	
	if(!isDefault){
		marker.setMap(map);
	}
	
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    pf_setMarker(latlng,latID,lngID);
	});
}


function pf_setMarker(latLng,latID,lngID){
	marker.setMap(map);
	// 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latLng);
    
    $('#'+latID).val(latLng.getLat());
    $('#'+lngID).val(latLng.getLng());
}



function pf_moveMap(addr1,addr2,latID,lngID){
	var address = $('#'+addr1).val() + ' ' + $('#'+addr2).val();
	address = address.trim();
	
	var geocoder = new daum.maps.services.Geocoder();
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {

	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	       	pf_setMarker(coords,latID,lngID);
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    }else{
	    	cf_smallBox('지도', '주소값이 없거나 주소로 해당 위치를 찾을 수 없습니다.', 3000,'gray');
	    }
	}); 
}

function pf_deleteAddr(){
	$('.addrInput').val('');
}

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

//주소 찾기
function pf_execDaumPostcode(post,addr2) {
	new daum.Postcode({
	  oncomplete: function(data) {
	      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	      // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	      var roadAddr = data.roadAddress || data.jibunAddress; // 도로명 주소 변수
	      // 우편번호와 주소 정보를 해당 필드에 넣는다.
	      document.getElementById(post).value = data.zonecode;
	      document.getElementById(addr2).value = roadAddr;
	     
	  }
	}).open();
}

function cf_replaceTrim(obj){
	$(obj).find(".checkTrim").each(
	function (index, element){
		$(element).val($(this).val().trim());
	});
}
</script>

