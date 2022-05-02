<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/common/CodeMirror_Include.jsp"%>
<script type="text/javascript" src="/resources/js/common/diff_match_patch.js"></script>
<style>
.customTitle{
    height: 20px;
    border: none;
    cursor: pointer;
    width: auto;
    display: inline;
}
.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control{background-color: inherit;}
</style>

<section id="widget-grid" class="">

	<div class="row">

		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0"
				data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>${resourcesType} 설정</h2>
				</header>
				<div>
					<div class="jarviswidget-editbox"></div>
					<div class="widget-body">
						<div class="widget-body-toolbar bg-color-white">
							<div class="alert alert-info no-margin fade in">
								<button type="button" class="close" data-dismiss="alert">×</button>
								홈페이지를 선택하면 해당하는 홈페이지의 ${resourcesType}설정이 출력 됩니다. 저장하지 않고 다른 탭을 누를 경우 작성했던 내용이 삭제됩니다.
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
						
						<ul id="resourcesTab1" class="nav nav-tabs bordered">
							<li class="active" data-keyno="${ResourcescommonKEYNO.RM_KEYNO}">
								<a href="#" data-toggle="tab" aria-expanded="true" data-scope="common">공통</a>
							</li>
							<li data-keyno="${ResourcesmainKEYNO.RM_KEYNO}">
								<a href="#" data-toggle="tab" aria-expanded="true" data-scope="main">메인</a>
							</li>
							<li data-keyno="${ResourcessubKEYNO.RM_KEYNO}">
								<a href="#" data-toggle="tab" aria-expanded="true" data-scope="sub">서브</a>
							</li>
							<li data-keyno="${ResourcesboardKEYNO.RM_KEYNO}"> 
								<a href="#" data-toggle="tab" aria-expanded="true" data-scope="board">게시판</a>
							</li>
							<c:if test="${not empty ResourcescustomKEYNO}">
								<c:forEach items="${ResourcescustomKEYNO}" var="model">
									<li class="customli" data-keyno="${model.RM_KEYNO}">
										<a href="#" data-toggle="tab" aria-expanded="true" data-scope="custom">
										<input type="text" class="form-control customTitle" value="${model.RM_TITLE }" name="custom_title_5" maxlength="20" readonly="readonly">
										<button class="close" data-dismiss="alert" onclick="pf_closeTab(this);">×</button>
										</a>
									</li> 
								</c:forEach>
							</c:if>
							<c:if test="${empty ResourcescustomKEYNO}">
								<li class="customli">
									<a href="#" data-toggle="tab" aria-expanded="true" data-scope="custom">
									<input type="text" class="form-control customTitle" value="직접설정" name="custom_title_5" maxlength="20" readonly="readonly">
									<button class="close" data-dismiss="alert" onclick="pf_closeTab(this);">×</button>
									</a>
								</li> 
							</c:if>
							<button id="tabPlus" class="btn btn-sm btn-info tabPlus" onclick="pf_addNewJs();" style="padding: 9px;">
								<i class="fa fa-plus"></i>
								추가
							</button>
						</ul>
						<form:form id="Form" method="post" action="">
							<input type="hidden" id="MN_HOMEDIV_C" name="MN_HOMEDIV_C" value="${menu.MN_HOMEDIV_C }" />
							<input type="hidden" id="RM_MN_HOMEDIV_C" name="RM_MN_HOMEDIV_C" value="${menu.MN_HOMEDIV_C }" />
							<input type="hidden" name="RM_TYPE" id="RM_TYPE" value="${resourcesType}">
							<input type="hidden" name="RM_KEYNO" id="RM_KEYNO" value="">
							<input type="hidden" name="RM_TITLE" id="RM_TITLE" value="">
							<input type="hidden" name="RM_SCOPE" id="RM_SCOPE" value="">
							<input type="hidden" name="actionType" id="actionType" value="">
							<input type="hidden" name="allck" id="allck" value="">
							
							<div id="myTabContent1" class="tab-content padding-10 form-horizontal bv-form">
								<div id="resourcesMenuDiv" class="tree">
			  						<ul id="menuListUl">
									</ul>
								</div>
								<div id="resourcesForm">
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
												<td><span class="nessSpan">*</span>제목</td>
												<td colspan="3">
												<input type="text" class="form-control" name="TITLE_NAME" id="TITLE_NAME" maxlength="50" placeholder="파일명 입력" onkeyup="pf_titleInsert(this.value);">
												</td>
											</tr>
											<tr>
												<td><span class="nessSpan">*</span>파일명</td>
												<td colspan="3">
												<input type="text" class="form-control" name="RM_FILE_NAME" id="RM_FILE_NAME" maxlength="50" placeholder="파일명.min으로 저장 후 배포할 경우 압축되어 배포됩니다." onkeyup="fn_press_han(this);">
												</td>
											</tr>
											<tr>
												<td>코멘트</td>
												<td colspan="3">
												<input type="text" class="form-control" name="RMH_COMMENT" id="RMH_COMMENT" data-bv-field="fullName" maxlength="500" placeholder="no message">
												</td>
											</tr>
											<tr>
												<td colspan="4"><span class="nessSpan">*</span>내용</td>
											</tr>
											<tr>
												<td colspan="4">
													<textarea class="form-control ckWebEditor" name="RM_DATA" id="RM_DATA"  style="width:100%;height:500px;min-width:260px;" data-bv-field="content"></textarea>
												</td>
											</tr>
											
											<tr>
												<td colspan="4">
													<fieldset class="padding-10 text-right"> 
														<button type="button" onclick="pf_jsDataInsert();" class="btn btn-sm btn-primary">	
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
var msg = '${msg}' 
$(function(){
	if(msg){
		setTimeout(function(){
			cf_smallBox('success', msg, 3000);
		},100)
	}
	var resourcesType = '${resourcesType}'
		resourcesType = resourcesType == 'js' ? 'javascript':resourcesType;
	editor = codeMirror(resourcesType,'RM_DATA')
	
	var SELECT_KEYNO = '${SELECT_KEYNO}'
	pf_clickLi('ture')
	if(SELECT_KEYNO != null && SELECT_KEYNO != ''){
		$("#resourcesTab1 li").each(function(i){
			if($(this).data('keyno') == SELECT_KEYNO){
				$("#resourcesTab1 li").removeClass('active');
				$(this).addClass('active');
				$(this).trigger("click");
			}
		})
	}else{
		$("#resourcesTab1 li").first().trigger("click");
	}
	
});

