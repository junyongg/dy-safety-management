var token = $("meta[name='_csrf']").attr("content");

var sesssionWorker = null, sessionDuration;
$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': token,
	    'AJAX': true
	  },
	  statusCode :{
		  401 : function() {
			  alert("인증에 실패 했습니다. 로그인 페이지로 이동합니다.");
              location.href = "/txap/user/login.do"; 
		  },
		  403 : function() {
			  alert("세션이 만료가 되었습니다. 로그인 페이지로 이동합니다.");
              location.href = "/txap/user/login.do";  
		  }
	  },
	  dataFilter:function(data,type) {
		  if (sesssionWorker){
	    		sesssionWorker.postMessage(sessionDuration);
	      }
		  return data; 
	  }
	});
$(document).ready(function() {
	// DO NOT REMOVE : GLOBAL FUNCTIONS!
	pageSetUp();
	
	
});

//관리자 게시판 상세보기 페이지 이동
function af_boardDetailView(keyOrKeyno, isNewWindow){
	isNewWindow = isNewWindow || false;
	var goUrl = '/txap/Board/data/detailView.do?BN_KEYNO=' + cf_getKeyno(keyOrKeyno,'BN');
	if( isNewWindow ){
		window.open(goUrl)
	}else{
		location.href = goUrl;
	}
	// /txap/Board/data/detailView.do?BT_KEYNO=BT_0000000000&BN_KEYNO=BN_0000000000&MN_HOMEDIV_C=MN_0000000000&MN_KEYNO=MN_0000000000
}