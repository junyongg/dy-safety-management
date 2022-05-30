<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
<style>
#menuIconView {font-size:50px; margin:15px 5px;}
div[id*=LINKBOX] {display:none;}

.popup_dl {
	margin-right: 12px;
}

.popup_select {
	padding-left:10px;
}

.label{
	color: #1c1c1c;
}
</style>

<!-- 폼 양식 설정 -->
<form:form action="" id="Form" name="Form" method="post" >
  <input type="hidden" id="MN_KEYNO" name="MN_KEYNO" value=""/>
  <input type="hidden" id="MN_NAME" name="MN_NAME" value=""/>
  <input type="hidden" id="MN_HOMEDIV_C" name="MN_HOMEDIV_C" value="${menu.MN_HOMEDIV_C }"/>
  <input type="hidden" id="MN_PAGEDIV_C" name="MN_PAGEDIV_C" value=""/>
  <input type="hidden" id="MN_BT_KEYNO" name="MN_BT_KEYNO" value=""/>
  <input type="hidden" id="MN_MAINKEY" name="MN_MAINKEY" value=""/>
  <input type="hidden" id="MN_ORDER" name="MN_ORDER" value=""/>
  <input type="hidden" id="MN_ORDER_BEFORE" name="MN_ORDER_BEFORE" value=""/>
  <input type="hidden" id="MN_LEV" name="MN_LEV" value=""/>
  <input type="hidden" id="MN_USE_YN" name="MN_USE_YN" value=""/>
  <input type="hidden" id="MN_SHOW_YN" name="MN_SHOW_YN" value=""/>
  <input type="hidden" id="MN_beforeURL" name="MN_beforeURL" value=""/>
  <input type="hidden" id="MN_URL" name="MN_URL" value=""/>
  <input type="hidden" id="MN_FORWARD_URL" name="MN_FORWARD_URL" value=""/>
  
  <input type="hidden" id="depthURL" value=""/>
  <input type="hidden" id="depthIntroURL" value=""/>
  
  <input type="hidden" id="MN_DEP" name="MN_DEP" value="" />
  <input type="hidden" id="MN_COLOR" name="MN_COLOR" value="" />
  <input type="hidden" id="MN_DATA1" name="MN_DATA1" value="" />
  <input type="hidden" id="MN_DATA2" name="MN_DATA2" value="" />
  <input type="hidden" id="MN_DATA3" name="MN_DATA3" value="" />
  <input type="hidden" id="MN_ENG_NAME" name="MN_ENG_NAME" value="" />
  <input type="hidden" id="MN_ICON_CSS" name="MN_ICON_CSS" value="" />
  <input type="hidden" id="MN_ICON_URL1" name="MN_ICON_URL1" value="" />
  <input type="hidden" id="MN_ICON_URL2" name="MN_ICON_URL2" value="" />
  <input type="hidden" id="MN_AUTHORITY" name="MN_AUTHORITY" value="" />
  <input type="hidden" id="MN_AUTHORITY_KEY" name="MN_AUTHORITY_KEY" value="" />
  <input type="hidden" id="MVD_KEYNO" name="MVD_KEYNO" value="" />
  
  <input type="hidden" id="MN_RESEARCH" name="MN_RESEARCH" value="${menu.MN_HOMEDIV_C eq HOMEDIV_ADMIN ? 'N' : ''}" />
  <input type="hidden" id="MN_QRCODE" name="MN_QRCODE" value="${menu.MN_HOMEDIV_C eq HOMEDIV_ADMIN ? 'N' : ''}" />
  <input type="hidden" id="MN_MANAGER" name="MN_MANAGER" value="" />
  <input type="hidden" id="MN_MANAGER_DEP" name="MN_MANAGER_DEP" value="" />
  <input type="hidden" id="MN_MANAGER_TEL" name="MN_MANAGER_TEL" value="" />
  <input type="hidden" id="MN_TOURKEY" name="MN_TOURKEY" value="" />
  
  <input type="hidden" id="XH_FS_KEYNO" name="XH_FS_KEYNO" value="" />
  
    
</form:form>

<!-- 내용시작 -->
<div id="content">
	<section id="widget-grid" class="">
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-magenta" id="menu_master_1" data-widget-editbutton="false">
  					<header>
    					<span class="widget-icon"> <i class="fa fa-lg fa-th-large"></i> </span>
    					<h2>메뉴관리</h2>
  					</header> 
  				<div> 
  				<div class="jarviswidget-editbox"></div>
  				<div class="widget-body">
  					<div class="widget-body-toolbar bg-color-white">
    					<div class="alert alert-info no-margin fade in">
      						<button type="button" class="close" data-dismiss="alert">×</button>
      						추가/변경 하고싶은 홈페이지 선택 <i class="fa-fw fa fa-caret-right"></i>
      						아이콘을 사용해서 원하는 기능을 시작
      						<br />
							<i class="fa fa-pencil" style="color:red; "></i> : 관리하기,
							<i class="fa fa-plus" style="color:red; "></i> : 추가하기,
							<i class="fa fa-check-square-o" style="color:red; "></i> : 사용중,
							<i class="fa fa-square-o" style="color:red; "></i> : 사용안함, 
							<i class="fa fa-trash-o" style="color:red; "></i> : 삭제하기,
							<i class="fa fa-retweet" style="color:red; "></i> : 페이지만들기,
							<i class="fa fa-lock" style="color:red; "></i> : 메뉴 감추기,
							<i class="fa fa-unlock" style="color:red; "></i> : 메뉴 보이기
