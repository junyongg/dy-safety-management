<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/common/CodeMirror_Include.jsp"%>
<script type="text/javascript" src="/resources/js/common/diff_match_patch.js"></script>
<style>
.customTitle{
	width: 90px;
    height: 20px;
}
</style>

<section id="widget-grid" class="">

	<div class="row">

		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0"
				data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>레이아웃 설정</h2>
				</header>
				<div>
					<div class="jarviswidget-editbox"></div>
					<div class="widget-body">
						<div class="widget-body-toolbar bg-color-white">
							<div class="alert alert-info no-margin fade in">
								<button type="button" class="close" data-dismiss="alert">×</button>
								홈페이지를 선택하면 해당하는 홈페이지의 레이아웃 설정이 출력 됩니다.
							</div>
						</div> 
						<div class="widget-body-toolbar bg-color-white">
							<div class="row">
								<div class="col-sm-2 text-align-left">
									<div>
										<label class="sr-only">홈페이지 선택</label>
										<select class="form-control input-sm" id="HOMEDIV_C" name="HOMEDIV_C" onchange="pf_HomeDivChange(this.value);">
											<option value="">홈페이지 선택</option>
											<c:forEach items="${homeDivList }" var="model"> 
 								                <option value="${model.MN_KEYNO }" ${model.MN_KEYNO eq menu.MN_HOMEDIV_C ? 'selected':'' }>${model.MN_NAME }</option> 
 								              </c:forEach>
										</select> 
									</div>
								</div>									
								<div class="col-sm-10 text-align-right">
									<button class="btn btn-sm btn-success" type="button" onclick="pf_Distribute('true')" style="margin-right:10px;">
										<i class="fa fa-plus"></i> 전체배포
									</button>
								</div>																
							</div>
						</div> 
						
						<ul id="LayoutTab" class="nav nav-tabs bordered">
							<li class="active" data-scope="prc_main">
								<a href="#" data-toggle="tab" aria-expanded="true">main</a>
							</li>
							<li data-scope="header">
								<a href="#" data-toggle="tab" aria-expanded="true">header</a>
							</li>
							<li data-scope="footer">
								<a href="#" data-toggle="tab" aria-expanded="true">footer</a>
							</li>
							<li data-scope="css">
								<a href="#" data-toggle="tab" aria-expanded="true">css</a>
							</li>
							<li data-scope="script">
								<a href="#" data-toggle="tab" aria-expanded="true">script</a>
							</li>
							<li data-scope="leftmenu">
								<a href="#" data-toggle="tab" aria-expanded="true">leftmenu</a>
							</li>
							<li data-scope="rightTop">
								<a href="#" data-toggle="tab" aria-expanded="true">rightTop</a>
							</li>
							<li data-scope="subTop">
								<a href="#" data-toggle="tab" aria-expanded="true">subTop</a>
							</li>
							
							<%-- <c:set var="layout_option" value="${fn:split(homeData.HM_LAYOUT_OPTION, '|') }"/>
							<c:forEach items="${layout_option }" var="option" varStatus="status">
								<li data-scope="${option }">
									<a href="#" data-toggle="tab" aria-expanded="true">${option }</a>
								</li>
							</c:forEach> --%>
						</ul>
						
						<form:form id="Form" method="post">
							<input type="hidden" id="MN_HOMEDIV_C" name="MN_HOMEDIV_C" value="${menu.MN_HOMEDIV_C }" />
							<input type="hidden" id="RM_MN_HOMEDIV_C" name="RM_MN_HOMEDIV_C" value="${menu.MN_HOMEDIV_C }" />
							<input type="hidden" name="RM_KEYNO" id="RM_KEYNO" value="">
							<input type="hidden" name="RM_SCOPE" id="RM_SCOPE" value="">
							<input type="hidden" name="RM_FILE_NAME" id="RM_FILE_NAME" value="">
							<input type="hidden" name="actionType" id="actionType" value="">
							<input type="hidden" name="RM_DATA" id="RM_DATA_TEMP" value="">
							<input type="hidden" name="RM_TYPE" id="RM_TYPE" value="${type }">
							<input type="hidden" name="allck" id="allck" value="">
							
							<div id="myTabContent1" class="tab-content padding-10 form-horizontal bv-form">
								<div>
									<table id="" class="table table-bordered table-striped">
										<colgroup>
											<col style="width: 20%;">
											<col style="width: 30%;">
											<col style="width: 20%;">
											<col style="width: 30%;">
										</colgroup>
										<tbody>
											<tr>
												<td>작성자</td>
												<td id="REGNM">
												</td>
												<td>작성일</td>
												<td id="REGDT">
												</td>
											</tr>
											<tr>
												<td>최근 게시물 수정자</td>
												<td id="MODNM">
												</td>
												<td>최근 게시물 수정일자</td>
												<td id="MODDT">
												</td>
											</tr>
											<tr>
												<td>코멘트</td>
												<td colspan="3">
												<input type="text" class="form-control" name="RMH_COMMENT" id="RMH_COMMENT" data-bv-field="fullName" maxlength="500" placeholder="no message">
												</td>
											</tr>
											<tr>
												<td colspan="4">내용</td>
											</tr>
											<tr>
												<td colspan="4">
													<textarea class="form-control ckWebEditor" id="RM_DATA" style="width:100%;height:500px;min-width:260px;" data-bv-field="content"></textarea>
												</td>
											</tr>
											
											<tr>
												<td colspan="4">
													<fieldset class="padding-10 text-right"> 
														<button type="button" onclick="pf_LayoutInsert();" class="btn btn-sm btn-primary">	
															<i class="fa fa-floppy-o"></i> 저장
														</button>
														<button class="btn btn-sm btn-success" type="button" onclick="pf_Distribute('false')" style="margin-right:10px;">
															<i class="fa fa-plus"></i> 배포
														</button>
													</fieldset>
												</td>
											</tr>
										</tbody>
									</table>
								</div>	
							</div>
						</div>
						</form:form>
						
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
														<col width="20%">
														<col width="25%">
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
					</div>
				</div>
			</div>
		</article>
	</div>
