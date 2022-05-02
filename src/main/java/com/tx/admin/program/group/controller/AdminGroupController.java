package com.tx.admin.program.group.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.tx.admin.member.dto.UserDTO;
import com.tx.admin.program.application.dto.PlaceDTO;
import com.tx.admin.program.group.dto.GroupDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.page.PageAccess;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * @FileName: AdminGroupController.java
 * @Date    : 2018. 01. 23. 
 * @Author  : 이재령	
 * @Version : 1.0
 */
@Controller
public class AdminGroupController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/**
	 * 단체예약 관리 - 프로그램관리
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/program.do")
	@CheckActivityHistory(desc="단체예약관리 페이지 방문")
	public ModelAndView programApplication(
			HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/program/group/pra_group.adm");
		
		return mv;
	}

	
	/**
	 * 단체예약 관리 - 프로그램관리Ajax
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/txap/program/group/program/pagingAjax.do")
	public ModelAndView groupAjax(
				HttpServletRequest req
				, Common search
				, GroupDTO GroupDTO
			) throws Exception {
	
        ModelAndView mv  = new ModelAndView("/txap/program/group/pra_group_data");
       
        List<HashMap<String,Object>> searchList = Component.getSearchList(req);
        Map<String,Object> map = CommonService.ConverObjectToMap(search);
       
        if(searchList != null){
            map.put("searchList", searchList);
        }
        PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Group.GM_AllListCnt",map, search.getPageUnit(), 10);
        map.put("firstIndex", pageInfo.getFirstRecordIndex());
        map.put("lastIndex", pageInfo.getLastRecordIndex());
        map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
        mv.addObject("paginationInfo", pageInfo);
        //가저올데이터
        mv.addObject("resultList", Component.getList("Group.GM_AllList", map));
        mv.addObject("search", search);
        return mv;
	}
	
	// 단체예약 관리 - 프로그램관리 엑셀
	@RequestMapping(value="/txap/program/group/program/excelAjax.do")
	public Object groupExcel(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/group/pra_group_excel");
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		if(searchList != null){
			map.put("searchList", searchList);
		}
		mv.addObject("resultList", Component.getList("Group.GM_AllList", map));
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
	 * 단체예약 관리 - 프로그램관리 - 등록
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/insertView.do")
	@CheckActivityHistory(desc="단체예약관리 - 등록 페이지 방문")
	public ModelAndView programGroupInsertView(
				  HttpServletRequest req
				, Map<String,Object> commandMap
				, UserDTO UserDTO
				, PlaceDTO place
					) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/group/pra_group_insert.adm");
		
		mv.addObject("mirrorPage", "/txap/program/group/program.do");
		mv.addObject("action", "insert");
		mv.addObject("placeList", Component.getList("Place.PM_getList",place));
		return mv;
	}
	
	/**
	 * 단체예약 관리 - 프로그램관리 - 수정페이지
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/UpdateView.do")
	@CheckActivityHistory(desc="단체예약관리 - 수정 페이지 방문")
	public ModelAndView programGroupUpdateView(
			  HttpServletRequest req
			, Map<String,Object> commandMap
			, GroupDTO GroupDTO
			, PlaceDTO place
			, @RequestParam(value="key") String key
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/group/pra_group_insert.adm");
		GroupDTO.setGM_KEYNO(CommonService.getKeyno(key, "GM"));
		mv.addObject("GroupCnt", Component.getData("Group.GroupCnt", GroupDTO));
		mv.addObject("ScheduleMain", Component.getList("Group.ScheduleMain", GroupDTO));
		mv.addObject("ScheduleSub", Component.getList("Group.ScheduleSub", GroupDTO));
		mv.addObject("placeList", Component.getList("Place.PM_getList",place));
		mv.addObject("DetailData", Component.getData("Group.GM_programData", GroupDTO));
		mv.addObject("mirrorPage", "/txap/program/group/program.do");
		mv.addObject("action", "update");
		return mv;
	}
	
	/**
	 * 단체예약 관리 - 프로그램관리 - 등록처리
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/insertViewInsert.do")
	@CheckActivityHistory(desc="단체예약관리 - 등록 처리", homeDiv= SettingData.HOMEDIV_ADMIN)
	public ModelAndView insertViewInsert(
			  HttpServletRequest req
			, Map<String,Object> commandMap
			, @RequestParam(value="schduleGroupData", required = false ) String schduleGroupData
			, GroupDTO GroupDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/group/program.do");
		
			@SuppressWarnings("unchecked")
			Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
			String REGNM = (String) user.get("UI_KEYNO");
			
			GroupDTO.setGM_REGNM(REGNM);
			String GM_KEYNO = GroupDTO.setGM_KEYNO(CommonService.getTableKey("GM"));
			
			Component.createData("Group.GM_Insert", GroupDTO);
			
			//다시 배열로 만들기
			schduleGroupData = schduleGroupData.replaceAll("&quot;", "\"");
			
			JsonParser parser = new JsonParser();	
			JsonElement element = parser.parse(schduleGroupData);
			JsonArray schduleGrouplist =  element.getAsJsonArray();
		      
		    System.out.println(schduleGrouplist.size());
		      
		    for(JsonElement schduleGroup : schduleGrouplist){
		    	
		       String GSM_KEYNO = GroupDTO.setGSM_KEYNO(CommonService.getTableKey("GSM"));
		       GroupDTO.setGSM_GM_KEYNO(GM_KEYNO);
		       
		       if(!schduleGroup.isJsonNull()){
		          String st_date = schduleGroup.getAsJsonObject().get("st_date").getAsString();
		          String en_date = schduleGroup.getAsJsonObject().get("en_date").getAsString();
		            
		          System.out.println("시작일 : " + st_date);
		          System.out.println("종료일 : " + en_date);
		          
		          JsonArray days = schduleGroup.getAsJsonObject().get("day").getAsJsonArray();
		          System.out.println("days size : " + days.size());
		          
		          if(!days.isJsonNull()) {
		        	  String GSM_DAY = "";
		         	for (int i=0;i<days.size();i++) {
		         		if(i != 0) {
		         			GSM_DAY += ",";
		         		}
		         		GSM_DAY += days.get(i).getAsString();
		         	}
		         	GroupDTO.setGSM_DAY(GSM_DAY);
		          }
		            
		          JsonArray times =  schduleGroup.getAsJsonObject().get("times").getAsJsonArray();
		          System.out.println("times size : " + times.size());
		          if(!times.isJsonNull()){
		             for(JsonElement timeData : times){
		            	
		            	GroupDTO.setGSS_KEYNO(CommonService.getTableKey("GSS")); 
		            	GroupDTO.setGSS_GSM_KEYNO(GSM_KEYNO);
		            	
		           	    String st_h = timeData.getAsJsonObject().get("st_h").getAsString();
		           	    String st_m = timeData.getAsJsonObject().get("st_m").getAsString();
		           	    String en_h = timeData.getAsJsonObject().get("en_h").getAsString();
		           	    String en_m = timeData.getAsJsonObject().get("en_m").getAsString();
		           	    String cnt = timeData.getAsJsonObject().get("cnt").getAsString();
		           	    String title = timeData.getAsJsonObject().get("title").getAsString();
		           	    String start_time = st_h + ":" + st_m;
		           	    String end_time = en_h + ":" + en_m;
		           	    
		           	    GroupDTO.setGSS_ST_TIME(start_time);
		           	    if(en_h != null && !en_h.equals("")) {
		           	    	GroupDTO.setGSS_EN_TIME(end_time);		           	    	
		           	    }
		           	    GroupDTO.setGSS_MAXIMUM(cnt);
		           	    GroupDTO.setGSS_SUBTITLE(title);
		           	    
		           	    Component.createData("Group.GSS_Insert", GroupDTO);
		           	    
		            }
		         }
		          
		         //스케줄 메인 등록
			     GroupDTO.setGSM_STDT(st_date);
			     GroupDTO.setGSM_ENDT(en_date);
//			     GroupDTO.setGSM_DAY(gSM_DAY);
			      
			     Component.createData("Group.GSM_Insert", GroupDTO);   
		      }
		   }
			
		mv.addObject("mirrorPage", "/txap/program/group/program.do");
		return mv;
	}
	
	/**
	 * 단체예약 관리 - 프로그램관리 - 수정처리
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/insertViewUpdate.do")
	@CheckActivityHistory(desc="단체예약관리 - 수정 처리", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView insertViewUpdate(
			HttpServletRequest req
			, Map<String,Object> commandMap
			, @RequestParam(value="schduleGroupData", required = false ) String schduleGroupData
			, GroupDTO GroupDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/group/program.do");
		
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		String REGNM = (String) user.get("UI_KEYNO");
		
		GroupDTO.setGM_MODNM(REGNM);
		String GM_KEYNO = GroupDTO.getGM_KEYNO();
		
		Component.updateData("Group.GM_Update", GroupDTO);
		
		Component.deleteData("Group.GSS_Delete", GroupDTO);
		Component.deleteData("Group.GSM_Delete", GroupDTO);
		
		//다시 배열로 만들기
		schduleGroupData = schduleGroupData.replaceAll("&quot;", "\"");
		
		JsonParser parser = new JsonParser();	
		JsonElement element = parser.parse(schduleGroupData);
		JsonArray schduleGrouplist =  element.getAsJsonArray();
		
		System.out.println(schduleGrouplist.size());
		
		for(JsonElement schduleGroup : schduleGrouplist){
			
			String GSM_KEYNO = GroupDTO.setGSM_KEYNO(CommonService.getTableKey("GSM"));
			GroupDTO.setGSM_GM_KEYNO(GM_KEYNO);
			
			if(!schduleGroup.isJsonNull()){
				String st_date = schduleGroup.getAsJsonObject().get("st_date").getAsString();
				String en_date = schduleGroup.getAsJsonObject().get("en_date").getAsString();
				
				System.out.println("시작일 : " + st_date);
				System.out.println("종료일 : " + en_date);
				
				if(schduleGroup.getAsJsonObject().get("day") != null) {
						JsonArray days = schduleGroup.getAsJsonObject().get("day").getAsJsonArray();
						System.out.println("days size : " + days.size());
						
						if(!days.isJsonNull()) {
							String GSM_DAY = "";
							for (int i=0;i<days.size();i++) {
								if(i != 0) {
									GSM_DAY += ",";
								}
								GSM_DAY += days.get(i).getAsString();
							}
							GroupDTO.setGSM_DAY(GSM_DAY);
						}
				}
				
				JsonArray times =  schduleGroup.getAsJsonObject().get("times").getAsJsonArray();
				System.out.println("times size : " + times.size());
				if(!times.isJsonNull()){
					for(JsonElement timeData : times){
						
						GroupDTO.setGSS_KEYNO(CommonService.getTableKey("GSS")); 
						GroupDTO.setGSS_GSM_KEYNO(GSM_KEYNO);
						
						String st_h = timeData.getAsJsonObject().get("st_h").getAsString();
						String st_m = timeData.getAsJsonObject().get("st_m").getAsString();
						String en_h = timeData.getAsJsonObject().get("en_h").getAsString();
						String en_m = timeData.getAsJsonObject().get("en_m").getAsString();
						String cnt = timeData.getAsJsonObject().get("cnt").getAsString();
						String title = timeData.getAsJsonObject().get("title").getAsString();
						System.out.println("시작시 : "+ st_h);
						System.out.println("시작분 : "+ st_m);
						System.out.println("종료시 : "+ en_h);
						System.out.println("종료분 : "+ en_m);
						System.out.println("정원 : "+ cnt);
						System.out.println("제목 : "+ title);
						String start_time = st_h + ":" + st_m;
						String end_time = en_h + ":" + en_m;
						System.out.println("시작 : "+ start_time);
						System.out.println("종료 : "+ end_time);
						
						GroupDTO.setGSS_ST_TIME(start_time);
						if(en_h != null && !en_h.equals("")) {
							GroupDTO.setGSS_EN_TIME(end_time);		           	    	
						}
						GroupDTO.setGSS_MAXIMUM(cnt);
						GroupDTO.setGSS_SUBTITLE(title);
						
						Component.createData("Group.GSS_Insert", GroupDTO);
						
					}
				}
				
				//스케줄 메인 등록
				GroupDTO.setGSM_STDT(st_date);
				GroupDTO.setGSM_ENDT(en_date);
//			     GroupDTO.setGSM_DAY(gSM_DAY);
				
				Component.createData("Group.GSM_Insert", GroupDTO);   
			}
		}
		
		mv.addObject("mirrorPage", "/txap/program/group/program.do");
		return mv;
	}
	
	/**
	 * 단체예약 관리 - 프로그램관리 - 삭제
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/delete.do")
	@CheckActivityHistory(desc="신청관리 - 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView programApplicationDelete(HttpServletRequest req
			, GroupDTO GroupDTO
			, @RequestParam("key") String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/group/program.do");
		
		GroupDTO.setGM_KEYNO(key);
		
		Component.updateData("Group.GM_Delete", GroupDTO);
		
		return mv;
	}

	/**
	 * 단체예약 관리 - 프로그램관리 - 스케줄 추가
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/subProgramInsert.do")
	@CheckActivityHistory(desc="단체예약관리 - 프로그램 스케줄 추가", homeDiv= SettingData.HOMEDIV_ADMIN)
	public GroupDTO subProgramInsert(
			  HttpServletRequest req
			, Map<String,Object> commandMap
			, GroupDTO GroupDTO
			) throws Exception {
		
		GroupDTO.setGM_KEYNO(CommonService.getTableKey("GM"));
		GroupDTO.setGSM_KEYNO(CommonService.getTableKey("GSM"));
		
		return GroupDTO;
	}
	
	
	/**
	 * 단체예약 관리 - 신청자 관리
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/apply.do")
	@CheckActivityHistory(desc="단체예약관리 페이지 방문")
	public ModelAndView programApply(
			HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/program/group/pra_applyList.adm");
		
		return mv;
	}

	/**
	 * 단체예약 관리 - 신청자 관리Ajax
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/txap/program/group/apply/pagingAjax.do")
	public ModelAndView applyAjax(
				HttpServletRequest req
				, Common search
				, GroupDTO GroupDTO
			) throws Exception {
        ModelAndView mv  = new ModelAndView("/txap/program/group/pra_applyList_data");
       
        List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
       
        if(searchList != null){
            map.put("searchList", searchList);
        }
        PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Group.GP_SelectCnt",map, search.getPageUnit(), 10);
        map.put("firstIndex", pageInfo.getFirstRecordIndex());
        map.put("lastIndex", pageInfo.getLastRecordIndex());
        map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
        mv.addObject("paginationInfo", pageInfo);
        //가저올데이터
        mv.addObject("resultList", Component.getList("Group.GP_Select", map));
        mv.addObject("search", search);
        return mv;
	}
	
	// 단체예약 관리 - 신청자 관리 엑셀
	@RequestMapping(value="/txap/program/group/apply/excelAjax.do")
	public Object applyExcel(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/group/pra_applyList_excel");
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		if(searchList != null){
			map.put("searchList", searchList);
		}
		mv.addObject("resultList", Component.getList("Group.GP_Select", map));
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
	 * 단체예약 관리 - 신청자 상세정보
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/group/applyDetail.do")
	@CheckActivityHistory(desc="단체예약관리 페이지 방문")
	public ModelAndView programApplyDetail(
			 HttpServletRequest req
			, @RequestParam("key") String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/program/group/pra_applyDetail.adm");
		String GP_KEYNO = CommonService.getKeyno(key, "GP");
		mv.addObject("applyData", Component.getData("mypage.tour_apply_detail", GP_KEYNO));
		mv.addObject("mirrorPage", "/txap/program/group/apply.do");
		return mv;
	}
	
}
