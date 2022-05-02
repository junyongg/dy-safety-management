<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<!-- widget grid -->

<form:form id="Form" name="Form" method="post" action="" class="form-inline" role="form">
<section id="widget-grid" class="">
	<div class="row">
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-0"
				data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>신청프로그램 리스트</h2>
				</header>
				<div class="widget-body" >
					<div class="widget-body-toolbar bg-color-white">
						<div class="alert alert-info no-margin fade in">
							<button type="button" class="close" data-dismiss="alert">×</button>
							신청프로그램 리스트를 확인합니다.
						</div> 
					</div>
					<div class="widget-body-toolbar bg-color-white">
						<div class="row"> 
							<div class="col-sm-12 col-md-2 text-align-right" style="float:right;">
								<div class="btn-group">  
									<button class="btn btn-sm btn-primary" type="button" onclick="pf_openAddApplication();" >
										<i class="fa fa-plus"></i>프로그램 등록
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<jsp:include page="/WEB-INF/jsp/txap/include/search/pra_search_header_paging.jsp" flush="true">
							<jsp:param value="/txap/program/application/applicationPaingAjax.do" name="pagingDataUrl" />
							<jsp:param value="/txap/program/application/applicationExcelAjax.do" name="excelDataUrl" />
						</jsp:include>
						<fieldset id="tableWrap">
						</fieldset>
					</div>
				</div>
			</div>
		</article>
	</div>
</section>

</form:form>
<!-- end widget grid -->


<script>
//신청프로그램 추가
function pf_openAddApplication(key){
	if(key != null && key != ""){
		location.href="/txap/program/application/updateView.do?key="+key;		
	}else{
		location.href="/txap/program/application/insertView.do";		
	}
}

function pf_deadline(obj, key){
	
	if(confirm("해당 프로그램을 마감처리 하시겠습니까?")){
		$.ajax({
			type: "POST",
			url: "/txap/program/application/application/deadline.do",
			data: {
				"AP_KEYNO" : key
			},
			async:false,
			success : function(){
				alert("마감처리 처리되었습니다.");
				location.reload();
				
			},
			error: function(){
				alert('알수없는 에러 발생. 관리자한테 문의하세요.')
			}
		});
	}
}

</script>
