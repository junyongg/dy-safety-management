<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<form:form id="form" action="" method="post">
<input type="hidden" name="THC_KEYNO" id="THC_KEYNO" value="${HireContent.THC_KEYNO }"> 
<input type="hidden" name="THC_EDUTYPE" id="THC_EDUTYPE"> 
<input type="hidden" name="THC_CAREERTYPE" id="THC_CAREERTYPE"> 
<input type="hidden" name="type" id="type" value="${type }"> 


<input type="hidden" id="TH_KEYNO" name="TH_KEYNO" value="${HireUser.TH_KEYNO }">
<input type="hidden" id="TH_USER" name="TH_USER" value="${HireUser.TH_USER }">
<input type="hidden" id="TH_PHONE" name="TH_PHONE" value="${HireUser.TH_PHONE }">
<input type="hidden" id="TH_EMAIL" name="TH_EMAIL" value="${HireUser.TH_EMAIL }">
<input type="hidden" id="TH_PASSWORD" name="TH_PASSWORD" value="${HireUser.TH_PASSWORD }">
<input type="hidden" id="TH_TYPE" name="TH_TYPE" value="${HireUser.TH_TYPE }">
<input type="hidden" id="TH_BNKEYNO" name="TH_BNKEYNO" value="${HireUser.TH_BNKEYNO }">
<input type="hidden" id="TH_CLASSTYPE" name="TH_CLASSTYPE" value="${HireUser.TH_CLASSTYPE }">
<input type="hidden" id="THC_USERKEY" name="THC_USERKEY" value="${HireUser.TH_KEYNO }">
<input type="hidden" id="htmlStr" name="htmlStr" value="">

