<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


<!doctype html>
<html lang="ko" xml:lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>영문홈페이지</title>
<link rel="shortcut icon" href="favicon/favicon.ico">
<link href="css/rest.css" type="text/css" rel="stylesheet">
<link href="css/slick.css" type="text/css" rel="stylesheet">
<link href="css/layout.css" type="text/css" rel="stylesheet">
<link href="css/main.css" type="text/css" rel="stylesheet">
<link href="css/sub.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="js/jquery-2.0.2.min.js"></script>
<script type="text/javascript" src="js/slick.js"></script>
<script type="text/javascript" src="js/common.js"></script>

</head>

<body>



<div id="wrap"> <!-- wrap -->

	
<!-- 헤더 -->
<header id="hd">
	
	<!-- top -->
	<div class="top">
		<div class="inner1110">
			<ul>
				<li>
					<button type="button" class="btn-home" title="홈으로">
						<i class="xi-home"></i> HOME
					</button>
				</li>
				<li>
					<button type="button" class="btn-lan">
						KOREA
					</button>
					<button type="button" class="btn-lan active">
						ENGLISH
					</button>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- menu -->
	<div class="menu">
		<div class="inner1110">
			<div class="logo-b">
				<a href="javascript:;" class="logo" onclick="browserTop()">
					<img src="resources/img/icon/icon_top_logo.png" alt="전남문화관광재단 로고">
				</a>
			</div>

			<nav>
				<ul id="gnb">
					<li><a href="javascript:;" data="#main-greeting">Greeting</a></li>
					<li><a href="javascript:;" data="#main-intro">Introduction & History</a></li>
					<li><a href="javascript:;" data="#main-vision">Vision and Strategy</a></li>
					<li><a href="javascript:;" data="#main-Major">Major Projects</a></li>
					<li><a href="javascript:;" data="#main-HowTo">How to Find Us</a></li>
				</ul>
			</nav>

			<button type="button" class="btn-moMenu" title="모바일메뉴">
				<i class="xi-bars"></i>
			</button>
		</div>
	</div>
</header>
<!-- 헤더 END -->


<!-- 메인배너 -->
<section id="main-slide-box">
	<div class="img-b" style="background-image: url('resources/img/main/main_top_img.jpg');"></div>
</section>
<!-- 메인배너 끝 -->



<!-- 메인 Greeting -->
<section id="main-greeting" class="sc">
	<div class="inner1110">
		<div class="m-title-box">
			<div class="line-ho"></div>
			<h2>Greeting</h2>
		</div>

		<div class="con-b">
			<p class="pur">
				Flowering in Art and Culture,  Lively with Tourism: South Jeolla Province
			</p>

			<p class="nor">
				Welcome to the home page of JACT, Jeollanam-do Association for Cultural Tourism.
				<br><br>
				We at JACT strive to bring the beauty of Namdo culture by  developing and restoring traditional art and culture of the region, and promoting public awareness toward the goodness of the Namdo culture.
				<br><br>
				And rightly so, we are blessed with the beautiful nature of Namdo and its rich cuisine across the four seasons.<br>
				More than two thous and beautiful islands, wide mudflats, and fresh food from clean nature also make South Jeolla a great tourist destination.
				<br><br>
				The pristine nature of South Jeolla will help heal your mind and body, and restore the joie de vivre of your everyday life. <br><br>

				JACT strives to use the excellence of Namdo’s culture and tourist resources to build a unique system of marketing with focus on art, culture, and tourism.
				<br><br>
				We will do our best to ensure that the people of South Jeolla and its visitors can enjoy a life rich in art and culture, and to bring even more life into the Namdo region with tourism.<br>
				We ask for your support and goodwill as we turn this goal into reality.
			</p>

			<div class="in-logo">
				<img src="resources/img/icon/icon_in_logo.png" alt="logo">
			</div>
		</div>

	</div>
</section>
<!-- 메인 Greeting END -->




