<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>



<style>
#menuIconView {font-size:50px; margin:15px 5px;}
div[id*=LINKBOX] {display:none;}
</style>

<!-- 폼 양식 설정 -->
<form:form action="" id="Form_list" name="Form" method="post" >
  <input type="hidden" id="MN_KEYNO" name="MN_KEYNO" value=""/>
  <input type="hidden" id="MN_HOMEDIV_C" name="MN_HOMEDIV_C" value="${menu.MN_HOMEDIV_C }"/>
</form:form>

<!-- 내용시작 -->
<div>
	<section id="widget-grid" class="">
		<div class="row" >
			<article class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
				<div class="jarviswidget jarviswidget-color-darken" id="menu_master_1" data-widget-editbutton="false">
  					<header>
    					<span class="widget-icon"> <i class="fa fa-lg fa-th-large"></i> </span>
    					<h2>페이지관리</h2>
  					</header> 
  				<div> 
  				<div class="jarviswidget-editbox"></div>
  				<div class="widget-body">
  					<div class="widget-body-toolbar bg-color-white">
    					<div class="form-inline">
      						<div class="row">
        						<div class="col-sm-12">
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
          							<div class="form-group" style="float: right;">
           								<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_allOpenAndClose('O')">	
											<i class="fa fa-plus"></i> 펼침
										</button>
										<button class="btn btn-sm btn-primary" id="Board_Edit"	type="button" onclick="pf_allOpenAndClose('C')">	
											<i class="fa fa-minus"></i> 닫힘
										</button>
										<button class="btn btn-sm btn-success" id="Board_Edit"	type="button" onclick="pf_Distribute('true')">	
											<i class="fa fa-plus"></i> 전체배포
										</button>
          							</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tree">
  						<ul id="menuListUl">
						</ul>
					</div>
				</div>
			</article>
			<article class="col-xs-12 col-sm-6 col-md-8 col-lg-8">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-1"
					data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-lg fa-th-large"></i></span>
						</span>
						<h2>페이지 등록 및 수정</h2>
					</header>
					<div id="page_ch"></div>
				</div>
			</article>
		</div>
	</section>
</div>
		
<script type="text/javascript">

var refreshParentKey = '';
$(document).ready(function() {
	//초기 뎁스1 메뉴 셋팅
	pf_changeHomeDiv('${menu.MN_KEYNO}')
});

//홈페이지 변경 처리
function pf_changeHomeDiv(value){
	$('#menuListUl').html(pf_getSubList(value));
}
 	
//페이지 만들기
function pf_makepage(menuKey, obj){
	$('#MN_KEYNO').val(menuKey);
	$.ajax({
		type: "POST",
		url:"/txap/homepage/page/insertView.do",
		data: $("#Form_list").serialize(),
		success : function(data){
			$("#page_ch").html(data)
			$("li.pageViewLi").removeClass().addClass('pageViewLi')
			$(obj).closest('li').addClass('active');
		},
		error  :function(){
		}	
	});
}
	
//sub 메뉴 리스트 가져오기
function pf_getSubList(key){
	$('#MN_KEYNO').val('');
	$('#MN_HOMEDIV_C').val(key);
	var temp= '';
	$.ajax({
		type: "POST",
		url: "/txap/homepage/page/subList/listAjax.do",
		async: false,
		data: $("#Form_list").serialize(),
		success : function(data){
		  	temp = data;
		}, error: function(){
			cf_smallBox('error', '메뉴 리스트 가져오기 에러', 3000,'#d24158');
			return false;
		}
	});
	return temp;
}
  

//배포하기
function pf_Distribute(allck) {

	if(confirm("정말 전체 배포를 하시겠습니까?")) {
		cf_loading();
		
		setTimeout(function(){
			$.ajax({
			    type   : "post",
			    url    : "/txap/homepage/page/distributeAjax.do",
			    data   : {
			    		"allck"	 			: allck,
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
  
</script>