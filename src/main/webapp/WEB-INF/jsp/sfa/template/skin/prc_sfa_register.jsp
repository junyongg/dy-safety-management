<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<script src="/resources/common/js/html2canvas.js"></script>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:20px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:20px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0lax{text-align:left;vertical-align:middle}
#sa2_problem{width: 5%}
.border{
	border-bottom :2px solid black;
}
input[type="text"] { border:0 solid black; width:80%; height: 30px;  /* 높이 초기화 */line-height: normal;  /* line-height 초기화 */font-size: 20px;}

input:focus {outline:none;}
select{ height: 30px; }

</style>
<form:form id="Form" name ="Form" method="post">
<div style="text-align: center;" id="esco">
<div>	
	<select class="form-control input-sm" name="su_keyno" id="su_keyno" onchange="changesulbi(this.value)">
	       		<option>선택하세요</option>
	       		<c:forEach items="${safeuserlist}" var="b">
				<option value="${b.SU_KEYNO}">${b.SU_SA_SULBI }</option>
				</c:forEach>		                
	</select>
	<select class="form-control input-sm" name="Year" id="Year"></select>
	<select class="form-control input-sm" name="Month" id="Month" onchange="datanumselect()"></select>
	<select class="form-control input-sm" name="selectgroup" id="selectgroup"></select>
	<button type="button" onclick="view()">조회</button>
