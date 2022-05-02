<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<div>
	<ul>
  	<c:forEach items="${resultList }" var="model">
		<li>
			<a href="${tilesUrl}/Board/${model.BN_KEYNO}/detailView.do"  title="${model.COLUMN1}">
              	<img src="${model.BN_THUMBNAIL_SRC}" alt="${model.COLUMN1}">
                <p>
                  ${model.COLUMN1} 수정
                </p>
			</a>
		</li>
    </c:forEach>
	</ul>
</div>