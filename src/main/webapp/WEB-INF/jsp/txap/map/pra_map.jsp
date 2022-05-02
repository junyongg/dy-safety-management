<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<style>
.checksize{
 width: 20% !important;
 margin-bottom: 5px !important;
}
form .error {color:red}

.checkbox-inline+.checkbox-inline, .radio-inline+.radio-inline {margin-left:0;}
.checkbox-inline, .radio-inline {margin-right:10px;}

#insert-article, #tableWrap.mini th.display, #tableWrap.mini td.display{display:none;}

.fixed-btns {position: fixed;bottom: 10px;right: 30px;z-index: 100;}

.fixed-btns > li {display: inline-block;margin-bottom: 7px;}
</style>

<section id="widget-grid" class="">
	<div class="row">
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="list-article">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0"
				data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>전자지도 정보 관리 리스트</h2>
				</header>
				<div class="widget-body">
					<div class="widget-body-toolbar bg-color-white">
						<div class="alert alert-info no-margin fade in">
							<button type="button" class="close" data-dismiss="alert">×</button>
							전자지도 정보 리스트를 확인합니다.
						</div> 
					</div>
					<form:form id="Form" name="Form" method="post" action="">
					<div class="widget-body-toolbar bg-color-white">
						<div class="row">
							<div class="col col-sm-12 text-align-right pull-right">
								<div class="btn-group">  
									<button class="btn btn-sm btn-primary" type="button" onclick="pf_actionView('N')">
										<i class="fa fa-plus"></i> 등록 
									</button> 
								</div>
							</div>
						</div>
					</div>
					
						<input type="hidden" name="action"/>
						<input type="hidden" name="key" id="key"/>
						<div class="table-responsive">
							<jsp:include page="/WEB-INF/jsp/txap/include/search/pra_search_header_paging.jsp" flush="true">
								<jsp:param value="/txap/map/pagingAjax.do" name="pagingDataUrl" />
								<jsp:param value="" name="excelDataUrl" />
							</jsp:include>
							<fieldset id="tableWrap">
							</fieldset>
						</div>
					</form:form>
				</div>
			</div>
		</article>
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-7" id="insert-article">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0"
				data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>정보 등록/수정</h2>
				</header>
				<div class="widget-body " >
					<form:form id="insertForm" class="form-horizontal" name="Form" method="post" action="">
						<div id="inputFormBox">
						</div>
					</form:form>
					<ul class="fixed-btns">
						<li>
							<a href="javascript:;" onclick="pf_Action()" class="btn btn-primary btn-circle btn-lg" title="저장하기"><i class="fa fa-save"></i></a>
						</li>
						
						<li id="deleteBtn">
							<a href="javascript:;" onclick="pf_delete()" class="btn btn-danger btn-circle btn-lg" title="삭제하기"><i class="fa fa-trash-o"></i></a>
						</li>
						<li>
							<a href="javascript:;" onclick="pf_togleArticle('N')" class="btn btn-default btn-circle btn-lg" title="목록보기"><i class="glyphicon glyphicon-list"></i></a>
						</li>
					</ul>
				</div>
			</div>
		</article>
	</div>
</section>


<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6415ea8c2cee8bb76bdce65bdf6a6bda&libraries=services"></script>
<script type="text/javascript">

// var checkUplaodFile = false;
var formActionType;
var msg = '${msg}'
var selectKey = '${key}'
$(function(){
	
	if(msg){
		setTimeout(function(){
			cf_smallBox('success', msg, 3000);
		},100);
	}
	
	if(selectKey){
		pf_actionView('Y',selectKey);
	}
});

function pf_actionViewPage(key){
	key = key || '';
	$('#key').val(key);
	$('#Form').attr('action','/txap/map/map.do?${_csrf.parameterName}=${_csrf.token}');
	$('#Form').submit();
}

function pf_actionView(isPossibleDelete,key){
	key = key || '';
	
	pf_togleArticle('Y');
	
	$.ajax({
		type: "POST",
		url: "/txap/map/dataAjax.do",
		data: {
			"key":key
		},
		async :false,
		success : function(data){
			$('#inputFormBox').html(data);
            
			if(isPossibleDelete == 'N'){
				$('#deleteBtn').hide();
			}else{
				$('#deleteBtn').show();
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			cf_smallBox('ajax', '알수없는 에러 발생. 관리자한테 문의하세요.', 3000,'gray');
		}
   }).done(function(){
	   cf_loading_out();
   });
	
}

function pf_togleArticle(action){
	if(action == 'Y'){
		$('#list-article').removeClass('col-lg-12').addClass('col-lg-5');
		$('#insert-article').show();
		$('#tableWrap').addClass('mini')
	}else{
		$('#list-article').removeClass('col-lg-5').addClass('col-lg-12');
		$('#insert-article').hide();
		$('#tableWrap').removeClass('mini')
	}
}

function pf_checkLength(id,maxLength){
	var letterLength = $('#'+id).val().length;
	if(letterLength > maxLength){
		letterLength = maxLength;
	}
	var text = '(' + letterLength + '/' + maxLength +'자)'
		
	$('#'+id+"_length").text(text);
}

function pf_checkClassLength(obj,maxLength){
	var letterLength = $(obj).val().length;
	if(letterLength > maxLength){
		letterLength = maxLength;
	}
	var text = '(' + letterLength + '/' + maxLength +'자)'
		
	$(obj).next().text(text);
}

function pf_delete(){
	if(confirm('정말 삭제하시겠습니까?')){
		cf_loading();
		$('#action').val('delete');
		$("#insertForm").attr("action", "/txap/map/mapAction.do?${_csrf.parameterName}=${_csrf.token}");
		$("#insertForm").submit();
	}
}

function pf_excelInert(){
	var file = $("#ExcelFile").val();
	var ext = file.substring(file.indexOf(".")+1)
	if(file == ""){
		cf_smallBox('ajax', '파일을 등록해주세요.', 3000,'gray');
		return false;
	}
	if("xlsx".indexOf(ext) != -1){
		$("#Form").attr("enctype", "multipart/form-data");
		$("#Form").attr("action","/txap/culture/store/info/excelInsert.do?${_csrf.parameterName}=${_csrf.token}");
		$("#Form").submit();
	}else{
		cf_smallBox('ajax', '엑셀파일만 등록 가능합니다.', 3000,'gray');
	}
}


function pf_excelDown(){
	$("#Form").attr("action","/txap/culture/store/info/excelDown.do?${_csrf.parameterName}=${_csrf.token}");
	$("#Form").submit();
}
</script>