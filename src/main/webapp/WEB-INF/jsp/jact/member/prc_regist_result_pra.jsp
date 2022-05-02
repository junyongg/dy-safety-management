<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>


<div class="joinContentsWrap">   
    <div class="contentsBox2 joinResutBox">
    	<div class="congIntroBoxJoin">
        	<h1>
            	${userInfo.UI_NAME}님<br>
                <span class="colorR">회원가입</span>을 진심으로 <span class="colorR">축하</span>합니다.
            </h1>
        </div>
		<c:if test="${empty Auth}">
	        <table class="tbl_02 tbl_join_01">
	        	<caption>회원가입 정보</caption>
	            <tbody>
	            	<tr>
	                	<th><span>*</span> 아이디</th>
	                	<td><span class="colorR">${userInfo.UI_ID }</span></td>
	                </tr>
	            </tbody>
	        </table>
	        <div class="grayJoinBox">
	        	<h2><span class="colorR">알려드립니다.</span></h2>
	            <ul class="ulDefault">
	            	<li>회원님의 패스워드는 아무도 알 수 없는 암호화 코드로 저장되므로 안심하셔도 좋습니다. 아이디, 패스워드 분실 시에는 회원가입 시 입력하신 이메일 주소를 이용하여 찾을 수 있습니다.</li>
	            	<li>회원 탈퇴는 언제든지 가능하며 일정 기간이 지난 후 회원님의 정보는 자동으로 삭제됩니다.<br> <br> 감사합니다.</li>
	            </ul>
	        </div>
     		</c:if> 
			<c:if test="${not empty Auth && Auth eq 'emailAuth' }">
	        <p class="introSmallJoin">
	        	*관리자페이지 회원관리 - 회원관리 설정 - 웹 에서 회원가입 인증여부가 이메일로 설정되어있어야 이메일이 제대로 전송됩니다.<br>
	        	*회원가입 시 입력하신 이메일 주소로 인증메일이 발송 되었습니다.<br>
	              		발송된 인증메일을 확인하신 후 인증처리를 하시면 사이트를 원활하게 이용하실 수 있습니다.   
	        </p>
	        <table class="tbl_02 tbl_join_01">
	        	<caption>회원가입 정보</caption>
	            <tbody>
	            	<tr>
	                	<th><span>*</span> 아이디</th>
	                	<td><span class="colorR">${userInfo.UI_ID }</span></td>
	                </tr>
	            	<tr>
	                	<th><span>*</span> 이메일주소</th>
	                	<td><span class="colorR">${userInfo.UI_EMAIL }</span></td>
	                </tr>
	            </tbody>
	        </table>
	        <div class="grayJoinBox">
	        	<h2><span class="colorR">알려드립니다.</span></h2>
	            <ul class="ulDefault">
	            	<li>이메일 주소를 잘못 입력하셨다면, 사이트 관리자에게 문의해 주시기 바랍니다.</li>
	            	<li>회원님의 패스워드는 아무도 알 수 없는 암호화 코드로 저장되므로 안심하셔도 좋습니다. 아이디, 패스워드 분실 시에는 회원가입 시 입력하신 이메일 주소를 이용하여 찾을 수 있습니다.</li>
	            	<li>회원 탈퇴는 언제든지 가능하며 일정 기간이 지난 후 회원님의 정보는 자동으로 삭제됩니다.<br> <br> 감사합니다.</li>
	            </ul>
	        </div>
     		</c:if> 
     		<c:if test="${not empty Auth && Auth eq 'phoneAuth' }">
	        <table class="tbl_02 tbl_join_01">
	        	<caption>인증번호</caption>
	            <tbody>
	            	<tr>
	                	<th><span>*</span> 인증번호</th>
	                	<td><input type="text" class="txtDefault txtWlong_1" placeholder="인증번호를 입력하세요."/> <button type="button" class="btn btnBig_02" onclick="javascript:;alert('결제모듈 등록 후 사용가능합니다.');">확인</button></td>
	                </tr>
	            </tbody>
	        </table>
	        <div class="grayJoinBox">
	        	<h2><span class="colorR">알려드립니다.</span></h2>
	            <ul class="ulDefault">
	            	<li>회원님의 패스워드는 아무도 알 수 없는 암호화 코드로 저장되므로 안심하셔도 좋습니다. 아이디, 패스워드 분실 시에는 회원가입 시 입력하신 이메일 주소를 이용하여 찾을 수 있습니다.</li>
	            	<li>회원 탈퇴는 언제든지 가능하며 일정 기간이 지난 후 회원님의 정보는 자동으로 삭제됩니다.<br> <br> 감사합니다.</li>
	            </ul>
	        </div>
     		</c:if> 
     		<c:if test="${not empty Auth && Auth eq 'adminAuth' }">
     		<p class="introSmallJoin">
	        	*관리자 승인 후 해당 아이디로 로그인할 수 있습니다.   
	        </p>
	         <table class="tbl_02 tbl_join_01">
	        	<caption>회원가입 정보</caption>
	            <tbody>
	            	<tr>
	                	<th><span>*</span> 아이디</th>
	                	<td><span class="colorR">${userInfo.UI_ID }</span></td>
	                </tr>
	            	<tr>
	                	<th><span>*</span> 이메일주소</th>
	                	<td><span class="colorR">${userInfo.UI_EMAIL }</span></td>
	                </tr>
	            </tbody>
	        </table>
	        <div class="grayJoinBox">
	        	<h2><span class="colorR">알려드립니다.</span></h2>
	            <ul class="ulDefault">
	            	<li>회원님의 패스워드는 아무도 알 수 없는 암호화 코드로 저장되므로 안심하셔도 좋습니다. 아이디, 패스워드 분실 시에는 회원가입 시 입력하신 이메일 주소를 이용하여 찾을 수 있습니다.</li>
	            	<li>회원 탈퇴는 언제든지 가능하며 일정 기간이 지난 후 회원님의 정보는 자동으로 삭제됩니다.<br> <br> 감사합니다.</li>
	            </ul>
	        </div>
     		</c:if> 
        <div class="btnBox">
            <button type="button" class="btn btnBig_02" onclick="location.href='/jact/index.do'">메인으로</button>
        </div>
        
    </div>                        
</div>