<!-- 							<i class="fa fa-sign-in" style="color:red; "></i> : 권한 관리 , -->
<!-- 							<i class="fa fa-edit" style="color:red; "></i> : 페이지 상세보기  or 페이지 등록, -->
<!-- 							<i class="fa fa-book" style="color:red; "></i> : 게시물 관리 -->
    					</div> 
  					</div>  
  					<div class="widget-body-toolbar bg-color-white">
    					<form:form class="form-inline" role="form">
      						<div class="row">
        						<div class="col-sm-12 col-md-10">
          							<div class="form-group">
            							<label class="sr-only">홈페이지 선택</label>
           								<select class="form-control input-sm" onchange="pf_changeHomeDiv(this.value)">
           									<c:forEach items="${homeDivList }" var="model">
               									<option value="${model.MN_KEYNO }" ${model.MN_KEYNO eq menu.MN_HOMEDIV_C ? 'selected':'' }>${model.MN_NAME }</option>
              									<c:if test="${model.MN_KEYNO eq menu.MN_HOMEDIV_C }">
                 								<c:set var="HOMEDIV_C_NM" value="${model.MN_NAME }"/>
              									</c:if>
             								</c:forEach>
           								</select>
          							</div>
									<button type="button" class="btn btn-default" onclick="pf_openInsertHome()">
										<i class="fa fa-plus"></i> 홈페이지 추가
									</button>
									<c:if test="${menu.MN_HOMEDIV_C ne HOMEDIV_ADMIN}">
									<button type="button" class="btn btn-default" onclick="pf_openUpdateHome()">
									  	<i class="fa fa-gear"></i> 홈페이지 수정
									</button>
									<button type="button" onclick="pf_Home_delete();" class="btn btn-default">
										<i class="fa fa-trash-o"></i> 홈페이지 삭제
									</button>
									</c:if>
									<button type="button" class="btn btn-default" onclick="pf_excelDownHome()">
										<i class="fa fa-table"></i> 홈페이지 엑셀
									</button>
									<!-- <button type="button" class="btn btn-default" onclick="pf_xmlHistory()">
										<i class="fa fa-save"></i> 홈페이지 백업
									</button> -->
								</div>
							</div>
						</form:form>
					</div>
					<!-- tree 시작 -->
					<div class="tree">
						<ul>
							<li class="parent_li" data-key="${menu.MN_KEYNO }"> 
								<span class="label">
									<i class="fa fa-lg fa-plus-circle">${menu.MN_NAME }</i>
								</span>
								<button type="button" class="btn btn-xs " onclick="pf_Set_MenuInsertView('${menu.MN_HOMEDIV_C}','${menu.MN_KEYNO}','${menu.MN_LEV}','${menu.MN_URL }')"><i class="fa fa-plus"></i></button>
								
								<!-- depth1Group 시작 -->
  								<ul id="depth1Group">
									<c:set var="beforeDepth" value=""/>
									<c:forEach items="${resultList}" var="model" varStatus="status2">
										
										<c:if test="${ !status2.first && model.MN_LEV lt beforeDepth }">
											<c:forEach begin="${model.MN_LEV}" end="${beforeDepth - 1}">
											</ul>
										</li>
											</c:forEach>
										</c:if>
										
										<!-- 소메뉴 형 일경우 -->
										<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU }">
											<li class="parent_li" data-key="${model.MN_KEYNO }"> 
												<span class="label">
										  			<i class="fa fa-lg fa-plus-circle"></i> 
										</c:if>
										
										<!--뷰, 게시판형일경우 -->
										<c:if test="${model.MN_PAGEDIV_C ne MENU_TYPE_SUBMENU }">
											<li data-key="${model.MN_KEYNO }" class="pageViewLi"> 
												<span>
										  			<i class="fa fa-lg fa-caret-right" ></i> 
										</c:if>
													<c:out value="${model.MN_NAME}" escapeXml="false" />
												</span> - 
												<c:if test="${model.MN_USE_YN eq 'Y' }">
													<button type="button" class="btn btn-xs Menu_Update"  onclick="pf_Set_MainMenuUpdateView('${model.MN_HOMEDIV_C}','${model.MN_MAINKEY}','${model.MN_KEYNO}','${model.MN_LEV}')"><i class="fa fa-pencil"></i></button>
													<c:if test="${model.MN_PAGEDIV_C == MENU_TYPE_SUBMENU }">   
													<button type="button" class="btn btn-xs " onclick="pf_Set_MenuInsertView('${model.MN_HOMEDIV_C}', '${model.MN_KEYNO}','${model.MN_LEV}','${model.MN_URL }')"><i class="fa fa-plus"></i></button>
													</c:if>
													<button type="button" class="btn btn-xs " onclick="pf_UseChecking('${model.MN_KEYNO}','N','${model.MN_MAINKEY }')"><i class="fa fa-check-square-o"></i></button>
													<button type="button" class="btn btn-xs " onclick="pf_MenuDelete('${model.MN_KEYNO}','${model.MN_MAINKEY }')"><i class="fa fa-trash-o"></i></button>
													<c:if test="${model.MN_SHOW_YN eq 'Y' }">
													<button type="button" class="btn btn-xs " onclick="pf_ShowChecking('${model.MN_KEYNO}','N','${model.MN_MAINKEY }')"><i class="fa fa-unlock"></i></button>
													</c:if>
													<c:if test="${model.MN_SHOW_YN eq 'N' }">
													<button type="button" class="btn btn-xs " onclick="pf_ShowChecking('${model.MN_KEYNO}','Y','${model.MN_MAINKEY }')"><i class="fa fa-lock"></i></button>
													</c:if> 
												<!-- DB에 저장된 페이지 바로가기 -->
												</c:if>
												<c:if test="${model.MN_USE_YN eq 'N' }">
													<button type="button" class="btn btn-xs " onclick="pf_UseChecking('${model.MN_KEYNO}','Y','${model.MN_MAINKEY }')"><i class="fa fa-square-o"></i></button>
												</c:if>
<%-- 												<button type="button" class="btn btn-success btn-xs " onclick="pf_OpenAuthorityManager('${model.MN_KEYNO}','${model.MN_URL}','${model.MN_PAGEDIV_C }')"><i class="fa fa-sign-in"></i></button> --%>
												<!--게시판형  -->
												<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_BOARD }">
													<c:if test="${not empty model.MN_KEYNO }"> 
													<button  type="button" class="btn btn-primary btn-xs " onclick="pf_boardmanagement('${model.MN_KEYNO }')"><i class="fa fa-book"></i></button>
													</c:if>
												</c:if>
												
													<ul>
											<c:if test="${model.MN_PAGEDIV_C ne MENU_TYPE_SUBMENU || (model.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU && model.MN_CHILD_CNT eq 0)}">
													</ul>
											</li>
											</c:if>
										
											<c:if test="${status2.last && model.MN_LEV gt 1}">
												<c:forEach begin="1" end="${model.MN_LEV - 1}">
													</ul>
											</li>
												</c:forEach>
											</c:if>
												<c:set var="beforeDepth" value="${model.MN_LEV }"/>
									</c:forEach>
								</ul>
								<!-- depth1Group 끝 -->
							</li>
						</ul>
					</div>
					<!-- tree 끝 -->
				</div>
			</article>
		</div>
	</section>
