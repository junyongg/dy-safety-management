<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<div id="content">
	<section id="widget-grid">
		<div class="row">
				<form:form id= "Form1" action="">
				<input type="hidden" name="chkvalue" id="chkvalue">
				<article class="col-xs-12 col-sm-12 col-md-12 col-lg-6" id="menu_1">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0"
				data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>발전소 리스트</h2>
				</header>
				<div class="widget-body " >
					<div class="widget-body-toolbar bg-color-white">
						<div class="alert alert-info no-margin fade in">
							<button type="button" class="close" data-dismiss="alert">×</button>
							발전소 리스트를 확인합니다.
						</div> 
					</div>
					<!-- <div class="widget-body-toolbar bg-color-white">
						<div class="row"> 
							<div class="col-sm-12 col-md-2 text-align-right" style="float:right;">
								<div class="btn-group">
									<button class="btn btn-sm btn-primary" type="button" onclick="pf_openInsertPopup();">
										<i class="fa fa-plus"></i> 발전소 등록
									</button> 
								</div>
							</div>
						</div>
					</div> -->
					<div class="table-responsive">
						<jsp:include page="/WEB-INF/jsp/sfa/include/search/pra_search_header_paging.jsp" flush="true">
							<jsp:param value="/sfa/sfaAdmin/USerpagingAjax.do" name="pagingDataUrl" />
						</jsp:include>
						<fieldset id="tableWrap">
						</fieldset>
					</div>
				</div>
			</div>
		</article>
		</form:form>
		
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="" data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-table"></i>
						</span>
					    <h2>발전소 등록</h2>
					</header>

					<div class="widget-body">

						<form:form id="Form2" class="form-horizontal" name="Form2"  method="post" action="" enctype="multipart/form-data">
							<legend>
								<div class="widget-body-toolbar bg-color-white">
									<div class="alert alert-info no-margin fade in">
										<button type="button" class="close" data-dismiss="alert">×</button>
										안전관리 발전소 등록
									</div>
								</div>:
							</legend>
							
							<div class="widget-body-toolbar bg-color-white">
								<div class="row">
									
									<div class="col-sm-6 col-md-2 text-align-right" style="float:right;">
										<div class="btn-group">  
											<button class="btn btn-sm btn" type="button" onclick="excelInsert();" >
												<i class="fa fa-plus"></i>엑셀 등록
											</button>
										</div>
									</div>
									
									<div class="col-sm-6 col-md-2 text-align-right" style="float:right;">
										<div class="btn-group">  
											<input type="file" id="excelFile" name="excelFile">
										</div>
									</div> 
								</div>
							</div>

							<div class="form-group">
									<label class="col-md-3 control-label"><span class="nessSpan">*</span> 발전소 선택</label>
									
									<div class="col-md-6">
										<select class="form-control input-sm select2" id="user" name="user" onchange="providerSelect2(this.value)">
											<option value="0">신규 등록</option>
											<c:forEach items="${safeuserlist }" var="b">
												<option value="${b.SU_KEYNO }">${b.SU_SA_SULBI }</option>
											</c:forEach>
										</select>
									</div>
								</div>


							<div id="myTabContent1"
								class="tab-content padding-10 form-horizontal bv-form">
								<div>
									<table id="" class="table table-bordered table-striped">
										<colgroup>
											<col style="width: 10%;">
											<col style="width: 15%;">
											<col style="width: 10%;">
											<col style="width: 15%;">
											<col style="width: 10%;">
											<col style="width: 15%;">
										</colgroup>
										<tbody>
											<tr>
												<td>발전소 명</td>
												<td><input type="text" class="form-control check" id="SU_SA_SULBI" name="SU_SA_SULBI"></td>
												<td>월별 점검 횟수</td>
												<td><input type="text" class="form-control check2" id="SU_SA_RG" name="SU_SA_RG" ></td>
												<td>발전소 주소</td>
												<td><input type="text" class="form-control check" id="SU_SA_AD" name="SU_SA_AD"></td>
											</tr>
											<tr>
												<td>발전소 용량</td>
												<td><input type="text" class="form-control check2" id="SU_SA_VOLUM" name="SU_SA_VOLUM" ></td>
												<td>발전 전압</td>
												<td><input type="text" class="form-control check2" id="SU_SA_VOLT" name="SU_SA_VOLT"></td>
												<td>CT비</td>
												<td><input type="text" class="form-control check2" id="SU_SA_CT" name="SU_SA_CT"></td>
											</tr>
											<tr>
												<td>인버터 대수</td>
												<td><select class="form-control input-sm" id="SU_SA_INVERTERNUM" name ="SU_SA_INVERTERNUM">
													 <option value="1">1대</option>
													 <option value="3">3대</option>
													 <option value="4">4~20대</option>
													</select></td>
												<td>점검일</td>
												<td><input type="text" class="form-control check2" id="SU_SA_ADMINDATE" name="SU_SA_ADMINDATE"></td>
												<td>계량기 번호1</td>
												<td><input type="text" class="form-control check2" id="SU_SA_METER1" name="SU_SA_METER1"></td>
											</tr>
											<tr>
												<td>계량기 번호2</td>
												<td><input type="text" class="form-control check2" id="SU_SA_METER2" name="SU_SA_METER2"></td>
												<td>사업주 전화번호 1</td>
												<td><input type="text" class="form-control check2" id="SU_SA_PHONE1" name="SU_SA_PHONE1"></td>
												<td>사업주 전화번호 2</td>
												<td><input type="text" class="form-control check2" id="SU_SA_PHONE2" name="SU_SA_PHONE2"></td>
											</tr>
											<tr>	
												<td>시공사 전화번호</td>
												<td><input type="text" class="form-control check2" id="SU_SA_PHONE3" name="SU_SA_PHONE3"></td>
												<td>판넬사 전화번호</td>
												<td><input type="text" class="form-control check2" id="SU_SA_PHONE4" name="SU_SA_PHONE4"></td>
												<td>관리업체 전화번호</td>
												<td><input type="text" class="form-control check2" id="SU_SA_PHONE5" name="SU_SA_PHONE5"></td>
											</tr>
											<tr>
												<td colspan="8">
													<fieldset class="padding-10 text-right" id = "buttonset2"> 
													<div id ="buttondiv2-2" style ="float: right">