</div>
<div style="margin-left: 400px; margin-top: 20px;">
<table class="tg" style="width: 80%; border:3px solid black;" >
<thead>
  <tr data-html2canvas-ignore="true">
  	<th class="tg-0lax" colspan="48" style="text-align: center;"><input type="checkbox" id="allcheck"></th>
  </tr>
  <tr>
    <th class="tg-0lax" colspan="48" style="text-align: center;">
    <label>
		<input type="text" style="width:10%; text-align: center;" class="tb_gbla1 input_type_serch"  title=""  name="sa2_title" id="sa2_title">점검표
	</label></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax" colspan="48" style="text-align: center;">
    <label>
	<input type="text" style="width:20%" class="tb_gbla1 input_type_serch"  value="${now }"  name="sa2_date" id="sa2_date">
	날씨 :<select id="sa2_wether" name="sa2_wether" style="width:10%">
  		<option value="맑음">맑음</option>
    	<option value="흐림">흐림</option>
    	<option value="비">비</option>
    	<option value="눈">눈</option>
    </select>
	점검자 : <select id="sa2_adminname" name="sa2_adminname" style="width:10%">
  		<option value="이민환">이민환</option>
    	<option value="김용인">김용인</option>	
    </select>
	</label></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="38" style = "background-color: #99CCFF" >
    	인 버 터 발 전 현 황
    </td>
	<td class="tg-0lax" colspan="10">
	<label id="sa2_label0"></label>
	</td>
  </tr>
  <tbody class="esco">
  <tr data-html2canvas-ignore="true">
  	<td colspan="48"><input type="checkbox" class="check" checked="checked" onclick="checkboxEvent(this)"></td> 
  </tr>
  <tr>
    <td class="tg-0lax" colspan="24">현재 출력 </td>
    <td class="tg-0lax" colspan="14">
    <label >
	<input type="text" style="width:40%" class="tb_gbla1 input_type_serch" value=""   name="sa2_nowpower" id="sa2_nowpower">
	</label>
	</td>	
	<td class="tg-0lax" colspan="10">
	<label id="sa2_label1"></label>		
	</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="24">금일 발전량 [KWh]</td>
    <td class="tg-0lax" colspan="14">
	<label>
	<input type="text" style="width:40% " class="tb_gbla1 input_type_serch"  value=""  name="sa2_todaypower" id="sa2_todaypower">
	</label>
	</td>
	<td class="tg-0lax" colspan="10">
	<label id="sa2_label2"></label>		
	</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="24">누적 발전량 <select id="sa2_accpowertype" name="sa2_accpowertype">
    <option value="KWh">KWh</option>
    <option value="MWh">MWh</option>
    </select></td>
    <td class="tg-0lax" colspan="14">
	<label>
	<input type="text" style="width:40% " class="tb_gbla1 input_type_serch"  value=""   name="sa2_accpower" id="sa2_accpower">
	</label>
	</td>
	<td class="tg-0lax" colspan="10">
	<label id="sa2_label3"></label>		
	</td>
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="24">기간 발전량<select id="sa2_periodpowertype"  name="sa2_periodpowertype">
    <option value="KWh">KWh</option>
    <option value="MWh">MWh</option>
    </select></td>
    <td class="tg-0lax" colspan="14">
    <label>
	<input type="text" style="width:40% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_periodpower" id="sa2_periodpower">
	</label>
    </td>
    <td class="tg-0lax" colspan="10">
	<label id="sa2_label4"></label>		
	</td>
  </tr>
  </tbody>
  <tbody class ="esco" data-html2canvas-ignore="true">
   <tr data-html2canvas-ignore="true">
  	<td colspan="48"><input type="checkbox" class="check" onclick="checkboxEvent(this)"></td> 
  </tr>
  <tr>
    <td class="tg-0lax" colspan="6" rowspan="3"> AC전압&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[V]</td>
    <td class="tg-0lax" colspan="6">L1 - N</td>
    <td class="tg-0lax" colspan="12">
	<label id="sa2_label5">
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_ACVL1_N" id="sa2_ACVL1_N">
	</label>
	</td>
    <td class="tg-0lax" colspan="6" rowspan="3">AC전류&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[A]</td>
    <td class="tg-0lax" colspan="6">L1</td>
    <td class="tg-0lax" colspan="12">
    <label id="sa2_label6">
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_ACAL1" id="sa2_ACAL1">
	</label>
    </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="6">L2 - N</td>
    <td class="tg-0lax" colspan="12">
	<label id="sa2_label7">
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_ACVL2_N" id="sa2_ACVL2_N">
	</label>
	</td>
    <td class="tg-0lax" colspan="6">L2</td>
    <td class="tg-0lax" colspan="12">
    <label id="sa2_label8">
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_ACAL2" id="sa2_ACAL2">
	</label>
    </td>
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="6">L3 - N</td>
    <td class="tg-0lax" colspan="12">
    <label id="sa2_label9">
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_ACVL3_N" id="sa2_ACVL3_N">
	</label></td>
    <td class="tg-0lax" colspan="6">L3</td>
    <td class="tg-0lax" colspan="12">
    <label id="sa2_label10">
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_ACAL3" id="sa2_ACAL3">
	</label></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">발전소 용량 [KW]</td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">발전전압 [V]</td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">CT비 [배]</td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">검침일</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="12">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="sa2_palntKW" id="sa2_palntKW">
	</label>
	</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="sa2_palntV" id="sa2_palntV">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="sa2_palntCT" id="sa2_palntCT">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${now}"  name="sa2_date2" id="sa2_date2">
	</label>
    </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="24">전월 누적 송전 유효전력량[KWh]-전체</td>
    <td class="tg-0lax" colspan="6">
    <select id="sa2_meternum1" name="sa2_meternum1" onchange="changenumber(this.value)">
    <option value="">계량기선택</option>
    <option value="4">계량기#4</option>
    <option value="5">계량기#5</option>
    </select>
    </td>
    <td class="tg-0lax" colspan="9">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter1KWh" id="sa2_meter1KWh">
	</label>
	</td>
<!--     <td class="tg-0lax" colspan="9">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> -->
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="24">현재 누적 송전 유효전력량[KWh]-전체</td>
    <td class="tg-0lax" colspan="6">
	<select id="sa2_meternum2" name="sa2_meternum2">
    </select>
	</td>
    <td class="tg-0lax" colspan="9">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter2KWh" id="sa2_meter2KWh">
	</label></td>
