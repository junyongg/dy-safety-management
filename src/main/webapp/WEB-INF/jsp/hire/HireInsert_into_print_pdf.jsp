<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<section id="sub-content" style="overflow-y: scroll;height: 600px; overflow-x: hidden;">
        <div class="inner1200"> <!--inner 시작 -->
			<!-- 서브컨텐츠 시작 -->
                <div class="employ_tab2_ul_con one" style="display: block;"> <!-- 입사지원서 -->
 					<button type="button" class="btn_support purple" title="출력" onclick="window.print()" style="width: 100%">출력</button>
                    <div class="tab_tit">
                        <span class="bolder">인적사항</span>
                    </div>
                    <div class="table_empl_in_box">
                        <table class="tbl_join_list verti border">
                            <caption>인적사항</caption>
<!--                             <colgroup> -->
                                <!-- <col style="width: 15%;">
                                <col style="width: 35%;">
                                <col style="width: 15%;">
                                <col style="width: 35%;"> -->
<!--                             </colgroup> -->
                            <tbody>
                                <tr>
                                    <th><label for="pri2_cate"><span class="red-c">*</span> 응시분야</label></th>
                                    <td class="txt">
<%--                                         <input type="text" class="txt_pri w100" id="THC_DEPARTMENT" name="THC_DEPARTMENT" readonly="readonly" value="${Hire.TH_CLASSTYPE }"> --%>
                                        ${Hire.TH_CLASSTYPE }
                                    </td>
                                    <th><label for="pri2_num1">응시번호</label></th>
                                    <td class="txt">