<section id="sub-content">
        <div class="inner1200"> <!--inner 시작 -->
            
            <!-- 서브 타이틀부분 -->
            <div class="sub-title-box">
                <h2>지원서 작성</h2>
                <ul class="list_ul">
                    <li class="home"><i class="xi-home"></i></li>
                    <li>열린광장</li>
                    <li>채용공고</li>
                    <li>지원서 작성</li>
				</ul>

            </div>


			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

                <!-- 지원서 작성 탑 부분 탭 -->
                <div class="employ_tab_box">
					<ul class="employ_tab_ul">
						<li class="active">
							<span class="icon n01"></span>
							<span class="txt">약관동의 및 기본정보입력</span>
						</li>
						<li class="active">
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


                <div class="txt_employ_warn_box">
                    <p class="bol">※ 입사지원서류 작성 시 기재착오, 내용누락으로 인한 불이익은 지원자 본인의 책임이므로 유의하여 작성하시기 바랍니다.</p>
                    <p class="txt" style="padding-left: 15px;">(허위 내용 또는 결격 사유 발생시 언제든지 합격 또는 취소됨을 안내드립니다.)</p>
                </div>


                <div class="employ_tab_box">
                    <ul class="employ_tab2_ul">
                        <li class="li active"><a href="javascript:;">입사지원서</a></li>
                        <li class=""><a href="javascript:;">자기소개</a></li>
                        <c:if test="${HireUser.TH_TYPE eq 'U' }">
                        	<li class=""><a href="javascript:;">직무수행계획서</a></li>
                        </c:if>
                    </ul>
                </div>

                <div class="employ_tab2_ul_con one" style="display: block;"> <!-- 입사지원서 -->

                    <div class="tab_tit">
                        <span class="bolder">인적사항</span>
                    </div>
                    <div class="table_empl_in_box">
                        <table class="tbl_join_list verti border">
                            <caption>인적사항</caption>
                            <colgroup>
                                <col style="width: 15%;">
                                <col style="width: 35%;">
                                <col style="width: 15%;">
                                <col style="width: 35%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><label for="pri2_cate"><span class="red-c">*</span> 응시분야</label></th>
                                    <td class="txt">
                                        <input type="text" class="txt_pri w100" id="THC_DEPARTMENT" name="THC_DEPARTMENT" readonly="readonly" value="${HireUser.TH_CLASSTYPE }">
                                    </td>
                                    <th><label for="pri2_num1">응시번호</label></th>
                                    <td class="txt">
                                        <input type="text" class="txt_pri w100" id="THC_NUMBER" name="THC_NUMBER" readonly="readonly" value="${HireNumber }">
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="pri2_name"><span class="red-c">*</span> 성명</label></th>
                                    <td class="txt" colspan="3">
                                        <input type="text" class="txt_pri w32" id="THC_NAME" name="THC_NAME" placeholder="한글" value="${HireUser.TH_USER }" readonly="readonly">
                                        <input type="text" class="txt_pri w32" id="THC_CNAME" name="THC_CNAME" placeholder="한문" value="${HireContent.THC_CNAME }">
                                        <input type="text" class="txt_pri w32" id="THC_ENAME" name="THC_ENAME" placeholder="영문" value="${HireContent.THC_ENAME }">
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="pri2_name"><span class="red-c">*</span> 현주소</label></th>
                                    <td class="txt" colspan="3">
                                        <input type="text" class="txt_pri w40" id="THC_ADD" name="THC_ADD" readonly="readonly" value="${HireContent.THC_ADD }">
                                        <button type="button" class="btn_pri purple" onclick="pf_execDaumPostcode()">우편번호 검색</button>
                                        <div style="width: 100%; height: 1px;"></div>
                                        <input type="text" class="txt_pri w40" name="THC_ADD1" id="THC_ADD1" value="${HireContent.THC_ADD1 }">
                                        <input type="text" class="txt_pri w40" placeholder="나머지 주소" name="THC_ADD2" value="${HireContent.THC_ADD2 }">
                                    </td>
                                </tr>
                                <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
                                <script type="text/javascript">
									//주소 찾기
									function pf_execDaumPostcode() {
									    new daum.Postcode({
									        oncomplete: function(data) {
									            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

									            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
									            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
									            var roadAddr = data.roadAddress || data.jibunAddress; // 도로명 주소 변수
									            // 우편번호와 주소 정보를 해당 필드에 넣는다.
									            document.getElementById('THC_ADD').value = data.zonecode;
									            document.getElementById("THC_ADD1").value = roadAddr;
									        }
									    }).open();
									}
                                </script>
                                <tr>
                                    <th><label for="pri2_name"><span class="red-c">*</span> 병역사항</label></th>
                                    <td class="txt" colspan="3">
                                        <label><input type="radio" name="THC_ARMY" value="P" ${HireContent.THC_ARMY eq 'P'?'checked':''}> 필</label>
                                        <div class="gab-h-30"></div>
                                        <label><input type="radio" name="THC_ARMY" value="M" ${HireContent.THC_ARMY eq 'M'?'checked':''}> 미필</label>
                                        <div class="gab-h-30"></div>
                                        <label><input type="radio" name="THC_ARMY" value="B" ${HireContent.THC_ARMY eq 'B'?'checked':''}> 면제/비대상</label>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="pri2_name"><span class="red-c"></span> 우대사항</label></th>
                                    <td class="tb_in" colspan="3">
                                        <table class="tbl_in_01">
                                            <caption>우대사항 내용</caption>
                                            <colgroup>
                                                <col style="width: 25%;">
                                                <col style="width: 25%;">
                                                <col style="width: 25%;">
                                                <col style="width: 25%;">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <td><label><input type="checkbox" name="bohun_check" ${not empty HireContent.THC_BOHUN?'checked':''}>보훈대상</label></td>
                                                    <td colspan="3">
                                                    	<label><input style="width: 90%;" type="text" name="THC_BOHUN" "${empty HireContent.THC_BOHUN?'readonly':''}" value="${HireContent.THC_BOHUN }"></label>
                                                    	<p style="margin-top: 10px;color: gray;">※ 보훈번호를 입력해주세요</p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><label><input type="checkbox" name="low_check" ${not empty HireList.lowpay?'checked':'' }>저소득층<br>대상</label></td>
                                                    <td colspan="3" class="tb_in">
                                                        <table class="tbl_in_01">
                                                            <caption>우대사항 내용</caption>
                                                            <colgroup>
                                                                <col style="width: 10%;">
                                                                <col style="width: 40%;">
                                                                <col style="width: 40%;">
                                                            </colgroup>
                                                            <tbody><tr>
                                                                <th>구분</th>
                                                                <td><label for="n004">국민기초생활보장법 상 수급자</label></td>
                                                                <td><label for="n005">한부모가족지원법 상 보호대상자</label></td>
                                                            </tr>
                                                            <tr>
                                                                <th>해당여부</th>
                                                                <td><input type="checkbox" id="n004" name="THC_LOWPAY" ${not empty HireList.lowpay?'':'disabled' } ${not empty HireList.lowpay[0]?'checked':''}></td>
                                                                <td><input type="checkbox" id="n005" name="THC_LOWPAY" ${not empty HireList.lowpay?'':'disabled' } ${not empty HireList.lowpay[1]?'checked':''}></td>
                                                            </tr>
                                                        </tbody></table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="2"><label><input type="checkbox" name="disabled_check" ${not empty HireContent.THC_DISABLED?'checked':''}> 장애인</label></td>
                                                    <td><label for="n001">장애종별</label></td>
                                                    <td><label for="n002">등급</label></td>
                                                    <td><label for="n003">장애인 등록정보</label></td>
                                                </tr>
                                                <tr>
                                                    <td><input type="text" id="n001" name="THC_DISABLED" ${empty HireContent.THC_DISABLED?'readonly':''}" value="${HireContent.THC_DISABLED }"></td>
                                                    <td><input type="text" id="n002" name="THC_DISABLED1" "${empty HireContent.THC_DISABLED?'readonly':''}" value="${HireContent.THC_DISABLED1 }"></td>
                                                    <td><input type="text" id="n003" name="THC_DISABLED2" "${empty HireContent.THC_DISABLED?'readonly':''}" value="${HireContent.THC_DISABLED2 }"></td>
                                                </tr>
                                            </tbody>
                                             <script type="text/javascript">
                                                	$('input[name="bohun_check"]').click(function(){
                                                		if($(this).is(':checked')){
                                                			$('input[name="THC_BOHUN"]').attr('readonly',false);
                                                			$('input[name="THC_BOHUN"]').focus();
                                                		}else{
                                                			$('input[name="THC_BOHUN"]').attr('readonly',true);
															$('input[name="THC_BOHUN"]').val('');
                                                		}
                                                	});


                                                	$('input[name="low_check"]').click(function(){
                                                		if($(this).is(':checked')){
                                                			$('input[name="THC_LOWPAY"]').attr('disabled',false);
                                                		}else{
                                                			$('input[name="THC_LOWPAY"]').attr('disabled',true);
                                                			$('input[name="THC_LOWPAY"]').attr('checked',false);
                                                		}
                                                	});

                                                	$('input[name="disabled_check"]').click(function(){
                                                		if($(this).is(':checked')){
                                                			$('input[name="THC_DISABLED"]').attr('readonly',false);
                                                			$('input[name="THC_DISABLED1"]').attr('readonly',false);
                                                			$('input[name="THC_DISABLED2"]').attr('readonly',false);
                                                			$('input[name="THC_DISABLED"]').focus();
                                                		}else{
                                                			$('input[name="THC_DISABLED"]').attr('readonly',true);
                                                			$('input[name="THC_DISABLED1"]').attr('readonly',true);
                                                			$('input[name="THC_DISABLED2"]').attr('readonly',true);
                                                			$('input[name="THC_DISABLED"]').val('');
                                                			$('input[name="THC_DISABLED1"]').val('');
                                                			$('input[name="THC_DISABLED2"]').val('');
                                                		}
                                                	});	
                                              </script>
                                        </table>
                                    </td>
                                </tr>
                                
                            </tbody>
                        </table>
                    </div>

                    <div class="gab50"></div>

                    <div class="tab_tit">
                        <span class="bolder">교육사항</span>
                        <span class="small"><b>*</b> 지원직무 관련 과목 및 교육과정을 이수한 경우 그 내용을 기입해 주십시오.</span>
                    </div>
                    <div class="table_empl_in_box table_wrap_mobile">
                        <table class="tbl_join_list border pd">
                            <caption>교육사항</caption>
                            <colgroup>
                                <col style="width: 33.33%;">
                                <col style="width: 33.33%;">
                                <col style="width: 16.33%;">
                                <col style="width: 16.33%;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>교육구분</th>
                                    <th>과목 명 및 교육과정</th>
                                    <th>교육시간</th>
                                </tr>
                            </thead>
                            <tbody class="EDU_BODY">
									<c:forEach begin="0" end="${not empty HireList.edutype ? fn:length(HireList.edutype)-1 :0}" varStatus="status">
										<c:set var="educount" value="${not empty HireList.edutype ? fn:length(HireList.edutype) :1}"/>
										<tr>
		                                    <td class="edutypeTd">
		                                        <label><input type="radio" class="edutype" name="THC_EDUTYPE${status.index }" value="A" ${HireList.edutype[status.index] eq 'A' ? 'checked':''}> 학교교육</label>
		                                        <div class="gab-h-30"></div>
		                                        <label><input type="radio" class="edutype" name="THC_EDUTYPE${status.index }" value="B" ${HireList.edutype[status.index] eq 'B' ? 'checked':''}> 직업훈련</label>
		                                        <div class="gab-h-30"></div>
		                                        <label><input type="radio" class="edutype" name="THC_EDUTYPE${status.index }" value="C" ${HireList.edutype[status.index] eq 'C' ? 'checked':''}> 기타</label>
		                                    </td>
		                                    <td>
		                                        <input type="text" class="txt_pri w90" name="THC_EDUSUBJECT" value="${HireList.edusubject[status.index]}">
		                                    </td>
		                                    <td>
		                                        <input type="text" class="txt_pri w70" name="THC_EDUSTARTTIME" value="${HireList.edustart[status.index]}" autocomplete="off"> 시간	
	<!-- 	                                        <button type="button" class="btn_pri purple calen" style="margin-left: -5px;" title="캘린더"><img src="/resources/img/sub/icon_join_calendar.png" alt=""></button> -->
		                                    </td>
		                                    <%-- <td>
		                                        <input type="text" class="txt_pri w70 datepicker" name="THC_EDUENDTIME" data-dateformat="yy-mm-dd" value="${HireList.eduend[status.index]}" autocomplete="off">
		                                    </td> --%>
		                                </tr>
									</c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="tbl_bott_btn_box">
                        <button type="button" class="btn_add_1" title="항목 추가하기" onclick="EduPlus();"><i class="xi-plus-circle-o"></i> 항목 추가하기</button>
                        <button type="button" class="btn_add_1" title="항목 제거하기" onclick="Minus('eduTr');"><i class="xi-minus-circle-o"></i> 항목 제거하기</button>
                    </div>
                    
                    <div class="gab15"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">직무관련 주요내용</span>
							<span class="txt"><span class="red-c"></span></span>
						</div>
						<textarea name="THC_EDUDO" rows="7" class="txtarea_emply" onkeypress="TextCount(this,'edudo');">${HireContent.THC_EDUDO}</textarea>
						<span id="edudo"></span>
					</div>


                    <div class="gab50"></div>

                    <div class="tab_tit">
                        <span class="bolder">자격사항</span>
                        <span class="small"><b>*</b> 지원직무 관련 국가기술/전문자격, 국가공인민간자격을 기입해 주십시오.</span>
                    </div>
                    <div class="table_empl_in_box table_wrap_mobile">
                        <table class="tbl_join_list border pd">
                            <caption>자격사항</caption>
                            <colgroup>
                                <col style="width: 33.33%;">
                                <col style="width: 33.33%;">
                                <col style="width: 33.33%;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>자격증명</th>
                                    <th>발급기관</th>
                                    <th>취득일자</th>
                                </tr>
                            </thead>
                            <tbody class="CERT_BODY">
									<c:forEach begin="0" end="${not empty HireList.certificate?fn:length(HireList.certificate)-1:0}" varStatus="status">
									<c:set var="cercount" value="${not empty HireList.certificate ? fn:length(HireList.certificate) :1}"/>
	                                <tr>
	                                    <td>
											<input type="text" class="txt_pri w60" name="THC_CERTIFICATE" value="${HireList.certificate[status.index]}">
	<!-- 										<button type="button" class="btn_pri purple" style="margin-left: -5px;" title="자격증검색">자격증검색</button> -->
	                                    </td>
	                                    <td>
	                                        <input type="text" class="txt_pri w90" name="THC_CERTIFICATEAGENCY" value="${HireList.certificateAgency[status.index]}">
	                                    </td>
	                                    <td>
	                                        <input type="text" class="txt_pri w70" name="THC_CERTIFICATETIME" value="${HireList.certificateTime[status.index]}">
	                                    </td>
	                                </tr>
	                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="tbl_bott_btn_box">
                        <button type="button" class="btn_add_1" title="항목 추가하기" onclick="CertiPlus();"><i class="xi-plus-circle-o"></i> 항목 추가하기</button>
                         <button type="button" class="btn_add_1" title="항목 제거하기" onclick="Minus('cerTr');"><i class="xi-minus-circle-o"></i> 항목 제거하기</button>
                    </div>



                    <div class="gab50"></div>

                    <div class="tab_tit">
                        <span class="bolder">경력 혹은 경력사항</span>
                        <span class="small"><b>*</b> 지원직무 관련 경험 혹은 경력사항을 기입해 주십시오.</span>
                    </div>
                    <div class="table_empl_in_box table_wrap_mobile">
                        <table class="tbl_join_list border pd">
                            <caption>경력사항</caption>
                            <colgroup>
                                <col style="width: 15%;">
                                <col style="width: 15%;">
                                <col style="width: 15%;">
                                <col style="width: 17.5%;">
                                <col style="width: 17.5%;">
                                <col style="width: 35%;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>구분</th>
                                    <th>소속조직</th>
                                    <th>역할</th>
                                    <th colspan="2">활동기간</th>
                                    <th>활동내역</th>
                                </tr>
                            </thead>
                            <tbody class="CREER_BODY">
	                                <c:forEach begin="0" end="${not empty HireList.careertype?fn:length(HireList.careertype)-1:0}" varStatus="status">
	                                <c:set var="careecount" value="${not empty HireList.careertype ? fn:length(HireList.careertype) :1}"/>
	                                <tr>
										<td class="careertypeTd">
											<label><input type="radio" class="careertype" name="THC_CAREERTYPE${status.index }" value="A" ${HireList.careertype[status.index] eq 'A' ? 'checked':'' }> 경험</label>
											<div class="gab-h-20"></div>
											<label><input type="radio" class="careertype" name="THC_CAREERTYPE${status.index }" value="B" ${HireList.careertype[status.index] eq 'B' ? 'checked':'' }> 경력</label>
										</td>
	                                    <td>
											<input type="text" class="txt_pri w90" name="THC_CAREERAGENCY" value="${HireList.careerAgency[status.index]}">
	                                    </td>
	                                    <td>
											<input type="text" class="txt_pri w90" name="THC_CAREERPOSITION" value="${HireList.careerPosition[status.index]}">
	                                    </td>
	                                    <td>
											<input type="text" class="txt_pri w70" name="THC_CAREERSATRTTIME" value="${HireList.careerstart[status.index]}">
	<!--                                         <button type="button" class="btn_pri purple calen" style="margin-left: -5px;" title="캘린더"><img src="/resources/img/sub/icon_join_calendar.png" alt=""></button> -->
	                                    </td>
	                                    <td>
											<input type="text" class="txt_pri w70" name="THC_CAREERENDTIME" value="${HireList.careerend[status.index]}">
	                                    </td>
										<td>
											<input type="text" class="txt_pri w90" name="THC_CAREERDO" value="${HireList.careerdo[status.index]}">
										</td>
	                                </tr>
	                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="tbl_bott_btn_box">
                        <button type="button" class="btn_add_1" title="항목 추가하기" onclick="CareerPlus();"><i class="xi-plus-circle-o"></i> 항목 추가하기</button>
                        <button type="button" class="btn_add_1" title="항목 제거하기" onclick="Minus('carTr');"><i class="xi-minus-circle-o"></i> 항목 제거하기</button>
					</div>

					<div class="gab15"></div>

					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">직무관련 주요내용</span>
							<span class="txt"><span class="red-c">*</span> 직무활동, 동아리/동호회, 팀프로젝트, 연구회, 재능기부 등 주요 직무경험을 서술하여 주십시오.</span>
						</div>
						<textarea name="THC_OTHERDO" rows="7" class="txtarea_emply" onkeypress="TextCount(this,'otherdo');">${HireContent.THC_OTHERDO}</textarea>
						<span id="otherdo"></span>
					</div>


					<div class="signiture_emply">

						<div class="txt1">본인의 위 기재사항이 사실과 틀림이 없음을 확인합니다.</div>

						<div class="bott_right">
							<div class="date">
								${fn:substring(bndate.BN_REGDT,0,4) }년 	${fn:substring(bndate.BN_REGDT,5,7) }월	 ${fn:substring(bndate.BN_REGDT,8,10) }일
							</div>
							<div class="name">
								<span class="s_t">작성자 : </span>
								<span class="na">${HireUser.TH_USER }</span>
								<span class="s_t">서명</span>
							</div>
						</div>

					</div>
					


                    <div class="gab50"></div>

                    <div class="textC">
                        <button type="button" class="btn_support purple nextbutton" onclick="NextPage(1);" title="다음">다음</button>
                        <button type="button" class="btn_support gray" onclick="PreInsert();" title="임시저장">임시저장</button>
                        <button type="button" class="btn_support gray" onclick="location.href='/jact/open/hire.do';" title="목록">목록</button>
                    </div>

                </div><!-- // 입사지원서 -->



				<div class="employ_tab2_ul_con two" style="display: none;"> <!-- 자기소개 -->
					
					
					
					
					<div class="tab_tit">
						<span class="small"><b> * </b>정부의 블라인드 채용 권장정책에 따라 직·간접적으로 학교명, 나이, 성별, 출신지, 가족관계 등 인적사항이 드러나지 않도록 유의하시기 바랍니다.</span>
						<br><br>
						<span class="bolder">
							인적사항
						</span>
					</div>
					<div class="table_empl_in_box">
						<table class="tbl_join_list verti pd">
							<caption>인적사항</caption>
							<colgroup>
								<col style="width: 15%;">
								<col style="width: 85%;">
							</colgroup>
							<tbody>
								<tr>
									<th><label for="pri3_cate">응시분야</label></th>
									<td class="txt"><input type="text" class="txt_pri w100" readonly="readonly" value="${HireUser.TH_CLASSTYPE }"></td>
								</tr>
								<tr>
									<th><label>성명</label></th>
									<td class="txt">${HireUser.TH_USER }</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="gab40"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">해당 직무에 지원하게 된 동기와 본인이 직무를 잘 수행할 수 있는 이유 (본인의 강점, 준비 관련 경험에 근거)가 무엇인지 기술해 주십시오.</span>
						</div>
						<textarea name="THC_CONTENT1" rows="7" class="txtarea_emply" onkeydown="TextCount(this,'con1');">${HireContent.THC_CONTENT1}</textarea>
						<span id="con1"></span>
					</div>


					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">본인의 경험 중 지원한 직무와 관련하여 가장 특별하고 인상 깊었던 경험에 대해 구체적으로 기술해 주십시오.</span>
						</div>
						<textarea name="THC_CONTENT2" rows="7" class="txtarea_emply" onkeydown="TextCount(this,'con2');">${HireContent.THC_CONTENT2}</textarea>
						<span id="con2"></span>
					</div>


					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">예상치 못했던 문제의 발생으로 계획대로 일이 진행되지 않았을 때, 책임감을 가지고 적극적으로 문제를 해결한 경험과 그 경험을 통해 얻은 것은 무엇인지 구체적으로 기술해 주십시오.</span>
						</div>
						<textarea name="THC_CONTENT3" rows="7" class="txtarea_emply" onkeydown="TextCount(this,'con3');">${HireContent.THC_CONTENT3}</textarea>
						<span id="con3"></span>
					</div>


					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">공동의 목표를 달성하기 위해 타인과 협업했던 경험과 그 과정에서 본인이 수행한 역할, 그리고 해당 경험을 통해 얻은 것은 무엇인지 구체적으로 기술해 주십시오.</span>
						</div>
						<textarea name="THC_CONTENT4" rows="7" class="txtarea_emply" onkeydown="TextCount(this,'con4');">${HireContent.THC_CONTENT4}</textarea>
						<span id="con4"></span>
					</div>


                    <div class="gab50"></div>
                    
                    <div class="textC">
                        <c:if test="${HireUser.TH_TYPE eq 'U' }">
                        	<button type="button" class="btn_support purple" onclick="NextPage(2);" title="다음">다음</button>
                        </c:if>
                        <c:if test="${HireUser.TH_TYPE ne 'U' }">
                        	<button type="button" onclick="insertData();" class="btn_support purple" title="제출">제출</button>
                        </c:if>
                        <button type="button" class="btn_support gray" onclick="PreInsert();" title="임시저장">임시저장</button>
                         <button type="button" class="btn_support gray" onclick="PrePage(1);" title="이전">이전</button> 
                        <button type="button" class="btn_support gray" onclick="location.href='/jact/open/hire.do';" title="목록">목록</button>
                    </div>

                </div><!-- // 자기소개 -->



				<div class="employ_tab2_ul_con three" style="display: none;"> <!-- 직무수행계획소 -->
					
					<div class="tab_tit">
						<span class="bolder">인적사항</span>
					</div>
					<div class="table_empl_in_box">
						<table class="tbl_join_list verti pd">
							<caption>인적사항</caption>
							<colgroup>
								<col style="width: 15%;">
								<col style="width: 85%;">
							</colgroup>
							<tbody>
								<tr>
									<th><label for="pri3_cate">응시분야</label></th>
									<td class="txt"><input type="text" class="txt_pri w100" readonly="readonly" value="${HireUser.TH_CLASSTYPE }"></td>
								</tr>
								<tr>
									<th><label>성명</label></th>
									<td class="txt">${HireUser.TH_USER }</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="gab40"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">서론(동향 및 전망 등)</span>
						</div>
						<textarea name="THC_UNYOUNG1" rows="7" class="txtarea_emply" onkeydown="TextCount2(this,'unyoung1');">${HireContent.THC_UNYOUNG1}</textarea>
						<span id="unyoung1"></span>
					</div>
					
					
					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">비전 및 목표</span>
						</div>
						<textarea name="THC_UNYOUNG2" rows="7" class="txtarea_emply" onkeydown="TextCount2(this,'unyoung2');">${HireContent.THC_UNYOUNG2}</textarea>
						<span id="unyoung2"></span>
					</div>
					
					
					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">추진방법</span>
						</div>
						<textarea name="THC_UNYOUNG3" rows="7" class="txtarea_emply" onkeydown="TextCount2(this,'unyoung3');">${HireContent.THC_UNYOUNG3}</textarea>
						<span id="unyoung3"></span>
					</div>
					
					
					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">추진일정</span>
						</div>
						<textarea name="THC_UNYOUNG4" rows="7" class="txtarea_emply" onkeydown="TextCount2(this,'unyoung4');">${HireContent.THC_UNYOUNG4}</textarea>
						<span id="unyoung4"></span>
					</div>

					<div class="gab50"></div>

					<div class="tab_tit">
						<span class="bolder">직무 세부추진 계획</span>
					</div>
					<div class="table_empl_in_box table_wrap_mobile">
						<table class="tbl_join_list border pd">
							<caption>직무 세부추진 계획</caption>
							<colgroup>
								<col style="width: 28%;">
								<col style="width: 44%;">
								<col style="width: 28%;">
							</colgroup>
							<thead>
								<tr>
									<th>업무분야</th>
									<th>세부추진계획 (추진방법 등)</th>
									<th>평가지표</th>
								</tr>
							</thead>
							<tbody>