<!--     <td class="tg-0lax" colspan="9">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> -->
  </tr>
  <tr>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">검침 대상</td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF"><input type="text" style="width:100%; background-color: #99CCFF " class="tb_gbla1 input_type_serch" readonly="readonly" value="" name="changenum" id="changenum"></td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF"><input type="text" style="width:100%; background-color: #99CCFF " class="tb_gbla1 input_type_serch" readonly="readonly" value="" name="changenum2" id="changenum2"></td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">검침일</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="6" rowspan="2" style = "background-color: #99CCFF">검침<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주기</td>
    <td class="tg-0lax" colspan="6" style = "background-color: #99CCFF">기간</td>
    <td class="tg-0lax" colspan="12">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter1period" id="sa2_meter1period">
	</label>
	</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter2period" id="sa2_meter2period">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_inverterperiod" id="sa2_inverterperiod">
	</label>
	</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="6" style = "background-color: #99CCFF">일</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter1date" id="sa2_meter1date">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter2date" id="sa2_meter2date">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_inverterdate" id="sa2_inverterdate">
	</label>
    </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">총발전량[KWh]</td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter1allKWh" id="sa2_meter1allKWh">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter2allKWh" id="sa2_meter2allKWh">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_inverterallKWh" id="sa2_inverterallKWh">
	</label></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">1일평균 발전량<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[KWh/day]</td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter1dayKWh" id="sa2_meter1dayKWh">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter2dayKWh" id="sa2_meter2dayKWh">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_inverterdayKWh" id="sa2_inverterdayKWh">
	</label></td>
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">1일평균 발전시간<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[hour/day]</td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter1dayhour" id="sa2_meter1dayhour">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_meter2dayhour" id="sa2_meter2dayhour">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  name="sa2_inverterdayhour" id="sa2_inverterdayhour">
	</label></td>
  </tr>
  </tbody>
  <tbody class ="esco" >
  <tr class="border" data-html2canvas-ignore="true">
  	<td colspan="48"><input type="checkbox" class="check" checked="checked"  onclick="checkboxEvent(this)"></td> 
  </tr>
  <tr class="border"> 
    <td class="tg-0lax" colspan="48">※ 점검자 확인사항 
     <input type="file" id="inputImage">
  <button type="button" id="sendButton">등록</button>
   </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48">
	
	<img src="" class="uploadImage" id ="sa2_image">
	</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48">　<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  name="sa2_opinion" id="sa2_opinion"></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  </tbody>
  <tr>
    <td class="tg-0lax" colspan="48">대양에스코 ㈜      TEL  061)332-8086      FAX &nbsp;&nbsp;&nbsp;070)4009-4586</td>
  </tr>
</tbody>
</table>
</div>
</div>
<div style="border:0 solid black;">
<div style="margin-top: 20px; margin-left: 400px;">
<table style="border: 2px solid black;">
<tr>
<td style="border-right: 2px solid black;">발전소 이상유무 선택</td>
<td style="width:250px; ">
<label>
<span>이상있음</span> 
<input type = "radio" style="width : 10%;" margin-top: 5px;" name = "sa2_problem" id="sa2_problem" value = "1">
</label>
<label>
<span>이상없음</span> 
<input type = "radio" style="width : 10%;" margin-top: 5px;" name = "sa2_problem" id="sa2_problem" value = "2">
</label></td>
</tr>
</table>
</div>
<div style="text-align: center;">
<input type="hidden" id="buttionType" name="buttionType" value="insert"> 
<input type="hidden" id="sa2_keyno" name="sa2_keyno">
<input type="hidden" id="sa2_inverternumtype" name="sa2_inverternumtype" value="">
<input type="hidden" id="sa_writetype" name="sa_writetype" value="2">
<input type="hidden" id="SU_KEYNO" name="SU_KEYNO" value="">
<input type="hidden" id="imgSrc" name="imgSrc" value="">
<button style="width: 150px; margin-top: 20px;" type="button" onclick="SendAlim()"> 알림 전송 후 저장 </button>
<button style="width: 100px; margin-top: 20px;" type="button" onclick="loadInfo()"> 저장 </button>
<!-- <button style="width: 100px; margin-top: 20px;" type="button" onclick="clearinput()"> 초기화 </button> -->
</div>
</div>
<div id = "prepaper">
</div>
</form:form>
<script type="text/javascript">

