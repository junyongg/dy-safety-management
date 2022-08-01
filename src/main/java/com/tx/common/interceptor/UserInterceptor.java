package com.tx.common.interceptor;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.homepage.menu.service.AdminMenuSessionService;
import com.tx.admin.operation.banner.dto.BannerDTO;
import com.tx.admin.statistics.dto.CheckAgent;
import com.tx.admin.statistics.dto.LogDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

public class UserInterceptor extends HandlerInterceptorAdapter {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 메뉴관리 서비스2 */
	@Autowired private AdminMenuSessionService AdminMenuSessionService;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		
		return super.preHandle(request, response, handler);
	}
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
		String URL = request.getRequestURI();
		Menu visiterMenu = null;
		boolean checkMirrorPage = false;
		Menu menu = new Menu();
		menu.setMN_URL(URL);
		
		if(modelAndView != null){
			String viewName = modelAndView.getViewName();
			if(!viewName.startsWith("redirect") && !viewName.startsWith("forward")){ //리다이렉트/포워드 제외
				if(checkUrlFilter(URL,"normal")){
					if(modelAndView.getModel().get("mirrorPage") != null){	// mirrorPage 가 있을경우 현재 url이 아닌 mirrorPage에서 메뉴정보를 가져옴
						
						String mirrorPage = (String)modelAndView.getModel().get("mirrorPage");
						menu.setMN_URL(mirrorPage);
						checkMirrorPage = true;
					}
					
					
					//현재 메뉴
					visiterMenu = Component.getData("Menu.AMN_getMenuByURL", menu);
					if(URL.startsWith("/txap")){
						adminSetting(request,response,handler,modelAndView,URL,visiterMenu);
					}else{ 
						userSetting(request,response,handler,modelAndView,URL,visiterMenu);
					}
					
					modelAndView.addObject("domain",CommonService.checkUrl(request));
					
					
					if(visiterMenu != null){
						 //팝업체크 - 쿠키 확인
						Cookie[] cookies = request.getCookies();
						List<String> key_w = new ArrayList<String>();
						List<String> key_b = new ArrayList<String>();
						if (cookies != null) {
						    for (Cookie cookie : cookies) {
						    	if("popup_w".equals(cookie.getName())){
						        	String keys[] = URLDecoder.decode(cookie.getValue(), "UTF-8").split(",");
						        	for(String k : keys){
						        		if(!k.equals("")){
						        			key_w.add(CommonService.getKeyno(k, "PI"));
						        		}
						        		
						        		if("0".equals(k)) {
						        			modelAndView.addObject("eventkey", "Y");
							        	}
						        	}
						        	
						        	
						        	modelAndView.addObject("CookieKeys", URLDecoder.decode(cookie.getValue(), "UTF-8"));
						        }
						        if("popup_b".equals(cookie.getName())){
						        	String keys[] = URLDecoder.decode(cookie.getValue(), "UTF-8").split(",");
						        	for(String k : keys){
						        		if(!k.equals("")){
						        			key_b.add(k);
						        		}
						        	}
						        }
						    }
						}
						
						Map<String,Object> popup = new HashMap<String,Object>();
						popup.put("MN_URL", visiterMenu.getMN_URL());
						if(key_w.size() > 0){
							popup.put("key", key_w);
						}
					
						if(key_w.size() >= 0){
							//팝업체크 
							popup.put("PI_DIVISION", "W");
							modelAndView.addObject("popupList_W", Component.getList("Popup.PI_getListWidthURL", popup) );
						}
						if(key_b.size() <= 0){
							popup.put("PI_DIVISION", "B");
							modelAndView.addObject("popupList_B", Component.getList("Popup.PI_getListWidthURL", popup) );
						}
					}
					
					
				}
				/*
				 * if(checkUrlFilter(URL,"activityHistory")){ //활동기록 //@CheckActivityHistory
				 * 어노테이션이 컨트롤러에 사용되었는지 체크함 CheckActivityHistory history = ((HandlerMethod)
				 * handler).getMethodAnnotation(CheckActivityHistory.class);
				 * //CheckActivityHistory 어노테이션이 없음으로 활동기록 남김 if(history != null) {
				 * if(!checkMirrorPage && visiterMenu == null){ //visiterMenu =
				 * Component.getData("Menu.AMN_getMenuByURL", menu); }
				 * 
				 * setActivityHistoryInfo(visiterMenu,history,request,modelAndView); } }
				 */
			}
			
		}
		 super.postHandle(request, response, handler, modelAndView);
	}
	
	/**
	 * 활동기록 
	 * @param visiterMenu
	 * @param history 
	 * @param request 
	 * @param modelAndView 
	 */
	@Transactional
	private void setActivityHistoryInfo(Menu visiterMenu, CheckActivityHistory history, HttpServletRequest request, ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		LogDTO log = new LogDTO();
    	@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("userInfo");
    	if(user != null){
    		log.setAH_UI_KEYNO((String)user.get("UI_KEYNO"));
    	}else{
    		log.setAH_UI_KEYNO("비회원");
    	}
    	log.setAH_URL(request.getServletPath());
    	Menu menu = new Menu();
    	menu.setMN_URL(log.getAH_URL());
    	
    	//홈페이지 키 셋팅
		if(visiterMenu != null){
			log.setAH_MENU(visiterMenu.getMN_KEYNO());
			log.setAH_HOMEDIV_C(visiterMenu.getMN_HOMEDIV_C());
		}else{
			String homeDiv = history.homeDiv();
			if(StringUtils.isNotEmpty(homeDiv)){
				log.setAH_HOMEDIV_C(homeDiv);
			}else{
				if(history.type().equals("hashmap")){
					@SuppressWarnings("unchecked")
					HashMap<String,Object> map = (HashMap<String, Object>) modelAndView.getModel().get("activityHistory");
					if(map != null){
						log.setAH_HOMEDIV_C((String) map.get("homeDiv"));
					}
				}
			}
		}
		
		Device device = DeviceUtils.getCurrentDevice(request);
		if(device.isMobile()) {
			log.setAH_DEVICE(getDeviceAorI(request));
		}else{
			log.setAH_DEVICE("P");
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
		
		String desc = "";
		
		if(history.type().equals("hashmap")){
			@SuppressWarnings("unchecked")
			HashMap<String,Object> map = (HashMap<String, Object>) modelAndView.getModel().get("activityHistory");
			if(map != null){
				desc = (String) map.get("desc");
			}
		}else{
			desc = history.desc();
			if(StringUtils.isBlank(desc) && visiterMenu != null) {
				desc = visiterMenu.getMN_NAME() + " 페이지 방문";
    		}
		}
		
		if(StringUtils.isNotEmpty(desc)){
			log.setAH_DESC(desc);
			log.setAH_IP(CommonService.getClientIP(request));
			log.setAH_SESSION(request.getSession().getId());
			Component.createData("Log.AH_creatData", log);
		}
	}
	
	
	
	/**
	 * 예외처리할 url 필터 
	 * @param uRL
	 * @param string
	 * @return
	 */
	private boolean checkUrlFilter(String url, String type) {
		// TODO Auto-generated method stub
		if("normal".equals(type)){	//기본 체크
			
            if(	!url.endsWith(".do") 	|| 	
            	url.endsWith("/ajax.do") 			|| 	
            	url.endsWith("Ajax.do")				||
            	url.startsWith("/async/")			||		
            	url.startsWith("/common/") 			||	
            	url.endsWith("/insert.do")			||
            	url.endsWith("/update.do") 			||	
            	url.endsWith("/delete.do")		){
            	
            	return false;
            }
            System.err.println("url :: " + url); 
			
		}else if("activityHistory".equals(type)){	//활동기록 체크
			
		}else{
			return false;
		}
		
		return true;
	}
	
	
	/**
	 * USER쪽 셋팅
	 * @param request
	 * @param response
	 * @param handler
	 * @param modelAndView
	 * @param URL
	 * @param visiterMenu2 
	 */
	private void userSetting(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView, String URL, Menu visiterMenu) throws Exception {
		// TODO Auto-generated method stub
		Menu menu = new Menu();
		menu.setMN_URL(URL);
		
		
		if(visiterMenu != null){
			//메인키값들로 이름들 리턴
			Map<String,Object> keyList = new HashMap<String,Object>();
			keyList.put("list", visiterMenu.getMN_MAINKEYS().split(","));
			keyList.put("lang", SettingData.HOMEPAGE_LANGUAGE);
			visiterMenu.setMN_MAINNAMES((String)Component.getData("Menu.AMN_getMainMenuNames",keyList));
			
			if(URL.split("/")[1].equals("cf")){	//데모1 페이지 레프트 메뉴에 대메뉴 영문명 넣기
				visiterMenu.setMN_ENG_NAME((String)Component.getData("Menu.get_eng_name",keyList));
			}
			
			BannerDTO bannerDTO = new BannerDTO();
			bannerDTO.setBM_MN_KEYNO(visiterMenu.getMN_HOMEDIV_C());
			bannerDTO.setBM_TYPE("S");
			modelAndView.addObject("bannerSiteList",Component.getList("Banner.get_siteList", bannerDTO));
			
		}
		
		if(visiterMenu != null && "en".equals(SettingData.HOMEPAGE_LANGUAGE)){
			visiterMenu.setMN_NAME(visiterMenu.getMN_ENG_NAME());
		}
		
		modelAndView.addObject("currentMenu", visiterMenu );
		if(request.getSession().getAttribute("tilesUrl")==null){
			request.getSession().setAttribute("tilesUrl", "/"+URL.split("/")[1]);
		}else{
			if(!request.getSession().getAttribute("tilesUrl").equals("/"+URL.split("/")[1])){
				request.getSession().setAttribute("tilesUrl", "/"+URL.split("/")[1]);
			}
		}

		
		//페이지 평가 관리부분
		if(visiterMenu != null) {
		String page_research = visiterMenu.getMN_RESEARCH();
		if(page_research.equals("Y")) {
			String TPS_MN_KEYNO =visiterMenu.getMN_KEYNO();
			HashMap<Integer, Object> tps_scores =Component.getData("Satisfaction.TPS_Page_eval", TPS_MN_KEYNO);
			modelAndView.addObject("tps_scores",tps_scores);
			}
		}
		menu.setMN_URL("/"+URL.split("/")[1]);
		HomeManager hm = Component.getData("Menu.AMN_getLayoutTypeByURL", menu);
		/*if(hm != null && "en".equals(SettingData.HOMEPAGE_LANGUAGE)) {
			hm.setHM_KO_TITLE(hm.getHM_EN_TITLE());
		}*/
			
		String tilesNm = "";
		if(hm != null){
			tilesNm = hm.getHM_TILES();
			modelAndView.addObject("homeData",hm);
			modelAndView.addObject("tilesNm",tilesNm);
		}
		
	if(visiterMenu !=null) {
		if(AdminMenuSessionService.checkTime(request, visiterMenu.getMN_HOMEDIV_C())){
			if(tilesNm != null && !"".equals(tilesNm)){
				List<Menu> list = Component.getList("Menu.AMN_getUserMenuListByHOMEDIV2", menu);
				if("en".equals(SettingData.HOMEPAGE_LANGUAGE)){
					for(Menu m : list){
						m.setMN_NAME(m.getMN_ENG_NAME());
					}
				}
				if(!list.isEmpty()){
					Menu m = list.get(0);
					request.getSession().setAttribute("saveMenuListTiles", m.getMN_HOMEDIV_C());
					//처음 들어왔을 때 시간 저장
			        request.getSession().setAttribute("ServerStartTime", Calendar.getInstance());
			        
				}
				//메뉴 리스트
				request.getSession().setAttribute("menuList", list);
			}
		}
	}
		// 타일즈 구분자 부착 (DB 에서 구분 코드 읽어옴 HM_TILES)
		String viewName = modelAndView.getViewName();
		if(viewName.indexOf(".") == -1){
			viewName = viewName + ".user";
		}else{
			String tiles = viewName.split("\\.")[1];
			if("none".equals(tiles)){	// none 은 아무것도 적용 안할 시 
				viewName = viewName.split("\\.")[0];
			} else if("notiles".equals(tiles)){	// notiles는 css,script 적용 시 
				viewName = viewName.split("\\.")[0] + ".notiles";
			} 
		}
		modelAndView.setViewName(viewName);
		
		
		
		//게시판 권한 처리
		if(visiterMenu != null && visiterMenu.getMN_PAGEDIV_C().equals("SC_TFOVO")){
			modelAndView.addObject("boardAuthList",getBoardAuthList(request,visiterMenu.getMN_URL())); 
		}
		
		// 타일즈에 따른 CSS/JS설정 조회
		if(visiterMenu != null){
			Map<String,Object> RMmap = new HashMap<String,Object>();
			List<Object> scopeList = new ArrayList<Object>();
			String tiles = URL.split("/")[1];
			
			if(visiterMenu.getMN_LEV() == 0){
				scopeList.add("main");
				RMmap.put("scopeList", scopeList);
			}else if(visiterMenu.getMN_PAGEDIV_C().equals(SettingData.MENU_TYPE_BOARD)){
				scopeList.add("board");
				scopeList.add("sub");				
			}else{
				scopeList.add("sub");				
			}
			scopeList.add("common");
			scopeList.add("custom");
			RMmap.put("tiles", tiles);
			RMmap.put("MN_KEYNO", visiterMenu.getMN_KEYNO());
			RMmap.put("scopeList", scopeList);
			
			String resourcesType[] = {"css", "js"};
			
			for (int i = 0; i < resourcesType.length; i++) {
				RMmap.put("resourcesType", resourcesType[i]);
				modelAndView.addObject(resourcesType[i]+"List", Component.getList("Resources.getTilesList", RMmap)); 
			}
			
		}
	}
	
	/**
	 * 게시판 서브 권한 리스트 겟
	 * @param req 
	 * @param mn_URL
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private Map<String,Boolean> getBoardAuthList(HttpServletRequest req, String URL) throws Exception {
		// TODO Auto-generated method stub
		
		List authList = Component.getList("Authority.UIA_GetListwidthUrl2",URL);
		Map<String,String> map = null;
		Map<String,Boolean> boardAuthList = new HashMap<String,Boolean>();
		Map user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		String userAuth[] = null;
		if(user != null && user.get("UIA_NAME") != null){
			userAuth =((String)user.get("UIA_NAME")).split(","); 
		}else{
			userAuth =new String[]{"ANONYMOUS"}; // 정보가 없으면 비회원 권한 셋팅
		}
		for(Object a : authList){
			map = (Map<String,String>)a;
//			System.out.println(map.get("UIR_NAME"));
			String list = map.get("AUTHORITY_LIST");
			boolean state = false;
			if(list == null){
				state = true;
			}else{
				for(String auth1 : userAuth){
					for(String auth2 : list.split(",")){
						if(auth1.equals(auth2)){
							state = true;
							break;
						}
					}
					if(state) break;
				}
				
			}
			boardAuthList.put(map.get("UIR_NAME"), state);
		}
		
		return boardAuthList;
	}
	
	/**
	 * ADMIN 쪽 셋팅
	 * @param request
	 * @param response
	 * @param handler
	 * @param modelAndView
	 * @param URL
	 * @param adminMenuByURL 
	 * @throws Exception 
	 */
	private void adminSetting(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView, String URL, Menu adminMenuByURL) throws Exception {
		
			Menu menu = new Menu(SettingData.HOMEDIV_ADMIN); //관리자 HOMEDIV_C 주입
			menu.setMN_URL(URL);
			menu.setMN_FORWARD_URL(URL);
			menu.setMN_SHOW_YN("Y");
			
			List<Menu> naviInfo = new ArrayList<Menu>();
			Menu menuForNavi = new Menu();
			if( adminMenuByURL != null ){
				modelAndView.addObject("currentMenu", adminMenuByURL);
				menuForNavi = (Menu)adminMenuByURL.clone();
				while( menuForNavi != null && !StringUtils.isEmpty( menuForNavi.getMN_MAINKEY() ) ){
					naviInfo.add( menuForNavi );
					menuForNavi.setMN_KEYNO( menuForNavi.getMN_MAINKEY() );
					menuForNavi = Component.getData("Menu.AMN_getMenuByKey", menuForNavi);
				}
				Collections.reverse(naviInfo); // 리스트 순서 뒤집기 - 뿌릴 때 편하게
				modelAndView.addObject("naviInfo", naviInfo);
				
			};
			/* 메뉴 전체정보 저장 - 메뉴UI 구현 */
			List<Menu> adminMenuList = Component.getList("Menu.AMN_getUserMenuListByHOMEDIV", menu);
			modelAndView.addObject("adminMenuList", adminMenuList);
			
            //홈페이지 구분 리스트
            modelAndView.addObject("headerHomeDivList", CommonService.getHomeDivCode(true));

	}
	
	/**
	 * 모바일 기기 값 가져오기
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

}
