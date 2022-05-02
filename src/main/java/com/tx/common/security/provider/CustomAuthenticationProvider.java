package com.tx.common.security.provider;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.beust.jcommander.internal.Console;
import com.tx.admin.member.dto.UserDTO;
import com.tx.common.common.Language;
import com.tx.common.component.ComponentService;
import com.tx.common.security.password.MyPasswordEncoder;
import com.tx.common.session.CustomSessionListener;
import com.tx.common.session.CustomSessionRegistry;
 
 
public class CustomAuthenticationProvider implements AuthenticationProvider{
 
	
	protected final Log logger = LogFactory.getLog(CustomAuthenticationProvider.class);
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	
	/** 암호화 */
	@Autowired MyPasswordEncoder passwordEncoder;
	
	@Autowired
    private CustomSessionRegistry sessionRegistry;
	
	private boolean usedLimitMaxSession = false;
	
	private int maxSessions = 0;
	
	private boolean existingSessionKill = true;
	
    public int getMaxSessions() {
		return maxSessions;
	}

	public void setMaxSessions(int maxSessions) {
		this.maxSessions = maxSessions;
	}
	
	public boolean isExistingSessionKill() {
		return existingSessionKill;
	}

	public void setExistingSessionKill(boolean existingSessionKill) {
		this.existingSessionKill = existingSessionKill;
	}
	
	public boolean isUsedLimitMaxSession() {
		return usedLimitMaxSession;
	}

	public void setUsedLimitMaxSession(boolean usedLimitMaxSession) {
		this.usedLimitMaxSession = usedLimitMaxSession;
	}

	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
    	
            String username = authentication.getName();
            String password = (String) authentication.getCredentials();
            
            UserDTO user = (UserDTO) Component.getData("member.selectUserInfo", username);
            
            //패스워드 비교!!구간
           
            if(user != null && user.getUI_PASSWORD() == null) {
            	//System.out.println(username + " 이름으로 처음들어온거 로그인 확인해서 성공하면 넣어줘야 한다. 입력받은  비밀번호는 '"+ password+"'");
            	user.setUI_MB_PASSWORD(password);
            	UserDTO result = (UserDTO) Component.getData("member.jact_user_login", user);
            	if(result != null && result.getUI_ID().equals(username)) {
            	//System.out.println("예전 비번으로 로그인 성공 ");
            	String encodePass =	passwordEncoder.encode(password);
            	user.setUI_PASSWORD(encodePass);
            	// cms용 비밀번호 저장하기
            	Component.updateData("member.UI_updateUser", user);
            	}
            }// 이전 비밀 번호로 로그인 하는 로직 끝
            
          	
            
          	if(user == null){
    			throw new LockedException(Language.getErrMessage(1));
    		}else{
    			Calendar today = Calendar.getInstance();
                Calendar targetCal = Calendar.getInstance();
                Date date = new Date();
                try {
                  date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(user.getLOCKDATE());
                } catch (Exception e) {
                	logger.debug("error : " + e.getMessage());
                }
                targetCal.setTime(date);
                long diffSec = (today.getTimeInMillis() - targetCal.getTimeInMillis()) / 1000;
                long minute = diffSec / 60;
                
              	if(user.getUI_LOCKYN().equals("Y") && minute < 30) {
              		throw new LockedException(Language.getErrMessage(0));
              	}else if(minute >= 30) {
              		//30분 이후 잠금해제
              		Component.updateData("member.updateLockData", user);
              		user.setUI_LOGIN_COUNT("0");
              		user.setUI_LOCKYN("N");
              	}
    		}
          	
    		if (!passwordEncoder.matches(password, user.getUI_PASSWORD())) {
    			if(user.getUI_LOGIN_COUNT() != null && !user.getUI_LOGIN_COUNT().equals("")) {
    				int count = Integer.parseInt(user.getUI_LOGIN_COUNT());
    				
    				count++;
    				user.setUI_LOGIN_COUNT(count+"");
    				
    				if(count >= 5) {
    					user.setUI_LOCKYN("Y");
    					Component.updateData("member.updateLock", user);
    					throw new LockedException(Language.getErrMessage(6));
    				}else {
    					user.setUI_LOCKYN("N");
    					Component.updateData("member.updateLock", user);
    				}
    			}else {
    				user.setUI_LOGIN_COUNT("1");
    				user.setUI_LOCKYN("N");
					Component.updateData("member.updateLock", user);
    			}
    			
            	throw new LockedException(Language.getErrMessage(2));
            }
    		
    		if(user.getUI_AUTH_YN().equals("N")){
    			//throw new UsernameNotFoundException("이메일 인증 안됨 " );
    			throw new LockedException(Language.getErrMessage(3));
    		}
    		
    		if(user.getUIA_NAME() == null){
    			throw new LockedException(Language.getErrMessage(4));
    		}
    		
    		if(user.getUI_DELYN().equals("Y")){
    			throw new LockedException(Language.getErrMessage(5));
    		}
    		
    		if(usedLimitMaxSession){
    			//같은 아이디 동시접속자수 체크
    			if(checkMaxSessions(user.getUI_ID())){
    				throw new LockedException("해당 아이디의 동시접속자수가 초과되었습니다. 기존 접속을 종료하여주세요.");
    			}
    		}
    		
    		
    		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
			String authority[] = user.getUIA_NAME().split(",");
			for(String auth : authority){
				roles.add(new SimpleGrantedAuthority(auth));
			}
			user.setAuthorities(roles);
			//로그인 시 잠금 초기화
			Component.updateData("member.updateLockData", user);
			
            Collection<? extends GrantedAuthority> authorities = user.getAuthorities();
            
           
            return new UsernamePasswordAuthenticationToken(user, password, authorities);
    }
 
	/**
	 * 해당 id로 기존 로그인한 세션을 확인하여 maxSessions 값을 넘어가면 기존 session을 죽인다.
	 * @param id
	 */
    private boolean checkMaxSessions(String id) {
		// TODO Auto-generated method stub
    	
    	
    	List<Object> allPrincipals = sessionRegistry.getAllPrincipals();
    	
    	int existCount = 0;
    	for(Object principal : allPrincipals) {
            
    		if(principal instanceof UserDTO) {
                UserDTO user = (UserDTO) principal;
                String UI_ID = user.getUI_ID();
                if(id.equals(UI_ID)){
                	if(++existCount >= maxSessions){
                		if(existingSessionKill){
                			HttpSession session = sessionRegistry.getSession(principal);
                			sessionRegistry.removeSessionInformation(session.getId());
                			session.invalidate();
                		}else{
                			return true;
                		}
                	}
                }
                
            }
        }
    	
    	return false;
    	
	}

	public boolean supports(Class<?> arg0) {
        return true;
    }
    
 
}