</div>


<script type="text/javascript">

var refreshParentKey = '';

$(document).ready(function() {
	
	//초기 뎁스1 메뉴 셋팅
	//$('#depth1Group').html(pf_getSubList('${menu.MN_KEYNO}'));
	
	
	
	<c:if test="${menu.MN_KEYNO eq HOMEDIV_ADMIN }">
	//관리자페이지에서 메뉴타입 - 단일페이지, 관광 페이지형 숨김처리
	$('select[id$=-PAGEDIV_C] option[value=${MENU_TYPE_PAGE}]').hide();
	$('select[id$=-PAGEDIV_C] option[value=${MENU_TYPE_TOUR}]').hide();
	</c:if>
	
	//메뉴 등록 레이어 창 화면 생성
	pf_create_layerDialog("Mainmenu-insert", "insert", "메뉴 생성","pf_Mainmenu_insert()");
	//메뉴 정보 변경 레이어 창 화면 생성
	pf_create_layerDialog("Mainmenu-update", "update","메뉴 관리","pf_Mainmenu_update()");
	//메뉴 등록 - 홈페이지 추가
	pf_create_layerDialog("addNewHomepage", "insert","홈페이지 추가","pf_Home_insert()");
	//홈페이지 수정
	pf_create_layerDialog("modifyHomepage", "update","홈페이지 수정","pf_Home_update()");
	//xml 히스토리
	pf_create_layerDialog("Xml-history", "backup", "XML히스토리", "pf_Xml_backup()");
	
	$('#Mainmenu-insert-COLOR').colorpicker()
	$('#Mainmenu-update-COLOR').colorpicker() 
	
	$('.tree li.parent_li > ul > li').hide();
  	// 메뉴 트리 선택 이벤트 show/hide 처리
	$(document).on('click','.parent_li > span.label', function(e) {
		var children = $(this).parent('li.parent_li').find(' > ul > li,> div > ul > li');
		if (children.is(':visible')) {
			children.hide('fast');
			$(this).attr('title', 'Expand this branch')
					.find(' > i')
						.removeClass()
						.addClass('fa fa-lg fa-plus-circle');
		} else {
			children.show('fast');
		    $(this).attr('title', 'Collapse this branch').find(' > i').removeClass().addClass('fa fa-lg fa-minus-circle');
		} 
		e.stopPropagation();
	});
	$('.tree > ul > li > span').trigger('click');
  
});

//홈페이지 변경 처리
function pf_changeHomeDiv(value){
	$("#MN_HOMEDIV_C").val(value);
    $("#Form").attr("action","/txap/homepage/menu.do");
    cf_loading();
    $("#Form").submit();
}

//홈페이지 추가
function pf_openInsertHome(){
	$('#addNewHomepage + input').val('');
	$('#addNewHomepage').dialog('open');
	
}

//홈페이지 엑셀다운
function pf_excelDownHome(){
	cf_checkExcelDownload();
	
	$("#Form").attr('action','/txap/homepage/menu/excelAjax.do');
	$("#Form").submit();
	
}

//xml 리스트
function pf_xmlHistory(){
	$.ajax({
		type: "POST",
		url: "/txap/homepage/menu/xmlList/listAjax.do",
		async: false,
		data: {
			"MN_HOMEDIV_C"	: $('#MN_HOMEDIV_C').val()
		},
		success : function(data){
		  	temp = "";
		  	if(data.length > 0){
		  		$.each(data,function(i){
			  		temp += '<tr>';
				  	temp += '<td>'+data[i].FS_ORINM+'</td>';
				  	temp += '<td>'+data[i].REGDT+'</td>';
				  	temp += '<td><a href="javascript:;" class="btn btn-labeled btn-success" type="button" onclick="cf_download(\''+data[i].XH_FS_KEYNO+'\')" style="padding:3%; margin-right: 15px;"><i class="fa fa-check"></i> 파일다운</a>';
				  	temp += '<a href="javascript:;" class="btn btn-info" type="button" onclick="pf_Xml_Refresh(\''+data[i].XH_FS_KEYNO+'\')" style="padding:3%;"><i class="glyphicon glyphicon-refresh"></i> 복원하기</a></td>';
				  	temp += '<td><a href="javascript:;" class="btn btn-danger" type="button" onclick="pf_Xml_Delete(\''+data[i].XH_KEYNO+'\')" style="padding:5%;"><i class="fa fa-remove"></i> 삭제하기</a></td>'
				  	temp += '</tr>';
			  	});
		  	}else{
		  		temp += '<tr><td colspan="4">백업파일이 없습니다.</td></tr>';
		  	}
		  	$("#XmlListTable tbody").html(temp);
		  	$('#Xml-history').dialog('open');
		}, error: function(){
	        cf_smallBox('error', 'xml 히스토리 가져오기 에러', 3000,'#d24158');
			return false;
		}
	});
	
}

//xml 파일 백업하기
function pf_Xml_backup(){
	cf_checkExcelDownload();
	var url = '/txap/homepage/menu/xmlList/backupAjax.do';
	$.ajax({
		type: "POST",
		url: url,
		data: $("#Form").serialize(),
		success : function(){
			pf_xmlHistory();
			cf_smallBox('ajax', "백업을 완료하였습니다.", 3000);
		}, error: function(){
			cf_smallBox('error', "알수없는 에러, 관리자에게 문의하세요.", 3000,'#d24158');
			return false;
		}
	});
}

//xml 복원하기
function pf_Xml_Refresh(key){
	$("#XH_FS_KEYNO").val(key);
	$.ajax({
		type: "POST",
		url: '/txap/homepage/menu/xmlList/refreshAjax.do',
		data: $("#Form").serialize(),
		success : function(data){
			cf_smallBox('ajax', "복원을 완료하였습니다.", 3000);
			pf_changeHomeDiv(data);
		}, error: function(){
			cf_smallBox('error', "알수없는 에러, 관리자에게 문의하세요.", 3000,'#d24158');
			return false;
		}
	});
}

//xml 삭제하기
function pf_Xml_Delete(key){
	$.ajax({
		type: "POST",
		url: '/txap/homepage/menu/xmlList/deleteAjax.do',
		data: {"XH_KEYNO":key},
		success : function(data){
			cf_smallBox('ajax', "삭제완료", 3000);
			pf_xmlHistory();
		}, error: function(){
			cf_smallBox('error', "알수없는 에러, 관리자에게 문의하세요.", 3000,'#d24158');
			return false;
		}
	});
}

