<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<!-- 풋터 -->
	<footer id="ft" style="padding-top: 20px;">
		<div class="inner1200">
			<div class="adr-b">
              <a href="/jact/member/private.do" style="color:gray;">개인정보처리방침</a>    
				<address>
					(재)전라남도문화재단 / 58566) 전라남도 무안군 삼향읍 후광대로 242 전남개발빌딩 13층 / Tel. 061-280-5800 / Fax. 061-280-5850 <br>
					Copyright (C) 2010 ~ 2016 (재)전라남도문화재단 All Right Reserved.  
                  <br>
                  <br>
				</address>
			</div>
			<div class="sel-b">
				<select id="site" class="ft-sel" title="사이트 이동" style="float: left;">
					<option value="/jact/index.do">FAMILY SITE</option>
					<option value="https://www.jeonnam.go.kr/">전남도청</option>
				</select>
              <div style="border:solid 2px gray;float: left;">
                    <button type="button" style="color:gray;padding: 5px;" onclick="go_site()" title="새창으로" >
                		이동
           			</button>
              </div>

			</div>
          <div class="sel-b">
                <img  style="margin-top: 44px;margin-left: 33px;position: absolute;" alt="가족친화 우수기관 마크" src="/resources/img/main/img_subchucachuca.png">
          </div>
            <div class="sel-b">
              <a title="새창" href="http://www.wa.or.kr/board/list.asp?BoardID=0006" target="_blank">
                <img  style="width:100px;height:71px;margin-top: -28px;margin-left: 1106px;" alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)" src="/resources/img/main/ingiyoung.gif"></a>
          </div>
		</div>
	</footer>

<script>
  function go_site(	){
    	window.open($("#site").val());
  }
  </script>