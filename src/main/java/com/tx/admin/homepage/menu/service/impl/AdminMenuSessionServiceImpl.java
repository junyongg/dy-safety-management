package com.tx.admin.homepage.menu.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.service.AdminMenuSessionService;
import com.tx.common.component.ComponentService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * AdminMenuSessionServiceImpl
 * 
 * @author 이혜주
 * @version 1.0
 * @since 2019-06-14
 */
public class AdminMenuSessionServiceImpl extends EgovAbstractServiceImpl implements AdminMenuSessionService {

	/** 공통 컴포넌트 */
	private ComponentService Component;
	
	private HashMap<String,Calendar> lastUpdateMenu = null;
	
	public AdminMenuSessionServiceImpl(ComponentService _Component){
		Component = _Component;
		lastUpdateMenu = new HashMap<String,Calendar>();
		List<HomeManager> homelist = Component.getListNoParam("HomeManager.HM_getList");
		for (HomeManager homeManager : homelist) {
			lastUpdateMenu.put(homeManager.getHM_MN_HOMEDIV_C(),Calendar.getInstance());
		}
	}
	
	//시간저장
	public void updateTime(String homeDiv) throws Exception {
		lastUpdateMenu.put(homeDiv,Calendar.getInstance());
	}
	
	
	public boolean checkTime(HttpServletRequest request, String key){
		boolean check = false;
		String saveMenuListTiles 	= 	 (String) request.getSession().getAttribute("saveMenuListTiles");
		Calendar ServerStartTime 	=	 (Calendar) request.getSession().getAttribute("ServerStartTime");
		Calendar updateTime = lastUpdateMenu.get(key);
		if(saveMenuListTiles == null || key == null || !saveMenuListTiles.equals(key) || (saveMenuListTiles.equals(key) && ServerStartTime.compareTo(updateTime) <= -1)){
			check = true;
		}
		
		return check;
	}
	


}
