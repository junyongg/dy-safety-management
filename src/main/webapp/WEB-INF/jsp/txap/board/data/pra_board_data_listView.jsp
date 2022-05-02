<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<style>
#dt_basic tbody tr{cursor: pointer;}
</style>
<input type="hidden" name="seqbo" id="seqbo"/>
<div id="content">
	<form:form id="Form" name="Form" method="post" action="/txap/Board/dataView.do" class="form-inline">
		<input type="hidden" name="BT_KEYNO" id="BT_KEYNO" value="">
		<input type="hidden" name="BN_KEYNO" id="BN_KEYNO" value="">
		<input type="hidden" name="MN_NAME" id="MN_NAME" value="">
		<section id="widget-grid" >
			<div class="row">
				<article class="col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget jarviswidget-color-blueDark" id="board_notice_list_1" data-widget-editbutton="false">
						<header>
							<span class="widget-icon"> <i class="fa fa-lg fa-desktop"></i> </span>
							<h2>게시물관리 </h2>
						</header> 
						<div>
							<div class="jarviswidget-editbox"></div>
							<div class="widget-body">
								<div class="widget-body-toolbar bg-color-white">
									<div class="alert alert-info no-margin fade in">
										<button type="button" class="close" data-dismiss="alert">×</button>
										게시판형 메뉴를 선택하면 해당하는 게시판의 게시물이 출력 됩니다.
									</div>
								</div> 
								<div class="widget-body-toolbar bg-color-white">
									<div class="row">
										<div class="col-sm-12 col-md-8 text-align-left">
											<div class="form-group">
												<label class="sr-only">일단은 게시판타입 선택</label>
												<c:choose>
													<c:when test="${not empty Menu}">
														<c:set var="MN_HOMEDIV_C" value="${Menu.MN_HOMEDIV_C }"/>
													</c:when>
													<c:otherwise>
														<c:set var="MN_HOMEDIV_C" value="${HOMEDIV_CF }"/>
													</c:otherwise>
												</c:choose>
												
												<select class="form-control input-sm" id="MN_HOMEDIV_C" name="MN_HOMEDIV_C" onchange="menuasync();">
													<option value="">홈페이지 선택</option>
													<c:forEach items="${homeDivList }" var="model"> 
		 								                <option value="${model.MN_KEYNO }" ${model.MN_KEYNO eq MN_HOMEDIV_C ? 'selected':'' }>${model.MN_NAME }</option> 
		 								              </c:forEach>
												</select> 
											</div>
											<div class="form-group">
												<label class="sr-only">일단은 게시판타입 선택</label>
												<select class="form-control input-sm" id="MN_KEYNO" name="MN_KEYNO" style="display: none;" onchange="pf_changeMenu()">
												</select> 
											</div>
										</div>																								
									 
										<div class="col-sm-12 col-md-4 text-align-right">
											<div class="btn-group">  
												<button class="btn btn-sm btn-primary" type="button" onclick="pf_RegistMove()" style="margin-right:10px;">
													<i class="fa fa-plus"></i> 게시물 등록
												</button>
												<button class="btn btn-sm btn-primary" type="button" id="htmlRegist" onclick="pf_HtmlRegistMove()">
													<i class="fa fa-plus"></i> 소개HTML 등록 및 수정
												</button> 
											</div>
										</div>
									</div>
								</div> 
								<div class="table-responsive">
									<jsp:include page="/WEB-INF/jsp/txap/include/search/pra_search_header_paging.jsp" flush="true">
										<jsp:param value="/txap/Board/dataView/pagingAjax.do" name="pagingDataUrl" />
										<jsp:param value="/txap/Board/dataView/excelAjax.do" name="excelDataUrl" />
									</jsp:include>
									<fieldset id="tableWrap">
									</fieldset>
								</div>
							</div>
						</div>
					</div>
					
				</article>
			</div>
		</section>
	</form:form>
</div>
<script type="text/javascript">

pageLoadingCheck = false;

$(function(){
	menuasync('init');
	pageLoadingCheck = true;
});

function menuasync(init){
	$.ajax({
	    type   : "post",
	    url    : "/txap/Board/data/main/menu/selectAjax.do",
	    data   : {"MN_KEYNO" : $("#MN_HOMEDIV_C").val()},
	    async  : false ,
	    success:function(data){
	    	cf_loading_out();
	    	if(data.length == 0){
	    		$("#MN_KEYNO").hide();	
	    	}else{
				var html = "<option value=''>메뉴선택</option>";
		    	for(var i = 0; i < data.length; i++){
					html += "<option value='"+data[i].MN_KEYNO+"' data-bt='"+data[i].MN_BT_KEYNO+"' data-html='"+data[i].BT_HTML_YN+"'>"+data[i].MN_NAME+"</option>";
		    	}
            	$("#MN_KEYNO").html(html);
            	$("#MN_KEYNO").show();
            	if(init){
            		pf_changeMenu("${Menu.MN_KEYNO }");
            	}
	    	}
	    },
	    error: function(jqXHR, textStatus, exception) {
	    	alert('error: '+textStatus+": "+exception);
	    }
	  });
}

function pf_changeMenu(MN_KEYNO){
	if(MN_KEYNO){
		$('#MN_KEYNO').val(MN_KEYNO);
	}
	
	var html = $('#MN_KEYNO option:selected').data('html');
	if(html == 'Y'){
		$('#htmlRegist').show();
	}else{
		$('#htmlRegist').hide();
	}
	var BT_KEYNO = $('#MN_KEYNO option:selected').data('bt');
	$("#BT_KEYNO").val(BT_KEYNO);
	var MN_NAME = $('#MN_KEYNO option:selected').text();
	$('#MN_NAME').val(MN_NAME);
	pf_LinkPage();
}

//게시판 타입 등록페이지 이동 
function pf_RegistMove() {
	
	if(!$("#BT_KEYNO").val() || !$("#MN_KEYNO").val()){
		alert("메뉴를 선택해주세요")
		return false;
	}
	$("#Form").attr("action", "/txap/Board/data/insertView.do");
	$("#Form").submit();
}

function pf_DetailMove(keyno){
	$('#BN_KEYNO').val(keyno);
	$("#Form").attr("action", "/txap/Board/data/detailView.do");
	$("#Form").submit();
}
function pf_HtmlRegistMove(){
	$("#Form").attr("action","/txap/Board/data/html/insertView.do");
	$("#Form").submit();
}


</script>