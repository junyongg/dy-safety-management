package com.tx.common.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.plexus.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.member.dto.UserDTO;
import com.tx.admin.member.dto.UserSettingDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.ComponentService;
import com.tx.common.security.aes.AES256Cipher;
import com.tx.common.security.password.MyPasswordEncoder;
import com.tx.common.security.rsa.service.RsaService;

/**
 * 
 * @FileName: LoginController.java
 * @Project : demo
 * @Date    : 2020. 02. 06. 
 * @Author  : 신강철	
 * @Version : 1.0
 */
@Controller
public class CommonMemberController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	
	/** 암호화 */
	@Autowired MyPasswordEncoder passwordEncoder;
	
	/** RSA */
	@Autowired RsaService RsaService;
	
	@RequestMapping(value="/{tiles}/member/login.do")
	public ModelAndView memberLogion(HttpServletRequest req, Map<String,Object> commandMap
			,@PathVariable String tiles
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/"+tiles+"/member/prc_login.notiles");
		
		
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		//로그인한 상태라면 메인화면으로 리다이렉트
		if(user != null){
			mv.setViewName("redirect:/"+tiles+"/index.do");
			return mv;
		}
		
		//리턴페이지 셋팅
		if(req.getParameter("customReturnPage") != null){
			mv.addObject("customReturnPage", req.getParameter("customReturnPage"));
		}else{
			if(req.getSession().getAttribute("customReturnPage") != null){
				mv.addObject("customReturnPage",req.getSession().getAttribute("customReturnPage"));
				req.getSession().removeAttribute("customReturnPage");
			}
		}
		
		//에러메세지 셋팅
		if(req.getSession().getAttribute("customExceptionmsg") != null){
			mv.addObject("customExceptionmsg",req.getSession().getAttribute("customExceptionmsg"));
			req.getSession().removeAttribute("customExceptionmsg");
		}
		
		RsaService.setRsa(req);
		
		return mv;
	}
	
	@RequestMapping(value="/{tiles}/login/denied.do")
	@CheckActivityHistory(desc="접근 거부 페이지 방문")
	public ModelAndView loginDenied(HttpServletRequest req
			,@PathVariable String tiles
			) throws Exception {
		
		
		ModelAndView mv  = new ModelAndView("/error/denied");
		
		mv.addObject("tiles",tiles);
		
		return mv;
	}
	
	/**
	 * 아이디 중복체크 , 금지단어 체크
	 * @param req
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/regist/checkIdEmailAjax.do")
	@ResponseBody
	public String commonMemberRegistCheck(HttpServletRequest req
			, UserDTO UserDTO
			, @RequestParam(value="tiles") String tiles
			
			) throws Exception {
		
		String result = Component.getData("member.UI_checkIdAndEmail", UserDTO);
		if(result != null && result.contains("id")){
			return "id";
		}
		
		UserSettingDTO setting = Component.getData("member.US_getData",tiles);
		//금지단어 체크
		if(UserDTO.getUI_ID()!= null && !UserDTO.getUI_ID().equals("")){
			String UI_ID = UserDTO.getUI_ID();
//			System.out.println("아이디 : "+UI_ID );
			for(String f : setting.getUS_ID_FILTER().split(",")){
				if(UI_ID.contains(f)){
					return "idFilter";
				}
			}
		}
		
		if(UserDTO.getUI_NAME()!= null && !UserDTO.getUI_NAME().equals("")){
			String UI_NAME = UserDTO.getUI_NAME();
			for(String f : setting.getUS_ID_FILTER().split(",")){
				if(UI_NAME.contains(f)){
					return "nameFilter";
				}
			}
		}
		
		return "ok";
		
	}
	
	/**
	 * 비밀번호 체크
	 * @param req
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/update/forbiddenWorkdCheckAjax.do")
	@ResponseBody
	public String commonMemberUpdateForbiddenWorkdCheckAjax(HttpServletRequest req
			, @RequestParam(value="tiles") String tiles
			, @RequestParam(value="text") String text
			) throws Exception {
		
		UserSettingDTO setting = Component.getData("member.US_getData",tiles);
		//금지단어 체크
		if(StringUtils.isNotEmpty(text)){
			for(String f : setting.getUS_ID_FILTER().split(",")){
				if(text.contains(f)){
					return "F";
				}
			}
		}
		
		return "S";
		
	}
	
	
	/**
	 * 비밀번호 체크
	 * @param req
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/update/checkPassword.do")
	@ResponseBody
	public boolean commonMemberUpdateCheckPassword(HttpServletRequest req
			, UserDTO UserDTO
			) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		
		String password = user.get("UI_PASSWORD")+"";
		
		if(passwordEncoder.matches(UserDTO.getUI_PASSWORD(), password)){
			return true;
		}else{
			return false;
		}
		
	}
	
	/**
	 * 아이디 체크
	 * @param req
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/update/checkId.do")
	@ResponseBody
	public boolean commonMemberUpdateCheckId(HttpServletRequest req
			, UserDTO UserDTO
			, @RequestParam(value="tiles") String tiles
			) throws Exception {
		int result = Component.getCount("member.UI_checkId", UserDTO);
		
		if(result == 1){
			return true;
		}else{
			UserSettingDTO setting = Component.getData("member.US_getData",tiles);
			//금지단어 체크
			if(UserDTO.getUI_ID()!= null && !UserDTO.getUI_ID().equals("")){
				String UI_ID = UserDTO.getUI_ID();
				for(String f : setting.getUS_ID_FILTER().split(",")){
					if(UI_ID.contains(f)){
						return true;
					}
				}
			}
			return false;
		}
	}
	/**
	 * 이메일 체크
	 * @param req
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/update/checkEmail.do")
	@ResponseBody
	public boolean commonMemberUpdateCheckEmail(HttpServletRequest req
			, UserDTO UserDTO
//			, @RequestParam(value="tiles") String tiles
			) throws Exception {
		
		String email = AES256Cipher.encode(UserDTO.getUI_EMAIL());
		int result = Component.getCount("member.UI_checkEmail", email);
		if(result == 1){
			return true;
		}
		
		return false;
	}
	
	/**
	 * 비밀번호 체크
	 * @param req
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/update/checkPwd.do")
	@ResponseBody
	public boolean commonMemberUpdateCheckPwd(HttpServletRequest req
			, UserDTO UserDTO
			, @RequestParam(value="type",required=false) String type
			) throws Exception {
		
		
		String encPwd = null;
		if(type != null && "admin".equals(type)){
			@SuppressWarnings("unchecked")
			Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
			if(user != null){
				encPwd = (String)user.get("UI_PASSWORD");
			}
		}else{
			UserDTO user = Component.getData("member.UI_IdCheck", UserDTO);
			encPwd = user.getUI_PASSWORD();
		}
		
		if(StringUtils.isEmpty(encPwd)){
			return false;
		}
		
		return passwordEncoder.matches(UserDTO.getUI_PASSWORD(), encPwd);
	}
	
	
	/**
	 * 금지단어 체크
	 * @param req
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/update/checkIdEmailAjax.do")
	@ResponseBody
	public String commonMemberUpdateCheck(HttpServletRequest req
			, UserDTO UserDTO
			, @RequestParam(value="tiles") String tiles
			
			) throws Exception {
		
		
		UserSettingDTO setting = Component.getData("member.US_getData",tiles);
		//금지단어 체크
		if(UserDTO.getUI_NAME()!= null && !UserDTO.getUI_NAME().equals("")){
			String UI_NAME = UserDTO.getUI_NAME();
			for(String f : setting.getUS_ID_FILTER().split(",")){
				if(UI_NAME.contains(f)){
					return "nameFilter";
				}
			}
		}
		
		return "ok";
		
	}
	
	
}
