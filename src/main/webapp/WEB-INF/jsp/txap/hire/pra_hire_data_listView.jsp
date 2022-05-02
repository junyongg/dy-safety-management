<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<style>
#dt_basic tbody tr{cursor: pointer;}
</style>
<input type="hidden" name="seqbo" id="seqbo"/>
<div id="content">
	<form:form id="form2" name="form2" method="post" action="">
		<input type="hidden" id="htmlStr" name="htmlStr">
		<input type="hidden" id="KEYNO" name="KEYNO">
	</form:form>

	<form:form id="Form" name="Form" method="post" action="" class="form-inline">

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
												
												<select class="form-control input-sm" id="BN_KEYNO" name="BN_KEYNO" onchange="UserView();">
													<option value="">채용 공고 선택</option>
													<c:forEach items="${HireBoard }" var="model"> 
		 								                <option value="${model.BN_KEYNO }" >${model.BN_TITLE }</option> 
		 								              </c:forEach>
												</select> 
											</div>
										</div>																								
									 
										<!-- <div class="col-sm-12 col-md-4 text-align-right">
											<div class="btn-group">  
												<button class="btn btn-sm btn-primary" type="button" onclick="pf_RegistMove()" style="margin-right:10px;">
													<i class="fa fa-plus"></i> 게시물 등록
												</button>
											</div>
										</div> -->
									</div>
								</div> 
								<div class="table-responsive">
									<jsp:include page="/WEB-INF/jsp/txap/include/search/pra_search_header_paging.jsp" flush="true">
										<jsp:param value="/txap/hire/pageAjax.do" name="pagingDataUrl" />
										<jsp:param value="/txap/hire/excelAjax.do" name="excelDataUrl" />
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

<div id="popup" style="display: none">

</div>

<script type="text/javascript">

function UserView(){
	pf_LinkPage();
}

function printPage(keyno){
	$("#TH_KEYNO").val(keyno);
	$.ajax({
		type : "POST" ,
		url : "/hire/UserPrint.do" ,
		data :  $('#Form').serializeArray() ,
		async:false ,
		success : function(data){
			$('#popup').html(data);
			printing();
		},
		error : function(xhr, status, error) {
            alert("에러발생");
      }

	}).done(function(){
		cf_loading_out();
	})
}

function AgreeDown(){
	$.ajax({
		type : "POST" ,
		url : "/hire/UserAgree.do" ,
		async:false ,
		success : function(data){
			$('#popup').html(data);
			printing();
		},
		error : function(xhr, status, error) {
            alert("에러발생");
      }

	}).done(function(){
		cf_loading_out();
	})
}

function PDFDownload(key,fskey){
	if(fskey == ''){
		fskey = PDFREDOWN(key);
	}else{
		location.href="/async/MultiFile/download.do?FS_KEYNO=" + fskey;
	}
}

function PDFREDOWN(key){
	$.ajax({
		type : "POST" ,
		url : "/hire/UserPrint.do?${_csrf.parameterName}=${_csrf.token}" ,
		data :  {
			"TH_KEYNO" : key
		} ,
		async:false ,
		success : function(data){
			pdfdown(key,data);
		},
		error : function(xhr, status, error) {
            alert("에러발생");
            return false;
      }
	}).done(function(){
		cf_loading_out();
	});
}

function pdfdown(key,data){
	$.ajax({
		type : "POST" ,
		url : "/hire/PdfAjax2.do?${_csrf.parameterName}=${_csrf.token}" ,
		data :  {
			"htmlStr" : data,
			"KEYNO" 	: key
		},
		async:false ,
		success : function(data){
			location.reload();
		},
		error : function(xhr, status, error) {
            alert("에러발생");
            return false;
      }
	}).done(function(){
		cf_loading_out();
	});
	
	
	location.reload();
}

function PDFAllDownload(keyno){
	$("#Form").attr("action","/txap/hire/PDFALLAjax.do");
	$("#TH_BNKEYNO").val(keyno);
	$("#TITLE").val($("#BN_KEYNO option:checked").text());
	$("#Form").submit();
}
</script>