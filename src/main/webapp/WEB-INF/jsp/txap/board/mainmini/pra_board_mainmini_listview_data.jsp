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

<c:set var="colspan" value="8"/>

<div class="tableMobileWrap">
<table id="dt_basic" class="pagingTable table table-striped table-bordered table-hover" width="100%">
	<thead>
		<%-- 모든필드 , 게시글 갯수 시작  --%>
		<tr>
			<th colspan="${colspan}">
				<div style="float:left;">
					<input type="text" class="form-control search-control" data-searchindex="all" placeholder="모든필드 검색" style="width:200px;display: inline-block;" />
					<button class="btn btn-sm btn-primary smallBtn" type="button" onclick="pf_LinkPage()" style="margin-right:10px;">
						<i class="fa fa-plus"></i> 검색
					</button>
				</div>
				<div style="float:right;">
					<!-- <button type="button" class="btn btn-sm btn-primary" onclick="pf_excel()">
						<i class="fa fa-file-excel-o"></i> 엑셀
					</button> -->
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
			<th class="hasinput">
				<select class="form-control search-control" data-searchindex="2" placeholder="홈페이지명 검색" >
		            <option value="">홈페이지명</option>
		            <c:forEach items="${homeDivList }" var="model"> 
		            	<option value="${model.MN_NAME }">${model.MN_NAME }</option> 
		            </c:forEach>
		        </select>
			</th>
			<th class="hasinput">
				<%-- <select class="form-control search-control" data-searchindex="3" placeholder="게시판명 검색" >
		            <option value="">게시판명</option>
		            <c:forEach items="${BoardList }" var="model"> 
		            	<option value="${model.MN_KEYNO }">${model.MN_NAME }</option> 
		            </c:forEach>
		        </select> --%>
		        <input type="text" class="form-control search-control" data-searchindex="3" placeholder="게시판명 검색" />
			</th>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="4" placeholder="표출갯수 검색" />
			</th>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="5" placeholder="작성자 검색" />
			</th>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="6" placeholder="작성일 검색" />
			</th>
			<th class="hasinput">
			</th>
			<th class="hasinput">
			</th>
			<!-- <th class="hasinput">
				<select class="form-control search-control search-control" data-searchindex="7" style="width:100%;">
		            <option value="">사용여부</option>
		            <option value="사용">사용</option>
		            <option value="미사용">미사용</option>
		        </select>
			</th> -->
		</tr>
		<%-- 화살표 정렬 --%>
		<tr>
			<th class="arrow" data-index="1">번호</th>
			<th class="arrow" data-index="2">홈페이지명</th>
			<th class="arrow" data-index="3">게시판명</th>
			<th class="arrow" data-index="4">표출 갯수</th>
			<th class="arrow" data-index="5">작성자</th>
			<th class="arrow" data-index="6">등록일</th>
			<th class="arrow">파일 배포</th>
			<th class="arrow">Import 복사</th>
			<!-- <th class="arrow" data-index="7">사용여부</th> -->
		</tr>
	</thead>
	<tbody>
		<c:if test="${empty resultList }">
			<tr>
				<td colspan="${colspan}">검색된 데이터가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${resultList }" var="model">
		<fmt:parseNumber value="${fn:substring(model.BMM_KEYNO, 4, 20)}" var="KEY" />
		<tr>
			<td>${model.COUNT}</td>
			<td><c:out value="${model.BMM_HOME_NAME} "/></td>
			<td><a href="javascript:pf_boardTypeUpdate('${model.BMM_KEYNO}')">${model.BMM_MN_NAME} </a></td>
			<td><c:out value="${model.BMM_SIZE} "/></td>
			<td><c:out value="${model.BMM_UI_NAME} "/></td>
			<td>${model.BMM_REGDT }</td>
			<td>
				<div class="btn btn-warning btn-xs" onclick="pf_PublishFile('${model.BMM_KEYNO}')">
					<i class="fa fa-file"></i> 배포하기
				</div>
			</td>
			<td>
				<div class="btn btn btn-default btn-xs" onclick="pf_Copy('${KEY}')">
					<i class="fa fa-copy"></i>
				</div>
			</td>
			<%-- <td>
				<c:choose>
					<c:when test="${model.BMM_USE eq '사용' }">
					<c:set var="color" value="#29088A"/>
					</c:when>
					<c:otherwise>
					<c:set var="color" value="#FF0040"/>
					</c:otherwise>
				</c:choose>
				<font color="${color }"><b>${model.BMM_USE}</b></font>
			</td> --%>
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
