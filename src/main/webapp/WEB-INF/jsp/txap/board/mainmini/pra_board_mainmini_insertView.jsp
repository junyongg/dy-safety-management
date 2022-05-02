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

.column_ul .column_li div{
	margin-left: 20px;
}

</style>

<script type="text/javascript">

var editor = null;

$(function() {
	
	editor = codeMirror("htmlmixed", "BMM_FORM");
	
	if("${BMM_DATA}"){
		menuasync();
	}else {
		pf_form_change(0);
	}
	
});

function menuasync(){
	
	$.ajax({
	    type   : "post",
	    url    : "/txap/Board/data/main/menu/selectAjax.do",
	    data   : {"MN_KEYNO" : $("#BMM_MN_HOMEDIV_C").val()},
	    async  : false ,
	    success:function(data){
	    	var html = "<option value=''>메뉴선택</option>";
	    	for(var i = 0; i < data.length; i++){
	    		html += "<option ";
	    		if("${BMM_DATA.BMM_MN_KEYNO}" == data[i].MN_KEYNO){
	    			html += "selected "
	    		}
	    		html += "value='"+data[i].MN_KEYNO +"'>"+data[i].MN_NAME+"</option>";
				
	    	}
        	$("#BMM_MN_KEYNO").html(html);
        	$("#BMM_MN_KEYNO").show();
	    	
	    },
	    error: function(jqXHR, textStatus, exception) {
	    	alert('error: '+textStatus+": "+exception);
	    }
	  });
	
	if("${BMM_DATA}"){
		pf_boardSelect();
	}
}

function pf_form_change(value){
    var temp = $("#form_data ul").children("li");
    var form_data = $(temp[value]).text();
	
	editor.setValue(form_data);
}

function pf_boardSelect(){
	
	$("#BT_COLUME").empty();
	
	$.ajax({
	    type   : "post",
	    url    : "/txap/Board/MainMiniBoard/board/selectAjax.do",
	    data   : {"MN_KEYNO" : $("#BMM_MN_KEYNO").val()},
	    async  : false ,
	    success:function(data){
	    	var html = "<ul class='column_ul'>";
	    	
	    	var defalut_option = [];
	    	defalut_option.push({comment : "기본키", dataset : "BN_KEYNO"});
	    	defalut_option.push({comment : "작성자", dataset : "BN_REGNM"});
	    	defalut_option.push({comment : "작성일", dataset : "BN_REGDT"});
	    	defalut_option.push({comment : "썸네일src", dataset : "BN_THUMBNAIL_SRC"});

	    	for(var i in defalut_option){
	    		html += "<li class='column_li'><label>"+defalut_option[i].comment+"</label><input type='text' value='" + defalut_option[i].dataset + "' readonly>";
				html += "<div class='btn btn-default btn-xs' onclick='pf_Copy(\"" + defalut_option[i].dataset  + "\")'><i class='fa fa-copy'></i></div></li>";
			}
	    	
	    	for(var i = 0; i < data.length; i++){
				html += "<li class='column_li'><label>"+data[i].COMMENT_NAME+"</label><input type='text' value='" + data[i].DATASET + "' readonly>";
				html += "<div class='btn btn-default btn-xs' onclick='pf_Copy(\"" + data[i].DATASET  + "\")'><i class='fa fa-copy'></i></div></li>";
	    	}
	    	html += "</ul>";
	    	
        	$("#BT_COLUME").html(html);
	    	
	    },
	    error: function(jqXHR, textStatus, exception) {
	    	alert('error: '+textStatus+": "+exception);
	    }
	  });
}

function pf_mainMiniInsert(){
	
	if(!pf_checkForm()){
		return false;
	}

	if(confirm("미니게시판을 생성하시겠습니까?")){
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/Board/MainMiniBoard/insert.do");
		$("#Form").submit();
	}
	
}

function pf_checkForm(){
	if(!$("#BMM_MN_HOMEDIV_C").val()){
		alert("홈페이지를 선택하세요.");
		$("#BMM_MN_HOMEDIV_C").focus();
		return false;
	}
	
	if(!$("#BMM_MN_KEYNO").val()){
		alert("게시판을 선택하세요.");
		$("#BMM_MN_KEYNO").focus();
		return false;
	}
	
	if(!$("#BMM_SIZE").val()){
		alert("페이지 목록 갯수를 입력하세요.");
		$("#BMM_SIZE").focus();
		return false;
	}
	
	return true;
}

function pf_mainMiniUpdate(){
	
	if(!pf_checkForm()){
		return false;
	}

	if(confirm("미니게시판을  수정하시겠습니까?")){
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/Board/MainMiniBoard/update.do");
		$("#Form").submit();
	}
	
}

function pf_mainMiniDelete(){
	if(confirm("미니게시판을  삭제하시겠습니까?")){
		cf_replaceTrim($("#Form"));
		$("#Form").attr("action", "/txap/Board/MainMiniBoard/delete.do");
		$("#Form").submit();
	}
}


function pf_back(){
	history.go(-1);
}

function pf_Copy(content){
	if(cf_copyToClipboard(content)){
		cf_smallBox('success', "값이 복사되었습니다.", 2000);
	}else{
		cf_smallBox('error', "복사하기 기능을 지원하지 않는 브라우저 입니다.", 3000,'#d24158');
	}
}
	
