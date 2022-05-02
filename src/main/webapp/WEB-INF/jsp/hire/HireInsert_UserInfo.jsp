<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script type="text/javascript" src="/resources/culture/js/jquery-2.0.2.min.js"></script>


<form:form id="form" method="post" action="">
<section id="sub-content">
		<!-- 아이디(이메일 찾기) -->
	<div class="mem-search-pop" style="">
		<div class="top-b">
			<h2>회원정보 찾기</h2>
		</div>
		<div class="con-b">
			<div class="join-box">
				<p class="p-t"><label for="jo-se-mail">이름 <span class="red-c">*</span></label></p>
				<div class="jo-row">
					<input type="text" class="txtDefault txtWlong_1" id="TH_USER" name="TH_USER">
				</div>
				
				<p class="p-t"><label for="jo-se-mail">게시물 키값 <span class="red-c">*</span></label></p>
				<div class="jo-row">
					<input type="text" class="txtDefault txtWlong_1" id="TH_BNKEYNO" name="TH_BNKEYNO">
				</div>
			</div>
		</div>
		<div class="btn-b">
			<button type="button" class="login-btn2" onclick="showUserinfo();">확인</button>
		</div>
	</div>
	</section>
</form:form>
	
	
<script type="text/javascript">

	function showUserinfo(){
		$.ajax({
			type: "post",
			url : "/hire/userInfo2.do",
			data :  $('#form').serializeArray(),
			success: function(data){
				console.log(data.TH_EMAIL)
				console.log(data.TH_PASSWORD)
			},
			error: function(){
				alert("에러");
			}
		});
	}

</script>
	
