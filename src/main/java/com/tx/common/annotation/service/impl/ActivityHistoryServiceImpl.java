package com.tx.common.annotation.service.impl;

import java.util.HashMap;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.board.dto.BoardNotice;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.common.annotation.service.ActivityHistoryService;

/**
 * 활동기록 서비스
 * @author 이재령
 * @date 2018-08-30
 *
 */
@Service("ActivityHistoryService")
public class ActivityHistoryServiceImpl implements ActivityHistoryService {
	
	
	
	@Override
	public void setDesc(String desc, ModelAndView mv) throws Exception {
		// TODO Auto-generated method stub
		
		HashMap<String,Object> activityHistory = new HashMap<String,Object>();
		activityHistory.put("desc", desc);
		
		mv.addObject("activityHistory",activityHistory);
	}
	
	@Override
	public void setDesc(HashMap<String,Object> activityHistory, ModelAndView mv) throws Exception {
		// TODO Auto-generated method stub

	}

	/**
	 * 활동기록 - 게시판 액션
	 * @param menu
	 * @param boardNotice
	 * @param type
	 * @param mv
	 */
	public void setDescBoardAction(Menu menu, BoardNotice boardNotice, String type, ModelAndView mv)  throws Exception{
		HashMap<String,Object> activityHistory = new HashMap<String,Object>();
		
		String action = "";
		if("insert".equals(type)){
			action = "등록 작업";
		}else if("insertView".equals(type)){
			action  = "등록화면 방문";
		}else if("update".equals(type)){
			action = "수정 작업";
		}else if("updateView".equals(type)){
			action  = "수정화면 방문";
		}else if("move".equals(type)){
			action = "이동 작업";
		}else if("moveView".equals(type)){
			action  = "이동화면 방문";
		}else if("detail".equals(type)){
			action  = "상세화면 방문";
		}else if("delete".equals(type)){
			action  = "삭제 작업";
		}else if("recovery".equals(type)){
			action  = "복원 작업";
		}else if("show".equals(type)){
			action  = "보이기 처리 작업";
		}else if("hide".equals(type)){
			action  = "숨김 처리 작업";
		}
		
		String desc = "";
		if(type.endsWith("insertView")){
			desc = menu.getMN_NAME() + " 게시물 " + action;
		}else{
			desc = menu.getMN_NAME() + " '" + boardNotice.getBN_TITLE() + "' 게시물 " + action;
		}
		activityHistory.put("desc", desc);
		activityHistory.put("homeDiv", menu.getMN_HOMEDIV_C());
		
		mv.addObject("activityHistory",activityHistory);
	}
	
	
	/**
	 * 활동기록 - 리소스 액션
	 * @param menu
	 * @param boardNotice
	 * @param type
	 * @param mv
	 */
	public void setDescResourceAction(String HOME_NAME, String resourcesName, String type, ModelAndView mv)  throws Exception{
		HashMap<String,Object> activityHistory = new HashMap<String,Object>();
		
		String action = "";
		if("insert".equals(type)){
			action = "등록 작업";
		}else if("insertView".equals(type)){
			action  = "등록화면 방문";
		}else if("update".equals(type)){
			action = "수정 작업";
		}else if("delete".equals(type)){
			action  = "삭제 작업";
		}else if("recovery".equals(type)){
			action  = "복원 작업";
		}else if("distribute".equals(type)){
			action  = "배포 작업";			
		}
		
		String desc = "";
		desc = HOME_NAME + " "+ resourcesName + " " + action;
		activityHistory.put("desc", desc);
		activityHistory.put("homeDiv", HOME_NAME);
		
		mv.addObject("activityHistory",activityHistory);
	}

	

}