$(function() {
	///data-html2canvas-ignore="true" 
	$(document).on('click','#allcheck',function(){
		if($('#allcheck').is(':checked')){
			$('.check').prop('checked',true);
			$('.esco').removeAttr('data-html2canvas-ignore');
		}else{     
			$('.check').prop('checked',false); 
			$('.esco').attr('data-html2canvas-ignore','true')
		} 
	});
	
	
	$(document).on('click','.check',function(){
	    if($('input[class=check]:checked').length==$('.check').length){  
			 $('#allcheck').prop('checked',true);    
		}else{       
			 $('#allcheck').prop('checked',false);     
		}
	});
	
	
	yearselect();
	monselect();
	
	//사진등록
  	  document.querySelector("#sendButton").addEventListener('click',()=>{

      let selectFile = document.querySelector("#inputImage").files[0];

      const file = URL.createObjectURL(selectFile);

      document.querySelector(".uploadImage").src = file;
      

    })
    
	/** 계량기 번호 변경 */
		var t = document.getElementById('sa2_meternum2');
		 
		t.addEventListener('change', function(event){
		 
		changetext(event.target.value);
      });
 		
//     window.setTimeout('loadInfo()',6000);

});

function checkboxEvent(obj){
	if($(obj).is(':checked')){
		$(obj).closest("tbody").removeAttr('data-html2canvas-ignore')
	}else{
		$(obj).closest("tbody").attr('data-html2canvas-ignore','true')
	}
}


function SendAlim(){
	
	var array = new Array(); 
	var target = $("#esco");
    var radioVal = $('input[name="sa2_problem"]:checked').val();
   	array.push(radioVal);
   	
   	if(!validationCheck()) return false
		if(array[0] == "1" || array[0] == "2"){
			if(confirm("저장 후 즉시 알림 전송하시겠습니까?")){
				if (target != null && target.length > 0) {
					
					var t = target[0];

					html2canvas(t).then(function(canvas) {
						var myImg = canvas.toDataURL("image/png");
						myImg = myImg.replace("data:image/png;base64,", "");
						
						
						$("#imgSrc").val(myImg);
 						$.ajax({
 							type : "POST",
 							data : $("#Form").serialize(),
 							dataType : "text",
 							url : "/sfa/Admin/sendAilmaAjax.do?${_csrf.parameterName}=${_csrf.token}",
 							success : function(data) {
 								alert(data);
 							},
 							error : function(a, b, c) {
 								alert("error");
 							}
 						});
					});
				}
			}else{
				
		 	}		
		}else{
			alert("발전소 이상유무를 선택해주세요");
		}
		
	
}
	
function loadInfo(){
	
	var array = new Array(); 
    var radioVal = $('input[name="sa2_problem"]:checked').val();
   	array.push(radioVal);
   	
   	if(!validationCheck()) return false
		if(array[0] == "1" || array[0] == "2"){
			if(confirm("저장하시겠습니까?")){
				s
				 $.ajax({
			        url: '/sfa/safe/safepaper2Insert.do?${_csrf.parameterName}=${_csrf.token}',
			        type: 'POST',
			        data: $("#Form").serialize(),
			        async: false,  
			        success: function(result) {
			        	location.reload();
			        	alert(result);
			        },
			        error: function(){
			        	alert("저장 에러");
			        }
				}); 
		 	}else{
		 		
		 	}		
		}else{
			alert("발전소 이상유무를 선택해주세요");
		}
		
	
}

