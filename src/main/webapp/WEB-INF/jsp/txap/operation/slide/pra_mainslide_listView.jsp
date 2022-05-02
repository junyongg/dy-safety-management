<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<link type="text/css" rel="stylesheet" href="/resources/css/common/paging_table.css">

<style>
.table-center{
 text-align: center;
}

td.red {color:red;}
</style>

<form:form  id="actionForm" method="post">
	<input type="hidden" name="MM_KEYNO" id="MM_KEYNO" value="">
	<input type="hidden" name="MM_USE_YN" id="MM_USE_YN" value="">
	<input type="hidden" id="MM_LEVEL" name="MM_LEVEL" value="">
	<input type="hidden" id="MM_LEVEL_AFTER" name="MM_LEVEL_AFTER" value="">
	<input type="hidden" id="MM_MN_KEYNO" name="MM_MN_KEYNO" value="">
	<input type="hidden" id="MM_LOCATION" name="MM_LOCATION" value="">
</form:form>


<%@ include file="pra_mainslide_listView_main.jsp" %>

<%@ include file="pra_mainslide_listView_sub.jsp" %>

<script type="text/javascript">

var searchParamList = [];

$(function(){
	var msg = '${msg}';
	if(msg == 'insert'){
		alert('성공적으로 등록되었습니다.')
	}else if(msg == 'update'){
		alert('성공적으로 수정되었습니다.')
	}
});


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



function pf_slideMain(key){
	location.href="/txap/operation/slide/insertView.do?MM_KEYNO=" + key;
}

//팝업 메인 등록 // 팝업 삭제 관련 체크박스 확인
function pf_useSlide(key,mainkey,location,use, level){
	$('#MM_KEYNO').val(key);
	$('#MM_USE_YN').val(use);
	$("#MM_LEVEL").val(level);
	$('#MM_MN_KEYNO').val(mainkey);
	$("#MM_LOCATION").val(location);
	$('#actionForm').attr('action','/txap/operation/slide/check.do');
	$('#actionForm').submit()
}

function pf_DeleteSlide(key){
	$('#MM_KEYNO').val(key);
	$('#actionForm').attr('action','/txap/operation/slide/deleteAjax.do');
	$('#actionForm').submit()
}

function pf_slideRegist(){
	$("#actionForm").attr("action", "/txap/operation/slide/insertView.do");
	$("#actionForm").submit();
}

//팝업 순서 변경
function fn_updateLevel(keyno,level,afterLevel,mainkey,location){
	$("#MM_KEYNO").val(keyno);
	$("#MM_LEVEL").val(level);
	$("#MM_LEVEL_AFTER").val(afterLevel);
	$("#MM_MN_KEYNO").val(mainkey);
	$("#MM_LOCATION").val(location);
	$("#actionForm").attr("action", "/txap/operation/slide/level/update.do");
	$("#actionForm").submit();
}	
</script>