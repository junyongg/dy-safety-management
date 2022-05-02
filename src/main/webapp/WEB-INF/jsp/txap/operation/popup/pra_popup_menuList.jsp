<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<style>
.tree .settings {display:inline-block;font-size: 0.5em;}
.tree .settings .checkbox {display:inline-block;margin:0;}
</style>

<%-- <legend id="mappingName">${resultData.NAME }</legend> --%>
<ul id="menuListTab" class="nav nav-tabs bordered">
<c:forEach items="${resultList}" var="model" varStatus="status">
	<li class="${status.first ? 'active':'' }">
		<a href="#menuList-tab-content-${status.count}" data-key="${model.homeManager.MN_KEYNO }" data-toggle="tab" class="menuList_select">${model.homeManager.MN_NAME}</a>
	</li>
</c:forEach>
	<li class="pull-right">
		<a href="javascript:void(0);">
		</a>
	</li>
</ul>
<div class="tab-content padding-10">
<c:forEach items="${resultList}" var="contents" varStatus="status">
	<div id="menuList-tab-content-${status.count}" class="tab-pane fade ${status.first ? 'in active':'' }" data-type="homepage">
		<div class="tree">
			<ul>
				<c:set var="HOMDIV_KEYNO" value="${contents.homeManager.MN_KEYNO }"/>
				<li class="parent_li" data-key="${contents.homeManager.MN_KEYNO }"> 
					<span class="label label-primary">
						<i  class="fa fa-lg fa-plus-circle">
						${contents.homeManager.MN_NAME }
						</i>
					</span>
							<div class="settings">
								<div class="checkbox">
									<label>
									  <input type="checkbox" class="checkbox style-3 access" name="accessRole">
									  <span></span>
									</label>
								</div>
							</div>
					<div class="settings">
						<div class="checkbox">
							<a href="javascript:;" onclick="pf_allOpenAndClose(this)"><i class="fa fa-plus" style="color:red;"></i> <font>모두 펼치기</font></a>
						</div>
					</div>
					<ul id="depth1Group">
							<li data-key="${HOMDIV_KEYNO }"> 
							<span>
					  			<i class="fa fa-lg fa-caret-right" ></i> 
					  			메인 화면
							</span>
							<div class="settings">
								<div class="checkbox">
									<label>
									  <input type="checkbox" class="checkbox style-3 access" name="accessRole">
									  <span></span>
									</label>
								</div>
							</div>
							</li>
					
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
						<li class="parent_li" data-key="${model.MN_KEYNO }"> 
							<span class="label label-primary">
					  			<i class="fa fa-lg fa-plus-circle"></i> 
					  			<c:out value="${model.MN_NAME}" escapeXml="false" />
					
							</span>
					</c:if>
					<!--뷰, 게시판형일경우 -->
					<c:if test="${model.MN_PAGEDIV_C ne MENU_TYPE_SUBMENU }">
						<li data-key="${model.MN_KEYNO }"> 
							<span>
					  			<i class="fa fa-lg fa-caret-right" ></i> 
					  			<c:out value="${model.MN_NAME}" escapeXml="false" />
					
							</span>
							<div class="settings">
								<div class="checkbox">
									<label>
									  <input type="checkbox" class="checkbox style-3 access" name="accessRole">
									  <span></span>
									</label>
								</div>
							</div>
					  		
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
				</li>
			</ul>
		</div>
	</div>
</c:forEach>
</div>


