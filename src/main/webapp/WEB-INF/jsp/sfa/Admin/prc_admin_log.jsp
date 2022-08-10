<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


	<link
      href="https://code.jquery.com/ui/1.12.1/themes/ui-lightness/jquery-ui.css"
      rel="stylesheet"
    />

    <!-- ✅ load jQuery ✅ -->
    <script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>

    <!-- ✅ load jquery UI ✅ -->
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"
      integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"></script>


<style>

section {text-align:center;
		 display: inline-block;		
		}

#mon01{

width : 80px;

}

</style>

<form:form id="Form" name="Form" method="post" action="">
	<section id="widget-grid" >
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="BOARD_TYPE_LIST_1" data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-table"></i>
						</span>
						<h2>발전소 안전관리 현황</h2>
					</header>
					<div class="widget-body" >
						<div class="widget-body-toolbar bg-color-white smart-form">
							<div class="row">
								<section class="col col-2">점검 후 이상 유/무
									<label class="select">
										<select class="form-control input-sm" name="AH_HOMEDIV_C" id="AH_HOMEDIV_C" onchange="pf_getList()">
							              	<option value="">전체</option>
							              	<option value="1">이상 있음</option>
							              	<option value="2">이상 없음</option>
							            </select> <i></i> 
									</label>
								</section>
								<section class="col col-2" style="margin-left: 50px;">시작일시
									<label class="input"> <i class="icon-append fa fa-calendar"></i>
										<input type="text" name="searchBeginDate" id="searchBeginDate" placeholder="시작일시" value="${search.searchBeginDate}">
									</label>
								</section>
								<section class="col" style="text-align:center;line-height:32px;padding-top:18px;">
									~
								</section>
								<section class="col col-2">종료일시
									<label class="input"> <i class="icon-append fa fa-calendar"></i>
										<input type="text" name="searchEndDate" id="searchEndDate" placeholder="종료일시" value="${search.searchEndDate}">
									</label>
								</section>
								<section class="col col-2">검색기간
									<label class="select">
										<select class="form-control input-sm" name="orderCondition" id="searchDate" onchange="pf_searchDate(this.value)">
							              	<option value="">선택하세요.</option>
							                <option value="1" ${search.orderCondition eq '1'? 'selected':'' }>오늘</option>
							                <option value="2" ${search.orderCondition eq '2'? 'selected':'' }>이번달</option>
							                <option value="3" ${search.orderCondition eq '3'? 'selected':'' }>일주일</option>
							                <option value="4" ${search.orderCondition eq '4'? 'selected':'' }>15일</option>
							                <option value="5" ${search.orderCondition eq '5'? 'selected':'' }>1개월</option>
							                <option value="6" ${search.orderCondition eq '6'? 'selected':'' }>2개월</option>
							                <option value="7" ${search.orderCondition eq '7'? 'selected':'' }>3개월</option>
							                <option value="8" ${search.orderCondition eq '8'? 'selected':'' }>6개월</option>
							                <option value="9" ${search.orderCondition eq '9'? 'selected':'' }>1년</option>
							                <option value="10" ${search.orderCondition eq '10'? 'selected':'' }>전체</option>
							            </select> <i></i>
									</label>
								</section>
<!-- 								<section class="col col-1">발전소 명 -->
<!-- 									<label class="input"> -->
<%-- 										<input type="text" name="UI_ID" id="UI_ID" placeholder="발전소 명" value="${search.UI_ID}"> --%>
<!-- 									</label> -->
<!-- 								</section> -->
								<section class="col col-2">
									<div class="btn-group" style="width: 100%;padding-top:18px;">  
											<button class="btn btn-sm btn-primary" onclick="pf_LinkPage()" type="button" style="margin-right:10px;">
												<i class="fa fa-floppy-o"></i> 조회
											</button>
									</div>
								</section>
							</div>
						</div>
						<div style="margin-top: 20px;">
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="10"  ${search.orderCondition eq '10'? 'selected':'' }  onclick = "pf_searchDate(this.value)">전체</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="13"  ${search.orderCondition eq '13'? 'selected':'' }  onclick = "pf_searchDate(this.value)">1월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="14"  ${search.orderCondition eq '14'? 'selected':'' }  onclick = "pf_searchDate(this.value)">2월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="15"  ${search.orderCondition eq '15'? 'selected':'' }  onclick = "pf_searchDate(this.value)">3월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="16"  ${search.orderCondition eq '16'? 'selected':'' }  onclick = "pf_searchDate(this.value)">4월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="17"  ${search.orderCondition eq '17'? 'selected':'' }  onclick = "pf_searchDate(this.value)">5월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="18"  ${search.orderCondition eq '18'? 'selected':'' }  onclick = "pf_searchDate(this.value)">6월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="19"  ${search.orderCondition eq '19'? 'selected':'' }  onclick = "pf_searchDate(this.value)">7월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="20"  ${search.orderCondition eq '20'? 'selected':'' }  onclick = "pf_searchDate(this.value)">8월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="21"  ${search.orderCondition eq '21'? 'selected':'' }  onclick = "pf_searchDate(this.value)">9월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="22"  ${search.orderCondition eq '22'? 'selected':'' }  onclick = "pf_searchDate(this.value)">10월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="23"  ${search.orderCondition eq '23'? 'selected':'' }  onclick = "pf_searchDate(this.value)">11월</button>
										<button type="button" class="btn btn-sm btn-default" name="mon01" id="mon01" value ="24"  ${search.orderCondition eq '24'? 'selected':'' }  onclick = "pf_searchDate(this.value)">12월</button>
										
							          
						</div>
						<div class="table-responsive">
							<jsp:include page="/WEB-INF/jsp/sfa/include/search/pra_search_header_paging.jsp" flush="true">
								<jsp:param value="/sfa/sfaAdmin/pagingAjaxAdmin.do" name="pagingDataUrl" />
						 		<jsp:param value="/sfa/sfaAdmin/Adminexcelajax.do" name="excelDataUrl" />
							</jsp:include>
							<fieldset id="tableWrap" style="margin-top: 10px;">
							</fieldset>
						</div>
					</div>
				</div>
			</article>
		</div>
	</section>
</form:form>

<script type="text/javascript">
function pf_searchDate(object){
	pf_settingSearchDate(object);
	pf_LinkPage();
}

//이전달로 이동 
$('.go-prev').on('click', function() { thisMonth = new Date(currentYear-1, currentMonth, 1); 
renderCalender(thisMonth); }); 

// 다음달로 이동 
$('.go-next').on('click', function() { thisMonth = new Date(currentYear+1, currentMonth, 1); 
renderCalender(thisMonth); });

</script>