<!-- 														<button class="btn btn-sm btn-danger" type="button" onclick="clear()" style="margin-right:10px;"><i class="glyphicon glyphicon-trash"></i> 삭제 -->
<!-- 														</button> -->
													</div>
													<div id = "buttondiv1-2" style ="float: right">
														<input type="hidden" id="buttionType2" name="buttionType2" value="insert">
														<input type="hidden" id="SU_KEYNO" name="SU_KEYNO" value=""> 	
														<button type="button" onclick="providerInsert2();" class="btn btn-sm btn-primary" id="ActionType2"><i class="fa fa-floppy-o"></i> 저장
														</button>
													</div>
													</fieldset>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</article>
		</div>
	</section>
	
</div>


<script type="text/javascript">

function providerSelect2(value){
	if(value == "0"){
		clear2();
		$("#buttondiv2-2").empty();
		$("#ActionType2").html('<i class="fa fa-floppy-o"></i> 저장')
		
		$("#buttionType2").val("insert");
	}else{
		providerSelectmethod2(value);
	}
}

function clear2(){
	$("#SU_SA_SULBI").val("")
	$("#SU_SA_AD").val("")
	$("#SU_SA_RG").val("")
	$("#SU_SA_VOLUM").val("")
	$("#SU_SA_VOLT").val("")
	$("#SU_SA_CT").val("")
	$("#SU_SA_INVERTERNUM").val("")
	$("#SU_SA_PHONE1").val("")
	$("#SU_SA_PHONE2").val("")
}

function providerSelectmethod2(value){
	 $.ajax({
        url: '/sfa/safe/UserSelectAjax.do?${_csrf.parameterName}=${_csrf.token}',
        type: 'POST',
        data: {
        	"SU_KEYNO":value
        },
        async: false,  
        success: function(result) {
        	
        	
        	$("#SU_KEYNO").val(result.SU_KEYNO)
        	$("#SU_SA_SULBI").val(result.SU_SA_SULBI)
        	$("#SU_SA_AD").val(result.SU_SA_AD)
        	$("#SU_SA_RG").val(result.SU_SA_RG)
        	$("#SU_SA_VOLUM").val(result.SU_SA_VOLUM)
        	$("#SU_SA_VOLT").val(result.SU_SA_VOLT)
        	$("#SU_SA_CT").val(result.SU_SA_CT)
        	$("#SU_SA_INVERTERNUM").val(result.SU_SA_INVERTERNUM)
        	$("#SU_SA_ADMINDATE").val(result.SU_SA_ADMINDATE)
        	$("#SU_SA_METER1").val(result.SU_SA_METER1)
        	$("#SU_SA_METER2").val(result.SU_SA_METER2)
        	$("#SU_SA_PHONE1").val(result.SU_SA_PHONE1)
        	$("#SU_SA_PHONE2").val(result.SU_SA_PHONE2)
        	$("#SU_SA_PHONE3").val(result.SU_SA_PHONE3)
        	$("#SU_SA_PHONE4").val(result.SU_SA_PHONE4)
        	$("#SU_SA_PHONE5").val(result.SU_SA_PHONE5)
        
        	
        	$("#buttondiv2-2").html('<button class="btn btn-sm btn-danger" type="button" onclick="supdeleteInfo();" style="margin-right:10px;"><i class="glyphicon glyphicon-trash"></i> 삭제</button>')
        	$("#ActionType2").html('<i class="glyphicon glyphicon-refresh"></i> 수정')
        	$("#buttionType2").val("update");
        	
        },
        error: function(){
        	alert("발전소 선택 에러");
        }
	}); 
}

function providerInsert2(){
	
	//if(!validationCheck2()) return false
	
	 $.ajax({
        url: '/sfa/safe/UserActionAjax.do?${_csrf.parameterName}=${_csrf.token}',
        type: 'POST',
        data: $("#Form2").serialize(),
        async: false,  
        success: function(result) {
        	alert(result);
        	location.reload();
        },
        error: function(){
        	alert("공급자 선택 에러");
        }
	}); 
}

function supdeleteInfo(){
	
	if(confirm("현재 발전소를 삭제하시겠습니까?")){
	
	$.ajax({
		type: "POST",
		url: '/sfa/safe/UserDelete.do?${_csrf.parameterName}=${_csrf.token}',
		async: false,
		data: $('#Form2').serializeArray(),
		success : function(data){
			location.reload();
			alert(data);
		}, 
		error: function(){
			
		}
	}); 
	
	}else
		return false;
	
}

function excelInsert(){
	alert("Dd");
	$("#Form2").attr("action","/sfa/safe/insertExcel.do?${_csrf.parameterName}=${_csrf.token}");
	$("#Form2").submit();

}
</script>