//홈페이지 수정
function pf_openUpdateHome(){
	$('#modifyHomepage + input').val('');
    $('#modifyHomepage').dialog('open'); 
}

//페이지 구분에 따른 입력상자 Show/Hide
function pf_checkShowAndHide(value,action,childCnt){
	//하위메뉴가 있는경우 소메뉴 변경 불가
	if(parseInt(childCnt) > 0){
		alert("하위메뉴가 존재합니다.");
		$("#Mainmenu-"+action+"-PAGEDIV_C").val('${MENU_TYPE_SUBMENU}').prop("selected", true);
		return false;
	}
	//URL 변경 처리
	if(value == '${MENU_TYPE_LINK}'){ //링크형
  		$('#Mainmenu-'+action+'-LINKBOX').show();
  		$('#Mainmenu-'+action+'-URLBOX').hide();
  	}else{
  		$('#Mainmenu-'+action+'-LINKBOX').hide();
  		$('#Mainmenu-'+action+'-URLBOX').show();
  	}
	
	<c:if test="${menu.MN_KEYNO ne HOMEDIV_ADMIN }">
	//페이지평가 제공 여부 - 소메뉴형과 링크형  제외 
	if(value != '${MENU_TYPE_SUBMENU}' && value != '${MENU_TYPE_LINK}'){
		$('.pageFiledset').show();
	}else{
		$('.pageFiledset').hide();
	}
	</c:if>
	
	//소메뉴 타입 show/hide
  	if(value == '${MENU_TYPE_SUBMENU}'){
  		$('.Mainmenu-'+action+'-SUBMENUBOX').show();
  		$('#Mainmenu-'+action+'-INTRO_URL').val('');
	}else{
		$('.Mainmenu-'+action+'-SUBMENUBOX').hide();
	}
	
	//게시판 타입 show/hide
  	if(value == '${MENU_TYPE_BOARD}'){
  		$('#Mainmenu-'+action+'-BOARDTYPEBOX').show();
  		$('#Mainmenu-'+action+'-BOARDTYPE').val('');
	}else{
		$('#Mainmenu-'+action+'-BOARDTYPEBOX').hide();
	}
	
  	//관광 타입 show/hide
  	if(value == '${MENU_TYPE_TOUR}'){
  		$('.Mainmenu-'+action+'-TOURTYPEBOX').show();
  		$('#Mainmenu-'+action+'-TOURTYPE').val('');
  		$('#Mainmenu-'+action+'-TOURKEY').val('');
	}else{
		$('.Mainmenu-'+action+'-TOURTYPEBOX').hide();
	}
}




//페이지 관리 페이지 보기 페이지 이동
function pf_DetailMove(keyno){
	$('#MVD_KEYNO').val(keyno);
	$("#Form").attr("action", "/txap/homepage/page/detailView.do");
	$("#Form").submit();
}

//페이지 만들기
function pf_makepage(home, name, url){
	$('#MN_HOMEDIV_C').val(home);
	$('#MN_NAME').val(name);
	$('#MN_URL').val(url);
	$("#Form").attr("action", "/txap/homepage/page/insertView.do");
	$("#Form").submit();
}
//게시판 관리로가기
function pf_boardmanagement(key){
	location.href="/txap/Board/dataView.do?MN_KEYNO="+key;
}



//sub 메뉴 리스트 가져오기
function pf_getSubList(key){
	var temp= '';
	$.ajax({
		type: "POST",
		url: "/txap/homepage/menu/subList/listAjax.do",
		async: false,
		data: {
			"MN_HOMEDIV_C"	: $('#MN_HOMEDIV_C').val(),
			"MN_MAINKEY"	: key
		},
		success : function(data){
		  	temp = data;
		}, error: function(){
			alert('메뉴 리스트 가져오기 에러')
			return false;
		}
	});
	return temp;
}
  
//URL 중복 검사 처리
function pf_urlCheck(url,key){
	var urlCheck = true;
	$.ajax({
		type: "POST",
		url: "/txap/homepage/menu/urlCheckAjax.do",
		async: false,
		data: {
			"MN_URL"	: url,
			"MN_KEYNO"	: key || ''
		},
		success : function(data){
		  	if(data > 0){
		  		urlCheck = false;
		  	}
		}, error: function(){
			alert('URL 중복검사 에러')
			return false;
		}
	});
	
	return urlCheck;
 
} 
  
function pf_forwardUrlCheck(){
	if( $('#MN_URL').val().trim() == $('#MN_FORWARD_URL').val().trim() ){
		alert("포워딩URL은 기본URL과 동일할 수 없습니다.");
		return false;
	}else{
		return true;
	}
}
      
// 등록, 수정 완료 후 처리
// 해당 메뉴 다시 불러옴
function pf_CallBack_Success(parentKey){
	$parentLi = $('li.parent_li[data-key="' + parentKey +'"]');
	$parentLi.find('ul').html(pf_getSubList(parentKey));
}

// 레이어창 다이얼로그 생성하기 
function pf_create_layerDialog(a,b,c,d){
	var btn_name = "";
	if(b == 'update'){
		btn_name = "변경하기";
	}else if(b == 'insert'){
		btn_name = "저장하기";
	}else if(b == 'backup'){
		btn_name = "백업하기";
	}
	$('#' + a).dialog({
		autoOpen : false, width : 800,  resizable : true, modal : true, title : c,
		buttons : [{ 
			html : "<i class='fa fa-floppy-o'></i>&nbsp;" + btn_name, "class" : "btn btn-primary", 
	        click : function() {
				if(eval(d)){
					$(this).dialog("close");  
				}
	        }
	  	}, { 
	  		html : "<i class='fa fa-times'></i>&nbsp; 취소하기", "class" : "btn btn-default", 
	        click : function() {
	          $(this).dialog("close");
			}
	  	}]
	});
}
  
