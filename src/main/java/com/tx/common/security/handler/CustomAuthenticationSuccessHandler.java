package com.tx.common.security.handler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.util.StringUtils;

import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.member.dto.UserDTO;
import com.tx.admin.statistics.dto.CheckAgent;
import com.tx.admin.statistics.dto.LogDTO;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.session.CustomSessionRegistry;

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;
	@Autowired CommonService CommonService;
	
	@Autowired
    private CustomSessionRegistry sessionRegistry;

	private String defaultUrl;
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	public CustomAuthenticationSuccessHandler() {
		defaultUrl = "/";
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
        //세션 시간 5분으로 설정
        request.getSession().setMaxInactiveInterval(SettingData.SESSION_DURATION);

		// 세션에 userInfo map으로 저장
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Object principal = auth.getPrincipal();
		UserDTO user = (UserDTO)principal;
		
		user.decode();
		Map<String, Object> map = null;
		try {
			map = CommonService.ConverObjectToMap(principal);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}
		if (principal != null && principal instanceof UserDTO) {
			setUserInfo(map,request);
		}

		clearAuthenticationAttributes(request);
		// 다음 이동할 페이지
		String returnUrl = decideRedirectUrl(request, response,map);
		
		
		sessionRegistry.registerNewSession(request.getSession(), principal);
		
		redirectStrategy.sendRedirect(request, response, returnUrl);
		
	}
	
	/**
	 * 유저정보 세션에 저장 및 활동기록 저장
	 * @param map
	 * @param request
	 */
	private void setUserInfo(Map<String, Object> map, HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		map.put("sessionId", request.getSession().getId());
		
		String UIA_NAME = (String)map.get("UIA_NAME");
		Map<String, Object> authority = new HashMap<String,Object>();
		authority.put("authList", UIA_NAME.split(","));
		map.put("isAdmin", Component.getData("Authority.UIA_isAdmin", authority)); //관리자 여부
		String ip = CommonService.getClientIP(request);
		map.put("ip", ip);
		
		LogDTO log = new LogDTO();
		log.setAH_UI_KEYNO((String)map.get("UI_KEYNO"));
    	log.setAH_URL(request.getServletPath());
    	
    	Device device = DeviceUtils.getCurrentDevice(request);
		String DEVICE = "P";
		if(device.isMobile()) {
			DEVICE = getDeviceAorI(request);
		}
		map.put("AH_DEVICE", DEVICE);
    	log.setAH_DEVICE(DEVICE);
    	
    	Menu menu = new Menu();
    	String URL = request.getServletPath();
    	URL = URL.substring(0,URL.indexOf("/",1));
    	menu.setMN_URL(URL);
		//현재 메뉴
		Menu visiterMenu = Component.getData("Menu.AMD_getDataWithUrl", menu);
		
		if(visiterMenu != null){
			String HOMEDIV_C = visiterMenu.getMN_KEYNO();
			log.setAH_HOMEDIV_C(HOMEDIV_C);
			map.put("AH_HOMEDIV_C", HOMEDIV_C);
		}
		
		String agent = request.getHeader("User-Agent");
		String Referer = request.getHeader("referer");
		if(Referer == null){
			Referer = "";
		}
		log.setAH_AGENT(agent);
		log.setAH_BROWSER(CheckAgent.getBrowser(agent));
		log.setAH_OS(CheckAgent.getOS(agent));
		log.setAH_REFERER(Referer);
    	log.setAH_DESC("로그인");
    	log.setAH_IP(ip);
    	log.setAH_SESSION(request.getSession().getId());
    	Component.createData("Log.AH_creatData", log);
    	
    	
    	//마지막 로그인 일자 저장
    	Component.updateData("member.UI_updateLastLogin", map);
    	
    	
    	request.getSession().setAttribute("userInfo", map);
		
	}

	/**
	 * 모바일 기기 값 가져오기
	 * 
	 * @param req
	 * @return I or A
	 */
	private String getDeviceAorI(HttpServletRequest req) {
		String header = req.getHeader("User-Agent");

		if (header != null) {
			if (header.indexOf("iPhone") > -1) {
				header = "I";

			} else if (header.indexOf("Android") > -1) {
				header = "A";

			}
		}
		return header;
	}

	private void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			return;
		}

		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}


	/**
	 * 인증 성공후 어떤 URL로 redirect 할지를 결정한다 
	 */
	private String decideRedirectUrl(HttpServletRequest request, HttpServletResponse response, Map<String, Object> map) {

		String returnUrl = "";
		String URL = request.getServletPath();
		URL = "/"+URL.split("/")[1];
		
		String UI_PWD_INIT = (String)map.get("UI_PWD_INIT");
		if("Y".equals(UI_PWD_INIT) && "/txap".equals(URL)){	//제품 설치후 최초 로그인
			return "/txap/login/init.do";
		}
		
		//권한별 시작 url 이 설정되어있는경우
		try{
			String UIA_KEYNO = (String)map.get("UIA_KEYNO");
			
			if(StringUtils.hasText(UIA_KEYNO)){
				Map<String, Object> map2 = new HashMap<String, Object>();
				
				map2.put("URL", URL);
				map2.put("UIA_KEYNO", UIA_KEYNO.split(",")[0]);
				
				returnUrl = Component.getData("HomeManager.HAM_getTargetUrl",map2);
				if(StringUtils.hasText(returnUrl)){
					return returnUrl;
				}
				
			}
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(getClass().getName() + " :: " + e.getMessage());
		}
		
		String returnPage = request.getParameter("customReturnPage");
		if(StringUtils.hasText(returnPage)){
			return returnPage;
		}
		
		//위쪽 필터에서 걸리지 않고 여기까지 오면 각 홈페이지 기본 url 인 /index.do 를 붙여서 리턴한다.
		return URL + "/index.do";
	}

}
