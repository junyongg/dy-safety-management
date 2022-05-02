<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<!-- FAVICONS -->
<c:choose>
	<c:when test="${not empty homeData.HM_FAVICON }">
		<c:set var="homeIcon" value="${domain }${homeData.HM_FAVICON }"/>
	</c:when>
	<c:otherwise>
		<c:set var="homeIcon" value="${domain }/resources/favicon.ico"/>
	</c:otherwise>
</c:choose>

<link rel="shortcut icon" href="${homeIcon }" type="image/x-icon">
<link rel="icon" href="${homeIcon }" type="image/x-icon">

<link type="text/css" rel="stylesheet" href="/webjars/jquery-ui/1.12.1/jquery-ui.min.css">
<link href="/resources/api/bxslider/jquery.bxslider.css" type="text/css" rel="stylesheet">
<!-- <link rel="shortcut icon" href="favicon/favicon.ico"> -->
<link href="/resources/culture/css/slick.css" type="text/css" rel="stylesheet">
<link href="/resources/culture/css/hamburgers.css" type="text/css" rel="stylesheet">
<link href="/resources/culture/css/animate.css" type="text/css" rel="stylesheet">
<link href="/resources/culture/css/layout.css" type="text/css" rel="stylesheet">
<link href="/resources/publish/culture/css/sub.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
  
<!-- CSS적용 -->
<c:forEach items="${cssList }" var="cssCommon">
	<link href="${cssCommon.RM_PATH }" type="text/css" rel="stylesheet">
</c:forEach>


