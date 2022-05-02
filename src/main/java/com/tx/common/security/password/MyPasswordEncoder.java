package com.tx.common.security.password;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MyPasswordEncoder {
	
	
	/** 암호화 */
	PasswordEncoder passwordEncoder = new StandardPasswordEncoder("TRONIX$(%&@!CTCMS");	//SHA256
//	PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	public String encode(CharSequence rawPassword){
		return passwordEncoder.encode(rawPassword);
	}
	
	public boolean matches(CharSequence rawPassword, String encodedPassword){
		return passwordEncoder.matches(rawPassword, encodedPassword);
	}
	
	
}
