<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>


<input type="hidden" id="TH_KEYNO" name="TH_KEYNO" value="">
<input type="hidden" id="TH_BNKEYNO" name="TH_BNKEYNO" value="${TH_BNKEYNO }">
<input type="hidden" id="TH_PASS_YN" name="TH_PASS_YN" value="">
<input type="hidden" id="whatcnt" name="whatcnt" value="${whatcnt }">
<input type="hidden" id="TITLE" name="TITLE" value="">
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
			<th colspan="${colspan }">
				<div style="float:left;">
					<input type="text" class="form-control search-control" data-searchindex="all" placeholder="모든필드 검색" style="width:200px;display: inline-block;" />
					<button class="btn btn-sm btn-primary smallBtn" type="button" onclick="pf_LinkPage()" style="margin-right:10px;">
						<i class="fa fa-plus"></i> 검색
					</button>
				</div>
				<div style="float:right;">
					<button type="button" class="btn btn-sm btn-default" onclick="AgreeDown()">
						동의서 출력
					</button> 
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
			</th>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="1" placeholder="신청자 검색" />
			</th>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="2" placeholder="신청자 번호 검색" />
			</th>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="3" placeholder="신청자 메일 검색" />
			</th>
			<th class="hasinput">
				<input type="text" class="form-control search-control" data-searchindex="4" placeholder="신청자 유형 검색" />
			</th>
			<th class="hasinput">
<!-- 				<select class="form-control search-control search-control" data-searchindex="4" style="width:100%;"> -->
<!-- 		            <option value="">합격 여부</option> -->
<!-- 		            <option value="Y">합격</option> -->
<!-- 		            <option value="N">불합격</option> -->
<!-- 		        </select> -->
			</th>
			<th class="hasinput">
			</th>
			<th class="hasinput">
			</th>
		</tr>
		<%-- 화살표 정렬 --%>
		<tr>
			<th class="arrow" data-index="1">번호</th>
			<th class="arrow" data-index="2">신청자</th>
			<th class="arrow" data-index="3">전화번호</th>
			<th class="arrow" data-index="4">이메일</th>
			<th class="arrow" data-index="5">유형</th>
			<th class="arrow" data-index="6"></th>
			<th class="arrow" data-index="7"></th>
			<th class="arrow" data-index="8">
				<button class="btn btn-sm btn-primary" onclick="PDFAllDownload('${TH_BNKEYNO }');">PDF전체 다운</button>
			</th>
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
			<td>${model.TH_NUMBER}</td>
			<td><a href="javascript:;" onclick="printPage('${model.TH_KEYNO}');"><c:out value="${model.TH_USER} "/></a></td>
			<td><a href="javascript:;" onclick="printPage('${model.TH_KEYNO}');">${model.TH_PHONE}</a></td>
			<td><a href="javascript:;" onclick="printPage('${model.TH_KEYNO}');">${model.TH_EMAIL}</a></td>
			<td>${model.TH_TYPE eq 'U'?'운영직':'기간제'}</td>
			<td>
				<c:choose>
					<c:when test="${model.TH_PASS_YN eq 'Y' }">
						<font color="#29088A"><b>합격</b></font>
					</c:when>
					<c:otherwise>
						<font color="#FF0040"><b>불합격</b></font>
					</c:otherwise>
				</c:choose>
<%-- 				<font color="${color }"><b>${model.BN_USE}</b></font> --%>
			</td>
			
			<td>
				<c:if test="${whatcnt eq 'one'}">
					<c:choose>
						<c:when test="${model.TH_PASS_YN eq 'N' }">
							<button type="button" class="btn btn-sm btn-primary" onclick="PassCheck('Y','${model.TH_KEYNO}');">합격</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-sm btn-danger" onclick="PassCheck('N','${model.TH_KEYNO}');">합격취소</button>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${whatcnt eq 'two'}">
					<c:if test="${model.TH_PASS_YN eq 'Y'}">
						<button type="button" class="btn btn-sm btn-default" onclick="FileDown('${model.TH_ZIP_KEYNO}');">파일 다운</button>
					</c:if>
				</c:if>
			</td>
			
			<td>
				<button type="button" class="btn btn-sm btn-default" onclick="PDFDownload('${model.TH_KEYNO}','${model.TH_PDF_KEYNO}');">PDF다운로드</button>
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
// 	cf_setttingDialog('#popup',"사용자 자기소개서",'인쇄','printing()');
	
	pf_defaultPagingSetting('${search.orderBy}','${search.sortDirect}');

})

function PassCheck(yn,key){
	$("#TH_PASS_YN").val(yn);
	$("#TH_KEYNO").val(key);
	
	$.ajax({
		type : "POST" ,
		url : "/txap/hire/PassAjax.do" ,
		data :  $('#Form').serializeArray() ,
		async:false ,
		success : function(data){
			alert("변경되었습니다.")
			pf_LinkPage();
		},
		error : function(xhr, status, error) {
            alert("에러발생");
      }
	});
}
function FileDown(key){
	if(key == null || key == ''){
		alert('등록된 파일이 없습니다.');
		return false;
	} 
	location.href="/async/MultiFile/download.do?FS_KEYNO=" + key;
}

//  function ShowData(keyno){
// // 	$('#ShowUserData').dialog('open')
// 	$("#TH_KEYNO").val(keyno);
// 	$("#Form").attr("action","/hire/UserPrint.do");
// 	$("#Form").submit();
// }

function printing(){
	var popupWindow = window.open("", "_blank" );
	popupWindow.document.write( '<head>'); 
	popupWindow.document.write( '<link href="/resources/publish/jact/css/sub2.css" type="text/css" rel="stylesheet">' );
	popupWindow.document.write( '<link href="/resources/publish/jact/css/common.css" type="text/css" rel="stylesheet">' );
	popupWindow.document.write( '<link href="/resources/css/layout.css" type="text/css" rel="stylesheet">' );
	popupWindow.document.write( '</head>' );
	popupWindow.document.write( '<body>'); 
	popupWindow.document.write( '<div id="subContentsWrap_01">');
	popupWindow.document.write( $("#sub-content").html() );
	popupWindow.document.write( '</div>' );
	popupWindow.document.write( '</body>' );
	popupWindow.document.close();
	/* setTimeout(function() {
		popupWindow.print();
	}, 500); */

}

</script>
