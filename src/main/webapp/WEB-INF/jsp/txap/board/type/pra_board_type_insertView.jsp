<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
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
.input-group-addon {
	background-color: #fff;
	border: none;
}
.checkboxWrap{
    border-bottom: 3px solid #ddd;
}
.inputmargin{
	margin-top: 10px;
}
</style>

<script type="text/javascript">

	var addOptionCnt = 1;
	var modifybool = true;
	var modifytextobj;

	var BOARD_COLUMN_TYPE_TITLE = '${BOARD_COLUMN_TYPE_TITLE}';
	var BOARD_COLUMN_TYPE_CHECK = '${BOARD_COLUMN_TYPE_CHECK}';
	var BOARD_COLUMN_TYPE_RADIO = '${BOARD_COLUMN_TYPE_RADIO}';
	var BOARD_COLUMN_TYPE_SELECT = '${BOARD_COLUMN_TYPE_SELECT}';
	var BOARD_COLUMN_TYPE_CHECK_CODE = '${BOARD_COLUMN_TYPE_CHECK_CODE}';
	var BOARD_COLUMN_TYPE_RADIO_CODE = '${BOARD_COLUMN_TYPE_RADIO_CODE}';
	var BOARD_COLUMN_TYPE_SELECT_CODE = '${BOARD_COLUMN_TYPE_SELECT_CODE}';
	var BOARD_COLUMN_TYPE_CALENDAR_START = '${BOARD_COLUMN_TYPE_CALENDAR_START}';
	var BOARD_COLUMN_TYPE_CALENDAR_END = '${BOARD_COLUMN_TYPE_CALENDAR_END}';

	$(function() {
		cf_checkbox_checked_val("COMMENT_YN", "N");
		cf_checkbox_checked_val("SECRET_YN", "N");
		cf_checkbox_checked_val("UPLOAD_YN", "N");
		cf_checkbox_checked_val("REPLY_YN", "N");
		cf_checkbox_checked_val("HTML_YN", "N");
		cf_checkbox_checked_val("THUMBNAIL_YN", "N");
		$('.thumnailResize').hide();
		cf_checkbox_checked_val("EMAIL_YN", "N");
		$('.emailAddress').hide();
		cf_checkbox_checked_val("DEL_LISTVIEW_YN", "Y");
		cf_checkbox_checked_val("DEL_COMMENT_YN", "Y");
		cf_checkbox_checked_val("SHOW_MINE_YN", "N");
		cf_checkbox_checked_val("DEL_POLICY", "L");
		cf_checkbox_checked_val("XSS_YN", "N");
		cf_checkbox_checked_val("HTMLMAKER_PLUS_YN", "N");
		cf_checkbox_checked_val("NUMBERING_TYPE", "V");
		$(".uploadRow").hide();
		pf_defaultColumn();

		$("#AddColumn").sortable(
				{
					beforeStop : function(event, ui) {
						$("#AddColumn .column-row").find(
								"input[name='BL_COLUMN_LEVEL']").each(
								function(i) {
									$(this).val(i + 1);
								})
					}
				});
		$("#AddColumn").disableSelection();
		
		$('input[name=THUMBNAIL_YN]').on('click',function() {
			if ($(this).is(':checked')) {
				$('.thumnailResize').show();
			} else {
				$('.thumnailResize').hide();
			}
		});

		$('input[name=EMAIL_YN]').on('click',function() {
			if ($(this).is(':checked')) {
				$('.emailAddress').show();
			} else {
				$('.emailAddress').hide();
			}
		});
		
		$('input[name=UPLOAD_YN]').on('click',function() {
			if ($(this).is(':checked')) {
				$(".uploadRow").show();
			} else {
				$(".uploadRow").hide();
				$("#BT_FILE_SIZE_LIMIT").val("0");
				$("#BT_FILE_CNT_LIMIT").val("0");
			}
		});

	})
	
	function pf_fileExt(type){
		if(type == 'Y'){
			$("#FILE_EXT").show();
		}else{
			$("#FILE_EXT").hide();			
		}
	}

	//게시판 타입 등록 처리 및 입력 폼 체크
	function pf_boardTypeInsert() {
		
		pf_checkBox();
		
		var fileExtCkVal = $('input[name=FILE_EXT]:checked').val();
		if(fileExtCkVal == 'blank'){
			$("#BT_FILE_EXT").val($("#FILE_EXT").val());
		}else{
			$("#BT_FILE_EXT").val(fileExtCkVal);			
		}
		
		if (!$("#BT_TYPE_NAME").val().trim()) {
			alert("게시판 타입명을 입력해주세요");
			return false;
		}
		if (!$("#BT_CODEKEY").val()) {
			alert("게시판 형태를 선택해주세요");
			return false;
		}

		if (!$("#BT_PAGEUNIT").val()) {
			alert("한 페이지당 게시되는 게시물 건 수를 확인하여주세요");
			$("#BT_PAGEUNIT").focus();
			return false;
		}

		if (!$("#BT_PAGESIZE").val()) {
			alert("페이지 리스트에 게시되는 페이지 건수를 확인하여주세요");
			$("#BT_PAGESIZE").focus();
			return false;
		}

		if ($('input[name=THUMBNAIL_YN]').is(':checked')) {
			if (!$("#BT_THUMBNAIL_WIDTH").val()
					|| $("#BT_THUMBNAIL_WIDTH").val() == 0) {
				alert("썸네일 리사이즈 width 값을 설정하여주세요.");
				$("#BT_THUMBNAIL_WIDTH").focus();
				return false;
			}
			if (!$("#BT_THUMBNAIL_HEIGHT").val()
					|| $("#BT_THUMBNAIL_HEIGHT").val() == 0) {
				alert("썸네일 리사이즈 height 값을 설정하여주세요.");
				$("#BT_THUMBNAIL_HEIGHT").focus();
				return false;
			}
		}

		if ($('input[name=EMAIL_YN]').is(':checked')) {
			if (!$("#BT_EMAIL_ADDRESS").val()) {
				alert("이메일 주소를 설정하여주세요.");
				$("#BT_EMAIL_ADDRESS").focus();
				return false;
			}
		}

		if ($('input[name=UPLOAD_YN]').is(':checked')) {

			if (!isNumberic($("#BT_FILE_CNT_LIMIT").val())
					|| Number($("#BT_FILE_CNT_LIMIT").val()) == 0) {
				alert("업로드 파일 수를 확인해주세요");
				return false;
			}
			if (!isNumberic($("#BT_FILE_SIZE_LIMIT").val())
					|| Number($("#BT_FILE_SIZE_LIMIT").val()) == 0) {
				alert("업로드 파일크기를 확인해주세요");
				return false;
			}
			
// 			if (!$("#BT_FILE_IMAGE_WIDTH").val()
// 					|| $("#BT_FILE_IMAGE_WIDTH").val() == 0) {
// 				alert("이미지 width 값을 설정하여주세요.");
// 				$("#BT_FILE_IMAGE_WIDTH").focus();
// 				return false;
// 			}
// 			if (!$("#BT_FILE_IMAGE_HEIGHT").val()
// 					|| $("#BT_FILE_IMAGE_HEIGHT").val() == 0) {
// 				alert("이미지 height 값을 설정하여주세요.");
// 				$("#BT_FILE_IMAGE_HEIGHT").focus();
// 				return false;
// 			}
		
			if(!$("#BT_FILE_EXT").val()){
				alert("업로드 확장자를 입력해 주세요.");
				$("#FILE_EXT").focus();
				return false;
			}	
			
			
		}
		if ($("#AddColumn").find(".column-row").length < 1) {
			alert("컬럼을 추가해주세요");
			return false;
		}

		if (valcheck()) {
			if (confirm("게시판 타입을 생성하시겠습니까?")) {
				success();
			} else {
				exit();
			}
		}
	}
	
	function valcheck() {
		var bool = true;
		$("#AddColumn")
				.find(".column-row")
				.each(
						function() {

							if ($(this).find("input[name='BL_COLUMN_LEVEL']")
									.val() == "") {
								alert("정렬순서를 입력해주세요");
								bool = false;
								return false;
							} else if (!$(this).find(
									"input[name='BL_COLUMN_NAME']").val()
									.trim()) {
								alert("컬럼명를 입력해주세요");
								bool = false;
								return false;
							} else if ($(this).find("select[name='BL_TYPE']")
									.val() == "") {
								alert("컬럼 타입을 선택해주세요");
								bool = false;
								return false;
							} else if ($(this).find(
									"select[name='BL_LISTVIEW_YN']").val() == "Y"
									&& $(this).find(
											"select[name='BL_COLUMN_SIZE']")
											.val() == "") {
								alert("컬럼 가로크기를 선택해주세요");
								bool = false;
								return false;
							} else if ($(this).find(
									"select[name='BL_LISTVIEW_YN']").val() == "") {
								alert("리스트 노출여부를 선택해주세요");
								bool = false;
								return false;
							}

							var BL_TYPE = $(this).find('select[name=BL_TYPE]')
									.val();
							if (BL_TYPE == '${BOARD_COLUMN_TYPE_RADIO}'
									|| BL_TYPE == '${BOARD_COLUMN_TYPE_SELECT}'
									|| BL_TYPE == '${BOARD_COLUMN_TYPE_CHECK}') {
								var length = $(
										"#Addoption_dialog_"
												+ $(this).attr('id')).find(
										'span.label').length;
								if (length < 1) {
									var name = $(this).find(
											'input[name=BL_COLUMN_NAME]').val();
									alert(name + '의 옵션이 설정되지 않았습니다. 확인하여주세요.');
									bool = false;
									return false;
								}
							} else if (BL_TYPE == '${BOARD_COLUMN_TYPE_RADIO_CODE}'
									|| BL_TYPE == '${BOARD_COLUMN_TYPE_SELECT_CODE}'
									|| BL_TYPE == '${BOARD_COLUMN_TYPE_CHECK_CODE}') {
								if (!$(this).find('select[name=BL_CODE]').val()) {
									var name = $(this).find(
											'input[name=BL_COLUMN_NAME]').val();
									alert(name + '의 코드가 설정되지 않았습니다. 확인하여주세요.');
									bool = false;
									return false;
								}
							}

						})
		return bool;
	}
	function pf_back() {
		location.href = "/txap/Board/typeView.do";
	}

	//성공 콜백 함수   
	function success() {
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/Board/type/insert.do");
		$("#Form").submit();
	}

	//실패 콜백 함수   
	function exit() {
		alert("취소되었습니다.");
		return false;
	}
	function pf_AddColumn() {
		var divID = "column-row" + addOptionCnt;
		var html = "";
		html += "<div id='"+divID+"' class='column-row'>";
		html += "<div class='row'>";
		html += "<input type='hidden' name='BL_KEYNO' value=''>";
		html += "<input type='hidden' id='BL_OPTION_DATA"+divID+"' name='BL_OPTION_DATA' value=''>";
		html += "<section class='col col-1'>";
		html += "<label class='input'> <i class='icon-prepend fa fa-edit'></i> ";
		html += "<input type='text' id='BL_COLUMN_LEVEL"
				+ divID
				+ "' name='BL_COLUMN_LEVEL' placeholder='정렬순서'  maxlength='2' onkeydown='return cf_only_Num(event);' readonly='readonly'/>";
		html += "</label>";
		html += "</section>";
		html += "<section class='col col-3'>";
		html += "<label class='input'> <i class='icon-prepend fa fa-edit'></i>";
		html += "<input type='text' class='checkTrim' name='BL_COLUMN_NAME' placeholder='컬럼명'  maxlength='50' />";
		html += "</label>";
		html += "</section>";
		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_TYPE' id='BL_TYPE" + divID
				+ "' onchange=pf_ColumnTypeChange('" + divID + "')>";
		html += "<option value=''>컬럼 타입</option>";

		<c:forEach items="${ColumnType}" var="model">
		html += "<option value='${model.SC_KEYNO}'>${model.SC_CODENM}</option>";
		</c:forEach>

		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_VALIDATE' id='BL_VALIDATE"+divID+"'>";
		html += "<option value=''>필수입력 여부</option>";
		html += "<option value='Y'>Y</option>";
		html += "<option value='N'>N</option>";
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_LISTVIEW_YN' id='BL_LISTVIEW_YN" + divID
				+ "' onchange=pf_ColumnViewYN('" + divID + "')>";
		html += "<option value=''>리스트 노출여부</option>";
		html += "<option value='Y'>Y</option>";
		html += "<option value='N'>N</option>";
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-1 selectCodeWrap'>";
		html += "<label class='select'>";
		html += "<select name='BL_CODE' id='BL_CODE" + divID
				+ "' onchange=pf_SettingCode('" + divID + "',this)>";
		html += "<option value=''>코드선택</option>";
		<c:forEach items="${MainCodeList}" var="model">
		html += "<option value='${model.MC_KEYNO}'>${model.MC_CODENM}</option>";
		</c:forEach>
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-2' style='height: 32px; line-height: 32px; vertical-align: middle;'>";
		html += "<section class='col-12 text-center' style='height: 32px; line-height: 32px; vertical-align: middle;'>";
		html += "<a href='javascript:;' onclick=pf_columnDelete('" + divID
				+ "')>";
		html += "삭제하기";
		html += "</a>";
		html += "<span class='option_dp'>"
		html += "|  ";
		html += "<a href='javascript:;' onclick=pf_optiondialog_open('" + divID
				+ "')>";
		html += "옵션관리";
		html += "</a> ";
		html += "</span>";
		html += "</section>";
		html += "</section>";
		html += "</div>";
		html += "</div>";
		$("#AddColumn").append(html);

		//제목타입은 삭제
		$('#BL_TYPE' + divID + ' option[value=' + BOARD_COLUMN_TYPE_TITLE + ']')
				.remove();

		optionhtml(divID);
		addOptionCnt++;
		$("#AddColumn .column-row").find("input[name='BL_COLUMN_LEVEL']").each(
				function(i) {
					$(this).val(i + 1);
				})

	}

	//코드타입 코드 셋팅
	function pf_SettingCode(divID, obj) {
		$('#BL_OPTION_DATA' + divID).val($(obj).val())
	}

	function pf_optiondialog_open(divID) {
		$("#Addoption_dialog_" + divID).dialog("open");
	}
	function pf_columnDelete(obj) {
		$("#" + obj).remove();
		$("#Addoption_dialog_" + obj).remove();
		$("#AddColumn .column-row").find("input[name='BL_COLUMN_LEVEL']").each(
				function(i) {
					$(this).val(i + 1);
				})
	}

	function optionhtml(divID) {
		var html = "";
		html += "<div id='Addoption_dialog_"+divID+"' title='옵션관리'>";
		html += "<fieldset>";
		html += "<div class='form-group'>";
		html += "<input class='form-control' placeholder='옵션이름 입력' type='text' id='option_data_"+divID+"'/>";
		html += "</div>";
		html += "<div class='form-group no-margin' >";
		html += "<label id='option_Msg_"+divID+"'></label>";
		html += "</div>";
		html += "<div class='form-group text-right'>";
		html += "<button class='btn btn-success' onclick=pf_option_action('"
				+ divID + "')>";
		html += "<i class='fa fa-save'></i>&nbsp; 저장";
		html += "</button>";
		html += "</div>";
		html += "<div class='form-group'>";
		html += "<label><i class='fa fa-th-list'></i> 옵션 내역</label> <br/>";
		html += "<label id='Addoption_dialog_ContentsBox_"+divID+"'>";
		html += "</label>";
		html += "</div>";
		html += "</fieldset>";
		html += "</div>";
		$("#optiondialog_append").append(html);
		$("#Addoption_dialog_" + divID).dialog(
				{
					autoOpen : false,
					width : 600,
					resizable : true,
					modal : true,
					close : function(event, ui) {
						var data = "";
						leng = $("#Addoption_dialog_ContentsBox_" + divID)
								.find('.atext').length;
						$("#Addoption_dialog_ContentsBox_" + divID).find(
								'.atext').each(
								function(i) {
									data += $(this).html();
									if (i + 1 < leng) {
										data += "|";
									}
									$("#" + divID).find(
											'#BL_OPTION_DATA' + divID)
											.val(data)
								})
						modifybool = true;
						modifytextobj = null;
						$("#option_data_" + divID).val("");
					}
				});
	}

	function pf_ColumnTypeChange(divID) {

		$("#" + divID).find('.option_dp').hide();
		$("#" + divID).find('.selectCodeWrap').hide();

		var ChangeSelectBox = $("#BL_TYPE" + divID).val();
		if (ChangeSelectBox == BOARD_COLUMN_TYPE_CHECK
				|| ChangeSelectBox == BOARD_COLUMN_TYPE_RADIO
				|| ChangeSelectBox == BOARD_COLUMN_TYPE_SELECT) {
			$("#" + divID).find('.option_dp').show();
		} else if (ChangeSelectBox == BOARD_COLUMN_TYPE_CHECK_CODE
				|| ChangeSelectBox == BOARD_COLUMN_TYPE_RADIO_CODE
				|| ChangeSelectBox == BOARD_COLUMN_TYPE_SELECT_CODE) {
			$("#" + divID).find('.selectCodeWrap').show();
		} else if (ChangeSelectBox == BOARD_COLUMN_TYPE_CALENDAR_START) {
			var count = 0;
			$("select[name=BL_TYPE]").each(function() {

				if ($(this).val() == BOARD_COLUMN_TYPE_CALENDAR_START) {
					count++;
				}

				if (count > 1) {
					alert("달력(시작날짜) 컬럼은 한개만 등록 가능합니다.")
					$(this).val("");
					return false;
				}
			});
		} else if (ChangeSelectBox == BOARD_COLUMN_TYPE_CALENDAR_END) {
			var count = 0;
			$("select[name=BL_TYPE]").each(function() {

				if ($(this).val() == BOARD_COLUMN_TYPE_CALENDAR_END) {
					count++;
				}

				if (count > 1) {
					alert("달력(종료날짜) 컬럼은 한개만 등록 가능합니다.")
					$(this).val("");
					return false;
				}
			});
		}
	}

	//옵션 정보 등록/수정 처리
	function pf_option_action(divID) {
		if (modifybool) {
			//입력 정보 검사
			if ($("#option_data_" + divID).val() == '') {
				alert("옵션이름을 입력하세요.");
				$("#option_data_" + divID).focus();
				return false;
			}
			var HtmlContents = "";
			// 등록할 옵션 정보 삽입
			HtmlContents += "<span class=\"label bg-color-blue\" style=\"margin-right:10px;\">"
					+ "<a href=\"javascript:;\" class=\"label atext\" "
					+ "onclick=\"pf_modify_view(this,'"
					+ divID
					+ "')\" >"
					+ $("#option_data_" + divID).val()
					+ "</a><a class=\"label\" href=\"javascript:;\">"
					+ "<i class=\"fa fa-trash-o\" onclick=pf_option_delete(this) ></i></a></span>";
			$("#Addoption_dialog_ContentsBox_" + divID).html(
					$("#Addoption_dialog_ContentsBox_" + divID).html()
							+ HtmlContents);
		} else {
			$(modifytextobj).html($("#option_data_" + divID).val())
			modifybool = true;
		}
		$("#option_data_" + divID).val("");
	}
	function pf_modify_view(obj, divID) {
		$("#option_data_" + divID).val($(obj).html());
		modifybool = false;
		modifytextobj = obj;
	}

	function pf_ColumnViewYN(divID) {
		var ChangeSelectBox = $("#BL_LISTVIEW_YN" + divID).val();
		if (ChangeSelectBox == 'Y') {
			$("#" + divID).find('.column_size_dp').show();
		} else {
			$("#" + divID).find('.column_size_dp').hide();
		}
	}

	function pf_option_delete(obj) {
		$(obj).parent().parent().remove();
	}

	function pf_defaultColumn() {
		var divID = "column-row" + addOptionCnt;
		var html = "";
		html += "<div id='"+divID+"' class='column-row'>";
		html += "<div class='row'>";
		html += "<input type='hidden' name='BL_KEYNO' value=''>";
		html += "<input type='hidden' id='BL_OPTION_DATA"+divID+"' name='BL_OPTION_DATA' value=''>";
		html += "<section class='col col-1'>";
		html += "<label class='input'> <i class='icon-prepend fa fa-edit'></i> ";
		html += "<input type='text' id='BL_COLUMN_LEVEL"
				+ divID
				+ "' name='BL_COLUMN_LEVEL' placeholder='정렬순서'  maxlength='2' onkeydown='return cf_only_Num(event);' value='1' readonly='readonly'/>";
		html += "</label>";
		html += "</section>";
		html += "<section class='col col-3'>";
		html += "<label class='input'> <i class='icon-prepend fa fa-edit'></i>";
		html += "<input type='text' class='checkTrim' name='BL_COLUMN_NAME' placeholder='컬럼명'  maxlength='50' value='제목'/>";
		html += "</label>";
		html += "</section>";
		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_TYPE' id='BL_TYPE" + divID
				+ "' onchange=pf_ColumnTypeChange('" + divID + "')>";
		html += "<option value='"+BOARD_COLUMN_TYPE_TITLE+"'>제목</option>";
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_VALIDATE' id='BL_VALIDATE"+divID+"'>";
		html += "<option value=''>필수 여부</option>";
		html += "<option value='Y' selected>Y</option>";
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_LISTVIEW_YN' id='BL_LISTVIEW_YN" + divID
				+ "' onchange=pf_ColumnViewYN('" + divID + "')>";
		html += "<option value=''>리스트 노출여부</option>";
		html += "<option value='Y' selected>Y</option>";
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "</div>";
		html += "</div>";

		$("#AddColumn").append(html);
		optionhtml(divID);
		addOptionCnt++;
	}
	
	//체크박스 값 넣기
	function pf_checkBox(){
		$('input[type=checkbox]').each(function(i){
			var checkVal = 'Y'
			var checkID = $(this).attr("id");
			if(!$(this).is(":checked")){
				if(checkID == 'NUMBERING_TYPE'){	//번호 넘버링 값
					checkVal = 'R';
				}else{
					checkVal = 'N'
				}
			}else{
				if(checkID == 'NUMBERING_TYPE'){	//번호 넘버링 값
					checkVal = 'V';
				}
			}
			$('#BT_'+checkID).val(checkVal);
			
			if(!$(this).is(":checked")){
				if(checkID == 'DEL_POLICY'){	//게시물 삭제 정책 값
					checkVal = 'P';
				}
			}else{
				if(checkID == 'DEL_POLICY'){	//번호 넘버링 값
					checkVal = 'L';
				}
			}
			$('#BT_'+checkID).val(checkVal);
			
		})
	}
