<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<c:choose>
	<c:when test="${not empty tilesNm }">
		<jsp:include page="/WEB-INF/jsp/publish/${tilesNm }/include/leftmenu.jsp"/>
	</c:when>
	<c:otherwise>
		<p>44908</p>
	</c:otherwise>
</c:choose>
