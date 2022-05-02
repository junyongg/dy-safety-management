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
	
	
	#MAINDIV, #SUBDIV1, #SUBDIV2  {display:none;}

</style>

<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row" >

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >

			<!-- Widget ID (each widget will need unique ID)-->
			<form:form id="frm" name="frm" enctype="multipart/form-data" action="/txap/operation/popup/insert.do?${_csrf.parameterName}=${_csrf.token}"  method="post">
			<input type="hidden" name="PI_KEYNO" id="PI_KEYNO" value="${popup.PI_KEYNO }">
			<input type="hidden" name="PI_MN_KEYNO" id="PI_MN_KEYNO" value="${popup.PI_MN_KEYNO }">
			<input type="hidden" name="PI_MN_TYPE" id="PI_MN_TYPE" value="${popup.PI_MN_TYPE }">
			<input type="hidden" name="PI_FS_KEYNO" id="PI_FS_KEYNO" value="${popup.PI_FS_KEYNO }">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>팝업 관리</h2>

				</header>
				<div class="widget-body form-horizontal">
				<fieldset>
					<div class="bs-example necessT">
				         <span class="colorR fs12">*표시는 필수 입력 항목입니다.</span>
				     </div>
					<div class="form-group">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> 팝업 제목</label>
						<div class="col-md-10">
							<input class="form-control checkTrim" name="PI_TITLE" id="PI_TITLE" type="text" value="<c:out value='${popup.PI_TITLE }' escapeXml='true'/>" maxlength="100">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" for="select-1"><span class="nessSpan">*</span> 팝업 띄울 메뉴</label>
						<div class="col-md-2">
							<select class="form-control input-sm" id="HOMEDIV">
				              <option value="">적용 홈페이지 선택</option>
				              <c:forEach items="${homeDivList }" var="model">
				                <option value="${model.MN_KEYNO }">${model.MN_NAME }</option>
				              </c:forEach>
				            </select>
						</div>
						<div class="col-md-2">
							<select class="form-control input-sm" id="MAINDIV">
				              <option>메뉴 선택</option>
				            </select>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> 팝업 링크</label>
						<div class="col-md-10">
							<input class="form-control" name="PI_LINK" id="PI_LINK" type="text" value="${popup.PI_LINK }" placeholder="http:// or https:// 으로 시작되어야됩니다." maxlength="200">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">팝업 내용</label>
						<div class="col-md-10">
						     <textarea style="width:100%;height:400px;min-width:260px;" name="PI_CONTENTS" id="PI_CONTENTS" placeholder="이미지를 삽입하지 않고, 텍스트만 입력할 경우 팝업 내용에 표시됩니다.">${popup.PI_CONTENTS }</textarea>
						     <div class="note" style="color: red;">(이미지를 삽입하지 않고, 텍스트만 입력할 경우 팝업 내용에 표시됩니다. 이미지를 올릴 경우 텍스트 내용은 포함되지 않습니다.)
				         	</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">팝업 이미지</label>
						<section class="col-md-10 smart-form">
						<div class="input input-file">
							<span class="button">
								<input type="file" id="file" name="file" onchange="cf_imgCheckAndPreview('file')">Browse
							</span>
							<input type="text" placeholder="이미지를 선택하여주세요" readonly="" id="file_text" value="${popup.FS_ORINM }">
						</div>
				   		 <div class="note" style="color: red;">(이미지를 올리지 않을경우 기본 크기는 300 x 300 px 이며, 아래 지정한 크기만큼 팝업창의 크기가 결정됩니다.<br>
				   		                                                                        이미지를 올릴 경우 아래 팝업 크기에 맞게 자동 리사이즈 됩니다.)
				         </div>
				         </section>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> 팝업 위치</label>
						<div class="col-md-5">상단
							<input class="form-control" placeholder="200" name="PI_TOP_LOC" id="PI_TOP_LOC" type="number" value="${popup.PI_TOP_LOC }" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="4">
							<div class="note" style="color: red;">
								(200px 이하는 호환성이 맞지 않으니, 200px 이상으로 설정하시기 바랍니다.)
					         </div>
						</div>
						<div class="col-md-5">왼쪽
							<input class="form-control" placeholder="200" name="PI_LEFT_LOC" id="PI_LEFT_LOC" type="number" value="${popup.PI_LEFT_LOC }" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="4">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> 팝업 크기</label>
						<div class="col-md-5">넓이
							<input class="form-control" placeholder="300" name="PI_WIDTH" id="PI_WIDTH" type="number" value="${popup.PI_WIDTH }" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="4">
							<div class="note" style="color: red;">
								(200px 이하는 호환성이 맞지 않으니, 200px 이상으로 설정하시기 바랍니다.)
					         </div>
						</div>
						<div class="col-md-5">높이
							<input class="form-control" placeholder="300" name="PI_HEIGHT" id="PI_HEIGHT" type="number" value="${popup.PI_HEIGHT }" oninput="cf_maxLengthCheck(this)" max="99999999999" maxlength="4">
						</div>
					</div>
					<div class="row">
						<label class="col-md-2 control-label"><span class="nessSpan">*</span> 날짜</label>
						<div class="col-md-5 smart-form">시작날짜
							<label class="input"> <i class="icon-append fa fa-calendar"></i>
								<input type="text" name="PI_STARTDAY" id="PI_STARTDAY" placeholder="시작날짜" data-dateformat="yy-mm-dd" class="datepicker "  value="${popup.PI_STARTDAY }">
							</label>
						</div>
						<div class="col-md-5 smart-form">종료날짜
							<label class="input"> <i class="icon-append fa fa-calendar"></i>
								<input type="text" name="PI_ENDDAY" id="PI_ENDDAY" placeholder="종료날짜" data-dateformat="yy-mm-dd" class="datepicker " value="${popup.PI_ENDDAY }">
							</label>
						</div>
					</div>
				                              
				
				</fieldset>
				<div class="form-actions">
					<div class="row">
						<div class="col-md-12">
							<c:if test="${empty popup}">
							<button class="btn btn-primary" type="button" onclick="Popup_Save()">
								<i class="fa fa-save"></i>
								저장
							</button>
							</c:if>
							<c:if test="${not empty popup}">
							<button class="btn btn-primary" type="button" onclick="Popup_Update()">
								<i class="fa fa-save"></i>
								수정
							</button>
							<button class="btn btn-danger" type="button" onclick="Popup_Delete()">
								<i class="fa fa-save"></i>
								삭제
							</button>
							</c:if>
							<button class="btn btn-default" type="button" onclick="location.href='/txap/operation/popup.do'">
								취소
							</button>
						</div>
					</div>
				</div>
				
				</div>
				
			    <!-- end 팝업관련 이미지 및 정보 div -->
			</div>
			</form:form>
			<!-- end widget -->
		</article>
		<!-- WIDGET END -->

	</div>
	<!-- end row -->

