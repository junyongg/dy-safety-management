package com.tx.admin.member.dto;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

import com.tx.common.dto.Common;
import com.tx.common.security.aes.AES256Cipher;

public class UserDTO extends Common implements UserDetails  {
	
	private static final long serialVersionUID = -3793808669767332434L;
	
	private String  
					// T_USERINFO 테이블
					UI_KEYNO,
					UI_ID,
					UI_PASSWORD,
					UI_NAME,
					UI_EMAIL,
					UI_PHONE,
					UI_BIRTH,
					UI_ZENDER,
					UI_AUTHORITY,
					UI_DELYN,
					UI_REGDT,
					UI_MODDT,
					UI_AUTH_YN,
					UI_AUTH_DATA,
					UI_DEL_REASON,
					UI_REP_NAME,
					UI_COMPANY,
					UI_RANK,
					UI_LASTLOGIN,
					UI_LOGIN_COUNT,
					UI_LOCKYN,
					UI_LOCKDATE,
					LOCKDATE,
					UI_PWD_INIT,
					
					//g4_member 추가
					UI_MB_PASSWORD,
					UI_MB_LEVEL,
					UI_MB_TEL,
					UI_MB_ZIP1,
					UI_MB_ZIP2,
					UI_MB_ADDR1,
					UI_MB_ADDR2,
					UI_MB_RECOMMEND,
					UI_MB_POINT,
					UI_MB_LOGIN_IP,
					UI_MB_IP,
					UI_INTERCEPT_DATE,
					UI_MB_NICK,
					UI_MB_NICK_DATE,
					UI_MB_EMAIL_CERTIFY,
					UI_MB_MAILLING,
					UI_MB_SMS,
					UI_MB_OPEN,
					UI_MB_OPEN_DATE,
					UI_MB_1,
					
					
					// T_USERINFO_AUTHORITY 테이블
					UIA_KEYNO,
					UIA_NAME,
					UIA_COMMENT,
					UIA_SYSTEM,
					UIA_MAINKEY,
					UIA_DIVISION,
					
					// T_USERINFO_ROLL 테이블
					UIR_KEYNO,
					UIR_NAME,
					UIR_SYSTEM,
					UIR_TYPE,
					UIR_TYPE_NAME,
					UIR_COMMENT
					
					;
	
	//사용자 정의
	private int UI_TOTAL = 0; // 총 회원수
	private int UI_TOTAL_LEAVE = 0; // 총 탈퇴회원
	private int COUNT = 0; // 회원카운트
				
	public int getCOUNT() {
		return COUNT;
	}

	public void setCOUNT(int cOUNT) {
		COUNT = cOUNT;
	}

	private boolean accountNonExpired = true;
    private boolean accountNonLocked = true;
	private boolean credentialsNonExpired = true;
    private boolean enabled = true;
    
	private Set<GrantedAuthority> authorities; // 계정이 가지고 있는 권한 목록
	
	
	
	
	

	public String getUI_MB_PASSWORD() {
		return UI_MB_PASSWORD;
	}

