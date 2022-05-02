<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<style>
    
 .visitor_bar{
	position: relative;
	height: 20px;
	margin:0;
}
.visitor_bar span {
    position: absolute;
  	top:6px;
    left: 0;
    height: 15px;
    background: #ddd;
}
.footTr{ 
    background: #878787;
	color: #fff;
}
 .footTd{text-align: center;}
    
</style>
<div id="content">
	<section id="widget-grid" class="">
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="chart_page" data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-bar-chart-o"></i>
						</span>
						<h2>메뉴별 통계 그래프</h2>
					</header>
					<div class="widget-body">
						<form:form id="Form" name="Form" method="post" class="smart-form">
							<input type="hidden" name="searchbot" value="${searchbot }">
							<div class="bg-color-white padding-10">
								<div class="row">
									<section class="col col-2">
										<label class="label">시작</label> <label class="input"> <i class="icon-append fa fa-calendar"></i> <input type="text" class="datepic" id="visitorSearchStartDate" name="STDT" placeholder="검색 일자" readonly="readonly">
										</label>
									</section>
									<section class="col col-2">
										<label class="label">끝</label> <label class="input"> <i class="icon-append fa fa-calendar"></i> <input type="text" class="datepic" id="visitorSearchEndDate" name="ENDT" placeholder="검색 일자" readonly="readonly">
										</label>
									</section>
									<section class="col col-2">
										<label class="label">접속 단말기 선택</label>
										<select class="form-control input-sm" id="DEVICE" name="DEV">
											<option value="0">적용 단말기 선택</option>
											<option value="P">PC 보기</option>
											<option value="M">MOBILE 보기</option>	
										</select>
									</section>
									<section class="col col-2">
										<label class="label">홈페이지 선택</label>
										<select class="form-control input-sm" id="HOMEDIV" name="HOME_DIV">
											<option value="0">적용 홈페이지 선택</option>
											<c:forEach items="${homeDivList }" var="model">
												<option value="${model.MN_KEYNO }">${model.MN_NAME }</option>
												<c:if test="${model.MN_KEYNO eq menu.MN_HOMEDIV_C }">
													<c:set var="HOMEDIV_C_NM" value="${model.MN_NAME }" />
												</c:if>
											</c:forEach>
										</select>
									</section>
									<section class="col col-3">
										<label class="label">&nbsp;</label>
										<div class="btn-group">
											<button class="btn btn-sm btn-primary" onclick="getHtml()" type="button" style="margin-right:10px;">
												<i class="fa fa-floppy-o"></i> 조회
											</button>
											<button class="btn btn-sm btn-primary" onclick="pf_download()" type="button">
												<i class="fa fa-floppy-o"></i> 엑셀
											</button>
										</div>
									</section>
								</div>
							</div>
						</form:form>
						<div class="tab-content">
							<table class="table table-bordered table-hover" id="maintable" style="width:100%;">
								<thead>
									<tr>
										<th width="10%">순위</th>
										<th width="10%">홈페이지</th>
										<th width="10%">메뉴</th>
										<th class="text-center" width="50%">그래프</th>
										<th width="10%">카운트</th>
										<th width="10%">퍼센트</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
					<!--2번째 탭컨텐츠끝  -->
				</div>
		</div>
	</article>
</div>
<script src="/resources/smartadmin/js/plugin/horizontal/jquery.horizBarChart.js"></script>

<script type="text/javascript">
var applicationTable = null;


$(document).ready(function(){
	
	datepickerOption.onSelect = function(selectedDate) {
		$('#visitorSearchEndDate').val($('#LC_STDT').val());
		$('#visitorSearchEndDate').datepicker('option', 'minDate', selectedDate);
	} 
	$('#visitorSearchStartDate').datepicker(datepickerOption)
	datepickerOption.onSelect = function(selectedDate) {
		$('#visitorSearchStartDate').datepicker('option', 'maxDate', selectedDate);
	}
	$('#visitorSearchEndDate').datepicker(datepickerOption);
	
	//checkTodate(); //날짜 초기화
	getHtml();

}); 

function checkTodate() {
	var d = new Date();
	var thisDate = leadingZeros(d.getFullYear(), 4) + '-'
			+ leadingZeros(d.getMonth() + 1, 2) + '-'
			+ leadingZeros(d.getDate(), 2);
	$('#visitorSearchStartDate').val(thisDate);
	$('#visitorSearchEndDate').val(thisDate);
}

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();
	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++)
			zero += '0';
	}
	return zero + n;
}

//비동기로 ajax 조회
function getHtml() {
	$.ajax({
		type : "post",
		data : $('#Form').serialize(),
		url : "/txap/statistics/menucount/pagingAjax.do",
		async : false,
		success : function(data, textStatus, xhr) {
			if(applicationTable){
				applicationTable.destroy();
			}
			$("#maintable tbody").empty().html(data);
			$(document).find('.chart').horizBarChart({
		        selector: '.bar',
		        speed: 500
		    });
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}

function pf_download(){
	$("#Form").attr("action", "/txap/statistics/menucount/excelAjax.do");
	$("Form").submit();
}

</script>
