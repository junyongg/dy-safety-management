<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/common/CodeMirror_Include.jsp"%>
<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/resources/js/common/diff_match_patch.js"></script>

<script type="text/javascript">
var editor_object = [];
var editor = null;
var msg = '${msg}' 
$(function(){
	if(msg){
		setTimeout(function(){
			cf_smallBox('success', msg, 3000);
		},100)
	}
	
	var type = 'S'
	if('${HTMLViewData.MVD_EDITOR_TYPE}' != ''){
		type = '${HTMLViewData.MVD_EDITOR_TYPE}'
	}
	pf_editorChange(type)
})

function pf_boardDataInsert(){
	if($('input[name=MVD_EDITOR_TYPE]:checked').val() == 'S'){
	    editor_object.getById["MVD_DATA"].exec("UPDATE_CONTENTS_FIELD", []);	  
   }else{
	   $("#MVD_DATA").val(editor.getValue())
   }
	
   if(!$("#MVD_DATA").val()){
     cf_smallBox('error', '내용을 입력해주세요.', 3000,'#d24158');
     return;
   }else{
		if(confirm("게시물을 생성하시겠습니까?")){
			success();
		}else{
			exit();
		}
	  }
}

function success(){
	$.ajax({
		type: "post",
		url: "/txap/homepage/page/insert.do?${_csrf.parameterName}=${_csrf.token}",
		data: $("#Form").serialize(),
		success : function(data){
			$("#page_ch").html(data)
		},
		error: function(){
		}
	});
}
  
function exit(){
	cf_smallBox('cancel', '취소되었습니다.', 3000,'#d24158');
	return false;
}

// 복원
function pf_introUse(KEYNO){
	$('#MVH_KEYNO').val(KEYNO);
	$.ajax({
		type: "POST",
		url: "/txap/homepage/page/detailView/returnPageAjax.do",
		data : $("#Form").serialize(),
		success : function(data){
		   if($('input[name=MVD_EDITOR_TYPE]:checked').val() == 'S'){
				pasteHTML(data)  
		   }else{
			   editor.setValue(data)
		   }
		   cf_smallBox('success', '데이터를 불러왔습니다.', 3000);
		   pf_scroll('pageTable');
		},
		error : function(){	
			cf_smallBox('error', '데이터를 가져올수없습니다. 관리자한테 문의하세요.', 3000,'#d24158');
		}
	});
}

function pf_scroll(id){
	var offset = $("#"+id).offset();
    $('html, body').animate({scrollTop : offset.top}, 400);
}

//에디터에 데이터 붙여넣기
function pasteHTML(data) {
	var sHTML = data;
	editor_object.getById["MVD_DATA"].exec("SET_IR", [""]);			//초기화
	editor_object.getById["MVD_DATA"].exec("PASTE_HTML", [sHTML]);	//데이터 넣기
}

//비교하기
function pf_compareData(KEY1, KEY2){
	
	$.ajax({
		type: "POST",
		url: "/txap/homepage/page/compareAjax.do",
		data: "MVH_KEYNO="+KEY1+"&MVD_KEYNO="+KEY2,
		async:false,
		success : function(obj){
			
			var dmp = new diff_match_patch();
			var d;
			if(KEY2 == undefined){
			    d = dmp.diff_main(obj.length == 1 ? "": obj[1].MVD_DATA, obj[0].MVD_DATA);
			}else{
				d = dmp.diff_main(obj[0].MVD_DATA, obj[1].MVD_DATA);
			}
		    dmp.diff_cleanupSemantic(d)
		    var ds = dmp.diff_prettyHtml(d);
	    	$('#compareData').html(ds)
	    	pf_scroll('compareData')
		},
		error: function(){
			cf_smallBox('error', '데이터를 가져올수없습니다', 3000);
			return false;
		}
	});
	
	
}

