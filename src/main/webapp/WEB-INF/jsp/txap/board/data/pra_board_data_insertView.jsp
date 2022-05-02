<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
<c:choose>
	<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LIST_NO_DETAIL }">
		<%@ include file="insertType/pra_board_data_insertView_noDetail.jsp"%>
	</c:when>
	<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_GALLERY }">
		<%@ include file="insertType/pra_board_data_insertView_movie.jsp"%>
	</c:when>
	<c:when test="${BoardType.BT_CODEKEY eq 'SC_0000000414' }">
	<!-- 무형문화재 -->
		<%@ include file="insertType/pra_board_data_insertView_movie.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="insertType/pra_board_data_insertView_normal.jsp"%>
	</c:otherwise>
</c:choose>