// 레이어창 입력박스 체크 하기
function pf_Input_Check(){
	//메뉴의 이름 입력 여부를 판단한다.
	if(!$("#MN_NAME").val().trim()){
		cf_alert("메뉴명을 입력해주세요.");
		return false;
	}
	//정렬기준의 입력 여부를 판단한다.
	if($("#MN_ORDER").val()==""){
		cf_alert("정렬기준을 입력해주세요.");
		return false;
	}
	
	if($('#MN_PAGEDIV_C').val() == '${MENU_TYPE_LINK}'){ //링크형
		//URL 입력 여부를 판단한다.
	    if(!$("#MN_URL").val().trim()){
			cf_alert("URL을 입력해주세요.");
			return false;
	    }
	
	    if( !( $('#MN_URL').val().startsWith('http://') || $('#MN_URL').val().startsWith('https://') ) ){
			cf_alert('링크는 http:// 나 https:// 로 시작되어야됩니다.');
			return false;
		}
	}else{
		//URL 입력 여부를 판단한다.
	    if(!$('#depthURL').val()){
			cf_alert("URL을 입력해주세요.");
			return false;
	    }
	    var regType;
	    if($('#MN_PAGEDIV_C').val() == '${MENU_TYPE_SUBMENU}'){ //소메뉴형
	    	regType = /^[A-Za-z0-9+]{1,50}$/; 
	    }else{
	    	regType = /^[A-Za-z0-9+]{1,50}.do$/;
	    }
	    
		if(!regType.test($('#depthURL').val())){
			alert('url이 규칙에 맞지 않습니다.')	
			return false;
		}
		
	  	//URL 중복 체크 처리
	    if(!pf_urlCheck($("#MN_URL").val(), $("#MN_KEYNO").val())){
	    	alert('URL이 중복됩니다.  다른 URL을 입력 해 주세요.');
	    	return false;
	    }
	  	//URL과 forwardURL 중복 체크 - 현재 forwardUrl 안쓰고있음
	    /* if(!pf_forwardUrlCheck()){
			return false;
	    } */
	    
	    if($('#depthIntroURL').val()){
	    	var introUrlRegType = /^[A-Za-z0-9+]{1,50}.do$/;
		    
		    if(!introUrlRegType.test($('#depthIntroURL').val())){
				alert('소개페이지 url이 규칙에 맞지 않습니다.')	
				return false;
			}
		    
		  	if(!pf_urlCheck($("#MN_FORWARD_URL").val(), $("#MN_KEYNO").val())){
		  		alert('소개페이지 url이 중복됩니다.  다른 URL을 입력 해 주세요.')
		  		return false;
		  	}
	    }
	    
	  	
	  	if($('#MN_PAGEDIV_C').val() == '${MENU_TYPE_BOARD}' && !$('#MN_BT_KEYNO').val()){	//게시판형
	  		alert('게시판 형태를 선택하여주세요.');
	  		return false;
	  	}
	  	
	  	if($('#MN_PAGEDIV_C').val() == '${MENU_TYPE_TOUR}' && !$('#MN_TOURKEY').val()){	//관광 형
	  		alert('관광정보를 선택하여주세요.');
	  		return false;
	  	}
	  	
	}
	return true;
}
  
//기능 Ajax 처리 공통
function pf_Access_Ajax(url,msg,parentKey){

	$.ajax({
		type: "POST",
		url: url,
		data: $("#Form").serialize(),
		success : function(){
			if(msg){ 
				alert(msg);
				location.reload();
			}
			pf_CallBack_Success(parentKey);
		}, error: function(){
			return false;
		}
	});
}

//레이어창 값 정리 취득
function pf_getMenuAccess_val(a,b){
	$("#MN_PAGEDIV_C").val($("#" + a + "-PAGEDIV_C").val()); //페이지구분
	if($("#MN_PAGEDIV_C").val() == '${MENU_TYPE_LINK}'){ //링크형
		$("#MN_URL").val($("#" + a + "-LINKURL").val().trim()); //URL
	}else{
		
		var depthURL = $("#" + a + "-URL").val().trim();
		var url = $("#" + a + "-preURL").text() + depthURL;
		$("#MN_URL").val(url); //URL
		$('#depthURL').val(depthURL);
		
	}
	$("#MN_DATA1").val($("#" +  a+ "-DATA1").val().trim());
	$("#MN_DATA2").val($("#" +  a+ "-DATA2").val().trim());
	$("#MN_DATA3").val($("#" +  a+ "-DATA3").val().trim());
	$("#MN_COLOR").val($("#" +  a+ "-COLOR").val().trim());
	$("#MN_ENG_NAME").val($("#" +  a+ "-ENG-NAME").val().trim());
	$("#MN_DEP").val($("#" + a + "-DEP").val());
	
	if($("#MN_PAGEDIV_C").val() == '${MENU_TYPE_SUBMENU}'){
		var depthIntroURL = $("#" +  a+ "-INTRO_URL").val().trim();
		if(depthIntroURL){
			$("#MN_FORWARD_URL").val(url + "/" + depthIntroURL); // 소개 페이지 url
			$('#depthIntroURL').val(depthIntroURL);	
		}else{
			$("#MN_FORWARD_URL").val('');
		}
	}else{
		$("#MN_FORWARD_URL").val('');
	}
	
	
	
	$("#MN_NAME").val($("#" + a + "-NAME").val().trim()); // 메뉴명
	if(a == 'Mainmenu-update'){
		$("#MN_MAINKEY").val($("#" + a + "-MAINKEY").val()); // 메인키
	}
	
	$("#MN_ORDER").val($("#" + a + "-ORDER").val()); //메뉴 정렬순서
	$("#MN_ORDER_BEFORE").val($("#" + a + "-BEFORE").val()); //메뉴 정렬순서
	$("#MN_BT_KEYNO").val($("#" + a + "-BOARDTYPE").val()); //게시판 타입
	$("#MN_ICON_CSS").val($("#" + a + "-ICONBOX").val()); //CSS icon
	
	<c:if test="${menu.MN_HOMEDIV_C ne HOMEDIV_ADMIN }">
	$("#MN_RESEARCH").val($('input[name='+a + "-RESEARCH"+']:checked').val()); //페이지 평가 사용여부
	$("#MN_QRCODE").val($('input[name='+a + "-QRCODE"+']:checked').val()); //페이지평가 - 큐알코드 사용여부
	</c:if>
	
	$("#MN_MANAGER").val($("#" + a + "-MANAGER").val()); //페이지 평가 - 콘텐츠 담당자
	$("#MN_MANAGER_DEP").val($("#" + a + "-MANAGERDEP").val()); //페이지 평가 - 담당 부서
	$("#MN_MANAGER_TEL").val($("#" + a + "-MANAGERTEL").val()); //페이지 평가 - 담당자 연락처
	$("#MN_TOURKEY").val($("#" + a + "-TOURKEY").val()); //관광정보 키
  
}
  

  
//메뉴 등록 처리
function pf_Mainmenu_insert(){
 
	pf_getMenuAccess_val("Mainmenu-insert");
	if(!pf_Input_Check()){
		return false;
	}
	if($("#MN_MAINKEY").val() == ""){
		$("#MN_LEV").val("1");
	}else{
		$("#MN_LEV").val(Number($("#MN_LEV").val())+1);
	}
	
	pf_Access_Ajax("/txap/homepage/menu/insertAjax.do","저장이 완료 되었습니다.",$('#MN_KEYNO').val());
	
	return true;
}
  