<script>
var cnt = 0;
var checkbox_list = [];
$(function(){
	$("input[name=accessRole]").on('click', function(){
		var Maintext = $("ul#menuListTab").find(".active").text().trim();
    	var Mainvalue = $("ul#menuListTab").find(".active").find("a").attr("data-key");
    	
    	var Subtext = $(this).closest("li").find("span").first().text().trim();
		var Subvalue = $(this).closest("li").attr('data-key');
		
		if(selected_popup_list != null){
			for(var i=0; i<selected_popup_list.length; i +=3){
				if(Maintext == selected_popup_list[i]){
					if(Subtext == selected_popup_list[i+1]){
						selected_popup_list[i] = "";
						selected_popup_list[i+1] = "";
						delete_span(selected_popup_list[i+2]);
					}
				}
			}
		}
		
		if($(this).prop('checked')){
			
			if(Maintext == Subtext){
				//기존 메뉴 제거
				for(var i=0; i<selected_popup_list.length; i +=3){
					if(Maintext == selected_popup_list[i]){
					selected_popup_list[i] = "";
					selected_popup_list[i+1] = "";
					delete_span(selected_popup_list[i+2]);
					}
				}
	 			//전체메뉴 선택시 하위메뉴 삭제
	 			for(var j=0; j<checkbox_list.length; j +=2){
	 				if(Maintext == checkbox_list[j]){
	 					checkbox_list[j] = "";
	 		 			checkbox_list[j+1] = "";
	 		 			$(".delete_"+j/2).remove();
	 		 			$("span[name=delete_"+j/2+"]").remove();
	 		 			}
	 				}
	 			checkbox_list.push(Maintext);
	 			checkbox_list.push(Subtext);
	 			var temp = "";
	 			temp += '<input class ="delete_'+cnt+'" type="hidden" name="MN_MENU_TITLE" value="'+Mainvalue+'"/>';
	 			temp += '<input class ="delete_'+cnt+'" type="hidden" name="MN_SUB_TITLE" value="A"/>';
	 			temp += '<span class="tag label label-info" name="delete_'+cnt+'"><div class="a">'+Maintext+'</div><div class="b">전체메뉴</div></span>';
	 			$('#selected_menu').append(temp);
	 			cnt += 1;
			}else{
	 			checkbox_list.push(Maintext);
	 			checkbox_list.push(Subtext);
	 			var temp = "";
	 			temp += '<input class ="delete_'+cnt+'" type="hidden" name="MN_MENU_TITLE" value="'+Mainvalue+'"/>';
	 			temp += '<input class ="delete_'+cnt+'" type="hidden" name="MN_SUB_TITLE" value="'+Subvalue+'"/>';
	 			temp += '<span class="tag label label-info" name="delete_'+cnt+'"><div class="a">'+Maintext+'</div><div class="b">'+ Subtext+'</div></span>';
	 			$('#selected_menu').append(temp);
	 			cnt += 1;
			}
		}else{
			var Maintext = $("ul#menuListTab").find(".active").text().trim();
	    	var Mainvalue = $("ul#menuListTab").find(".active").find("a").attr("data-key");
	    	
	    	var Subtext = $(this).closest("li").find("span").first().text().trim();
			var Subvalue = $(this).closest("li").attr('data-key');
			
			if(Maintext == Subtext){
				$('input[name=accessRole]').prop('checked',false);
			}
			for(var j=0; j<checkbox_list.length; j +=2){
	 		 		if(Maintext == checkbox_list[j]){
	 		 			if(Subtext == checkbox_list[j+1]){
	 		 				checkbox_list[j] = "";
	 		 				checkbox_list[j+1] = "";
	 		 				$(".delete_"+j/2).remove();
	 		 				$("span[name=delete_"+j/2+"]").remove();
	 		 				return
	 		 			}
	 		 		}
	 		 	}
		}
	});
	
	$('.tree > ul').attr('role', 'tree').find('ul').attr('role', 'group');
	$('.tree li.parent_li > ul > li').hide();
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
	$('.tree > ul > li > span').trigger('click');
	
	$('input[name=accessRole]').on('click',function(){
		//하위 checkbox들 checked 처리
// 		$(this).closest('li').find('input[name=accessRole]').prop('checked',$(this).is(':checked'));
		
		$(this).closest('li').find('input[name=accessRole]').prop('disabled',$(this).is(':checked'));
		$(this).prop("disabled","");
		//부모 checkbox checked 처리
		var uncheckedLength = $(this).closest('ul').children('li').find('input[name=accessRole]').not(':checked').length;
		var parentInput = $(this).closest('ul').closest('li').children('.settings').find('input[name=accessRole]');
		if(uncheckedLength == 0){
			parentInput.prop('checked',true)
		}else{
			parentInput.prop('checked',false)
		}
	})
})

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

function delete_span(num){
	$(".delete_"+num).remove();
	$("span[name=delete_"+num+"]").remove();
}

</script>
