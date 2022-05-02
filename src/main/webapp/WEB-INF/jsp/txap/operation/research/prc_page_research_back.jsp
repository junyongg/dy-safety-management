<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<style>

/*코멘트*/
.subHealingPlus_CommentWrap {width:100%; border:8px solid #dddddd; position: relative;}
.subHealingPlus_CommentWrap .callBox {background-color:#f5f5f6; padding:24px 10px 13px 45px; border-bottom:2px solid #ddd; font-size:17px; color:#444;}
.subHealingPlus_CommentWrap .conBox {width:100%; padding:30px 34px 18px;}
.subHealingPlus_CommentWrap .leftQBox {width:40px; float:left; font-size:54px; font-weight:500; color:#cccccc; line-height:0.8;}
.subHealingPlus_CommentWrap .rightConBox {width:calc(100% - 40px); float:left; padding-left:20px;}
.subHealingPlus_CommentWrap .rightConBox .question01 {font-size:18px; color:#333; padding-bottom:16px; border-bottom:1px dashed #999999; font-weight:500; margin-bottom:17px;}
.subHealingPlus_CommentWrap .rightConBox .answer01 {margin-bottom:27px;}
.subHealingPlus_CommentWrap .rightConBox .answer01 label {font-size:16px; font-weight:500; color:#666; margin-left:50px;}
.subHealingPlus_CommentWrap .rightConBox .answer01 label:first-of-type {margin-left:0px;}

.subHealingPlus_CommentWrap .rightConBox .commentBox h5 {font-size:16px; font-weight:500; color:#444; margin-bottom:15px;}
.subHealingPlus_CommentWrap .rightConBox .commentBox .formBox .textareaBox {width:85%; float:left; padding-right:13px;}
.subHealingPlus_CommentWrap .rightConBox .commentBox .formBox .textareaBox .textAreaHealing {width:100%; height:60px;}
.subHealingPlus_CommentWrap .rightConBox .commentBox .formBox .btnBox {width:15%; float:left;}
.subHealingPlus_CommentWrap .rightConBox .commentBox .formBox .btnBox .btnHealingUpload {width:100%; height:60px; background-color:#999999; font-weight:500; color:#fff; font-size:15px; text-align:center;}
.subHealingPlus_CommentWrap .rightConBox .commentBox .formBox .btnBox .btnHealingUpload:hover {background:#f173ac}

/* 만족도 결과 */
div#researchRusult {position: absolute; left: 54%; top: 20%; width: 400px; height: 215px; background: #ffffff; overflow: hidden; border: 1px solid #9e9e9e;}
div#researchRusult h4 {float: left; margin: 15px 0 0 15px; padding: 0 0 0 35px; width: 85%; font-size: 1em; color: #2f3646; line-height: 190%;}
div#researchRusult h4 span {font-weight: normal;}
.pointBtn {position: absolute; right: 30px; top: 23px; font-weight: bold; margin: 0; padding: 0;}
 .pointBtn a {color: #225c96; text-decoration: underline;}
#pointView {position: absolute; left: 8px; top: 50px; padding: 10px; width: 360px; background: #f6eeba; z-index: 10000;}
#pointView p.Pagepoint {border-bottom: 1px dotted #d6ce9d; margin-bottom: 5px;}
#pointView p.btn_close02 {clear: both; width: 45px; margin: 0 auto;}
ul.graph li {clear: both; height: 19px; width: 386px; margin: 0 0 13px 0; overflow: hidden;}
ul.graph li div {float: left; width: 386px;}
ul.graph li div dl dt {float: left; width: 79px; font-weight: bold; padding: 2px 0 0 0; color: #5c616f;}
ul.graph li div dl dd {float: left; width: 270px; margin-left: 60px;}
div#researchRusult p.btn_close {position: absolute; right: 0; top: 0; padding: 5px; margin: 0;}
a {text-decoration: none; color: #727272; margin-right: 10px;}
.listNone{display: none;}
.closeImg{width: 20px; height: 20px;}

/* 그래프 */
ul.graph {float: left; width: 330px;}
.hGraph ul {margin: 0 50px 0 20px; padding: 1px 0 0 0; border: 1px solid #ddd; border-top: 0; border-right: 0; font-size: 11px; font-family: Tahoma, Geneva, sans-serif; list-style: none;}
.hGraph li {position: relative; margin: 10px 0; white-space: nowrap; vertical-align: top;}
.hGraph .gTerm {position: absolute; width: 40px; top: 0; left: 1px; line-height: 20px; text-align: left; color: #767676; font-weight: bold;}
.hGraph .gBar {position: relative; display: inline-block; height: 20px; border: 1px solid #ccc; border-left: 0; background: #e9e9e9;}
</style>
<!--의견등록-->
<form:form id="PageForm">
	<fmt:parseNumber value="${fn:substring(currentMenu.MN_KEYNO,4,20)}" var="menuKey"/>
	<input type="hidden" name="TPS_MN_KEYNO" id="TPS_MN_KEYNO" value="${menuKey}"/>
	<input type="hidden" name="TPS_SCORE_NAME" id="TPS_SCORE_NAME"/>
	<div class="subHealingPlus_CommentWrap">
		<c:if test="${not empty currentMenu.MN_QR_KEYNO}">
			<div class="callBox">
				<div style="width: 85%;  display: inline-block;">
					오른쪽 QR Code 이미지를 스마트폰에 인식시키면 자동으로 이 페이지로 연결됩니다.<br/>
					이 QR Code는 페이지의 정보를 담고 있습니다.
				</div>
					<img alt="qr-code" src="/resources/img/upload/${currentMenu.IMG_PATH }"/>
		    </div>
		</c:if>
	    <div class="conBox clearfix">
	    	<div class="leftQBox">Q</div>
	        <div class="rightConBox">
	        	<div class="question01">
	            	현재페이지에서 제공되는 서비스에 대하여 만족하십니까?
	            </div>
	            <div class="answer01">
	            	<label><input type="radio" class="radioHealing01" name="TPS_SCORE" value="5"> 매우만족</label>
	            	<label><input type="radio" class="radioHealing01" name="TPS_SCORE" value="4"> 만족</label>
	            	<label><input type="radio" class="radioHealing01" name="TPS_SCORE" value="3"> 보통</label>
	            	<label><input type="radio" class="radioHealing01" name="TPS_SCORE" value="2"> 불만족</label>
	            	<label><input type="radio" class="radioHealing01" name="TPS_SCORE" value="1"> 매우 불만족</label>
	            </div>
	            <div class="commentBox">
	            	<h5>* 좀 더 나은 서비스 제공을 위해 의견을 수렴하여 빠른 시일 내에 반영하겠습니다.</h5>
	                <div class="formBox clearfix">
	                	<div class="textareaBox">
	                    	<textarea class="textAreaHealing" name="TPS_COMMENT" maxlength="2000"></textarea>
	                    </div>
	                    <div class="btnBox">
	                    	<button type="button" class="btnHealingUpload" onclick="pf_insert()">의견등록</button>
	                    </div>
	                </div>
	            </div>
	            <div style="min-height:31px; margin-top: 10px;">
	            	<div style="width: 85%; float: left; margin-top: 8px;">${currentMenu.MN_MANAGER }</div>
	            	<button type="button" class="btn btnSmall_write btn-default" style="width: 15%;" onclick="pf_PointTow('researchRusult', 'R'); return false;">결과보기</button>
            	</div>
	        </div>
	    </div>
	    
	 
	   <div id="researchRusult" class="listBlock">
		  	<h4>만족도조사결과 <span id="Participants">(참여인원:0명)</span></h4>
		    <p class="pointBtn"><a href="#pointView" onclick="pf_PointTow('pointView', 'S'); return false;">요약설명보기</a></p>
		    <div id="pointView" class="listNone">
		    	<p class="Pagepoint">만족도 조사에 참여해 주셔서 감사합니다.<br>
		        현재 페이지의 만족도 투표는 <strong id="Participants2">총 0명</strong>이 참여하였으며, 현재 "<strong class="scoreName">매우만족</strong>"이 <strong class="scoreCnt">0표</strong>로 가장 많은 표를 받았습니다.<br>
		        투표에 참여한 시민들은 현 페이지에 대해 "<strong class="scoreName">매우만족</strong>" 하고 있습니다.</p>
		        <p class="btn_close02"><a href="#pointView" onclick="pf_PointTow('pointView', 'C'); return false;">닫기</a></p>
		    </div>
		    <div class="hGraph">
		    
		    <ul class="graph">
		    	<li>
		        	<div class="bar_list">
		            	<dl>
		                	<dt class="gTerm">매우만족</dt>
		                    <dd><span id="value05" class="gBar" style="width:0%;">0표</span></dd>
		                </dl>
		            </div>
		        </li>
		    	<li>
		        	<div class="bar_list">
		            	<dl>
		                	<dt class="gTerm">만족</dt>
		                    <dd><span id="value04" class="gBar" style="width:0%;">0표</span></dd>
		                </dl>
		            </div>
		        </li>
		    	<li>
		        	<div class="bar_list">
		            	<dl>
		                	<dt class="gTerm">보통</dt>
		                    <dd><span id="value03" class="gBar" style="width:0%;">0표</span></dd>
		                </dl>
		            </div>
		        </li>
		    	<li>
		        	<div class="bar_list">
		            	<dl>
		                	<dt class="gTerm">불만족</dt>
		                    <dd><span id="value02" class="gBar" style="width:0%;">0표</span></dd>
		                </dl>
		            </div>
		        </li>
		    	<li>
		        	<div class="bar_list">
		            	<dl>
		                	<dt class="gTerm">매우불만족</dt>
		                    <dd><span id="value01" class="gBar" style="width:0%;">0표</span></dd>
		                </dl>
		            </div>
		        </li>
		    </ul>
		    </div>
		    <p class="btn_close"><a href="#researchRusult" onclick="pf_PointTow('researchRusult', 'C'); return false;"><img alt="닫기" src="/resources/img/calendar/btn_close_gray.png" class="closeImg"/></a></p>
		  </div>
		   
	</div>
</form:form>
<script>
$(function(){
	$("#researchRusult").attr("class", 'listNone');
});
//결과보기
function pf_PointTow(point, type){
	var className = $("#"+point).attr('class');
	var key = $("#TPS_MN_KEYNO").val();
	if(type == 'R'){
		$.ajax({
		      type: "POST",
		      url: "/common/page/satisfaction/satisfactionResult.do",
		      data: {
		    	  "TPS_MN_KEYNO" : key
		      },
		      success : function(data){
	    		var dataList = data.resultData;
				var total = 0;
				var max = 0;
				var maxScore = 5;
				var maxScoreNM = "매우만족";
	    		$.each(dataList, function(j){
		    		datas = dataList[j];	
		    		$(".bar_list").find("#value0"+datas.TPS_SCORE).text(datas.COUNT+"표").css("width", datas.COUNT+"0%");
		    		total += datas.COUNT;
		    		if(max < datas.TPS_SCORE){
		    			max = datas.COUNT;
		    			maxScoreNM = datas.TPS_SCORE_NAME;
		    		} 
		    	});
	    	
	    		$(".scoreName").text(maxScoreNM);
	    		$(".scoreCnt").text(max+"표");
	    		$("#Participants").text("(참여인원:"+total+"명)");
	    		$("#Participants2").text("총 "+total+"명");
		      }, 
		      error: function(){
		        return false;
		      }
		    });
	}
	
	if(className != 'listNone'){
		$("#"+point).attr("class", 'listNone');
	}else{
		$("#"+point).attr("class", 'listBlock');		
	}
}

//만족도 등록
function pf_insert(){
	var checkval = $("input[type=radio][name=TPS_SCORE]:checked").val()
	if(checkval == "5")
		$("#TPS_SCORE_NAME").val("매우만족");
	if(checkval == "4")
		$("#TPS_SCORE_NAME").val("만족");
	if(checkval == "3")
		$("#TPS_SCORE_NAME").val("보통");
	if(checkval == "2")
		$("#TPS_SCORE_NAME").val("불만족");
	if(checkval == "1")
		$("#TPS_SCORE_NAME").val("매우불만족");
	
	var menu = $("#TPS_MN_KEYNO").val();
	var satisfaction = $("input[name=TPS_SCORE]:radio:checked").val();
	if(!satisfaction){
		alert("만족도를 선택하세요.");
		return false;
	}

	$.ajax({
	    type   : "POST",
	    url    : "/common/page/satisfaction/satisfactionInsert.do",
	    data   : $("#PageForm").serialize(),
	    async:false,
	    success:function(result){
	    	$("input:radio[name='TPS_SCORE']").removeAttr('checked');
	    	$(".textAreaHealing").val("");
	    	if(result == 1){
	    		alert("평가가 완료되었습니다.");
	    	}else if(result == 0){
	    		alert("하루에 두번은 등록 하실 수 없습니다.");
	    	}
	    },
	    error: function() {
	    	alert("에러, 관리자에게 문의하세요.");
	    }
	});

}
</script>