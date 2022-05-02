<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>


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
					<h2>프로그램 신청자 조회</h2>

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
							프로그램 신청자 리스트를 확인합니다.
						</div> 
					</div>
					<div class="table-responsive">
						<jsp:include page="/WEB-INF/jsp/txap/include/search/pra_search_header_paging.jsp" flush="true">
							<jsp:param value="/txap/program/application/applicationApply/pagingAjax.do" name="pagingDataUrl" />
							<jsp:param value="/txap/program/application/applicationApply/excelAjax.do" name="excelDataUrl" />
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

<script>
//프로그램 상세보기
function pf_detail(key, type){
	$("#key").val(key);
	if(type == 'U'){
		$("#Form").attr("action", "/txap/program/application/applicationApplyDetail.do");
	}else if(type == 'M'){
		$("#Form").attr("action", "/txap/program/application/updateView.do");
	}
	$("#Form").submit();
} 
</script>
