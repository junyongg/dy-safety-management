<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<link type="text/css" rel="stylesheet" href="/resources/jcia/css/board.css">

<jsp:useBean id="toDay" class="java.util.Date" scope="page"/>
<fmt:formatDate value="${toDay}" pattern="yyyy-MM" var="nowDate" />

<form:form id="Form" name="Form" method="post">
	<input type="hidden" name="PageIndex" id="PageIndex" value="${paginationInfo.currentPageNo}" />
	<input type="hidden" name="NM_KEYNO" id="NM_KEYNO" value="" />
	<!-- 본문 시작 -->
	<div class="subContentInner">
	    <div class="boardTopWrap">
	    	<div class="boardCountBox">
	        	<p class="board_count">총 <span><fmt:formatNumber value="${paginationInfo.totalRecordCount }" pattern="#,###" /></span>개의 게시물이 있습니다.</p>
	        </div>
	        
		     <div class="searchBox">
	        	<label for="searchCondition" class="labelSearch">검색</label>
	            <select class="selectDefault searchSelect" title="검색 할 내용 선택" id="searchCondition" name="searchCondition"  >
					<option value="year">연도</option>
					<option value="month">월</option>
					<option value="ho">호</option>
	            </select>
	            <label for="searchKeyword" class="blind">검색어를 입력해주세요</label>
	            <input type="text" class=" txtDefault txtSearch" id="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어를 입력해주세요" name="searchKeyword" onkeydown="if(event.keyCode == 13) pf_boardSearch();">
	            <button type="button" class="btnDefault btnSizeSearch btnBgBlue"  onclick="pf_boardSearch()">검색</button>
	        </div>
	    </div>  
	    
	    <div class="tblBoardBox">
	         <table class="tbl_Board_01 tbl_Board_notice tbl_newsLetter" summary="뉴스레터 게시판 리스트">
	             <caption>뉴스레터 게시판</caption>
	             <thead></thead>
	             <tbody>
	             	<c:forEach items="${NewsLetterList }" var="model">
	             	<fmt:parseNumber value="${fn:substring(model.NM_KEYNO,4,20) }" var="newsKey"/>
	             	<c:set value="${fn:substring(model.REGDT,0,7) }" var="month"/>
	             		<tr>
		                 	<td class="number">
 		                 		<c:if test="${month eq nowDate }">
 			                 		<span class="notice">NEW</span> 
 		                 		</c:if> 
 		                 		<c:if test="${month ne nowDate }">
		                 			<c:out value="${model.count }" />
		                 		</c:if>
		                 	</td>
		                    <td class="boardSubject"><a href="javascript:;" onclick="pf_DetailMove('${newsKey}')"><c:out value="${model.NM_TITLE }" /> (<c:out value="${model.NM_YEAR }" />.<fmt:formatNumber value="${model.NM_MONTH }" minIntegerDigits="2" type="number"/>. Vol.<c:out value="${model.NM_NUMBERING }" />)</a></td>
		                 	<td class="date"><c:out value="${model.REGDT }" /></td>
		                 	<td class="count"><c:out value="${model.NM_HITS }" /></td>
		                 </tr>
	             	</c:forEach>
	             </tbody>
	             <tfoot></tfoot>
	     	</table>
	   	</div>
	    <c:if test="${userInfo.isAdmin eq 'Y' }">
		    <div class="boardBtnBox"> <!-- 문의하기 글쓰기 버튼 -->
		        	<button type="button" class="btnBoard_01" onclick="pf_RegistMove()">글쓰기</button>
		    </div>
	    </c:if>
	    <div class="pageNumberBox">
	        <ul class="pageNumberUl">
	           <ui:pagination paginationInfo="${paginationInfo }" type="normal_board" jsFunction="pf_LinkPage" />
	        </ul>
	    </div>
	</div>
	<!-- 본문 끝 -->
</form:form>

<script>
$(function(){
	var searchCondition ='${BoardNotice.searchCondition}'
	if(searchCondition){
		$('#searchCondition').val('${BoardNotice.searchCondition}');
		$('#searchKeyword').val("${BoardNotice.searchKeyword}");
		$('#orderCondition').val('${BoardNotice.orderCondition}');
	}
	/* if(keywordList){
		$('#searchKeyword').autocomplete({
			source: keywordList,
			focus: function( event, ui ) {
				return false; 
			}
		});
	} */
	
})
//페이지 이동
function pf_LinkPage(num){
	$('#PageIndex').val(num);
	$('#Form').attr('action',location.pathname)
	$('#Form').submit();
}

//검색
function pf_boardSearch(){
	$('#PageIndex').val(1);
	$('#Form').attr('action','/jcia/information/newsletter.do');
	$('#Form').submit();
}

//글쓰기
function pf_RegistMove() {
	var write = '${boardAuthList.write}';
	if(write == 'false'){
		if(!cf_checkLogin()){
			return false;
		}
		alert('글쓰기 권한이 없습니다. 관리자한테 문의하세요.');
		return false;
	}
	$("#Form").attr("action", "/jcia/information/newsletter/insertView.do");
	$("#Form").submit();
}

//상세보기
function pf_DetailMove(keyno){
	$("#NM_KEYNO").val(keyno);
	$('#Form').attr('action','/jcia/information/newsletter/'+keyno+'/detail.do');
	$('#Form').submit();
}
</script>