<%-- 							<c:forEach begin="0" end="${not empty HireList.unyoun5?fn:length(HireList.unyoun5)-1:2}" varStatus="status"> --%>
							<c:forEach begin="0" end="3" varStatus="status">
								<tr>
									<td>
										<textarea class="txta1" name="THC_UNYOUNG5">${HireList.unyoun5[status.index]}</textarea>
									</td>
									<td>
										<textarea class="txta1" name="THC_UNYOUNG6">${HireList.unyoun6[status.index]}</textarea>
									</td>
									<td>
										<textarea class="txta1" name="THC_UNYOUNG7">${HireList.unyoun7[status.index]}</textarea>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>

					
					<div class="gab20"></div>

					<div class="txt_employ_warn_box">
						<p class="bol">※ 작성요령</p>
						<p class="txt" style="padding-left: 15px;">
							- 위 서식에 의거 응시자가 자유롭게 기술<br>
							- 업무분야 : 직무수행 계획서에서 제시한 목표를 실행하기 위한 단위업무에 대해 기술<br>
							- 세부추진계획 : 추진방법, 연차별 추진일정 등<br>
							- 평가지표 : 추진결과 성과목표 달성도 평가를 위한 지표를 계량화하여 제시
						</p>
					</div>

                    <div class="gab50"></div>

                    <div class="textC">
                    	<button type="button" onclick="insertData();" class="btn_support purple" title="등록">
	                        <c:if test="${type ne 'update' }">
		                        	제출
	                        </c:if>
	                        <c:if test="${type eq 'update' }">
		                        	수정
	                        </c:if>
                        </button>
                        <button type="button" class="btn_support gray" onclick="PreInsert();" title="임시저장">임시저장</button>
						<button type="button" class="btn_support gray" onclick="PrePage(2);" title="이전">이전</button>
						<button type="button" class="btn_support gray" onclick="location.href='/jact/open/hire.do';" title="목록">목록</button>
                    </div>
                </div><!-- // 직무수행계획소 -->

            </div>

		</div> <!--inner 끝 -->
	</section>
