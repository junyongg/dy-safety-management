<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<!-- 메뉴 출력-->
<c:forEach items="${resultList}" var="model" varStatus="status">
<!-- 소메뉴 형 일경우 -->
<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU }">
	<li class="parent_li" data-key="${model.MN_KEYNO }"> 
		<span class="label label-primary">
  			<i class="fa fa-lg fa-plus-circle"></i> 
</c:if>
<!--뷰, 게시판형일경우 -->
<c:if test="${model.MN_PAGEDIV_C ne MENU_TYPE_SUBMENU }">
	<li data-key="${model.MN_KEYNO }"> 
		<span>
  			<i class="fa fa-lg fa-caret-right" ></i> 
</c:if>
<c:out value="${model.MN_NAME}" escapeXml="false" /> 
		</span> - 
		<c:if test="${model.MN_USE_YN eq 'Y' }">
		<button type="button" class="btn btn-success btn-xs Menu_Update"  onclick="pf_Set_MainMenuUpdateView('${model.MN_HOMEDIV_C}','${model.MN_MAINKEY}','${model.MN_KEYNO}','${model.MN_LEV}')"><i class="fa fa-pencil"></i></button>
		<c:if test="${model.MN_PAGEDIV_C == MENU_TYPE_SUBMENU }">   
		<button type="button" class="btn btn-primary btn-xs " onclick="pf_Set_MenuInsertView('${model.MN_HOMEDIV_C}', '${model.MN_KEYNO}','${model.MN_LEV}','${model.MN_URL }')"><i class="fa fa-plus"></i></button>
		</c:if>
		<button type="button" class="btn btn-warning btn-xs " onclick="pf_UseChecking('${model.MN_KEYNO}','N','${model.MN_MAINKEY }')"><i class="fa fa-check-square-o"></i></button>
		<button type="button" class="btn btn-danger btn-xs " onclick="pf_MenuDelete('${model.MN_KEYNO}','${model.MN_MAINKEY }')"><i class="fa fa-trash-o"></i></button>
		<c:if test="${model.MN_SHOW_YN eq 'Y' }">
		<button type="button" class="btn btn-primary btn-xs " onclick="pf_ShowChecking('${model.MN_KEYNO}','N','${model.MN_MAINKEY }')"><i class="fa fa-unlock"></i></button>
		</c:if>
		<c:if test="${model.MN_SHOW_YN eq 'N' }">
		<button type="button" class="btn btn-primary btn-xs " onclick="pf_ShowChecking('${model.MN_KEYNO}','Y','${model.MN_MAINKEY }')"><i class="fa fa-lock"></i></button>
		</c:if> 
		
		<!-- DB에 저장된 페이지 바로가기 -->
	</c:if>
	<c:if test="${model.MN_USE_YN eq 'N' }">
		<button type="button" class="btn btn-warning btn-xs " onclick="pf_UseChecking('${model.MN_KEYNO}','Y','${model.MN_MAINKEY }')"><i class="fa fa-square-o"></i></button>
	</c:if>
		<button type="button" class="btn btn-success btn-xs " onclick="pf_OpenAuthorityManager('${model.MN_KEYNO}','${model.MN_URL}','${model.MN_PAGEDIV_C }')"><i class="fa fa-sign-in"></i></button>
	<!--단일페이지형-->
<%-- 	<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_PAGE }"> --%>
<%-- 		<c:if test="${not empty model.MVD_KEYNO }">  --%>
<%-- 		<button  type="button" class="btn btn-primary btn-xs " onclick="pf_DetailMove('${model.MVD_KEYNO }')"><i class="fa fa-edit"></i></button> --%>
<%-- 		</c:if> --%>
<%-- 		<c:if test="${empty model.MVD_KEYNO }">  --%>
<%-- 		<button  type="button" class="btn btn-primary btn-xs " onclick="pf_makepage('${model.MN_HOMEDIV_C}','${model.MN_NAME}','${model.MN_URL}')"><i class="fa fa-edit"></i></button> --%>
<%-- 		</c:if> --%>
<%-- 	</c:if> --%>
	
	<!--소메뉴형이면서 소개페이지가 있을경우-->
<%-- 	<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU && not empty model.MN_FORWARD_URL }"> --%>
<%-- 		<c:if test="${not empty model.MVD_KEYNO }">  --%>
<%-- 		<button  type="button" class="btn btn-primary btn-xs " onclick="pf_DetailMove('${model.MVD_KEYNO }')"><i class="fa fa-edit"></i></button> --%>
<%-- 		</c:if> --%>
<%-- 		<c:if test="${empty model.MVD_KEYNO }">  --%>
<%-- 		<button  type="button" class="btn btn-primary btn-xs " onclick="pf_makepage('${model.MN_HOMEDIV_C}','${model.MN_NAME}','${model.MN_FORWARD_URL}')"><i class="fa fa-edit"></i></button> --%>
<%-- 		</c:if> --%>
<%-- 	</c:if> --%>
	
	<!--게시판형  -->
	<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_BOARD }">
		<c:if test="${not empty model.MN_KEYNO }"> 
		<button  type="button" class="btn btn-primary btn-xs " onclick="pf_boardmanagement('${model.MN_KEYNO }')"><i class="fa fa-book"></i></button>
		</c:if>
	</c:if>
		<ul></ul>
	</li>
</c:forEach>
  									