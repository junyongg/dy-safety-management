<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<form:form id="newsForm" name="newsForm" commandName="news" method="POST">
	<table id="expert_table1">
		<tbody>
			<tr>
				<th><label for="NL_NAME"><spring:message code="news.name" /></label></th>
				<td colspan="3">
					<input type="text" name="NL_NAME" maxlength="10"/>
					<br/>
					<span style="font-size: 12px; color: red;"><form:errors path="NL_NAME"/></span>
				</td>
			</tr>
			<tr>
				<th><label for="NL_POSITION"><spring:message code="news.position" /></label></th>
				<td colspan="3">
					<input type="text" name="NL_POSITION" maxlength="25"/>
					<br/>
					<span style="font-size: 12px; color: red;"><form:errors path="NL_POSITION"/></span>
				</td>
			</tr>
			<tr>
				<th><label for="NL_BELONG"><spring:message code="news.belong" /></label></th>
				<td colspan="3">
					<input type="text" name="NL_BELONG" maxlength="50"/>
					<br/>
					<span style="font-size: 12px; color: red;"><form:errors path="NL_BELONG"/></span>
				</td>
			</tr>
			<tr>
				<th><label for="NL_EMAIL"><spring:message code="news.email" /></label></th>
				<td colspan="3">
					<input type="text" name="NL_EMAIL" maxlength="50"/>
					<br/><span style="font-size: 12px;">- 신청확인, 본인확인 등을 위한 중요 사항이오니 정확히 기재하시기 바랍니다.</span>
					<br/><span style="font-size: 12px; color: red;"><form:errors path="NL_EMAIL" /></span>
				</td>
			</tr>
		</tbody>
	</table>
	
</form:form>

<button type="button" onclick="pf_insert();">신청하기</button>
<button type="button" onclick="pf_close();">취소</button>

<script>
function pf_insert(){
	if(confirm("등록하시겠습니까?")){
		frm = document.newsForm;
	   	frm.action = "<c:url value='/jcia/news/newsInsert.do'/>";
	    frm.submit();
	}
}

function pf_close(){
	window.open("about:blank","_self").close();
}
</script>