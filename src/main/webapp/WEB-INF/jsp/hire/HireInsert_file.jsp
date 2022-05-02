<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<style>
	.file_join{
		width: 33%;
	}
	.spans{
		padding: 5px;
	}
	
	.subcontents{
	    font-size: 10px;
	    font-weight: 800;
	    color: gray;
	}
	.plus{
		float: right;
	}
	
	.plustr{
		background-color:white !important;
	}
</style>

<form:form name="form" id="form" action="/hire/Fileinsert2.do?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data" method="post" onsubmit="return InsertFile();">
<input type="hidden" name="TH_KEYNO" value="${hire.TH_KEYNO }">
<input type="hidden" name="TH_FILE1" value="${hire.TH_FILE1 }">
<input type="hidden" name="TH_FILE2" value="${hire.TH_FILE2 }">
<input type="hidden" name="TH_FILE3" value="${hire.TH_FILE3 }">
<input type="hidden" name="TH_FILE4" value="${hire.TH_FILE4 }">
<input type="hidden" name="TH_FILE5" value="${hire.TH_FILE5 }">
<input type="hidden" name="TH_FILE6" value="${hire.TH_FILE6 }">
<input type="hidden" name="TH_FILE7" value="${hire.TH_FILE7 }">
<input type="hidden" name="TH_FILE8" value="${hire.TH_FILE8 }">
<section id="sub-content">
        <div class="inner1200"> <!--inner 시작 -->
			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

                <!-- 첨부파일 -->
                <table class="tbl_join_list verti">
                    <colgroup>
                        <col style="width: 20%;">
                        <col style="width: 80%;">
                    </colgroup>
                    <caption>입사지원현황</caption>
                    <tbody>
                         <tr class="FileTr1">
                            <th><label for="file1">주민등록초본</label>
                            	<br><span class="subcontents">(병역사항포함)</span>
                            </th>
                            <td class="txt">
                            	<input type="file" class="file_join" id="file1" name="file1"><span class="spans">- ${empty fileT1.get(0)?'선택된 파일이 없습니다.':fileT1.get(0) }</span>
                            	<button type="button" class="plus btn-e-sum1" onclick="FilePlus(1);">
									<i class="xi-plus"></i>
								</button>
                            </td>
                        </tr>
                        <c:if test="${fn:length(fileT1) > 1 }">
	                        <c:forEach begin="1" end="${fn:length(fileT1)-1}" var="c">
	                        	<tr class="FileTr1">
									<th class="plustr">추가파일</th>
 										<td class="txt">
											<input type="file" class="file_join" name="file1"><span class="spans">- ${fileT1.get(c) }</span>
												<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">
													<i class="xi-minus"></i>
												</button>
										</td>
								</tr>	
	                        </c:forEach>
                        </c:if>
                        
                        <tr class="FileTr2">
                            <th><label for="file2">기본증명서</label></th>
                            <td class="txt"><input type="file" class="file_join" id="file2" name="file2"><span class="spans">- ${empty fileT2.get(0)?'선택된 파일이 없습니다.':fileT2.get(0) }</span>
                            	<button type="button" class="plus btn-e-sum1" onclick="FilePlus(2);">
									<i class="xi-plus"></i>
								</button>
                            </td>
                        </tr>
                        
                        <c:if test="${fn:length(fileT2) > 1 }">
	                        <c:forEach begin="1" end="${fn:length(fileT2)-1}" var="c">
	                        	<tr>
									<th class="plustr">추가파일</th>
 										<td class="txt">
											<input type="file" class="file_join" name="file2"><span class="spans">- ${fileT2.get(c) }</span>
												<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">
													<i class="xi-minus"></i>
												</button>
										</td>
								</tr>	
	                        </c:forEach>
                        </c:if>
                        
                        <tr class="FileTr3">
                            <th><label for="file3">증명사진</label></th>
                            <td class="txt"><input type="file" class="file_join" id="file3" name="file3"><span class="spans">- ${empty fileT3.get(0)?'선택된 파일이 없습니다.':fileT3.get(0) }</span>
                            	<button type="button" class="plus btn-e-sum1" onclick="FilePlus(3);">
									<i class="xi-plus"></i>
								</button>
                            </td>
                        </tr>
                        
                        <c:if test="${fn:length(fileT3) > 1 }">
	                        <c:forEach begin="1" end="${fn:length(fileT3)-1}" var="c">
	                        	<tr>
									<th class="plustr">추가파일</th>
 										<td class="txt">
											<input type="file" class="file_join" name="file3"><span class="spans">- ${fileT3.get(c) }</span>
												<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">
													<i class="xi-minus"></i>
												</button>
										</td>
								</tr>	
	                        </c:forEach>
                        </c:if>
                        <tr class="FileTr4">
                            <th><label for="file4">교육이수확인증</label></th>
                            <td class="txt"><input type="file" class="file_join" id="file4" name="file4"><span class="spans">- ${empty fileT4.get(0)?'선택된 파일이 없습니다.':fileT4.get(0) } </span>
                            	<button type="button" class="plus btn-e-sum1" onclick="FilePlus(4);">
									<i class="xi-plus"></i>
								</button>
                            </td>
                        </tr>
                        
                        <c:if test="${fn:length(fileT4) > 1 }">
	                        <c:forEach begin="1" end="${fn:length(fileT4)-1}" var="c">
	                        	<tr>
									<th class="plustr">추가파일</th>
 										<td class="txt">
											<input type="file" class="file_join" name="file4"><span class="spans">- ${fileT4.get(c) }</span>
												<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">
													<i class="xi-minus"></i>
												</button>
										</td>
								</tr>	
	                        </c:forEach>
                        </c:if>
                        <tr class="FileTr5">
                            <th><label for="file5">경력증명서 </label>
                            <br><span class="subcontents">(근무부서,직무,최종직위,직급,근무기간명기)</span></th>
                            <td class="txt"><input type="file" class="file_join" id="file5" name="file5"><span class="spans">- ${empty fileT5.get(0)?'선택된 파일이 없습니다.':fileT5.get(0) } </span>
                            	<button type="button" class="plus btn-e-sum1" onclick="FilePlus(5);">
									<i class="xi-plus"></i>
								</button>
                            </td>
                        </tr>
                        
                        <c:if test="${fn:length(fileT5) > 1 }">
	                        <c:forEach begin="1" end="${fn:length(fileT5)-1}" var="c">
	                        	<tr>
									<th class="plustr">추가파일</th>
 										<td class="txt">
											<input type="file" class="file_join" name="file5"><span class="spans">- ${fileT5.get(c) }</span>
												<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">
													<i class="xi-minus"></i>
												</button>
										</td>
								</tr>	
	                        </c:forEach>
                        </c:if>
                        <tr class="FileTr6">
                            <th><label for="file6">건강보험 자격득실 확인서 </label>
                            		<br><span class="subcontents">※경력입증은 경력증명서 근무기간과 국민건강보험 자격득실 확인서상의 근무기간이 다를 경우 건강보험자격득실확인서상의 근무기간을 적용</span>
                            </th>
                            <td class="txt"><input type="file" class="file_join" id="file6" name="file6"><span class="spans">- ${empty fileT6.get(0)?'선택된 파일이 없습니다.':fileT6.get(0) } </span>
                            	<button type="button" class="plus btn-e-sum1" onclick="FilePlus(6);">
									<i class="xi-plus"></i>
								</button>
                            </td>
                        </tr>
                        
                        <c:if test="${fn:length(fileT6) > 1 }">
	                        <c:forEach begin="1" end="${fn:length(fileT6)-1}" var="c">
	                        	<tr>
									<th class="plustr">추가파일</th>
 										<td class="txt">
											<input type="file" class="file_join" name="file6"><span class="spans">- ${fileT6.get(c) }</span>
												<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">
													<i class="xi-minus"></i>
												</button>
										</td>
								</tr>	
	                        </c:forEach>
                        </c:if>
                        <tr class="FileTr7">
                            <th><label for="file7">직무관련자격증 사본</label></th>
                            <td class="txt"><input type="file" class="file_join" id="file7" name="file7"><span class="spans"> - ${empty fileT7.get(0)?'선택된 파일이 없습니다.':fileT7.get(0) } </span>
                            	<button type="button" class="plus btn-e-sum1" onclick="FilePlus(7);">
									<i class="xi-plus"></i>
								</button>
                            </td>
                        </tr>
                        
                        <c:if test="${fn:length(fileT7) > 1 }">
	                        <c:forEach begin="1" end="${fn:length(fileT7)-1}" var="c">
	                        	<tr>
									<th class="plustr">추가파일</th>
 										<td class="txt">
											<input type="file" class="file_join" name="file7"><span class="spans">- ${fileT7.get(c) }</span>
												<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">
													<i class="xi-minus"></i>
												</button>
										</td>
								</tr>	
	                        </c:forEach>
                        </c:if>
                        <tr class="FileTr8">
                            <th><label for="file8">기타 증빙자료</label><br><span class="subcontents">(취업지원대상자증명서,국민기초수급자증명서,장애인복지카드 등)</span></th>
                            <td class="txt"><input type="file" class="file_join" id="file8" name="file8"><span class="spans">- ${empty fileT8.get(0)?'선택된 파일이 없습니다.':fileT8.get(0) }</span>
                            	<button type="button" class="plus btn-e-sum1" onclick="FilePlus(8);">
									<i class="xi-plus"></i>
								</button>
                            </td>
                        </tr>
                        
                        <c:if test="${fn:length(fileT8) > 1 }">
	                        <c:forEach begin="1" end="${fn:length(fileT8)-1}" var="c">
	                        	<tr>
									<th class="plustr">추가파일</th>
 										<td class="txt">
											<input type="file" class="file_join" name="file8"><span class="spans">- ${fileT8.get(c) }</span>
												<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">
													<i class="xi-minus"></i>
												</button>
										</td>
								</tr>	
	                        </c:forEach>
                        </c:if>
                        <!-- <c:if test="${fn:length(fileT) > 8}">
	                        <c:forEach begin="8" end="${fn:length(fileT)-1}" var="c">
	 							<tr>
		                            <th><label for="file${c }">추가 파일</label></th>
		                            <td class="txt"><input type="file" class="file_join" id="file${c }" name="file"><span class="spans"> </span></td>
		                        </tr>	                       
	                        </c:forEach>
                        </c:if> -->
                    </tbody>
                </table>

                <div class="gab50"></div>

                <div class="textC">
                    <button type="submit" class="btn_support purple" title="파일 제출">파일 제출</button>
					<!-- <button type="button" class="btn_support gray" onclick="FilePlus();" title="파일 추가">파일 추가</button> -->
                    <button type="button" class="btn_support gray" onclick="window.location.reload();" title="새로 고침">새로 고침</button>
                </div>
                <!-- // 첨부파일 -->

			</div>

		</div> <!--inner 끝 -->
	</section>
</form:form>

<script>
function InsertFile(){
	if(!confirm("파일을 제출 하시겠습니까?")){
		return false
	}
}

/*var cnt = ('${fn:length(fileT)}'>8)?'${fn:length(fileT)}':9;*/
function FilePlus(cnt){
	
	var html = "";
	html += '<tr class="FileTr'+cnt+'">';
	html += '<th class="plustr"><label for="file7">추가파일</label></th>';
 	html += '<td class="txt">';
    html += 	'<input type="file" class="file_join" name="file'+cnt+'"><span class="spans"></span>';
    html += 	'<button type="button" class="plus btn-e-sum1" onclick="FileDelete(this);">';
    html += 	'<i class="xi-minus"></i>';
    html += 	'</button>';
    html += '</td>';
    html += '</tr>';		
	$(".FileTr"+cnt).last().after(html);
}


function FileDelete(obj){
	 var tr = $(obj).parent().parent();
	 
	    //라인 삭제
	    tr.remove();
}
</script>
