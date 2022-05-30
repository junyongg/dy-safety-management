package com.tx.common.captcha.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.common.captcha.service.AudioCaptCha;
import com.tx.common.captcha.service.CaptCha;
import com.tx.common.component.ComponentService;

import cn.apiclub.captcha.Captcha;


/**
 * 
 * @FileName: CaptchaController.java
 * @Project : cf
 * @Date    : 2020. 05. 31. 
 * @Author  : 신강철	
 * @Version : 1.0
 */
@Controller
public class CaptchaController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	
	
	@RequestMapping(value="/common/captcha/img.do")
	@ResponseBody
	public void commonCaptchaImg(HttpServletRequest req, HttpServletResponse res, Map<String,Object> commandMap
			) throws Exception {
		new CaptCha().getCaptCha(req, res);
	}
	
	@RequestMapping(value="/common/captcha/audio.do")
	@ResponseBody
	public void commonCaptchaAudio(HttpServletRequest req, HttpServletResponse res, Map<String,Object> commandMap
			) throws Exception {
	    Captcha captcha = (Captcha) req.getSession().getAttribute(Captcha.NAME);
	    String getAnswer = captcha.getAnswer(); //CaptsCha Image에 사용된 문자열을 반환한다.
	    new AudioCaptCha().getAudioCaptCha(req, res, getAnswer);
	}
	
	@RequestMapping(value="/common/captcha/submit.do")
	@ResponseBody
	public boolean commonCaptchaSubmit(HttpServletRequest req, HttpServletResponse res, Map<String,Object> commandMap
			) throws Exception {
		boolean state = false;
		//Captcha.NAME = 'simpleCaptcha'
		   Captcha captcha = (Captcha) req.getSession().getAttribute(Captcha.NAME);
		   String answer = req.getParameter("answer"); //사용자가 입력한 문자열
		   if ( answer != null && !"".equals(answer) ) {

		       if (captcha.isCorrect(answer)) { //사용자가 입력한 문자열과 CaptCha 클래스가 생성한 문자열
		    	   req.getSession().removeAttribute(Captcha.NAME);
		    	   state = true;
		       } 
		   }
		return state; 
	}
	
}
