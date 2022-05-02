package com.tx.common.security.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
 
/**
 * 인증 실패 핸들러
 * @author TerryChang
 *
 */
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
 
    private String loginidname;         // 로그인 id값이 들어오는 input 태그 name
    private String loginpasswdname;     // 로그인 password 값이 들어오는 input 태그 name
    private String loginredirectname;       // 로그인 성공시 redirect 할 URL이 지정되어 있는 input 태그 name
    private String exceptionmsgname;        // 예외 메시지를 request의 Attribute에 저장할 때 사용될 key 값
    
    public String getLoginidname() {
        return loginidname;
    }
 
 
    public void setLoginidname(String loginidname) {
        this.loginidname = loginidname;
    }
 
 
    public String getLoginpasswdname() {
        return loginpasswdname;
    }
 
 
    public void setLoginpasswdname(String loginpasswdname) {
        this.loginpasswdname = loginpasswdname;
    }
 
    public String getExceptionmsgname() {
        return exceptionmsgname;
    }
 
    public String getLoginredirectname() {
        return loginredirectname;
    }
 
 
    public void setLoginredirectname(String loginredirectname) {
        this.loginredirectname = loginredirectname;
    }
 
 
    public void setExceptionmsgname(String exceptionmsgname) {
        this.exceptionmsgname = exceptionmsgname;
    }
 
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        // TODO Auto-generated method stub
        
    	String URL = request.getServletPath();
		URL = "/"+URL.split("/")[1];
		
		String defaultFailureUrl = "/txap/user/login.do";
		if(!URL.equals("/txap")){
			defaultFailureUrl = URL + "/member/login.do";
		}
		
    	
    	String message = exception.getMessage();
        
        request.getSession().setAttribute("customExceptionmsg", message);
        
        if(request.getParameter("customReturnPage") != null){
        	request.getSession().setAttribute("customReturnPage", request.getParameter("customReturnPage"));
		}
        
        
        response.sendRedirect(request.getContextPath() + defaultFailureUrl);

    }
 
}
