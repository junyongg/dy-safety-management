<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<jsp:useBean id="now" class="java.util.Date" />
<div class="main_notice_tab_con"><!-- 입찰 -->
	<button type="button" class="btn_more" onclick="nextBoard()" title="더보기">
	<i class="xi-plus-thin"></i></button>
	<ul class="main_notice_list">
  	<c:forEach items="${resultList }" var="model">
		<li>
			<span class="num">입찰</span>
			<a class="sbj" href="${tilesUrl}/Board/${model.BN_KEYNO}/detailView.do"  title="${model.COLUMN72}">
              <c:if test="${not empty model.COLUMN138 }">
					<fmt:formatDate var="nows" value="${now }" pattern="yyyyMMdd"/>
					  <fmt:parseDate var="date" value="${model.COLUMN138 }" pattern="yyyy-MM-dd"/>
					  <fmt:formatDate var="date" value="${date }" pattern="yyyyMMdd"/>
					  <c:set var="Dday" value="${date - nows}"/>
					
					  <c:if test="${ Dday < 15 && Dday > 0 }">
						  <b > D - <c:out value="${Dday }"/> </b>
					  </c:if>
                      <c:if test="${ Dday  == 0 }">
						  <b > D - day </b>
					  </c:if>
			  </c:if>
              ${model.COLUMN72} 
			</a>
          <span class="date">${model.BN_REGDT}</span>

		</li>
    </c:forEach>
	</ul>
</div>