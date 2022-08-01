<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>


<div class="pageNumberBox">
	<c:if test="${not empty resultList }">
		<div class="col-sm-6 col-xs-12" style="line-height: 35px; text-align: left;">
			<span class="pagetext">총 ${paginationInfo.totalRecordCount }건  / 총 ${paginationInfo.totalPageCount} 페이지 중 ${paginationInfo.currentPageNo} 페이지 </span>
		</div>
		<div class="col-sm-6 col-xs-12 middlePage" style="text-align: right;">
				<ul class="pageNumberUl" >
					<ui:pagination paginationInfo="${paginationInfo }" type="normal_board" jsFunction="pf_LinkPage" />
			    </ul>
		</div>
    </c:if>
    <c:if test="${empty resultList }">
		<div class="col-sm-6 col-xs-12" style="line-height: 35px; text-align: left;">
		<span class="pagetext">0건 중 0~0번째 결과(총  ${paginationInfo.totalRecordCount }건중 매칭된 데이터)</span>
		</div>
    </c:if>
    <div style="clear: both"></div>
</div>

<c:set var="colspan" value="${fn:length(BoardColumnList)+4 }"/>

<div class="tableMobileWrap">
<table id="dt_basic" class="pagingTable table table-striped table-bordered table-hover" width="100%">
	<thead>
		<%-- 모든필드 , 게시글 갯수 시작  --%>
		<tr>
			<th colspan="${colspan }">
				<div style="float:left;">
					<input type="text" class="form-control search-control" data-searchindex="all" placeholder="모든필드 검색" style="width:200px;display: inline-block;" />
					<button class="btn btn-sm btn-primary smallBtn" type="button" onclick="pf_LinkPage()" style="margin-right:10px;">
						<i class="fa fa-plus"></i> 검색
					</button>
				</div>
				<div style="float:right;">
					<button type="button" class="btn btn-sm btn-primary" onclick="pf_excel()">
						<i class="fa fa-file-excel-o"></i> 엑셀
					</button>
					<select name="pageUnit" id="pageUnit" style="width:50px;display:inline-block; vertical-align: top;height: 31px;" onchange="pf_LinkPage();">
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
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="1" placeholder="번호 검색" />
			</th>
			<c:forEach items="${BoardColumnList }" var="model">
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="data${model.KEYNO }" placeholder="${model.BL_COLUMN_NAME } 검색" />
			</th>	
			</c:forEach>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="2" placeholder="작성자 검색" />
			</th>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="3" placeholder="작성일 검색" />
			</th>
			<th class="hasinput">ㄴ
				<select class="form-control search-control search-control" data-searchindex="4" style="width:100%;">
		            <option value="">사용여부</option>
		            <option value="사용">사용</option>
		            <option value="미사용">미사용</option>
		            <option value="삭제">삭제</option>
		        </select>
			</th>
		</tr>
		<%-- 화살표 정렬 --%>
		<tr>
			<th class="arrow" data-index="1">번호</th>
			<th class="arrow" data-index="2">제목	</th>
			<th class="arrow" data-index="3">작성일</th>
			<th class="arrow" data-index="4">사용여부</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${empty resultList }">
			<tr>
				<td colspan="${colspan }">검색된 데이터가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${resultList }" var="model">
		<tr>
			<td>${model.NUM}</td>
			<c:forEach items="${BoardColumnList }" var="column">
			<c:set var="tempName">BD_DATA_${column.KEYNO}</c:set>
				<c:choose>
					<c:when test="${column.BL_TYPE eq  BOARD_COLUMN_TYPE_TITLE}">
			<td>
				<a href="#" onclick="pf_DetailMove('${model.BN_KEYNO}');"><c:out value="${model[tempName]}"/></a>
			</td>
					</c:when>
					<c:otherwise>
			<td><c:out value="${model[tempName]}"/></td>					
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<td><c:out value="${model.BN_UI_NAME} "/></td>
			<td>${model.BN_REGDT }</td>
			<td>
				<c:choose>
					<c:when test="${model.BN_USE eq '사용' }">
					<c:set var="color" value="#29088A"/>
					</c:when>
					<c:otherwise>
					<c:set var="color" value="#FF0040"/>
					</c:otherwise>
				</c:choose>
				<font color="${color }"><b>${model.BN_USE}</b></font>
			</td>
		</tr>
		</c:forEach>
	
	</tbody>
</table>
</div>
<%-- 하단 페이징 --%>
<div class="pageNumberBox dt-toolbar-footer">
	<c:if test="${not empty resultList }">
		<div class="col-sm-6 col-xs-12" style="line-height: 35px; text-align: left;">
			<span class="pagetext">총 ${paginationInfo.totalRecordCount }건  / 총 ${paginationInfo.totalPageCount} 페이지 중 ${paginationInfo.currentPageNo} 페이지</span>
		</div>
		<div class="col-sm-6 col-xs-12" style="text-align: right;">
				<ul class="pageNumberUl" >
					<ui:pagination paginationInfo="${paginationInfo }" type="normal_board" jsFunction="pf_LinkPage" />
			    </ul>
		</div>
    </c:if>
    <c:if test="${empty resultList }">
    	<div class="col-sm-6 col-xs-12" style="line-height: 35px; text-align: left;">
		<span class="pagetext">0건 중 0~0번째 결과(총  ${paginationInfo.totalRecordCount }건중 매칭된 데이터)</span>
		</div>
    </c:if>
</div>

<script type="text/javascript">

$(function(){

	pf_defaultPagingSetting('${search.orderBy}','${search.sortDirect}');

})

</script>
