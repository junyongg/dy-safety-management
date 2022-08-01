package com.tx.safeAdmin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.util.tld.SiteProperties;
import com.tx.common.dto.Common;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.page.PageAccess;
import com.tx.common.service.reqapi.requestAPIservice;
import com.tx.admin.statistics.dto.LogDTO;
import com.tx.safeAdmin.dto.safebillDTO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class safeAdminLogController {

	
	@Autowired	ComponentService Component;
	
	@Autowired CommonService CommonService;
	
	@Autowired requestAPIservice requestAPI;
	/** 페이지 처리 출 */
	@Autowired
	private PageAccess PageAccess;
	
	
	/**
	 * 활동 기록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping("/sfa/sfaAdmin/logstatus.do")
	   public ModelAndView BillLog(HttpServletRequest req
			  , LogDTO search
			  , Common search2
			  , @RequestParam(value="id",required=false) String id
			  , @RequestParam(value="AH_HOMEDIV_C",required=false) String AH_HOMEDIV_C) throws Exception {
		   ModelAndView mv = new ModelAndView("/sfa/Admin/prc_admin_log");
		    
		  
		   
		   String homeKey = null;
			if(StringUtils.isNotBlank(AH_HOMEDIV_C)){
				homeKey = AH_HOMEDIV_C;
			}else{
				String siteKey = (String)req.getSession().getAttribute("SITE_KEYNO");
				if(StringUtils.isNotBlank(siteKey)){
					homeKey = siteKey;
				}else{
					homeKey = SiteProperties.getString("HOMEPAGE_REP");
				}
			}
			
			
			
			mv.addObject("AH_HOMEDIV_C", homeKey);
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
	 @RequestMapping(value="/sfa/sfaAdmin/pagingAjaxAdmin.do")
		public ModelAndView BillLogPaging(HttpServletRequest req,
				Common search
				, @RequestParam(value="UI_ID",required=false) String UI_ID
				, @RequestParam(value="AH_HOMEDIV_C",required=false) String AH_HOMEDIV_C
				) throws Exception {
			
			ModelAndView mv  = new ModelAndView("/sfa/Admin/prc_admin_logpaging.notiles");

			List<HashMap<String,Object>> searchList = Component.getSearchList(req);
			
			Map<String,Object> map = CommonService.ConverObjectToMap(search);
			
			if(searchList != null){
				map.put("searchList", searchList);
			}
			
			
			
			map.put("AH_HOMEDIV_C", AH_HOMEDIV_C);
			map.put("UI_ID", UI_ID);
			
			PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"sfa.Safe_getListCnt",map, search.getPageUnit(), 10);
			
			map.put("firstIndex", pageInfo.getFirstRecordIndex());
			map.put("lastIndex", pageInfo.getLastRecordIndex());
			map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
			
			mv.addObject("paginationInfo", pageInfo);
			
			List<HashMap<String,Object>> resultList = Component.getList("sfa.Safe_getList", map); 
			mv.addObject("resultList4", resultList);
			mv.addObject("search", search);
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
	@RequestMapping(value="/sfa/sfaAdmin/Adminexcelajax.do")
	public ModelAndView BillLogExcel(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			, @RequestParam(value="AH_HOMEDIV_C", required = false) String AH_HOMEDIV_C
			, @RequestParam(value="UI_ID", required = false) String UI_ID
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/sfa/Admin/prc_admin_log_excel.notiles");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		map.put("AH_HOMEDIV_C", AH_HOMEDIV_C);
		map.put("UI_ID", UI_ID);
		
		mv.addObject("resultList4", Component.getList("sfa.Safe_getList", map));
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
	@RequestMapping(value="/sfa/sfaAdmin/log/billdataAjax.do")
	@ResponseBody
	public Object BillLogData(HttpServletRequest req
			, LogDTO search
			) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("data", Component.getList("bills.Safe_getList",search));// 데이터 가져옴
        Object result = map;
		
		return result;
	}
	
	
	//로그 페이지 팝업 
	@RequestMapping(value="/sfa/sfaAdmin/log/controller.do")
	@ResponseBody
	public Object PopUpController(HttpServletRequest req
			, @RequestParam(value="listtable", required = false) String listtable
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/sfa/Admin/prc_admin_popup.notiles");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map = Component.getData("sfa.safepaperselect_one", listtable);  //object로 보냄 getList는 배열, getData는 object 

		
		mv.addObject("list",map); //object로 보냄
		
		
		return mv;
	}
	
	//수정페이지
		@RequestMapping(value="/sfa/safeAdmin/safeAdminUpdate.do")
		public Object UpdatePage(HttpServletRequest req
				, @RequestParam(value="listtable", required = false) String listtable
				) throws Exception {
			ModelAndView mv  = new ModelAndView("/sfa/Admin/prc_admin_updateview.notiles");
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map = Component.getData("sfa.safepaperselect_one", listtable);  //object로 보냄 getList는 배열, getData는 object

			
			mv.addObject("list",map); //object로 보냄
			mv.addObject("safeuserlist", Component.getListNoParam("sfa.safeuserselect"));
			
			
			return mv;
		}
	
}