<!-- 메인 introduction history -->
<section id="main-intro" class="sc">
	<div class="inner1110">
		
		<div class="m-title-box">
			<div class="line-ho"></div>
			<h2>Introduction & History</h2>
		</div>


		<div class="con-b">
			<p class="nor">
				JACT is an organization supported by the South Jeolla Province to provide systematic support toward the art, culture, and tourist projects in the region, thereby enhancing the quality of life in South Jeolla Province and its cultural tourist capabilities. <br>
				For this purpose, JACT undertakes a variety of projects, including support toward the creation, distribution, and implementation of art and cultural projects, providing assistance toward art and cultural education, everyday cultural projects, research into Cultural Heritages, tourist attraction and marketing, and developing tourist projects
			</p>
		</div>

		<div class="in-white-box">
			<p class="tit">History</p>
			
			<!-- 히스토리탭 -->
			<ul class="tab-history">
				<li><a href="javascript:;">2008 ~ 2014</a></li>
				<li><a href="javascript:;">2015 ~ Now</a></li>
			</ul>

			<!-- 히스토리 내용 -->
			<div class="tab-history-wrap">
				
				<div class="history_year_box tab-history-con"> <!-- 2008 2014 -->
					
					<div class="one">
						<div class="year">2014</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2014. 08. 13.</div>
								<div class="in_txt">Appointment of Kim Chung-gyeong as the eighth Administrative Director</div>
							</div>
							<div class="row">
								<div class="date">2014. 01. 08.</div>
								<div class="in_txt">Opening of the Jeonnam Cultural Property Research Center</div>
							</div>
						</div>
					</div>
					
					<div class="one">
						<div class="year">2013</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2013. 07. 19.</div>
								<div class="in_txt">Appointment of Jeong Gwang-deok as the seventh Administrative Director</div>
							</div>
							<div class="row">
								<div class="date">2013. 07.</div>
								<div class="in_txt">Publication of the first issue of the newsletter “Munhwarang”</div>
							</div>
							<div class="row">
								<div class="date">2013. 04.</div>
								<div class="in_txt">Establishment of Mid- to Long-term Development Plans</div>
							</div>
							<div class="row">
								<div class="date">2013. 02.</div>
								<div class="in_txt">Selection of CI</div>
							</div>
						</div>
					</div>
					
					<div class="one">
						<div class="year">2012</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2012. 12.</div>
								<div class="in_txt">Office expansion</div>
							</div>
							<div class="row">
								<div class="date">2012. 08. 31.</div>
								<div class="in_txt">Appointment of Kim Myeong-won as the sixth Administrative Director</div>
							</div>
						</div>
					</div>
					
					<div class="one">
						<div class="year">2011</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2011. 12. 30.</div>
								<div class="in_txt">Designation as an Organization Dedicated to Arts (South Jeolla Province)</div>
							</div>
							<div class="row">
								<div class="date">2011. 09.</div>
								<div class="in_txt">Reorganization into three teams (Planning and Management Team, Cultural Project Team, Art Support Team)</div>
							</div>
							<div class="row">
								<div class="date">2011. 07. 25.</div>
								<div class="in_txt">Appointment of Cha Joo-gyeong as the fifth Administrative Director</div>
							</div>
							<div class="row">
								<div class="date">2011. 01. 10.</div>
								<div class="in_txt">Appointment of Park Yang-jong as the fourth Administrative Director</div>
							</div>
						</div>
					</div>
					
					<div class="one">
						<div class="year">2010</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2010. 09. 27.</div>
								<div class="in_txt">Appointment of Yoo Dong-soo as the third Administrative Director</div>
							</div>
							<div class="row">
								<div class="date">2010. 08. 01.</div>
								<div class="in_txt">Appointment of Joo Yeong-jin as the second Administrative Director</div>
							</div>
							<div class="row">
								<div class="date">2010. 05. 27.</div>
								<div class="in_txt">Designation as an Art and Culture Education Support Center (Ministry of Culture, Sports and Tourism)</div>
							</div>
							<div class="row">
								<div class="date">2010. 04. 23.</div>
								<div class="in_txt">Designation as a regional overseer of the Cultural Voucher project (Ministry of Culture, Sports and Tourism)</div>
							</div>
							<div class="row">
								<div class="date">2010. 03. 24.</div>
								<div class="in_txt">Transfer of Art and Cultural Promotion Fund and Provincial Korean Traditional Music Group Funding Project to the JACT (from South Jeolla Province)</div>
							</div>
							<div class="row">
								<div class="date">2010. 01.</div>
								<div class="in_txt">Reorganization into two teams (Planning and Management Team, Cultural Project Team)</div>
							</div>
						</div>
					</div>
					
					<div class="one">
						<div class="year">2009</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2009. 09. 14.</div>
								<div class="in_txt">Consignment of Provincial Korean Traditional Music Group and Namdo Art Bank projects to the JACT (from South Jeolla Province)</div>
							</div>
							<div class="row">
								<div class="date">2009. 07.</div>
								<div class="in_txt">Construction of the JACT office and the beginning of operations (1 Administrative Director, 1 Team Director)</div>
							</div>
							<div class="row">
								<div class="date">2009. 07. 31.</div>
								<div class="in_txt">Appointment of Moon In-soo as the first Administrative Director</div>
							</div>
							<div class="row">
								<div class="date">2009. 05. 29.</div>
								<div class="in_txt">Registration of corporation</div>
							</div>
							<div class="row">
								<div class="date">2009. 05. 20.</div>
								<div class="in_txt">Issuance of permit for the corporation</div>
							</div>
							<div class="row">
								<div class="date">2009. 04. 22.</div>
								<div class="in_txt">Founding of the general meeting and board meeting of JACT</div>
							</div>
						</div>
					</div>
					
					<div class="one">
						<div class="year">2008</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2008. 11. 13.</div>
								<div class="in_txt">Enactment of Municipal Ordinance for the Promotion of Art and Culture at South Jeolla Province</div>
							</div>
							<div class="row">
								<div class="date">2008. 05. 16.</div>
								<div class="in_txt">Creation of Plan for Establishment of the JACT by the South Jeolla Province</div>
							</div>
						</div>
					</div>
				</div>
				

				<div class="history_year_box tab-history-con"> <!-- 2015 now -->
						
					<div class="one">
						<div class="year">2019</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2019. 01. 01.</div>
								<div class="in_txt">Appointment of Cho Yong-ik as the first President of JACT</div>
							</div>
						</div>
					</div>

					<div class="one">
						<div class="year">2018</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2018. 08. 20.</div>
								<div class="in_txt">Organizational reform (introduction of the post of President)</div>
							</div>
						</div>
					</div>

					<div class="one">
						<div class="year">2017</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2017. 08. 01.</div>
								<div class="in_txt">Consignment for the operation of Jeonnam International SUMUK Biennale</div>
							</div>
						</div>
					</div>

					<div class="one">
						<div class="year">2016</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2016. 08. 16.</div>
								<div class="in_txt">Relocation of the JACT (from the 11th floor of JNDC Building to the 13th floor)</div>
							</div>
							<div class="row">
								<div class="date">2016. 06. 29.</div>
								<div class="in_txt">Structural reorganization (change in name from Cultural Welfare Team to Art and Cultural Training Support Team)</div>
							</div>
							<div class="row">
								<div class="date">2016. 04. 15.</div>
								<div class="in_txt">JACT launch (founding of the Tourist Marketing Team and Tourist Research and Development Team)</div>
							</div>
							<div class="row">
								<div class="date">2016. 04. 17.</div>
								<div class="in_txt">Name change (from Jeonnam Art and Culture Association to Jeollanam-do Association for Cultural Tourism)</div>
							</div>
						</div>
					</div>

					<div class="one">
						<div class="year">2015</div>
						<div class="right_b">
							<div class="row">
								<div class="date">2015. 12. 06.</div>
								<div class="in_txt">Appointment of film director Im Kwon-taek as an honorary ambassador</div>
							</div>
							<div class="row">
								<div class="date">2015. 07. 27.</div>
								<div class="in_txt">Appointment of Oh Yeong-sang as the ninth Administrative Director</div>
							</div>
							<div class="row">
								<div class="date">2015. 05. 30.</div>
								<div class="in_txt">Opening of Namdo Sori Ullimteo</div>
							</div>
							<div class="row">
								<div class="date">2015. 05. 29.</div>
								<div class="in_txt">Structural reorganization (establishment of Cultural Welfare Team and Performance Hall Operations Team)</div>
							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- 히스토리 내용 END -->
		</div>

	</div>
