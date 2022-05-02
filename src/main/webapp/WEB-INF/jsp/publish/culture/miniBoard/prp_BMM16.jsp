<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<div>
  <c:forEach items="${resultList }" var="model">
  		<img src="${model.BN_THUMBNAIL_SRC}" style="width:100%;height: 100%;">
  </c:forEach>
</div>