</section>
<script type="text/javascript">
var editor = null;

$(function(){
	editor = codeMirror('htmlmixed','RM_DATA')
	
	pf_clickLi();
	
	var scope = '${SCOPE}'
	
	if(scope != null && scope != ''){
		$("#LayoutTab li").each(function(i){
			if($(this).data('scope') == scope){
				$("#LayoutTab li").removeClass('active');
				$(this).addClass('active');
				$(this).trigger("click");
			}
		})
	}else{
		$("#LayoutTab li").first().trigger("click");
	}
});

function pf_clickLi(){
	$("#LayoutTab li").each(function(i){
		$(this).on('click', function(){
			var scopeType = $(this).data('scope');
			pf_data(scopeType);
			
		})
	})
}

function pf_data(scopeType){
	var homediv_c = $("#MN_HOMEDIV_C").val();
	var type = $("#RM_TYPE").val();
	
	$.ajax({
		type: "POST",
		url: "/txap/homepage/layout/dataAjax.do",
		data : {"RM_MN_HOMEDIV_C" : homediv_c,
				"RM_SCOPE" : scopeType,
				"RM_TYPE" : type},
		success : function(result){
			var data = result.LayoutData;
			var historyList = result.LayoutDataHistory;
			$("#RM_SCOPE").val(scopeType)
			
			//초기화
			$("#intro-history").empty();
			$("#compareData").empty();
			
			var keyno = '';
			var actiontype = 'insert';
			var REGNM = '작성자 없음';
			var REGDT = '작성일 없음';
			var MODNM = '최근 게시물 수정자 없음';
			var MODDT = '게시물 수정이력 없음';
			var RM_DATA = '';
			var filename = scopeType;
			
			if(data){
				keyno	 		= data.RM_KEYNO;   
				actiontype	 	= 'update';   
				REGNM 			= data.RM_REGNM;   
				REGDT 			= data.RM_REGDT;
				if(typeof data.RM_MODNM != 'undefined'){
					MODNM 			= data.RM_MODNM;
				}
				if(typeof data.RM_MODDT != 'undefined'){
					MODDT 			= data.RM_MODDT;
				}
				RM_DATA 		= data.RM_DATA;
			}
			
			$("#actionType").val(actiontype)
			$("#RM_KEYNO").val(keyno)
			$("#RM_FILE_NAME").val(filename)
			$("#REGNM").text(REGNM)
			$("#REGDT").text(REGDT)
			$("#MODNM").text(MODNM)
			$("#MODDT").text(MODDT)
			editor.setValue(RM_DATA);
			
			var temp = '';
			if(historyList.length > 0){
				$.each(historyList, function(i){
					var history = historyList[i]
					temp += '<tr>';
			    	temp += '	<td class="text-align-center">'+history.RMH_VERSION+'</td>';
			    	temp += '	<td class="text-align-center">'+history.RMH_MODNM+'</td>';
			    	temp += '	<td class="text-align-center">'+history.RMH_COMMENT+'</td>';
			    	temp += '	<td class="text-align-center">'+history.RMH_STDT+' ~ '+history.RMH_ENDT+'</td>';
			    	temp += '	<td class="text-align-center">';
			    	temp += '	<a class="btn btn-default btn-xs" href="#" onclick="pf_introUse(\''+history.RMH_KEYNO+'\');"><i class="fa fa-repeat"></i> 복원</a>';
			    	if(i != 0){
			    		temp += '	<a class="btn btn-default btn-xs" href="javascript:;" onclick="pf_compareData(\''+history.RMH_KEYNO+'\',\''+history.RMH_RM_KEYNO+'\');"><i class="fa fa-repeat"></i> 최신 데이터와 비교</a>';
			    	}
		    		temp += '	<a class="btn btn-default btn-xs" href="javascript:;" onclick="pf_compareData(\''+history.RMH_KEYNO+'\');"><i class="fa fa-repeat"></i> 변경사항</a>';
			    	temp += '	</td>';
		    		temp += '</tr>';
				})
			$("#intro-history").html(temp)
			}
		},
		error : function(){	
			cf_smallBox('error', '에러발생', 3000,'#d24158');
		}
	});
}

