<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<style>
.tree .settings {display:inline-block;font-size: 0.5em;}
.tree .settings .checkbox {display:inline-block;margin:0;}

.fixed-btns {position: fixed;bottom: 50px;right: 40px;z-index: 100;}
.fixed-btns > li {display: inline-block;margin-bottom: 7px;}
label input[type=checkbox].checkbox + span {font-weight: 700 !important;}
.board-tree label span {border:none;margin-right:0;}

label input[type=checkbox].checkbox.style-3.all:checked+span:before {border-color: #3276b1;background: #3276b1;}

</style>

<form:form id="menuSettingForm">
	<input type="hidden" name="type" value="${type}">
	<input type="hidden" name="UIA_KEYNO" value="${resultData.UIA_KEYNO }">
	<input type="hidden" name="UIA_DIVISION" value="${resultData.UIA_DIVISION }">
	<input type="hidden" name="UI_ID" value="${resultData.UI_ID }">
	<input type="hidden" name="UI_KEYNO" value="${resultData.UI_KEYNO }">

<div class="text-align-right pull-right">
	<div class="btn-group">  
		<button class="btn btn-sm btn-primary" type="button" onclick="pf_selectAll(true)">
			<i class="fa fa-plus"></i> 모두 선택
		</button>
		<button style="margin-left:5px;" class="btn btn-sm btn-primary" type="button" onclick="pf_selectAll(false)">
			<i class="fa fa-minus"></i> 모두 해제
		</button> 
	</div>
</div>

<legend id="mappingName">${resultData.NAME eq 'ANONYMOUS' ? '비회원' : resultData.NAME }
<c:if test="${type eq 'B' }"> - ${resultData.UIA_NAME }</c:if>
</legend>



<ul id="menuListTab" class="nav nav-tabs bordered">
<c:forEach items="${resultList}" var="model" varStatus="status">
	<li class="${status.first ? 'active':'' }">
		<a href="#menuList-tab-content-${status.count}" data-toggle="tab">${model.homeManager.MN_NAME}</a>
	</li>
</c:forEach>
<!-- 	<li> -->
<%-- 		<a href="#menuList-tab-content-${fn:length(resultList) + 1}" data-toggle="tab"> --%>
<!-- 			<i class="fa fa-th-list" style="color:red;"></i> -->
<!-- 			게시판 -->
<!-- 		</a> -->
<!-- 	</li> -->
	<li class="pull-right">
		<a href="javascript:void(0);">
		</a>
	</li>
</ul>
<div class="tab-content padding-10">
<c:forEach items="${resultList}" var="contents" varStatus="status">
	<div id="menuList-tab-content-${status.count}" class="tab-pane fade ${status.first ? 'in active':'' }" data-type="homepage">
		<div class="tree menu-tree">
			<ul>
			<c:set var="beforeDepth" value=""/>
			<c:forEach items="${contents.menuList}" var="model" varStatus="status2">
			
				<c:if test="${ !status2.first && model.MN_LEV lt beforeDepth }">
					<c:forEach begin="${model.MN_LEV}" end="${beforeDepth - 1}">
					</ul>
				</li>
					</c:forEach>
				</c:if>
			
			<!-- 소메뉴 형 일경우 -->
			<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU }">
				<li class="parent_li"> 
					<span class="label label-primary">
			  			<i class="fa fa-lg fa-plus-circle"></i> 
			</c:if>
			<!--뷰, 게시판형일경우 -->
			<c:if test="${model.MN_PAGEDIV_C ne MENU_TYPE_SUBMENU }">
				<li> 
					<span>
			  			<i class="fa fa-lg fa-caret-right" ></i> 
			</c:if>
						<c:out value="${model.MN_NAME}" escapeXml="false" />
			
					</span>
					<div class="settings">
						<div class="checkbox">
							<c:choose>
								<c:when test="${fn:contains(model.MN_URL,'/member')}">
							<span style="color:gray;">설정불가(로그인 관련 url)</span>	
								</c:when>
								<c:when test="${resultData.UIA_DEPTH eq '1' || (resultData.UIA_DEPTH ne '1' && fn:contains(model.MN_ROLES_MAIN,AUTHORITY_ROLE_ACCESS) ) }">
								<!-- 부모그룹이 없거나 // 부모 그룹이 있고, 부모 그룹에서 접근권한이 있을경우 -->
							<c:set var="accessChecked" value="${fn:contains(model.MN_ROLES,AUTHORITY_ROLE_ACCESS) ? 'checked':'' }"/>
							<label>
								<c:set var="isBoardClass" value="${model.MN_PAGEDIV_C eq MENU_TYPE_BOARD ? 'board':'' }"/>
								<input type="checkbox" class="checkbox style-3 access ${isBoardClass }" name="accessRole" value="${model.MN_KEYNO }" ${accessChecked }>
								<span>접근권한</span>
							</label>
								</c:when>
								<c:otherwise>
							<span style="color:gray;">접근불가</span>	
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				<c:if test="${status2.first }">
					<a href="javascript:;" onclick="pf_allOpenAndClose(this)"><i class="fa fa-plus" style="color:red;"></i> <font>모두 펼치기</font></a>
				</c:if>
					<ul>
				<c:if test="${model.MN_PAGEDIV_C ne MENU_TYPE_SUBMENU || (model.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU && model.MN_CHILD_CNT eq 0)}">
					</ul>
				</li>
				</c:if>
				
				<c:if test="${status2.last && model.MN_LEV gt 1}">
					<c:forEach begin="1" end="${model.MN_LEV}">
					</ul>
				</li>
					</c:forEach>
				</c:if>
				<c:set var="beforeDepth" value="${model.MN_LEV }"/>
			</c:forEach>
			</ul>
		</div>
	</div>
