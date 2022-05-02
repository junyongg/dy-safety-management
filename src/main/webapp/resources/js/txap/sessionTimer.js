var sessionRemain;
var setRemainTimeInterval;
function sessionTimer()
{
	var fixTime = sessionRemain - 30;
	if(fixTime == 0){
		clearInterval(setRemainTimeInterval);
		postMessage("logout");
	}else{
		var hour = Math.floor(fixTime / (60 * 60));
		var min = Math.floor(( fixTime / 60 ) % 60)
		var sec = Math.floor( fixTime  % 60)
		
		postMessage((hour == 0 ? '' : hour+'시간 ') + (min == 0 ? '' : min+'분 ') + (sec == 0 ? '' : sec+'초 '));
		sessionRemain--;
		
	}
}

onmessage = function(e) {
    // the passed-in data is available via e.data
	if(setRemainTimeInterval){
		clearInterval(setRemainTimeInterval);
	}
	sessionRemain = e.data;
	sessionTimer();
	setRemainTimeInterval = setInterval(function(){sessionTimer()},1000);
};

