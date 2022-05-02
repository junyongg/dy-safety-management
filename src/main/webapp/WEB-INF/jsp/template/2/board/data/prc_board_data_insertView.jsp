<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<link type="text/css" rel="stylesheet" href="/resources/jcia/css/board.css">


<c:choose>
	<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LIST_NO_DETAIL }">
		<%@ include file="insertView/prc_board_data_insertView_list_noDetail.jsp"%>
	</c:when>
	<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LIST_NO_CONTENT }">
		<c:if test="${Menu.MN_KEYNO eq COSTOMER_CONTRACT || Menu.MN_KEYNO eq COSTOMER_PRIVATE}">
			<%@ include file="insertView/prc_board_data_insertView_no_content.jsp"%>
		</c:if>
		<c:if test="${Menu.MN_KEYNO ne COSTOMER_CONTRACT && Menu.MN_KEYNO ne COSTOMER_PRIVATE}">
			<%@ include file="insertView/prc_board_data_insertView_list_noDetail.jsp"%>
		</c:if>
	</c:when>
	<c:otherwise>
		<%@ include file="insertView/prc_board_data_insertView_normal.jsp"%>
	</c:otherwise>
</c:choose>

<script>

//링크확인
function pf_link(id){
	window.open($('#'+id).val())
}




</script>