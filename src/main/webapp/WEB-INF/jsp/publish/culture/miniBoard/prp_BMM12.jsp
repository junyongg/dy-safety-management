<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<div class="con-box">
	<ul class="main-board-ul">
  	<c:forEach items="${resultList }" var="model">
		<li>
			<a href="${tilesUrl}/Board/${model.BN_KEYNO}/detailView.do"  title="${model.COLUMN126}" class="sbj">
             ${model.COLUMN126}	</a>
              <p class="date">${model.BN_REGDT}</p>
		</li>
    </c:forEach>
	</ul>
</div>