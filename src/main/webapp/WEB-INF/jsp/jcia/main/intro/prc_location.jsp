<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=buCznVpOVg1XhxaeAkia&submodules=geocoder"></script>
<script>

var map;
$(document).ready(function(){
	// 탭 지정
	tabFucNomal('.directionTab li','.subDirectionCon');
	map = new naver.maps.Map('map');
	setTab(0);
});

function setTab(what) {
	sc.hide();
	sc.eq(what).fadeIn();
	a.removeClass('active');
	a.eq(what).addClass('active');	
	if(what == 0){
		pf_locationChange(34.817283,126.45960339999999);
	}else if(what == 1){
		pf_locationChange(35.0218239,126.796994);
	}else if(what == 2){
		pf_locationChange(35.0247137,126.7818813);
	}else if(what == 3){
		pf_locationChange(34.6391466,126.7735558);
	}else if(what == 4){
		pf_locationChange(34.9689184,127.4809015);
	}else if(what == 5){
		pf_locationChange(34.8160939,126.42607);
	}
	
// 	pf_test();
}

function pf_locationChange(lat,lng){
	
	var addr = new naver.maps.LatLng(lat,lng);
	map.setCenter(addr);
	
	var buildname = $(".directionTab .active a").text();
	
 	var marker = new naver.maps.Marker({
      position: addr,
      map: map
    });
    
    // 마크 클릭시 인포윈도우 오픈
    var infowindow = new naver.maps.InfoWindow({
        content: '<h4 style="padding:5px;">'+buildname+'</h4>'
    });
    
    infowindow.open(map, marker);
}


/* function pf_test(){
	var myaddress = '목포시 석현로 46';
	naver.maps.Service.geocode({address: myaddress}, function(status, response) {
	    if (status !== naver.maps.Service.Status.OK) {
	        return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
	    }
	    var result = response.result;
	    console.log(result.items[0].point.x)
	    console.log(result.items[0].point.y)
	});
}
 */