function pf_clickLi(tabactiveCK){
	if(!tabactiveCK){
		$('.customTitle:first').trigger('click');
	}
	
	$("#resourcesTab1 li").on('click', function(){
		var scopeType = $(this).find('a').data('scope');
		var resourcesKey = $(this).data('keyno');
		var title;
		if(scopeType == 'custom'){
			title = $(this).find('input').val()
		}else{
			title = $(this).find('a').text()
		}
		pf_formAjax(resourcesKey,scopeType,title)
	})
}

function pf_formAjax(resourcesKey,scopeType,title){
	cf_loading();
	
	setTimeout(function(){
		$.ajax({
			type: "POST",
			url: "/txap/homepage/resource/${resourceType}/Ajax.do",
			data : {
					"RM_KEYNO"			:resourcesKey,
					"RM_SCOPE"			:scopeType
				},
			success : function(result){
				var data = result.ResultData;
				var historyList = result.HistoyeData;
				var keyno = '';
				var actiontype = 'insert';
				var REGNM = '작성자 없음';
				var REGDT = '작성일 없음';
				var MODNM = '최근 게시물 수정자 없음';
				var MODDT = '게시물 수정이력 없음';
				var RM_FILE_NAME = '';
				var RM_DATA = '';
				var RMH_COMMENT = '';
				
				if(data != null && data != ""){
					actiontype	 	= 'update';   
					keyno	 		= data.RM_KEYNO;   
					REGNM 			= data.RM_REGNM;   
					REGDT 			= data.RM_REGDT;   
					if(typeof data.RM_MODNM != 'undefined'){
						MODNM 		= data.RM_MODNM;   
					}
					if(typeof data.RM_MODDT != 'undefined'){
						MODDT 		= data.RM_MODDT;   
					}
					RM_FILE_NAME 	= data.RM_FILE_NAME;
					RM_DATA 		= data.RM_DATA;
				}
				
				$("#RM_TITLE").val(title)
				$("#TITLE_NAME").val(title)
				$("#RM_SCOPE").val(scopeType)
				$("#actionType").val(actiontype)
				$("#RM_KEYNO").val(keyno)
				$("#REGNM").text(REGNM)
				$("#REGDT").text(REGDT)
				$("#MODNM").text(MODNM)
				$("#MODDT").text(MODDT)
				$("#RMH_COMMENT").val(RMH_COMMENT)
				$("#RM_FILE_NAME").val(RM_FILE_NAME)
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
			    		temp += '	<a class="btn btn-default btn-xs" href="javascript:;" onclick="pf_compareData(\''+history.RMH_KEYNO+'\',\''+history.RMH_RM_KEYNO+'\');"><i class="fa fa-repeat"></i> 최신 데이터와 비교</a>';
			    		temp += '	<a class="btn btn-default btn-xs" href="javascript:;" onclick="pf_compareData(\''+history.RMH_KEYNO+'\');"><i class="fa fa-repeat"></i> 변경사항</a>';
				    	temp += '	</td>';
			    		temp += '</tr>';
					})
				}
				$("#intro-history").html(temp)
				
				if(scopeType == 'custom'){
					$("#TITLE_NAME").attr('disabled',false)
					pf_jsMenuList($("#MN_HOMEDIV_C").val(),keyno)
					$("#resourcesMenuDiv").css('width','30%').css('float','left').css('overflow-y','scroll').css('height','740px')
					$("#resourcesForm").css('width','70%').css('float','left')
				}else{
					$("#TITLE_NAME").attr('disabled',true)
					$("#menuListUl").html('')
					$("#resourcesMenuDiv").removeAttr('style')
					$("#resourcesForm").removeAttr('style')
				}
			},
			error : function(){	
				cf_smallBox('error', '에러발생', 3000,'#d24158');
			}
		}).done(function(){
			cf_loading_out();
		});
	},100)
}