</section>
<!-- 메인 introduction history END -->




<!-- 메인 Vision -->
<section id="main-vision" class="sc">
	<div class="inner1110">
		<!-- 타이틀 -->
		<div class="m-title-box">
			<div class="line-ho"></div>
			<h2>Vision and Strategy</h2>
		</div>
		
		<!-- 비전내용 -->
		<div class="con-b">
			
			<!-- 미션비전목표정보 -->
			<div class="vision-info-box">							
				<div class="col">
					<div class="icon-b"><img src="resources/img/icon/icon_mission_01.png" alt="아이콘"></div>
					<h2>Mission</h2>
					<div class="line"></div>
					<h4>
						South Jeolla Province <br>
						Promotion of Art, Culture, <br>
						and Tourism
					</h4>
				</div>
				
				<div class="col">
					<div class="icon-b"><img src="resources/img/icon/icon_mission_02.png" alt="아이콘"></div>
					<h2>Vision</h2>
					<div class="line"></div>
					<h4>
						Promoting the Happiness <br>
						of the Province with <br>
						Routinization of Cultural Tourism
					</h4>
				</div>
				
				<div class="col">
					<div class="icon-b"><img src="resources/img/icon/icon_mission_03.png" alt="아이콘"></div>
					<h2>Strategic Target </h2>
					<div class="line"></div>
					<h4>
						Establishing Enjoyable Cultural <br> Tourism for the Five Senses and <br> 
						Establishing a Sustainable Basis <br> for Management
					</h4>
				</div>
			</div>
			<!-- 선 -->
			<div class="vision-line-box">
				<div class="icon"><img src="resources/img/icon/icon_mission_circle.png" alt="아이콘"></div>
			</div>
			<!-- 성과목표 -->
			<div class="target-goal-wrap">
				<div class="topBox">
					<h2>Achievement Goals</h2>
				</div>

				<div class="subBottom purple">
					<ul>
						<li>
							<p>
								Enhancing the satisfaction of <br>
								people in South Jeolla Province
							</p>
						</li>
						<li>
							<p>
								Realizing the social value of <br>
								public service
							</p>
						</li>
						<li>
							<p>
								Establishing an <br>
								employee-friendly workplace
							</p>
						</li>
					</ul>
				</div>
			</div>
			<!-- 선 -->
			<div class="vision-line-box">
				<div class="icon"><img src="resources/img/icon/icon_mission_circle.png" alt="아이콘"></div>
			</div>
			<!-- 전략과제 -->
			<div class="target-goal-wrap">
				<div class="topBox">
					<h2>Strategic Task</h2>
				</div>

				<div class="subBottom white">
					<ul>
						<li>
							<p>
								Sustainable
								Basis of Management
							</p>
						</li>
						<li>
							<p>
								Strengthening the Capacity for
								Art and Culture in South Jeolla
							</p>
						</li>
						<li>
							<p>
								Establishing the Basis for
								South Jeolla’s Tourist Industry
							</p>
						</li>
						<li>
							<p>
								Strengthening Provincial
								Cultural Services
							</p>
						</li>
					</ul>
				</div>
			</div>

		</div> <!-- con END -->

	</div>