//연월 셋팅
function yearselect(){
	
	var dt = new Date();
	var comyear = dt.getFullYear();
	
	years = "";
		
// 	for(var i = (comyear-5); i <= (comyear); i++){
		years += $("#Year").append("<option value="+comyear+">"+comyear+"년"+"</option>");
// 	}
}

function monselect(){
	
	var dt = new Date();
	var commonth = dt.getMonth();
	
	month = "";
	for(var i = 1; i <= 12; i++){
		month += $("#Month").append("<option value="+i+">"+i+"월"+"</option>");
	}
}


function datanumselect(){
	
	var a = $("#su_keyno").val();
	var b = $("#Year").val();
	var c = $("#Month").val();
	
	$.ajax({
        url: '/sfa/sfaAdmin/previewAjax.do?${_csrf.parameterName}=${_csrf.token}',
        type: 'POST',
        data: $("#Form").serialize(),
        async: false,  
        success: function(data) {
        	
        	console.log(data);
        	if(data == null || data == ""){
        		alert("해당 연월에 작성한 양식이 없습니다");
        	}else{
				var userlist = [];
				 
				for(var i=0; i<data.length; i++){
					userlist[i] = data[i].sa2_keyno;
				}
	
				for(var i=0; i<data.length; i++){
					$("#selectgroup").append("<option value = "+data[i].sa2_keyno+">"+data[i].datenum+"</option>"); // <option>값 넣어줌
			 	}  		
	        	
	//         	if(data == "null"){        		
	//         		alert("해당 연월에 작성한 양식이 없습니다.")	
	//         	}else{
	// 	        	var left = Math.ceil((window.screen.width - 1000)/2);
	// 	        	var top = Math.ceil((window.screen.height - 820)/2);
	// 	        	var popOpen	= window.open("/sfa/sfaAdmin/preview.do?su_keyno="+a+"&Year="+b+"&Month="+c+"&type="+d, "Taxpopup","width=1200px,height=900px,top="+top+",left="+left+",status=0,toolbar=0,menubar=0,location=false,scrollbars=yes");
	// 	        	popOpen.focus();
	//         	}	
        	}
        	
        },
        error: function(){
        	alert("저장 에러");
        }
	}); 
	
}

