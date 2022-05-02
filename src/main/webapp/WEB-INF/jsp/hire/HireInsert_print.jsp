<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<section id="sub-content">
       <div class="inner1200"> <!--inner 시작 -->
           
           <!-- 서브 타이틀부분 -->
           <div class="sub-title-box">
               <h2>응시표 출력</h2>
               <ul class="list_ul">
                   <li class="home"><i class="xi-home"></i></li>
                   <li>열린광장</li>
                   <li>채용공고</li>
                   <li>응시표 출력</li>
				</ul>
           </div>


		<!-- 서브컨텐츠 시작 -->
		<div id="sub-con-start">

               <!-- 응시표 출력 -->
               <div class="examin_wrap">
                   <div class="title_box">
                       <h2>${bntitle }</h2>
                   </div>
                   <div class="content_txt">
                       <p class="bolder">본인은 재단법인 전라남도문화재단 직원채용 시험에 응시하고자 원서를 제출하여 다음사항을 서약합니다.</p>
                       <p class="txt1">
                           아래 기재사항은 사실과 다름이 없으며 만일 시험결과에 부당한 영향을 끼칠 목적으로 허위사실을 기재하였을 때에는<br>
                           당해 시험이 정지 또는 무효가 되고 향후 5년간 응시자격이 정지되어도 의의를 제기하지 않습니다.
                       </p>
                   </div>
                   <div class="content_txt2">
                       <div class="date">
                           ${fn:substring(bndate,0,4) }년 <span class="gab-h-40"></span>${fn:substring(bndate,5,7) } 월 <span class="gab-h-40"></span>${fn:substring(bndate,8,10) } 일
                       </div>
                       <div class="company">재단법인 전라남도 무노하재단 대표이사 귀하</div>
                   </div>
                   
                   <div class="tbl_examin_box table_wrap_mobile" id="printpage">
                       <table class="tbl_examin">
                           <caption>응시표</caption>
                           <colgroup>
                               <col style="width: 15%;">
                               <col style="width: 30%;">
                               <col style="width: 15%;">
                               <col style="width: 40%;">
                           </colgroup>
                           <thead>
                               <tr>
                                   <th colspan="4">응 시 표</th>
                               </tr>
                           </thead>
                           <tbody>
                               <tr>
                                   <td rowspan="2" class="lb_none"><span class="bold">지원내역</span></td>
                                   <td colspan="2"><span class="bold">응시분야</span></td>
                                   <td><span class="bold">직급</span></td>
                               </tr>
                               <tr>
                                   <td colspan="2">${hire.THC_DEPARTMENT }</td>
                                   <td><span class="bold red-c">※ 해 당 사 항 없 음</span></td>
                               </tr>
                               <tr>
                                   <td rowspan="3" class="lb_none top_bold"><span class="bold">※<br>응시<br>번호</span></td>
                                   <td rowspan="3" class="top_bold right_bold">${hire.THC_NUMBER }</td>
                                   <td rowspan="3"><span class="bold">성명</span></td>
                                   <td class="txt">(한글) ${hire.THC_NAME }</td>
                               </tr>
                               <tr>
                                   <td class="txt">(한자) ${hire.THC_CNAME }</td>
                               </tr>
                               <tr>
                                   <td class="txt">(영문) ${hire.THC_ENAME }</td>
                               </tr>
                           </tbody>
                       </table>
                   </div>

                   <div class="warning_box">
                       <h2>주의사항</h2>
                       <h5>
                           1. 응시표를 분실하였을 때는 시험일 전까지 재교부 받을 수 있습니다.<br>
                           2. 시험당일은 응시표를 지참하고 시험시작 20분전까지 시험장소에 등록하여야 합니다.
                       </h5>
                   </div>

                   <div class="gab50"></div>
                   <div class="textC">
                       <button type="button" class="btn_support purple" title="출력" onclick="hire_print()">출력</button>
                       <button type="button" class="btn_support gray" title="목록" onclick="location.href='/jact/open/hire.do'">목록</button>
                   </div>
               </div>
               <!-- // 응시표 출력 -->

           </div>

	</div> <!--inner 끝 -->
</section>
<script>
function hire_print(){
	
	var popupWindow = window.open("", "_blank" );
	popupWindow.document.write( '<head>'); 
	popupWindow.document.write( '<link href="/resources/publish/jact/css/sub.css" type="text/css" rel="stylesheet">' );
	popupWindow.document.write( '<link href="/resources/css/layout.css" type="text/css" rel="stylesheet">' );
	popupWindow.document.write( '<link href="/resources/publish/jact/css/common.css" type="text/css" rel="stylesheet">' );
	popupWindow.document.write( '</head>' );
	popupWindow.document.write( '<body>'); 
	
	popupWindow.document.write( '<section id="sub-content">'); 
		popupWindow.document.write( '<div class="inner1200">'); 
			popupWindow.document.write( '<div id="sub-con-start">'); 
				popupWindow.document.write( '<div class="examin_wrap">'); 
					popupWindow.document.write( $("#printpage").html() );
				popupWindow.document.write( '</div>' );
			popupWindow.document.write( '</div>' );
		popupWindow.document.write( '</div>' );
	popupWindow.document.write( '</section>' );

	popupWindow.document.write( '</body>' );
	popupWindow.document.close()
	
	setTimeout(function() {
		popupWindow.print();
	}, 500);
	
	
// 	var initBody = document.body.innerHTML;
// 	window.onbeforeprint = function () {
// 		document.body.innerHTML = document.getElementById("printpage").innerHTML;
// 	}
// 	window.onafterprint = function () {
// 		document.body.innerHTML = initBody;
// 	}

// 	window.print();

}

function hire_back(){
	window.history.back();
}


</script>