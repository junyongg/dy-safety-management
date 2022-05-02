<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<link type="text/css" rel="stylesheet" href="/resources/jcia/css/board.css">
<script>
//뒤로가기
function pf_back(){
	location.href="${mirrorPage }";
}

function pf_newsUpDel(key, type){
	var write = '${boardAuthList.write}';
	if(write == 'false'){
		if(!cf_checkLogin()){
			return false;
		}
		alert('권한이 없습니다. 관리자한테 문의하세요.');
		return false;
	}
	if(type == "D"){
		if(confirm("삭제하시겠습니까?")){
			location.href="/jcia/information/newsletter/newsDelete.do?key="+key;
		}		
	}else if(type == "U"){
		location.href="/jcia/information/newsletter/newsUpdatePage.do?key="+key;
	}
}
</script>
<form:form id="newsForm" method="POST">
<!-- 본문 시작 -->
      <div class="subContentInner">
          <div class="detailViewWrap"> <!-- 상세보기 시작 -->
              <div class="detail_titleBox"><!-- 타이틀 제목 -->
              	<h2>
              	<c:set var="now" value="<%=new java.util.Date() %>"/>
              	<c:set  var="today"><fmt:formatDate value='${now}' pattern='yyyy-MM-dd' /></c:set>
              	<c:if test="${BoardNotice.BN_IMPORTANT eq 'Y' && BoardNotice.BN_IMPORTANT_DATE >= today}">
               	<span class="notice">공지</span>
              	</c:if>
              	<c:out value="${resultData.NM_TITLE}" escapeXml="true"/>(<c:out value="${resultData.NM_YEAR }" />.<fmt:formatNumber value="${resultData.NM_MONTH }" minIntegerDigits="2" type="number"/>. Vol.<c:out value="${resultData.NM_NUMBERING }" />)
              	</h2>
              </div>
              <div class="detail_infoBox"> <!-- 게시판 정보 -->
              	<ul class="board_infoUl">
                  	<li>
                      	<span class="subJ">등록자</span> <c:out value="${resultData.UI_NAME }"/>
                      </li>
                  	<li>
                      	<span class="subJ">등록일</span> <c:out value="${resultData.REGDT }"/>
                      </li>
                  	<li>
                      	<span class="subJ">조회수</span> <c:out value="${resultData.NM_HITS }"/>
                      </li>
                  </ul>
              </div>
              
              <div class="datail_ContentBox" style="text-align: center;"> <!-- 컨텐츠 내용 -->
              	
                  <div class="textC">
                  	<p><c:out value="${resultData.NM_CONTENT }" escapeXml="false"/></p>
                  </div>
                  
              </div>
              
              <div class="btnUploadBox">
               	<fmt:parseNumber value="${fn:substring(resultData.NM_KEYNO, 4, 20)}" var="NM_KEYNO_NUMBERTYPE" />
               	<c:if test="${userInfo.isAdmin eq 'Y'}">
				<button class="btnDefault bg_gray_01 btnSizeM_3" type="button" onclick="pf_newsUpDel('${NM_KEYNO_NUMBERTYPE}', 'U')">
						수정
				</button>
				<button class="btnDefault bg_gray_01 btnSizeM_3" type="button" onclick="pf_newsUpDel('${NM_KEYNO_NUMBERTYPE}', 'D')">
					삭제
				</button>
				</c:if>
              </div> 
          	
              <div class="detial_middleBtnBox"> <!-- 중간 목록보기 박스 -->
              	<button type="button" class="btnBoardList" onclick="pf_back()">목록보기 <i class="fal fa-bars"></i></button>
              </div>
              
              <%-- <div class="detail_nextPostBox"> <!-- 이전글 다음글 박스 -->
              	<table class="tbl_next_Prev">
                  	<colgroup>
                      	<col width="15%">
                      	<col width="85%">
                      </colgroup>
                      <caption>이전글 다음글</caption>
                      <tbody>
                      	<tr>
                          	<c:if test="${not empty nextBoardNotice }">
				    		<fmt:parseNumber value="${fn:substring(nextBoardNotice.BN_KEYNO,5,20)}" var="numberType" />
				    		<th>다음글</th>
				    		<td><a href="${tilesUrl}/Board/${numberType }/detailView.do"><c:out value="${nextBoardNotice.BN_TITLE }" escapeXml="true" ></c:out></a></td>
				            </c:if>
				                          	<c:if test="${empty nextBoardNotice }">
				    		<th>다음글</th>
				    		<td><a href="javascript:;">다음글이 없습니다.</a></td>
				            </c:if>
				        </tr>
				        <tr>
				            <c:if test="${not empty prevBoardNotice }">
				            <fmt:parseNumber value="${fn:substring(prevBoardNotice.BN_KEYNO,5,20)}" var="numberType" />
				            <th>이전글</th>
				            <td><a href="${tilesUrl}/Board/${numberType }/detailView.do"><c:out value="${prevBoardNotice.BN_TITLE }" escapeXml="true" ></c:out></a></td>
				            </c:if>
				            <c:if test="${ empty prevBoardNotice }">
				            <th>이전글</th>
				            <td><a href="javascript:;">이전글이 없습니다.</a></td>
				            </c:if>
                          </tr>
                      </tbody>
                  </table>
              </div> --%>
              
          
         </div> <!-- 상세보기 끝 -->
     </div>
     <!-- 본문 끝 -->
</form:form>