</c:forEach>
	<div id="menuList-tab-content-${fn:length(resultList) + 1}" class="tab-pane fade" data-type="board">
		<div class="tree board-tree">
			<ul>
			<c:set var="beforeDepth" value=""/>
			<c:forEach items="${boardList}" var="model" varStatus="status">
			
				<c:if test="${ !status.first && model.MN_DEPTH lt beforeDepth }">
					<c:forEach begin="${model.MN_DEPTH}" end="${beforeDepth - 1}">
					</ul>
				</li>
					</c:forEach>
				</c:if>
			
			<!-- 게시판의 뎁스는 3이다 -->
			<c:if test="${model.MN_DEPTH ne 3 }">
				<li class="parent_li"> 
					<span class="label label-primary">
			  			<i class="fa fa-lg fa-plus-circle"></i> 
			</c:if>
			<c:if test="${model.MN_DEPTH eq 3 }">
				<li> 
					<span>
			  			<i class="fa fa-lg fa-caret-right" ></i> 
			</c:if>
						<c:out value="${model.MN_NAME}" escapeXml="false" />
					</span>
					<div class="settings">
						<div class="checkbox ${model.MN_KEYNO }">
							<c:if test="${model.MN_DEPTH eq 3}">
							<label class="boardRole">
								<input type="checkbox" class="checkbox style-3 all" value="">
								<span>모든 권한</span>
							</label>
							<c:forEach items="${boardAuthorityList }" var="boardAuth">
							<label class="boardRole">
								<c:set var="roleCheck" value="${fn:contains(model.UIR_KEYNO,boardAuth.UIR_KEYNO) ? 'checked':'' }"/>
								<input type="checkbox" class="checkbox style-3 ${boardAuth.UIR_NAME}" name="${boardAuth.UIR_NAME}Role" value="${model.MN_KEYNO }" ${roleCheck }>
								<span>${boardAuth.UIR_COMMENT}</span>
							</label>
							</c:forEach>
							<span class="boardRole" style="color:gray;">접근불가</span>	
							</c:if>
						</div>
					</div>
					<ul>
				<c:if test="${model.MN_DEPTH eq 3}">
					</ul>
				</li>
				</c:if>
				
				<c:if test="${status2.last}">
					<c:forEach begin="1" end="2">
					</ul>
				</li>
					</c:forEach>
				</c:if>
				<c:set var="beforeDepth" value="${model.MN_DEPTH }"/>
			</c:forEach>
			</ul>
		</div>
	</div>
</div>
</form:form>

<ul class="fixed-btns">
	<li>
		<a href="javascript:;" onclick="pf_save()" class="btn btn-primary btn-circle btn-lg"><i class="fa fa-save"></i></a>
	</li>
	<li>
		<a href="javascript:;" onclick="pf_moveTop()" class="btn btn-default btn-circle btn-lg"><i class="fa fa-chevron-up"></i></a>
	</li>
</ul>

<script>

