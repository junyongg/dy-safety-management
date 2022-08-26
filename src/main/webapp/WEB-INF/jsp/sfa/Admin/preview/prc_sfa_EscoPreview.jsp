<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<script src="/resources/common/js/html2canvas.js"></script>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0lax{text-align:left;vertical-align:middle}
#sa2_problem{width: 5%}
.border{
	border-bottom :2px solid black;
}
input{ border:0 solid black; width:80%;}
input:focus {outline:none;}
</style>
<form:form id="Form" name ="Form" method="post">
<div style="text-align: center;">
<div id="" style="margin-left: 400px; margin-top: 20px;">
<table class="tg" style="width: 80%; border:3px solid black;">
<thead>
  <tr>
    <c:if test="${preview.sa2_problem eq '1' }">
    <th class="tg-0lax" colspan="48" style="text-align: center; background-color: #EE0000;"></th>
	</c:if>
    <c:if test="${preview.sa2_problem eq '2' }">
    <th class="tg-0lax" colspan="48" style="text-align: center; background-color: #00FF00;"></th>
	</c:if>
	</tr>
	<tr>
    <th class="tg-0lax" colspan="48" style="text-align: center; ">
    <label>
	<input type="text" style="width:10%; text-align: center;" class="tb_gbla1 input_type_serch"  value="${preview.sa2_title }" name="sa2_title1" id="sa2_title1">점검표
	</label></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax" colspan="48" style="text-align: center;">
    <label>
	<input type="text" style="width:20%" class="tb_gbla1 input_type_serch"  value="${preview.sa2_date }"  readonly="readonly" name="sa2_date1" id="sa2_date1">
	날씨 : <input type="text" style="width:20%" class="tb_gbla1 input_type_serch"  value="${preview.sa2_wether }" readonly="readonly" name="sa2_wether1" id="sa2_wether1">
	점검자 : <input type="text" style="width:20%" class="tb_gbla1 input_type_serch"  value="${preview.sa2_adminname }" readonly="readonly" name="sa2_adminname1" id="sa2_adminname1">
	</label></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48" style = "background-color: #99CCFF" >인 버 터 발 전 현 황
    </td>

  </tr>
  <tr>
    <td class="tg-0lax" colspan="24">현재 출력 </td>
    <td class="tg-0lax" colspan="24">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_nowpower }" readonly="readonly"  name="sa2_nowpower1" id="sa2_nowpower">
	</label></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="24">금일 발전량 [KWh]</td>
    <td class="tg-0lax" colspan="24">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_todaypower }" readonly="readonly" name="sa2_todaypower1" id="sa2_todaypower">
	</label>
	</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="24">누적 발전량 <input type="text" style="width:100% "  value="${preview.sa2_accpowertype }" class="tb_gbla1 input_type_serch"  readonly="readonly" name="sa2_accpowertype1" id="sa2_accpowertype1"></td>
    <td class="tg-0lax" colspan="24">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_accpower }" readonly="readonly"  name="sa2_accpower1" id="sa2_accpower1">
	</label>
	</td>
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="24">기간 발전량 <input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_periodpowertype }" readonly="readonly" name="sa2_periodpowertype1" id="sa2_periodpowertype1"></td>
    <td class="tg-0lax" colspan="24">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  readonly="readonly" value="${preview.sa2_periodpower }" name="sa2_periodpower1" id="sa2_periodpower1">
	</label>
    </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="6" rowspan="3">AC<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전압<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[V]</td>
    <td class="tg-0lax" colspan="6">L1 - N</td>
    <td class="tg-0lax" colspan="12">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  readonly="readonly"  value="${preview.sa2_ACVL1_N }" name="sa2_ACVL1_N1" id="sa2_ACVL1_N1">
	</label>
	</td>
    <td class="tg-0lax" colspan="6" rowspan="3">AC<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전류<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[A]</td>
    <td class="tg-0lax" colspan="6">L1</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_ACAL1 }"   readonly="readonly"  name="sa2_ACAL11" id="sa2_ACAL11">
	</label>
    </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="6">L2 - N</td>
    <td class="tg-0lax" colspan="12">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_ACVL2_N }" readonly="readonly"  name="sa2_ACVL2_N1" id="sa2_ACVL2_N1">
	</label>
	</td>
    <td class="tg-0lax" colspan="6">L2</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_ACAL2 }" readonly="readonly"  name="sa2_ACAL21" id="sa2_ACAL21">
	</label>
    </td>
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="6">L3 - N</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_ACVL3_N }" readonly="readonly"  name="sa2_ACVL3_N1" id="sa2_ACVL3_N1">
	</label></td>
    <td class="tg-0lax" colspan="6">L3</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_ACAL3 }" readonly="readonly"  name="sa2_ACAL31" id="sa2_ACAL31">
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
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_palntKW }" readonly="readonly" name="sa2_palntKW1" id="sa2_palntKW1">
	</label>
	</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_palntV }" readonly="readonly" name="sa2_palntV1" id="sa2_palntV1">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_palntCT }" readonly="readonly" name="sa2_palntCT1" id="sa2_palntCT1">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch"  value="${preview.sa2_date2 }"  readonly="readonly"  name="sa2_date21" id="sa2_date21">
	</label>
    </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="24">전월 누적 송전 유효전력량[KWh]-전체</td>
    <c:if test="${preview.sa2_meternum1 eq '4' }">
	    <td class="tg-0lax" colspan="6">계량기#4</td>
		</c:if>
		<c:if test="${preview.sa2_meternum1 eq '5' }">
		<td class="tg-0lax" colspan="6">계량기#5</td>
	</c:if>    
    <td class="tg-0lax" colspan="9">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter1KWh }" readonly="readonly"  name="sa2_meter1KWh1" id="sa2_meter1KWh1">
	</label>
	</td>
