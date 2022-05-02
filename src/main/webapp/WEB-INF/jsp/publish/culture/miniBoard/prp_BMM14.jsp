<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

	<ul class="main-board-ul main-survey-con" style="display: none;"> <!-- 시·발굴조사 -->
  	<c:forEach items="${resultList }" var="model">
		<li>
			<a href="${tilesUrl}/Board/${model.BN_KEYNO}/detailView.do"  title="${model.COLUMN127}" class="sbj">
              ${model.COLUMN127}
			</a><p class="date">${model.BN_REGDT}</p>
		</li>
    </c:forEach>
	</ul>
