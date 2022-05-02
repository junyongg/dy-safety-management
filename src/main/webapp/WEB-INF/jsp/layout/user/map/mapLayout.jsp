<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<%@ taglib prefix="tiles" 	uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html lang="${homeData.HM_LANG }">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>전라남도 문화재단 전자맵</title>

<tiles:insertAttribute name="css"/>
<tiles:insertAttribute name="script"/>

</head>

<body style='font-family: MalgunGothic;'>
	<div id="wrap"> <!-- WRAP -->
		<tiles:insertAttribute name="body"/>
		
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
</html>