</form:form>	
	
	
<script>
var educnt = '${educount}';
var cercnt = '${cercount}';
var careercnt = '${careecount}';
/* $(document).ready(function() {
	 $("#form").validate({

       onfocusout : function (element) {

           $(element).valid();

       },
       
       rules : {
    	  
    	   THC_CNAME 		:	{required:true}
    	   ,THC_ENAME		:	{required:true}
    	   ,THC_ADD			:	{required:true}
    	   ,THC_ADD1		:	{required:true}
    	   ,THC_ADD2		:	{required:true}
    	   ,THC_ARMY		:	{required:true}
    	   ,THC_CONTENT1	:	{required:true}
    	   ,THC_CONTENT2	:	{required:true}
    	   ,THC_CONTENT3	:	{required:true}
    	   ,THC_CONTENT4	:	{required:true}
    	    if('${HireUser.TH_KEYNO }' == 'U'){
    		   ,THC_UNYOUNG1	:	{required:true}
        	   ,THC_UNYOUNG2	:	{required:true}
        	   ,THC_UNYOUNG3	:	{required:true}
        	   ,THC_UNYOUNG4	:	{required:true}
        	   ,THC_UNYOUNG5	:	{required:true}
        	   ,THC_UNYOUNG6	:	{required:true}
        	   ,THC_UNYOUNG7	:	{required:true}   
    	   }
    	    
       },

       messages : {

    	   THC_CNAME 		:	{required:"필수정보를 적어주세요."}
		   ,THC_ENAME		:	{required:"필수정보를 적어주세요."}
		   ,THC_ADD			:	{required:"필수정보를 적어주세요."}
		   ,THC_ADD1		:	{required:"필수정보를 적어주세요."}
		   ,THC_ADD2		:	{required:"필수정보를 적어주세요."}
		   ,THC_ARMY		:	{required:"필수정보를 적어주세요."}
		   ,THC_CONTENT1	:	{required:"필수정보를 적어주세요."}
		   ,THC_CONTENT2	:	{required:"필수정보를 적어주세요."}
		   ,THC_CONTENT3	:	{required:"필수정보를 적어주세요."}
		   ,THC_CONTENT4	:	{required:"필수정보를 적어주세요."}
		   if('${HireUser.TH_KEYNO }' == 'U'){
			   ,THC_UNYOUNG1	:	{required:"필수정보를 적어주세요."}
	    	   ,THC_UNYOUNG2	:	{required:"필수정보를 적어주세요."}
	    	   ,THC_UNYOUNG3	:	{required:"필수정보를 적어주세요."}
	    	   ,THC_UNYOUNG4	:	{required:"필수정보를 적어주세요."}
	    	   ,THC_UNYOUNG5	:	{required:"필수정보를 적어주세요."}
	    	   ,THC_UNYOUNG6	:	{required:"필수정보를 적어주세요."}
	    	   ,THC_UNYOUNG7	:	{required:"필수정보를 적어주세요."}   
		   } 
       }, 

       invalidHandler : function(form, validator) {

           var errors = validator.numberOfInvalids();

           if( errors ) 

           {
//                $("h3 span.ok").html("(유효성 검사 실패)"); 

               validator.errorList[0].element.focus();

           }

       },
       errorPlacement: function(error, element) {
        	$(element).after(error);	
         }

   });
	
}); */

