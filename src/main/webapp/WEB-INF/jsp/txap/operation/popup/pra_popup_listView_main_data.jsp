<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>


	<ul id="menuListTab_1" class="nav nav-tabs bordered">
			<li class="active"><a href="#first" data-toggle="tab"
				class="menuList_select"><span style="color:gray">전체 팝업 관리</span></a></li>
			<li class=><a href="#twice" data-toggle="tab"
				class="menuList_select"><span style="color:gray">메뉴별 팝업 관리</span></a></li>
			<li class="pull-right"><a href="javascript:void(0);"> </a></li>
		</ul>
<div class="tab-content padding-2">		
<div id="first" class="tab-pane fade active in">
<div class="pageNumberBox">
		
	<c:if test="${not empty resultList }">
		<div class="col-sm-6 col-xs-12"
			style="line-height: 35px; text-align: left;">
			<span class="pagetext">총 ${paginationInfo.totalRecordCount }건
				/ 총 ${paginationInfo.totalPageCount} 페이지 중
				${paginationInfo.currentPageNo} 페이지 </span>
		</div>
		<div class="col-sm-6 col-xs-12 middlePage" style="text-align: right;">
			<ul class="pageNumberUl">
				<ui:pagination paginationInfo="${paginationInfo }"
					type="normal_board" jsFunction="pf_LinkPage1" />
			</ul>
		</div>
	</c:if>
	<c:if test="${empty resultList }">
		<div class="col-sm-6 col-xs-12"
			style="line-height: 35px; text-align: left;">
			<span class="pagetext">0건 중 0~0번째 결과(총
				${paginationInfo.totalRecordCount }건중 매칭된 데이터)</span>
		</div>
	</c:if>
	<div style="clear: both"></div>
</div>

<div class="tableMobileWrap">
	<table
		class="pagingTable table table-striped table-bordered table-hover"
		width="100%">
		<thead>
			<%-- 모든필드 , 게시글 갯수 시작  --%>
			<tr>
				<th colspan="6">
					<div style="float: left;">
						<input type="text" class="form-control search-control"
							data-searchindex="all" placeholder="모든필드 검색"
							style="width: 200px; display: inline-block;" />
						<button class="btn btn-sm btn-primary smallBtn" type="button"
							onclick="pf_LinkPage(1,'Form1');" style="margin-right: 10px;">
							<i class="fa fa-plus"></i> 검색
						</button>
					</div>
					<div style="float: right;">
						<button type="button" class="btn btn-sm btn-primary"
							onclick="pf_excel('Form1')">
							<i class="fa fa-file-excel-o"></i> 엑셀
						</button>
						<select name="pageUnit" 
							style="width: 50px; display: inline-block; vertical-align: top; height: 31px;"
							onchange="pf_LinkPage(1,'Form1');">
							<option value="10" ${10 eq search.pageUnit ? 'selected' : '' }>10</option>
							<option value="25" ${25 eq search.pageUnit ? 'selected' : '' }>25</option>
							<option value="50" ${50 eq search.pageUnit ? 'selected' : '' }>50</option>
							<option value="75" ${75 eq search.pageUnit ? 'selected' : '' }>75</option>
							<option value="100" ${100 eq search.pageUnit ? 'selected' : '' }>100</option>
						</select>
					</div>
				</th>
			</tr>
			<%-- 모든필드  ,  엑셀다운, 게시글 갯수 끝  --%>
			<tr>
				<th class="hasinput"><input type="text"
					class="form-control search-control" data-searchindex="1"
					placeholder="제목 검색" /></th>
				<th class="hasinput"><input type="text"
					class="form-control search-control" data-searchindex="2"
					placeholder="기간 검색" /></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
			<%-- 화살표 정렬 --%>
			<tr>
				<th class="arrow" data-index="1">제목</th>
				<th class="arrow" data-index="2">기간</th>
				<th class="arrow" data-index="3">링크</th>
				<th class="arrow" data-index="4">유형</th>
				<th>사용여부</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty resultList }">
				<tr>
					<td colspan="6">검색된 데이터가 없습니다.</td>
				</tr>
			</c:if>

			<c:forEach items="${resultList }" var="model">
					<tr>
							<td><a href="javascript:;"
								onclick="pf_popupMain('${model.PI_KEYNO}')"><c:out
										value="${model.PI_TITLE}" escapeXml="true" /></a></td>
							<c:choose>
								<c:when test="${sysdate <= model.PI_ENDDAY }">
									<c:set var="dateClass" value="" />
								</c:when>
								<c:otherwise>
									<c:set var="dateClass" value="red" />
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${model.PI_ENDDAY == '기간없음'}">
									<c:set var="model.PI_DATE" value="" />
									<td>${model.PI_ENDDAY }</td>
								</c:when>
								<c:otherwise>
									<td class="${dateClass}">${model.PI_STARTDAY }~${model.PI_ENDDAY }</td>
								</c:otherwise>
							</c:choose>
							<td>${model.PI_LINK }</td>
							<td>${model.PI_TYPE_TEXT }</td>
							<c:choose>
								<c:when test="${model.PI_CHECK eq 'Y' }">
								<td>
									<button type="button" class="btn btn-default btn-xs"
										onclick="pf_usePopup('${model.PI_KEYNO}','N')">
										<i class="fa fa-rotate-left"></i> 중지
									</button>
								</td>
								</c:when>
								<c:otherwise>
										<td><a class="btn btn-primary btn-xs" href="#"
											onclick="pf_usePopup('${model.PI_KEYNO}','Y')">
												<i class="fa fa-repeat"></i> 복원
										</a> <a class="btn btn-danger btn-xs" href="#"
											onclick="pf_DeletePopup('${model.PI_KEYNO}')">
												<i class="fa fa-trash-o"></i> 삭제
										</a></td>
								</c:otherwise>
							</c:choose>
						</tr>
				</c:forEach>
		</tbody>
	</table>
