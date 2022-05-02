<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
	<ul class="main-board-ul main-survey-con"> 
  	<c:forEach items="${resultList }" var="model">
		<li>
			<a href="${tilesUrl}/Board/${model.BN_KEYNO}/detailView.do"  title="${model.COLUMN1}" class="sbj">
              ${model.COLUMN1}
			</a><p class="date">${model.BN_REGDT}</p>
		</li>
    </c:forEach>
	</ul>