//배포하기
function pf_Distribute(allck) {
	if($("#MVD_KEYNO").val() == null || $("#MVD_KEYNO").val() == ''){
		cf_smallBox('error', '저장한 후 배포가능합니다.', 3000,'#d24158');
		return false;
	}
	if(confirm("정말 배포를 하시겠습니까?")) {
		cf_loading();
		
		setTimeout(function(){
			$.ajax({
			    type   : "post",
			    url    : "/txap/homepage/page/distributeAjax.do",
			    data   : {
			    		"allck"	 			: allck,
			    		"MVD_KEYNO"	 		: $("#MVD_KEYNO").val(),
			    		"MVD_MN_HOMEDIV_C"  : $("#MVD_MN_HOMEDIV_C").val()
			    		},
			    async  : false,
			    success:function(data){
			    	if(data) {
			    		cf_smallBox('success', '배포되었습니다', 3000);
			    	} else {
			    		cf_smallBox('error', '배포실패', 3000,'#d24158');
			    	}
			    },
			    error: function(jqXHR, textStatus, exception) {
			    	cf_smallBox('error', '에러발생', 3000,'#d24158');
			    }
			  }).done(function(){
				cf_loading_out();
			})
		},100)
	}
}

function pf_contentPreview(key, homekey, type){
	$("#HomeKey").val(homekey)
	$("#Keyno").val(key)
	$("#keyType").val(type)
	
	if(type == 'main'){
		if(editor_object.length > 0){
			editor_object.getById["MVD_DATA"].exec("UPDATE_CONTENTS_FIELD", []);
		}
		if(editor != null){
			$("#MVD_DATA").val(editor.getValue())
		}
		$("#contents").val($("#MVD_DATA").val())
		$("#contents").val()
	}
	
	$.ajax({
		type: "POST",
		url: "/txap/homepage/page/previewAjax.do",
		data : $("#previewForm").serializeArray(),
		async:false,
		success : function(mirrorPage){
			window.open("${homeData.MN_URL}/homepage/page/preview.do?mirrorPage="+mirrorPage, "preview");
		},
		error : function(){	
			cf_smallBox('error', '데이터를 가져올수없습니다. 관리자한테 문의하세요.', 3000,'#d24158');
		}
	});
}

function pf_editorChange(value){
	
	if(editor_object.length > 0){
		editor_object.getById["MVD_DATA"].exec("UPDATE_CONTENTS_FIELD", []);
	}
	if(editor != null){
		$("#MVD_DATA").val(editor.getValue())
	}
	
	if(value == 'S'){
		if(editor_object.length == 0){
			nhn.husky.EZCreator.createInIFrame({
		        oAppRef: editor_object,
		        elPlaceHolder: "MVD_DATA",
		        sSkinURI: "/resources/smarteditor2/SmartEditor2Skin.html",
		        htParams : {
		            bUseToolbar : true,            
		            bUseVerticalResizer : true,    
		            bUseModeChanger : true,
		        },
		        menuName : '페이지관리' //본문에 이미지 저장시 사용되는 캡션
		    });
			$('.CodeMirror').hide()			
		}else{
			editor_object.getById["MVD_DATA"].exec("SET_IR", [""]);						//초기화
			editor_object.getById["MVD_DATA"].exec("PASTE_HTML", [editor.getValue()]);	//데이터 넣기
			$('#MVD_DATA-iframe').show()			
			$('.CodeMirror').hide()			
		}
	}else if(value == 'C'){
		if(editor == null){
			editor = codeMirror('htmlmixed','MVD_DATA', '', false)
			$('#MVD_DATA-iframe').hide()
		}else{			
			var data = editor_object.getById["MVD_DATA"].getIR();	//데이터 넣기
			editor.setValue(data)
			$('#MVD_DATA-iframe').hide()
			$('.CodeMirror').show()			
		}
	}
}

</script>

