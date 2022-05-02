package com.tx.admin.statistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.statistics.dto.LogDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.page.PageAccess;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * @FileName: AdminLogController.java
 * @Date    : 2017. 12. 15. 
 * @Author  : 이재령	
 * @Version : 1.0
 */
@Controller
public class AdminLogController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	
	/**
	 * 활동 기록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/statistics/log.do")
	@CheckActivityHistory(desc="활동 기록 페이지 방문")
	public ModelAndView adminOperationLog(HttpServletRequest req
			, LogDTO search
			, @RequestParam(value="id",required=false) String id
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/statistics/log/pra_log_listView.adm");
		
		// 홈페이지 구분 리스트
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		if(id != null){
			search.setUI_ID(id);
		} 
		
		mv.addObject("search", search);
		return mv;
	}
	
	
	/**
	 * 활동 기록 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/statistics/log/pagingAjax.do")
	public ModelAndView adminOperationLogPagingAjax(HttpServletRequest req,
			Common search
			, @RequestParam(value="AH_HOMEDIV_C", required = false) String AH_HOMEDIV_C
			, @RequestParam(value="UI_ID", required = false) String UI_ID
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/statistics/log/pra_log_listView_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		map.put("AH_HOMEDIV_C", AH_HOMEDIV_C);
		map.put("UI_ID", UI_ID);
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Log.AH_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("Log.AH_getList", map));
		mv.addObject("search", search);
		
		// 홈페이지 구분 리스트
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		return mv;
		
		
	}
	
	
	/**
	 * 활동 기록 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/statistics/log/excelAjax.do")
	public ModelAndView adminOperationLogExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			, @RequestParam(value="AH_HOMEDIV_C", required = false) String AH_HOMEDIV_C
			, @RequestParam(value="UI_ID", required = false) String UI_ID
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/statistics/log/pra_log_listView_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		map.put("AH_HOMEDIV_C", AH_HOMEDIV_C);
		map.put("UI_ID", UI_ID);
		
		mv.addObject("resultList", Component.getList("Log.AH_getList", map));
		mv.addObject("search", search);
		
		try {
            
			Cookie cookie = new Cookie("fileDownload", "true");
	        cookie.setPath("/");
	        res.addCookie(cookie);
            
        } catch (Exception e) {
            System.out.println("쿠키 에러 :: "+e.getMessage());
        }
		return mv;
		
	}
	
	
	
	/**
	 * 활동 기록 - 데이터 가져오기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/statistics/log/dataAjax.do")
	@ResponseBody
	public Object adminOperationLogDataAjax(HttpServletRequest req
			, LogDTO search
			) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("data", Component.getList("Log.AH_getList",search));// 데이터 가져옴
        Object result = map;
		
		return result;
	}
	
	
}