</script>
  <!-- 본문 시작 -->
            <div class="subContentInner">
            	<div class="subDirectionWrap"> <!-- 찾아오시는길 시작 -->
                    <div class="subTabWrap directionTabWrap">   <!-- 탭 -->               	
                        <ul class="subTabUl directionTab">
                        	<li class="active">
                            	<a href="javascript:;">전남정보진흥원 <br>(본원)
                                </a>
                            </li>
                        	<li>
                            	<a href="javascript:;">전남실감미디어 <br>산업지원센터
                                </a>
                            </li>
                        	<li>
                            	<a href="javascript:;">전남콘텐츠기업 <br>육성센터
                                </a>
                            </li>
                        	<li>
                            	<a href="javascript:;">전남음악 <br>창작소
                                </a>
                            </li>
                        	<li>
                            	<a href="javascript:;">전남콘텐츠 <br>코리아랩
                                </a>
                            </li>
                        	<li>
                            	<a href="javascript:;">목포벤처문화사업 <br>지원센터
                                </a>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="subDirectionCon">  <!-- 탭 내용 - 전남정보진흥원(본원) -->
                    	<div class="contentBox">
                        	<div class="subjectBox">
                            	<h2>전남정보진흥원(본원)</h2>
                            </div>
                            <div class="addressBox">
                            	<ul class="directionAddressUl">
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-compass"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>Address</h3>
                                            <h4>
                                                58564 전라남도 무안군 삼향읍 오룡3길 2, <br>
                                                전남중소기업진흥원 건물 內 1층
                                            </h4>
                                        </div>
                                    </li>
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-headset"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>C/S Center</h3>
                                            <h4>
                                                Tel. 061-280-7007 <br>
                                                Fax. 061-280-7008
                                            </h4>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div> <!-- 탭내용 끝 -->
                    
                    <div class="subDirectionCon">  <!-- 탭 내용 -전남실감미디어 산업지원센터 -->
                    	<div class="contentBox">
                        	<div class="subjectBox">
                            	<h2>전남실감미디어 산업지원센터</h2>
                            </div>
                            <div class="addressBox">
                            	<ul class="directionAddressUl">
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-compass"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>Address</h3>
                                            <h4>
                                                58323 전라남도 나주시 빛가람로 777 
                                            </h4>
                                        </div>
                                    </li>
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-headset"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>C/S Center</h3>
                                            <h4>
                                                Tel. 061-339-6917 <br>
                                                Fax. 061-339-6901
                                            </h4>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div> <!-- 탭내용 끝 -->
                    
                    <div class="subDirectionCon">  <!-- 탭 내용 - 전남콘텐츠기업 육성센터 -->
                    	<div class="contentBox">
                        	<div class="subjectBox">
                            	<h2>전남콘텐츠기업 육성센터</h2>
                            </div>
                            <div class="addressBox">
                            	<ul class="directionAddressUl">
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-compass"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>Address</h3>
                                            <h4>
                                                58322 전라남도 나주시 우정로 10, <br>
                                                이노파크식스틴 3층
                                            </h4>
                                        </div>
                                    </li>
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-headset"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>C/S Center</h3>
                                            <h4>
                                                Tel. 061-339-6996
                                            </h4>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div> <!-- 탭내용 끝 -->
                    
                    <div class="subDirectionCon">  <!-- 탭 내용 - 전남음악 창작소 -->
                    	<div class="contentBox">
                        	<div class="subjectBox">
                            	<h2>전남음악 창작소</h2>
                            </div>
                            <div class="addressBox">
                            	<ul class="directionAddressUl">
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-compass"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>Address</h3>
                                            <h4>
                                                59231 전라남도 강진군 오감길 2
                                            </h4>
                                        </div>
                                    </li>
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-headset"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>C/S Center</h3>
                                            <h4>
                                                Tel. 061-433-3636 <br>
                                                Fax. 061-432-9081
                                            </h4>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div> <!-- 탭내용 끝 -->
                    
                    <div class="subDirectionCon">  <!-- 탭 내용 - 전남콘텐츠 코리아랩 -->
                    	<div class="contentBox">
                        	<div class="subjectBox">
                            	<h2>전남콘텐츠 코리아랩</h2>
                            </div>
                            <div class="addressBox">
                            	<ul class="directionAddressUl">
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-compass"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>Address</h3>
                                            <h4>
                                                전남 순천시 중앙로 255, <br>
                                                공동실험실습관 506호
                                            </h4>
                                        </div>
                                    </li>
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-headset"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>C/S Center</h3>
                                            <h4>
                                                Tel. 061-755-9525 <br>
                                                Fax. 061-755-9559
                                            </h4>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        
                    </div> <!-- 탭내용 끝 -->
                    
                    <div class="subDirectionCon">  <!-- 탭 내용 - 목포벤처문화산업 지원센터 -->
                    	<div class="contentBox">
                        	<div class="subjectBox">
                            	<h2>목포벤처문화산업 지원센터</h2>
                            </div>
                            <div class="addressBox">
                            	<ul class="directionAddressUl">
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-compass"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>Address</h3>
                                            <h4>
                                                58656 전라남도 목포시 석현로 46 
                                            </h4>
                                        </div>
                                    </li>
                                	<li>
                                    	<div class="iconBox">
                                        	<i class="fal fa-headset"></i>
                                        </div>
                                        <div class="letterBox">
                                        	<h3>C/S Center</h3>
                                            <h4>
                                                Tel. 061-280-7494 <br>
                                                Fax. 061-280-7413
                                            </h4>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div> <!-- 탭내용 끝 -->
                
                 <div class="mapBox">
                 	<div class="innerMapBox">                        
                          <div id="map" style="width:100%;height:400px;"></div>
                    </div>
                 </div>
               </div> <!-- 찾아오시는길 끝 -->
            </div>
            <!-- 본문 끝 -->