//메뉴 수정 처리
function pf_Mainmenu_update(){
	pf_getMenuAccess_val("Mainmenu-update");
	if(!pf_Input_Check()){
		return false;
	}
	if($("#MN_MAINKEY").val() == ""){
	    $("#MN_LEV").val("1");
	}else{
		$("#MN_LEV").val(Number($("#MN_LEV").val())+1);
	}
	pf_Access_Ajax("/txap/homepage/menu/updateAjax.do","변경이 완료 되었습니다.",$('#MN_MAINKEY').val());
	return true;
}
  
//홈페이지 신규등록 처리
function pf_Home_insert(){
	if( allInputCheck_notNull('#form_newHome') ){
		
  		//이미지 용량, 확장자 제한
  		if(document.getElementById("homeimg").value!=""){
  			var fileimg = document.getElementById("homeimg");
  			var fileSize = fileimg.size;
  			var maxSize = 1 * 1024 * 1024;
  			
  			if(fileSize > maxSize){
  				alert("용량은 1MB를 초과할 수 없습니다.");
  				return;
  			}
  			
  			var thumbext = fileimg.value;
  			thumbext = thumbext.slice(thumbext.indexOf(".")+1).toLowerCase();
  			
  			if(thumbext != "ico"){
  				alert("확장자는 ico만 등록 가능합니다.");
  				return;
  			}
  		}
  		
  		var tilesName = $("#form_newHome [name=HM_TILES]").val(); 
  		var check = true;
			
		if(!tilesName){
			alert('타일즈 이름을 입력하여주세요');
			check = false;
			
		}else{
		  				
			 $.ajax({
		     	type: "POST",
		        url: "/txap/homepage/menu/homeMenu/checkTilesNameAjax.do",
		        data: {
		        	"HM_TILES":tilesName
		        },
			    async:false,
		        success : function(result){
		          if(result == 'F'){
		        	  alert('중복되거나 사용할수없는 타일즈 이름입니다.');
		        	  check = false;
		          }
		        }, 
		        error: function(){
		        	console.log('에러 : #9382433')
		        	check = false;
		        }
	       	});
			
		}
		
		if(!check){
		$("#form_newHome [name=HM_TILES]").focus();
			return false;
		}
			
			
  		var homeUrl = $("#form_newHome [name=MN_URL]").val().trim();
  		var regType = /^[/][A-Za-z0-9+]{1,50}$/; 
		
		if(!regType.test(homeUrl)){
	  		alert('/ 로 시작되어야하고 영문과 숫자로만 구성되어야됩니다 50자 제한')
	  		$("#form_newHome [name=MN_URL]").focus()
	  		return false;
  		}
		
		check = true;
		//URL 중복 체크 처리
    	if( !pf_urlCheck(homeUrl) ){
      		check = false;
    	}else{
    		var reservedUrl = [
    				'/async',
    				'/common',
    				'/admin'
    		];
    		
    		for(var i in reservedUrl){
    			if(homeUrl == reservedUrl[i]){
    				check = false;
    			}
    		}
    	}
		
		if(!check){
			alert('홈페이지 메인 URL이 중복되거나 사용할수 없는 URL입니다.\n다른 URL을 입력 해 주세요.');
      		$("#form_newHome [name=MN_URL]").focus()
      		return false;
		}
		
		
		
		$('#form_newHome input[name=HAM_DEFAULT_URL]').each(function(){ 
			if(check && $(this).val() && !($(this).val().startsWith(homeUrl+"/") && $(this).val().endsWith(".do"))){
				alert('권한별 시작페이지 URL은 시작 URL로 시작되어야되고, .do로 끝나야합니다.');
				$(this).focus();
				check = false;
			}
		})
		
		if(!check){
      		return false;
		}
			
		
    	if(confirm('추가하시겠습니까?')){
    		cf_loading();
    		$("#form_newHome select[name=HM_MENU_DEPTH]").attr("disabled", false);
    		cf_replaceTrim($("#form_newHome"));
		  	$('#form_newHome').attr('action','/txap/homepage/menu/homeMenu/insert.do?${_csrf.parameterName}=${_csrf.token}');
			$('#form_newHome').submit();
    	}
 	}
	return false;

}
  
//홈페이지 수정 처리
function pf_Home_update(){
 	if( allInputCheck_notNull('#form_modifyHome') ){
		
 		var check = true;
 		var homeUrl = $("#form_modifyHome [name=MN_URL]").val().trim();
 		$('#form_modifyHome input[name=HAM_DEFAULT_URL]').each(function(){ 
			if(check && $(this).val() && !($(this).val().startsWith(homeUrl+"/") && $(this).val().endsWith(".do"))){
				alert('권한별 시작페이지 URL은 시작 URL로 시작되어야되고, .do로 끝나야합니다.');
				$(this).focus();
				check = false;
			}
		})
		
		if(!check){
      		return false;
		}
 		
 		
  		if(confirm('수정하시겠습니까?')){
  			cf_replaceTrim($("#form_modifyHome"));  		
	  		$('#form_modifyHome').attr('action','/txap/homepage/menu/homeMenu/update.do?${_csrf.parameterName}=${_csrf.token}');
	  		$('#form_modifyHome').submit();
  		}
  	}
	return false;
	
}