</section>
<!-- 메인 Vision END -->





<!-- 메인 Major -->
<section id="main-Major" class="sc">
	<div class="inner1110">
		<!-- 타이틀 -->
		<div class="m-title-box">
			<div class="line-ho"></div>
			<h2>Major Projects</h2>
		</div>
		
		<!-- 메인프로젝트 탭 -->
		<ul class="tab-projects">
			<li class="active"><a href="javascript:;">Art and Cultural Creation Support Project</a></li>
			<li><a href="javascript:;">Art and Cultural Education</a></li>
			<li><a href="javascript:;">Everyday Cultural Project</a></li>
			<li><a href="javascript:;">Cultural Heritage Excavation, Survey, and Preservation</a></li>
			<li><a href="javascript:;">International Tourism Attraction and Marketing</a></li>
			<li><a href="javascript:;">Tourism Policy and Content R&D</a></li>
		</ul>

		<!-- 메인내용1 -->
		<div class="tab-projects-wrap">
			
			<div class="tab-projects-con"><!-- 01 -->
				<div class="in-txt">
					<h4>Art and Cultural Creation Support Project</h4>
					<h5>
						We provide support toward artistic and creative activities of artists and artist groups in South Jeolla Province. 
					</h5>
				</div>
				
				<!-- 슬라이드 박스 -->
				<div class="slide-pojects-box">
					<button type="button" class="btn s01 prev" title="이전">
						<i class="xi-angle-left"></i>
					</button>
					<button type="button" class="btn s01 next" title="다음">
						<i class="xi-angle-right"></i>
					</button>

					<!-- 슬라이드 -->
					<ul class="ja-project1">
						<li><img src="resources/img/main/sub_pojects_01_01.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_01_02.jpg" alt="이미지"></li>
					</ul>
				</div>
			</div>
			
			<div class="tab-projects-con"><!-- 02 -->
				<div class="in-txt">
					<h4>Art and Cultural Education</h4>
					<h5>
						We implement a number of educational projects that seek to promote opportunities of participation for the people of the region and to develop representative brands for regional characteristics by establishing support structures for community-oriented art and cultural education.
					</h5>
				</div>
				
				<!-- 슬라이드 박스 -->
				<div class="slide-pojects-box">
					<button type="button" class="btn s02 prev" title="이전">
						<i class="xi-angle-left"></i>
					</button>
					<button type="button" class="btn s02 next" title="다음">
						<i class="xi-angle-right"></i>
					</button>

					<!-- 슬라이드 -->
					<ul class="ja-project2">
						<li><img src="resources/img/main/sub_pojects_02_01.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_02_02.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_02_03.jpg" alt="이미지"></li>
					</ul>
				</div>
			</div>
			
			<div class="tab-projects-con"><!-- 03 -->
				<div class="in-txt">
					<h4>Everyday Cultural Project</h4>
					<h5>
						We implement a number of infrastructure-building projects intended to facilitate the cultural opportunities for the people of South Jeolla Province, such as cultural sensibility programs, accessibility programs, and cultural diversity support.
					</h5>
				</div>
				
				<!-- 슬라이드 박스 -->
				<div class="slide-pojects-box">
					<button type="button" class="btn s03 prev" title="이전">
						<i class="xi-angle-left"></i>
					</button>
					<button type="button" class="btn s03 next" title="다음">
						<i class="xi-angle-right"></i>
					</button>

					<!-- 슬라이드 -->
					<ul class="ja-project3">
						<li><img src="resources/img/main/sub_pojects_03_01.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_03_02.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_03_03.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_03_04.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_03_05.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_03_06.jpg" alt="이미지"></li>
					</ul>
				</div>
			</div>
			
			<div class="tab-projects-con"><!-- 04 -->
				<div class="in-txt">
					<h4>Cultural Heritage Excavation, Survey, and Preservation</h4>
					<h5>
						We strive to establish a robust system of archaeological research and excavation to provide a system of management and preservation of the cultural heritage of South Jeolla, and to develop new and valuable cultural heritage, such as the Mahan cultural sites at Yeongsangang River.
					</h5>
				</div>
				
				<!-- 슬라이드 박스 -->
				<div class="slide-pojects-box">
					<button type="button" class="btn s04 prev" title="이전">
						<i class="xi-angle-left"></i>
					</button>
					<button type="button" class="btn s04 next" title="다음">
						<i class="xi-angle-right"></i>
					</button>

					<!-- 슬라이드 -->
					<ul class="ja-project4">
						<li><img src="resources/img/main/sub_pojects_04_01.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_04_02.jpg" alt="이미지"></li>
					</ul>
				</div>
			</div>
			
			<div class="tab-projects-con"><!-- 05 -->
				<div class="in-txt">
					<h4>International Tourism Attraction and Marketing</h4>
					<h5>
						We oversee a number of projects designed to attract international tourists to South Jeolla Province with focus on Muan International Airport, cruise tours, and MICE infrastructure.
					</h5>
				</div>
				
				<!-- 슬라이드 박스 -->
				<div class="slide-pojects-box">
					<button type="button" class="btn s05 prev" title="이전">
						<i class="xi-angle-left"></i>
					</button>
					<button type="button" class="btn s05 next" title="다음">
						<i class="xi-angle-right"></i>
					</button>

					<!-- 슬라이드 -->
					<ul class="ja-project5">
						<li><img src="resources/img/main/sub_pojects_05_01.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_05_02.jpg" alt="이미지"></li>
					</ul>
				</div>
			</div>
			
			<div class="tab-projects-con"><!-- 06 -->
				<div class="in-txt">
					<h4>Tourism Policy and Content R&D</h4>
					<h5>
						We implement tourist policy, tourist package development, and training for tourist specialists for the South Jeolla Provincial Government.
					</h5>
				</div>
				
				<!-- 슬라이드 박스 -->
				<div class="slide-pojects-box">
					<button type="button" class="btn s06 prev" title="이전">
						<i class="xi-angle-left"></i>
					</button>
					<button type="button" class="btn s06 next" title="다음">
						<i class="xi-angle-right"></i>
					</button>

					<!-- 슬라이드 -->
					<ul class="ja-project6">
						<li><img src="resources/img/main/sub_pojects_06_01.jpg" alt="이미지"></li>
						<li><img src="resources/img/main/sub_pojects_06_02.jpg" alt="이미지"></li>
					</ul>
				</div>
			</div>

		</div>
		<!-- 메인내용 끝 -->

	</div>