</script>
<style>
.option_dp, .selectCodeWrap, .column_size_dp {
	display: none;
}
</style>
<div id="content">
	<form:form id="Form" name="Form" method="post" action="">
		<input type="hidden" name="BT_REGNM" value="${userInfo.UI_ID }" />
		<input type="hidden" name="BT_FILE_EXT" id="BT_FILE_EXT" value=""/>
		<input type="hidden" id="BT_HTML_YN" name="BT_HTML_YN" value="${BoardType.BT_HTML_YN }"/>
		<input type="hidden" id="BT_XSS_YN" name="BT_XSS_YN" value="${BoardType.BT_XSS_YN }"/>
		<input type="hidden" id="BT_HTMLMAKER_PLUS_YN" name="BT_HTMLMAKER_PLUS_YN" value="${BoardType.BT_HTMLMAKER_PLUS_YN }"/>
		<input type="hidden" id="BT_NUMBERING_TYPE" name="BT_NUMBERING_TYPE" value="${BoardType.BT_NUMBERING_TYPE }"/>
		<input type="hidden" id="BT_SECRET_YN" name="BT_SECRET_YN" value="${BoardType.BT_SECRET_YN }"/>
		<input type="hidden" id="BT_REPLY_YN" name="BT_REPLY_YN" value="${BoardType.BT_REPLY_YN }"/>
		<input type="hidden" id="BT_COMMENT_YN" name="BT_COMMENT_YN" value="${BoardType.BT_COMMENT_YN }"/>
		<input type="hidden" id="BT_DEL_LISTVIEW_YN" name="BT_DEL_LISTVIEW_YN" value="${BoardType.BT_DEL_LISTVIEW_YN }"/>
		<input type="hidden" id="BT_DEL_COMMENT_YN" name="BT_DEL_COMMENT_YN" value="${BoardType.BT_DEL_COMMENT_YN }"/>
		<input type="hidden" id="BT_THUMBNAIL_YN" name="BT_THUMBNAIL_YN" value="${BoardType.BT_THUMBNAIL_YN }"/>
		<input type="hidden" id="BT_EMAIL_YN" name="BT_EMAIL_YN" value="${BoardType.BT_EMAIL_YN }"/>
		<input type="hidden" id="BT_UPLOAD_YN" name="BT_UPLOAD_YN" value="${BoardType.BT_UPLOAD_YN }"/>
		<div class="row">
			<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
				<h1 class="page-title txt-color-blueDark">
					<i class="fa fa-table fa-fw "></i> 게시판관리 <span>> 게시판 타입 등록 </span>
				</h1>
			</div>
		</div>

		<section id="widget-grid">
			<div class="row">
				<article class="col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget jarviswidget-color-blueDark" id=""
						data-widget-editbutton="false">
						<header>
							<span class="widget-icon"> <i class="fa fa-table"></i>
							</span>
							<h2>게시판 타입 등록</h2>
						</header>

						<div>
							<div class="widget-body-toolbar bg-color-white">
								<div class="alert alert-info no-margin fade in">
									<button type="button" class="close" data-dismiss="alert">×</button>
									새로운 게시판 타입 정보를 생성합니다.<br> <span style="color: red;">*표시는
										필수 입력 항목입니다.</span>
								</div>
							</div>

							<div class="widget-body no-padding smart-form">
								<fieldset>
									<div class="row">
										<section class="col col-12">
											<h6>게시판 정보 등록</h6>
										</section>
									</div>

									<div class="row">
										<section class="col col-6">
											<span class="nessSpan">*</span> 게시판 타입명 <label class="input">
												<i class="icon-prepend fa fa-edit"></i> <input
												class="checkTrim inputmargin" type="text" id="BT_TYPE_NAME"
												name="BT_TYPE_NAME" placeholder="게시판 타입명" maxlength="50"
												value="" />
											</label>
										</section>
										<section class="col col-6">
											<span class="nessSpan">*</span> 게시판 유형 <label class="select">
												<select name="BT_CODEKEY" id="BT_CODEKEY" class="inputmargin">
													<option value="">게시판 유형</option>
													<c:forEach items="${Code }" var="model">
														<option value="${model.SC_KEYNO }">${model.SC_CODENM }</option>
													</c:forEach>
											</select> <i></i>
											</label>
										</section>
									</div>
									<div class="row">
										<section class="col col-6">
											<label class="label input">한 페이지당 게시되는 게시물 건 수 <input
												type="number" id="BT_PAGEUNIT" name="BT_PAGEUNIT" value="10" class="inputmargin"
												oninput="cf_maxLengthCheck(this)" max="99" maxlength="2" />
											</label>
										</section>
										<section class="col col-6">
											<label class="label input"> 페이지 리스트에 게시되는 페이지 건수 <input
												type="number" id="BT_PAGESIZE" name="BT_PAGESIZE" value="5" class="inputmargin"
												oninput="cf_maxLengthCheck(this)" max="99" maxlength="2" />
											</label>
										</section>
									</div>
									<div class="row checkboxWrap" style="margin-bottom: 15px;">	
										<section class="col col-6">
											<label class="col-md-4 control-label">소개HTML 사용여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="HTML_YN" value="" 
																			class="onoffswitch-checkbox" id="HTML_YN" >
																	<label class="onoffswitch-label" for="HTML_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">XSS 필터 사용여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="XSS_YN" value="" 
																			class="onoffswitch-checkbox" id="XSS_YN" >
																	<label class="onoffswitch-label" for="XSS_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">Web 에디터 추가</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="HTMLMAKER_PLUS_YN" value="" 
																			class="onoffswitch-checkbox" id="HTMLMAKER_PLUS_YN" >
																	<label class="onoffswitch-label" for="HTMLMAKER_PLUS_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">번호 넘버링 종류</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch" style="width: 70px;">
																	<input type="checkbox" name="NUMBERING_TYPE" value="" 
																			class="onoffswitch-checkbox" id="NUMBERING_TYPE" >
																	<label class="onoffswitch-label" for="NUMBERING_TYPE"> 
																		<span class="onoffswitch-inner" data-swchon-text="가상번호" data-swchoff-text="실제번호"></span> 
																		<span class="onoffswitch-switch onoffswitch-switch2"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">비밀글 기능 사용여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="SECRET_YN" value="" 
																			class="onoffswitch-checkbox" id="SECRET_YN" >
																	<label class="onoffswitch-label" for="SECRET_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">답글 기능 사용여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="REPLY_YN" value="" 
																			class="onoffswitch-checkbox" id="REPLY_YN" >
																	<label class="onoffswitch-label" for="REPLY_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">댓글 기능 사용여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="COMMENT_YN" value="" 
																			class="onoffswitch-checkbox" id="COMMENT_YN" >
																	<label class="onoffswitch-label" for="COMMENT_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">삭제된 게시물 리스트에 보여질지 여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="DEL_LISTVIEW_YN" value="" 
																			class="onoffswitch-checkbox" id="DEL_LISTVIEW_YN" >
																	<label class="onoffswitch-label" for="DEL_LISTVIEW_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">삭제된 댓글 보여질지 여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="DEL_COMMENT_YN" value="" 
																			class="onoffswitch-checkbox" id="DEL_COMMENT_YN" >
																	<label class="onoffswitch-label" for="DEL_COMMENT_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">자기가 쓴글만 보이기 여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="SHOW_MINE_YN" value="" 
																			class="onoffswitch-checkbox" id="SHOW_MINE_YN" >
																	<label class="onoffswitch-label" for="SHOW_MINE_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6">
											<label class="col-md-4 control-label">게시물 삭제 정책</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch" style="width: 70px;">
																	<input type="checkbox" name="DEL_POLICY" value="" 
																			class="onoffswitch-checkbox" id="DEL_POLICY" >
																	<label class="onoffswitch-label" for="DEL_POLICY"> 
																		<span class="onoffswitch-inner" data-swchon-text="논리삭제" data-swchoff-text="물리삭제"></span> 
																		<span class="onoffswitch-switch onoffswitch-switch2"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										</div>
										
										<div class="row">
										<section class="col col-6">
											<label class="col-md-4 control-label">썸네일 사용여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="THUMBNAIL_YN" value="" 
																			class="onoffswitch-checkbox" id="THUMBNAIL_YN" >
																	<label class="onoffswitch-label" for="THUMBNAIL_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-3 thumnailResize">
											<label class="label input">썸네일 리사이즈 weight 값(단위 px) <input
												type="number" id="BT_THUMBNAIL_WIDTH" class="inputmargin"
												name="BT_THUMBNAIL_WIDTH" value="0"
												oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4" />
											</label>
										</section>
										<section class="col col-3 thumnailResize">
											<label class="label input">썸네일 리사이즈 height 값(단위 px) <input
												type="number" id="BT_THUMBNAIL_HEIGHT" class="inputmargin"
												name="BT_THUMBNAIL_HEIGHT" value="0"
												oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4" />
											</label>
										</section>
										</div>
										<div class="row">
										<section class="col col-6">
											<label class="col-md-4 control-label">글 등록시 이메일 수신여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="EMAIL_YN" value="" 
																			class="onoffswitch-checkbox" id="EMAIL_YN" >
																	<label class="onoffswitch-label" for="EMAIL_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>
										
										<section class="col col-6 emailAddress">
											이메일 주소 <label class="input inputmargin"> <i
												class="icon-prepend fa fa-edit"></i> <input type="text"
												id="BT_EMAIL_ADDRESS" name="BT_EMAIL_ADDRESS"
												placeholder="E-mail" maxlength="50"
												value="${BoardType.BT_EMAIL_ADDRESS }" />
											</label>
										</section>
										</div>
										
										<div class="row">
										<section class="col col-4">
											<label class="col-md-6 control-label">업로드 기능 사용여부</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1" style="margin-left: 5px;">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch">
																	<input type="checkbox" name="UPLOAD_YN" value="" 
																			class="onoffswitch-checkbox" id="UPLOAD_YN" >
																	<label class="onoffswitch-label" for="UPLOAD_YN"> 
																		<span class="onoffswitch-inner" data-swchon-text="YES" data-swchoff-text="NO"></span> 
																		<span class="onoffswitch-switch"></span> 
																	</label> 
																</span>
															</span>
														</label>	
													</div>
												</div>
											</div>
										</section>

										<div class="col col-2 uploadRow">
											<div class="form-group">
												<label class="label input">업로드 파일 수 제한 <input
													class="form-control inputmargin" id="BT_FILE_CNT_LIMIT"
													name="BT_FILE_CNT_LIMIT" value="0" type="number"
													oninput="cf_maxLengthCheck(this)" max="999" maxlength="3">
												</label>
											</div>
										</div>
										<div class="col col-2 uploadRow">
											<div class="form-group">
												<label class="label input">업로드 파일크기 제한(MB) <input
													class="form-control inputmargin" id="BT_FILE_SIZE_LIMIT"
													name="BT_FILE_SIZE_LIMIT" value="0" type="number"
													oninput="cf_maxLengthCheck(this)" max="999" maxlength="3">
												</label>
											</div>
										</div>
									   <div class="col col-2 uploadRow">
											<div class="form-group">
												<label class="label input">업로드 이미지 Weight값(단위 px) <input
													class="form-control inputmargin" id="BT_FILE_IMAGE_WIDTH"
													name="BT_FILE_IMAGE_WIDTH" value="0" type="number"
													oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4">
												</label>
											</div>
										</div>
										<div class="col col-2 uploadRow">
											<div class="form-group">
												<label class="label input">업로드 이미지 height값(단위 px) <input
													class="form-control inputmargin" id="BT_FILE_IMAGE_HEIGHT"
													name="BT_FILE_IMAGE_HEIGHT" value="0" type="number"
													oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4">
												</label>
											</div>
										</div>
									</div>
									<div class="row uploadRow">
										<div class="col col-6">
											<label class="col-md-4 control-label">업로드 확장자</label>
											<div class="inline-group">
												<div class="row">
													<label class="radio"> <input type="radio"
														name="FILE_EXT" value="bmp,jpg,png,gif,jpeg,hwp,pdf,zip,xls,xlsx,doc,docx,ppt,pptx" onclick="pf_fileExt('N');" checked> <i></i>통합파일
													</label> 
													<label class="radio"> <input type="radio"
														name="FILE_EXT" value="hwp,txt,pdf,xls,xlsx,doc,docx,ppt,pptx" onclick="pf_fileExt('N');"> <i></i>문서 파일류
													</label> 
													<label class="radio"> <input type="radio"
														name="FILE_EXT" value="bmp,jpg,png,gif,jpeg" onclick="pf_fileExt('N');"> <i></i>이미지 파일류
													</label> 
													<label class="radio"> <input type="radio"
														name="FILE_EXT" value="blank" onclick="pf_fileExt('Y');"> <i></i>직접입력
													</label>
												</div>
											</div>
										</div>
										<div class="col col-6 inline-group">
											<input class="form-control" id="FILE_EXT" type="text" placeholder="bmp,jpg,png,gif,jpeg,hwp,pdf,zip,xls,xlsx,doc,docx,ppt,pptx" style="display: none; margin-bottom: 15px;">
										</div>
									</div>
									
								</fieldset>

								<fieldset>
									<div class="smart-form">
										<div class="row">
											<section class="col col-1">
												<h6>컬럼 등록</h6>
											</section>
											<section class="col col-3">
												<button class="btn btn-sm btn-primary" id="Board_Edit"
													type="button" onclick="pf_AddColumn()">
													<i class="fa fa-floppy-o"></i> 컬럼추가(정렬순서 드래그)
												</button>
											</section>
										</div>
										<div class="row columnTitle">
											<section class="col col-1">순서</section>
											<section class="col col-3">제목</section>
											<section class="col col-1">컬럼타입</section>
											<section class="col col-1">필수입력 여부</section>
											<section class="col col-1">리스트 노출여부</section>
											<section class="col col-3">기타옵션</section>
										</div>
										<fieldset id="AddColumn"></fieldset>
									</div>
								</fieldset>
								<fieldset class="padding-10 text-right">
									<button class="btn btn-sm btn-primary" id="Board_Edit"
										type="button" onclick="pf_boardTypeInsert()">
										<i class="fa fa-floppy-o"></i> 저장
									</button>
									<button class="btn btn-sm btn-default" id="Board_Delete"
										type="button" onclick="pf_back()">
										<i class="fa fa-times"></i> 취소
									</button>
								</fieldset>
							</div>
						</div>
					</div>
				</article>
			</div>
		</section>
	</form:form>
</div>
<div id="optiondialog_append"></div>