$(function(){
	
	$.datepicker.setDefaults({
		 closeText: '닫기', // 닫기 버튼 텍스트 변경
		    currentText: '오늘' // 오늘 텍스트 변경
		    ,monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'] // 개월 텍스트 설정
		    ,monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'] // 개월 텍스트 설정
		    ,dayNames: ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'] // 요일 텍스트 설정
		    ,dayNamesShort: ['월','화','수','목','금','토','일'] // 요일 텍스트 축약 설정&nbsp;   dayNamesMin: ['월','화','수','목','금','토','일'], // 요일 최소 축약 텍스트 설정
		    ,dateFormat: 'yy-mm-dd' //Input Display Format 변경
    	 	,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	 	    ,changeYear: true //콤보박스에서 년 선택 가능
	 	    ,changeMonth: true //콤보박스에서 월 선택 가능  
	})
	
	CareerDate();
	Certidate();
	
// 	tabFucNomal('.employ_tab2_ul li','.employ_tab2_ul_con');
	
});
function CareerDate(){
	//경력
	$('input[name="THC_CAREERSATRTTIME"]').datepicker({
		dateFormat: "yy-mm-dd"
	});
	$('input[name="THC_CAREERENDTIME"]').datepicker({
		dateFormat: "yy-mm-dd"
	});
}