</section>
<!-- end widget grid -->

<script type="text/javascript">
var editor_object = [];
var fskey = '${popup.PI_FS_KEYNO}';
var fsname = '${popup.FS_ORINM}';
//텍스트 관련 에디터 생성
$(function(){
	
	var msg = '${msg}';
	if(msg == '1'){
		alert('성공적으로 수정되었습니다.')
	}
	
	nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "PI_CONTENTS",
        sSkinURI: "/resources/smarteditor2/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
        },
        menuName : '팝업관리' //본문에 이미지 저장시 사용되는 캡션
    });
	
	$('#PI_STARTDAY').on('change',function(){
		$('#PI_ENDDAY').datepicker('option', 'minDate', $(this).val());
	});
	$('#PI_ENDDAY').on('change',function(){
		$('#PI_STARTDAY').datepicker('option', 'maxDate', $(this).val());
	});
	
	if('${popup.PI_MN_KEYNO}' != ''){
		$('#HOMEDIV').val('${popup.MN_HOMEDIV_C}');
		 cf_menuSetting($('#HOMEDIV'),'${popup.MN_KEYNO}','${popup.PI_MN_TYPE}')
	}
	
	$('#HOMEDIV').on('change',function(){
		 cf_menuSetting($(this))
		 
	})
	
	
})