<!--     <td class="tg-0lax" colspan="9">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> -->
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="24">현재 누적 송전 유효전력량[KWh]-전체</td>
  	 <c:if test="${preview.sa2_meternum2 eq '3' }">
	    <td class="tg-0lax" colspan="6">계량기#4</td>
		</c:if>
		<c:if test="${preview.sa2_meternum2 eq '7' }">
		<td class="tg-0lax" colspan="6">계량기#7</td>
		</c:if>
		<c:if test="${preview.sa2_meternum2 eq '9' }">
		<td class="tg-0lax" colspan="6">계량기#9</td>
	</c:if>
    <td class="tg-0lax" colspan="9">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter2KWh }" readonly="readonly"  name="sa2_meter2KWh1" id="sa2_meter2KWh1">
	</label></td>
<!--     <td class="tg-0lax" colspan="9">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> -->
  </tr>
  <tr>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">검침 대상</td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF"><input type="text" style="width:100%; background-color: #99CCFF " class="tb_gbla1 input_type_serch" readonly="readonly" value="${preview.changenum }" name="changenum" id="changenum"></td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF"><input type="text" style="width:100%; background-color: #99CCFF " class="tb_gbla1 input_type_serch" readonly="readonly" value="${preview.changenum2 }" name="changenum2" id="changenum2"></td>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">검침일</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="6" rowspan="2" style = "background-color: #99CCFF">검침<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주기</td>
    <td class="tg-0lax" colspan="6" style = "background-color: #99CCFF">기간</td>
    <td class="tg-0lax" colspan="12">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter1period }" readonly="readonly"  name="sa2_meter1period1" id="sa2_meter1period1">
	</label>
	</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter2period }" readonly="readonly"  name="sa2_meter2period1" id="sa2_meter2period1">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
	<label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_inverterperiod }" readonly="readonly"  name="sa2_inverterperiod1" id="sa2_inverterperiod1">
	</label>
	</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="6" style = "background-color: #99CCFF">일</td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter1date }" readonly="readonly"  name="sa2_meter1date1" id="sa2_meter1date1">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter2date }" readonly="readonly"  name="sa2_meter2date1" id="sa2_meter2date1">
	</label>
    </td>
    <td class="tg-0lax" colspan="12">
    <label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_inverterdate }" readonly="readonly"  name="sa2_inverterdate1" id="sa2_inverterdate1">
	</label>
    </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">총발전량[KWh]</td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter1allKWh }" readonly="readonly"  name="sa2_meter1allKWh1" id="sa2_meter1allKWh1">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter2allKWh }" readonly="readonly"  name="sa2_meter2allKWh1" id="sa2_meter2allKWh1">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_inverterallKWh }" readonly="readonly"  name="sa2_inverterallKWh1" id="sa2_inverterallKWh1">
	</label></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">1일평균 발전량<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[KWh/day]</td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter1dayKWh }" readonly="readonly"  name="sa2_meter1dayKWh1" id="sa2_meter1dayKWh1">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter2dayKWh }" readonly="readonly"  name="sa2_meter2dayKWh1" id="sa2_meter2dayKWh1">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_inverterdayKWh }" readonly="readonly"  name="sa2_inverterdayKWh1" id="sa2_inverterdayKWh1">
	</label></td>
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="12" style = "background-color: #99CCFF">1일평균 발전시간<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[hour/day]</td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter1dayhour }" readonly="readonly"  name="sa2_meter1dayhour1" id="sa2_meter1dayhour1">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_meter2dayhour }" readonly="readonly"  name="sa2_meter2dayhour1" id="sa2_meter2dayhour1">
	</label></td>
    <td class="tg-0lax" colspan="12"><label>
	<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_inverterdayhour }" readonly="readonly"  name="sa2_inverterdayhour1" id="sa2_inverterdayhour1">
	</label></td>
  </tr>
  <tr class="border">
    <td class="tg-0lax" colspan="48"> ※ 점검자 확인사항 </td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48">　<input type="text" style="width:100% " class="tb_gbla1 input_type_serch" value="${preview.sa2_opinion }" name="sa2_opinion1" id="sa2_opinion1"></td>
	</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="48">　&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr>
