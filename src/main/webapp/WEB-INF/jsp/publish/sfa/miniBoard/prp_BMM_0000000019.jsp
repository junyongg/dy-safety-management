<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script charset="UTF-8"></script>
<div>
	<ul>
  	<c:forEach items="${resultList }" var="model">
		<li>
			<a href="${tilesUrl}/Board/${model.BN_KEYNO}/detailView.do"  title="${model.title}">
              ${model.title}
			</a>
		</li>
    </c:forEach>
	</ul>
</div>