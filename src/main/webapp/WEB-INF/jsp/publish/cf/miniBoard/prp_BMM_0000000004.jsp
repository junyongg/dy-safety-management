<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<div>
	<ul>
  	<c:forEach items="${resultList }" var="model">
		<li>
			<a href="${tilesUrl}/Board/${model.BN_KEYNO}/detailView.do"  title="${model.COLUMN6}">
              	<img src="${model.BN_THUMBNAIL_SRC}" alt="${model.COLUMN6}">
              	<p>
                  ${model.COLUMN6}
              </p>
			</a>
		</li>
    </c:forEach>
	</ul>
</div>