function pf_jsMenuList(homekey,keyno){
	$.ajax({
		type: "POST",
		url: "/txap/homepage/resource/${resourceType}/MenuListAjax.do",
		data : {
				"KEYNO"					: keyno,
				"MN_HOMEDIV_C"			: homekey
			},
		success : function(result){
			$("#menuListUl").html(result)
		},
		error : function(){	
			cf_smallBox('error', '메뉴 리스트 가져오기 에러', 3000,'#d24158');
		}
	});
}

function pf_HomeDivChange(value){
	location.href="/txap/homepage/resource/${resourceType}.do?MN_HOMEDIV_C="+value  
}

// CSS 배포
function pf_Distribute(allck) {
	
	$('#allck').val(allck);
	
	if(allck == 'false'){
		if($("#RM_KEYNO").val() == null || $("#RM_KEYNO").val() == ''){
			cf_smallBox('error', '저장한 후 배포가능합니다.', 3000,'#d24158');
			return false;
		}
	}
	var url = '/txap/homepage/resource/${resourceType}/distributeAjax.do'
	cf_smallBoxConfirm('Ding Dong!', '정말 배포를 하시겠습니까?','onclick=pf_submit(\''+url+'\')')
}

function pf_submit(url){
	cf_loading();
	setTimeout(function(){
		$('#Form').attr('action',url);
		$('#Form').submit();
	},100)
}

