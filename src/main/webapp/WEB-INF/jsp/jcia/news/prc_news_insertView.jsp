<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<link type="text/css" rel="stylesheet" href="/resources/jcia/css/board.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<style>
.tbl_board_Write tbody tr th{vertical-align: middle;}
.tbl_board_Write .newsDiv{position: relative; display: block; font-weight: 400;}
.tbl_board_Write .newsSpan{color:#ffffff; position: absolute; top: 4px; right: 4px; float: none; height: 22px;  padding: 0 14px; font-size: 13px; line-height: 22px;    background-color: #3276B1; opacity: .8;  width: 100px; text-align: center;}
.tbl_board_Write .newsInput1{position: absolute; top: 0; right: 0; cursor: pointer; opacity: 0; width: 100%; height: 100%;}
.tbl_board_Write .newsInput2{width: 100%; height: 32px; line-height: 32px; padding: 5px 10px; font: 13px/16px 'Open Sans',Helvetica,Arial,sans-serif;}
</style>
<script>
	if (!window.jQuery.ui) {
		document.write('<script src="/resources/smartadmin/js/libs/jquery-ui-1.10.3.min.js"><\/script>');
	}
</script>
<script type="text/javascript">
//전역변수선언
var editor_object = [];
var action = '${action}';
var isAdmin = '${userInfo.isAdmin}'; 
var plus = '<c:out value = "${BoardType.BT_HTMLMAKER_PLUS_YN}"/>';


$(function(){
	 var webEditUseYn = true; 
		if(plus == 'N'){
			webEditUseYn = false;
		}     
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "NM_CONTENT",
        sSkinURI: "/resources/smarteditor2/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : webEditUseYn,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : webEditUseYn,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : webEditUseYn
        },
        menuName : '${currentMenu.MN_NAME}' //본문에 이미지 저장시 사용되는 캡션
    });
	
  /*   if(action == 'update'){
    	pf_initColumnData("${BoardNotice.BN_KEYNO }")
    	cf_radio_checked("BN_SECRET_YN", "${BoardNotice.BN_SECRET_YN }");
    	if(isAdmin == 'Y'){
    		cf_radio_checked("BN_IMPORTANT", "${BoardNotice.BN_IMPORTANT }");
    	}
    }
    $("iframe").attr("title","네이버 에디터"); */
});


function pf_boardDataInsert(type){
	//웹에디터 내용 textarea로 복사
	editor_object.getById["NM_CONTENT"].exec("UPDATE_CONTENTS_FIELD", []);
// 	if(!pf_formCheck()){
// 		return false; 
// 	}
	if(!$("#NM_YEAR").val()){
		alert("년도를 입력해주세요.");
		$("#NM_YEAR").focus();
		return false;
	}
	if(!$("#NM_MONTH").val()){
		alert("월을 입력해주세요.");
		$("#NM_MONTH").focus();
		return false;
	}
	if(!$("#NM_FS_KEYNO").val()){
		if(!$("#thumbnail").val()){
			alert("리스트에 보여질 이미지를 선택하세요.");
			return false;
		}
	}
	$("#type").val(type);
	var msg = null;
	if(type == 'N'){
		msg = '등록'; 
	}else if(type == 'U'){
		msg = '수정'; 		
	}
	
	if(confirm("뉴스레터를 "+msg+"하시겠습니까?")){
		$("#Form").attr("action", "/jcia/information/newsletter/Insert.do?${_csrf.parameterName}=${_csrf.token}");
		$("#Form").submit();	 
	}else{
		exit();
	}	
}

function exit(){
	alert("취소되었습니다.");
	return false;
}

function pf_back(){
	location.href="${mirrorPage }";
}


