<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<script src="/resources/api/mask/jquery.mask.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript" src="http://t1.daumcdn.net/cssjs/postcode/1513129253770/171213.js"></script>
<style>
.researchTr:first-of-type .removeBtn{display: none;}
</style>
<form:form id="expertForm" name="expertForm" commandName="expert" method="POST">
<!-- 	<input id="EI_BIRTH" name="EI_BIRTH" type="hidden"/> -->
	<div>인적사항 정보</div>
	<table id="expert_table1">
		<tbody>
			<tr>
				<th><label for="EI_NAME"><spring:message code="expert.name" /></label></th>
				<td colspan="3">
					<form:input path="EI_NAME" type="text" maxlength="10"/>
					<br/>
					<span style="font-size: 12px; color: red;"><form:errors path="EI_NAME"/></span>
				</td>
			</tr>
			<tr>
				<th><label for="EI_BIRTH"><spring:message code="expert.birth" /></label></th>
				<td>
					<form:input path="EI_BIRTH" type="text" maxlength="10" onblur="pf_birth();"/>
					<label for="solar">
						<input type="radio" id="solar" name="EI_BIRTH_TYPE" value="S" checked="checked"/>양력
					</label>
					<label for="lunar">
					<input type="radio" id="lunar" name="EI_BIRTH_TYPE" value="L"/>음력
					</label>
					<br/><span style="font-size: 12px; color: red;"><form:errors path="EI_BIRTH" /></span>
				</td>
			</tr>
			<tr>
				<th><label for="EI_EMAIL"><spring:message code="expert.email" /></label></th>
				<td colspan="3">
					<form:input path="EI_EMAIL" type="text" maxlength="50"/>
					<br/><span style="font-size: 12px;">- 신청확인, 본인확인 등을 위한 중요 사항이오니 정확히 기재하시기 바랍니다.</span>
					<br/><span style="font-size: 12px; color: red;"><form:errors path="EI_EMAIL" /></span>
				</td>
			</tr>
			<tr>
				<th><label for="EI_ADDRESS1"><spring:message code="expert.address" /></label></th>
				<td colspan="3">
					<div class="input-group input-group-sm" style="margin-bottom: 10px;">
	                    <input name="EI_POST" id="EI_POST" type="text" class="form-control input-sm" readonly="readonly">
	                    <span class="input-group-btn">
	                        <button class="btn btn-default" type="button" onclick="pf_post('EI_POST','EI_ADDRESS1')" style="margin-left: 10px;">주소 찾기</button>
	                    </span>
	                </div>
	                <div class="form-inline">
						<input name="EI_ADDRESS1" id="EI_ADDRESS1" type="text" class="form-control input-sm" style="width: 48%">
						<input name="EI_ADDRESS2" id="EI_ADDRESS2" type="text" class="form-control input-sm" placeholder="상세주소 입력" maxlength="50" >
					</div>
					<br/>
					<span style="font-size: 12px; color: red;"><form:errors path="EI_ADDRESS1"/></span>
				</td>
			</tr>
			<tr>
				<th><label for="EI_PHONE"><spring:message code="expert.tel" /></label></th>
				<td colspan="3">
					<input class="userAdd" id="EI_PHONE" name="EI_PHONE" type="text" placeholder="ex) 000-0000-0000" onkeyup="pf_autoHypenPhone(this,this.value)" maxlength="13"/>
				</td>
			</tr>
			<tr>
				<th><label for="EI_PHONE"><spring:message code="expert.phone" /></label></th>
				<td colspan="3">
					<input class="userAdd" id="EI_PHONE2" name="EI_PHONE2" type="text" placeholder="ex) 000-0000-0000" onkeyup="pf_autoHypenPhone(this,this.value)" maxlength="13"/>
				</td>
			</tr>
			<tr>
				<th><label for="EI_BELONG"><spring:message code="expert.belong" /></label></th>
				<td>
					<input type="text" name="EI_BELONG" maxlength="50"/>
					<br/>
					<span style="font-size: 12px; color: red;"><form:errors path="EI_BELONG"/></span>
					</td>
				<th><label for="EI_POSITION"><spring:message code="expert.position" /></label></th>
				<td>
					<input type="text" name="EI_POSITION" maxlength="25"/>
					<br/>
					<span style="font-size: 12px; color: red;"><form:errors path="EI_POSITION"/></span>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div>학위사항 정보</div>
	<table id="expert_table2"> 
		<tbody class="researchTr">
			 <button type="button" onclick="pf_degreeAdd();">추가</button>
				<tr>
					<th><label for="EDR_SCHOOL"><spring:message code="expert.school" /></th>
					<td><input type="text" name="EDR_SCHOOL" maxlength="10"/>  <button type="button" onclick="pf_degreeRemove(this);" class="removeBtn">삭제</button></td>
				</tr>
				<tr>
					<th><label for="EDR_MAJOR"><spring:message code="expert.major" /></th>
					<td><input type="text" name="EDR_MAJOR" maxlength="10"/></td>
				</tr>
				<tr>
					<th><label for="EDR_DEGREE"><spring:message code="expert.degree" /></th>
					<td><input type="text" name="EDR_DEGREE" maxlength="10"/></td>
				</tr>
				<tr>
					<th><label for="EDR_DETAILE"><spring:message code="expert.detaile" /></th>
					<td><input type="text" name="EDR_DETAILE" maxlength="50" /></td>
				</tr>
		</tbody>
	</table>
	
	<div>관심연구분야</div> <button type="button" onclick="pf_ResearchAdd();">추가</button>
	<table id="expert_table3">
		<tbody>
			<tr class="researchTr">
				<th><label for="ER_FIELD"><spring:message code="expert.field" /></th>
				<td><input type="text" name="ER_FIELD" maxlength="50"/> <button type="button" onclick="pf_ResearchRemove(this);" class="removeBtn">삭제</button></td>
			</tr>
		</tbody>
	</table>
