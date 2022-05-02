<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<div class="content">
	<ul>
  	<c:forEach items="${resultList }" var="model">
		<li>
			<a href="${tilesUrl}/Board/${model.BN_KEYNO}/detailView.do"  title="${model.COLUMN69}">
             ${model.COLUMN69} 
			</a>
          <span class="date">${model.BN_REGDT}</span>

		</li>
    </c:forEach>
	</ul>
</div>