</div>
<%-- 하단 페이징 --%>
<div class="pageNumberBox dt-toolbar-footer">
	<c:if test="${not empty resultList }">
		<div class="col-sm-6 col-xs-12"
			style="line-height: 35px; text-align: left;">
			<span class="pagetext">총 ${paginationInfo.totalRecordCount }건
				/ 총 ${paginationInfo.totalPageCount} 페이지 중
				${paginationInfo.currentPageNo} 페이지</span>
		</div>
		<div class="col-sm-6 col-xs-12" style="text-align: right;">
			<ul class="pageNumberUl">
				<ui:pagination paginationInfo="${paginationInfo }"
					type="normal_board" jsFunction="pf_LinkPage1" />
			</ul>
		</div>
	</c:if>
	<c:if test="${empty resultList }">
		<div class="col-sm-6 col-xs-12"
			style="line-height: 35px; text-align: left;">
			<span class="pagetext">0건 중 0~0번째 결과(총
				${paginationInfo.totalRecordCount }건중 매칭된 데이터)</span>
		</div>
	</c:if>
</div>
</div>

<div id="twice" class="tab-pane fade" >
<input type="hidden" value="" id="Main_text">
<input type="hidden" value="" id="Main_value">
<input type="hidden" value="" id="Sub_text">
<input type="hidden" value="" id="Sub_value">
<input type="hidden" value="" id="type_b">
<!-- 메뉴부분 -->
<div id="popup_sub_menu_list" style="width:40%;float:left;border-right: 1px solid #80808061;">
<div >
					
</div>
</div>
<!-- 바디부분 -->
<div id="popup_list" style="width:60%;float:right">

</div>

</div>
</div>
<script type="text/javascript">
	$(function() {
		menu_popup_view();
		
		pf_getMenuList_main();
		
		pf_defaultPagingSetting('Form1', '${search.orderBy}',
				'${search.sortDirect}');
	});

	function pf_LinkPage1(num) {
		pf_LinkPage(num, 'Form1');
	}
	
	//테이블 불러오기
	function menu_popup_view() {
		var Sub_value = $('#Sub_value').val();
		var type_b = $('#type_b').val();
		$.ajax({
			type: "post",
			url : "/txap/operation/popup/popup_list_subAjax.do",
			data: {"Sub_value":Sub_value,"type_b":type_b},
			success:function(data){
				$("#popup_list").html(data);
			},error:function(){
				alert('실패');
			}
		});
	}
	
	//메뉴 불러오기
	function pf_getMenuList_main(){
		$.ajax({
			type: "POST",
			url: "/txap/operation/popup/popup_menuList_mainAjax.do",
			data: "",
			success : function(data){
			  	$('#popup_sub_menu_list').html(data);
			}, error: function(){
				alert("에러");
			}
		});
	}
</script>
