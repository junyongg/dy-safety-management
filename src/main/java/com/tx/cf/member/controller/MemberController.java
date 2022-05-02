package com.tx.cf.member.controller;

import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tx.admin.member.dto.UserDTO;
import com.tx.admin.member.dto.UserSettingDTO;
import com.tx.admin.program.application.dto.ApplicationDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.mail.service.EmailService;
import com.tx.common.security.aes.AES256Cipher;
import com.tx.common.security.password.MyPasswordEncoder;
/**
 * 
 * @FileName: MemberController.java
 * @Project : cf
 * @Date    : 2017. 05. 31. 
 * @Author  : 이재령	
 * @Version : 1.0
 */
@Controller
public class MemberController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 암호화 */
	@Autowired MyPasswordEncoder passwordEncoder;
	
	/** email **/
    @Autowired private EmailService EmailService;
    
	/**
	 * 회원가입 - 약관동의
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cf/member/regist.do")
	@CheckActivityHistory(desc="회원가입 - 약관동의 페이지 방문")
	public ModelAndView cfMemberRegist(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/member/prc_regist_agree");
		
		mv.addObject("userInfoSetting", Component.getData("member.US_getData","cf"));
		
		return mv;
	}
	
	/**
	 * 회원가입 - 회원정보
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cf/member/regist/info.do")
	@CheckActivityHistory(desc="회원가입 - 회원정보 페이지 방문")
	public ModelAndView cfMemberRegistInfo(HttpServletRequest req
			, @RequestParam(value="data",defaultValue="") String data
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/member/prc_regist_info");
		
		
		if(!data.equals("data")){ //약관동의에서 넘어올때만 data에 값 들어옴
			mv.setViewName("redirect:/cf/member/regist.do");
			return mv;
		}
		
		mv.addObject("userInfoSetting", Component.getData("member.US_getData","cf"));
		mv.addObject("mirrorPage", "/cf/member/regist.do");
		return mv;
	}
	/**
	 * 회원가입 - 가입완료
	 * @param req
	 * @param data
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cf/member/regist/result.do")
	@Transactional
	@CheckActivityHistory(desc="회원가입 - 가입완료 작업")
	public ModelAndView cfMemberRegistSave(HttpServletRequest req
			, UserDTO UserDTO
			, @RequestParam(value="tiles") String tiles
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/member/prc_regist_result");
	
		UserSettingDTO setting = Component.getData("member.US_getData",tiles);
		
		String encryptionPW = passwordEncoder.encode(req.getParameter("UI_PASSWORD"));	
		
		
		UserDTO.setUI_KEYNO(CommonService.getTableKey("UI"));
		UserDTO.setUI_PASSWORD(encryptionPW);
		
		if(setting.getUS_AUTH() != null && setting.getUS_AUTH().equals("N")){ // 인증 미사용시
			UserDTO.setUI_AUTH_YN("Y");
		}else{ 
			UserDTO.setUI_AUTH_YN("N");
		}
		
		ApplicationDTO ApplicationDTO = new ApplicationDTO();
		ApplicationDTO.setAPU_KEYNO(CommonService.getTableKey("APU"));
		ApplicationDTO.setAPU_UI_KEYNO(UserDTO.getUI_KEYNO());
		ApplicationDTO.setAPU_NAME(UserDTO.getUI_NAME());
		ApplicationDTO.setAPU_RELATION("본인");
		ApplicationDTO.setAPU_BIRTH(UserDTO.getUI_BIRTH());
		ApplicationDTO.setAPU_GENDER(UserDTO.getUI_ZENDER());
		ApplicationDTO.setAPU_PHONE(UserDTO.getUI_PHONE());
		ApplicationDTO.setAPU_SELFYN("Y");
		Component.createData("Application.APU_Insert", ApplicationDTO);
		
		
		UserDTO.encode();
		Component.createData("member.UI_insert", UserDTO);
		UserDTO.decode();
		if(setting.getUS_AUTH() != null && setting.getUS_AUTH().equals("E")){	//이메일
			EmailService.sendAuthEmail(UserDTO,req,"cf");
			mv.addObject("Auth", "emailAuth");
		}else if(setting.getUS_AUTH() != null && setting.getUS_AUTH().equals("A")){	//관리자
			mv.addObject("Auth", "adminAuth");
		}
//		else if(setting.getUS_AUTH() != null && setting.getUS_AUTH().equals("P")){	//핸드폰
//			mv.addObject("Auth", "phoneAuth");
//		}
		
		
		if(setting.getUS_UIA_KEYNO() != null && !setting.getUS_UIA_KEYNO().equals("")){
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("UI_KEYNO", UserDTO.getUI_KEYNO());
			map.put("UIA_KEYNO", setting.getUS_UIA_KEYNO().split(","));
			Component.createData("member.UI_setAuthority", map);
		}
		
		mv.addObject("mirrorPage", "/cf/member/regist.do");
		mv.addObject("userInfo", UserDTO);
		return mv;
	}
	
	
	/**
	 * 아이디 비번찾기
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cf/member/find.do")
	public ModelAndView cfMemberFind(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/member/prc_find");
		
		return mv;
	}
	
	/**
	 * 이메일 확인후 메일 전송
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cf/member/find/confirm.do")
	@ResponseBody
	public boolean cfMemberFindConfirm(HttpServletRequest req
			, UserDTO UserDTO
			) throws Exception {
		boolean state = false;
		
		List<UserDTO> userList = Component.getList("member.UI_findUserWithEmail", UserDTO);
		
		if(userList != null){
			for(UserDTO u : userList){
				if(UserDTO.getUI_EMAIL().equals(AES256Cipher.decode(u.getUI_EMAIL()))){
					EmailService.newPswToEmail(u,req);
					state = true;
					break;
				}
			}
		}
		
		
		return state;
	}
	
	/**
	 * 회원정보 수정 페이지
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cf/mypage/info.do")
	@CheckActivityHistory(desc="회원정보 수정 페이지 방문")
	public ModelAndView cfMypageInfo(HttpServletRequest req, Map<String,Object> commandMap
			,@RequestParam(value="msg",required= false) String msg) throws Exception {
		ModelAndView mv  = new ModelAndView("/jact/mypage/prc_info");
		
		if(msg != null){
			mv.addObject("msg", msg);
		}
		return mv;
	}
	
	
	
	/**
	 * 회원정보 수정
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cf/mypage/info/update.do")
	@CheckActivityHistory(desc="회원정보 수정 작업")
	public ModelAndView cfMypageInfoUpdate(HttpServletRequest req
			, UserDTO UserDTO
			, @RequestParam(value="UI_PASSWORD2",defaultValue="") String UI_PASSWORD2
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/cf/mypage/info.do");
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		
		UserDTO.setUI_KEYNO(user.get("UI_KEYNO")+"");
		UserDTO.setUI_AUTH_YN("Y");
		
		if(!UI_PASSWORD2.equals("")){
			UserDTO.setUI_PASSWORD(passwordEncoder.encode(UI_PASSWORD2));
		}else{
			UserDTO.setUI_PASSWORD("");
		}
		Component.updateData("member.UI_updateUser", UserDTO);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication,user.get("UI_ID")+"", req));
		
		
		return mv;
	}
	
	
	/**
	 * 스프링 시큐리티 새로 고침
	 * @param currentAuth
	 * @param username
	 * @param req
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private Authentication createNewAuthentication(Authentication currentAuth, String username, HttpServletRequest req) {
        UserDetails newPrincipal = Component.getData("member.selectUserInfo", username);
        UsernamePasswordAuthenticationToken newAuth = 
            new UsernamePasswordAuthenticationToken(newPrincipal,currentAuth.getCredentials(),currentAuth.getAuthorities());
        newAuth.setDetails(currentAuth.getDetails());
        UserDTO principal =(UserDTO)newAuth.getPrincipal();
        principal.decode();
		Map<String, Object> map = ConverObjectToMap(principal);
		if (principal != null && principal instanceof UserDTO) {
			String UIA_NAME = (String)map.get("UIA_NAME");
			Map<String, Object> authority = new HashMap<String,Object>();
			authority.put("authList", UIA_NAME.split(","));
			map.put("isAdmin", Component.getData("Authority.UIA_isAdmin", authority)); //관리자 여부
			req.getSession().setAttribute("userInfo", map);
		}
        return newAuth;
    }
	
	/**
	 * Object -> map
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static Map ConverObjectToMap(Object obj) {
		try {
			// Field[] fields = obj.getClass().getFields(); //private field는 나오지
			// 않음.
			Field[] fields = obj.getClass().getDeclaredFields();
			Map resultMap = new HashMap();
			for (int i = 0; i <= fields.length - 1; i++) {
				fields[i].setAccessible(true);
				resultMap.put(fields[i].getName(), fields[i].get(obj));
			}
			return resultMap;
		} catch (IllegalArgumentException e) {
			System.out.println(e.getMessage());
		} catch (IllegalAccessException e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	/**
	 * 회원탈퇴 페이지
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cf/mypage/withdraw.do")
	@CheckActivityHistory(desc="회원탈퇴 페이지 방문")
	public ModelAndView cfMypageWithdraw(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/mypage/prc_withdraw");
		mv.addObject("Code", Component.getList("Code.ASC_GetList", "AQ"));
		
		return mv;
	}
	/**
	 * 회원탈퇴
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cf/mypage/withdraw/action.do")
	@ResponseBody
	@CheckActivityHistory(desc="회원탈퇴 작업")
	public boolean cfMypageWithdrawAction(HttpServletRequest req
			,UserDTO UserDTO
			) throws Exception {
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		
		String password = user.get("UI_PASSWORD")+"";
		
		
		if(passwordEncoder.matches(UserDTO.getUI_PASSWORD(), password)){
			UserDTO.setUI_KEYNO(user.get("UI_KEYNO")+"");
			Component.deleteData("member.UI_delete", UserDTO);
			return true;
		}else{
			return false;
		}
		
	}

	
}