<%-- 	<c:if test="${preview.sa2_problem eq '1' }"> --%>
<!--     <td class="tg-0lax" colspan="48"><img src="/resources/img/safeAdmin/red.png">발전소 이상 있음</td> -->
<%-- 	</c:if> --%>
<%-- 	<c:if test="${preview.sa2_problem eq '2' }"> --%>
<!--     <td class="tg-0lax" colspan="48"><img src="/resources/img/safeAdmin/green.png">발전소 이상 없음</td> -->
<%-- 	</c:if> --%>
  </tr>
</tbody>
</table>
</div>
</div>
<div style="text-align: center;">
<input type="hidden" id="buttionType1" name="buttionType1" value="insert"> 
<input type="hidden" id="sa2_keyno1" name="sa2_keyno1">
<input type="hidden" id="sa2_inverternumtype1" name="sa2_inverternumtype1" value="">
<input type="hidden" id="sa_writetype1" name="sa_writetype1" value="2">
<input type="hidden" id="SU_KEYNO1" name="SU_KEYNO1" value="">
<input type="hidden" id="imgSrc1" name="imgSrc1" value="">
</div>
</form:form>
<script type="text/javascript">



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
//         	$("#sa_balkw").val(result.SU_SA_BALKW)
//         	$("#sa_solarv").val(result.SU_SA_SOLARV)
//         	$("#sa_solarkw").val(result.SU_SA_SOLARKW)
//         	$("#sa_transvolum").val(result.SU_SA_TRANSVOLUM)
//         	$("#sa_admintype").val(result.SU_SA_ADMINTYPE)
//         	$("#sa_admincount").val(result.SU_SA_ADMINCOUNT)
        	
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







</script>