</script>
<article id="container" class="container_sub clearfix">
	<div class="inner">
		<div class="conSub01_bottomBox">
			<div class="innerContainer clearfix">
				<form:form id="Form" name="Form" method="post" enctype="multipart/form-data">
				<input type="hidden" name="type" id="type" value=""/>
					<c:if test="${action eq 'insert' }">
						<input type="hidden" name="NM_REGNM" id="NM_REGNM" value="${userInfo.UI_KEYNO }"/>
						<input type="hidden" id="NM_NUMBERING" name="NM_NUMBERING" value="${Numbering + 1 }"/>
					</c:if>
					<c:if test="${action eq 'update' }">
						<fmt:parseNumber value="${fn:substring(resultData.NM_KEYNO,4,20) }" var="key"/>
						<input type="hidden" id="NM_KEYNO" name="NM_KEYNO" value="${key}"/>
						<input type="hidden" id="NM_FS_KEYNO" name="NM_FS_KEYNO" value="${resultData.NM_FS_KEYNO}"/>
					</c:if>
					<!-- 본문 시작 -->
					<div class="subContentInner">
					    <div class="boardWriteBox"> <!-- 글 작성 시작 -->
								<table class="tbl_board_Write">
					                 <caption>${currentMenu.MN_NAME }</caption>
					                 	<colgroup>
					                 	<col width="15%">
					                 	<col width="35%">
					                 	<col width="15%">
					                 	<col width="35%">
					                 </colgroup>
					                 <tbody>
						                 	<!--  && empty userInfo -->
						                 	<tr>
						                     	<th rowspan="2"><label for="NM_TITLE"><span><i class="fal fa-check"></i></span> 제목</label></th>
						                         <td colspan="3">
						                         	<input type="text" id="NM_TITLE" name="NM_TITLE" value="${empty resultData.NM_TITLE ? '전남정보문화산업진흥원' : resultData.NM_TITLE }" class="txtDefault txtWUploadL" maxlength="50"/>
						                         </td>
						                         
						                    </tr>
						                    <tr>
						                    	<td colspan="3">
						                         	<input type="text" id="NM_YEAR" name="NM_YEAR" maxlength="4" class="txtDefault " value="<c:out value='${resultData.NM_YEAR }'/>"/>년
						                         	&nbsp;
						                         	<input type="text" id="NM_MONTH" name="NM_MONTH" maxlength="2" class="txtDefault " value="<c:out value='${resultData.NM_MONTH }'/>"/>월
													, 
													&nbsp;
													<c:if test="${action eq 'insert' }">
														<c:out value="${Numbering + 1 }"/>호
													</c:if>
													<c:if test="${action eq 'update' }">
														<c:out value="${resultData.NM_NUMBERING}"/>호
													</c:if>
						                         </td>
						                    </tr>
						                 	<tr>
						                     	<th><label for="BN_PWD"><span><i class="fal fa-check"></i></span> 리스트 이미지</label></th>
						                         <td colspan="3">
						                         	<img style="width:100px;height:100px;margin:5px 0;" onerror="this.style.display='none';this" src="/resources/img/upload/${resultData.IMG_PATH }" id="thumbnail_img" alt="썸네일"/>
						                         	<div class="input input-file newsDiv">
							                         	<span class="button newsSpan">
															<input id="thumbnail" class="newsInput1" type="file" name="listfile" onchange="cf_imgCheckAndPreview('thumbnail')">파일선택
														</span>
														<input type="text" class="newsInput2" name="thumbnail_text" id="thumbnail_text" placeholder="이미지를 선택하여주세요." readonly="readonly" value="<c:out value='${resultData.IMG_ORINM }'/>">
						                         	</div>
						                         	<p class="passParaph">사이즈 :: 200 X 200 사이즈가 다를시 자동 리사이즈 됩니다.</p>
						                         </td>
						                     </tr>
										<tr>
					                     	<th style="vertical-align:top;"><label for="txtUpName"><span><i class="fal fa-check"></i></span> 내용</label></th>
					                         <td colspan="3" class="contentBox">
					                         	<c:if test="${action eq 'insert' }">
													<textarea name="NM_CONTENT" id="NM_CONTENT" rows="5" style="width:100%;height:400px;min-width:260px;" title="내용을 입력해주세요"></textarea>
												</c:if>
												<c:if test="${action eq 'update' }">
													<textarea name="NM_CONTENT" id="NM_CONTENT" rows="5" style="width:100%;height:400px;min-width:260px;" title="내용을 입력해주세요">${resultData.NM_CONTENT }</textarea>
												</c:if>
					                         </td>
					                    </tr>
					                 </tbody>
					             </table>
									
								<div class="btnUploadBox">
									<c:if test="${action eq 'insert' }">
									<button type="button" class="btnDefault btnBgBlue btnSizeM_2" onclick="pf_boardDataInsert('N')">글쓰기</button>
									</c:if>
									<c:if test="${action eq 'update' }">
									<button type="button" class="btnDefault btnBgBlue btnSizeM_2" onclick="pf_boardDataInsert('U')">수정</button>
									</c:if>
									<button type="button" class="btnDefault btnWhiteLine btnSizeM_2" onclick="pf_back()">취소</button>
								</div>
					    </div> <!-- 글 작성 끝 -->
					</div>
					<!-- 본문 끝 -->
				</form:form>	
			</div>
		</div>
	</div>
</article>

