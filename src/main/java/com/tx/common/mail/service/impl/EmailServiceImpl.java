package com.tx.common.mail.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.tx.admin.member.dto.UserDTO;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.mail.service.EmailService;
import com.tx.common.security.aes.AES256Cipher;
import com.tx.common.security.password.MyPasswordEncoder;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("EmailService")
public class EmailServiceImpl extends EgovAbstractServiceImpl implements EmailService{
	
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 암호화 */
	@Autowired MyPasswordEncoder passwordEncoder;
	
	/** 이메일 템플릿 */
	@Resource(name="velocityEngine")
    VelocityEngine velocityEngine;
	
	
	@Autowired
	private EmailSender emailSender;
	
	@Override
	public void sendEmail(String emailTitle, String email, String contents) throws Exception {
		// TODO Auto-generated method stub
	    	emailSender.sendEmail(email, emailTitle, contents);
	}
	/**
	 * 게시물 등록/수정 이메일
	 * @param email 
	 * @throws Exception 
	 *   */
	@Override
	public void sendBoardEmail(String menuName,String action, String boardName, int boardKey, String email, HttpServletRequest req) throws Exception {
		// TODO Auto-generated method stub
		String emailTitle = "["+menuName + "] 게시판에 게시물이 " + action + "되었습니다.";
		String domain = CommonService.checkUrl(req);
		String boardUrl = domain + "/cf/Board/" + boardKey + "/detailView.do";
		
		 Map<String,Object> map = new HashMap<String,Object>();
		 map.put("domain",domain);
		 map.put("emailTitle",emailTitle);
		 map.put("boardName",boardName);
		 map.put("boardUrl", boardUrl);
	    String veloTemplate = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "boardEmail.vm", "UTF-8",map);
		emailSender.sendEmail(email, emailTitle, veloTemplate);
	}
	
	
	/**
	 * 회원 활성화 인증메일 보내기
	 * ( 아이디 + divStr(구분자) + 현재시간(밀리세컨드) 문자열을 암호화 후 return  
	 * @throws Exception 
	 *   */
	@Override
	public String sendAuthEmail(UserDTO UserDTO, HttpServletRequest req, String tiles) throws Exception{
		String ret = "";
		
		String emailTitle = "전남 문화관광 계정 인증 안내";
		String domain = CommonService.checkUrl(req);
		String encodedInfo = makeEmailAuthCode(UserDTO);
		String AuthURL = domain + "/"+tiles+"/member/signAuth/update.do?userinfo=" + encodedInfo;
		
		 Map<String,Object> map = new HashMap<String,Object>();
		 map.put("domain",domain);
		 map.put("AuthURL",AuthURL);
		 map.put("UI_NAME", UserDTO.getUI_NAME());
	    String veloTemplate = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emailAuth.vm", "UTF-8",map);
		emailSender.sendEmail(UserDTO.getUI_EMAIL(), emailTitle, veloTemplate);
		
		return ret;
	}
	
	
	/**
	 * 아이디 및 비밀번호 찾기
	 * @param reciver
	 * @param UserDTO
	 * @throws Exception
	 */
	@Override
	public void newPswToEmail(UserDTO UserDTO, HttpServletRequest req) throws Exception{
		
		String emailTitle = "전남 문화관광 계정 안내";
		String domain = CommonService.checkUrl(req);
		String url = domain + "/jact/member/login.do";
		StringBuffer buffer = new StringBuffer();
		Random random = new Random();
		
		// 비밀번호랜덤 생성
		String chars[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9".split(",");
		for (int i = 0; i < 8; i++) {
			buffer.append(chars[random.nextInt(chars.length)]);
		}
		
		// 서버 비밀번호 변경 (UI_KEYNO 필요)
		UserDTO.setUI_PASSWORD( passwordEncoder.encode(buffer.toString()));
		Component.updateData("member.UI_updateUserTempPwd", UserDTO);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user", UserDTO);
		map.put("pwd", buffer.toString());
		map.put("url",url);
		map.put("domain",domain);
	    String veloTemplate = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "idAndPwdConfirm.vm", "UTF-8",map);
		// 비밀번호 발송
	    String email = AES256Cipher.decode(UserDTO.getUI_EMAIL());
		emailSender.sendEmail(email, emailTitle, veloTemplate);
	}
	
		
	/**
	 * 이메일 인증 코드 생성
	 * ( 아이디 + divStr(구분자) + 현재시간(밀리세컨드) 문자열을 암호화 후 return  
	 * @throws Exception 
	 *   */
	@Override
	public String makeEmailAuthCode(UserDTO UserDTO) throws Exception{
		String beforeEncInfo = "";
		String encodedInfo = "";
		String divStr = "^_^";
		
		Calendar cal = Calendar.getInstance();
		beforeEncInfo += UserDTO.getUI_ID() + divStr;
		beforeEncInfo += cal.getTimeInMillis();
		
		encodedInfo = AES256Cipher.encode(beforeEncInfo);
		UserDTO.setUI_AUTH_DATA(beforeEncInfo);
		Component.updateData("member.UI_userSignAuthData", UserDTO);
		
		return encodedInfo;
	}
	
	/**
	 * 이메일 인증 
	 * 난수생성  
	 * @throws Exception 
	 *   */
	@Override
	public String EmailAuthonCode(
			String Email
			,HttpServletRequest req) throws Exception{
		String emailTitle = "전남 문화재단 인증";
		HashMap<String , Object> map = new HashMap<String, Object>();
		String domain = CommonService.checkUrl(req);
		String authKey = getAuthCode(6);
		map.put("authKey", authKey);
		map.put("domain", domain);
	    String veloTemplate = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emailAuthHire.vm", "UTF-8",map);
		emailSender.sendEmail(Email, emailTitle, veloTemplate);
		
		return authKey;
	}
	/**
	 * 이메일로 비번전송 
	 * @throws Exception 
	 *   */
	@Override
	public void EmailPwCode(
			String Email
			,HttpServletRequest req
			,String password
			) throws Exception{
		String emailTitle = "전남 문화재단 채용 비밀번호 찾기";
		HashMap<String , Object> map = new HashMap<String, Object>();
		String domain = CommonService.checkUrl(req);
		password = password.substring(4);
		map.put("password", password);
		map.put("domain", domain);
		String veloTemplate = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emailAuthHirePw.vm", "UTF-8",map);
		emailSender.sendEmail(Email, emailTitle, veloTemplate);
		
	}
	
	
	
	
	/**
	 * 이메일 인증 코드 생성
	 * @throws Exception 
	 *   */
	@Override
	public UserDTO isEmailAuthCode(String encodedInfo) throws Exception{
		String decodedInfo = AES256Cipher.decode(encodedInfo.replaceAll(" ", "+"));
		
		return Component.getData("member.UI_userSignAuthConfirm", decodedInfo);
	}
	
	
	/**
	 * 인증코드 생성하기 
	 * @throws Exception 
	 *   */
    private String getAuthCode(int number) {
        Random random = new Random();
        StringBuffer buffer = new StringBuffer();
        int num = 0;

        while(buffer.length() < number) {
            num = random.nextInt(10);
            buffer.append(num);
        }

        return buffer.toString();
    }
	
	
}