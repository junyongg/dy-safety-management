<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<input type="hidden" id="emailAuthKey" name="emailAuthKey">
<input type="hidden" id="Authorize" name="Authorize" value="N">



<form:form id="form" action="/hire/userInsert.do" method="post">
<input type="hidden" id="TH_BNKEYNO" name="TH_BNKEYNO" value="${hireUser.TH_BNKEYNO }">
<input type="hidden" id="TH_CLASSTYPE" name="TH_CLASSTYPE" value="${hireUser.TH_CLASSTYPE }">
<section id="sub-content">
	<div class="inner1200">
	
			<div class="sub-title-box">
                <h2>지원서 작성</h2>
                <ul class="list_ul">
                    <li class="home"><i class="xi-home"></i></li>
                    <li>열린광장</li>
                    <li>채용공고</li>
                    <li>지원서 작성</li>
				</ul>

            </div>
            <div id="sub-con-start">

                <!-- 지원서 작성 탑 부분 탭 -->
                <div class="employ_tab_box">
					<ul class="employ_tab_ul">
						<li class="active">
							<span class="icon n01"></span>
							<span class="txt">약관동의 및 기본정보입력</span>
						</li>
						<li>
							<span class="icon n02"></span>
							<span class="txt">지원서&amp;자기소개서 입력</span>
						</li>
						<li>
							<span class="icon n03"></span>
							<span class="txt">최종제출</span>
						</li>
					</ul>
				</div>
                <!-- // 지원서 작성 탑 부분 탭 -->

				<!-- 약관동의 -->
				<div class="terms_title_box">
					<h2>${Title }</h2>
				</div>

				<div class="terms_accordion_box acco_privacy">
					<div class="one agree active">
						<div class="sbj_b">
							<div class="txt">개인정보처리방침</div>
							<div class="icon"><i class="xi-angle-down"></i></div>
						</div>
						<div class="content_b" style="display: block;">
							본 홈페이지를 통해 제출하는 지원서는 귀하께서 지원서를 제출하는 회사(이하 채용회사)가 직접 접수하고 관리하며, 향후 지원서 관리책임은 채용회사에 있습니다.<br>
							지원자는 아래 개인정보 제공 등에 관해 동의하지 않을 권리가 있습니다. <br>
							다만, 지원서를 통해 제공받은 정보는 채용회사의 채용 및 선발에 필수적인 항목으로 해당 정보를 제공받지 못할 경우 회사는 공정한 선발전형을 진행할 수 없습니다.<br>
							따라서 아래 개인정보 제공에 대해 동의하지 않는 경우 채용 및 선발전형에 지원이 제한될 수 있습니다. <br>
							지원자의 동의 거부 권리 및 동의 거부에 따른 불이익은 아래에 제시되는 모든 동의사항에 해당됩니다.
						</div>
					</div>
					<div class="one">
						<div class="sbj_b">
							<div class="txt"><input type="checkbox" class="check_pri one" id="priv_01"><label for="priv_01"><span></span> 개인정보 수집 및 이용에 관한 동의</label></div>
							<div class="icon one"><i class="xi-angle-down"></i></div>
						</div>
						<div class="content_b" style="display: none;">
							본인은 (재)전라남도문화재단이 본인을 채용함에 있어 인사 검증 등 채용에 수반되는 정보의 수집 및 이용의 필요성을 이해하고 있으며, <br>
							이를 위해 「개인정보보호법」 등에 의해 보호되고 있는 본인에 관한 각종 정보자료를 동법 제15조(개인정보의 수집, 이용), 제17조(개인정보 제공),<br> 
							제18조(개인정보 이용·제공 제한)의 규정 등에 따라 담당부서에 제공하는데 동의합니다.
							
							<br>
			                <span>
			                    □ 개인정보 수집․이용의 범위<br>
			                    &nbsp;&nbsp;&nbsp;－ 개인식별정보 : 성명(한글, 한문, 영문), 주민등록번호<br>
			                    &nbsp;&nbsp;&nbsp;－ 연락정보 : 현주소, 자택전화번호, 휴대전화번호, e-mail<br>
			                    &nbsp;&nbsp;&nbsp;－ 교육‧훈련‧경력사항 : 소속조직명, 근무기간, 담당업무<br>
			                    &nbsp;&nbsp;&nbsp;－ 기타사항 : 병역사항, 자격사항(자격명, 취득일자, 발급기관), 어학사항(어학시험명, 점수, 취득일), 우대사항(발급일자, 발급기관)<br>
			                    □ 개인정보의 수집․이용 목적 : 채용 및 채용관리, 지원자 평가, 지원자 사후관리<br>
			                    □ 개인(신용)정보의 보유․이용 기간 : 제출 5년 또는 삭제 신청시 까지
			                </span>
							 <br>※ 개인정보 제공 동의를 거부할 권리가 있으며, 이 경우 동의 거부에 따른 불이익(채용전형 중지 등)이 발생할 수 있습니다.
						</div>
					</div>
					<div class="one">
						<div class="sbj_b">
							<div class="txt"><input type="checkbox" class="check_pri one" id="priv_02"><label for="priv_02"><span></span> 개인정보의 위탁 제공에 대한 동의</label></div>
							<div class="icon one"><i class="xi-angle-down"></i></div>
						</div>
						<div class="content_b" style="display: none;">
							본 홈페이지를 통해 제출하는 지원서는 귀하께서 지원서를 제출하는 회사(이하 채용회사)가 직접 접수하고 관리하며, 향후 지원서 관리책임은 채용회사에 있습니다.<br>
							지원자는 아래 개인정보 제공 등에 관해 동의하지 않을 권리가 있습니다. <br>
							다만, 지원서를 통해 제공받은 정보는 채용회사의 채용 및 선발에 필수적인 항목으로 해당 정보를 제공받지 못할 경우 회사는 공정한 선발전형을 진행할 수 없습니다.<br>
							따라서 아래 개인정보 제공에 대해 동의하지 않는 경우 채용 및 선발전형에 지원이 제한될 수 있습니다. <br>
							지원자의 동의 거부 권리 및 동의 거부에 따른 불이익은 아래에 제시되는 모든 동의사항에 해당됩니다.
						</div>
					</div>
				</div>

				<div class="term_checkAll">
					<input type="checkbox" class="check_pri" id="priv_All"><label for="priv_All"><span></span> 전체동의</label>
				</div>

				<script>
					$('.acco_privacy .one.active .content_b').slideDown();

					$('.acco_privacy .one').on('click', function () {
						$(this).toggleClass('active');
						$(this).find('.content_b').slideToggle();

						if ($(this).hasClass('active')) {
							$(this).find('.check_pri').prop('checked', true);
						} else {
							$(this).find('.check_pri').prop('checked', false);
						}
					})

					// 전체동의
					$('#priv_All').on('click',function(){
						var chk = $(this).is(':checked');
						if(chk) $('.sbj_b .check_pri').prop('checked',true);
						else $('.sbj_b .check_pri').prop('checked', false);
					})
				</script>


				<div class="gab40"></div>

				<table class="tbl_join_list verti">
					<caption>응시구분</caption>
					<colgroup>
						<col style="width: 15%;">
						<col style="width: 85%;">
					</colgroup>
					<tbody>
						<tr>
							<th><label>응시구분</label></th>
							<td class="txt">
								<c:forEach items="${BdDataList }" var="Bd">
									<c:if test="${Bd.BD_BL_KEYNO eq 'BL_0000000145' }">
										<c:choose>
											<c:when test="${Bd.BD_DATA eq '기간제'}">
												<input type="hidden" name="TH_TYPE" value="G">
											</c:when>
											<c:otherwise>
												<input type="hidden" name="TH_TYPE" value="U">
											</c:otherwise>
										</c:choose>
										<c:out value="${Bd.BD_DATA }"/>
									</c:if>
								</c:forEach>
								
								<!-- <input type="radio" class="check_circle" id="priv_cate1" checked="checked" name="TH_TYPE" value="U"><label for="priv_cate1"><span></span> 운영직</label> -->
								<!-- <span class="gab-h-20"></span> -->
								<!-- <input type="radio" class="check_circle" id="priv_cate2" checked="checked" name="TH_TYPE" value="G"><label for="priv_cate2"><span></span> 기간제</label> -->
							</td>
						</tr>
						<tr>
							<th><label for="priv_name1">지원자 성명</label></th>
							<td class="txt">
								<input type="text" class="txt_pri w60" id="TH_USER" name="TH_USER">
								<p class="bo_txt">※ 공백없이 입력하세요</p>
							</td>
						</tr>
						<tr>
							<th><label for="priv_phone1">휴대전화번호</label></th>
							<td class="txt">
								<input type="text" class="txt_pri w60" id="TH_PHONE" name="TH_PHONE" onkeyup="pf_autoHypenPhone(this,this.value)" placeholder="000-0000-0000"> 
								<p class="bo_txt">※ 결과 알림에 사용되오니, 반드시 연결가능한 번호를 입력하세요. (본인 미보유시, 가족 핸드폰 입력)</p>
							</td>
						</tr>
						<tr>
							<th><label for="priv_mail1">이메일</label></th>
							<td class="txt">
								<input type="text" class="txt_pri w60 email" id="TH_EMAIL" name="TH_EMAIL"> <button type="button" class="btn_pri purple email_next" title="이메일 인증" onclick="Email();">이메일 인증</button>
								<p class="bo_txt">※ 비밀번호 찾기 및 결과 알림에 사용되오니, 반드시 자주 사용하는 메일 주소를 입력하세요.</p>
							</td>
						</tr>
						<tr>
							<th><label for="priv_pwd1">비밀번호</label></th>
							<td class="txt">
								<input type="password" class="txt_pri w60" id="TH_PASSWORD" name="TH_PASSWORD" placeholder="비밀번호를 입력해주세요.">
								<input type="password" class="txt_pri w60" id="TH_PASSWORD2" name="TH_PASSWORD2" placeholder="비밀번호 확인을 위해 다시 한번 입력해주세요.">
								<p class="bo_txt">※ 8~9자 영문 대·소문자/특수문자/숫자 중 3종류, 혹은 10자 이상 영문/숫자/특수문자 중 2종류를 사용하세요.</p>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="gab50"></div>

				<div class="textC">
					<button type="button" class="btn_support purple" title="지원서 작성" onclick="Application();"><i class="xi-pen"></i> 지원서 작성</button>
				</div>
				
				<!-- // 약관동의 -->


				<!-- 이메일 본인인증 팝업 -->
				<div class="popUp_join email_pop">
					<div class="title_box">
						<h2>이메일 본인인증</h2>
					</div>
					
					<div class="email_con">
						<p class="bol">이메일로 인증번호가 발송완료 되었습니다.</p>
						<p class="nor">
							받는 메일서버의 상황에 따라 최대 5분정도 소요됩니다.<br>
							받으신 인증번호를 하단에 입력하세요.
						</p>

						<input type="text" class="txt_pri w100" id="emailAuthKey_check" name="emailAuthKey_check">
					</div>

					<div class="btn_box">
						<button type="button" class="btn_support purple" title="확인" onclick="KeyCheck();">확인</button>
						<button type="button" class="btn_support gray" title="취소" onclick="$('.email_pop, .email_pop_b').hide();">취소</button>
					</div>
				</div>
				<div class="popUp_join_black email_pop_b"></div>
				<!-- // 이메일 본인인증 팝업 -->


				<!-- 정보확인 팝업 -->
				<div class="popUp_join info_pop">
					<div class="title_box">
						<h2>정보확인</h2>
					</div>
				
					<div class="email_con">
						<p class="bol">입력하신 기초정보를 확인하세요!</p>
						<p class="nor">
							이름, 생년월일 등과 같은 지원자의 기초정보는 한 번 입력시 수정이 불가능 합니다.<br>
							아래의 정보를 꼼꼼히 확인하신 후, 지원서를 작성하세요.
						</p>

						<div class="person_info_box">
							<ul>
								<li>
									<span class="sbj">지 원 자 성명</span>
									<span class="txt user"></span>
								</li>
								<li>
									<span class="sbj">휴대전화 번호</span>
									<span class="txt phone"></span>
								</li>
								<li>
									<span class="sbj">이 메 일</span>
									<span class="txt email"></span>
								</li>
							</ul>
						</div>
					</div>
						
					<div class="btn_box">
						<div class="btn_txt">
							지원서 작성 페이지로 이동하시겠습니까?<br>
							하단의 지원서 작성버튼 클릭시, 기초정보 수정이 불가능합니다.
						</div>
						<button type="submit" class="btn_support purple" title="확인">확인</button>
						<button type="button" class="btn_support gray" title="취소" onclick="$('.info_pop, .info_pop_b').hide();">취소</button>
					</div>
				</div>
				<div class="popUp_join_black info_pop_b"></div>
				<!-- // 정보확인 팝업 -->

            </div>
            
            </div>
