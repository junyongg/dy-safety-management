<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<style>

pre {background-color: inherit !important;}

</style>

<form:form id="Form" name="Form" method="post" action="">
	<input type="hidden" name="TPS_MN_KEYNO" value="${resultData.TPS_MN_KEYNO }" />
	<input type="hidden" name="MenuName" value="${MenuName}" />
	<section id="widget-grid" >
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="BOARD_TYPE_LIST_1" data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-table"></i>
						</span>
						<h2>페이지 평가</h2>
					</header>
					<div class="widget-body " >
						<div class="widget-body-toolbar bg-color-white">
							<div class="alert alert-info no-margin fade in">
								<button type="button" class="close" data-dismiss="alert">×</button>
								${MenuName} 페이지 평가 내역
							</div> 
						</div>
						<div class="table-responsive">
							<jsp:include page="/WEB-INF/jsp/txap/include/search/pra_search_header_paging.jsp" flush="true">
								<jsp:param value="/txap/operation/pageResearch/detail/pagingAjax.do" name="pagingDataUrl" />
								<jsp:param value="/txap/operation/pageResearch/detail/excelAjax.do" name="excelDataUrl" />
							</jsp:include>
							<fieldset id="tableWrap">
							</fieldset>
							<div class="form-actions" style="margin: 25px 0 0 0;">
							<div class="row">
								<div class="col-md-12">
									<button class="btn btn-primary" type="button" onclick="location.href='/txap/operation/pageResearch.do'">
										목록
									</button>
								</div>
							</div>
						</div>
						</div>
					</div>
				</div>
			</article>
		</div>
	</section>
</form:form>