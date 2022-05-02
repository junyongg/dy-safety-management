<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<c:choose>
	<c:when test="${type eq 'menu' }">
		<div class="re-content re-c-menu" id="menuDirectSearchGo">
            <ul class="re-c-menu-ul">
                <c:forEach items="${menuSearchList }" var="model" varStatus="menuStatus">
               		<li>
               		<a href="${model.MN_URL }"  target="_blank">
	       		  [	<c:forEach items="${fn:split(model.MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
                             	<c:if test="${!nameStatus.last }" >
									${name}&gt;
                    	      	</c:if>
                        	  	<c:if test="${nameStatus.last}">
                          			${name}
                         		</c:if>
                 	</c:forEach> ]
            		</a>
                	</li>
                </c:forEach>
            </ul>
        </div>
		<div class="page-box">
			<ul class="page-ul">
				<ui:pagination paginationInfo="${menuPaginationInfo }" type="normal_jact" jsFunction="pf_linkpage_menu" />
		    </ul>
		</div>
	</c:when>
	<c:when test="${type eq 'page' }">
		<div class="re-content re-c-website" id="pageDirectSearchGo">
	                    <c:forEach items="${PageSearchList }" var="model">
	                        <div class="one">
	                            <div class="address">
	                             [  <c:forEach items="${fn:split(model.PG_MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
			                               <c:if test="${!nameStatus.last }" >
			                               	 ${name}&gt;
			                               </c:if>
			                               <c:if test="${nameStatus.last }">
												${name}
										   </c:if>
	                            	</c:forEach>]
	                            </div>
	                            <div class="info">
	                                <ul>
	                                    <li>작성일 : ${fn:substring(model.MVD_REGDT,0,10) }</li>
	                                </ul>
	                            </div>
	                            <div class="title">
	                                 <a href="${model.MN_URL }" target="_blank">${model.MN_NAME }</a>
	                            </div>
	                            <div class="content">
	                             	  ${model.MVD_DATA }  
	                            </div>
	                        </div>
	                      </c:forEach>
	                   </div>
		<div class="page-box">
			<ul class="page-ul">
				<ui:pagination paginationInfo="${PaginationInfo }" type="normal_jact" jsFunction="pf_linkpage_page" />
		    </ul>
		</div>
	</c:when>
	
	
	
	<c:when test="${type eq 'board' }">
		<div class="re-content re-c-website" id="boardSearchGo">
            <c:forEach items="${boardSearchList }" var="model">
                <div class="one">
                    <div class="address">
                       [<c:forEach items="${fn:split(model.BD_MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
                         <c:if test="${!nameStatus.last }" >
                         	 ${name}&gt;
                         </c:if>
                         <c:if test="${nameStatus.last }">
								${name}
						   </c:if>
						    
                    	</c:forEach>]
                    </div>
                    <div class="info">
                        <ul>
                            <li>작성일 : ${fn:substring(model.BN_REGDT,0,10) }</li>
                        </ul>
                    </div>
                    <div class="title">
                        <a href="/jact/Board/${fn:substring(model.BN_KEYNO,8,15) }/detailView.do" target="_blank">${model.BN_TITLE }</a>
                    </div>
                    <div class="content">
                     	  ${model.BN_CONTENTS }  
                    </div>
                </div>
              </c:forEach>
           </div>
<!-- 		<div class="clear"></div> -->
		<div class="page-box">
			<ul class="page-ul">
				<ui:pagination paginationInfo="${boardPaginationInfo }" type="normal_jact" jsFunction="pf_linkpage_board" />
		    </ul>
		</div>
	</c:when>
	<c:when test="${type eq 'file' }">
	<div class="re-content re-c-website" id="fileSearchGo">
             <c:forEach items="${fileSearchList }" var="model">
                 <div class="one">
                     <div class="address">
                      [  <c:forEach items="${fn:split(model.FS_MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
                          
                          <c:if test="${!nameStatus.last }" >
                          	 ${name}&gt;
                          </c:if>
                          <c:if test="${nameStatus.last }">
								${name}
						   </c:if>
		   
                     	</c:forEach>
                     	]
                     </div>
                     <div class="info">
                         <ul>
                             <li>작성일 : ${fn:substring(model.BN_REGDT,0,10) }</li>
                         </ul>
                     </div>
                     <div class="title">
                         <a href="/jact/Board/${fn:substring(model.BN_KEYNO,8,15) }/detailView.do">${model.BN_TITLE }</a>
                         <button type="button" class="atta-btn" onclick="cf_download('${model.FS_KEYNO}')">
                             <i class="xi-cloud-download"></i>다운로드
                         </button>
                     </div>
                     <div class="content">
                      	  ${model.BN_CONTENTS }  
                     </div>
                 </div>
               </c:forEach>
            </div>
         <div class="page-box">
			<ul class="page-ul">
				<ui:pagination paginationInfo="${filePaginationInfo }" type="normal_jact" jsFunction="pf_linkpage_file" />
		    </ul>
		</div>
	</c:when>
	
</c:choose>