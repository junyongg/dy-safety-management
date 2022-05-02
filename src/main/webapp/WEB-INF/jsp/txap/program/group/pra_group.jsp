<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


<!-- widget grid -->
<form:form id="Form" name="Form" method="post" action="" class="form-inline" role="form">
<input type="hidden" name="key" id="key">
<section id="widget-grid" class="">
	<div class="row">
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-0"
				data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>단체예약프로그램 목록 조회</h2>

				</header>
				<!-- widget div-->
					<div>
						<!-- widget edit box -->
						<div class="jarviswidget-editbox">
							<!-- This area used as dropdown edit box -->
						</div>
						<!-- end widget edit box -->
						<div class="widget-body-toolbar bg-color-white" style="margin-bottom: 5px;">
							<div class="alert alert-info no-margin fade in" style="text-align: left;">
								<button type="button" class="close" data-dismiss="alert">×</button>
								단체프로그램 리스트를 확인합니다.
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
								<jsp:param value="/txap/program/group/program/pagingAjax.do" name="pagingDataUrl" />
								<jsp:param value="/txap/program/group/program/excelAjax.do" name="excelDataUrl" />
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

<script>
//신청프로그램 추가
function pf_openAddApplication(){
	location.href="/txap/program/group/insertView.do";
}

//프로그램 상세보기
function pf_detail(key){
	$("#key").val(key);
	$("#Form").attr("action", "/txap/program/group/UpdateView.do");
	$("#Form").submit();
}
</script>
