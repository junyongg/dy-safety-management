package com.tx.admin.homepage.menu.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;


/**
 * AdminMenuService
 * @author 신강철
 * @version 1.0
 * @since 2019-05-15
 */
public interface AdminMenuService {

	
	/**
	 * 메뉴 리스트 가져오기
	 * @param pageDivList 
	 * @param _depth 
	 * @param req
	 * @param tour
	 * @param REGNM
	 * @throws Exception
	 */
	public List<Menu> getMenuList(HomeManager homeManager, List<String> pageDivList,boolean isIncludeHomeDiv) throws Exception;
	
	public List<Menu> getMenuList(HomeManager homeManager, List<String> pageDivList) throws Exception;
	
	public List<Menu> getMenuList(HomeManager homeManager) throws Exception;
	
	/**
	 * 레이아웃 기본 파일 생성
	 * @throws Exception
	 */
	public boolean create_layoutFile(String tiles, HttpServletRequest req, Menu Menu) throws Exception;
	
	/**
	 * 레이아웃 템플릿 파일 복사
	 * @throws Exception
	 */
	public boolean copy_layoutFile(String oriTiles, String newTiles, HttpServletRequest req, Menu Menu) throws Exception;

    	
} 
