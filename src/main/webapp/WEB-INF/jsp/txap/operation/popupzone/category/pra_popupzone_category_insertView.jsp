<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<%@ include file="/WEB-INF/jsp/common/CodeMirror_Include.jsp" %>

<style>
.columnTitle {
	text-align: center;
	word-break: keep-all;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ccc;
	padding: 5px 0
}

.columnTitle section {
	margin-bottom: 0
}

.option_dp, .selectCodeWrap, .column_size_dp {
	display: none;
}

.column_ul .column_li label{
	width: 20%;
}

.column_ul .column_li input{
	padding-left:10px;
	width: 50%;
}

.column_ul .column_li a{
	margin-left: 20px;
}

label input[type=checkbox].checkbox+span, label input[type=radio].radiobox+span{z-index: 1}

</style>

<script type="text/javascript">

var editor = null;

$(function() {
	
	editor = codeMirror("htmlmixed", "TCGM_FORM");
	pf_columList();
	
	cf_checkbox_checked_val("TCGM_IMG_YN", "N");
	cf_checkbox_checked_val("TCGM_IMG_RESIZE_YN", "N");
	$('.imgResizeYN').hide();
	$('.imgResizeValue').hide();
	if('update' === '${type}') {
		if($('#TCGM_IMG_YN').val() == 'Y') {
			$('.imgResizeYN').show();
			
			if($('#TCGM_IMG_RESIZE_YN').val() == 'Y') {
				$('.imgResizeValue').show();
			}
		}
	}
	
	
	$('#IMG_YN').on('click',function() {
		if ($(this).is(':checked')) {
			$('.imgResizeYN').show();
		} else {
			$('.imgResizeYN').hide();
			$('#IMG_RESIZE_YN').prop('checked', false);
			$('.imgResizeValue').hide();
// 			$('#TCGM_IMG_WIDTH').val(0);
// 			$('#TCGM_IMG_HEIGHT').val(0);
		}
	});
	
	$('#IMG_RESIZE_YN').on('click',function() {
		if ($(this).is(':checked')) {
			$('.imgResizeValue').show();
		} else {
			$('.imgResizeValue').hide();
		}
	});
	
	if("${type}" == "update"){
		
	}else {
		pf_form_change(0);
	}
	
});

function pf_form_change(value){
    var temp = $("#form_data ul").children("li");
    var form_data = $(temp[value]).text();
	
	editor.setValue(form_data);
}

function pf_columList(){
	
	$("#BT_COLUME").empty();
	
	var html = "<ul class='column_ul'>";
	
	var defalut_option = [];
	defalut_option.push({comment : "?????????", dataset : "TLM_KEYNO"});
	defalut_option.push({comment : "????????????(ALT)", dataset : "TLM_ALT"});
	defalut_option.push({comment : "?????????", dataset : "TLM_COMMENT"});
	defalut_option.push({comment : "??????URL", dataset : "TLM_URL"});
	defalut_option.push({comment : "??????????????????", dataset : "TLM_FS_KEYNO"});
	defalut_option.push({comment : "????????????", dataset : "TLM_STARTDT"});
	defalut_option.push({comment : "????????????", dataset : "TLM_ENDT"});
	defalut_option.push({comment : "?????????", dataset : "TLM_REGNM"});
	defalut_option.push({comment : "?????????", dataset : "TLM_REGDT"});
	defalut_option.push({comment : "????????????", dataset : "TLM_USE_YN"});
	defalut_option.push({comment : "????????????", dataset : "TLM_DEL_YN"});
	defalut_option.push({comment : "?????????????????????", dataset : "TLM_TCM_KYENO"});

	for(var i in defalut_option){
		html += "<li class='column_li'><label>"+defalut_option[i].comment+"</label><input type='text' value='" + defalut_option[i].dataset + "' readonly>";
		html += "<div class='btn btn btn-default btn-xs'  onclick='pf_Copy(\"" + defalut_option[i].dataset  + "\")'><i class='fa fa-copy'></i></div></li>";
	}
	
	html += "</ul>";
	$("#BT_COLUME").html(html);
	
}

function pf_categoryInsert(){
	
	if(!pf_checkForm()){
		return false;
	}

	pf_checkBox();
	
// 	return false;
	if(confirm("??????????????? ?????????????????????????")){
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/operation/popupzone/insert.do");
		$("#Form").submit();
	}
	
}