function pf_HomeDivChange(value){
	$("#MN_HOMEDIV_C").val(value);
	$("#RM_MN_HOMEDIV_C").val(value);
    $("#RM_DATA_TEMP").val("");
    $("#Form").attr("action","/txap/homepage/layout.do");
    cf_loading();
    $("#Form").submit();
}

function pf_LayoutInsert(){
  	
    $("#RM_DATA_TEMP").val(editor.getValue())

	if(!$("#RM_DATA_TEMP").val()){
      cf_smallBox('error', '내용을 입력해주세요.', 3000,'#d24158');
      return false;
    }
	
	if(confirm("저장하시겠습니까?")){
        cf_loading();
        
        
        setTimeout(function(){
            $.ajax({
            type: "POST",
            url: "/txap/homepage/layout/insert.do",
            data : $("#Form").serialize(),
            success : function(scope){
                cf_smallBox('ajax', '저장되었습니다.', 3000);
                pf_data(scope);
            },
            error : function(){    
            }
            }).done(function(){
                cf_loading_out();
            });
        },100)

	}
} 

// layout 배포
function pf_Distribute(allck) {
	
	$('#allck').val(allck);
	
	var msg = "";
	
	if(allck == 'false'){
		if($("#RM_KEYNO").val() == null || $("#RM_KEYNO").val() == ''){
			cf_smallBox('error', 'layout을 저장한 후 배포가능합니다.', 3000,'#d24158');
			return false;
		}
		
		msg = "정말 배포를 하시겠습니까?" ;
		
	}else {
		msg = "전체 배포를 하시겠습니까?" ;
	}
	
	if(confirm(msg)) {
		cf_loading();
		setTimeout(function(){
			$.ajax({
			    type   : "post",
			    url    : "/txap/homepage/layout/distributeAjax.do",
			    data   : $("#Form").serialize(),
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



//복원
function pf_introUse(RMH_KEYNO){
	cf_loading();
	
	setTimeout(function(){
		$.ajax({
			type: "POST",
			url: "/txap/homepage/layout/returnPageAjax.do",
			data : {"RMH_KEYNO":RMH_KEYNO},
			success : function(data){
				editor.setValue(data)
			},
			error : function(){	
			}
		 }).done(function(){
			cf_loading_out();
		});
	},100)
}


//비교하기
function pf_compareData(RMH_KEY1, RM_KEY2){
	cf_loading();
	
	setTimeout(function(){
	$.ajax({
		type: "POST",
		url: "/txap/homepage/layout/compareAjax.do",
		data: "RMH_KEYNO=" + RMH_KEY1 + "&RM_KEYNO=" + RM_KEY2,
		async: false,
		success : function(obj){
			var dmp = new diff_match_patch();
			var diff;
			
			if(RM_KEY2 == undefined){
				diff = dmp.diff_main(obj.length == 1 ? "": obj[1].RM_DATA, obj[0].RM_DATA);
			}else{
				diff = dmp.diff_main(obj[0].RM_DATA, obj[1].RM_DATA);
			}
		    dmp.diff_cleanupSemantic(diff)
		    
		    var ds = dmp.diff_prettyHtml(diff);
	    	$('#compareData').html(ds)
		},
		error: function(){
			cf_smallBox('error', '데이터를 가져올수없습니다. 관리자한테 문의하세요.', 3000,'#d24158');
			return false;
		}
		}).done(function(){
			cf_loading_out();
			});
	},100)
}



</script>