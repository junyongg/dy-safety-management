package com.tx.admin.operation.research.controller;

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

import com.tx.admin.operation.satisfaction.dto.SatisfactionDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.page.PageAccess;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 
 * @FileName: ResearchController.java
 * @Project : Research
 * @Date    : 2018. 05. 14. 
 * @Author  : 이혜주	
 * @Version : 1.0
 */
@Controller
public class ResearchController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	
	/**
	 * 페이지 평가 관리
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/pageResearch.do")
	@CheckActivityHistory(desc="페이지 평가 페이지 방문")
	public ModelAndView pageResearch() throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/research/pra_research_listView.adm");
		
		return mv;
	}
	
	/**
	 * 페이지 평가 관리 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/pageResearch/pagingAjax.do")
	public ModelAndView pageResearchPagingAjax(HttpServletRequest req,
			Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/research/pra_research_listView_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Satisfaction.TPS_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("Satisfaction.TPS_getList", map));
		mv.addObject("search", search);
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		return mv;
		
		
	}
	
	
	/**
	 * 페이지 평가 관리 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/pageResearch/excelAjax.do")
	public ModelAndView pageResearchExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/research/pra_research_listView_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		mv.addObject("resultList", Component.getList("Satisfaction.TPS_getList", map));
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
	
	
	@ResponseBody
	@RequestMapping(value="/txap/operation/pageDetail.do")
	public Map<String, Object> pageDetail(
								  SatisfactionDTO SatisfactionDTO
								, @RequestParam(value="key", required=true) String key
								) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		SatisfactionDTO.setTPS_MN_KEYNO(CommonService.getKeyno(key, "MN"));
		map.put("resultList", Component.getList("Satisfaction.TPS_PageDataList", SatisfactionDTO));
		map.put("MenuName", Component.getList("Satisfaction.TPS_MenuName", SatisfactionDTO));
		return map;
	}
	
	/**
	 * 페이지 평가 관리 - 메뉴별 코멘트
	 * @param SatisfactionDTO
	 * @param key
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/pageResearch/detail.do")
	@CheckActivityHistory(desc="페이지 평가 상세 페이지")
	public ModelAndView pageResearchDetail(
			SatisfactionDTO SatisfactionDTO
			, @RequestParam(value="key", required=true) String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/research/pra_research_detail.adm");
		SatisfactionDTO.setTPS_MN_KEYNO(CommonService.getKeyno(key, "MN"));
		
		mv.addObject("MenuName", Component.getList("Satisfaction.TPS_MenuName", SatisfactionDTO));
		mv.addObject("resultData",SatisfactionDTO);
		mv.addObject("mirrorPage", "/txap/operation/pageResearch.do");
		return mv;
	}
	
	/**
	 * 페이지 평가 관리 - 메뉴별 코멘트 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/pageResearch/detail/pagingAjax.do")
	public ModelAndView pageResearchDetailPagingAjax(HttpServletRequest req,
			Common search
			, @RequestParam String TPS_MN_KEYNO
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/research/pra_research_detail_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("TPS_MN_KEYNO", TPS_MN_KEYNO);
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Satisfaction.TPS_getDetailListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("Satisfaction.TPS_getDetailList", map));
		mv.addObject("search", search);
		return mv;
		
		
	}
	
	
	/**
	 * 페이지 평가 관리 - 메뉴별 코멘트 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/pageResearch/detail/excelAjax.do")
	public ModelAndView pageResearchDetailExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			, @RequestParam String TPS_MN_KEYNO
			, @RequestParam String MenuName
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/research/pra_research_detail_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("TPS_MN_KEYNO", TPS_MN_KEYNO);
		
		mv.addObject("resultList", Component.getList("Satisfaction.TPS_getDetailList", map));
		mv.addObject("search", search);
		mv.addObject("MenuName", MenuName);
		
		
		try {
            
			Cookie cookie = new Cookie("fileDownload", "true");
	        cookie.setPath("/");
	        res.addCookie(cookie);
            
        } catch (Exception e) {
            System.out.println("쿠키 에러 :: "+e.getMessage());
        }
		return mv;
		
	}
	
	
	
}
