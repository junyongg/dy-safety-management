package com.tx.common.mail.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tx.admin.member.dto.UserDTO;
import com.tx.common.component.ComponentService;
import com.tx.common.mail.service.EmailService;
import com.tx.common.mail.service.impl.EmailSender;

/**
 * 
 * @FileName: CommonMailController.java
 * @Project : 메일
 * @Date : 2019. 02. 28.
 * @Author : 이재령
 * @Version : 1.0
 */
@Controller
public class CommonMailController {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;

	/** email **/
    @Autowired private EmailService EmailService;
	
	/**
	 * 인증메일 받아서 인증
	 * @param userinfo
	 * @param req
	 * @param redirectAttributes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/member/signAuth/update.do")
	@Transactional
	public String userSignAuth(String userinfo, // 암호화된 정보(아이디+생성시간)
			HttpServletRequest req
			,RedirectAttributes redirectAttributes
			,@PathVariable String tiles
			) throws Exception {
		
		UserDTO user = EmailService.isEmailAuthCode(userinfo); // 메일인증
		
		String signMsg = "";
		if(user == null){
			signMsg = "회원 인증이 실패하였습니다. 계속 인증에 실패할 경우 고객지원을 통해 문의해 주세요.";
		}else if(user.getUI_AUTH_YN().equals("Y")){
			signMsg = "이미 인증 되었습니다. 로그인 하여주세요.";
		}else{
			// 회원 인증 갱신
			Component.updateData("member.UI_userSignAuth", user);
			signMsg = "회원 인증이 성공하였습니다.";
		}
		
		redirectAttributes.addAttribute("msg", URLEncoder.encode(signMsg, "UTF-8"));
		
		return "redirect:/"+tiles+"/index.do";
	}

	
}