function pf_checkForm(){
	if(!$("#TCGM_MN_HOMEDIV_C").val()){
		alert("??????????????? ???????????????.");
		$("#TCGM_MN_HOMEDIV_C").focus();
		return false;
	}
	
	if(!$("#TCGM_TITLE").val()){
		alert("????????? ???????????????.");
		$("#TCGM_TITLE").focus();
		return false;
	}
	
	if(!editor.getValue()){
		alert("??????????????? ???????????????.");
		$("#TCGM_FORM").focus();
		return false;
	}
	
	if ($('#IMG_RESIZE_YN').is(':checked')) {
		if (!$("#TCGM_IMG_WIDTH").val() || $("#TCGM_IMG_WIDTH").val() == 0) {
			alert("????????? ???????????? width ?????? ?????????????????????.");
			$("#TCGM_IMG_WIDTH").focus();
			return false;
		}
		if (!$("#TCGM_IMG_HEIGHT").val() || $("#TCGM_IMG_HEIGHT").val() == 0) {
			alert("????????? ???????????? height ?????? ?????????????????????.");
			$("#TCGM_IMG_HEIGHT").focus();
			return false;
		}
	}
	
	return true;
}

function pf_checkBox() {
	$('input[type=checkbox]').each(function(i){
		var checkVal = 'Y'
		var checkID = $(this).attr("id");

		if($(this).is(":checked")){
			checkVal = 'Y';
		}else{
			checkVal = 'N';
		}
		$('#TCGM_'+checkID).val(checkVal);
	});
}

function pf_categoryUpdate(){
	
	if(!pf_checkForm()){
		return false;
	}

	pf_checkBox();
	
	if(confirm("???????????????  ?????????????????????????")){
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/operation/popupzone/update.do");
		$("#Form").submit();
	}
	
}

function pf_categoryDelete(){
	if(confirm("??????????????? ?????????????????????????")){
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/operation/popupzone/delete.do");
		$("#Form").submit();
	}
}


function pf_back(){
	history.go(-1);
}

function pf_Copy(content){
	if(cf_copyToClipboard(content)){
		cf_smallBox('success', "?????? ?????????????????????.", 2000);
	}else{
		cf_smallBox('error', "???????????? ????????? ???????????? ?????? ???????????? ?????????.", 3000,'#d24158');
	}
}
	
</script>

<div id="form_data" style="display: none;">
	<ul>
<li id="form_li_data">
&lt;div style="margin: 0 auto; width: 80%;"&gt;
	&lt;ul id="sample"&gt;
	  	&lt;c:forEach items="&#36;&#123;resultList &#125;" var="model"&gt;
			&lt;li&gt;
				&lt;a href="&#36;&#123;model.TLM_URL&#125;" target="_blank"&gt;
					&lt;img src="/resources/img/upload/&#36;&#123;model.FS_FOLDER&#125;/&#36;&#123;model.FS_CHANGENM&#125;.&#36;&#123;model.FS_EXT&#125;" 
						alt="&#36;&#123;model.TLM_ALT&#125;" title="&#36;&#123;model.TLM_COMMENT&#125;"&gt;
				&lt;/a&gt;
			&lt;/li&gt;
	    &lt;/c:forEach&gt;
	&lt;/ul&gt;
&lt;/div&gt;

&lt;script type="text/javascript"&gt;
	$(function() {
		$('#sample').bxSlider({
			auto: true,
			speed: 1000,
			pause: 4000,
			mode: 'fade',
			autoControls: true,
			pager: true,
			touchEnabled : (navigator.maxTouchPoints > 0),
			captions: true
		});
	});
&lt;/script&gt;
</li>
	<c:forEach items="${formDataList }" var="model3" varStatus="status">
	<li><c:out value="${model3.TCGM_FORM }" escapeXml="true"></c:out></li>    
    </c:forEach>
	</ul>
</div>