</section>
</form:form>

<script>

//화면 호출시 가장 먼저 호출되는 부분 
$(document).ready(function() {
	
	
	document.addEventListener('keydown', function(event) {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
	}, true);
	
	
	$('.acco_privacy .one .txt').click(function(e){
        e.stopPropagation();                  
     })
	
	 $("#form").validate({

        onfocusout : function (element) {

            $(element).valid();

        },
        
        rules : {
        	
        	TH_PASSWORD : {required:true, minlength:8, maxlength:16, passwordChk:true},

        	TH_PASSWORD2 : {required:true, equalTo:"#TH_PASSWORD"},

        	TH_USER : {required:true, minlength:2, maxlength:20},

        	TH_EMAIL : {required:true, minlength:5, maxlength:50, email:true},
        	
        	TH_PHONE : {required:true, phone:true}
        	
        },

        messages : {

        	TH_PASSWORD : {required:"필수정보를 적어주세요.", minlength:jQuery.validator.format("최소 {0}자 이상으로 설정 가능합니다."), maxlength:jQuery.validator.format("최대 {0}자 이하로 설정 가능합니다."), passwordChk:"비밀번호 형식이 잘못되었습니다."},

        	TH_PASSWORD2 : {required:"필수정보를 적어주세요.", equalTo:"입력한 비밀번호가 서로 일치하지 않습니다."},

        	TH_USER : { minlength:jQuery.validator.format("최소 {0}자 이상으로 설정 가능합니다."), maxlength:jQuery.validator.format("최대 {0}자 이하로 설정 가능합니다.")},
        
        	TH_EMAIL : {required:"필수정보를 적어주세요.", minlength:jQuery.validator.format("최소 {0}자 이상으로 설정 가능합니다."), maxlength:jQuery.validator.format("최대 {0}자 이하로 설정 가능합니다."), email:"이메일 형식이 잘못되었습니다."},
        	
        	TH_PHONE : {required:"필수정보를 적어주세요.", phone:"전화번호 형식이 잘못되었습니다."}
        	
        }, 

        invalidHandler : function(form, validator) {

            var errors = validator.numberOfInvalids();

            if( errors ) 

            {
//                 $("h3 span.ok").html("(유효성 검사 실패)"); 

                alert(validator.errorList[0].message);

                validator.errorList[0].element.focus();

            }

        },
        errorPlacement: function(error, element) {
        	if($(element).hasClass('email')){
        		$('.email_next').after(error)
         	}else{
         		$(element).after(error);	
         	}		
          }

    });
	
});