</section>
<!-- 메인 Major END -->




<!-- 메인 How to -->
<section id="main-HowTo" class="sc">
	<div class="inner1110">
		<!-- 타이틀 -->
		<div class="m-title-box">
			<div class="line-ho"></div>
			<h2>How to Find Us</h2>
		</div>
		
		<!-- 오시는길 내용 -->
		<div class="con-b">
			
			<!-- 맵 -->
			<div class="map-box">
				<img src="resources/img/main/img_map_01.jpg" alt="지도">
			</div>

			<!-- 오시는방법 -->

			<div class="come-info-box">
				<p class="sub-in-yellow-title">Contacts</p>
				<div class="line"></div>
				<div class="info-b">
					<div class="icon-box"><img src="resources/img/icon/icon_come_01.png" alt="아이콘"></div>
					<div class="txt-box">
						<div class="in-b">								
							<ul class="dot-ul1">
								<li>Name: Jeollanam-do Association for Cultural Tourism</li>
								<li>Address: 13th floor, JNDC Building, 242, Hugwang-daero, Samhyang-eup, Muan-gun, Jeollanam-do, Republic of Korea 58566 (534-821)  Jeollanam-do Association for Cultural Tourism</li>
								<li>Telephone: +82-61-280-5800</li>
								<li>Fax: +82-61-280-5850</li>
							</ul>
						</div>
						<div class="in-b">								
							<ul class="dot-ul1">
								<li>Name: Jeollanam-do Association for Cultural Tourism</li>
								<li>Address: 13th floor, JNDC Building, 242, Hugwang-daero, Samhyang-eup, Muan-gun, Jeollanam-do, Republic of Korea 58566 (534-821)  Jeollanam-do Association for Cultural Tourism</li>
								<li>Telephone: +82-61-280-5800</li>
								<li>Fax: +82-61-280-5850</li>
							</ul>
						</div>
					</div>
				</div>
			</div>


			<div class="come-info-box">
				<p class="sub-in-yellow-title">Public Transportation</p>
				<div class="line"></div>
				<div class="info-b">
					<div class="icon-box"><img src="resources/img/icon/icon_come_02.png" alt="아이콘"></div>
					<div class="txt-box">
						<p class="sub-arrow-title">Mokpo City Bus lines</p>
						<div class="in-b">								
							<ul class="dot-ul1">
								<li>1-1: Mokpo National Maritime University → Mokpo Station → Bus Terminal → disembark at South Jeolla Office (every 70 min)</li>
								<li>Mokpo National Maritime University Rear Gate → Plaza No. 2 → Plaza No. 3 → Mokpo Christian Hospital → disembark at South Jeolla Office (every 13 min)</li>
								<li>Samhakdo Island → Mokpo Station → Bus Terminal → Mokpo Culture & Sports Center → disembark at South Jeolla Office (every 70 min)</li>
							</ul>
						</div>
						<p class="sub-arrow-title">Regional Bus lines</p>
						<div class="in-b">								
							<ul class="dot-ul1">
								<li>1-1: Mokpo National Maritime University → Mokpo Station → Bus Terminal → disembark at South Jeolla Office (every 70 min)</li>
								<li>Mokpo National Maritime University Rear Gate → Plaza No. 2 → Plaza No. 3 → Mokpo Christian Hospital → disembark at South Jeolla Office (every 13 min)</li>
								<li>Samhakdo Island → Mokpo Station → Bus Terminal → Mokpo Culture & Sports Center → disembark at South Jeolla Office (every 70 min)</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
</section>
<!-- 메인 How to END -->




<!-- 풋터 -->
<footer id="ft">
	<div class="inner1110">
		<address>
			Jeollanam-do Culture & Tourism Foundation / 58566 13th floor, Jeonnam Development Building, 242 Hugwang-daero, Samhyang-eup, Muan-gun, Jeollanam-do, Korea / Tel. 061-280-5800 / Fax. 061-280-5850
			Jeonnam Institute of Cultural Heritage / 58566) 13F, Jeonnam Development Building, 242 Hugwang-daero, Samhyang-eup, Muan-gun, Jeollanam-do, Korea / Tel. 061-287-6802 / Fax. 061-287-6801 <br><br>

			Copyright (C) 2019 Jeollanam-do Culture & Tourism Foundation All Right Reserved.
		</address>		
	</div>
</footer>
<!-- 풋터 끝 -->

</div> <!-- wrap END -->



</body>
</html>
