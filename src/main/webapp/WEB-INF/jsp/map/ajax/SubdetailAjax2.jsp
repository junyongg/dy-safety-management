<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
    <c:if test="${not empty SubresultData }">
    			<!-- 탭 제목 버튼 -->
	            <div class="detail_in_title_box">
	                <button type="button" class="btn_tabSl prev" title="이전 버튼" onclick="MovePage('${SubresultData.MMA_X_LOCATION}','${SubresultData.MMA_Y_LOCATION}','type','pre');">
	                    <span class="circle"><i class="xi-angle-left"></i></span>
	                    <span class="txt">이전</span>
	                </button>
	                <button type="button" class="btn_tabSl next" title="다음 버튼" onclick="MovePage('${SubresultData.MMA_X_LOCATION}','${SubresultData.MMA_Y_LOCATION}','type','next');">
	                    <span class="txt">다음</span>
	                    <span class="circle"><i class="xi-angle-right"></i></span>
	                </button>
	                
	                <h2>${SubresultData.MMS_TITLE }</h2>
	            </div>
	
	            <!-- 탭 상세내용 -->
	            <div class="explain_box">
	                <ul class="detail_info_list">
	                    <c:if test="${not empty SubresultData.MMS_TYPE}">
		                    <li>
			                      <p class="cate">분류</p>
			                      <p class="con">${SubresultData.MMS_TYPE }</p>
			                </li>
		                </c:if>
		                <c:if test="${SubresultData.MMS_TYPE ne '기타' }">
		                	<c:if test="${not empty SubresultData.MMS_SIZE}">
				                <li>
				                       <p class="cate">규격</p>
				                       <p class="con">${SubresultData.MMS_SIZE }</p>
				                </li>
			            	</c:if>
			            	<c:if test="${not empty SubresultData.MMS_MATERIAL}">
				                <li>
				                       <p class="cate">소재</p>
				                       <p class="con">${SubresultData.MMS_MATERIAL }</p>
				                </li>
			            	</c:if>
			            	<c:if test="${not empty SubresultData.MMS_INSTALL}">
				                <li>
				                       <p class="cate">설치일</p>
				                       <p class="con">${SubresultData.MMS_INSTALL }</p>
				                </li>
			            	</c:if>
		                </c:if>
		                  
		                <c:if test="${SubresultData.MMS_TYPE eq '기타' }">
		                	<c:if test="${not empty SubresultData.MMS_TIME}">
				                <li>
				                      <p class="cate">기간</p>
				                      <p class="con">${SubresultData.MMS_TIME }</p>
				                </li>
				            </c:if>
				            <c:if test="${not empty SubresultData.MMS_AUTHOR}">
				                <li>
				                      <p class="cate">참여작가</p>
				                      <p class="con">${SubresultData.MMS_AUTHOR }</p>
				                </li>
				            </c:if>
		                </c:if>
		                 	<c:if test="${not empty SubresultData.MMS_ADDRESS}">
				                <li>
				                      <p class="cate">상세주소</p>
				                      <p class="con">${SubresultData.MMS_ADDRESS }</p>
				                </li>
				            </c:if>
				            <c:if test="${not empty SubresultData.MMS_CONTENT}">
				                <li>
				                      <p class="cate">설명</p>
				                      <p class="con">${SubresultData.MMS_CONTENT}</p>
				                </li>
				            </c:if>

	                </ul>
	            </div>
	
	            <!-- 사진 슬라이드 -->
	            <div class="slide_box">
	                <!-- 일반슬라이드 -->
	                <div class="lb_slider">
	                    <div class="swiper-container gallery-main">
	                        <div class="swiper-wrapper">
	                            <c:forEach items="${SubFileSubList }" var="file">
		                            <div class="swiper-slide"><img src="/resources/img/upload/${file.FS_FOLDER}${file.FS_CHANGENM }.${file.FS_EXT }" alt="${file.FS_ORINM }"></div>
	                            </c:forEach>
	                        </div>
	                        <button class="swiper01_btn prev" type="button" title="이전슬라이드"><i class="xi-angle-left-thin"></i></button>
	                        <button class="swiper01_btn next" type="button" title="다음슬라이드"><i class="xi-angle-right-thin"></i></button>
	                    </div>
	                </div>
	                
	                <!-- 썸네일 슬라이드 -->
	                <div class="rb_slider">
	                    <div class="swiper-container gallery-thumbs">
	                        <div class="swiper-wrapper">
	                            <c:forEach items="${SubFileSubList }" var="file">
		                            <div class="swiper-slide"><img src="/resources/img/upload/${file.FS_FOLDER}${file.FS_CHANGENM }.${file.FS_EXT }" alt="${file.FS_ORINM }"></div>
		                        </c:forEach>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            
	            <script>
		            $(function(){
		           		$("#MMS_KEYNO").val('${SubresultData.MMS_KEYNO }');
		           		$("#Allnum").val('${Allnum }');
		           	});
	            
			        var galleryThumbs = new Swiper(".gallery-thumbs", {
			            // loop : true,
			            // centeredSlides: true,
			            centeredSlidesBounds: true,
			            spaceBetween : 1,
			            slidesPerView: 5,
			            watchOverflow: true,
			            watchSlidesVisibility: true,
			            watchSlidesProgress: true,
			            direction: 'vertical',
			            breakpoints: {
			                800 : {
			                    direction: 'horizontal',
			                    slidesPerView: 3,
			                    spaceBetween: 10,
			                }
			            }
			        });
			
			        var galleryMain = new Swiper(".gallery-main", {
			            autoHeight : true,
			            loop: false,
			            watchOverflow: true,
			            watchSlidesVisibility: true,
			            watchSlidesProgress: true,
			            preventInteractionOnTransition: true,
			            navigation: {
			                nextEl: '.swiper01_btn.next',
			                prevEl: '.swiper01_btn.prev',
			            },
			            effect: 'fade',
			            fadeEffect: {
			                crossFade: true
			            },
			            thumbs: {
			                swiper: galleryThumbs
			            }
			        });
			    </script>
	            <!-- // 사진 슬라이드 -->
         </c:if>
         <c:if test="${empty SubresultData }">
         	작품이 등록되지 않았습니다.
         </c:if>