package com.tx.admin.homepage.menu.service;

import javax.servlet.http.HttpServletRequest;


/**
 * AdminMenuSessionService
 * @author 이혜주
 * @version 1.0
 * @since 2019-06-14
 */
public interface AdminMenuSessionService {

	
	/**
	 * 메뉴 최종 수정시간 저장
	 * @param req
	 * @param REGNM
	 * @throws Exception
	 */
	public void updateTime(String homeDiv) throws Exception;
	public boolean checkTime(HttpServletRequest request, String key) throws Exception;
	

    	
} 