<div id="content">

	<section id="widget-grid">
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="" data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-table"></i>
						</span>
						<c:if test="${type eq 'insert' }">
						<h2>???????????? ??????</h2>
						</c:if>
						<c:if test="${type eq 'update' }">
						<h2>???????????? ??????</h2>
						</c:if>
					</header>

					<div class="widget-body">

						<form:form id="Form" class="form-horizontal" name="Form" method="post">
							<input type="hidden" name="TCGM_REGNM" value="${userInfo.UI_ID }" />
							<c:if test="${type eq 'update' }">
							<input type="hidden" name="TCGM_KEYNO" value="${TCGM_DATA.TCGM_KEYNO }" />
							</c:if>
							<input type="hidden" name="TCGM_IMG_YN" id="TCGM_IMG_YN" value="${TCGM_DATA.TCGM_IMG_YN }" />
							<input type="hidden" name="TCGM_IMG_RESIZE_YN" id="TCGM_IMG_RESIZE_YN" value="${TCGM_DATA.TCGM_IMG_RESIZE_YN }" />
							
							
							<legend>
								<c:if test="${type eq 'insert' }">
								<h2>???????????? ???????????? </h2>
								</c:if>
								<c:if test="${type eq 'update' }">
								<h2>???????????? ???????????? </h2>
								</c:if>
							</legend>
							
							<fieldset>
								<div class="bs-example necessT">
									<span class="colorR fs12">*????????? ?????? ?????? ???????????????.</span>
								</div>
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> ????????????</label>
									<div class="col-md-6">
										<select class="form-control input-sm" id="TCGM_MN_HOMEDIV_C" name="TCGM_MN_HOMEDIV_C">
							              <option value="">?????? ???????????? ??????</option>
							              <c:forEach items="${homeDivList }" var="model">
							                <option value="${model.MN_KEYNO }" ${TCGM_DATA.TCGM_MN_HOMEDIV_C eq model.MN_KEYNO ? 'selected' : '' } >${model.MN_NAME }</option>
							              </c:forEach>	
							            </select>
									</div>
								</div>
								
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> ??????</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="TCGM_TITLE" name="TCGM_TITLE" value="${TCGM_DATA.TCGM_TITLE }">
									</div>
								</div>
								
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label">????????? ?????? ??????</label>
									<section class="col-md-3 smart-form" >
										<label class="checkbox" style="padding-top:0">
											<input type="checkbox" class="radiobox style-0" name="IMG_YN" id="IMG_YN" value="" ${TCGM_DATA.TCGM_IMG_YN eq 'Y' ? 'checked' : ''}><i></i>
										</label>
									</section>
								
									<label class="col-md-1 control-label imgResizeYN">???????????? ??????</label>
									<section class="col-md-3 smart-form imgResizeYN">
										<label class="checkbox" style="padding-top:0">
											<input type="checkbox" class="radiobox style-0" name="IMG_RESIZE_YN" id="IMG_RESIZE_YN" value="" ${TCGM_DATA.TCGM_IMG_RESIZE_YN eq 'Y' ? 'checked' : ''}><i></i>
										</label>
									</section>
								</div>
								
								<div class="form-group has-feedback imgResizeValue">
									<label class="col-md-1 control-label">width ???(?????? px) </label>
									<section class="col-md-3">
										<input type="number" id="TCGM_IMG_WIDTH" class="form-control" name="TCGM_IMG_WIDTH" value="${TCGM_DATA.TCGM_IMG_WIDTH }"
											oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4" />
									</section>
									<label class="col-md-1 control-label">height ???(?????? px) </label>
									<section class="col-md-3">
										<input type="number" id="TCGM_IMG_HEIGHT" class="form-control" name="TCGM_IMG_HEIGHT" value="${TCGM_DATA.TCGM_IMG_HEIGHT }"
											oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4" />
									</section>
								</div>
								
								<div class="row">
									<div class="form-group has-feedback">
										<label class="col-md-9 control-label"></label>
										<div class="col-md-2">
											<select class="form-control input-sm" id="BMM_FORM_SELECT" onchange="pf_form_change(this.value);">
								              <option value="0">?????????</option>
								              <c:forEach items="${formDataList }" var="model3" varStatus="status">
								              <option value="${status.count }" ${TCGM_DATA.TCGM_KEYNO eq model3.TCGM_KEYNO ? 'selected' : '' }>${model3.FORM_NAME }</option>
								              </c:forEach>
								            </select>
										</div>
										
									</div>
								</div>
								
								<div class="row">
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">?????? ??????</label>
										<div class="col-md-3" id="BT_COLUME" style="height: 400px;border: solid 1px gray;overflow-y: scroll; padding: 10px;">
										
										</div>
												
										<label class="col-md-1 control-label"><span class="nessSpan">*</span> HTML ??????</label>
										<div class="col-md-6">
											<textarea name="TCGM_FORM" id="TCGM_FORM" rows="5" style="width:100%;height:400px;min-width:260px;">${TCGM_DATA.TCGM_FORM}</textarea>
										</div>
									</div>
								</div>
								
								<div class="form-actions">
									<div class="row">
										<div class="col-md-12">
											<c:if test="${type eq 'insert' }">
												<button class="btn btn-sm btn-primary" type="button" onclick="pf_categoryInsert()">??????</button>
											</c:if>
											<c:if test="${type eq 'update' }">
												<button class="btn btn-sm btn-primary" type="button" onclick="pf_categoryUpdate()">??????</button>
												<button class="btn btn-sm btn-danger" type="button" onclick="pf_categoryDelete()">??????</button>
											</c:if>
											<button class="btn btn-sm btn-default" id="Board_Delete" type="button" onclick="pf_back();">??????</button> 
										</div>
									</div>
								</div>
							</fieldset>
						</form:form>
					</div>
				</div>
			</article>
		</div>
	</section>
</div>

