<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  import="java.util.*" %>

<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>

<style>
	.btn_margin{
	 margin: 10px;
	}
	
	.center_box{
	 width : 80%; 

	}
	
	.full_box{
	 width: 100%;
	}
	
	.contents_box{
	 width: 70%;
	 height: 30%; 
	}
	
	.img_box{
	 border: 1px solid gray;
	 margin-top : 10px;
	 padding : 10px;
	 width : 70%;
	 height: 30%;	 
	}
	
	.popup_save{
	 position : relative;
	 left : 300px;
	 bottom: 1px;
	}
	
	.popup_margin{
	 margin: 8px;
	}
	.date_margin{
	 margin-top: 10px;
	 margin-bottom: 10px;
	}
	
	
	#MAINDIV, #SUBDIV1, #SUBDIV2, .homePoptype {display:none;}

	#view_background {width:100%;height:193px;border:1px solid #000;background-size:100% 100%;}
	#view_title {margin-top:30px;text-align: center;font-size:44px;font-weight: 500}
	#view_comment {margin-top:20px;text-align: center;font-size:19px;max-width:70%;display: block;margin: 0 auto;letter-spacing: -1px;line-height: 27px;font-weight: 400}
	
</style>

<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row" >

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-6" >
			<!-- Widget ID (each widget will need unique ID)-->
			<form:form id="frm" name="frm" enctype="multipart/form-data" action="/txap/operation/popup/insert.do?${_csrf.parameterName}=${_csrf.token}"  method="post">
			<input type="hidden" name="PI_KEYNO" id="PI_KEYNO" value="${popup.PI_KEYNO }">
			<input type="hidden" name="PI_MN_KEYNO" id="PI_MN_KEYNO" value="${popup.PI_MN_KEYNO }">
			<input type="hidden" name="PI_MN_TYPE" id="PI_MN_TYPE" value="${popup.PI_MN_TYPE }">
			<input type="hidden" name="PI_FS_KEYNO" id="PI_FS_KEYNO" value="${popup.PI_FS_KEYNO }">
			
			<input type="hidden" name="resize" id="resize" value="${resize }">
            <c:if test="${not empty popup }">
            <input type="hidden" name="PI_TYPE" value="${popup.PI_TYPE }">
            <input type="hidden" name="PI_DIVISION" value="${popup.PI_DIVISION }">
            </c:if>
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>?????? ??????</h2>
				</header>
				
				<div class="widget-body form-horizontal">
				<fieldset>
					<div class="bs-example necessT">
				         <span class="colorR fs12">*????????? ?????? ?????? ???????????????.</span>
				     </div>
					<div class="form-group">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> ?????? ??????</label>
						<div class="col-md-8">
							<input class="form-control checkTrim" name="PI_TITLE" id="PI_TITLE" type="text" value="<c:out value='${popup.PI_TITLE }' escapeXml='true'/>" maxlength="100">
						</div>
						</div>
							<div class="form-group">
								<label class="col-md-2 control-label"><span
									class="nessSpan">*</span>????????? ??????</label>
								<input class="form-control tagsinput" value="" data-role="tagsinput" style="display: none;">
									<div class="col-md-8">
										<div id="selected_menu" class="bootstrap-tagsinput">
										<script type="text/javascript">
											var selected_popup_list = [];
										</script>
										<c:if test="${not empty popup1}">
										<c:forEach items="${popup1 }" varStatus="status" >
													<input class="delete_${status.count+100}" type="hidden" name="MN_MENU_TITLE"
														value="${popup1[status.count-1].MN_HOMEDIV_C }" />
													<input class="delete_${status.count+100}" type="hidden" name="MN_SUB_TITLE"
														value="${popup1[status.count-1].MN_KEYNO }" />
														
													<span class="tag label label-info" name="delete_${status.count+100}">
														<div class="a">${popup1[status.count-1].MAIN_NAME }</div>
														<div class="b"> ${popup1[status.count-1].SUB_NAME }</div>
													<span onclick="delete_span(${status.count+100})" data-role="remove"></span></span>
											<script type="text/javascript">
												selected_popup_list.push('${popup1[status.count-1].MAIN_NAME }')
												selected_popup_list.push('${popup1[status.count-1].SUB_NAME }')
												selected_popup_list.push('${status.count+100}')
											</script>
										</c:forEach>
										</c:if>
										</div>
									</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label"><span
									class="nessSpan">*</span> ?????? ??????</label>
								<div class="col-md-8">
									<input class="form-control" name="PI_LINK" id="PI_LINK"
										type="text" value="${popup.PI_LINK }"
										placeholder="http:// or https:// ?????? ????????????????????????." maxlength="200">
								</div>
							</div>
						
					<div class="row">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> ??????</label>
						
						<div class="col-md-4 smart-form">
						<label class="radio">
							<input type="radio" id="start_date" name="date_select" value="Y" onclick="pf_date_use('Y')" ${(not empty popup.PI_STARTDAY) ? 'checked':'' }>
							<i style="margin-top: 7px;"></i>??????</label>
						<label class="radio">
							<input type="radio" id="end_date" name="date_select" value="N" onclick="pf_date_use('N')"${(empty popup || popup.PI_ENDDAY eq '????????????') ? 'checked':'' }>
							<i style="margin-top: 7px;"></i>?????? ??????</label>
						</div>
						
						<div class="col-md-2 smart-form" id="date_1">????????????
							<label class="input"> <i class="icon-append fa fa-calendar"></i>
								<input type="text" name="PI_STARTDAY" id="PI_STARTDAY" placeholder="????????????" data-dateformat="yy-mm-dd" class="datepicker " value="${popup.PI_STARTDAY }">
							</label>
						</div>
						<div class="col-md-2 smart-form" id="date_2">????????????
							<label class="input"> <i class="icon-append fa fa-calendar"></i>
								<input type="text" name="PI_ENDDAY" id="PI_ENDDAY" placeholder="????????????" data-dateformat="yy-mm-dd" class="datepicker " value="${popup.PI_ENDDAY }">
							</label>
						</div>
					</div>
					
					<div class="form-group" style="margin-top: 10px;">
						<label class="col-md-2 control-label">?????? ??????</label>
						<div class="col-md-8">
							<c:if test="${empty popup }">
							<div class="smart-form">
								<div class="inline-group">
									<label class="radio">
										<input type="radio" name="PI_DIVISION" value="W" onclick="pf_popType('W')"${(empty popup || popup.PI_DIVISION eq 'W') ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>???????????? ??????</label>
									<label class="radio">
										<input type="radio" name="PI_DIVISION" value="B" onclick="pf_popType('B')" ${popup.PI_DIVISION eq 'B' ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>????????????</label>
								</div>
							</div>
							</c:if>
							<c:if test="${not empty popup }">
							<input class="form-control" type="text" value="${popup.PI_DIVISION eq 'W' ? '???????????? ??????':'????????????'  }" readonly="readonly">
							</c:if>
						</div>
					</div>
					
					<div class="form-group homePoptype" style="margin-top: 10px;">
						<label class="col-md-2 control-label">????????? ?????? ??????</label>
						<div class="col-md-4">
							<c:if test="${empty popup }">
							<div class="smart-form">
								<div class="inline-group">
									<label class="radio">
										<input type="radio" name="PI_TYPE" value="A" ${(empty popup || popup.PI_TYPE eq 'A') ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>????????????</label>
									<label class="radio">
										<input type="radio" name="PI_TYPE" value="B" ${popup.PI_TYPE eq 'B' ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>????????????</label>
								</div>
							</div>
							</c:if>
							<c:if test="${not empty popup }">
							<input class="form-control" type="text" value="${popup.PI_TYPE eq 'A' ? '????????????':'????????????'  }" readonly="readonly">
							</c:if>
						</div>
					</div>
				</fieldset>
				
				<legend></legend>
				<fieldset class="popupType popupTypeW"> 
					<div class="form-group">
						<label class="col-md-2 control-label">?????? ??????</label>
						<div class="col-md-10">
						     <textarea style="width:100%;height:400px;min-width:260px;" name="PI_CONTENTS" id="PI_CONTENTS" placeholder="???????????? ???????????? ??????, ???????????? ????????? ?????? ?????? ????????? ???????????????.">${popup.PI_CONTENTS }</textarea>
						     <div class="note" style="color: red;">(???????????? ???????????? ??????, ???????????? ????????? ?????? ?????? ????????? ???????????????. ???????????? ?????? ?????? ????????? ????????? ???????????? ????????????.)
				         	</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">?????? ?????????</label>
						<section class="col-md-10 smart-form">
						<div class="input input-file">
							<span class="button">
								<input type="file" id="fileW" name="fileW" onchange="cf_imgCheckAndPreview('fileW')">Browse
							</span>
							<input type="text" placeholder="???????????? ?????????????????????" readonly="" id="fileW_text" value="${popup.FS_ORINM }">
						</div>
				   		 <div class="note" style="color: red;">(???????????? ????????? ???????????? ?????? ????????? 300 x 300 px ??????, ?????? ????????? ???????????? ???????????? ????????? ???????????????.<br>
				   		                                                                        ???????????? ?????? ?????? ?????? ?????? ????????? ?????? ?????? ???????????? ?????????.)
				         </div>
				         </section>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> ?????? ??????</label>
						<div class="col-md-5">??????
							<input class="form-control" placeholder="200" name="PI_TOP_LOC" id="PI_TOP_LOC" type="number" value="${popup.PI_TOP_LOC }" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="4">
							<div class="note" style="color: red;">
								(200px ????????? ???????????? ?????? ?????????, 200px ???????????? ??????????????? ????????????.)
					         </div>
						</div>
						<div class="col-md-5">??????
							<input class="form-control" placeholder="200" name="PI_LEFT_LOC" id="PI_LEFT_LOC" type="number" value="${popup.PI_LEFT_LOC }" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="4">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> ?????? ??????</label>
						<div class="col-md-5">??????
							<input class="form-control" placeholder="300" name="PI_WIDTH" id="PI_WIDTH" type="number" value="${popup.PI_WIDTH }" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="4">
							<div class="note" style="color: red;">
								(200px ????????? ???????????? ?????? ?????????, 200px ???????????? ??????????????? ????????????.)
					         </div>
						</div>
						<div class="col-md-5">??????
							<input class="form-control" placeholder="300" name="PI_HEIGHT" id="PI_HEIGHT" type="number" value="${popup.PI_HEIGHT }" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="4">
						</div>
					</div>
				</fieldset>
				
				<fieldset class="popupType popupTypeA">
					<div class="form-group">
						<label class="col-md-2 control-label">?????? ?????????</label>
						<section class="col-md-4 smart-form">
						<div class="input input-file">
							<span class="button">
<!-- 								<input type="file" id="file" name="file" onchange="$('#filetext').val(this.value)">Browse -->
								<input type="file" id="fileA" name="fileA" onchange="cf_imgCheckAndPreview('fileA')">Browse
							</span>
							<input type="text" placeholder="???????????? ?????????????????????" readonly="" name="fileA_text" id="fileA_text" value="${popup.FS_ORINM }">
						</div>
				   		 <div class="note" style="color: red;">(????????? ???????????? 1920 x 193 ????????? ???????????? ???????????? ???????????? ?????????????????????.)
				         </div>
				         </section>
				         <section class="col-md-4 smart-form">
				         	<label class="checkbox" style="padding-top:0">
				         	
							<c:choose>
								<c:when test="${popup.PI_RESIZE_CHECK eq 'N'}">
									<input type="checkbox" name="file_resize" value="Y" > 
								</c:when>
								<c:otherwise>
									<input type="checkbox" name="file_resize" value="Y" checked="checked">
								</c:otherwise>
							</c:choose>
							<i></i>?????? ???????????? ??????</label>
				         </section>
					</div>
				</fieldset>
				<fieldset class="popupType popupTypeB">
					<div class="form-group">
						<label class="col-md-2 control-label">?????? ??????</label>
						<div class="col-md-4">
							<input class="form-control" name="PI_TITLE2" id="PI_TITLE2" type="text" value="${popup.PI_TITLE2 }" maxlength="50" placeholder="?????????" onkeyup="pf_changeText(this.value,'T')">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">?????? ??????</label>
						<div class="col-md-6">
							<div class="smart-form">
								<label class="textarea"> 										
									<textarea rows="3" class="custom-scroll" name="PI_COMMENT" id="PI_COMMENT" onkeyup="pf_changeText(this.value,'C')" placeholder="?????? ????????? ?????????????????? ????????? ????????? ?????????, ????????? ????????? ????????? ?????????. ????????? ????????? ????????? ???????????? ????????? ????????? ???????????? ?????? ????????? ????????? ??????.">${popup.PI_COMMENT }</textarea> 
								</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">?????? ?????????</label>
						<div class="col-md-10">
							<div class="smart-form">
								<div class="inline-group">
									<label class="radio">
										<input type="radio" name="PI_BACKGROUND_COLOR" value="N" ${(empty popup || popup.PI_BACKGROUND_COLOR eq 'N') ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>??????<br>
									</label>
									<label class="radio">
										<input type="radio" name="PI_BACKGROUND_COLOR" value="1" ${popup.PI_BACKGROUND_COLOR eq '1' ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>??????1<br>
										<img src="/resources/img/popup/background01.jpg" style="width:100px;">
									</label>
									<label class="radio">
										<input type="radio" name="PI_BACKGROUND_COLOR" value="2" ${popup.PI_BACKGROUND_COLOR eq '2' ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>??????2<br>
										<img src="/resources/img/popup/background02.jpg" style="width:100px;">
									</label>
									<label class="radio">
										<input type="radio" name="PI_BACKGROUND_COLOR" value="3" ${popup.PI_BACKGROUND_COLOR eq '3' ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>??????3<br>
										<img src="/resources/img/popup/background03.jpg" style="width:100px;">
									</label>
									<label class="radio">
										<input type="radio" name="PI_BACKGROUND_COLOR" value="4" ${popup.PI_BACKGROUND_COLOR eq '4' ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>??????4<br>
										<img src="/resources/img/popup/background04.jpg" style="width:100px;">
									</label>
									<label class="radio">
										<input type="radio" name="PI_BACKGROUND_COLOR" value="5" ${popup.PI_BACKGROUND_COLOR eq '5' ? 'checked':'' }>
										<i style="margin-top: 7px;"></i>??????5<br>
										<img src="/resources/img/popup/background05.jpg" style="width:100px;">
									</label>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="form-group">
						<label class="col-md-2 control-label">??????</label>
						<div class="col-md-2">??????
							<input class="form-control" name="PI_TITLE_COLOR" id="PI_TITLE_COLOR" type="text" placeholder="#8CC63E" value="${popup.PI_TITLE_COLOR}" maxlength="7" >
						</div>
						<div class="col-md-2">??????
							<input class="form-control" name="PI_COMMENT_COLOR" id="PI_COMMENT_COLOR" type="text" placeholder="#000" value="${popup.PI_COMMENT_COLOR}" maxlength="7" >
						</div>
					</div>
					<c:if test="${empty popup}">
					<div id="view_background">
						<p style="color:#8CC63E" id="view_title">?????????</p>
						<p style="color:#000" id="view_comment">?????? ????????? ?????????????????? ????????? ????????? ?????????, ????????? ????????? ????????? ?????????. ????????? ????????? ????????? ???????????? ????????? ????????? ???????????? ?????? ????????? ????????? ??????.</p>
					</div>
					</c:if>
					<c:if test="${not empty popup}">
						<c:set var="backgroundImg" value=""/>
						<c:if test="${not empty popup.PI_BACKGROUND_COLOR && popup.PI_BACKGROUND_COLOR ne 'N' }">
							<c:set var="backgroundImg" value="url('/resources/img/popup/background0${popup.PI_BACKGROUND_COLOR}.jpg')"/>
						</c:if>
					<div style="background-image:${backgroundImg}"  id="view_background">
						<p style="color:${popup.PI_TITLE_COLOR}" id="view_title">${popup.PI_TITLE2 }</p>
						<p style="color:${popup.PI_COMMENT_COLOR}" id="view_comment">${popup.PI_COMMENT }</p>
					</div>
					</c:if>
				</fieldset>
				
				<div class="form-actions">
					<div class="row">
						<div class="col-md-12">
							<c:if test="${empty popup}">
							<button class="btn btn-primary" type="button" onclick="Popup_Save()" id="saveBtn">
								<i class="fa fa-save"></i>
								??????
							</button>
							</c:if>
							<c:if test="${not empty popup}">
							<button class="btn btn-primary" type="button" onclick="Popup_Update()" id="updateBtn">
								<i class="fa fa-save"></i>
								??????
							</button>
							<button class="btn btn-danger" type="button" onclick="Popup_Delete()">
								<i class="fa fa-save"></i>
								??????
							</button>
							</c:if>
							<button class="btn btn-default" type="button" onclick="location.href='/txap/operation/popup.do'">
								??????
							</button>
						</div>
					</div>
				</div>
				
				</div>
				
			    <!-- end ???????????? ????????? ??? ?????? div -->
			</div>
			</form:form>
			<!-- end widget -->
		</article>
		<!-- WIDGET END -->

<!-- 		?????? ????????? -->
		<article class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-1"
				data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>?????? ??????</h2>
				</header>
				<div class="widget-body " >
					<div class="widget-body-toolbar bg-color-white">
						<div class="alert alert-info no-margin fade in">
							<button type="button" class="close" data-dismiss="alert">??</button>
							* ??? ???????????? ?????? YES/NO ???????????? ?????? ?????? ?????? ?????? ?????????.
						</div> 
					</div>
					<div id="menuListWrap">
					
					</div>
				</div>
			</div>
		</article>
	</div>
	<!-- end row -->

</section>
<!-- end widget grid -->

<script type="text/javascript">
var editor_object = [];
var fskey = '${popup.PI_FS_KEYNO}';
var fsname = '${popup.FS_ORINM}';
//????????? ?????? ????????? ??????
$(function(){
	var data_check = $("input[type=radio][name=date_select]:checked").val()
	
// 	$("input[name=accessRole]").on('click', function(){
// 		if($(this).prop('checked')){
			
// 		}else{
			
// 		}
// 	}
	
	//???????????????
	pf_getMenuList();
	
	//???????????? ?????? ????????????
	$('#PI_STARTDAY').datepicker({
		minDate : 0,
		dateFormat: "yy-mm-dd"
	});
	
	var msg = '${msg}';
	if(msg == '1'){
		alert('??????????????? ?????????????????????.')
	}
	
	nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "PI_CONTENTS",
        sSkinURI: "/resources/smarteditor2/SmartEditor2Skin.html",
        htParams : {
            // ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
            bUseToolbar : true,            
            // ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
            bUseVerticalResizer : true,    
            // ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
            bUseModeChanger : true,
        },
        menuName : '????????????' //????????? ????????? ????????? ???????????? ??????
    });
	
	
	$('#PI_STARTDAY').on('change',function(){
		$('#PI_ENDDAY').datepicker('option', 'minDate', $(this).val());
	});
	$('#PI_ENDDAY').on('change',function(){
		$('#PI_STARTDAY').datepicker('option', 'maxDate', $(this).val());
	});
	
	pf_date_use(data_check);	
	
	$('.popupType').hide();
	$('input[name=PI_TYPE]').on('change',function(){
		var type = $(this).val();
		changeType(type);
	});
	
	var piDiv = '${popup.PI_DIVISION}'|| 'W'
	pf_popType(piDiv)
	if(piDiv == 'B'){
		var piType = '${popup.PI_TYPE}' || 'A';
		if(piType == 'B'){
			pf_changeText($('#PI_COMMENT').val(),'C');
		}
		changeType(piType)
	}
	
	$('input[name=PI_BACKGROUND_COLOR]').on('change',function(){
		var type = $(this).val();
		if(type == 'N'){
			$('#view_background').css('background-image','');
		}else{
			var background = 'url("/resources/img/popup/background0'+type+'.jpg")';
			$('#view_background').css('background-image',background);
		}
	})
	
	$('#PI_TITLE_COLOR').colorpicker().on('changeColor',
            function(ev) {
		$('#view_title').css('color',ev.color.toHex());
    });
	$('#PI_COMMENT_COLOR').colorpicker().on('changeColor',
            function(ev) {
		$('#view_comment').css('color',ev.color.toHex());
    });
})

function pf_changeText(value,type){
	if(type == 'T'){
		$('#view_title').text(value);
	}else if(type == 'C'){
		value = value.replace(/(?:\r\n|\r|\n)/g, '<br>');
		$('#view_comment').html(value);
	}
}

function pf_popType(type){
	if(type == 'B'){
		$('.homePoptype').show();
		changeType('A');
	}else{
		$('.homePoptype').hide();
		changeType('W');
		$('#PI_CONTENTS-iframe').height($('#PI_CONTENTS').height() + 56);  	//????????? ?????? ??????
	}
}

function changeType(type){
	$('.popupType').hide();
	$('.popupType'+type).show();
}

var status = false;
//?????? ??????????????? ???????????? ????????????
function Popup_Save(){
	var type = $("input[name=PI_DIVISION]:checked").val();
	var data_check = $("input[type=radio][name=date_select]:checked").val()
	
	if(!Popup_CommonCheck()){return false;}
	if(type == 'W'){
		if(!Popup_checkFormW()){return false;}
	}else{
		if(!Popup_checkFormB('fileA')){return false;}
	}
	
	$("#PI_DIVISION").val(type)
	var data_check = $("input[type=radio][name=date_select]:checked").val()
	if(data_check == "N"){
		$("#PI_STARTDAY").attr("value","")
		$("#PI_ENDDAY").attr("value","????????????")
	}
	if(status){
		cf_replaceTrim($("#frm"));
		$("#frm").submit();
	}

	return false;
} 


//?????? ??????????????? ???????????? ????????????
function Popup_Update(type){
	
	if(!Popup_CommonCheck()){return false;}
	if(type == 'W'){
		if(!Popup_checkFormW()){return false;}
	}else{
		if(!Popup_checkFormB('fileA_text')){return false;}
	}
	
	cf_replaceTrim($("#frm"));
	var data_check = $("input[type=radio][name=date_select]:checked").val()
	
	if(data_check =="Y"){
		if(!pf_nullCheck(document.getElementById("PI_STARTDAY") , "????????????"  , "text")) return;
		if(!pf_nullCheck(document.getElementById("PI_ENDDAY") , "????????????"  , "text")) return;
	}
	if(data_check == "N"){
		$("#PI_STARTDAY").attr("value","")
		$("#PI_ENDDAY").attr("value","????????????")
	}
	
	$('#frm').attr('action',"/txap/operation/popup/update.do?${_csrf.parameterName}=${_csrf.token}")	
	$("#frm").submit();
} 

function Popup_CommonCheck(){
	
	if(!pf_nullCheck(document.getElementById("PI_TITLE") , "??????"  , "text"))
	{
		return;
	}
	/* if(!pf_nullCheck(document.getElementById("PI_LINK") , "?????? ??????"  , "text")) return;
	if( !( $('#PI_LINK').val().startsWith('http://') || $('#PI_LINK').val().startsWith('https://') ) ){
		cf_smallBox('error', '????????? http:// ??? https:// ??? ????????????????????????.', 3000,'#d24158');
		$('#PI_LINK').focus();
		return false;
	} */
	var data_check = $("input[type=radio][name=date_select]:checked").val()
	if(data_check =="Y"){
		if(!pf_nullCheck(document.getElementById("PI_STARTDAY") , "????????????"  , "text")) return;
		if(!pf_nullCheck(document.getElementById("PI_ENDDAY") , "????????????"  , "text")) return;
	}
	status = true;
	return true;
}


function Popup_checkFormW(){
	
	//???????????? ?????? textarea??? ??????
	editor_object.getById["PI_CONTENTS"].exec("UPDATE_CONTENTS_FIELD", []);
	
	if(!pf_nullCheck(document.getElementById("PI_TOP_LOC") , "??????"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("PI_LEFT_LOC") , "??????"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("PI_WIDTH") , "??????"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("PI_HEIGHT") , "??????"  , "text")) return;
	
	$('#resize').val('Y');
	
	status = true;
	return true;
}

function Popup_checkFormB(id){
	
	var type = $('input[name=PI_TYPE]:checked').val();
	if(type == 'A'){
		var file = $('.popupType'+type).find('input[type=file][name=file]').val();
		if(!$("#"+id).val()){
			cf_smallBox('error', '?????? ???????????? ??????????????????.', 3000,'#d24158');
			return;
		}
	}else if(type == 'B'){
		if(!pf_nullCheck(document.getElementById("PI_TITLE2") , "?????? ??????"  , "text")) return;
		if(!pf_nullCheck(document.getElementById("PI_COMMENT") , "?????? ??????"  , "text")) return;
		if(!$('#PI_TITLE_COLOR').val()){
			$('#PI_TITLE_COLOR').val('#8CC63E')
		}
		if(!$('#PI_COMMENT_COLOR').val()){
			$('#PI_COMMENT_COLOR').val('#ffffgf')
		}
	}
	if($('input[name=file_resize]:checked').val() == 'Y'){
		$('#resize').val('Y');
	}else{
		$('#resize').val('N');
	}
	
	status = true;
	return true;
}

function Popup_Delete(){
	if(confirm('?????? ?????????????????????????')){
		$.ajax({
			type: "POST",
			url: "/txap/operation/popup/deleteAjax.do",
			data: "PI_KEYNO="+$('#PI_KEYNO').val(),
			async:false,
			success : function(data){
				cf_smallBox('Form', '??????????????? ?????????????????????.', 3000);
				location.href='/txap/operation/popup.do';
			},
			error: function(){
				cf_smallBox('ajax', '???????????? ?????? ??????. ??????????????? ???????????????.', 3000,'gray');
				return false;
			}
		});
	}
}

//null check
function pf_nullCheck(obj, name, inputType){
	
	var str = "";
	
	if     (inputType == "text")	str = "??????";
	else if(inputType == "select")	str = "??????";
	if($.trim(obj.value) == ""){
		cf_smallBox('Form', name + "???(???) "+ str +"????????????.", 3000,'#d24158');
		obj.value = "";
		obj.focus();
		
		return false;
	}else{
		return true;
	}
}
function pf_date_use(use){
	
	if(use == "Y"){
		$("#date_1").show();
		$("#date_2").show();
	}else{
		$("#date_1").hide();
		$("#date_2").hide();
		$("#PI_STARTDAY").attr("value","")
 		$("#PI_ENDDAY").attr("value","")
	}
}

function pf_getMenuList(){
		$.ajax({
			type: "POST",
			url: "/txap/operation/popup/popup_menuListAjax.do",
			data: "",
			success : function(data){
			  	$('#menuListWrap').html(data);
			}, error: function(){
				alert("??????");
			}
		});
}
</script>