function Certidate(){
	//자격증
	$('input[name="THC_CERTIFICATETIME"]').datepicker({
		dateFormat: "yy-mm-dd"
	});
}



//임시저장
function PreInsert(){
	eduType();
	carType();
	
	$.ajax({
		type	:	"post",
		url		:	"/hire/preInsert.do?${_csrf.parameterName}=${_csrf.token}",
		data	:	$('#form').serializeArray(),
		success :	function(data){
			$("#TH_KEYNO").val(data['keyno']);
			$("#THC_USERKEY").val(data['keyno']);
			$("#THC_NUMBER").val(data['number']);
			alert("임시저장 되었습니다.")
		},
		error	:	function(){
			alert("임시저장 에러");
		}
	});
}

function EduPlus(){
	
	var html = "";
		html +='<tr class="eduTr'+educnt+'">'
		html +='<td class="edutypeTd">'
		html +='<label><input type="radio" class="edutype" name="THC_EDUTYPE'+educnt+'" value="A"> 학교교육</label>'
		html +='<div class="gab-h-30"></div>'        
		html +='<label><input type="radio" class="edutype" name="THC_EDUTYPE'+educnt+'" value="B"> 직업훈련</label>'
		html +='<div class="gab-h-30"></div>'
		html +='<label><input type="radio" class="edutype" name="THC_EDUTYPE'+educnt+'" value="C"> 기타</label>'
		html +='</td>'
		html +='<td>'
		html +='<input type="text" class="txt_pri w90" name="THC_EDUSUBJECT">'
		html +='</td>'
		html +='<td>'
		html +='<input type="text" class="txt_pri w70" name="THC_EDUSTARTTIME">시간'
		html +='</td>'
		html +='</tr>'
	$(".EDU_BODY").append(html);
	educnt++;
}
function CertiPlus(){
	var html = "";
		html += '<tr class="cerTr'+cercnt+'">'
		html += '<td>'
		html += '<input type="text" class="txt_pri w60" name="THC_CERTIFICATE">'
		html += '</td>'
		html += '<td>'
		html += '<input type="text" class="txt_pri w90" name="THC_CERTIFICATEAGENCY">'
		html += '</td>'
		html += '<td>'
		html += '<input type="text" class="txt_pri w70" name="THC_CERTIFICATETIME">'
		html += '</td>'
		html += '</tr>'
		$(".CERT_BODY").append(html);
		cercnt++;
		Certidate();
}
function CareerPlus(){
	var html = "";
	html += '<tr class="carTr'+careercnt+'">'
	html += '<td class="careertypeTd">'
	html += '<label><input type="radio" class="careertype" name="THC_CAREERTYPE'+careercnt+'" value="A"> 경험</label>'
	html += '<div class="gab-h-20"></div>'
	html += '<label><input type="radio" class="careertype" name="THC_CAREERTYPE'+careercnt+'" value="B"> 경력</label>'
	html += '</td>'
	html += '<td>'
	html += '<input type="text" class="txt_pri w90" name="THC_CAREERAGENCY">'
	html += '</td>'
	html += '<td>'
	html += '<input type="text" class="txt_pri w90" name="THC_CAREERPOSITION">'
	html += '</td>'
	html += '<td>'
	html += '<input type="text" class="txt_pri w70" name="THC_CAREERSATRTTIME">'
	html += '</td>'
	html += '<td>'
	html += '<input type="text" class="txt_pri w70" name="THC_CAREERENDTIME">'
	html += '</td>'
	html += '<td>'
	html += '<input type="text" class="txt_pri w90" name="THC_CAREERDO">'
	html += '</td>'
	html += '</tr>'
	$(".CREER_BODY").append(html);
	careercnt++;
	CareerDate();
}

