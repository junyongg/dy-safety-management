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
</style>

<form:form name="form" id="form" action="/hire/FileinsertAll.do?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data" method="post" onsubmit="return InsertFile();">
<input type="hidden" name="TH_KEYNO" value="${hire.TH_KEYNO }">
<input type="hidden" name="TH_FILE" value="${hire.TH_FILE }">
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
                    <tbody id="fileList">
                         <tr>
                            <th><label for="file1">주민등록초본 1부</label>
                            	<br><span class="subcontents">(병역사항포함)</span>
                            </th>
                            <td class="txt">
                            	<input type="file" class="file_join" id="file1" name="file"><span class="spans"> - ${empty fileT.get(0)?'선택된 파일이 없습니다.':fileT.get(0) }</span>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="file2">기본증명서</label></th>
                            <td class="txt"><input type="file" class="file_join" id="file2" name="file"><span class="spans"> - ${empty fileT.get(1)?'선택된 파일이 없습니다.':fileT.get(1) }</span></td>
                        </tr>
                        <tr>
                            <th><label for="file3">증명사진</label></th>
                            <td class="txt"><input type="file" class="file_join" id="file3" name="file"><span class="spans"> - ${empty fileT.get(2)?'선택된 파일이 없습니다.':fileT.get(2) }</span></td>
                        </tr>
                        <tr>
                            <th><label for="file4">교육이수확인증</label></th>
                            <td class="txt"><input type="file" class="file_join" id="file4" name="file"><span class="spans"> - ${empty fileT.get(3)?'선택된 파일이 없습니다.':fileT.get(3) }</span></td>
                        </tr>
                        <tr>
                            <th><label for="file5">경력증명서 1부</label>
                            <br><span class="subcontents">(근무부서,직무,최종직위,직급,근무기간명기)</span></th>
                            <td class="txt"><input type="file" class="file_join" id="file5" name="file"><span class="spans"> - ${empty fileT.get(4)?'선택된 파일이 없습니다.':fileT.get(4) }</span></td>
                        </tr>
                        <tr>
                            <th><label for="file6">건강보험 자격득실 확인서 1부</label>
                            		<br><span class="subcontents">※경력입증은 경력증명서 근무기간과 국민건강보험 자격득실 확인서상의 근무기간이 다를 경우 건강보험자격득실확인서상의 근무기간을 적용</span>
                            </th>
                            <td class="txt"><input type="file" class="file_join" id="file6" name=file><span class="spans"> -  ${empty fileT.get(5)?'선택된 파일이 없습니다.':fileT.get(5) }</span></td>
                        </tr>
                        <tr>
                            <th><label for="file7">직무관련자격증 사본</label></th>
                            <td class="txt"><input type="file" class="file_join" id="file7" name="file"><span class="spans"> - ${empty fileT.get(6)?'선택된 파일이 없습니다.':fileT.get(6) } </span></td>
                        </tr>
                        <tr>
                            <th><label for="file8">기타 증빙자료</label><br><span class="subcontents">(취업지원대상자증명서,국민기초수급자증명서,장애인복지카드 등)</span></th>
                            <td class="txt"><input type="file" class="file_join" id="file8" name="file"><span class="spans"> - ${empty fileT.get(7)?'선택된 파일이 없습니다.':fileT.get(7) }</span></td>
                        </tr>
                        <c:if test="${fn:length(fileT) > 8}">
	                        <c:forEach begin="8" end="${fn:length(fileT)-1}" var="c">
	 							<tr>
		                            <th><label for="file${c }">추가 파일</label></th>
		                            <td class="txt"><input type="file" class="file_join" id="file${c }" name="file"><span class="spans"> - ${empty fileT.get(c)?'선택된 파일이 없습니다.':fileT.get(c) }</span></td>
		                        </tr>	                       
	                        </c:forEach>
                        </c:if>
                    </tbody>
                </table>

                <div class="gab50"></div>

                <div class="textC">
                    <button type="submit" class="btn_support purple" title="파일 제출">파일 제출</button>
					<button type="button" class="btn_support gray" onclick="FilePlus();" title="파일 추가">파일 추가</button>
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

var cnt = ('${fn:length(fileT)}'>8)?'${fn:length(fileT)}':9;
function FilePlus(){
	
	var html = "";
 	html += '<tr>';
	html += '<th><label for="file'+ cnt +'">추가 파일</label></th>';
	html += '<td class="txt"><input type="file" class="file_join" id="file'+cnt+'" name="file"><span class="spans">';
	html += '</span></td>';
	html += '</tr>';
			
	$("#fileList").append(html);
	cnt++;
}
</script>