<form:form id="previewForm" name="previewForm" method="post">
	<input type="hidden" name="HomeKey" id="HomeKey"/> 
	<input type="hidden" name="Keyno" id="Keyno"/> 
	<input type="hidden" name="keyType" id="keyType"/> 
	<textarea name="contents" id="contents" style="display: none;"></textarea> 
</form:form>

<div>
	<section id="widget-grid" >
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-blueDark" id="" data-widget-editbutton="false" data-widget-custombutton="false">				
					<form:form id="Form" name="Form" method="post" class="form-horizontal bv-form" novalidate="novalidate" enctype="multipart/form-data">
						<input type="hidden" name="MVD_MN_KEYNO" value="${Menu.MN_KEYNO}" />
						<input type="hidden" name="MVD_MN_HOMEDIV_C" id="MVD_MN_HOMEDIV_C" value="${Menu.MN_HOMEDIV_C}" />
						<input type="hidden" name="MVD_DATA_BEFORE" value="<c:out value='${HTMLViewData.MVD_DATA }'/>" />
						<input type="hidden" name="MVD_KEYNO" id="MVD_KEYNO" value="${HTMLViewData.MVD_KEYNO }" />
						<input type="hidden" name="MVH_KEYNO" id="MVH_KEYNO" value="" />
						<header>
							<legend style=float: left;"><span>페이지 등록</span>
							<button class="btn btn-success" type="button" onclick="pf_contentPreview('${HTMLViewData.MVD_KEYNO }','${Menu.MN_HOMEDIV_C}','main')" style="float: right;">
	                       	<i class=" fa fa-circle-thin"></i> 콘텐츠 미리보기
	                     	</button>
							<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_Distribute('false')" style="float: right;">	
								<i class="fa fa-plus"></i> 배포
							</button>
							<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_boardDataInsert()" style="float: right;">	
								<i class="fa fa-floppy-o"></i> 저장
							</button>
							<div class="clear"></div>
							</legend>
						</header>
						<div>
							<table id="pageTable" class="table table-bordered table-striped">
								<colgroup>
									<col style="width: 20%;">
									<col style="width: 30%;">
									<col style="width: 20%;">
									<col style="width: 30%;">
								</colgroup>
								<tbody>
									<tr>
										<td>작성자</td>
										<td>
											${empty HTMLViewData.MVD_REGNM ? '작성자 없음' : HTMLViewData.MVD_REGNM }
										</td>
										<td>작성일</td>
										<td>
											${empty HTMLViewData.MVD_REGDT ? '작성일 없음' : HTMLViewData.MVD_REGDT }
										</td>
									</tr>
									<tr>
										<td>최근 게시물 수정자</td>
										<td>
											${empty HTMLViewData.MVD_MODNM ? '최근 게시물 수정자 없음' : HTMLViewData.MVD_MODNM}
										</td>
										<td>최근 게시물 수정일자</td>
										<td>
											${empty HTMLViewData.MVD_MODDT ? '게시물 수정이력 없음' : HTMLViewData.MVD_MODDT} 
										</td>
									</tr>
									<tr>
										<td>히스토리 코멘트</td>
										<td colspan="3"><input type="text" class="form-control" name="MVH_COMMENT" id="MVH_COMMENT" value="" maxlength="100"></td>
									</tr>
									<tr>
										<td>에디터 타입</td>
										<td colspan="3" class="smart-form">
										<div class="row">
											<div class="col col-6">
												<div class="inline-group">
													<div class="row">
														<label class="radio" style="padding-top: 0; margin-top: 4px;"> <input type="radio" name="MVD_EDITOR_TYPE" value="S" ${empty HTMLViewData.MVD_EDITOR_TYPE || HTMLViewData.MVD_EDITOR_TYPE eq 'S' ? 'checked' : ''} onclick="pf_editorChange(this.value);"> <i></i>스마트 에디터
														</label> 
														<label class="radio" style="padding-top: 0; margin-top: 4px;"> <input type="radio" name="MVD_EDITOR_TYPE" value="C" ${HTMLViewData.MVD_EDITOR_TYPE eq 'C' ? 'checked' : ''} onclick="pf_editorChange(this.value);"> <i></i>코드미러
														</label> 
													</div>
												</div>
											</div>
										</div>
										</td>
									</tr>
									<tr>
										<td colspan="4">내용</td>
									</tr>
									<tr>
										<td colspan="4">
											<textarea class="form-control ckWebEditor" name="MVD_DATA" id="MVD_DATA" style="width:100%;height:500px;min-width:260px;" data-bv-field="content"><c:out value="${HTMLViewData.MVD_DATA }" escapeXml="false"/></textarea><i class="form-control-feedback" data-bv-icon-for="content" style="display: none;"></i>
										</td>
									</tr>
								</tbody>
							</table>
						</div>	
					</form:form>
				</div>
			</article>
		</div>
		
		<div class="row">	
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-green" id="" data-widget-editbutton="false" data-widget-custombutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i></span>
						<h2>히스토리</h2>
					</header>
					<div>
						<div class="jarviswidget-editbox"></div>
						<div class="widget-body">
							<div class="table-responsive">
								<table id="datatable_fixed_column" class="table table-bordered table-hover" width="100%">
								<colgroup>
									<col width="5%">
									<col width="10%">
									<col width="">
									<col width="16%">
									<col width="24%">
								</colgroup>
							    <thead>
							      <tr>
									<th class="text-align-center">버전</th>
									<th class="text-align-center">작성자</th>
									<th class="text-align-center">코멘트</th>
									<th class="text-align-center">게시기간</th>
									<th class="text-align-center">기능</th>
							      </tr>
							    </thead>
							    <tbody id="intro-history">
							    	<c:forEach items="${HTMLViewDataHistory}" var="model">
							    	<tr>
							    		<td class="text-align-center"><fmt:formatNumber value="${model.MVH_VERSION }" pattern="0.00"/></td>
							    		<td class="text-align-center">${model.MVD_MODNM }</td>
							    		<td class="text-align-center">${model.MVH_COMMENT }</td>
							    		<td class="text-align-center">${model.MVH_STDT} ~ ${model.MVH_ENDT}</td>
							    		<td class="text-align-center">
							    		<a class="btn btn-default btn-xs" href="javascript:;" onclick="pf_introUse('${model.MVH_KEYNO}');"><i class="fa fa-repeat"></i> 복원</a>
							    		<a class="btn btn-default btn-xs" href="javascript:;" onclick="pf_compareData('<c:out value="${model.MVH_KEYNO }"/>','<c:out value="${HTMLViewData.MVD_KEYNO }"/>');"><i class="fa fa-repeat"></i> 최신 데이터와 비교</a>
							    		<a class="btn btn-default btn-xs" href="javascript:;" onclick="pf_compareData('<c:out value="${model.MVH_KEYNO }"/>');"><i class="fa fa-repeat"></i> 변경사항</a>
							    		<a class="btn btn-success btn-xs" href="javascript:;" onclick="pf_contentPreview('<c:out value="${model.MVH_KEYNO }"/>','${Menu.MN_HOMEDIV_C}','history')"><i class="fa fa-eye"></i> 미리보기</a>
							    		</td>
						    		</tr>
							    	</c:forEach>
						    	</tbody>
							    </table>
							</div>
						</div>
					</div>
				</div>
			</article>
		</div>
		
		<div class="row">	
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-green" id="compareData_wrap" data-widget-editbutton="false" data-widget-custombutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i></span>
						<h2>소스 비교</h2>
					</header>
					<div>
						<div class="jarviswidget-editbox"></div>
						<div class="widget-body">
							<div id="compareData"></div>
						</div>
					</div>
				</div>
			</article>
		</div>
	</section>
</div>