</form:form>

<button type="button" onclick="pf_insert();">등록하기</button>
<button type="button" onclick="pf_close();">취소</button>

<%-- <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script> --%>
<%-- <validator:javascript formName="expert" staticJavascript="false" xhtml="true" cdata="false"/> --%>
<script>
$(function(){
	$("#EI_BIRTH").mask('0000-00-00');
});
function pf_ResearchAdd(){
	$tr = $("#expert_table3").find(".researchTr").eq(0);
	var clone = $tr.clone();
	clone.find("input").val("");
	$("#expert_table3").append(clone);
}

function pf_ResearchRemove(obj){
	$(obj).closest("tr").remove();
}
function pf_degreeRemove(obj){
	$(obj).parent().parent().parent().remove();
	
}

function pf_degreeAdd(){
	$tr = $("#expert_table2").find(".researchTr").eq(0);
	var clone = $tr.clone();
	clone.find("input").val("");
	$("#expert_table2").append(clone);
}

function pf_insert(){
	if(confirm("등록하시겠습니까?")){
		frm = document.expertForm;
	   	frm.action = "<c:url value='/jcia/expert/expertInsert.do'/>";
	    frm.submit();
	}
}

function pf_close(){
	window.open("about:blank","_self").close();
}

//휴대폰번호
function pf_autoHypenPhone(obj,str){
   str = str.replace(/[^0-9]/g, '');
   var tmp = '';
   if(str.length < 4){
       tmp += str;
   }else if(str.length < 7){
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3);
   }else if(str.length < 11){
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3, 3);
       tmp += '-';
       tmp += str.substr(6);
   }else{              
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3, 4);
       tmp += '-';
       tmp += str.substr(7);
   }
   $(obj).val(tmp)
}

//생년월일 유효성
function pf_birth(){
	var birth = $("#EI_BIRTH").val();
	var format = /^(19[3-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
    if(birth && !format.test(birth)){
     alert("생년월일이 유효하지 않습니다. \n1930-01-01부터 2099-12-31까지 입력 가능합니다.");
   	 $("#EI_BIRTH").val('');
   	 $("#EI_BIRTH").focus();
     return false;
    }
}

//이메일 유효성
// function pf_email(){
// 	var email = $("#EI_EMAIL").val();
// 	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
// 	if(email){
// 		if(exptext.test(email)==false){
// 			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
// 			alert("이메일형식이 올바르지 않습니다.");
// 			$("#EI_EMAIL").val('');
// 			$("#EI_EMAIL").focus();
// 			return false;
// 		}
// 	}
// }

//주소검색
function pf_post(zoneCode,address){
	 daum.postcode.load(function(){
	     new daum.Postcode({
	         oncomplete: function(data) {
	        	// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
               var extraRoadAddr = ''; // 도로명 조합형 주소 변수

               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraRoadAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraRoadAddr !== ''){
                   extraRoadAddr = ' (' + extraRoadAddr + ')';
               }
               // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
               if(fullRoadAddr !== ''){
                   fullRoadAddr += extraRoadAddr;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById(zoneCode).value = data.zonecode; //5자리 새우편번호 사용
               document.getElementById(address).value = fullRoadAddr;	//도로명주소 입력

	         }
	     }).open();
	 });
}

</script>