</script>

<div id="form_data" style="display: none;">
	<ul>
<li id="form_li_data">&lt;div&gt;
	&lt;ul&gt;
  	&lt;c:forEach items="&#36;&#123;resultList &#125;" var="model"&gt;
		&lt;li&gt;
			&lt;a href="&#36;&#123;tilesUrl&#125;/Board/&#36;&#123;model.BN_KEYNO&#125;/detailView.do"  title="&#36;&#123;model.title&#125;"&gt;
              &#36;&#123;model.title&#125;
			&lt;/a&gt;
		&lt;/li&gt;
    &lt;/c:forEach&gt;
	&lt;/ul&gt;
&lt;/div&gt;</li>
	<c:forEach items="${formDataList }" var="model3" varStatus="status">
	<li><c:out value="${model3.BMM_FORM }" escapeXml="true"></c:out></li>    
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
						<h2>메인 미니게시판 등록</h2>
						</c:if>
						<c:if test="${type eq 'update' }">
						<h2>메인 미니게시판 수정</h2>
						</c:if>
					</header>

					<div class="widget-body">

						<form:form id="Form" class="form-horizontal" name="Form" method="post">
							<input type="hidden" name="BMM_REGNM" value="${userInfo.UI_ID }" />
							<c:if test="${type eq 'update' }">
							<input type="hidden" name="BMM_KEYNO" value="${BMM_DATA.BMM_KEYNO }" />
							</c:if>
							<legend>
								<c:if test="${type eq 'insert' }">
								<h2>미니게시판 등록하기 </h2>
								</c:if>
								<c:if test="${type eq 'update' }">
								<h2>미니게시판 수정하기 </h2>
								</c:if>
							</legend>
							
							<fieldset>
								<div class="bs-example necessT">
									<span class="colorR fs12">*표시는 필수 입력 항목입니다.</span>
								</div>
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> 홈페이지</label>
									<div class="col-md-3">
										<select class="form-control input-sm" id="BMM_MN_HOMEDIV_C" name="BMM_MN_HOMEDIV_C" onchange="menuasync();" ${type eq 'update' ? 'disabled' : '' }>
							              <option value="">적용 홈페이지 선택</option>
							              <c:forEach items="${homeDivList }" var="model">
							                <option value="${model.MN_KEYNO }" ${BMM_DATA.BMM_MN_HOMEDIV_C eq model.MN_KEYNO ? 'selected' : '' } >${model.MN_NAME }</option>
							              </c:forEach>	
							            </select>
									</div>
								</div>
								
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> 게시판</label>
									<div class="col-md-3">
										<select class="form-control input-sm" id="BMM_MN_KEYNO" name="BMM_MN_KEYNO" onchange="pf_boardSelect();" ${type eq 'update' ? 'disabled' : '' }>
							              <option value="">게시판 선택</option>
							            </select>
									</div>
								</div>
								
								
								<div class="form-group has-feedback">
									<label class="col-md-1 control-label"><span class="nessSpan">*</span> 페이지 목록 갯수</label>
									<div class="col-md-3">
										<label class="input-group"> 
											<input type="number" class="form-control" id="BMM_SIZE" name="BMM_SIZE" value="${BMM_DATA.BMM_SIZE }" oninput="cf_maxLengthCheck(this)" max="99" maxlength="2">
											<span class="input-group-addon"><i class="fa fa-cube"></i></span>
										</label>
									</div>
								</div> 
								
								<div class="row">
									<div class="form-group has-feedback">
										<label class="col-md-9 control-label"></label>
										<div class="col-md-2">
											<select class="form-control input-sm" id="BMM_FORM_SELECT" onchange="pf_form_change(this.value);">
								              <option value="0">기본폼</option>
								              <c:forEach items="${formDataList }" var="model3" varStatus="status">
								              <option value="${status.count }" ${BMM_DATA.BMM_KEYNO eq model3.BMM_KEYNO ? 'selected' : '' }>${model3.FORM_NAME }</option>
								              </c:forEach>
								            </select>
										</div>
										
									</div>
								</div>
								
								<div class="row">
									<div class="form-group has-feedback">
										<label class="col-md-1 control-label">컬럼 목록</label>
										<div class="col-md-3" id="BT_COLUME" style="height: 400px;border: solid 1px gray;overflow-y: scroll; padding: 10px;">
										
										</div>
												
										<label class="col-md-1 control-label">HTML 소스</label>
										<div class="col-md-6">
											<textarea name="BMM_FORM" id="BMM_FORM" rows="5" style="width:100%;height:400px;min-width:260px;">${BMM_DATA.BMM_FORM}</textarea>
											
										</div>
									</div>
								</div>
								
								<div class="form-actions">
									<div class="row">
										<div class="col-md-12">
											<c:if test="${type eq 'insert' }">
												<button class="btn btn-sm btn-primary" type="button" onclick="pf_mainMiniInsert()">저장</button>
											</c:if>
											<c:if test="${type eq 'update' }">
												<button class="btn btn-sm btn-primary" type="button" onclick="pf_mainMiniUpdate()">수정</button>
												<button class="btn btn-sm btn-danger" type="button" onclick="pf_mainMiniDelete()">삭제</button>
											</c:if>
											<button class="btn btn-sm btn-default" id="Board_Delete" type="button" onclick="pf_back();">취소</button> 
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

