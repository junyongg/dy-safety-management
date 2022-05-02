$(function(){
	var saveId = cf_getCookie('saveId');
	if(saveId){
		$('#idSave').attr('checked',true);
		$('#UI_ID').val(saveId);
		$('#UI_PASSWORD').focus();
	}else{
		$('#UI_ID').focus();
	}
})

function validateEncryptedForm() {
	
    var username = document.getElementById("UI_ID").value;
    var password = document.getElementById("UI_PASSWORD").value;
    password = password.trim();
    if(username){
    	if(!password){
    		alert("비밀번호를 입력해주세요.");
    		return false;
    	}
    }
    
    if(password){
    	if(!username){
    		alert("ID를 입력해주세요.");
    		return false;
    	}
    }
    
    if (!username && !password) {
        alert("ID/비밀번호를 입력해주세요.");
        return false;
    }

    try {
        var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
        var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
        submitEncryptedForm(username,password, rsaPublicKeyModulus, rsaPublicKeyExponent);
    } catch(err) {
        alert(err);
    }
    return false;
}

function submitEncryptedForm(username, password, rsaPublicKeyModulus, rsaPpublicKeyExponent) {
    var rsa = new RSAKey();
    rsa.setPublic(rsaPublicKeyModulus, rsaPpublicKeyExponent);

    // 사용자ID와 비밀번호를 RSA로 암호화한다.
    var securedUsername = rsa.encrypt(username);
    var securedPassword = rsa.encrypt(password);
	
    
    //아이디 저장 체크시 쿠키에 저장
	if($('#idSave').is(':checked')){
		cf_setCookie('saveId',username)
	}else{
		cf_clearCookie('saveId');
	}

    // POST 로그인 폼에 값을 설정하고 발행(submit) 한다.
    var securedLoginForm = document.getElementById("securedLoginForm");
    securedLoginForm.securedUsername.value = securedUsername;
    securedLoginForm.securedPassword.value = securedPassword;
    securedLoginForm.submit();
}