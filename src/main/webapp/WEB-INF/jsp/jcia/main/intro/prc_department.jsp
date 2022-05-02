<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<link type="text/css" rel="stylesheet" href="/resources/jcia/css/board.css">
<style>
font.searchKeyword {color:#1e69c8;font-weight: bold;}
</style>
<script>

//검색
function pf_orgSearch(depName){
	if(depName){
		$('#searchCondition').val('D')
		$('#searchKeyword').val(depName)
	}
	var searchCondition = $('#searchCondition').val();
	
	var keyword = $('#searchKeyword').val();
	$('.table_wrap_mobile').show(); // 일단 모든 테이블 show
	if(searchCondition != 'D' && keyword){
		$('.grouptd').hide();
		$('.tempTd').show();
	}else{
		$('.grouptd').show();
		$('.tempTd').hide();
	}
	
	$('font.searchKeyword').each(function(){ // 기존 하이라이트 제거
		$wrap = $(this).parent();
		var temp = $wrap.text();
		$wrap.html(temp);
	});
	
	if(!keyword){ // 검색어가 없으면 전체 보여줌
		$('div[id^=group], tr[id^=person]').show();
	}else{
		
		if(searchCondition == 'D'){ //부서검색일시
			pf_orgSearchWithDepName(keyword)
			return false;
		}
		
		$('div[id^=group], tr[id^=person]').hide();
		
		var className = '.condition'+searchCondition;
		var searchClass = new Array();
		var result = new Array();
		$(className).each(function(){ // 검색결과 필터링
			if($(this).html().includes(keyword.trim())){
				var searchTr = $(this).closest("tr");
				searchClass.push($(searchTr).attr("class"));
						
				$(this).parents('tr').show(); // 해당 사원 show
				$(this).parents('.table_wrap_mobile').prev().show(); //해당 사원의 부서 show
				
				var temp = $(this).html(); // 검색결과 하이라이트
				temp = temp.replaceAll(keyword , '<font class="searchKeyword">'+keyword+'</font>');
				$(this).html(temp);
				
			}
		});
		//아이디랑 클래스이름 같을 때 갯수 찾아서 rowspan을 변경?
		console.log(searchClass)
		searchClass.sort();
		for(var value in searchClass) {
		    var index = searchClass[value];
		    result[index] = result[index] == undefined ? 1 : result[index] += 1;
		}        
		for(var value in result) {
			$("tr[class="+value+"]:visible").each(function(i){
				if(i == 0){
					//rowspan
					$(this).find('.tempTd').attr("rowspan", result[value]);
				}else{
					//hide
					$(this).find('.tempTd').hide();
				}
			})
		}
		
	}
	
	$('.table_wrap_mobile').each(function(){ // 검색된 사원이 없는 table hide
		if($(this).find('tbody tr:visible').length == 0){
			$(this).hide();
		}
	});
	
	if($(".table_wrap_mobile:visible").length > 0){ //검색된 사원중 첫번째 부서명으로 위치 이동
		var offset = $(".chartResultWrap").offset();
	    $('html, body').animate({scrollTop : offset.top- 25}, 400);
	}else{ // 검색결과가 없으면 모든 사원 보여줌
		alert('검색결과가 없습니다.');
		$('.table_wrap_mobile, div[id^=group], tr[id^=person], tr[class^=topGroup]').show();
	}
}

//부서 검색
function pf_orgSearchWithDepName(keyword){
	$('div[id^=group], .table_wrap_mobile').hide();
	$('tr[id^=person]').show();
	$('tbody tr').hide();
	$('div[id^=group], td[id^=group]').each(function(){
		
		if($(this).find('.depName').text().includes(keyword.trim())){ 
			$(this).show();
			$(this).next().show().find('tr').show();
		}
		if($(this).find('.TDdepName').text().includes(keyword.trim())){ 
			var className = $(this).attr('class');	//클래스 가져오기
			className = className.split(' ')[0];
			var selectDiv = $(this).closest("div").show();
			$(selectDiv).show();
			$("."+className).show();
			
			var temp = $(this).html(); // 검색결과 하이라이트
			temp = temp.replaceAll(keyword , '<font class="searchKeyword">'+keyword+'</font>');
			$(this).html(temp);
		}
	});
	
	if(($("tr[class^=topGroup]:visible").length > 0) || ($("div[id^=group]:visible").length > 0)){ //검색된 부서 첫번째 부서명으로 위치 이동
		var offset = $(".chartResultWrap").offset();
	    $('html, body').animate({scrollTop : offset.top - 25}, 400);
	}else{ // 검색결과가 없으면 모든 사원 보여줌
		alert('검색결과가 없습니다.');
		$('.table_wrap_mobile, div[id^=group], tr[id^=person], tr[class^=topGroup]').show();
	}
}
</script>
<!-- 본문 시작 -->
            <div class="subContentInner">
                <div class="organiztionCharWrap"> <!-- 조직도 시작 -->
                    <div class="organiChartBox"> <!-- 조직도 차트 -->
                    	 <div class="topOneName">
		                  	<h2>
	                          <a href="javascript:;" onclick="pf_orgSearch('${orgLeader.DN_NAME}');">${orgLeader.DN_NAME }</a>
	                     	</h2>
               			 </div>
                    		
                   		<div class="subOrganiBox">
                            <c:forEach items="${orgList }" var="model">
                            	<c:if test="${orgLeader.DN_KEYNO eq model.DN_MAINKEY}">
                            		<div class="one">
		                            	<h2>
		                                	<a href="javascript:;" onclick="pf_orgSearch('${model.DN_NAME}');">${model.DN_NAME }</a>
		                                </h2>
		                                <ul class="organiSubUl">
	                                		<c:forEach items="${orgList }" var="model2">
	                                			<c:if test="${model.DN_KEYNO eq model2.DN_MAINKEY}">
	                                				<li><a href="javascript:;" onclick="pf_orgSearch('${model2.DN_NAME}');">${model2.DN_NAME }</a></li>	          
	                                			</c:if>
	                                		</c:forEach>
		                                </ul>
		                            </div>
                            	</c:if>
	                        </c:forEach> 
                   		</div>
                    </div>
                    <div class="chartResultWrap"> <!-- 차트 내용 보여주는곳 -->
                        <div class="boardTopWrap">
                            <div class="searchBox orgaSearchBox">                            
                                <label for="searchCondition" class="labelSearch">직원검색</label>
                                <select class="selectDefault searchSelect" name="searchCondition" id="searchCondition" title="검색 할 내용 선택">
						            <option value="A">이름</option>
						            <option value="B">연락처</option>
						            <option value="C">담당업무</option>
						            <option value="D">소속</option>
					            </select>
					            <label for="searchKeyword" class="blind">검색어를 입력하세요</label>
					            <input type="text" class="txtDefault txtSearch" placeholder="검색어를 입력해주세요" name="searchKeyword" id="searchKeyword" onkeydown="if(event.keyCode == 13) pf_orgSearch();" title="검색어를 입력해주세요"/>
           						<button type="button" class="btnDefault btnSizeSearch btnBgBlue" onclick="pf_orgSearch();">검색</button>
                            </div>
                        </div>
                        
                        <!-- 원장 -->
                        	<div class="orgaTableBox">
                        		<fmt:parseNumber value="${fn:substring(orgLeader.DN_KEYNO, 4, 20) }" var="DN_KEYNO_NUMBERTYPE"/>
	                        	<div class="subjextBox" id="group${DN_KEYNO_NUMBERTYPE }">
                            		<h2><font class="depName">${orgLeader.DN_NAME }</font></h2>
	                            </div>
	                            
	                            <div class="tbl_box table_wrap_mobile">
	                            	<table class="tbl_normal tbl_organiztion_01" summary="${orgLeader.DN_NAME } 테이블">
	                                	<caption>${orgLeader.DN_NAME } 테이블</caption>
	                                    <thead>
	                                    	<tr>
	                                        	<th scope="col">소속</th>
	                                        	<th scope="col">직위</th>
	                                        	<th scope="col">이름</th>
	                                        	<th scope="col">연락처</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                    	<c:forEach items="${orgPersonList }" var="Leader">
	                                    		<c:if test="${orgLeader.DN_KEYNO eq Leader.DU_DN_KEYNO }">
	                                    		<fmt:parseNumber value="${fn:substring(Leader.DU_KEYNO, 4, 20) }" var="DU_KEYNO_NUMBERTYPE"/>
		                                    		<tr id="person${DU_KEYNO_NUMBERTYPE }">
		                                    		   	<td class="group">전남정보문화산업진흥원</td>
	  	                                    			<td class="conditionC">${Leader.DU_ROLE }</td>
	  	                                    			<td class="conditionA">${Leader.DU_NAME }</td>
			                                            <td class="conditionB"><span>☎</span> ${Leader.DU_TEL }</td>
		                                    		</tr>
	                                    		</c:if>
	                                    	</c:forEach>
	                                    </tbody>
	                                    <tfoot></tfoot>
	                                </table>
	                            </div>
                        	</div>
                        
                        
                        <!-- 직원들 -->
                        <c:forEach items="${orgList }" var="model"> 
                        	<c:if test="${orgLeader.DN_KEYNO eq model.DN_MAINKEY}">
                        	<fmt:parseNumber value="${fn:substring(model.DN_KEYNO,4,20) }" var="DN_KEYNO_NUMBERTYPE2"/>
                        	
                        	<div class="orgaTableBox">
	                        	<div class="subjextBox group${ DN_KEYNO_NUMBERTYPE2}" id="group${ DN_KEYNO_NUMBERTYPE2}">
                            		<h2><font class="depName">${model.DN_NAME }</font></h2>
	                            </div>
	                            
	                            <div class="tbl_box table_wrap_mobile">
	                            	<table class="tbl_normal tbl_organiztion_01" summary="${model.DN_NAME } 테이블">
	                                	<caption>${model.DN_NAME } 테이블</caption>
	                                    <thead>
	                                    	<tr>
	                                        	<th width="15%" scope="col">소속</th>
	                                        	<th width="10%" scope="col">직위</th>
	                                        	<th width="10%" scope="col">이름</th>
	                                        	<th width="35%" scope="col">담당업무</th>
	                                        	<th width="20%" scope="col">연락처</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
                                    		<c:if test="${orgLeader.DN_KEYNO eq model.DN_MAINKEY }">
                                  				<c:set value="${count + 1 }" var="count"/>
                                    			<c:forEach items="${orgPersonList }" var="ReprePerson" >
                                    				<c:if test="${ReprePerson.DU_DN_KEYNO eq model.DN_KEYNO}">
	                                    			<fmt:parseNumber value="${fn:substring(ReprePerson.DU_KEYNO,4,20) }" var="DU_KEYNO_NUMBERTYPE"/>
                                    					<tr id="person${DU_KEYNO_NUMBERTYPE}">
                                    						<c:if test="${model.DN_COUNT_DEPARTMENT eq 0  }">
                                    							<c:if test="${count eq 1 }">
                                    								<div>
	                                    							<td rowspan="${model.DN_COUNT }"  class="group conditionD">${model.DN_NAME }</td>
                                    								</div>
	                                    						</c:if>
			  	                                    			<td class="conditionC">${ReprePerson.DU_ROLE }</td>
                                    						</c:if>
                                    						<c:if test="${model.DN_COUNT_DEPARTMENT ne 0  }">
			  	                                    			<td colspan="2" class="conditionC">${ReprePerson.DU_ROLE }</td>
                                    						</c:if>
		  	                                    			<td class="conditionA">${ReprePerson.DU_NAME }</td>
		  	                                    			<td class="text_left conditionC">${ReprePerson.DU_CONTENTS}</td>
				                                            <td class="conditionB">
				                                            <c:if test="${not empty ReprePerson.DU_TEL }">
					                                            <span>☎</span> ${ReprePerson.DU_TEL }
				                                            </c:if>
				                                            </td>
			                                    		</tr>
		                                    			<c:if test="${count1 eq model2.DN_COUNT }">
			                                    			<c:set value="0" var="count"/>
			                                    		</c:if>
                                    				</c:if>
                                    			</c:forEach>
                                    		</c:if>
	                                    	<c:forEach items="${orgList }" var="model2">
	                                    		<c:if test="${model.DN_KEYNO eq model2.DN_MAINKEY }">
	                                    			<fmt:parseNumber value="${fn:substring(model2.DN_KEYNO,4,20) }" var="DN_KEYNO_NUMBERTYPE3"/>
	                                    			<c:set value="0" var="count"/>
		                                    		<c:forEach items="${orgPersonList }" var="person" varStatus="status">
			                                    		<c:if test="${model2.DN_KEYNO eq person.DU_DN_KEYNO}">
			                                    		<fmt:parseNumber value="${fn:substring(person.DU_KEYNO,4,20) }" var="DU_KEYNO_NUMBERTYPE2"/>
				                                    		<c:set value="${count + 1 }" var="count"/>
				                                    		<tr id="person${DU_KEYNO_NUMBERTYPE2}" class="topGroup${DN_KEYNO_NUMBERTYPE3}">
				                                    			<td class="tempTd" style="display: none;">${model2.DN_NAME }</td>
				                                    			<c:if test="${count eq 1 }">
				                                    		   	<td rowspan="${model2.DN_COUNT }" class="topGroup${DN_KEYNO_NUMBERTYPE3} grouptd"  id="group${DN_KEYNO_NUMBERTYPE3 }"><font class="TDdepName">${model2.DN_NAME }</font></td>
				                                    			</c:if>
			  	                                    			<td class="conditionC">${person.DU_ROLE }</td>
			  	                                    			<td class="conditionA">${person.DU_NAME }</td>
			  	                                    			<td class="text_left conditionC">${person.DU_CONTENTS}</td>
					                                            <td class="conditionB">
					                                            	<c:if test="${not empty person.DU_TEL }">
							                                            <span>☎</span> ${person.DU_TEL }
						                                            </c:if>
					                                            </td>
				                                    		</tr>
				                                    		<c:if test="${count eq model2.DN_COUNT }">
				                                    			<c:set value="0" var="count"/>
				                                    		</c:if>
			                                    		</c:if>
		                                    		</c:forEach>
	                                    		</c:if>
	                                    	</c:forEach>
	                                    </tbody>
	                                    <tfoot></tfoot>
	                                </table>
	                            </div>
                        	</div>
                        	</c:if>
                        </c:forEach>
                    
                </div> <!-- 조직도 끝 -->
            </div>
           </div>
            <!-- 본문 끝 -->