function eduType(){
	var eduArr = new Array();
	$('.edutypeTd').each(function(){
		$(this).find('input[type=radio]:checked').val()
		eduArr.push($(this).find('input[type=radio]:checked').val());
	});
	$("#THC_EDUTYPE").val(eduArr);
}

function carType(){
	var carArr = new Array();
	$('.careertypeTd').each(function(){
		$(this).find('input[type=radio]:checked').val()
		carArr.push($(this).find('input[type=radio]:checked').val());
	});
	$("#THC_CAREERTYPE").val(carArr);
}

function DefaultVaildation(){
	if($("#THC_CNAME").val() == ""){ 
		alert("한자를 입력해주세요"); 
		$("#THC_CNAME").focus();
		return false;
	}else if($("#THC_ENAME").val() == ""){ 
		alert("영문을 입력해주세요"); 
		$("#THC_ENAME").focus();
		return false;
	}else if($("#THC_ADD").val() == ""){ 
		alert("주소를 입력해주세요"); 
		$("#THC_ADD").focus();
		return false;
	}else if($('input[name="THC_ARMY"]').is(":checked") == false){ 
		alert("병역사항을 체크해주세요"); 
		$('input[name="THC_ARMY"]').focus();
		return false;
	}
	return true;
}

function NextPage(num){
	if(num == 1){
		if(DefaultVaildation()){
			$("ul.employ_tab2_ul li").removeClass('active');
			$("ul.employ_tab2_ul li:nth-child("+(num+1)+")").addClass('li active');
			
			$('.employ_tab2_ul_con.one').hide();
			$('.employ_tab2_ul_con.two').show();
		}
	}else{
		$("ul.employ_tab2_ul li").removeClass('active');
		$("ul.employ_tab2_ul li:nth-child("+(num+1)+")").addClass('li active');
		
		$('.employ_tab2_ul_con.two').hide();
		$('.employ_tab2_ul_con.three').show();
	}
}

