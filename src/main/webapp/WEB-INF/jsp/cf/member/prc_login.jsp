<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<script type="text/javascript" src="/resources/api/rsa/jsbn.js"></script>
<script type="text/javascript" src="/resources/api/rsa/rsa.js"></script>
<script type="text/javascript" src="/resources/api/rsa/prng4.js"></script>
<script type="text/javascript" src="/resources/api/rsa/rng.js"></script>
<script type="text/javascript" src="/resources/api/rsa/login.js"></script>


<form:form id="securedLoginForm" name="securedLoginForm" action="/cf/j_spring_security_check.do" method="post" style="display: none;">
	<input type="hidden" name="customReturnPage" value="${customReturnPage}" />
	<input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}" />
	<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}" />
	<input type="hidden" name="securedUsername" id="securedUsername" value="" />
	<input type="hidden" name="securedPassword" id="securedPassword" value="" />
</form:form>

<form:form id="Form">
<input type="hidden" name="customReturnPage" value="${customReturnPage}" />
<div class="loginSiteWrap">
   	<p class="smallIntro">
    	* 홈페이지 게시내용의 책임성 확보를 위하여 실명제로 운영되고 있는바, 이의 효율적인 운영을 위해 회원가입 및 로그인을 하셔야 합니다.<br>
        * ID가 없으신 분은 회원가입을 해주시기 바랍니다.
    </p>
    <div class="formBox clearfix">
    	<div class="col">
        	<p class="samllChar">* 로그인을 하시면 보다 편리하게 서비스를 받으실 수 있습니다.</p>
            <div class="loginFormBox clearfix">
            	<div class="inputForm">
                	<p><input type="text" name="UI_ID" id="UI_ID" class="txtlogin width100Per" placeholder="아이디를 입력하세요"></p>
                	<p><input type="password" name="UI_PASSWORD" id="UI_PASSWORD" class="txtlogin width100Per" placeholder="비밀번호를 입력하세요"></p>
                </div>
                <button type="submit" class="btn btnLogin" onclick="validateEncryptedForm(); return false;">로그인</button>
            </div>
            <label class="pointer right"><input type="checkbox" id="idSave" style="position: relative;top: -1px;left: 10px;margin-right: 15px;">ID 기억하기</label>
            <p class="samllChar">${customExceptionmsg}</p>
            <div class="linkBox">
            	<h4><a href="/cf/member/find.do">아이다 비밀번호 찾기</a></h4>
                <p>아이디, 비밀번호를 잊어버리셨나요?</p>
            </div>
        </div>
    	<div class="col">
        	<div class="lineVertical"></div>
        	<div class="newJoinBox">
            	<h2>신규회원가입</h2>
                <p>
                	홈페이지회원으로 가입하시면 다양한 서비스를 제공받으실 수 있습니다.
                </p>
            </div>
            <div class="linkBox">
            	<h4><a href="/cf/member/regist.do">회원가입</a></h4>
                <p>아직 회원이 아니신가요?</p>
            </div>
        </div>
    </div>
</div>
</form:form>