//이전 양식 조회
function view(){
	
	$.ajax({
        url: '/sfa/sfaAdmin/previewplaceholder.do?${_csrf.parameterName}=${_csrf.token}',
        type: 'POST',
        data: $("#Form").serialize(),
        async: false,  
        success: function(data) {
        	
        	var a = data.sa2_date;

        	var result = a.substring(6,13);
        	
        	var result2 = result.replace(" ","")
        	
        	
        	$("#sa2_label0").html("<input type='text' style='width:100%' class='tb_gbla1 input_type_serch' value="+result2+" name='' id=''>")
        	$("#sa2_label1").html("<input type='text' style='width:40%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_nowpower+" name='sa2_nowpower3' id='sa2_nowpower3'>")
        	$("#sa2_label2").html("<input type='text' style='width:40%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_todaypower+" name='sa2_todaypower3' id='sa2_todaypower3'>")
        	$("#sa2_label3").html("<input type='text' style='width:40%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_accpower+" name='sa2_accpower3' id='sa2_accpower3'>")
        	$("#sa2_label4").html("<input type='text' style='width:40%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_periodpower+" name='sa2_periodpower3' id='sa2_periodpower3'>")
        	$("#sa2_label5").html("<input type='text' style='width:100%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_ACVL1_N+" name='sa2_ACVL1_N' id='sa2_ACVL1_N'>")
        	$("#sa2_label6").html("<input type='text' style='width:100%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_ACAL1+" name='sa2_ACAL1' id='sa2_ACAL1'>")
        	$("#sa2_label7").html("<input type='text' style='width:100%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_ACVL2_N+" name='sa2_ACVL2_N' id='sa2_ACVL2_N'>")
        	$("#sa2_label8").html("<input type='text' style='width:100%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_ACAL2+" name='sa2_ACAL2' id='sa2_ACAL2'>")
        	$("#sa2_label9").html("<input type='text' style='width:100%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_ACVL3_N+" name='sa2_ACVL3_N' id='sa2_ACVL3_N'>")
        	$("#sa2_label10").html("<input type='text' style='width:100%' class='tb_gbla1 input_type_serch' value='' placeholder ="+data.sa2_ACAL3+" name='sa2_ACAL3' id='sa2_ACAL3'>")
        	
		
        },
        error: function(){
        	alert("저장 에러");
        }
	}); 
	
// 	$.ajax({
//         url: '/sfa/sfaAdmin/prepaperview.do?${_csrf.parameterName}=${_csrf.token}',
//         type: 'POST',
//         data: $("#Form").serialize(),
//         async: false,  
//         success: function(data) {
        	
//         	$("#prepaper").html(data)
        	
//         },
//         error: function(){
//         	alert("저장 에러");
//         }
// 	}); 
	
}

function changesulbi(keyno) {
	
	$("#SU_KEYNO").val(keyno);
	
	$.ajax({
        url: '/sfa/safe/safeuserselect.do?${_csrf.parameterName}=${_csrf.token}',
        type: 'POST',
        data: {
			SU_KEYNO : keyno
		},
        async: false,  
        success: function(result) {

        	
        	$("#sa2_title").val(result.SU_SA_SULBI)
        	$("#sa2_palntKW").val(result.SU_SA_VOLUM)
        	$("#sa2_palntV").val(result.SU_SA_VOLT)
        	$("#sa2_palntCT").val(result.SU_SA_CT)
        	$("#sa2_inverternumtype").val(result.SU_SA_INVERTERNUM)
        	$("#sa2_nowpower").val("164 KW")
        	$("#sa2_todaypower").val("2607 KW")
        	$("#sa2_accpower").val("665,260 KW")
        	
//         	var date = result.CONN_DATE;
//         	console.log(date);
//         	var month = result.Conn_date.substr(5,7);
//         	 $("#Year").html("<option value'"result.Conn_date"'>"+i+"년"+"</option>");
        },
        error: function(){
        	alert("저장 에러");
        }
	}); 
}

function validationCheck(){
	
	if($("#sa2_title").val() == ''){
		alert("발전소를 선택해주세요");
		return false
	}
	
	return true
}


function changenumber(value){
	
	if(value == 4){
		
		$("#sa2_meternum2").html("<select id='sa2_meternum2' name='sa2_meternum2'><option value='7'>계량기#7</option>")
		$("#changenum").val("계량기#4")
		$("#changenum2").val("계량기#7")
		
	}else if(value == 5){
		
		$("#sa2_meternum2").html("<select id='sa2_meternum2' name='sa2_meternum2'><option value='3'>계량기#3</option><option value='9'>계량기#9</option></select>")
		$("#changenum").val("계량기#5")
		$("#changenum2").val("계량기#3")
		
		
	}
	
}



function changetext(value){
	
	
	if(value == 3){

		$("#changenum2").val("계량기#3")
		
	}else if(value == 9){

		$("#changenum2").val("계량기#9")
		
	}
	
}
// function image(){
	
// 	$.ajax({
//         url: '/imageInsert.do',
//         type: 'POST',
//         data: $("#Form").serialize(),
//         async: false,  
//         processData: false,
//         contentType: false,
//         success: function(result) {

//         	console.log(result);
//         },
//         error: function(e){
//         	console.log(e);
//         	alert("저장 에러");
//         }
// 	}); 
	
// }






</script>