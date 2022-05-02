<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<c:choose>
	<c:when test="${not empty tilesNm }">
		<jsp:include page="/WEB-INF/jsp/publish/${tilesNm }/include/header.jsp"/>
	</c:when>
	<c:otherwise>
		<jsp:include page=""/>
	</c:otherwise>
</c:choose>
