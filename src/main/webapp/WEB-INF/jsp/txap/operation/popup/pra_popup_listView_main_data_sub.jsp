<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<div class="table-responsive">
	<table
		class="table table-bordered" style="text-align:center;margin-left: 15px;width: 98%;">
		<thead>
		<%-- 하단 페이징 --%>
<div class="pageNumberBox dt-toolbar-footer">
	<c:if test="${not empty resultList_sub }">
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
	<c:if test="${empty resultList_sub }">
		<div class="col-sm-6 col-xs-12"
			style="line-height: 35px; text-align: left;">
			<span class="pagetext">0건 중 0~0번째 결과(총
				${paginationInfo.totalRecordCount }건중 매칭된 데이터)</span>
		</div>
	</c:if>
</div>
			<%-- 화살표 정렬 --%>
			<tr>
				<th style="text-align: center;">제목</th>
				<th style="text-align: center;">기간</th>
				<th style="text-align: center;">링크</th>
				<th style="text-align: center;">유형</th>
				<th style="text-align: center;">사용여부</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty resultList_sub }">
				<tr>
					<td colspan="5">검색된 데이터가 없습니다.</td>
				</tr>
			</c:if>

			<c:forEach items="${resultList_sub }" var="model">
						<tr>
							<td><a href="javascript:;"
								onclick="pf_popupMain('${model.PI_KEYNO}')"><c:out
										value="${model.PI_TITLE}" escapeXml="true" /></a></td>
							<%-- 			<td class="${dateClass}"> --%>
							<c:choose>
								<c:when test="${model.PI_ENDDAY == '기간없음'}">
									<c:set var="model.PI_DATE" value="" />
									<td>기간없음</td>
								</c:when>
								<c:otherwise>
									<td>${model.PI_STARTDAY } ~ ${model.PI_ENDDAY }</td>
								</c:otherwise>
							</c:choose>
							<td>${model.PI_LINK }</td>
							<td>${model.PI_TYPE_TEXT }</td>
							<c:choose>
								<c:when test="${model.PI_CHECK eq 'Y' }">
								<td>
									<button type="button" class="btn btn-default btn-xs"
										onclick="pf_usePopup('${model.PI_KEYNO}','N', '${model.PI_MN_KEYNO}','${model.PI_LEVEL }')">
										<i class="fa fa-rotate-left"></i> 중지
									</button>
								</td>
								</c:when>
								<c:otherwise>
								<td><a class="btn btn-primary btn-xs" href="#"
									onclick="pf_usePopup('${model.PI_KEYNO}','Y','${model.PI_MN_KEYNO }')">
										<i class="fa fa-repeat"></i> 복원
								</a> <a class="btn btn-danger btn-xs" href="#"
									onclick="pf_DeletePopup('${model.PI_KEYNO}','${model.PI_MN_KEYNO }')">
										<i class="fa fa-trash-o"></i> 삭제
								</a></td>
								</c:otherwise>
							</c:choose>
						</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 바디 끝 -->
<script type="text/javascript">
	$(function() {
		pf_defaultPagingSetting('Form1', '${search.orderBy}',
		'${search.sortDirect}');
	});
	
	function pf_LinkPage1(num) {
		pf_LinkPage(num, 'Form1');
	}
	
	
	//페이징 관련 기본 셋팅
	function pf_defaultPagingSetting(formId,searchOrderBy,searchSortDirect){
		
		var formObj = '#'+formId;
		
		if(searchOrderBy){
			$(formObj + ' th.arrow').each(function(){
				var index = $(this).data('index');
				if(searchOrderBy == index){
					$(this).addClass(searchSortDirect);
				} 
				
			})
		}
		
		$(formObj + ' th.arrow').on('click',function(){
			var sortDirect = '';
			var orderBy = $(this).data('index');
			if($(this).hasClass('asc')){
				sortDirect = 'desc'
			}else if($(this).hasClass('desc')){
				sortDirect = 'asc'
			}else{
				sortDirect = 'desc'
			}
			
			$(formObj + ' input[name=orderBy]').val(orderBy);
			$(formObj + ' input[name=sortDirect]').val(sortDirect);
			
			pf_LinkPage(1,formId);
			
		})
		
	}

	//엑셀 버튼
	function pf_excel(formId){
		
		formId = formId || 'Form';
		
		formObj = '#'+formId;
		
		var excelUrl = $(formObj + ' input[name=excelUrl]').val();
		
		cf_checkExcelDownload();
		
		$(formObj).attr('action',excelUrl);
		$(formObj).submit();
		
	}

	function pf_addInput(formId,obj){
		
		var search = $(obj).val();
		var searchindex = $(obj).data('searchindex');
		
		var type = $(obj).data('type');
		
		if(type == 'currency'){	//통화 같은경우 콤마를 넣든 안넣든 검색 가능하도록 처리
			search = search.replaceAll(',','');
		}
		
		var form = document.getElementById(formId);
		
		searchParams = {
			'searchKeyword' : search,
			'searchIndex' : searchindex
		}
		
		searchParamList.push(searchParams)
		
		for(var key in searchParams) {
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("class", "hiddenForm");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", key);
			hiddenField.setAttribute("value", searchParams[key]);
			form.appendChild(hiddenField);
		}
		
		
	}

	//페이지 넘기기
	function pf_LinkPage(num,formId){
		
		num = num || 1;
		
		var formObj ='#'+formId; 
		
		cf_loading();
		
		searchParamList = [];
		$(formObj + ' .hiddenForm').remove();
		
		$(document).find(formObj + ' .search-control').each(function(){
			if($(this).val()){
				pf_addInput(formId,this);
			}
		})
		
		$(formObj + ' input[name=pageIndex]').val(num);	
		
		setTimeout(function(){
			pf_getList(formId);
		},200);	
		
	}

	function pf_getList(formId){
		
		var formObj = '#'+formId;
		
		var pagingUrl = $(formObj + ' input[name=pagingUrl]').val();
		
		$.ajax({
			type : "POST" ,
			url : pagingUrl ,
			data :  $(formObj).serializeArray() ,
			async:false ,
			
			success : function(data){
				//console.log(data);
				$(formObj + ' .tableWrap').html(data);
				
				if(searchParamList.length > 0){
					for(var i in searchParamList) {
						var searchIndex = searchParamList[i].searchIndex;
						$(document).find(formObj + ' .search-control').each(function(){
							
							var index = $(this).data('searchindex');
							if(searchIndex == index){
								$(this).val(searchParamList[i].searchKeyword)
							}
							
						})
					}
					
				}
				
				$(formObj + ' .search-control').on('keydown',function(key){
					if (key.keyCode == 13 && $(this).val()) {
						pf_LinkPage(1,formId);
					}
				})
				
				
				
			},
			error : function(xhr, status, error) {
	            alert("에러발생");
	      }

		}).done(function(){
			cf_loading_out();
		})
	}
</script>
