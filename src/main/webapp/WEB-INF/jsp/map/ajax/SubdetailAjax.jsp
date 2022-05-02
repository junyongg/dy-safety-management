<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
    
    <c:if test="${not empty SubresultData }">
    		
		  <c:set var="FOLDER" value="${SubFileSubList[0].FS_FOLDER }"/>
		  <c:set var="CHANGENM" value="${SubFileSubList[0].FS_CHANGENM }"/>
		  <c:set var="EXT" value="${SubFileSubList[0].FS_EXT }"/>
		  <c:set var="ORINM" value="${SubFileSubList[0].FS_ORINM }"/>
	      
          <div class="img_box" style="background-image:url('/resources/img/upload/${FOLDER}${CHANGENM }.${EXT }" alt="${ORINM }')"></div>
          <div class="txt_box">
              <div class="title">
                  <h2>${SubresultData.MMS_TITLE }</h2>
                  <h5></h5>
              </div>
              <ul class="detail_ul">
                  <li>
                      <p class="cate">분류</p>
                      <p class="con">${SubresultData.MMS_TYPE }</p>
                  </li>
                  
                  <c:if test="${SubresultData.MMS_TYPE ne '기타' }">
                   <c:if test="${not empty SubresultData.MMS_SIZE }"> 
	                   <li>
	                       <p class="cate">규격</p>
	                       <p class="con">${SubresultData.MMS_SIZE }</p>
	                   </li>
                   </c:if>
                   <c:if test="${not empty SubresultData.MMS_MATERIAL }">
	                   <li>
	                       <p class="cate">소재</p>
	                       <p class="con">${SubresultData.MMS_MATERIAL }</p>
	                   </li>
                   </c:if>
                   <c:if test="${not empty SubresultData.MMS_INSTALL }">
	                   <li>
	                       <p class="cate">설치일</p>
	                       <p class="con">${SubresultData.MMS_INSTALL }</p>
	                   </li>
                   </c:if>
                  </c:if>
                  
                  <c:if test="${SubresultData.MMS_TYPE eq '기타' }">
	                  <c:if test="${not empty SubresultData.MMS_TIME }">
		                  <li>
		                      <p class="cate">기간</p>
		                      <p class="con">${SubresultData.MMS_TIME }</p>
		                  </li>
	                  </c:if>
	                  <c:if test="${not empty SubresultData.MMS_AUTHOR }">
		                  <li>
		                      <p class="cate">참여작가</p>
		                      <p class="con">${SubresultData.MMS_AUTHOR }</p>
		                  </li>
	                  </c:if>
	              </c:if>
	                 <c:if test="${not empty SubresultData.MMS_ADDRESS }">
	                  <li>
	                      <p class="cate">상세주소</p>
	                      <p class="con">${SubresultData.MMS_ADDRESS }</p>
	                  </li>
	                 </c:if>
	                 <c:if test="${not empty SubresultData.MMS_CONTENT }">
	                  <li>
	                      <p class="cate">간단설명</p>
	                      <p class="con">${SubresultData.MMS_CONTENT}</p>
	                  </li>
                  	</c:if>
              </ul>
          </div>

          
           <script>
           $(function(){
           		$("#MMS_KEYNO").val('${SubresultData.MMS_KEYNO }');
           		$("#Allnum").val('${Allnum }');
           		$("#youtubeFrame").attr("src","https://www.youtube.com/embed/"+'${youtubeLink }')
           		alert("${SubresultData.MMA_AREA }");
           		$("#shareSns").attr("onclick","popUp_sns01_show('" + "http://jncf.or.kr/map/prc_map.do?area=${SubresultData.MMA_AREA }" + "')")
           		$("#shareText").text("http://jncf.or.kr/map/prc_map.do?area=${SubresultData.MMA_AREA }")
           });
          </script>
         </c:if>
         <c:if test="${empty SubresultData }">
         	작품이 등록되지 않았습니다.
         </c:if>
         