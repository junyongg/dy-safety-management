<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<section id="sub-content" style="padding: 0px;" >
		
		<!-- 슬라이드부분 -->
		<div id="main-slide-box">
			<div class="btn-b prev"><button type="button"><i class="xi-angle-left-thin"></i></button></div>
			<div class="btn-b next"><button type="button"><i class="xi-angle-right-thin"></i></button></div>
			<div class="main-slide-page"></div>
			<ul class="main-slide-ul">
				<c:forEach items="${slide }" var="slide" >
					<li data-title="${slide.MM_TITLE }" data-comment="${slide.MM_COMMENT }">
						
						<c:choose>
							<c:when test="${slide.MM_URL eq ''}">
								<a href="javascript:;">
							</c:when>
							<c:otherwise>
								<a href="${slide.MM_URL}" target="_blank">
							</c:otherwise>
						</c:choose>
						<div class="img-b" style="background-image:url(${slide.FS_PATH});"></div></a>	
					</li>
				</c:forEach>
			</ul>
<!-- 					<div class="circle-btn-b"> -->
<!-- 						<a href="/culture/intro/introduce.do"> -->
<!-- 							<p class="txt"> -->
<!-- 								문화재 연구소 <br> 자세히보기 -->
<!-- 							</p> -->
<!-- 							<button type="button" class="btn" onclick="location.href='/culture/intro/introduce.do'">MORE</button> -->
<!-- 						</a> -->
<!-- 					</div> -->
						
		</div>
		<!-- 슬라이드 부분 끝 -->

	
		<!-- 메인밑에쪽 컨텐츠 -->
		<article class="main-bottom-wrap">
			
			<div class="inner1200">
				
				<div class="col board news"> <!-- 뉴스부분 -->					
					<div class="title-box">
						<h2>NEWS</h2>
						<button type="button" class="more" onclick="location.href='/culture/letter.do'" title="자세히보기"><i class="xi-plus-thin"></i></button>
					</div>

					
					<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=12"/>
				</div> <!-- 뉴스끝 -->
				

				<div class="col board survey"> <!-- 조사현황 -->					
					<div class="title-box">
						<h2>마한 연구동향</h2>
<!-- 						<ul class="tab-in main-survey-tab"> -->
<!-- 							<li class="active"><a href="javascript:;" onclick="setPath('Indi')">지표조사</a></li> -->
<!-- 							<li><a href="javascript:;" onclick="setPath('exca')">시·발굴조사</a></li> -->
<!-- 						</ul> -->
						<button type="button" class="more" onclick="location.href='/culture/business/mahayungu.do'" title="자세히보기"><i class="xi-plus-thin"></i></button>
					</div>

					<div class="con-box">
						<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=18"/>
					</div>
				</div> <!-- 조사현황 끝 -->
				

				<div class="col book"> <!-- 자료실 -->					
					<div class="title-box">
						<h2>자료실</h2>
						<button type="button" class="more" onclick="location.href='/culture/refer/report.do'" title="자세히보기"><i class="xi-plus-thin"></i></button>
					</div>

					<div class="con-box">
<!-- 						<div class="main-book-up" style="background-image:url('/resources/culture/img/main/img_main_book.jpg')"></div> -->
						<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=16"/>
						
					</div>
				</div> <!-- 자료실 끝 -->

			</div>

		</article>
		<!-- 2020-11-04 추가 메인 컨텐츠 -->
		<div class="jeonnam_culture_new_con">
			<div class="inner1200">

				<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=17"/>
				
				<div class="col youtube">
					<div class="title-box">
						<h2>마한역사문화권 홍보영상</h2>
						<button type="button" class="more" onclick="localtion.href='/culture/business/movie.do'"><i class="xi-plus-thin"></i></button>
					</div>
				
					<div class="main_youtube1_mahan">
						<div class="in">
							<iframe width="100%" height="100%" src="https://www.youtube.com/embed/uV4DE0qdKeY" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen=""></iframe>
						</div>
					</div>
				</div>


				<div class="col mahan">
					<a href="/culture/business/mahasa1.do"><img src="/resources/img/main/new/mahan_link.jpg" alt="고려 강대한 해상왕국 마한"></a>
				</div>

			</div>
		</div>

	</section>
	
	<script type="text/javascript">
// var nextpath = '/culture/search/Indi.do'; //지표조사
//  /culture/search/exca.do    //시발굴조사


// function setPath(key){
// 	switch (key) {
// 	case "Indi":
// 	 nextpath = '/culture/search/Indi.do';
// 	 break;
	 
// 	case "exca":
// 	 nextpath = '/culture/search/exca.do';
// 	 break;
	
// 	default:
// 	 break;
// 	}
// }

// function nextBoard(){
// location.href=nextpath;
// }

</script>