//홈페이지 삭제
function pf_Home_delete(){
	if(confirm('정말 삭제하시겠습니까? 관련 모든 데이터가 삭제됩니다.')){
		location.href='/txap/homepage/menu/homeMenu/delete.do?key=${homeData.HM_KEYNO}';
	}
}
  
  
/* 폼 갯수 많을 때 입력 체크 - 미입력 폼으로 포커싱까지  */
function allInputCheck_notNull($form){
	var trueFalse = true;
	$($form + ' input').not('[type=hidden], [name=_csrf], .exceptForm').each(function(){
		if( !$(this).val().trim() ){
			alert('해당 값을 입력해주세요.');
			$(this).focus();
			trueFalse = false;
			return false;
		}
	})
	return trueFalse;
}
  
  
//메뉴 수정 레이어창 화면처리
function pf_Set_MainMenuUpdateView(homekey,mainkey,key,lev){
	$subMenu =$('#Mainmenu-update-PAGEDIV_C').find('option[value=${MENU_TYPE_SUBMENU}]');
	if(lev >= '${homeData.HM_MENU_DEPTH }' ){
		$subMenu.hide();
   	}else{
	   	$subMenu.show();
   	}
    
    $('#Mainmenu-update').dialog('open');
    
    pf_resetForm();
    var pageDivC = pf_setMenuAccess_val(homekey,mainkey,key);
    
    
    
}

//레이어창 값 삽입
function pf_setMenuAccess_val(homekey,mainkey,key){
	var pageDivC = '';
	var childCnt = 0;  
	
	$.ajax({
		url: '/txap/homepage/menu/dataAjax.do',
      	type: 'POST',
      	data: {
			"MN_HOMEDIV_C":homekey,
      	 	"MN_MAINKEY":mainkey,
      	 	"MN_KEYNO":key
      	},
      	async: false,  
      	success: function(data) {
			var result = data.result;
			var menuCnt = data.MenuCnt;
      	 	if(result){
				pageDivC = result.MN_PAGEDIV_C;
				pf_checkShowAndHide(pageDivC,'update',0);
      	 		
      	 		var thisUrl = result.MN_URL
	          	$("#MN_KEYNO").val(result.MN_KEYNO);
				$("#MN_LEV").val(result.MN_LEV);
				$("#Mainmenu-update-NAME").val(result.MN_NAME);
				$("#Mainmenu-update-MAINKEY").val(result.MN_MAINKEY);
				
				childCnt = result.MN_CHILD_CNT;
				$("#Mainmenu-update-PAGEDIV_C").val(pageDivC);
				$("#Mainmenu-update-PAGEDIV_C").attr("onchange", "pf_checkShowAndHide(this.value,'update',\'"+childCnt+"\');");
				$("#MN_beforeURL").val(thisUrl);
				  
				$("#Mainmenu-update-ORDER").empty();
				for(var i = 1; i <= menuCnt; i++){
					var option = $('<option>'+i+'</option>');
					$("#Mainmenu-update-ORDER").append(option);
					$("#Mainmenu-update-ORDER").val(result.MN_ORDER).prop("selected", true);
 				}
				$("#Mainmenu-update-BEFORE").val(result.MN_ORDER);
				
				$("#Mainmenu-update-BOARDTYPE").val(result.MN_BT_KEYNO);
				$("#Mainmenu-update-ICONBOX").val(result.MN_ICON_CSS);
				$("#Mainmenu-update-ENG-NAME").val(result.MN_ENG_NAME);
				$("#Mainmenu-update-DEP").val(result.MN_DEP);
				$("#Mainmenu-update-COLOR").val(result.MN_COLOR);
				$("#Mainmenu-update-DATA1").val(result.MN_DATA1);
				$("#Mainmenu-update-DATA2").val(result.MN_DATA2);
				$("#Mainmenu-update-DATA3").val(result.MN_DATA3);
				
				<c:choose>
					<c:when test="${menu.MN_KEYNO eq HOMEDIV_ADMIN }">
				pf_refreshIcon_updateForm(result.MN_ICON_CSS); // CSS icon리스트 선택하기
					</c:when>
					<c:otherwise>
				$("input[name=Mainmenu-update-RESEARCH][value="+result.MN_RESEARCH+"]").prop('checked',true);
				$("input[name=Mainmenu-update-QRCODE][value="+result.MN_QRCODE+"]").prop('checked',true);
				$("#Mainmenu-update-MANAGER").val(result.MN_MANAGER);
				$("#Mainmenu-update-MANAGERDEP").val(result.MM_MANAGER_DEP);
				$("#Mainmenu-update-MANAGERTEL").val(result.MM_MANAGER_TEL);
					</c:otherwise>
				</c:choose>
				
				if(pageDivC == '${MENU_TYPE_LINK}'){ //링크형
					$('#Mainmenu-update-LINKURL').val(thisUrl);
				}else{
					/* URL,preURL 가공&삽입 부분  */
					var url = thisUrl.split('/');
					if(url.length == 2){ //최상위 홈메뉴일 경우
						$('#Mainmenu-update-preURL').text('');
					   	$('#Mainmenu-update-URL').val(thisUrl);
					}else{
					   	var lastIndex = thisUrl.lastIndexOf('/')+1;
					   	$('#Mainmenu-update-preURL').text(thisUrl.substring(0,lastIndex));
					   	$('#Mainmenu-update-URL').val(thisUrl.substring(lastIndex));
					}
					pf_setUrlInputWidth('update');
					
				}
				
				if(pageDivC == '${MENU_TYPE_SUBMENU}'){ //소메뉴형
				   	var introUrl = result.MN_FORWARD_URL;
				   	if(introUrl){
				   		introUrl = introUrl.substring(introUrl.lastIndexOf('/')+1)
				   	}
				   	$('#Mainmenu-update-INTRO_URL').val(introUrl);
				}
				
				
				if(pageDivC == '${MENU_TYPE_TOUR}'){ //관광형
					$('#Mainmenu-update-TOURCATEGORY').val(result.MN_TOUR_CATEGORY);
					pf_chageTourCategory('update',result.MN_TOUR_CATEGORY);
					$('#Mainmenu-update-TOURKEY').val(result.MN_TOURKEY);
					$('#Mainmenu-update-TOURKEY').trigger('change');
				
				}
				
			}
		},
	    error :function(){
  	   		alert('에러!! 관리자한테 문의하세요');
  	   		state = false;
	    }
	}); 
	return pageDivC;
}

//아이콘 업데이트
function pf_refreshIcon_updateForm($iconClassNm){
	$('#menuIconBox_update .demo-icon-font').removeClass('selectedIcon');
	$('#menuIconView_update').attr('class','');
	if($iconClassNm){
	  	var classNm = $iconClassNm.replace('fa ', '');
		$('#menuIconBox_update .' + classNm).parents('.demo-icon-font:first').trigger('click');
	}
}

  
  
