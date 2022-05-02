<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>



<c:choose>
	<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LIST_NO_DETAIL }">
		<%@ include file="insertView/prc_board_data_insertView_list_noDetail.jsp"%>
	</c:when>
	<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_GALLERY }">
		<%@ include file="insertView/prc_board_data_insertView_normal_movie.jsp"%>
	</c:when>
	<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_SIGN }">
		<%@ include file="insertView/prc_board_data_insertView_table.jsp"%>
	</c:when>
	<c:when test="${BoardType.BT_CODEKEY eq 'SC_0000000414' }">
	<!-- 무형문화재 -->
		<%@ include file="insertView/prc_board_data_insertView_normal_movie.jsp"%>
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