function Email(){
	var errorText = $("#TH_EMAIL-error").text();
	var email =  $("#TH_EMAIL").val();
	if(errorText == "" && email != ""){
		if($("#Authorize").val() == "N"){
			$.ajax({
				type: 'POST',
				url: '/hire/emailAjax.do?${_csrf.parameterName}=${_csrf.token}',
				data: {
					"email" : email,
					"bnkey" : $("#TH_BNKEYNO").val()
				},
				success:function(data){
					if(data == '0'){
						alert("이미 등록된 이메일 입니다.");
					}else{
						$("#emailAuthKey").val(data);
						$('.email_pop, .email_pop_b').show();
					}
				},
				error: function(e){
					alert("에러");
				}
			});
		}else{
			alert("이미 인증되었습니다.");
		}
	}else{
		if(errorText == ""){
			alert("이메일을 입력해주세요.")
		}else{
			alert(errorText);
		}
	}
	
}

function KeyCheck(){
	var key = $("#emailAuthKey_check").val();
	if(key == $("#emailAuthKey").val()){
		$("#Authorize").val("Y");
		alert("인증되었습니다.");
		$('.email_pop, .email_pop_b').hide();
	}else{
		alert("인증번호가 다릅니다. 다시 확인해주세요.");
	}
}

function Application(){
	
	if($("#priv_01").is(":checked") == false){
		alert("개인정보 수집 및 이용에 관한 동의를 해주세요.");
		return false
	}
	if($("#priv_02").is(":checked") == false){
		alert("개인정보의 위탁 제공에 대한 동의를 해주세요.");
		return false
	}
	
	
	if($('#Authorize').val() == 'Y'){
		$('.person_info_box .user').text($('#TH_USER').val());
		$('.person_info_box .phone').text($('#TH_PHONE').val());
		$('.person_info_box .email').text($('#TH_EMAIL').val());
		
		$('.info_pop, .info_pop_b').show();	
	}else{
		alert("인증이 되지 않았습니다.");
	}
	
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

</script>
