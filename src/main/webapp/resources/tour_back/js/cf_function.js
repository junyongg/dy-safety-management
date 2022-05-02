var token = $("meta[name='_csrf']").attr("content");

$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': token,
	    'AJAX': true
	  },
	  statusCode :{
		  401 : function() {
			  alert("인증에 실패 했습니다. 로그인 페이지로 이동합니다.");
              location.href = "/cf/member/login.do"; 
		  },
		  403 : function() {
			  alert("세션이 만료가 되었습니다. 로그인 페이지로 이동합니다.");
			  location.href = "/cf/member/login.do";  
		  }
	  }
	});


//=======================공유==========================
//페이스북
function facebook(){
	var url = encodeURIComponent(document.URL); 
	window.open("http://www.facebook.com/share.php?u=" + url);
}
//트위터
function twitter(){
	var url = encodeURIComponent(document.URL);
	window.open("https://twitter.com/intent/tweet?url="+url); // text 파라미터 삭제함
}
//밴드
function band(title){
	var url = encodeURIComponent(document.URL);
	window.open("http://www.band.us/plugin/share?body="+encodeURIComponent(title)+encodeURIComponent("\n")+location.href+"&route="+location.href, "share_band", "width=410, height=540, resizable=no");

}
//구글+
function google(){
	var url = encodeURIComponent(document.URL);
	window.open("https://plus.google.com/share?url="+url);
}

//카카오스토리
function cf_kakaoStroryShare2() {
	var url = document.URL;
	Kakao.Story.share({  
	    url: url/*,  
	    text: '${SNSInfo.TITLE }'*/
	});
}

//블로그
function cf_blog(){
	var url = document.URL
	window.open("http://blog.naver.com/openapi/share?url="+url)
}