function cf_menuSetting(obj,key,type){
	var state = true;
	
	 $.ajax({
		type: "POST",
		url: "/txap/operation/popup/menu/listAjax.do",
		data: "MN_HOMEDIV_C=" + $(obj).val(),
		async:false,
		success : function(data){
			var temp = '';
			temp += '<option  value="">메뉴 선택</option>';
			temp += '<option  value="A" data-type="'+$(obj).val()+'">모든 메뉴</option>';
			temp += '<option  value="'+$(obj).val()+'">메인화면</option>';
			$.each(data,function(i){
				temp += '<option value='+data[i].MN_KEYNO+'>'+data[i].MN_NAME+'</option>'
			})
			$('#MAINDIV').html(temp).show();
			if(key){
				if(type == 'A'){
					$('#MAINDIV').val(type);
				}else{
					$('#MAINDIV').val(key);
				}
			}
			
		},
		error: function(){
			alert('데이터를 가져올수없습니다. 관리자한테 문의하세요.')
			return false;
		}
	});
}



//팝업 시작날짜와 종료날짜 예외처리
function Popup_Save(){
	
	if(!Popup_checkForm()){
		return false;
	}
	
	cf_replaceTrim($("#frm"));
	
	$("#frm").submit();
	
} 


//팝업 시작날짜와 종료날짜 예외처리
function Popup_Update(){
	
	if(!Popup_checkForm()){
		return false;
	}
	
	cf_replaceTrim($("#frm"));
	
	$('#frm').attr('action',"/txap/operation/popup/update.do?${_csrf.parameterName}=${_csrf.token}")	
	$("#frm").submit();
	
} 

function Popup_checkForm(){
	
	//웹에디터 내용 textarea로 복사
	editor_object.getById["PI_CONTENTS"].exec("UPDATE_CONTENTS_FIELD", []);
	if(!pf_nullCheck(document.getElementById("PI_TITLE") , "제목"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("HOMEDIV") , "적용 홈페이지"  , "select")) return;
	if(!pf_nullCheck(document.getElementById("MAINDIV") , "메뉴"  , "select")){
		return;
	}else{
		if($('#MAINDIV').val() == 'A'){
			$('#PI_MN_KEYNO').val($('#HOMEDIV').val());
			$('#PI_MN_TYPE').val('A');
		}else{
			$('#PI_MN_KEYNO').val($('#MAINDIV').val());
			$('#PI_MN_TYPE').val('N');
		}
		
	}
	
	if(!pf_nullCheck(document.getElementById("PI_TOP_LOC") , "상단"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("PI_LEFT_LOC") , "왼쪽"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("PI_WIDTH") , "넓이"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("PI_HEIGHT") , "높이"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("PI_LINK") , "팝업 링크"  , "text")) return;
	
	if( !( $('#PI_LINK').val().startsWith('http://') || $('#PI_LINK').val().startsWith('https://') ) ){
		alert('링크는 http:// 나 https:// 로 시작되어야됩니다.');
		$('#PI_LINK').focus();
		return false;
	}
	
	if(!pf_nullCheck(document.getElementById("PI_STARTDAY") , "시작날짜"  , "text")) return;
	if(!pf_nullCheck(document.getElementById("PI_ENDDAY") , "종료날짜"  , "text")) return;
	
	return true;
}

function Popup_Delete(){
	if(confirm('정말 삭제하시겠습니까?')){
		$.ajax({
			type: "POST",
			url: "/txap/operation/popup/deleteAjax.do",
			data: "PI_KEYNO="+$('#PI_KEYNO').val(),
			async:false,
			success : function(data){
				alert('성공적으로 삭제되었습니다.')
				location.href='/txap/operation/popup.do';
			},
			error: function(){
				alert('삭제 할수없습니다. 관리자한테 문의하세요.')
				return false;
			}
		});
	}
}

//null check
function pf_nullCheck(obj, name, inputType){
	
	var str = "";
	
	if     (inputType == "text")	str = "입력";
	else if(inputType == "select")	str = "선택";
	if($.trim(obj.value) == ""){
		alert(name + "을(를) "+ str +"해주세요.");
		obj.value = "";
		obj.focus();
		
		return false;
	}else{
		return true;
	}
}
 
	
</script>
