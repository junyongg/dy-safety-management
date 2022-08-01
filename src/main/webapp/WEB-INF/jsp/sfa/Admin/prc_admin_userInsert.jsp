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

						<form:form id="Form2" class="form-horizontal" name="Form2"  method="post">
							<legend>
								<div class="widget-body-toolbar bg-color-white">
									<div class="alert alert-info no-margin fade in">
										<button type="button" class="close" data-dismiss="alert">×</button>
										안전관리 발전소 등록
									</div>
								</div>
							</legend>


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
												<td>수전전압/용량</td>
												<td><input type="text" class="form-control check" id="SU_SA_SUJEONV" name="SU_SA_SUJEONV">
													<input type="text" class="form-control check" id="SU_SA_SUJEONKW" name="SU_SA_SUJEONKW"></td>
												<td>발전전압/용량</td>
												<td><input type="text" class="form-control check" id="SU_SA_BALV" name="SU_SA_BALV">
													<input type="text" class="form-control check" id="SU_SA_BALKW" name="SU_SA_BALKW"></td>
												<td>태양광</td>
												<td><input type="text" class="form-control check2" id="SU_SA_SOLARV" name="SU_SA_SOLARV" >
													<input type="text" class="form-control check2" id="SU_SA_SOLARKW" name="SU_SA_SOLARKW" ></td>
											</tr>
											<tr>
												<td>계약용량</td>
												<td><input type="text" class="form-control check2" id="SU_SA_TRANSVOLUM" name="SU_SA_TRANSVOLUM" ></td>
												<td>점검종별</td>
												<td><input type="text" class="form-control check2" id="SU_SA_ADMINTYPE" name="SU_SA_ADMINTYPE"></td>
												<td>발전소명</td>
												<td><input type="text" class="form-control check2" id="SU_SA_SULBI" name="SU_SA_SULBI"></td>
											</tr>
											<tr>
												<td>전화번호</td>
												<td><input type="text" class="form-control check2" id="SU_SA_PHONE" name="SU_SA_PHONE"></td>
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
	$("#SU_SA_SUJEONV").val("")
	$("#SU_SA_SUJEONKW").val("")
	$("#SU_SA_BALV").val("")
	$("#SU_SA_BALKW").val("")
	$("#SU_SA_SOLARV").val("")
	$("#SU_SA_SOLARKW").val("")
	$("#SU_SA_TRANSVOLUM").val("")
	$("#SU_SA_ADMINTYPE").val("")
	$("#SU_SA_SULBI").val("")
	$("#SU_SA_PHONE").val("")
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
        	
        	$("#SU_SA_SUJEONV").val(result.SU_SA_SUJEONV)
        	$("#SU_SA_SUJEONKW").val(result.SU_SA_SUJEONKW)
        	$("#SU_SA_BALV").val(result.SU_SA_BALV)
        	$("#SU_SA_BALKW").val(result.SU_SA_BALKW)
        	$("#SU_SA_SOLARV").val(result.SU_SA_SOLARV)
        	$("#SU_SA_SOLARKW").val(result.SU_SA_SOLARKW)
        	$("#SU_SA_TRANSVOLUM").val(result.SU_SA_TRANSVOLUM)
        	$("#SU_SA_ADMINTYPE").val(result.SU_SA_ADMINTYPE)
        	$("#SU_SA_SULBI").val(result.SU_SA_SULBI)
        	$("#SU_KEYNO").val(result.SU_KEYNO)
        	$("#SU_SA_PHONE").val(result.SU_SA_PHONE)
        	
        
        	
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



</script>