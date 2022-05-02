package com.tx.common.annotation.service;

import java.util.HashMap;

import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.board.dto.BoardNotice;
import com.tx.admin.homepage.menu.dto.Menu;

/**
 * 활동기록 서비스
 * @author 이재령
 * @date 2018-08-30
 *
 */
public interface ActivityHistoryService {
	
	/**
	 * 활동기록 
	 * @param keyword
	 * @param req
	 */
	public void setDesc(String desc, ModelAndView mv) throws Exception;
	
	/**
	 * 활동기록 
	 * @param keyword
	 * @param req
	 */
	public void setDesc(HashMap<String,Object> activityHistory,ModelAndView mv) throws Exception;
	

	/**
	 * 활동기록 - 게시판 액션
	 * @param menu
	 * @param boardNotice
	 * @param type
	 * @param mv
	 */
	public void setDescBoardAction(Menu menu, BoardNotice boardNotice, String type, ModelAndView mv) throws Exception;
	
	
	/**
	 * 활동기록 - 리소스 액션
	 * @param menu
	 * @param boardNotice
	 * @param type
	 * @param mv
	 */
	public void setDescResourceAction(String HOME_NAME, String resourcesName, String type, ModelAndView mv) throws Exception;
	

	
}