<%--                                         <input type="text" class="txt_pri w100" id="THC_NUMBER" name="THC_NUMBER" readonly="readonly" value="${Hire.THC_NUMBER }"> --%>
                                        ${Hire.THC_NUMBER }
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="pri2_name"><span class="red-c">*</span> 성명</label></th>
                                    <td class="txt">
                                        ${Hire.TH_USER }
                                    </td>
                                    <td class="txt"><pre><c:out value="${Hire.THC_CNAME }" escapeXml="true"/></pre></td>
                                    <td class="txt">${Hire.THC_ENAME }</td>
                                </tr>
                                <tr>
                                    <th><label for="pri2_name"><span class="red-c">*</span> 현주소</label></th>
                                    <td class="txt" colspan="3">
                                        <!-- <input type="text" class="txt_pri w40" id="THC_ADD" name="THC_ADD" readonly="readonly" value="${Hire.THC_ADD }">
                                        <input type="text" class="txt_pri w40" id="THC_ADD1" name="THC_ADD1" readonly="readonly" value="${Hire.THC_ADD1 }">
                                        <input type="text" class="txt_pri w40" id="THC_ADD2" name="THC_ADD2" readonly="readonly" value="${Hire.THC_ADD2 }"> -->
                                        ${Hire.THC_ADD }
                                        ${Hire.THC_ADD1 }
                                        ${Hire.THC_ADD2 }
                                        <div style="width: 100%; height: 1px;"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="pri2_name"><span class="red-c">*</span> 병역사항</label></th>
                                    <td class="txt" colspan="3">
                                        <!-- <label><input type="radio" name="THC_ARMY" value="P" ${Hire.THC_ARMY eq 'P'?'checked':''}> 필</label>
                                        <div class="gab-h-30"></div>
                                        <label><input type="radio" name="THC_ARMY" value="M" ${Hire.THC_ARMY eq 'M'?'checked':''}> 미필</label>
                                        <div class="gab-h-30"></div>
                                        <label><input type="radio" name="THC_ARMY" value="B" ${Hire.THC_ARMY eq 'B'?'checked':''}> 면제/비대상</label> -->
                                        ${army}
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="pri2_name"><span class="red-c"></span> 우대사항</label></th>
                                    <td class="tb_in" colspan="3">
                                        <table class="tbl_in_01">
                                            <caption>우대사항 내용</caption>
                                            <!-- <colgroup>
                                                <col style="width: 25%;">
                                                <col style="width: 25%;">
                                                <col style="width: 25%;">
                                                <col style="width: 25%;">
                                            </colgroup> -->
                                            <tbody>
                                                <tr>
                                                    <td><label><!-- <input type="checkbox" name="bohun_check" ${not empty Hire.THC_BOHUN?'checked':''} style="width:90%;"> -->보훈대상</label></td>
                                                    <td colspan="3">${Hire.THC_BOHUN }<!-- <label><input type="text" name="THC_BOHUN" "${empty Hire.THC_BOHUN?'readonly':''}" value="${Hire.THC_BOHUN }"></label> --></td>

                                                </tr>
                                                <tr>
                                                    <td><!-- <label><input type="checkbox" name="low_check" ${not empty HireList.lowpay?'checked':'' }></label> -->저소득층 대상</td>
                                                    <td colspan="3" class="tb_in">
                                                        <table class="tbl_in_01">
                                                            <caption>우대사항 내용</caption>
                                                            <!-- <colgroup>
                                                                <col style="width: 10%;">
                                                                <col style="width: 40%;">
                                                                <col style="width: 40%;">
                                                            </colgroup> -->
                                                            <tbody>
                                                            <tr>
                                                                <th>구분</th>
                                                                <td><label for="n004">국민기초생활보장법 상 수급자</label></td>
                                                                <td><label for="n005">한부모가족지원법 상 보호대상자</label></td>
                                                            </tr>
                                                            <tr>
                                                                <th>해당여부</th>
                                                                <td>${not empty HireList.lowpay[0]?'YES':'NO'}<!-- <input type="checkbox" id="n004" name="THC_LOWPAY" ${not empty HireList.lowpay?'':'disabled' } ${not empty HireList.lowpay[0]?'checked':''}> --></td>
                                                                <td>${not empty HireList.lowpay[1]?'YES':'NO'}<!-- <input type="checkbox" id="n005" name="THC_LOWPAY" ${not empty HireList.lowpay?'':'disabled' } ${not empty HireList.lowpay[1]?'checked':''}> --></td>
                                                            </tr>
                                                        </tbody></table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="2">
                                                    	<!-- <label><input type="checkbox" name="disabled_check" ${not empty HireContent.THC_DISABLED?'checked':''}></label>  -->장애인
                                                    </td>
                                                    <td><label for="n001">장애종별</label></td>
                                                    <td><label for="n002">등급</label></td>
                                                    <td><label for="n003">장애인 등록정보</label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    	<!-- <input type="text" id="n001" name="THC_DISABLED" ${empty Hire.THC_DISABLED?'readonly':''}" value="${Hire.THC_DISABLED }"> -->
                                                    	${not empty Hire.THC_DISABLED ? 'Hire.THC_DISABLED':' ' }
                                                    </td>
                                                    <td>
                                                    	<!-- <input type="text" id="n002" name="THC_DISABLED1" "${empty Hire.THC_DISABLED?'readonly':''}" value="${Hire.THC_DISABLED1 }"> -->
                                                    	${not empty Hire.THC_DISABLED1 ? 'Hire.THC_DISABLED1':' ' }
                                                    </td>
                                                    <td>
                                                    	<!-- <input type="text" id="n003" name="THC_DISABLED2" "${empty Hire.THC_DISABLED?'readonly':''}" value="${Hire.THC_DISABLED2 }"> -->
                                                    	${not empty Hire.THC_DISABLED2 ? 'Hire.THC_DISABLED2':' ' }
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="gab20"></div>

                    <div class="tab_tit">
                        <span class="bolder">교육사항</span>
                        <span class="small"><b>*</b> 지원직무 관련 과목 및 교육과정을 이수한 경우 그 내용을 기입해 주십시오.</span>
                    </div>
                    <div class="table_empl_in_box">
                        <table class="tbl_join_list border pd">
                            <caption>교육사항</caption>
                            <!-- <colgroup>
                                <col style="width: 33.33%;">
                                <col style="width: 33.33%;">
                                <col style="width: 16.33%;">
                                <col style="width: 16.33%;">
                            </colgroup> -->
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
		                                       <!--  <label><input type="radio" class="edutype" name="THC_EDUTYPE${status.index }" value="A" ${HireList.edutype[status.index] eq 'A' ? 'checked':''}> 학교교육</label>
		                                        <div class="gab-h-30"></div>
		                                        <label><input type="radio" class="edutype" name="THC_EDUTYPE${status.index }" value="B" ${HireList.edutype[status.index] eq 'B' ? 'checked':''}> 직업훈련</label>
		                                        <div class="gab-h-30"></div>
		                                        <label><input type="radio" class="edutype" name="THC_EDUTYPE${status.index }" value="C" ${HireList.edutype[status.index] eq 'C' ? 'checked':''}> 기타</label> -->
		                                        <c:choose>
		                                        	<c:when test="${HireList.edutype[status.index] eq 'A'}">학교교육</c:when>
		                                        	<c:when test="${HireList.edutype[status.index] eq 'B'}">직업훈련 </c:when>
		                                        	<c:when test="${HireList.edutype[status.index] eq 'C'}">기타 </c:when>
		                                        	<c:otherwise>선택안함</c:otherwise>	
		                                        </c:choose>
		                                    </td>
		                                    <td>
		                                        <!-- <input type="text" class="txt_pri w90" name="THC_EDUSUBJECT" value="${HireList.edusubject[status.index]}"> -->
		                                        ${HireList.edusubject[status.index]}
		                                    </td>
		                                    <td>
		                                        <!-- <input type="text" class="txt_pri w70 datepicker" name="THC_EDUSTARTTIME" data-dateformat="yy-mm-dd" value="${HireList.edustart[status.index]}" autocomplete="off"> -->
		                                        ${HireList.edustart[status.index]}
	<!-- 	                                        <button type="button" class="btn_pri purple calen" style="margin-left: -5px;" title="캘린더"><img src="/resources/img/sub/icon_join_calendar.png" alt=""></button> -->
		                                    </td>
		                                </tr>
									</c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="gab15"></div>

					<div class="employ_txtarea_box">
						<table class="ContentsTable">
							<thead class="Contentshead">
								<tr>
									<th>직무관련 주요내용</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="ContentsData"> <pre>- <c:out value="${Hire.THC_EDUDO }" escapeXml="true"/></pre></td>
								</tr>
							</tbody>
						</table>
						<%-- <div class="tit">
							<span class="bolder">직무관련 주요내용</span>
							<span class="txt"><span class="red-c"></span></span>
						</div>
             			 <pre class="ContentsData">- <c:out value="${Hire.THC_EDUDO }" escapeXml="true"/></pre> --%>
						<%-- <textarea name="THC_OTHERDO" rows="7" class="txtarea_emply">
							${Hire.THC_OTHERDO }
						</textarea> --%>
					</div>
					
					
                    <div class="tbl_bott_btn_box">
                    </div>

                    <div class="gab20"></div>

                    <div class="tab_tit">
                        <span class="bolder">자격사항</span>
                        <span class="small"><b>*</b> 지원직무 관련 국가기술/전문자격, 국가공인민간자격을 기입해 주십시오.</span>
                    </div>
                    <div class="table_empl_in_box">
                        <table class="tbl_join_list border pd">
                            <caption>자격사항</caption>
                            <!-- <colgroup>
                                <col style="width: 33.33%;">
                                <col style="width: 33.33%;">
                                <col style="width: 33.33%;">
                            </colgroup> -->
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
											<!-- <input type="text" class="txt_pri w60" name="THC_CERTIFICATE" value="${HireList.certificate[status.index]}"> -->
											${not empty HireList.certificate[status.index]?HireList.certificate[status.index]:'선택안함'}
	<!-- 										<button type="button" class="btn_pri purple" style="margin-left: -5px;" title="자격증검색">자격증검색</button> -->
	                                    </td>
	                                    <td>
	                                        <!-- <input type="text" class="txt_pri w90" name="THC_CERTIFICATEAGENCY" value="${HireList.certificateAgency[status.index]}"> -->
	                                        ${HireList.certificateAgency[status.index]}
	                                    </td>
	                                    <td>
	                                        <!-- <input type="text" class="txt_pri w70" name="THC_CERTIFICATETIME" value="${HireList.certificateTime[status.index]}"> -->
	                                        ${HireList.certificateTime[status.index]}
	                                    </td>
	                                </tr>
	                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="tbl_bott_btn_box">
                    </div>



                    <div class="gab20"></div>

                    <div class="tab_tit">
                        <span class="bolder">경력 혹은 경력사항</span>
                        <span class="small"><b>*</b> 지원직무 관련 경험 혹은 경력사항을 기입해 주십시오.</span>
                    </div>
                    <div class="table_empl_in_box ">
                        <table class="tbl_join_list border pd">
                            <caption>경력사항</caption>
                            <!-- <colgroup>
                                <col style="width: 15%;">
                                <col style="width: 15%;">
                                <col style="width: 15%;">
                                <col style="width: 17.5%;">
                                <col style="width: 17.5%;">
                                <col style="width: 35%;">
                            </colgroup> -->
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
											<!-- <label><input type="radio" class="careertype" name="THC_CAREERTYPE${status.index }" value="A" ${HireList.careertype[status.index] eq 'A' ? 'checked':'' }> 경험</label>
											<div class="gab-h-20"></div>
											<label><input type="radio" class="careertype" name="THC_CAREERTYPE${status.index }" value="B" ${HireList.careertype[status.index] eq 'B' ? 'checked':'' }> 경력</label> -->
 											<c:choose>
		                                        	<c:when test="${HireList.careertype[status.index] eq 'A'}">경험</c:when>
		                                        	<c:when test="${HireList.careertype[status.index] eq 'B'}">경력</c:when>
		                                        	<c:otherwise>선택안함</c:otherwise>	
		                                    </c:choose>
										</td>
	                                    <td>
											<!-- <input type="text" class="txt_pri w90" name="THC_CAREERAGENCY" value="${HireList.careerAgency[status.index]}"> -->
											${HireList.careerAgency[status.index]}
	                                    </td>
	                                    <td>
											<!-- <input type="text" class="txt_pri w90" name="THC_CAREERPOSITION" value="${HireList.careerPosition[status.index]}"> -->
											${HireList.careerPosition[status.index]}
	                                    </td>
	                                    <td>
											<!-- <input type="text" class="txt_pri w70" name="THC_CAREERSATRTTIME" value="${HireList.careerstart[status.index]}"> -->
											${HireList.careerstart[status.index]}
	<!--                                         <button type="button" class="btn_pri purple calen" style="margin-left: -5px;" title="캘린더"><img src="/resources/img/sub/icon_join_calendar.png" alt=""></button> -->
	                                    </td>
	                                    <td>
											<!-- <input type="text" class="txt_pri w70" name="THC_CAREERENDTIME" value="${HireList.careerend[status.index]}"> -->
											${HireList.careerend[status.index]}
	                                    </td>
										<td>
											<!-- <input type="text" class="txt_pri w90" name="THC_CAREERDO" value="${HireList.careerdo[status.index]}"> -->
											${HireList.careerdo[status.index]}
										</td>
	                                </tr>
	                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

					<div class="gab15"></div>
					
					<div class="employ_txtarea_box">	
						<table class="ContentsTable">
							<thead class="Contentshead">
								<tr>
									<th>
										<p>직무관련 주요내용</p>
										<span class="txt"><span class="red-c">*</span> 직무활동, 동아리/동호회, 팀프로젝트, 연구회, 재능기부 등 주요 직무경험을 서술하여 주십시오.</span>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="ContentsData"> <pre><c:out value="${Hire.THC_OTHERDO }" escapeXml="true"/></pre></td>
								</tr>
							</tbody>
						</table>
					</div>
						
					<%-- <div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">직무관련 주요내용</span>
							<span class="txt"><span class="red-c">*</span> 직무활동, 동아리/동호회, 팀프로젝트, 연구회, 재능기부 등 주요 직무경험을 서술하여 주십시오.</span>
						</div>
						<pre class="ContentsData">- <c:out value="${Hire.THC_OTHERDO }" escapeXml="true"/></pre>
						 
						<textarea name="THC_OTHERDO" rows="7" class="txtarea_emply">
							${Hire.THC_OTHERDO }
						</textarea>
					</div> --%>

                    <div class="gab20"></div>

                </div><!-- // 입사지원서 -->

				<div class="employ_tab2_ul_con two"> <!-- 자기소개 -->
					<div class="tab_tit">
						<span class="bolder">자기소개서</span>
					</div>

					<div class="gab20"></div>
					
						<div class="employ_txtarea_box">
							<table class="ContentsTable">
								<thead class="Contentshead">
									<tr>
										<th>해당 직무에 지원하게 된 동기와 본인이 직무를 잘 수행할 수 있는 이유 (본인의 강점, 준비 관련 경험에 근거)가 무엇인지 기술해 주십시오.</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="ContentsData"> <pre class="">- <c:out value="${Hire.THC_CONTENT1}" escapeXml="true"/></pre></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="gab20"></div>
						
						<div class="employ_txtarea_box">
							<table class="ContentsTable">
								<thead class="Contentshead">
									<tr>
										<th>본인의 경험 중 지원한 직무와 관련하여 가장 특별하고 인상 깊었던 경험에 대해 구체적으로 기술해 주십시오.</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="ContentsData"><pre class=""> <c:out value="${Hire.THC_CONTENT2}" escapeXml="true"></c:out></pre> </td>
									</tr>
								</tbody>
							</table>
						</div>
					<div class="gab20"></div>
					<div class="employ_txtarea_box">
						<table class="ContentsTable">
							<thead class="Contentshead">
								<tr>
									<th>예상치 못했던 문제의 발생으로 계획대로 일이 진행되지 않았을 때, 책임감을 가지고 적극적으로 문제를 해결한 경험과 그 경험을 통해 얻은 것은 무엇인지 구체적으로 기술해 주십시오.</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="ContentsData"> <pre class=""> <c:out value="${Hire.THC_CONTENT3}" escapeXml="true"/></pre> </td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<table class="ContentsTable">
							<thead class="Contentshead">
								<tr>
									<th>공동의 목표를 달성하기 위해 타인과 협업했던 경험과 그 과정에서 본인이 수행한 역할, 그리고 해당 경험을 통해 얻은 것은 무엇인지 구체적으로 기술해 주십시오.</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="ContentsData"> <pre class=""> <c:out value="${Hire.THC_CONTENT4}" escapeXml="true"/></pre> </td>
								</tr>
							</tbody>
						</table>
					</div>
					<%-- <div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">해당 직무에 지원하게 된 동기와 본인이 직무를 잘 수행할 수 있는 이유 (본인의 강점, 준비 관련 경험에 근거)가 무엇인지 기술해 주십시오.</span>
						</div>
						<pre class="ContentsData">- <c:out value="${Hire.THC_CONTENT1}" escapeXml="true"/></pre>
					</div>
 --%>

					<%-- <div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">본인의 경험 중 지원한 직무와 관련하여 가장 특별하고 인상 깊었던 경험에 대해 구체적으로 기술해 주십시오.</span>
						</div>
						<pre class="ContentsData">- <c:out value="${Hire.THC_CONTENT2}" escapeXml="true"></c:out></pre>
					</div> --%>


					<%-- <div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">예상치 못했던 문제의 발생으로 계획대로 일이 진행되지 않았을 때, 책임감을 가지고 적극적으로 문제를 해결한 경험과 그 경험을 통해 얻은 것은 무엇인지 구체적으로 기술해 주십시오.</span>
						</div>
						<pre class="ContentsData">- <c:out value="${Hire.THC_CONTENT3}" escapeXml="true"/></pre>
					</div> --%>


					<%-- <div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<div class="tit">
							<span class="bolder">공동의 목표를 달성하기 위해 타인과 협업했던 경험과 그 과정에서 본인이 수행한 역할, 그리고 해당 경험을 통해 얻은 것은 무엇인지 구체적으로 기술해 주십시오.</span>
						</div>
						<pre class="ContentsData">- <c:out value="${Hire.THC_CONTENT4}" escapeXml="true"/></pre>
					</div>


                    <div class="gab20"></div>
                    
                    <div class="textC">
                    </div> --%>

                </div><!-- // 자기소개 -->


				<c:if test="${Hire.TH_TYPE eq 'U' }">
				<div class="employ_tab2_ul_con three"> <!-- 직무수행계획소 -->
					
					
					<div class="employ_txtarea_box">
						<table class="ContentsTable">
							<thead class="Contentshead">
								<tr>
									<th>서론(동향 및 전망 등)</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="ContentsData"> <pre class="ContentsData"><c:out value="${Hire.THC_UNYOUNG1}" escapeXml="true"/></pre> </td>
								</tr>
							</tbody>
						</table>
						
						<%-- <div class="tit">
							<span class="bolder">서론(동향 및 전망 등)</span>
						</div>
						<pre class="ContentsData"><c:out value="${Hire.THC_UNYOUNG1}" escapeXml="true"/></pre> --%>
					</div>
					
					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<table class="ContentsTable">
							<thead class="Contentshead">
								<tr>
									<th>비전 및 목표</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="ContentsData"> <pre class="ContentsData"><c:out value="${Hire.THC_UNYOUNG2}" escapeXml="true"/></pre> </td>
								</tr>
							</tbody>
						</table>
						<%-- <div class="tit">
							<span class="bolder">비전 및 목표</span>
						</div>
						<pre class="ContentsData"><c:out value="${Hire.THC_UNYOUNG2}" escapeXml="true"/></pre> --%>
					</div>
					
					
					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<table class="ContentsTable">
							<thead class="Contentshead">
								<tr>
									<th>추진방법</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="ContentsData"> <pre class="ContentsData"><c:out value="${Hire.THC_UNYOUNG3}" escapeXml="true"/></pre> </td>
								</tr>
							</tbody>
						</table>
						
						
						<%-- <div class="tit">
							<span class="bolder">추진방법</span>
						</div>
						<pre class="ContentsData"><c:out value="${Hire.THC_UNYOUNG3}" escapeXml="true"/></pre> --%>
					</div>
					
					
					<div class="gab20"></div>
					
					<div class="employ_txtarea_box">
						<table class="ContentsTable">
							<thead class="Contentshead">
								<tr>
									<th>추진일정</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="ContentsData"> <pre class="ContentsData"><c:out value="${Hire.THC_UNYOUNG4}" escapeXml="true"/></pre> </td>
								</tr>
							</tbody>
						</table>
						<%-- <div class="tit">
							<span class="bolder">추진일정</span>
						</div>
						<pre class="ContentsData"><c:out value="${Hire.THC_UNYOUNG4}" escapeXml="true"/></pre> --%>
					</div>

					<div class="gab20"></div>

					<div class="tab_tit">
						<span class="bolder">직무 세부추진 계획</span>
					</div>
					<div class="table_empl_in_box ">
						<table class="tbl_join_list border pd">
							<caption>직무 세부추진 계획</caption>
							<!-- <colgroup>
								<col style="width: 28%;">
								<col style="width: 44%;">
								<col style="width: 28%;">
							</colgroup> -->
							<thead>
								<tr>
									<th>업무분야</th>
									<th>세부추진계획 (추진방법 등)</th>
									<th>평가지표</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach begin="0" end="${not empty HireList.unyoun5?fn:length(HireList.unyoun5)-1:2}" varStatus="status">
								<tr>
									<td>
										<pre class="ContentsData"><c:out value="${HireList.unyoun5[status.index]}" escapeXml="true"/></pre>
									</td>
									<td>
										<pre class="ContentsData"><c:out value="${HireList.unyoun6[status.index]}" escapeXml="true"/></pre>
									</td>
									<td>
										<pre class="ContentsData"><c:out value="${HireList.unyoun7[status.index]}" escapeXml="true"/></pre>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					
					<div class="gab20"></div>

                    <div class="textC">
                    </div>
                </div><!-- // 직무수행계획소 -->
				</c:if>

		</div> <!--inner 끝 -->
	</section>
