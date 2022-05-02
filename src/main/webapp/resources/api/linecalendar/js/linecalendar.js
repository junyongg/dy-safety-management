
//해당 년월 마지막 날짜
function lastDay(year, month){
	//var curDate = new Date();
	var lastDate = new Date(year, month, "");
	return lastDate.getDate();

}

//해당 월의 일수
//32 - new Date(year, month, 32).getDate()
//위 코드를 쓰면 윤년도 계산 가능!
function fn_DayOfMonth(year, month){
    //month 는 0 부터 시작해서..
    return 32 - new Date(year, month-1, 32).getDate();
}

var dayIDs = [ 'sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat' ];

//날짜를 출력하는 함수
function getCalender(year, month){	
	var CurrentDate = new Date(); 
	var CurrentDateYear = CurrentDate.getFullYear(); 
	var CurrentDateMonth = CurrentDate.getMonth()+1; 
	var CurrentDateDay = CurrentDate.getDate(); 
	var today = new Date(CurrentDateYear + "-" + CurrentDateMonth + "-" + CurrentDateDay);
	
	var day;
	var toweek;
	var dayCnt = lastDay(year, month);
	
	var start;
	var end;
	
	var temp = '';
		temp += '<ul class="day_ul">';
		for(var i = 1; i <= dayCnt; i++ ){
			var date = new Date((year+'/'+month+'/'+i)) //익스에서 '-'안되서 '/'로 변경
			var toweek = getInputDayLabel(year, month, i)
			var dayClass = dayIDs[date.getDay()]
			var dateClass = getFormatDate(date)
			temp += '<li onclick="getDetailList(this)">';
			if(toweek == "S"){
				temp += '	<a href="javascript:;" class="we">';
			}else{
				temp += '	<a href="javascript:;">';
			}
			temp += '		<p class="dy">'+toweek+'</p><span class="line"></span>';
			temp +=	'		<p class="num">'+i+'</p>';
			temp += '	</a>';
			temp += '</li>';
		}
		temp += '</ul>';
		
	return temp;
}

function getDateTime(dateVal){
	var date = new Date(dateVal)
	var time = date.getTime()/1000
	return time
}

//yyyyMMdd 포맷으로 반환
function getFormatDate(date){
	var year = date.getFullYear();                 //yyyy
	var month = (1 + date.getMonth());             //M
	month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
	var day = date.getDate();                      //d
	day = day >= 10 ? day : '0' + day;             //day 두자리로 저장
	return  year + '/' + month + '/' + day;
}
	
//요일 구하기
function getInputDayLabel(year,month,day) {
    var week = new Array('S', 'M', 'T', 'W', 'T', 'F', 'S');
    var toweek = new Date(year+'/'+month+'/'+day).getDay();
    var todayLabel = week[toweek];
    return todayLabel;
}

