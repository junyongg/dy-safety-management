<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
 <!------------------------------------------------------------------------
    		 main Slide START   메인 슬라이드 시작
	------------------------------------------------------------------------->
    <div class="mainSlideWrap">
    
    	<div class="inner1080">
        	
            <div class="mobileSlideLetterBox"> <!-- 모바일 슬라이드 글씨 -->
            	<div class="subjectBox" id="mobile_title">
                	<c:forEach items="${mainSlideList }" var="slideList" varStatus="status">
                		<c:if test="${status.first }">
                			${slideList.MM_TITLE }
               			</c:if>
                	</c:forEach>
                </div>
                <div class="btnBox">
                	<button type="button" class="mobileSlideBtnPrev"><i class="fas fa-angle-left"></i></button>
                	<button type="button" class="mobileSlideBtnPause"><i class="fas fa-pause"></i></button>
                	<button type="button" class="mobileSlideBtnNext"><i class="fas fa-angle-right"></i></button>
                </div>
            </div> <!-- 모바일 슬라이드 글씨 끝 -->
            
        	<div class="slideLetterBox">
            	<h2 id="main_title">
                	<c:forEach items="${mainSlideList }" var="slideList" varStatus="status">
                		<c:if test="${status.first }">
                			${slideList.MM_TITLE }
               			</c:if>
                	</c:forEach>
                </h2>
                <div class="btnBoxWrap">
                	<button type="button" class="mainSlidePrevBtn">PREV</button>
                	<div class="innerLine clearfix">
                    	<div class="circle_1 leftOne "></div>
                    	<div class="circle_1 middleOne redOne"></div>
                    	<div class="circle_1 rightOne "></div>
                    </div>
                	<button type="button" class="mainSlideNextBtn">NEXT</button>
                </div>
                <h4 id="main_comment">
                	<c:forEach items="${mainSlideList }" var="slideList" varStatus="status">
                		<c:if test="${status.first }">
                			${slideList.MM_COMMENT }
               			</c:if>
                	</c:forEach>
                </h4>
                <div class="mainSlidePagerBox">
                    <ul class="mainSlidePagerUl" id="mainSliderPager">
                   		<c:forEach items="${mainSlideList }" var="slideList">
                   		<li class="circleBox" id="circleBox">
                       		<a data-slide-index="${slideList.COUNT-1 }"  href="javascript:;"></a>
                      	</li>
  						</c:forEach>
                     </ul>
                </div>
            </div>
        	<div class="mainSlideImgBox">
            	<ul class="mainSlideUl_01" id="bxslider1">
            		<c:forEach items="${mainSlideList }" var="slideList">
            			<fmt:parseNumber value="${fn:substring(slideList.MM_KEYNO,5,20) }" var="key"/>
                		<li data-title="${slideList.MM_TITLE }" data-comment="${slideList.MM_COMMENT }">
                			<a href="${slideList.MM_URL }" title="${slideList.MM_TITLE }" target="_blank">
                				<img src="/resources/img/upload/${slideList.THUMBNAIL_PATH }" alt="슬라이드 이미지"  title="${slideList.MM_TITLE }">
							</a>
               			</li>
            		</c:forEach>
                </ul>
            </div>
        </div>
        
    </div>
    <!------------------------------------------------------------------------
    		 main Slide END   메인 슬라이드 끝
	------------------------------------------------------------------------->
    
    
    
    <!------------------------------------------------------------------------
    		 mainContents START   메인 콘텐츠 내용1
	------------------------------------------------------------------------->
    
    <div class="mainContents01Wrap" id="contents_start"> <!-- 메인컨텐츠 시작 -->
    	<div class="inner1080">
        

            <div class="mainNoticeWrap"> <!-- 공지사항 시작 -->
                <div class="titleBox">
                    <h1>ISSUE & NOTICE <span>JCIA</span></h1>
                    <h5>전남정보문화산업진흥원의 주요 소식을 이곳에서 확인하세요.</h5>
                </div>
                <div class="noticeRealWrap">
                    <div class="moreBtnBox">
                        <a id="ViewMore" href="/jcia/information/news.do" title="전체소식 더보기">더보기 <i class="fal fa-plus-square"></i></a>
                    </div>
                    <div class="mainNoticeTabWrap"> <!-- tab -->
                    	<!-- 모바일 버튼 박스 -->
                        <button type="button" class="btnNoticeSlideMobilePrev"><i class="fal fa-angle-left"></i></button>
                        <button type="button" class="btnNoticeSlideMobileNext"><i class="fal fa-angle-right"></i></button>
                        <!-- 모바일 버튼 박스 끝 -->
                        <ul class="mainNoticeTab" id="mobileNoticeTab">
                            <li class="active" data-url="/jcia/information/news.do" data-title="전체소식 더보기">
                                <a href="javascript:;">전체소식</a>
                            </li>
                            <li data-url="/jcia/information/business.do" data-title="사업공고 더보기">
                                <a href="javascript:;">사업공고</a>
                            </li>
                            <li data-url="/jcia/information/tender.do" data-title="입찰공고 더보기">
                                <a href="javascript:;">입찰공고</a>
                            </li>
                            <li data-url="/jcia/information/employ.do" data-title="채용공고 더보기">
                                <a href="javascript:;">채용공고</a>
                            </li>
                        </ul>
                    </div> <!-- tab 끝 --> 
                    
                    
                    <div class="mainNoticeConWrap mainNoticeTabCon"> <!-- 전체소식 -->
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                    </div> <!-- 전체소식 끝 -->
                        
                        
                    <div class="mainNoticeConWrap mainNoticeTabCon"> <!-- 사업공고 -->
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[사업공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[사업공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[사업공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[사업공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[사업공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[사업공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                    </div> <!-- 사업공고 끝 -->
                        
                        
                    <div class="mainNoticeConWrap mainNoticeTabCon"> <!-- 입찰공고 -->
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[입찰공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[입찰공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[입찰공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[입찰공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[입찰공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[입찰공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                    </div> <!-- 입찰공고 끝 -->
                        
                        
                    <div class="mainNoticeConWrap mainNoticeTabCon"> <!-- 채용공고 -->
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[채용공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[채용공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[채용공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[채용공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                        <div class="row"> <!-- row -->
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[채용공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                            
                            
                            <div class="oneBox">
                                <div class="dateBox">
                                    <h5>2018-01</h5>
                                    <h2>25</h2>
                                </div>
                                <div class="letterBox">
                                    <a href="javascript:;">
                                        <p class="title">[채용공고 2018-61호]</p>
                                        <p class="content">
                                            여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집
                                        </p>
                                        <p class="attachment">
                                            <span><i class="fal fa-paperclip"></i></span> 여수 기반 빅게임 콘텐츠 개발과정 크리에이터 모집 안내, 과제평가_붙임
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </div> <!-- row End -->
                        
                    </div> <!-- 채용공고 끝 -->
                </div>
                 <div class="mouseIconWrap">
                    <h3>Down</h3>
                    <div class="iconWrap wow bounce">
                        <a href="javascript:;" onclick="pf_DownMove();"></a>
                    </div>
                </div>
            </div> <!-- 공지사항 끝 -->
        
            
        	<div class="mainContenMiddleUpWrap" id="contents_start2"> <!-- 메인컨텐츠 1 시작 -->
        
                <div class="row_1 upBox"> <!-- row 1 시작 -->
                    <div class="box01 boxSame majorBusi">
                            <h2>주요사업</h2>
                            <h5>
                                전남정보문화산업진흥원<br>
                                주요사업을 <br>
                                알려드립니다.
                            </h5>
                            <a href="/jcia/information/business.do">
                            <div class="btnBox">
                                <span>▶</span> 주요사업 안내 바로가기
                            </div>
                            </a>
                    </div>
                    <div class="box01 boxSame comeHow">
                        <a href="/jcia/intro/location.do">
                            <h2>찾아오시는 길</h2>
                            <h5>
                                전남정보문화산업진흥원<br>
                                오시는 길을<br>
                                알려드립니다.
                            </h5>
                            <div class="iconBox">
                                <img src="/resources/jcia/img/icon/icon_main_bus_01.png" alt="버스아이콘">
                            </div>
                        </a>
                    </div>
                    <div class="box01 row4menu">
                        <ul class="mainMiddleContentUl_01 clearfix">
                            <li onclick="pf_popupOpen('E');">
                                <a href="javascript:;">
                                    <div class="iconBox icon01"></div>
                                    <div class="letterBox">
                                        <h4>전문가<br>DB등록</h4>
                                    </div>
                                </a>
                            </li>
                            <li onclick="pf_popupOpen('N');">
                                <a href="javascript:;">
                                    <div class="iconBox icon02"></div>
                                    <div class="letterBox">
                                        <h4>뉴스레터<br>신청</h4>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="/jcia/agora/survey.do">
                                    <div class="iconBox icon03"></div>
                                    <div class="letterBox">
                                        <h4>설문참여</h4>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="/jcia/agora/inquiry.do">
                                    <div class="iconBox icon04"></div>
                                    <div class="letterBox">
                                        <h4>문의하기</h4>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div> <!-- row 1 끝 -->
            
                <div class="row_1 downBox"> <!-- row 1 시작 -->
                
                    <div class="box01 menuArrowBox">
                        <ul class="mainMiddleContentUl_02">
                            <li>
                                <a href="/jcia/agora/customer.do">고객만족경영</a>
                            </li>
                            <li>
                                <a href="/jcia/agora/ethics.do">윤리경영</a>
                            </li>
                            <li>
                                <a href="/jcia/agora/operate.do">경영공시</a>
                            </li>
                            <li>
                                <a href="https://www.redwhistle.org/report/reportNew.asp?organ=1196">청렴신문고</a>
                            </li>
                            <li>
                                <a href="/jcia/agora/contact.do">계약정보공개</a>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="box01 row2menu clearfix">
                        <div class="one_1 orangeBg">
                            <a href="/jcia/agora/customer.do">
                                <h2>고객광장</h2>
                                <h5>고객의 의견을<br> 듣습니다.</h5>
                                <div class="iconBox">
                                    <img src="/resources/jcia/img/icon/icon_main_handShake_1.png" alt="악수 아이콘">
                                </div>
                            </a>
                        </div>
                        <div class="one_1 brownBg">
                            <a href="javascript:;">
                                <h2>시설안내</h2>
                                <h5>JCIA 시설을 <br>소개합니다.</h5>
                                <div class="iconBox">
                                    <img src="/resources/jcia/img/icon/icon_main_building_1.png" alt="빌딩 아이콘">
                                </div>
                            </a>
                        </div>
                    </div>
                    
                    <div class="box01 menuWhitewBox">
                        <ul class="mainMiddleContentUl_03 clearfix">
                            <li>
                                <a href="/jcia/facility/regionfacility.do">지역별 시설안내</a>
                            </li>
                            <li>
                                <a href="/jcia/facility/operatingfacility.do">운영시설</a>
                            </li>
                            <li>
                                <a href="/jcia/facility/enterprisefacility.do">기업입주시설</a>
                            </li>
                        </ul>
                    </div>
                </div> <!-- row 1 끝 -->
            
            </div> <!-- 메인컨텐츠 1 끝 -->
			
            
            <div class="mobileMainContent_01"> <!-- 모바일 메인 컨텐츠 -->
            	<div class="title_01 contactGuestTitle">
                	<a href="javascript:;">고객광장 <i class="fal fa-angle-down"></i></a>                    
                    <div class="contentBox">
                        <ul>
                            <li><a href="/jcia/agora/customer.do">고객만족경영</a></li>
                            <li><a href="/jcia/agora/ethics.do">윤리경영</a></li>
                            <li><a href="/jcia/agora/operate.do">경영공시</a></li>
                            <li><a href="https://www.redwhistle.org/report/reportNew.asp?organ=1196">청렴신문고</a></li>
                            <li><a href="/jcia/agora/contact.do">계약정보공개</a></li>
                        </ul>
                    </div>
                </div>
            	<div class="title_01 buildingGuideTitle">
                	<a href="javascript:;">시설안내 <i class="fal fa-angle-down"></i></a>
                    <div class="contentBox">
                        <ul>
                            <li><a href="/jcia/facility/regionfacility.do">지역별 시설안내</a></li>
                            <li><a href="/jcia/facility/operatingfacility.do">운영시설</a></li>
                            <li><a href="/jcia/facility/enterprisefacility.do">기업입주시설</a></li>
                        </ul>
                    </div>
                </div>
            </div> <!-- 모바일 메인 컨텐츠 끝 -->
            
            
            
            <div class="mainContentMiddleRinkWrap"> <!-- 메인 링크 -->
            	<ul class="mainContentRinkUl upRinkBox">
                	<li>
                    	<a href="http://www.jnscc.or.kr/" target="_blank">
                        	<p>목포벤처문화산업지원센터</p>
                            <div class="btnBox"></div>
                        </a>
                    </li>
                	<li>
                    	<a href="http://www.jncontents.com/" target="_blank">
                        	<p>전남콘텐츠닷컴</p>
                            <div class="btnBox"></div>
                        </a>
                    </li>
                	<li>
                    	<a href="http://www.jcopyright.or.kr/" target="_blank">
                        	<p>전남저작권서비스센터</p>
                            <div class="btnBox"></div>
                        </a>
                    </li>
                	<li>
                    	<a href="http://www.ogamtong.com/" target="_blank">
                        	<p>전남음악창작소</p>
                            <div class="btnBox"></div>
                        </a>
                    </li>
                </ul>
                
            	<ul class="mainContentRinkUl downRinkBox">
                	<li>
                    	<a href="http://eswcc.kr/" target="_blank">
                        	<p>광주ㆍ전남 SW융합클러스터</p>
                            <div class="btnBox"></div>
                        </a>
                    </li>
                	<li>
                    	<a href="javascript:;" target="_blank">
                        	<p>설화DB시스템</p>
                            <div class="btnBox"></div>
                        </a>
                    </li>
                	<li>
                    	<a href="http://jeonnam.work.go.kr/" target="_blank">
                        	<p>전남ICT워크넷</p>
                            <div class="btnBox"></div>
                        </a>
                    </li>
                	<li>
                    	<a href="https://www.ckl.or.kr/ckl/main/main.do" target="_blank">
                        	<p>전남콘텐츠코리아랩</p>
                            <div class="btnBox"></div>
                        </a>
                    </li>
                </ul>
            </div>  <!-- 메인 링크 끝 -->
            
        </div>
    </div> <!-- 메인컨텐츠 끝 -->
    
    
    <!------------------------------------------------------------------------
    		 mainContents END   메인 콘텐츠 내용1 끝
	------------------------------------------------------------------------->
    
    
    
    <!------------------------------------------------------------------------
    		 mainSNSContentWrap Start   메인 sns 콘텐츠 내용
	------------------------------------------------------------------------->
    <div class="mainSnsContentWrap">
    	<div class="inner1080"> <!-- inner 시작 -->
        
        	<div class="mainSnsTitleBox">
            	<h2>COMMUNICATION <span>JCIA</span></h2>
                <h5>함께 소통하고 공감하는 전남정보문화산업진흥원</h5>
            </div>
            
            <div class="mainSnsContentBox">
            	<ul class="clearfix">
            		<c:forEach items="${boardThumbnail }" var="model">
            			<fmt:parseNumber value="${fn:substring(model.BN_KEYNO,4,20) }" var="boardkey"/>
            			<c:if test="${not empty model.THUMBNAIL_PATH }">
		                	<li><a href="javascript:;" onclick="pf_boardPromoteLink('${boardkey}');"><img src="/resources/img/upload/${model.THUMBNAIL_PATH }" alt="보도자료 이미지" width="264" height="160"></a></li>            			
            			</c:if>
            			<c:if test="${empty model.THUMBNAIL_PATH }">
		                	<li><a href="javascript:;" onclick="pf_boardPromoteLink('${boardkey}');"><img src="/resources/jcia/img/img_main_bottom_01.jpg" alt="보도자료 이미지" width="264" height="160"></a></li>            			
            			</c:if>
            		</c:forEach>
                </ul>
            </div>
            
            <div class="mainSnsSlideWrap">
                <div class="bgBlueColor"></div>
                <div class="bgSkyColor"></div>
            	<div class="innerBox clearfix">
                	<div class="nameBox">
                    	<button type="button">
                            JCIA<br>SNS
                        </button>
                    </div>
                    <div class="snsIconBox">
                    	<ul>
                        	<li>
                            	<a href="https://www.facebook.com/withjcia/" target="_blank"><img src="/resources/jcia/img/icon/icon_Sns_01-02.png" alt="facebook"></a>
                            </li>
                        	<li>
                            	<a href="javascript:;" target="_blank"><img src="/resources/jcia/img/icon/icon_Sns_01-03.png" alt="twitter"></a>
                            </li>
                        	<li>
                            	<a href="javascript:;" target="_blank"><img src="/resources/jcia/img/icon/icon_Sns_01-04.png" alt="instagram"></a>
                            </li>
                        	<li>
                            	<a href="javascript:;" target="_blank"><img src="/resources/jcia/img/icon/icon_Sns_01-05.png" alt="youtube"></a>
                            </li>
                        </ul>
                    </div>
                    <div class="closeBtnBox">
                    	<button type="button"><i class="fal fa-times"></i></button>
                    </div>
                </div>
            </div>
        
        </div> <!-- inner 시작 끝 -->
    </div>
    <!------------------------------------------------------------------------
    		 mainSNSContentWrap END   메인 sns 콘텐츠 내용 끝
	------------------------------------------------------------------------->
    
    
    <!------------------------------------------------------------------------
    		 mainBottomBanner Start   메인 밑에 배너 시작
	------------------------------------------------------------------------->
    <div class="mainBottomBannerWrap">
        <div class="inner1080">
        	<div class="mainBannerBtnPrev">
            	<a href="javascript:;"><img src="/resources/jcia/img/icon/icon_mainBannerArrow_prev.png" alt="이전버튼"></a>
            </div>
            <div class="mainBannerBSlideBox">
            	<ul class="clearfix" id="bxslider2">
            		<c:forEach items="${mainBannerList }" var="model" varStatus="status">
            			<li >
		            		<c:if test="${status.index eq 0}">
		            			<c:set var="firstImg" value="/resources/img/upload/${model.THUMBNAIL_PATH }"/>
		            		</c:if>
		            		<c:if test="${status.index lt 5}">
		            			<a href="${model.BM_URL }" target="_blank" title="${model.BM_TITLE }로 이동">
			                		<img style="width:150px;height:37px; margin: 0 auto;" src="/resources/img/upload/${model.THUMBNAIL_PATH }" alt="${model.BM_TITLE }"/>
			                	</a>
		            		</c:if>
		            		<c:if test="${status.index ge 5}">
		            		<fmt:parseNumber value="${fn:substring(model.BM_KEYNO, 4, 20)}" var="BM_KEYNO" />
		            			<a href="${model.BM_URL }" target="_blank" title="${model.BM_TITLE }로 이동">
			                		<img class="bannerImg${BM_KEYNO}" style="width:150px;height:37px; margin: 0 auto;" src="${firstImg }" alt="${model.BM_TITLE }"/>
			                	</a>
		            		</c:if>
		                </li>
            		</c:forEach>
                </ul>
            </div>
        	<div class="mainBannerBtnNext">
            	<a href="javascript:;"><img src="/resources/jcia/img/icon/icon_mainBannerArrow_next.png" alt="다음버튼"></a>
            </div>
        </div>
    </div>    
    <!------------------------------------------------------------------------
    		 mainBottomBanner END   메인 밑에 배너 시작
	------------------------------------------------------------------------->