$(function(){
	$('.tree > ul').attr('role', 'tree').find('ul').attr('role', 'group');
	$('.menu-tree li.parent_li > ul > li').hide();
	$('.tree').find('.parent_li').attr('role', 'treeitem').find(' > span').attr('title', 'Collapse this branch').on('click', function(e) {
		var children = $(this).parent('li.parent_li').find(' > ul > li');
		if (children.is(':visible')) {
			children.hide('fast');
			$(this).attr('title', 'Expand this branch').find(' > i').removeClass().addClass('fa fa-lg fa-plus-circle');
		} else {
			children.show('fast');
			$(this).attr('title', 'Collapse this branch').find(' > i').removeClass().addClass('fa fa-lg fa-minus-circle');
		}
		e.stopPropagation();
	});	
	$('.menu-tree > ul > li > span').trigger('click');
	
	
	
	$('input[name=accessRole]').on('click',function(){
		
		//하위 checkbox들 checked 처리
		$(this).closest('li').find('input[name=accessRole]').prop('checked',$(this).is(':checked')).each(function(){
			if($(this).hasClass('board')){
				pf_changeBoardAuth($(this))	
			}
		});
		
		//부모 checkbox checked 처리
		if($(this).is(':checked')){
			$(this).parents('li.parent_li').children('.settings').find('input[name=accessRole]').prop('checked',true);
		}
		
	})
	
	$('input[name=accessRole].board').each(function(){
		pf_changeBoardAuth($(this))
	})
	
	$('.board-tree input[type=checkbox].all').on('click',function(){
		$(this).closest('.settings').find('input[type=checkbox]').prop('checked',$(this).is(':checked'));
	})
	
	$('.board-tree input[type=checkbox]:not(.all)').on('click',function(){
		
		pf_boardAuthAllCheck($(this).closest('.settings'));
		
	})
	
	$('.board-tree .settings').each(function(){
		pf_boardAuthAllCheck(this);
	})
})

/**
 * 게시판 모드 권한 체크박스 체크 여부 
 * obj  = .setting 객체
 */
function pf_boardAuthAllCheck(obj){
	
	var unCheckedLength = $(obj).find('input[type=checkbox]:not(.all):not(:checked)').length;
	$(obj).find('input[type=checkbox].all').prop('checked',unCheckedLength == 0)
}



function pf_allOpenAndClose(obj){
	var ul = $(obj).next('ul');
	
	if($(obj).find('i').hasClass('fa-plus')){
		$(obj).find('i').addClass('fa-minus').removeClass('fa-plus');
		$(obj).find('font').text('모두 닫기');
		$(obj).closest('li').find('li.parent_li > span').each(function(){
			$(this).parent('li.parent_li').find(' > ul > li').show();
			$(this).attr('title', 'Collapse this branch').find(' > i').removeClass().addClass('fa fa-lg fa-minus-circle');
		})
	}else{
		$(obj).find('i').addClass('fa-plus').removeClass('fa-minus');
		$(obj).find('font').text('모두 펼치기');
		$(obj).closest('li').find('li.parent_li > span').each(function(){
			$(this).parent('li.parent_li').find(' > ul > li').hide();
			$(this).attr('title', 'Expand this branch').find(' > i').removeClass().addClass('fa fa-lg fa-plus-circle');
		})
	}
	
	
}

function pf_moveTop(){
	$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
}

function pf_save(){
	
	cf_loading();
	
	setTimeout(function(){
		$.ajax({
			type: "POST",
			url: "/txap/homepage/authority/saveMenuListAjax.do",
			data: $('#menuSettingForm').serializeArray(),
			async :false,
			success : function(data){
				if(data == 'S'){
					cf_smallBox('ajax', '[${resultData.NAME }] 에 대한 메뉴별 권한이 저장되었습니다.', 3000);
					if('${type}' == 'B'){
						pf_LinkPage($('#userPageIndex').val())
					}
				}else{
					cf_smallBox('ajax', '알수없는 에러 발생. 관리자한테 문의하세요.', 3000,'gray');
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				cf_smallBox('ajax', '알수없는 에러 발생. 관리자한테 문의하세요.', 3000,'gray');
			}
	   }).done(function(){
		   cf_loading_out();
	   });
	},100)
	
	
}

function pf_changeBoardAuth(obj){
	
	var mnKey = $(obj).val();
	
	var checkbox = $('.board-tree .checkbox.'+mnKey);
	
	checkbox.find('.boardRole').hide();
	if($(obj).is(':checked')){
		checkbox.find('label.boardRole').show();
	}else{
		checkbox.find('span.boardRole').show();
	}

	
	
}

function pf_selectAll(check){
	$('.settings input[type=checkbox]').prop('checked',check);
	
	$('input[name=accessRole].board').each(function(){
		pf_changeBoardAuth($(this))
	})
}


</script>
