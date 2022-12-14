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
		cf_checkbox_checked_val("COMMENT_YN", "${BoardType.BT_COMMENT_YN }");
		cf_checkbox_checked_val("HTMLMAKER_PLUS_YN",
				"${BoardType.BT_HTMLMAKER_PLUS_YN }");
		cf_checkbox_checked_val("SECRET_YN", "${BoardType.BT_SECRET_YN }");
		cf_checkbox_checked_val("UPLOAD_YN", "${BoardType.BT_UPLOAD_YN }");
		cf_checkbox_checked_val("REPLY_YN", "${BoardType.BT_REPLY_YN }");
		cf_select_check("BT_CODEKEY", "${BoardType.BT_CODEKEY }");
		cf_checkbox_checked_val("HTML_YN", "${BoardType.BT_HTML_YN }");
		cf_checkbox_checked_val("THUMBNAIL_YN", "${BoardType.BT_THUMBNAIL_YN }");
		if ($('input[name=THUMBNAIL_YN]').is(':checked')) {
			$('.thumnailResize').show();
		} else {
			$('.thumnailResize').hide();
		}
		cf_checkbox_checked_val("DEL_LISTVIEW_YN","${BoardType.BT_DEL_LISTVIEW_YN }");
		cf_checkbox_checked_val("DEL_COMMENT_YN", "${BoardType.BT_DEL_COMMENT_YN }");
		cf_checkbox_checked_val("SHOW_MINE_YN", "${BoardType.BT_SHOW_MINE_YN }");
		cf_checkbox_checked_val("DEL_POLICY", "${BoardType.BT_DEL_POLICY }");
		cf_checkbox_checked_val("XSS_YN", "${BoardType.BT_XSS_YN}");
		cf_checkbox_checked_val("NUMBERING_TYPE", "${BoardType.BT_NUMBERING_TYPE}");
		cf_checkbox_checked_val("EMAIL_YN", "${BoardType.BT_EMAIL_YN }");
		if ($('input[name=EMAIL_YN]').is(':checked')) {
			$('.emailAddress').show();
		} else {
			$('.emailAddress').hide();
		}

		var extCk = false;
		$('input[name=FILE_EXT]').each(function(){
			if($(this).val() == '${BoardType.BT_FILE_EXT }'){
				extCk = true;
			}
		});
		if(!extCk){
			cf_radio_checked("FILE_EXT", "blank");
			$("#FILE_EXT").val('${BoardType.BT_FILE_EXT }');
			$("#FILE_EXT").show();
		}else{
			cf_radio_checked("FILE_EXT", "${BoardType.BT_FILE_EXT }");
		}
		
		if ($('input[name=UPLOAD_YN]').is(':checked')) {
			$(".uploadRow").show();
		}else{
			$(".uploadRow").hide();
			$("#BT_FILE_SIZE_LIMIT").val("0");
			$("#BT_FILE_CNT_LIMIT").val("0");
		}

		pf_initColumn('${BoardType.BT_KEYNO }');

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
	
	//????????? ?????? ?????? ?????? ??? ?????? ??? ??????
	function pf_boardTypeUpdate() {

		pf_checkBox()
		
		var fileExtCkVal = $('input[name=FILE_EXT]:checked').val();
		if(fileExtCkVal == 'blank'){
			$("#BT_FILE_EXT").val($("#FILE_EXT").val());
		}else{
			$("#BT_FILE_EXT").val(fileExtCkVal);			
		}
		
		if (!$("#BT_TYPE_NAME").val().trim()) {
			alert("????????? ???????????? ??????????????????");
			$("#BT_TYPE_NAME").focus();
			return false;
		}
		if (!$("#BT_CODEKEY").val()) {
			alert("????????? ????????? ??????????????????");
			$("#BT_CODEKEY").focus();
			return false;
		}

		if (!$("#BT_PAGEUNIT").val()) {
			alert("??? ???????????? ???????????? ????????? ??? ?????? ?????????????????????");
			$("#BT_PAGEUNIT").focus();
			return false;
		}

		if (!$("#BT_PAGESIZE").val()) {
			alert("????????? ???????????? ???????????? ????????? ????????? ?????????????????????");
			$("#BT_PAGESIZE").focus();
			return false;
		}

		if ($('input[name=THUMBNAIL_YN]').is(':checked')) {
			if (!$("#BT_THUMBNAIL_WIDTH").val()
					|| $("#BT_THUMBNAIL_WIDTH").val() == 0) {
				alert("????????? ???????????? width ?????? ?????????????????????.");
				$("#BT_THUMBNAIL_WIDTH").focus();
				return false;
			}
			if (!$("#BT_THUMBNAIL_HEIGHT").val()
					|| $("#BT_THUMBNAIL_HEIGHT").val() == 0) {
				alert("????????? ???????????? height ?????? ?????????????????????.");
				$("#BT_THUMBNAIL_HEIGHT").focus();
				return false;
			}
		}

		if ($('input[name=EMAIL_YN]').is(':checked')) {
			if (!$("#BT_EMAIL_ADDRESS").val()) {
				alert("????????? ????????? ?????????????????????.");
				$("#BT_EMAIL_ADDRESS").focus();
				return false;
			}
		}

		if ($('input[name=UPLOAD_YN]').is(':checked')) {

			if (!isNumberic($("#BT_FILE_CNT_LIMIT").val())
					|| Number($("#BT_FILE_CNT_LIMIT").val()) == 0) {
				alert("????????? ?????? ?????? ??????????????????");
				return false;
			}
			if (!isNumberic($("#BT_FILE_SIZE_LIMIT").val())
					|| Number($("#BT_FILE_SIZE_LIMIT").val()) == 0) {
				alert("????????? ??????????????? ??????????????????");
				return false;
			}
			if($('input[name=THUMBNAIL_YN]').is(':checked')){
				if(!$("#BT_THUMBNAIL_WIDTH").val() || $("#BT_THUMBNAIL_WIDTH").val() == 0) {
					alert("????????? ???????????? width ?????? ?????????????????????.");
					$("#BT_THUMBNAIL_WIDTH").focus();
					return false;
				}
				if(!$("#BT_THUMBNAIL_HEIGHT").val() || $("#BT_THUMBNAIL_HEIGHT").val() == 0) {
					alert("????????? ???????????? height ?????? ?????????????????????.");
					$("#BT_THUMBNAIL_HEIGHT").focus();
					return false;
				}
			}
			if(!$("#BT_FILE_EXT").val()){
				alert("????????? ???????????? ????????? ?????????.");
				$("#FILE_EXT").focus();
				return false;
			}	
		}	
				
		if ($("#AddColumn").find(".column-row").length < 1) {
			alert("????????? ??????????????????");
			return false;
		}

		if (valcheck()) {
			if (confirm("????????? ????????? ?????????????????????????")) {
				success();
			} else {
				exit();
			}
		}
	}

	//?????? ??????
	function pf_boardTypeDelete() {
		if (confirm("????????? ????????? ?????????????????????????")) {
			$("#Form").attr("action", "/txap/Board/type/delete.do");
			$("#Form").submit();
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
								alert("??????????????? ??????????????????");
								bool = false;
								return false;
							} else if (!$(this).find(
									"input[name='BL_COLUMN_NAME']").val()
									.trim()) {
								alert("???????????? ??????????????????");
								bool = false;
								return false;
							} else if ($(this).find("select[name='BL_TYPE']")
									.val() == "") {
								alert("?????? ????????? ??????????????????");
								bool = false;
								return false;
							} else if ($(this).find(
									"select[name='BL_VALIDATE']").val() == "") {
								alert("???????????? ????????? ??????????????????");
								bool = false;
								return false;
							} else if ($(this).find(
									"select[name='BL_LISTVIEW_YN']").val() == "Y"
									&& $(this).find(
											"select[name='BL_COLUMN_SIZE']")
											.val() == "") {
								alert("?????? ??????????????? ??????????????????");
								bool = false;
								return false;
							} else if ($(this).find(
									"select[name='BL_LISTVIEW_YN']").val() == "") {
								alert("????????? ??????????????? ??????????????????");
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
									var name = $(this).find('#BL_COLUMN_NAME')
											.val();
									alert(name + '??? ????????? ???????????? ???????????????. ?????????????????????.');
									bool = false;
									return false;
								}
							} else if (BL_TYPE == '${BOARD_COLUMN_TYPE_RADIO_CODE}'
									|| BL_TYPE == '${BOARD_COLUMN_TYPE_SELECT_CODE}'
									|| BL_TYPE == '${BOARD_COLUMN_TYPE_CHECK_CODE}') {
								if (!$(this).find('select[name=BL_CODE]').val()) {
									var name = $(this).find('#BL_COLUMN_NAME')
											.val();
									alert(name + '??? ????????? ???????????? ???????????????. ?????????????????????.');
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

	//?????? ?????? ??????   
	function success() {
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/Board/type/update.do");
		$("#Form").submit();
	}

	//?????? ?????? ??????   
	function exit() {
		alert("?????????????????????.");
		return false;
	}

	function pf_AddColumn() {
		var divID = "column-row" + addOptionCnt;
		var html = "";
		html += "<div id='"+divID+"' class='column-row'>";
		html += "<div class='row'>";
		html += "<input type='hidden' id='BL_KEYNO' name='BL_KEYNO' value=''>";
		html += "<input type='hidden' id='BL_OPTION_DATA"+divID+"' name='BL_OPTION_DATA' value=''>";
		html += "<section class='col col-1'>";
		html += "<label class='input'> <i class='icon-prepend fa fa-edit'></i> ";
		html += "<input type='text' id='BL_COLUMN_LEVEL"
				+ divID
				+ "' name='BL_COLUMN_LEVEL' placeholder='????????????'  maxlength='50' value='' readonly='readonly' onkeydown='return cf_only_Num(event);'/>";
		html += "</label>";
		html += "</section>";
		html += "<section class='col col-3'>";
		html += "<label class='input'> <i class='icon-prepend fa fa-edit'></i>";
		html += "<input class='checkTrim' type='text' id='BL_COLUMN_NAME' name='BL_COLUMN_NAME' placeholder='?????????'  maxlength='50' value=''/>";
		html += "</label>";
		html += "</section>";
		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_TYPE' id='BL_TYPE" + divID
				+ "' onchange=pf_ColumnTypeChange('" + divID + "')>";
		html += "<option value=''>?????? ??????</option>";
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
		html += "<option value=''>???????????? ??????</option>";
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
		html += "<option value=''>????????? ????????????</option>";
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
		html += "<option value=''>????????????</option>";
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
		html += "????????????";
		html += "</a>";
		html += "<span class='option_dp'>"
		html += "|  ";
		html += "<a href='javascript:;' onclick=pf_optiondialog_open('" + divID
				+ "')>";
		html += "????????????";
		html += "</a> ";
		html += "</span>"
		html += "</section>";
		html += "</section>";
		html += "</div>";
		html += "</div>";
		$("#AddColumn").append(html);

		//??????????????? ??????
		$('#BL_TYPE' + divID + ' option[value=' + BOARD_COLUMN_TYPE_TITLE + ']')
				.remove();

		optionhtml(divID);
		addOptionCnt++;

		$("#AddColumn .column-row").find("input[name='BL_COLUMN_LEVEL']").each(
				function(i) {
					$(this).val(i + 1);
				})
	}

	//???????????? ?????? ??????
	function pf_SettingCode(divID, obj) {
		$('#BL_OPTION_DATA' + divID).val($(obj).val())
	}

	function pf_optiondialog_open(divID) {
		$("#Addoption_dialog_" + divID).dialog("open");
	}
	function pf_columnDelete(obj) {
		if ($("#" + obj).find("#BL_KEYNO").val() != "") {
			var delhtml = "<input type='hidden' name='delete_bl_keyno' value='"
					+ $("#" + obj).find("#BL_KEYNO").val() + "' />";
			$("#Form").append(delhtml);
		}
		$("#" + obj).remove();
		$("#Addoption_dialog_" + obj).remove();

		$("#AddColumn .column-row").find("input[name='BL_COLUMN_LEVEL']").each(
				function(i) {
					$(this).val(i + 1);
				})
	}

	function optionhtml(divID) {
		var html = "";
		html += "<div id='Addoption_dialog_"+divID+"' title='????????????'>";
		html += "<fieldset>";
		html += "<div class='form-group'>";
		html += "<input class='form-control' placeholder='???????????? ??????' type='text' id='option_data_"+divID+"'/>";
		html += "</div>";
		html += "<div class='form-group no-margin' >";
		html += "<label id='option_Msg_"+divID+"'></label>";
		html += "</div>";
		html += "<div class='form-group text-right'>";
		html += "<button class='btn btn-success' onclick=pf_option_action('"
				+ divID + "')>";
		html += "<i class='fa fa-save'></i>&nbsp; ??????";
		html += "</button>";
		html += "</div>";
		html += "<div class='form-group'>";
		html += "<label><i class='fa fa-th-list'></i> ?????? ??????</label> <br/>";
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
						if (leng == 0) {
							$("#" + divID).find('#BL_OPTION_DATA' + divID).val(
									"")
						} else {
							$("#Addoption_dialog_ContentsBox_" + divID).find(
									'.atext').each(
									function(i) {
										data += $(this).html();
										if (i + 1 < leng) {
											data += "|";
										}
										$("#" + divID).find(
												'#BL_OPTION_DATA' + divID).val(
												data)
									})
						}
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
					alert("??????(????????????) ????????? ????????? ?????? ???????????????.")
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
					alert("??????(????????????) ????????? ????????? ?????? ???????????????.")
					$(this).val("");
					return false;
				}
			});
		}

	}

	//?????? ?????? ??????/?????? ??????
	function pf_option_action(divID) {
		if (modifybool) {
			//?????? ?????? ??????
			if ($("#option_data_" + divID).val() == '') {
				alert("??????????????? ???????????????.");
				$("#option_data_" + divID).focus();
				return false;
			}
			var HtmlContents = "";
			// ????????? ?????? ?????? ??????
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

	function pf_initColumn(BT_KEYNO) {
		$.ajax({
			type : "POST",
			url : "/txap/Board/type/updateView/listAjax.do",
			data : "BL_BT_KEYNO=" + BT_KEYNO,
			success : function(result) {
				for (var i = 0; i < result.length; i++) {
					pf_ajaxData(result[i])
				}
			},
			error : function() {
				cf_alert("??????????????? ????????? ??????????????????.");
				return false;
			}
		});
	}
	function pf_ajaxData(result) {
		var divID = "column-row" + addOptionCnt;
		var html = "";
		html += "<div id='"+divID+"' class='column-row'>";
		html += "<div class='row'>";
		html += "<input type='hidden' id='BL_KEYNO' name='BL_KEYNO' value='"+result.BL_KEYNO+"'>";
		html += "<input type='hidden' id='BL_OPTION_DATA"+divID+"' name='BL_OPTION_DATA' value='"+result.BL_OPTION_DATA+"'>";
		html += "<section class='col col-1'>";
		html += "<label class='input'> <i class='icon-prepend fa fa-edit'></i> ";
		html += "<input type='text' id='BL_COLUMN_LEVEL"
				+ divID
				+ "' name='BL_COLUMN_LEVEL' placeholder='????????????'  maxlength='50' value='"
				+ result.BL_COLUMN_LEVEL
				+ "' readonly='readonly' onkeydown='return cf_only_Num(event);'/>";
		html += "</label>";
		html += "</section>";
		html += "<section class='col col-3'>";
		html += "<label class='input'> <i class='icon-prepend fa fa-edit'></i>";
		html += "<input class='checkTrim' type='text' id='BL_COLUMN_NAME' name='BL_COLUMN_NAME' placeholder='?????????'  maxlength='50' value='"+result.BL_COLUMN_NAME+"'/>";
		html += "</label>";
		html += "</section>";
		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_TYPE' id='BL_TYPE" + divID
				+ "' onchange=pf_ColumnTypeChange('" + divID + "')>";
		if (result.BL_TYPE == BOARD_COLUMN_TYPE_TITLE) {
			html += "<option value='"+BOARD_COLUMN_TYPE_TITLE+"'>??????</option>";
		} else {
			<c:forEach items="${ColumnType}" var="model">
			<c:if test="${model.SC_KEYNO ne BOARD_COLUMN_TYPE_TITLE}">
			html += "<option value='${model.SC_KEYNO}'>${model.SC_CODENM}</option>";
			</c:if>
			</c:forEach>
		}
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_VALIDATE' id='BL_VALIDATE"+divID+"'>";
		if (result.BL_TYPE == BOARD_COLUMN_TYPE_TITLE) {
			html += "<option value='Y'>Y</option>";
		} else {
			html += "<option value=''>???????????? ??????</option>";
			html += "<option value='Y'>Y</option>";
			html += "<option value='N'>N</option>";
		}

		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-1'>";
		html += "<label class='select'>";
		html += "<select name='BL_LISTVIEW_YN' id='BL_LISTVIEW_YN" + divID
				+ "' onchange=pf_ColumnViewYN('" + divID + "')>";
		if (result.BL_TYPE == BOARD_COLUMN_TYPE_TITLE) {
			html += "<option value='Y'>Y</option>";
		} else {
			html += "<option value=''>????????? ????????????</option>";
			html += "<option value='Y'>Y</option>";
			html += "<option value='N'>N</option>";
		}
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		html += "<section class='col col-1 selectCodeWrap'>";
		html += "<label class='select'>";
		html += "<select name='BL_CODE' id='BL_CODE" + divID
				+ "' onchange=pf_SettingCode('" + divID + "',this)>";
		html += "<option value=''>????????????</option>";
		<c:forEach items="${MainCodeList}" var="model">
		html += "<option value='${model.MC_KEYNO}'>${model.MC_CODENM}</option>";
		</c:forEach>
		html += "</select>";
		html += "<i></i>";
		html += "</label>";
		html += "</section>";

		if (result.BL_TYPE != BOARD_COLUMN_TYPE_TITLE) {
			html += "<section class='col col-2' style='height: 32px; line-height: 32px; vertical-align: middle;'>";
			html += "<section class='col-12 text-center' style='height: 32px; line-height: 32px; vertical-align: middle;'>";
			html += "<a href='javascript:;' onclick=pf_columnDelete('" + divID
					+ "')>";
			html += "????????????";
			html += "</a>";
			html += "<span class='option_dp'>"
			html += "|  ";
			html += "<a href='javascript:;' onclick=pf_optiondialog_open('"
					+ divID + "')>";
			html += "????????????";
			html += "</a> ";
			html += "</span>"
			html += "</section>";
			html += "</section>";
		}
		html += "</div>";
		html += "</div>";
		$("#AddColumn").append(html);
		optionhtml(divID);

		cf_select_check("BL_TYPE" + divID, result.BL_TYPE);
		cf_select_check("BL_VALIDATE" + divID, result.BL_VALIDATE);
		cf_select_check("BL_LISTVIEW_YN" + divID, result.BL_LISTVIEW_YN);
		cf_select_check("BL_COLUMN_SIZE" + divID, result.BL_COLUMN_SIZE);
		var optiondata = $("#BL_OPTION_DATA" + divID).val();
		var optionVal = optiondata.split("|");

		var BL_TYPE = $("#BL_TYPE" + divID).val();

		if (BL_TYPE == BOARD_COLUMN_TYPE_CHECK
				|| BL_TYPE == BOARD_COLUMN_TYPE_RADIO
				|| BL_TYPE == BOARD_COLUMN_TYPE_SELECT) {
			if (optiondata != null && optiondata != "") {
				for (var c = 0; c < optionVal.length; c++) {
					var HtmlContents = "";
					//????????? ?????? ?????? ??????
					HtmlContents += "<span class=\"label bg-color-blue\" style=\"margin-right:10px;\">"
							+ "<a href=\"javascript:;\" class=\"label atext\" "
							+ "onclick=\"pf_modify_view(this,'"
							+ divID
							+ "')\" >"
							+ optionVal[c]
							+ "</a><a class=\"label\" href=\"javascript:;\">"
							+ "<i class=\"fa fa-trash-o\" onclick=pf_option_delete(this) ></i></a></span>";
					$("#Addoption_dialog_ContentsBox_" + divID).html(
							$("#Addoption_dialog_ContentsBox_" + divID).html()
									+ HtmlContents);

				}
			}
		} else if (BL_TYPE == BOARD_COLUMN_TYPE_CHECK_CODE
				|| BL_TYPE == BOARD_COLUMN_TYPE_RADIO_CODE
				|| BL_TYPE == BOARD_COLUMN_TYPE_SELECT_CODE) {
			cf_select_check("BL_CODE" + divID, result.BL_OPTION_DATA);

		}

		pf_ColumnViewYN(divID)
		pf_ColumnTypeChange(divID)

		addOptionCnt++;
	}
	
	//???????????? ??? ??????
	function pf_checkBox(){
		$('input[type=checkbox]').each(function(i){
			var checkVal = 'Y'
			var checkID = $(this).attr("id");
			if(!$(this).is(":checked")){
				if(checkID == 'NUMBERING_TYPE'){	//?????? ????????? ???
					checkVal = 'R';
				}else{
					checkVal = 'N'
				}
			}else{
				if(checkID == 'NUMBERING_TYPE'){	//?????? ????????? ???
					checkVal = 'V';
				}
			}
			$('#BT_'+checkID).val(checkVal);
			
			if(!$(this).is(":checked")){
				if(checkID == 'DEL_POLICY'){	//????????? ?????? ?????? ???
					checkVal = 'P';
				}
			}else{
				if(checkID == 'DEL_POLICY'){	//?????? ????????? ???
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
		<input type="hidden" name="BT_MODNM" value="${userInfo.UI_ID }" />
		<input type="hidden" name="BT_KEYNO" value="${BoardType.BT_KEYNO }" />
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
		<input type="hidden" id="BT_SHOW_MINE_YN" name="BT_SHOW_MINE_YN" value="${BoardType.BT_SHOW_MINE_YN }"/>
		<input type="hidden" id="BT_DEL_POLICY" name="BT_DEL_POLICY" value="${BoardType.BT_DEL_POLICY }"/>
		
		<div class="row">
			<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
				<h1 class="page-title txt-color-blueDark">
					<i class="fa fa-table fa-fw "></i> ??????????????? <span>> ????????? ?????? ?????? </span>
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
							<h2>????????? ?????? ??????</h2>
						</header>

						<div>
							<div class="widget-body-toolbar bg-color-white">
								<div class="alert alert-info no-margin fade in">
									<button type="button" class="close" data-dismiss="alert">??</button>
									????????? ????????? ?????? ????????? ???????????????.<br> <span style="color: red;">*???????????????
										?????? ?????? ???????????????.</span>
								</div>
							</div>

							<div class="widget-body no-padding smart-form">
								<fieldset>
									<div class="row">
										<section class="col col-12">
											<h6>????????? ?????? ??????</h6>
										</section>
									</div>

									<div class="row">
										<section class="col col-6">
											<span class="nessSpan">*</span> ????????? ????????? <label class="input">
												<i class="icon-prepend fa fa-edit"></i> <input
												class="checkTrim inputmargin" type="text" id="BT_TYPE_NAME"
												name="BT_TYPE_NAME" placeholder="????????? ?????????" maxlength="50"
												value="${BoardType.BT_TYPE_NAME }" />
											</label>
										</section>

										<section class="col col-6">
											<span class="nessSpan">*</span> ????????? ?????? <label class="select">
												<select name="BT_CODEKEY" id="BT_CODEKEY" class="inputmargin">
													<option value="">????????? ??????</option>
													<c:forEach items="${Code }" var="model">
														<option value="${model.SC_KEYNO }">${model.SC_CODENM }</option>
													</c:forEach>
											</select> <i></i>
											</label>
										</section>
									</div>
									<div class="row">
										<section class="col col-6">
											<label class="label input">??? ???????????? ???????????? ????????? ??? ??? <input
												type="number" id="BT_PAGEUNIT" name="BT_PAGEUNIT" class="inputmargin"
												value="${BoardType.BT_PAGEUNIT }"
												oninput="cf_maxLengthCheck(this)" max="99" maxlength="2" />
											</label>
										</section>
										<section class="col col-6">
											<label class="label input"> ????????? ???????????? ???????????? ????????? ?????? <input
												type="number" id="BT_PAGESIZE" name="BT_PAGESIZE" class="inputmargin"
												value="${BoardType.BT_PAGESIZE }"
												oninput="cf_maxLengthCheck(this)" max="99" maxlength="2" />
											</label>
										</section>
									</div>
									
									<div class="row checkboxWrap" style="margin-bottom: 15px;">		
										<section class="col col-6">
											<label class="col-md-4 control-label">??????HTML ????????????</label>
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
											<label class="col-md-4 control-label">XSS ?????? ????????????</label>
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
											<label class="col-md-4 control-label">Web ????????? ??????</label>
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
											<label class="col-md-4 control-label">?????? ????????? ??????</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch" style="width: 70px;">
																	<input type="checkbox" name="NUMBERING_TYPE" value="" 
																			class="onoffswitch-checkbox" id="NUMBERING_TYPE" >
																	<label class="onoffswitch-label" for="NUMBERING_TYPE"> 
																		<span class="onoffswitch-inner" data-swchon-text="????????????" data-swchoff-text="????????????"></span> 
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
											<label class="col-md-4 control-label">????????? ?????? ????????????</label>
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
											<label class="col-md-4 control-label">?????? ?????? ????????????</label>
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
											<label class="col-md-4 control-label">?????? ?????? ????????????</label>
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
											<label class="col-md-4 control-label">????????? ????????? ???????????? ???????????? ??????</label>
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
											<label class="col-md-4 control-label">????????? ?????? ???????????? ??????</label>
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
											<label class="col-md-4 control-label">????????? ????????? ????????? ??????</label>
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
											<label class="col-md-4 control-label">????????? ?????? ??????</label>
											<div class="inline-group">
												<div class="row">
													<div class="col-sm-1">
														<label> 
															<span class="input-group-addon">
																<span class="onoffswitch" style="width: 70px;">
																	<input type="checkbox" name="DEL_POLICY" value="" 
																			class="onoffswitch-checkbox" id="DEL_POLICY" >
																	<label class="onoffswitch-label" for="DEL_POLICY"> 
																		<span class="onoffswitch-inner" data-swchon-text="????????????" data-swchoff-text="????????????"></span> 
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
											<label class="col-md-4 control-label">????????? ????????????</label>
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
											<label class="label input">????????? ???????????? weight ???(?????? px) <input
												type="number" id="BT_THUMBNAIL_WIDTH" class="inputmargin"
												name="BT_THUMBNAIL_WIDTH"
												value="${BoardType.BT_THUMBNAIL_WIDTH }"
												oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4" />
											</label>
										</section>
										<section class="col col-3 thumnailResize">
											<label class="label input">????????? ???????????? height ???(?????? px) <input
												type="number" id="BT_THUMBNAIL_HEIGHT" class="inputmargin"
												name="BT_THUMBNAIL_HEIGHT"
												value="${BoardType.BT_THUMBNAIL_HEIGHT }"
												oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4" />
											</label>
										</section>
										</div>
										
										<div class="row">
										<section class="col col-6">
											<label class="col-md-4 control-label">??? ????????? ????????? ????????????</label>
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
											????????? ?????? <label class="input inputmargin"> <i
												class="icon-prepend fa fa-edit"></i> <input type="text"
												id="BT_EMAIL_ADDRESS" name="BT_EMAIL_ADDRESS"
												placeholder="E-mail" maxlength="50"
												value="${BoardType.BT_EMAIL_ADDRESS }" />
											</label>
										</section>
										</div>
										
										
										<div class="row">
											<section class="col col-4">
												<label class="col-md-6 control-label">????????? ?????? ????????????</label>
												<div class="inline-group">
													<div class="row">
														<div class="col-sm-1" style="margin-left: 5px;">
															<label> 
																<span class="input-group-addon">
																	<span class="onoffswitch">
																		<input type="checkbox" name="UPLOAD_YN" value="" 
																				class="onoffswitch-checkbox" id="UPLOAD_YN" 
																				${empty resultData || fn:contains(resultData.TC_SHOW_COLUMN,'TC_CONTACT') ? 'checked="checked"':'' }>
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
													<label class="label input">????????? ?????? ??? ?????? <input
														class="form-control inputmargin" id="BT_FILE_CNT_LIMIT"
														name="BT_FILE_CNT_LIMIT" value="${BoardType.BT_FILE_CNT_LIMIT }" type="number"
														oninput="cf_maxLengthCheck(this)" max="999" maxlength="3">
													</label>
												</div>
											</div>
											<div class="col col-2 uploadRow">
												<div class="form-group">
													<label class="label input">????????? ???????????? ??????(MB) <input
														class="form-control inputmargin" id="BT_FILE_SIZE_LIMIT"
														name="BT_FILE_SIZE_LIMIT" value="${BoardType.BT_FILE_SIZE_LIMIT }" type="number"
														oninput="cf_maxLengthCheck(this)" max="999" maxlength="3">
													</label>
												</div>
											</div>
										   <div class="col col-2 uploadRow">
												<div class="form-group">
													<label class="label input">????????? ????????? Weight???(?????? px) <input
														class="form-control inputmargin" id="BT_FILE_IMAGE_WIDTH"
														name="BT_FILE_IMAGE_WIDTH" value="${BoardType.BT_FILE_IMAGE_WIDTH }" type="number"
														oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4">
													</label>
												</div>
											</div>
											<div class="col col-2 uploadRow">
												<div class="form-group">
													<label class="label input">????????? ????????? height???(?????? px) <input
														class="form-control inputmargin" id="BT_FILE_IMAGE_HEIGHT"
														name="BT_FILE_IMAGE_HEIGHT" value="${BoardType.BT_FILE_IMAGE_HEIGHT }" type="number"
														oninput="cf_maxLengthCheck(this)" max="9999" maxlength="4">
													</label>
												</div>
											</div>
										</div>
										<div class="row uploadRow">
											<div class="col col-6">
												<label class="col-md-4 control-label">????????? ?????????</label>
												<div class="inline-group">
													<div class="row">
														<label class="radio"> <input type="radio"
															name="FILE_EXT" value="bmp,jpg,png,gif,jpeg,hwp,pdf,zip,xls,xlsx,doc,docx,ppt,pptx" onclick="pf_fileExt('N');" checked> <i></i>????????????
														</label> 
														<label class="radio"> <input type="radio"
															name="FILE_EXT" value="hwp,txt,pdf,xls,xlsx,doc,docx,ppt,pptx" onclick="pf_fileExt('N');"> <i></i>?????? ?????????
														</label> 
														<label class="radio"> <input type="radio"
															name="FILE_EXT" value="bmp,jpg,png,gif,jpeg" onclick="pf_fileExt('N');"> <i></i>????????? ?????????
														</label> 
														<label class="radio"> <input type="radio"
															name="FILE_EXT" value="blank" onclick="pf_fileExt('Y');"> <i></i>????????????
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
												<h6>?????? ??????</h6>
											</section>
											<section class="col col-3">
												<button class="btn btn-sm btn-primary" id="Board_Edit"
													type="button" onclick="pf_AddColumn()">
													<i class="fa fa-floppy-o"></i> ????????????(???????????? ?????????)
												</button>
											</section>
										</div>
										<div class="row columnTitle">
											<section class="col col-1">??????</section>
											<section class="col col-3">??????</section>
											<section class="col col-1">????????????</section>
											<section class="col col-1">???????????? ??????</section>
											<section class="col col-1">????????? ????????????</section>
											<section class="col col-3">????????????</section>
										</div>

										<fieldset id="AddColumn"></fieldset>
									</div>
								</fieldset>
								<fieldset class="padding-10 text-right">
									<button class="btn btn-sm btn-primary" id="Board_Edit"
										type="button" onclick="pf_boardTypeUpdate()">
										<i class="fa fa-floppy-o"></i> ??????
									</button>
									<button class="btn btn-sm btn-danger" id="Board_Edit"
										type="button" onclick="pf_boardTypeDelete()">
										<i class="fa fa-floppy-o"></i> ??????
									</button>
									<button class="btn btn-sm btn-default" id="Board_Delete"
										type="button" onclick="pf_back()">
										<i class="fa fa-times"></i> ??????
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