function PrePage(num){
 	$("ul.employ_tab2_ul li").removeClass('active');
	$("ul.employ_tab2_ul li:nth-child("+(num)+")").addClass('li active');
	if(num == 1){
		$('.employ_tab2_ul_con.two').hide();
		$('.employ_tab2_ul_con.one').show();
	}else{
		$('.employ_tab2_ul_con.three').hide();
		$('.employ_tab2_ul_con.two').show();
	}
}

function SubmitCheck(){
	if(!confirm("이력서를 제출하시겠습니까")){
		return false;
	}else{
		eduType();
		carType();
		
		return true;
	}
}

function Minus(type){
	if(type == 'eduTr'){
		educnt--;
		$("."+type+educnt).remove()
	}else if(type == 'cerTr'){
		cercnt--;
		$("."+type+cercnt).remove()
	}else{
		careercnt--;
		$("."+type+careercnt).remove()
	}
}

function TextCount(obj,id){
	var strValue = obj.value;
	var strLen = strValue.length+1;
	var str = "";
	str += '[' + strLen + '자 / 500자]';
	if(strLen > 499){
		alert("제한 글자를 초과하였습니다.");
		$(obj).val(strValue.substring(0, 498));
	}
	$("#"+id).html(str);
}

function TextCount2(obj,id){
	var strValue = obj.value;
	var strLen = strValue.length+1;
	var str = "";
	str += '[' + strLen + '자 ]';
	$("#"+id).html(str);
}

function back(){
	window.history.back();
}

function insertData(){
	if(SubmitCheck()){
		$.ajax({
			type : "POST" ,
			url : "/hire/insert.do?${_csrf.parameterName}=${_csrf.token}" ,
			data :  $('#form').serializeArray() ,
			async:false ,
			success : function(data){
				$("#TH_KEYNO").val(data);
				$("#THC_USERKEY").val(data);
				PDFDownload();
			},
			error : function(xhr, status, error) {
	            alert("에러발생0");
	            return false;
	      }
		});
	}
}

function PDFDownload(){
	$.ajax({
		type : "POST" ,
		url : "/hire/UserPrint.do?${_csrf.parameterName}=${_csrf.token}" ,
		data :  $('#form').serializeArray() ,
		async:false ,
		success : function(data){
			pdfdown(data);
		},
		error : function(xhr, status, error) {
            alert("에러발생");
            return false;
      }
	}).done(function(){
		cf_loading_out();
	})
}

function pdfdown(data){
	$("#form").attr("action","/hire/PdfAjax.do");
	$("#htmlStr").val(data);
	$("#form").submit();
	
	
}

</script>