//복원
function pf_introUse(RMH_KEYNO){
	cf_loading();
	
	setTimeout(function(){
		$.ajax({
			type: "POST",
			url: "/txap/homepage/resource/${resourceType}/detailView/returnPage.do",
			data : {"RMH_KEYNO":RMH_KEYNO},
			success : function(data){
				editor.setValue(data)
				cf_smallBox('success', '데이터를 성공적으로 불러왔습니다', 3000);
			},
			error : function(){	
				cf_smallBox('error', '에러발생', 3000,'#d24158');
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
		url: "/txap/homepage/resource/${resourceType}/detailView/compareAjax.do",
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

//추가버튼
function pf_addNewJs(){
	var customCnt = $("#resourcesTab1").find('li').length
	var liCnt = $("#resourcesTab1").find('li').length+1
	var cloneLi = $("#resourcesTab1").find('li:nth-child('+customCnt+')').clone()
									.removeClass('active')
									.attr('data-keyno','')
									.find("input").attr('name', 'custom_title_'+liCnt).val("직접입력").end();
	$('#tabPlus').before(cloneLi)
	pf_clickLi('ture')
}


//탭삭제
function pf_closeTab(obj){
	$li = $(obj).closest('li');
	var tabCnt  = $('.customli').length;
	var key 	= $li.data('keyno');
	
	if(tabCnt <= 1){
		cf_smallBox('error', '초기값은 삭제하실 수 없습니다.', 3000,'#d24158');
		return false;
	}else{
		if(key){
			if(confirm('삭제하시겠습니까?')){
				
				cf_loading();
				
				setTimeout(function(){
					$.ajax({
						type: "POST",
						url: "/txap/homepage/resource/${resourceType}/DeleteAjax.do",
						data : {"RM_KEYNO":key},
						success : function(data){
							cf_smallBox('success', '삭제되었습니다.', 3000);
							$li.remove()
							pf_clickLi($('#resourcesTab1 li').hasClass('active'))
						},
						error : function(){	
							cf_smallBox('error', '에러발생', 3000,'#d24158');
						}
					 }).done(function(){
						cf_loading_out();
					});
				},100)
			}
// 			cf_smallBoxConfirm('Ding Dong!', '삭제 하시겠습니까?', "onclick=pf_tapDelete(\'" + key + "\',\'" + $li.length + "\')")
		}else{
			 $li.remove()
		}
		
		pf_clickLi($('#resourcesTab1 li').hasClass('active'))
	}
}

//삭제작업
function pf_tapDelete(key,obj){
	console.log(key)
	cf_loading();
	
	setTimeout(function(){
		$.ajax({
			type: "POST",
			url: "/txap/homepage/resource/${resourceType}/DeleteAjax.do",
			data : {"RM_KEYNO":key},
			success : function(data){
				cf_smallBox('success', '삭제되었습니다.', 3000);
				$obj.remove()
			},
			error : function(){	
				cf_smallBox('error', '에러발생', 3000,'#d24158');
			}
		 }).done(function(){
			cf_loading_out();
		});
	},100)
}

function pf_validate(id, text){
	if(!$("#"+id).val()){
	  cf_smallBox('error', text+'을 입력해주세요.', 3000,'#d24158');
      $("#"+id).focus()
      return false;
    }
	return true;
}

//저장
function pf_jsDataInsert(){
  	
	$("#RM_DATA").val(editor.getValue())
	$("#RM_TITLE").val($("#TITLE_NAME").val())

	if(!pf_validate('TITLE_NAME','제목')){return false;}
	if(!pf_validate('RM_FILE_NAME','파일명')){return false;}
	if(!pf_validate('RM_DATA','내용')){return false;}
		
	var url = '/txap/homepage/resource/${resourceType}/insert.do'
	cf_smallBoxConfirm('Ding Dong!', '저장 하시겠습니까?','onclick=pf_submit(\''+url+'\')')
} 


function pf_titleInsert(val){
	$("#resourcesTab1 li.active").find('input').val(val)
}

/* 한글입력 방지 */
function fn_press_han(obj){
	$(obj).val($(obj).val().replace(/[\ㄱ-ㅎㅏ-ㅣ|가-힣]/gi,''))
}


</script>