	public void setUI_MB_PASSWORD(String uI_MB_PASSWORD) {
		UI_MB_PASSWORD = uI_MB_PASSWORD;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}
	
	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
		//this.authorities = authorities;
	}
	
	
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return getUI_ID();
	}
	
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return getUI_PASSWORD();
	}
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return accountNonExpired;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		
		return accountNonLocked;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return credentialsNonExpired;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return enabled;
	}
	
	
	
	
	
	public void setAccountNonExpired(boolean accountNonExpired) {
		this.accountNonExpired = accountNonExpired;
	}
	public void setAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}
	public void setCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	private static SortedSet<GrantedAuthority> sortAuthorities(Collection<? extends GrantedAuthority> authorities) {

		Assert.notNull(authorities, "Cannot pass a null GrantedAuthority collection");
		SortedSet<GrantedAuthority> sortedAuthorities = new TreeSet<GrantedAuthority>(new AuthorityComparator());
		for (GrantedAuthority grantedAuthority : authorities) {
			Assert.notNull(grantedAuthority, "GrantedAuthority list cannot contain any null elements");
			sortedAuthorities.add(grantedAuthority);
			}
		return sortedAuthorities;
	}
	
	@SuppressWarnings("serial")
	private static class AuthorityComparator implements Comparator<GrantedAuthority>, Serializable {
		@SuppressWarnings("unused")
		private static final long serialVersionUId = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

		@Override
		public int compare(GrantedAuthority g1, GrantedAuthority g2) {
			// TODO Auto-generated method stub
			if (g2.getAuthority() == null) {
				return -1;
			}
			if (g1.getAuthority() == null) {
				return 1;
			}
			return g1.getAuthority().compareTo(g2.getAuthority());
		}
		
		
	}
	
	
	public void decode(){
		
		try{
			if(StringUtils.isNotBlank(this.UI_EMAIL)){
				this.UI_EMAIL = AES256Cipher.decode(this.UI_EMAIL);
			}
			if(StringUtils.isNotBlank(this.UI_PHONE)){
				this.UI_PHONE = AES256Cipher.decode(this.UI_PHONE);
			}
			
		}catch(Exception e){
			System.out.println("UserDTO 복호화중 에러 :: " + e.getMessage());
		}
		
	}
	
	public void encode(){
		try{
			if(StringUtils.isNotBlank(this.UI_EMAIL)){
				this.UI_EMAIL = AES256Cipher.encode(this.UI_EMAIL);
			}
			if(StringUtils.isNotBlank(this.UI_PHONE)){
				this.UI_PHONE = AES256Cipher.encode(this.UI_PHONE);
			}
			
		}catch(Exception e){
			System.out.println("UserDTO 암호화중 에러 :: " + e.getMessage());
		}
	}
	
	
	public int getUI_TOTAL_LEAVE() {
		return UI_TOTAL_LEAVE;
	}

	public void setUI_TOTAL_LEAVE(int uI_TOTAL_LEAVE) {
		UI_TOTAL_LEAVE = uI_TOTAL_LEAVE;
	}

	public int getUI_TOTAL() {
		return UI_TOTAL;
	}

	public void setUI_TOTAL(int uI_TOTAL) {
		UI_TOTAL = uI_TOTAL;
	}

	public String getUI_AUTH_YN() {
		return UI_AUTH_YN;
	}

	public void setUI_AUTH_YN(String uI_AUTH_YN) {
		UI_AUTH_YN = uI_AUTH_YN;
	}

	public String getUIR_TYPE_NAME() {
		return UIR_TYPE_NAME;
	}

	public void setUIR_TYPE_NAME(String uIR_TYPE_NAME) {
		UIR_TYPE_NAME = uIR_TYPE_NAME;
	}

	public String getUIR_SYSTEM() {
		return UIR_SYSTEM;
	}

	public void setUIR_SYSTEM(String uIR_SYSTEM) {
		UIR_SYSTEM = uIR_SYSTEM;
	}

	public String getUIR_TYPE() {
		return UIR_TYPE;
	}

	public void setUIR_TYPE(String uIR_TYPE) {
		UIR_TYPE = uIR_TYPE;
	}

	public String getUIR_KEYNO() {
		return UIR_KEYNO;
	}

	public void setUIR_KEYNO(String uIR_KEYNO) {
		UIR_KEYNO = uIR_KEYNO;
	}

	public String getUIR_NAME() {
		return UIR_NAME;
	}

	public void setUIR_NAME(String uIR_NAME) {
		UIR_NAME = uIR_NAME;
	}

	public String getUIR_COMMENT() {
		return UIR_COMMENT;
	}

	public void setUIR_COMMENT(String uIR_COMMENT) {
		UIR_COMMENT = uIR_COMMENT;
	}

	public String getUIA_SYSTEM() {
		return UIA_SYSTEM;
	}

	public void setUIA_SYSTEM(String uIA_SYSTEM) {
		UIA_SYSTEM = uIA_SYSTEM;
	}

	public String getUIA_COMMENT() {
		return UIA_COMMENT;
	}

	public void setUIA_COMMENT(String uIA_COMMENT) {
		UIA_COMMENT = uIA_COMMENT;
	}

	public String getUIA_KEYNO() {
		return UIA_KEYNO;
	}

	public void setUIA_KEYNO(String uIA_KEYNO) {
		UIA_KEYNO = uIA_KEYNO;
	}

	public String getUIA_NAME() {
		return UIA_NAME;
	}

	public void setUIA_NAME(String uIA_NAME) {
		UIA_NAME = uIA_NAME;
	}

	public String getUI_KEYNO() {
		return UI_KEYNO;
	}

	public void setUI_KEYNO(String uI_KEYNO) {
		UI_KEYNO = uI_KEYNO;
	}

	public String getUI_ID() {
		return UI_ID;
	}

	public void setUI_ID(String uI_ID) {
		UI_ID = uI_ID;
	}
	
	
	public String getUI_PASSWORD() {
		return UI_PASSWORD;
	}

	public void setUI_PASSWORD(String uI_PASSWORD) {
		UI_PASSWORD = uI_PASSWORD;
	}

	public String getUI_NAME() {
		return UI_NAME;
	}

	public void setUI_NAME(String uI_NAME) {
		UI_NAME = uI_NAME;
	}

	public String getUI_EMAIL() {
		return UI_EMAIL;
	}

	public void setUI_EMAIL(String uI_EMAIL) {
		UI_EMAIL = uI_EMAIL;
	}

	public String getUI_PHONE() {
		return UI_PHONE;
	}

	public void setUI_PHONE(String uI_PHONE) {
		UI_PHONE = uI_PHONE;
	}

	public String getUI_BIRTH() {
		return UI_BIRTH;
	}

	public void setUI_BIRTH(String uI_BIRTH) {
		UI_BIRTH = uI_BIRTH;
	}

	public String getUI_ZENDER() {
		return UI_ZENDER;
	}

	public void setUI_ZENDER(String uI_ZENDER) {
		UI_ZENDER = uI_ZENDER;
	}

	public String getUI_AUTHORITY() {
		return UI_AUTHORITY;
	}

	public void setUI_AUTHORITY(String uI_AUTHORITY) {
		UI_AUTHORITY = uI_AUTHORITY;
	}

	public String getUI_DELYN() {
		return UI_DELYN;
	}

	public void setUI_DELYN(String uI_DELYN) {
		UI_DELYN = uI_DELYN;
	}

	public String getUI_REGDT() {
		return UI_REGDT;
	}

	public void setUI_REGDT(String uI_REGDT) {
		UI_REGDT = uI_REGDT;
	}

	public String getUI_MODDT() {
		return UI_MODDT;
	}

	public void setUI_MODDT(String uI_MODDT) {
		UI_MODDT = uI_MODDT;
	}

	public String getUI_AUTH_DATA() {
		return UI_AUTH_DATA;
	}

	public void setUI_AUTH_DATA(String uI_AUTH_DATA) {
		UI_AUTH_DATA = uI_AUTH_DATA;
	}

	public String getUI_DEL_REASON() {
		return UI_DEL_REASON;
	}

	public void setUI_DEL_REASON(String uI_DEL_REASON) {
		UI_DEL_REASON = uI_DEL_REASON;
	}


	public String getUI_REP_NAME() {
		return UI_REP_NAME;
	}

	public void setUI_REP_NAME(String uI_REP_NAME) {
		UI_REP_NAME = uI_REP_NAME;
	}

	public String getUI_COMPANY() {
		return UI_COMPANY;
	}

	public void setUI_COMPANY(String uI_COMPANY) {
		UI_COMPANY = uI_COMPANY;
	}

	public String getUI_RANK() {
		return UI_RANK;
	}

	public void setUI_RANK(String uI_RANK) {
		UI_RANK = uI_RANK;
	}

	public String getUI_LASTLOGIN() {
		return UI_LASTLOGIN;
	}

	public void setUI_LASTLOGIN(String uI_LASTLOGIN) {
		UI_LASTLOGIN = uI_LASTLOGIN;
	}
	
	public String getUI_LOGIN_COUNT() {
		return UI_LOGIN_COUNT;
	}

	public void setUI_LOGIN_COUNT(String uI_LOGIN_COUNT) {
		UI_LOGIN_COUNT = uI_LOGIN_COUNT;
	}

	public String getUI_LOCKYN() {
		return UI_LOCKYN;
	}

	public void setUI_LOCKYN(String uI_LOCKYN) {
		UI_LOCKYN = uI_LOCKYN;
	}

	public String getUI_LOCKDATE() {
		return UI_LOCKDATE;
	}

	public void setUI_LOCKDATE(String uI_LOCKDATE) {
		UI_LOCKDATE = uI_LOCKDATE;
	}

	public String getLOCKDATE() {
		return LOCKDATE;
	}

	public void setLOCKDATE(String lOCKDATE) {
		LOCKDATE = lOCKDATE;
	}

	public String getUI_PWD_INIT() {
		return UI_PWD_INIT;
	}

	public void setUI_PWD_INIT(String uI_PWD_INIT) {
		UI_PWD_INIT = uI_PWD_INIT;
	}

	public String getUIA_MAINKEY() {
		return UIA_MAINKEY;
	}

	public void setUIA_MAINKEY(String uIA_MAINKEY) {
		UIA_MAINKEY = uIA_MAINKEY;
	}

	public String getUIA_DIVISION() {
		return UIA_DIVISION;
	}

	public void setUIA_DIVISION(String uIA_DIVISION) {
		UIA_DIVISION = uIA_DIVISION;
	}

	public String getUI_MB_LEVEL() {
		return UI_MB_LEVEL;
	}

	public void setUI_MB_LEVEL(String uI_MB_LEVEL) {
		UI_MB_LEVEL = uI_MB_LEVEL;
	}

	public String getUI_MB_TEL() {
		return UI_MB_TEL;
	}

	public void setUI_MB_TEL(String uI_MB_TEL) {
		UI_MB_TEL = uI_MB_TEL;
	}

	public String getUI_MB_ZIP1() {
		return UI_MB_ZIP1;
	}

	public void setUI_MB_ZIP1(String uI_MB_ZIP1) {
		UI_MB_ZIP1 = uI_MB_ZIP1;
	}

	public String getUI_MB_ZIP2() {
		return UI_MB_ZIP2;
	}

	public void setUI_MB_ZIP2(String uI_MB_ZIP2) {
		UI_MB_ZIP2 = uI_MB_ZIP2;
	}

	public String getUI_MB_ADDR1() {
		return UI_MB_ADDR1;
	}

	public void setUI_MB_ADDR1(String uI_MB_ADDR1) {
		UI_MB_ADDR1 = uI_MB_ADDR1;
	}

	public String getUI_MB_ADDR2() {
		return UI_MB_ADDR2;
	}

	public void setUI_MB_ADDR2(String uI_MB_ADDR2) {
		UI_MB_ADDR2 = uI_MB_ADDR2;
	}

	public String getUI_MB_RECOMMEND() {
		return UI_MB_RECOMMEND;
	}

	public void setUI_MB_RECOMMEND(String uI_MB_RECOMMEND) {
		UI_MB_RECOMMEND = uI_MB_RECOMMEND;
	}

	public String getUI_MB_POINT() {
		return UI_MB_POINT;
	}

	public void setUI_MB_POINT(String uI_MB_POINT) {
		UI_MB_POINT = uI_MB_POINT;
	}

	public String getUI_MB_LOGIN_IP() {
		return UI_MB_LOGIN_IP;
	}

	public void setUI_MB_LOGIN_IP(String uI_MB_LOGIN_IP) {
		UI_MB_LOGIN_IP = uI_MB_LOGIN_IP;
	}

	public String getUI_MB_IP() {
		return UI_MB_IP;
	}

	public void setUI_MB_IP(String uI_MB_IP) {
		UI_MB_IP = uI_MB_IP;
	}

	public String getUI_INTERCEPT_DATE() {
		return UI_INTERCEPT_DATE;
	}

	public void setUI_INTERCEPT_DATE(String uI_INTERCEPT_DATE) {
		UI_INTERCEPT_DATE = uI_INTERCEPT_DATE;
	}

	public String getUI_MB_NICK() {
		return UI_MB_NICK;
	}

	public void setUI_MB_NICK(String uI_MB_NICK) {
		UI_MB_NICK = uI_MB_NICK;
	}

	public String getUI_MB_NICK_DATE() {
		return UI_MB_NICK_DATE;
	}

	public void setUI_MB_NICK_DATE(String uI_MB_NICK_DATE) {
		UI_MB_NICK_DATE = uI_MB_NICK_DATE;
	}

	public String getUI_MB_EMAIL_CERTIFY() {
		return UI_MB_EMAIL_CERTIFY;
	}

	public void setUI_MB_EMAIL_CERTIFY(String uI_MB_EMAIL_CERTIFY) {
		UI_MB_EMAIL_CERTIFY = uI_MB_EMAIL_CERTIFY;
	}

	public String getUI_MB_MAILLING() {
		return UI_MB_MAILLING;
	}

	public void setUI_MB_MAILLING(String uI_MB_MAILLING) {
		UI_MB_MAILLING = uI_MB_MAILLING;
	}

	public String getUI_MB_SMS() {
		return UI_MB_SMS;
	}

	public void setUI_MB_SMS(String uI_MB_SMS) {
		UI_MB_SMS = uI_MB_SMS;
	}

	public String getUI_MB_OPEN() {
		return UI_MB_OPEN;
	}

	public void setUI_MB_OPEN(String uI_MB_OPEN) {
		UI_MB_OPEN = uI_MB_OPEN;
	}

	public String getUI_MB_OPEN_DATE() {
		return UI_MB_OPEN_DATE;
	}

	public void setUI_MB_OPEN_DATE(String uI_MB_OPEN_DATE) {
		UI_MB_OPEN_DATE = uI_MB_OPEN_DATE;
	}

	public String getUI_MB_1() {
		return UI_MB_1;
	}

	public void setUI_MB_1(String uI_MB_1) {
		UI_MB_1 = uI_MB_1;
	}
	
	
}