function pf_Set_MenuInsertView(homekey,key,lev,url){
   	var length;
   	$.ajax({
		type: "POST",
		url: "/txap/homepage/menu/countAjax.do",
		data: {
			"key":key,
			"homekey":homekey
		},
		async:false,
	   		success : function(result){
	     	length = result;
	   	}, error: function(){
	     	return false;
	   	}
 	});
   
  	var boardOption =$('#Mainmenu-insert-PAGEDIV_C').find('option[value=SC_QXCFB]');
  	if(lev >= Number('${homeData.HM_MENU_DEPTH }') - 1 ){
   		boardOption.css("display","none");
  	}else{
    	boardOption.css("display","block");
  	}
   	pf_resetForm();
   	$('#MN_KEYNO').val(key); //비동기 메뉴갱신할 때 사용
   	$('#MN_MAINKEY').val(key);
   	$('#MN_LEV').val(lev);
   	$('#Mainmenu-insert').dialog('open');
   	$('#Mainmenu-insert .url-input span').text(url+"/")
  	
   	pf_setUrlInputWidth('insert');
   	
   	
   	//정렬 순서 부분
   	$('#Mainmenu-insert-ORDER').empty();
   	for(var i = 1; i <= length+1; i++){
		var option = $('<option>'+i+'</option>');
		$('#Mainmenu-insert-ORDER').append(option);
		$('#Mainmenu-insert-ORDER option:last').prop("selected", true);
   	}
   	$('input[id^=Mainmenu-insert]').val('');
   	$('#Mainmenu-insert-PAGEDIV_C').val('${MENU_TYPE_SUBMENU}')

	pf_checkShowAndHide('${MENU_TYPE_SUBMENU}','insert',0);
   	
}


/**
 * URL박스 width 값 셋팅
 */
function pf_setUrlInputWidth(type){
	
	
	$('#Mainmenu-' + type + ' .url-input').each(function(){
		var spanWidth = $(this).find('span').width();
	   	var divWidth = $(this).width();
	   
	   	$(this).find('input').width(divWidth - 50 - spanWidth);	
	   	
	})
	
	
	
   	
}

  
  
/* 선택메뉴 비활성화 처리 */
function pf_UseChecking(key, use,mainkey){
	$("#MN_KEYNO").val(key);
	$("#MN_USE_YN").val(use); 
	pf_Access_Ajax("/txap/homepage/menu/use/updateAjax.do","",mainkey);
}
  
/* 선택메뉴 보이기/감추기 처리 */
function pf_ShowChecking(key, show,mainkey){
	$("#MN_KEYNO").val(key);
	$("#MN_SHOW_YN").val(show); 
	pf_Access_Ajax("/txap/homepage/menu/show/updateAjax.do","",mainkey);
}
    
/* 메뉴 논리 삭제 */
function pf_MenuDelete(a,b){
	cf_confirm("삭제하시겠습니까?","pf_MenuDeleteAccess('"+a+"','"+b+"')");
} 
  
// 메뉴 삭제 콜백 처리 
function pf_MenuDeleteAccess(key,mainkey){
	
	mainkey = mainkey || $('#MN_MAINKEY').val();
	
	$("#MN_KEYNO").val(key);
	pf_Access_Ajax("/txap/homepage/menu/deleteAjax.do","삭제처리가 완료 되었습니다.",mainkey);
}
  
//세팅된 값들을 초기화 시킴 - form 1개만 컨트롤하기 위해 사용
function pf_resetForm(){
	var MN_HOMEDIV_C_bak = '${menu.MN_HOMEDIV_C }';
	$('#Form + input').val('');
	$('#MN_HOMEDIV_C').val(MN_HOMEDIV_C_bak);
}
  
  
 function pf_imgCheckAndPreview2(id,ext,maxSize){
	var MB = 1048576;
	//값이 없으면 30MB 셋팅
	maxSize = maxSize || 30;
	
	ext = ext || 'ico';
	var isIE9 = (navigator.userAgent.indexOf('MSIE 9.0') != -1);  
	var path =$('#'+id).val();
	if(!path){ // 파일 선택 취소 처리
		$('#'+id+'_img').attr('src','');
	}
	
	
	var thisExt = path.substring(path.lastIndexOf('.') + 1).toLowerCase();  
	if(ext.indexOf(thisExt) != -1)  
	{ 
		$('#'+id+'_text').val($('#'+id).val());
		var f = document.getElementById(id).files[0];
		var size = f.size;
		if(size > maxSize * MB){
			alert('파일이 너무 큽니다.('+maxSize+'MB 제한)' );
		}
		if(isIE9) {  
			// $('#'+id+'_img').attr('src', path);  
		}else{  
			
			var reader = new FileReader();
			reader.onload = (function(evt) {  //evt get all value
				$('#'+id+'_img').attr('src',evt.target.result).show();
				
			});
			reader.readAsDataURL(f);
		}  
		
	}else{  
		alert('파일 형식이 잘못되었습니다.');
		$('#'+id).val('');
	}   
	
}  

function pf_chageTourCategory(type,value){
	
	var temp = '<option value="">선택하세요.</option>'
	
	if(value){
		$.ajax({
			type: "POST",
			url: "/txap/tour/info/list2Ajax.do",
			async: false,
			data: {
				"TC_TYPE"	: value,
				"TC_USE"	: 'Y'
			},
			success : function(data){
			  	
				if(data.length > 0){
					
					$.each(data,function(i){
						temp += '<option value="'+data[i].TC_KEYNO+'">'+data[i].TC_TITLE+'</option>'
					})
					
					
				}else{
					temp = '<option value="">데이터 없음</option>'
				}
				
				
			}, error: function(){
				alert('관광정보 가져오기 에러')
			}
		});
	}
	
	$('#Mainmenu-'+type+'-TOURKEY').html(temp).select2();
	
}

function pf_urlSetting(obj){
	var value = $(obj).val();
	value = value.toLowerCase();
	$(obj).val(value);
	$('#form_newHome input[name=MN_URL]').val("/" + value);
}
 
 
</script>
<%@ include file="/WEB-INF/jsp/txap/homepage/menu/script/pra_menu_list_authority_script.jsp" %>
<%@ include file="/WEB-INF/jsp/txap/homepage/menu/pra_menu_pop.jsp" %>
<%@ include file="/WEB-INF/jsp/txap/homepage/menu/pra_menu_xml_pop.jsp" %>