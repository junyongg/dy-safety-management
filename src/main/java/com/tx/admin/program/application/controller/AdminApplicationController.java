package com.tx.admin.program.application.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.tx.admin.program.application.dto.ApplicationDTO;
import com.tx.admin.program.application.dto.PlaceDTO;
import com.tx.admin.program.application.dto.PlaceSeatDTO;
import com.tx.admin.program.application.service.ApplicationService;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.page.PageAccess;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * @FileName: AdminApplicationController.java
 * @Date    : 2018. 01. 18. 
 * @Author  : 이재령	
 * @Version : 1.0
 */
@Controller
public class AdminApplicationController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/** 신청프로그렘 서비스  */
	@Autowired private ApplicationService ApplicationService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	/**
	 * 프로그램 관리 - 신청관리
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/application/application.do")
	@CheckActivityHistory(desc="신청관리 페이지 방문")
	public ModelAndView programApplication(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/application/pra_application.adm");
		
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 신청관리 ajax
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/txap/program/application/applicationPaingAjax.do")
	public ModelAndView programApplicationAjax(HttpServletRequest req, Map<String,Object> commandMap,
			Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/application/pra_application_data");
		mv.addObject("JangsoList", Component.getListNoParam("Place.PM_getList2"));
		mv.addObject("ProgramType", Component.getList("Code.ASC_GetList", "CB"));
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Application.AP_getDataListCnt",map, search.getPageUnit(), 10);
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		mv.addObject("paginationInfo", pageInfo);
		
		@SuppressWarnings("rawtypes")
		List<Map> list = Component.getList("Application.AP_getDataList", map);
		if (list != null) {
			String key= null;
			for(@SuppressWarnings("rawtypes") Map map1 : list) {
				key = CommonService.setKeyno(map1.get("AP_KEYNO")+"");
				map1.put("AP_KEYNO", key);
			}
		}
		mv.addObject("resultList", list);
		mv.addObject("search", search);
		return mv;
	}
	
	// 프로그램 관리 - 신청관리  엑셀
	@RequestMapping(value="/txap/program/application/applicationExcelAjax.do")
	public Object programApplicationExcel(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/application/pra_application_excel");
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		if(searchList != null){
			map.put("searchList", searchList);
		}
		mv.addObject("resultList", Component.getList("Application.AP_getDataList", map));
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
	 * 프로그램 관리 - 프로그램 마감처리
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/txap/program/application/application/deadline.do")
	@CheckActivityHistory(desc="프로그램 마감처리", homeDiv= SettingData.HOMEDIV_ADMIN)
	public void programDeadline(
				    HttpServletRequest req
				  , @RequestParam(required=false, value="AP_KEYNO") String AP_KEYNO
				  , Map<String,Object> commandMap
			) throws Exception {
		
		Component.updateData("Application.AP_Deadline", AP_KEYNO);
		
	}
	
	/**
	 * 프로그램 관리 - 신청자리스트
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/application/applicationApply.do")
	@CheckActivityHistory(desc="신청 프로그램 신청자 리스트 페이지 방문")
	public ModelAndView programApplicationApply(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/program/application/pra_applicantList.adm");
		ApplicationService.checkExpiredDate("ApplyView",req);
		ApplicationService.ViewExpiredDate("ApplyView",req);
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 신청자리스트ajax
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/txap/program/application/applicationApply/pagingAjax.do")
	public ModelAndView programApplicationApplyAjax(
				HttpServletRequest req
				, Common search
				, ApplicationDTO ApplicationDTO
			) throws Exception {
	
        ModelAndView mv  = new ModelAndView("/txap/program/application/pra_applicantList_data");
       
        List<HashMap<String,Object>> searchList = Component.getSearchList(req);
        Map<String,Object> map = CommonService.ConverObjectToMap(search);
       
        if(searchList != null){
            map.put("searchList", searchList);
        }
        
        PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Application.APP_ApplicantListCnt",map, search.getPageUnit(), 10);
        map.put("firstIndex", pageInfo.getFirstRecordIndex());
        map.put("lastIndex", pageInfo.getLastRecordIndex());
        map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
        mv.addObject("paginationInfo", pageInfo);
        //가저올데이터
        mv.addObject("resultList", Component.getList("Application.APP_ApplicantList", map));
        mv.addObject("search", search);
        return mv;
	}
	
	// 프로그램 관리 - 신청자 관리  엑셀
	@RequestMapping(value="/txap/program/application/applicationApply/excelAjax.do")
	public Object programApplicationApplyExcel(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/application/pra_applicantList_excel");
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		if(searchList != null){
			map.put("searchList", searchList);
		}
		mv.addObject("resultList", Component.getList("Application.APP_ApplicantList", map));
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
	 * 신청프로그램 관리 - 신청자 상세정보
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/application/applicationApplyDetail.do")
	@CheckActivityHistory(desc="신청자 상세정보 페이지 방문")
	public ModelAndView programApplyDetail(
			 HttpServletRequest req
			, @RequestParam(value="key") String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/program/application/pra_applicationDetail.adm");
		String APP_KEYNO = CommonService.getKeyno(key, "APP");
		mv.addObject("applicantData", Component.getData("mypage.program_apply_detail", APP_KEYNO));	//신청자 정보
		mv.addObject("applicantSaleList", Component.getList("mypage.program_sale_detail", APP_KEYNO));	//할인 종류
		mv.addObject("mirrorPage", "/txap/program/application/applicationApply.do");
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 신청관리 - 등록화면
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/application/insertView.do")
	@CheckActivityHistory(desc="신청관리 - 등록 페이지 방문")
	public ModelAndView programApplicationInsertView(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/program/application/pra_application_insert.adm");
		
		
		mv.addObject("ProgramType", Component.getList("Code.ASC_GetList", "CB"));
		mv.addObject("placeList", Component.getListNoParam("Place.PM_getList"));
		mv.addObject("discountList", Component.getListNoParam("Application.AD_getAllList"));
		mv.addObject("mirrorPage", "/txap/program/application/application.do");
		mv.addObject("action", "Insert");
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 신청관리 - 수정화면
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/txap/program/application/updateView.do")
	@CheckActivityHistory(desc="신청관리 - 수정 페이지 방문")
	public ModelAndView programApplicationUpdateView(HttpServletRequest req, Map<String,Object> commandMap
			, @RequestParam(value="key", required=false) String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/program/application/pra_application_insert.adm");
		
		ApplicationDTO app = new ApplicationDTO();
		app.setAP_KEYNO(CommonService.getKeyno(key, "AP"));
		HashMap resultData = Component.getData("Application.AP_getData", app);
		
//		resultData.put("key", key);
		mv.addObject("resultData", resultData);
		mv.addObject("ProgramType", Component.getList("Code.ASC_GetList", "CB"));
		mv.addObject("ApplyCnt", Component.getData("Application.ApplyCnt", app));
		mv.addObject("ScheduleMain", Component.getList("Application.ScheduleMain", app));
		mv.addObject("ScheduleSub", Component.getList("Application.ScheduleSub", app));
		mv.addObject("discountList", Component.getListNoParam("Application.AD_getAllList"));
		mv.addObject("placeList", Component.getListNoParam("Place.PM_getList"));
		mv.addObject("mirrorPage", "/txap/program/application/application.do");
		mv.addObject("action", "Update");
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 신청관리 - 등록
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/application/insert.do")
	@CheckActivityHistory(desc="신청관리 - 등록 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView programApplicationInsert(HttpServletRequest req, Map<String,Object> commandMap
			, ApplicationDTO ApplicationDTO
			, @RequestParam(value="schduleGroupData", required = false ) String schduleGroupData
			, @RequestParam(value="AD_KEYNO", required = false ) String AD_KEYNO[]
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/application/application.do");
		@SuppressWarnings({ "unchecked", "rawtypes" })
		Map user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		ApplicationDTO.setAP_REGNM((String)user.get("UI_KEYNO"));
		String AP_KEYNO = CommonService.getTableKey("AP");
		ApplicationDTO.setAP_KEYNO(AP_KEYNO);
		
		Component.createData("Application.AP_insertData", ApplicationDTO);
		
		//할인정책
		if(AD_KEYNO != null){
			HashMap<String,Object> adMap = new HashMap<String,Object>();
			adMap.put("AP_KEYNO", AP_KEYNO);
			adMap.put("adList", AD_KEYNO);
			Component.createData("Application.AD_insertSelectData", adMap);
		}
		
		//스케쥴 셋팅
		setSchedule(AP_KEYNO,schduleGroupData);
		
		
		return mv;
	}
	
	
	
	private void setSchedule(String AP_KEYNO, String schduleGroupData) {
		// TODO Auto-generated method stub
		//다시 배열로 만들기
		
		schduleGroupData = schduleGroupData.replaceAll("&quot;", "\"");
		
		JsonParser parser = new JsonParser();	
		JsonElement element = parser.parse(schduleGroupData);
		JsonArray schduleGrouplist =  element.getAsJsonArray();
	      
	    for(JsonElement schduleGroup : schduleGrouplist){
	    
	       
	       
	       if(!schduleGroup.isJsonNull()){
	    	   ApplicationDTO mainGroup = new ApplicationDTO();
		       
		      
		       
	          String st_date = schduleGroup.getAsJsonObject().get("st_date").getAsString();
	          String en_date = schduleGroup.getAsJsonObject().get("en_date").getAsString();
	            
	          JsonArray days = schduleGroup.getAsJsonObject().get("day").getAsJsonArray();
	          
	          if(!days.isJsonNull()) {
	        	  String GSM_DAY = "";
	         	for (int i=0;i<days.size();i++) {
	         		if(i != 0) {
	         			GSM_DAY += ",";
	         		}
	         		GSM_DAY += days.get(i).getAsString();
	         	}
	         	mainGroup.setASM_DAY(GSM_DAY);
	          }
	            
	          JsonArray times =  schduleGroup.getAsJsonObject().get("times").getAsJsonArray();
	          if(!times.isJsonNull()){
	        	  
	        	  String ASM_KEYNO = CommonService.getTableKey("ASM");
			      mainGroup.setASM_KEYNO(ASM_KEYNO);
			      mainGroup.setASM_AP_KEYNO(AP_KEYNO);
	        	  
	              for(JsonElement timeData : times){
	            	  ApplicationDTO subGroup = new ApplicationDTO();
	            	  subGroup.setASS_KEYNO(CommonService.getTableKey("ASS")); 
	            	  subGroup.setASS_ASM_KEYNO(ASM_KEYNO);
	            	
	           	   	  String st_h = timeData.getAsJsonObject().get("st_h").getAsString();
	           	      String st_m = timeData.getAsJsonObject().get("st_m").getAsString();
	           	      String en_h = timeData.getAsJsonObject().get("en_h").getAsString();
	           	      String en_m = timeData.getAsJsonObject().get("en_m").getAsString();
	           	      String cnt = timeData.getAsJsonObject().get("cnt").getAsString();
	           	      String title = timeData.getAsJsonObject().get("title").getAsString();
	           	      String start_time = st_h + ":" + st_m;
	           	      String end_time = en_h + ":" + en_m;
	           	    
	           	      subGroup.setASS_ST_TIME(start_time);
	           	      if(en_h != null && !en_h.equals("")) {
	           	    	  subGroup.setASS_EN_TIME(end_time);		           	    	
	           	      }
	           	      subGroup.setASS_MAXIMUM(cnt);
	           	      subGroup.setASS_SUBTITLE(title);
	           	    
	           	    Component.createData("Application.ASS_insertData", subGroup);
	           	    
	             }
	             
	             //스케줄 메인 등록
	             mainGroup.setASM_STDT(st_date);
	             mainGroup.setASM_ENDT(en_date);
	             
	             Component.createData("Application.ASM_insertData", mainGroup);   
	             
	         }
	          
	      }
	   }
	}

	/**
	 * 프로그램 관리 - 신청관리 - 수정
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/application/update.do")
	@CheckActivityHistory(desc="신청관리 - 수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView programApplicationUpdate(HttpServletRequest req, Map<String,Object> commandMap
			, ApplicationDTO ApplicationDTO
			, @RequestParam(value="schduleGroupData", required = false ) String schduleGroupData
			, @RequestParam(value="AD_KEYNO", required = false ) String AD_KEYNO[]
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/application/application.do");
		@SuppressWarnings({ "unchecked", "rawtypes" })
		Map user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		ApplicationDTO.setAP_MODNM((String)user.get("UI_KEYNO"));
		
		Component.updateData("Application.AP_updateData", ApplicationDTO);
		String AP_KEYNO = ApplicationDTO.getAP_KEYNO();
		//할인 정책
		HashMap<String,Object> adMap = new HashMap<String,Object>();
		adMap.put("AP_KEYNO", AP_KEYNO);
		Component.deleteData("Application.AD_deleteSelectData", adMap);
		if(AD_KEYNO != null){
			adMap.put("adList", AD_KEYNO);
			Component.createData("Application.AD_insertSelectData", adMap);
		}
		
		if(ApplicationDTO.getApp_type().equals("O")) {
			//스케쥴 셋팅
			Component.deleteData("Application.ASM_deleteData", ApplicationDTO);
			Component.deleteData("Application.ASS_deleteData", ApplicationDTO);
			setSchedule(AP_KEYNO,schduleGroupData);
		}
		
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 신청관리 - 삭제
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/application/delete.do")
	@CheckActivityHistory(desc="신청관리 - 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView programApplicationDelete(HttpServletRequest req
			, ApplicationDTO ApplicationDTO
			, @RequestParam("key") String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/application/application.do");
		
		
		ApplicationDTO.setAP_KEYNO(key);
		
		Component.updateData("Application.AP_deleteData", ApplicationDTO);
		
		return mv;
	}
	
	/**
	 * 장소 관리 - 추가 
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/program/placeList/insert.do")
	@CheckActivityHistory(desc = "장소 추가 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String programPlaceListInsert(Model model,
			PlaceDTO pm,
			@RequestParam(value="insertPlaceImg", required = false ) MultipartFile thumbnail,
			@RequestParam(value="seatGroupData", required = false ) String seatGroupData,
			HttpServletRequest req) throws Exception{ 
		
		
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		String REGNM = (String) user.get("UI_KEYNO");
		
		FileSub FileSub = null;
		if(thumbnail != null && !thumbnail.isEmpty()) {
			FileSub = FileUploadTools.FileUpload(thumbnail, CommonService.getTableKey("FM"), REGNM, true);
			pm.setPM_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		String PM_KEYNO = CommonService.getTableKey("PM");
		pm.setPM_KEYNO(PM_KEYNO);
		
		Component.createData("Place.PM_insertData", pm);
		
		if(pm.getPM_SEATPLAN_YN().equals("Y") && seatGroupData != null){ //좌석배치도 셋팅
			
			insertSeatGroupData(seatGroupData,PM_KEYNO);
		}
		
		return "redirect:/txap/program/placeList.do";
	}
	
	/**
	 * 좌석배치도 저장
	 * @param seatGroupData
	 * @param PM_KEYNO
	 */
	private void insertSeatGroupData(String seatGroupData, String PM_KEYNO) {
		// TODO Auto-generated method stub
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(seatGroupData);
		JsonArray seatGrouplist =  element.getAsJsonArray();
		List<PlaceSeatDTO> seatMainList = new ArrayList<PlaceSeatDTO>();
		List<PlaceSeatDTO> seatSubList = new ArrayList<PlaceSeatDTO>();
		PlaceSeatDTO seatMain = null;
		PlaceSeatDTO seatSub = null;
		for(JsonElement seatGroup : seatGrouplist){
			if(!seatGroup.isJsonNull()){
				
				seatMain = new PlaceSeatDTO();
				
				String title = seatGroup.getAsJsonObject().get("title").getAsString();
				int row = seatGroup.getAsJsonObject().get("row").getAsInt();
				int col = seatGroup.getAsJsonObject().get("col").getAsInt();
				int top = seatGroup.getAsJsonObject().get("top").getAsInt();
				int left = seatGroup.getAsJsonObject().get("left").getAsInt();
				String PSM_KEYNO = CommonService.getTableKey("PSM");
				seatMain.setPSM_KEYNO(PSM_KEYNO);
				seatMain.setPSM_PM_KEYNO(PM_KEYNO);
				seatMain.setPSM_NAME(title);
				seatMain.setPSM_ROW(row);
				seatMain.setPSM_COL(col);
				seatMain.setPSM_TOP(top);
				seatMain.setPSM_LEFT(left);
				seatMainList.add(seatMain);
				
				JsonArray table =  seatGroup.getAsJsonObject().get("table").getAsJsonArray();
				if(!table.isJsonNull()){
					for(int i=0;i<table.size();i++){
						JsonArray rowData =  table.get(i).getAsJsonArray();
						for(int j=0;j<rowData.size();j++){
							seatSub = new PlaceSeatDTO();
							
							seatSub.setPSS_KEYNO(CommonService.getTableKey("PSS"));
							seatSub.setPSS_PSM_KEYNO(PSM_KEYNO);
							seatSub.setPSS_ROW(i);
							seatSub.setPSS_COL(j);
							seatSub.setPSS_CODE(rowData.get(j).getAsString());
							
							seatSubList.add(seatSub);
						}
					}
				}
				
			}
		}
		
		if(seatMainList.size() > 0){
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("seatMainList", seatMainList);
			Component.createData("Place.PSM_insertData", map);
			map.put("seatSubList", seatSubList);
			Component.createData("Place.PSS_insertData", map);
			
		}
	}

	/**
	 * 장소 관리 - 수정
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/program/placeList/update.do")
	@CheckActivityHistory(desc = "장소 수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String programPlaceListUpdate(Model model,
			PlaceDTO pm,
			@RequestParam(value="insertPlaceImg", required = false ) MultipartFile thumbnail,
			@RequestParam(value="seatGroupData", required = false ) String seatGroupData,
			HttpServletRequest req) throws Exception{ 
		
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		String REGNM = (String) user.get("UI_KEYNO");
		
		FileSub FileSub = null;
		if(thumbnail != null && !thumbnail.isEmpty()) {
			if(StringUtils.isEmpty(pm.getPM_FS_KEYNO())){
				FileSub = FileUploadTools.FileUpload(thumbnail, CommonService.getTableKey("FM"), REGNM, true);
			}else{
				FileSub = FileUploadTools.imageChange(pm.getPM_FS_KEYNO(), thumbnail, REGNM, true);
			}
			
			pm.setPM_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		
		Component.updateData("Place.PM_updateData", pm);
		
		if(pm.getPM_SEATPLAN_YN().equals("Y") && seatGroupData != null){ //좌석배치도 셋팅
			String PM_KEYNO = pm.getPM_KEYNO();
			Component.deleteData("PSM_deleteData", PM_KEYNO);
			Component.deleteData("PSS_deleteData", PM_KEYNO);
			
			insertSeatGroupData(seatGroupData,PM_KEYNO);
		}
		
		return "redirect:/txap/program/placeList.do";
	}
	
	/**
	 * 장소 관리 - 삭제
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/program/placeList/delete.do")
	@CheckActivityHistory(desc = "장소 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String programPlaceListDelete(Model model,
			PlaceDTO pm,
			HttpServletRequest req) throws Exception{ 
		
		Component.updateData("Place.PM_deleteData", pm);
		
		return "redirect:/txap/program/placeList.do";
	}
	
	
	/**
	 * 프로그램 관리 - 장소관리
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/placeList.do")
	@CheckActivityHistory(desc="장소관리 페이지 방문")
	public ModelAndView programPlaceList(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/place/pra_placelist.adm");
		
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 장소관리Ajax
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/txap/program/placeList/paingAjax.do")
	public ModelAndView programPlaceListAjax(
				HttpServletRequest req
				, Common search
				, PlaceDTO place
			) throws Exception {
        ModelAndView mv  = new ModelAndView("/txap/program/place/pra_placelist_data");
       
        List<HashMap<String,Object>> searchList = Component.getSearchList(req);
        Map<String,Object> map = CommonService.ConverObjectToMap(search);
       
        if(searchList != null){
            map.put("searchList", searchList);
        }
        PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Place.PM_getDataListCnt",map, search.getPageUnit(), 10);
        map.put("firstIndex", pageInfo.getFirstRecordIndex());
        map.put("lastIndex", pageInfo.getLastRecordIndex());
        map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
        mv.addObject("paginationInfo", pageInfo);
        //가저올데이터
        mv.addObject("resultList", Component.getList("Place.PM_getDataList", map));
        mv.addObject("search", search);
        return mv;
	}
	
	// 프로그램 관리 - 장소관리 엑셀
	@RequestMapping(value="/txap/program/placeList/excelAjax.do")
	public Object programPlaceListExcel(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/place/pra_placelist_excel");
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		if(searchList != null){
			map.put("searchList", searchList);
		}
		mv.addObject("resultList", Component.getList("Place.PM_getDataList", map));
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
	 * 프로그램 관리 - 장소관리 - 등록 화면
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/placeList/insertView.do")
	@CheckActivityHistory(desc="장소관리 페이지 방문")
	public ModelAndView programPlaceListInsertView(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/place/pra_place_insertView.adm");
		mv.addObject("mirrorPage", "/txap/program/placeList.do");
		mv.addObject("action", "Insert");
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 장소관리 - 수정 화면
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/placeList/updateView.do")
	@CheckActivityHistory(desc="장소관리 페이지 방문")
	public ModelAndView programPlaceListUpdateView(HttpServletRequest req, Map<String,Object> commandMap
			, @RequestParam(value="key", required=false) String key
			, PlaceDTO place
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/place/pra_place_insertView.adm");
		
		place.setPM_KEYNO(CommonService.getKeyno(key, "PM"));
		HashMap<String,Object> resultData = Component.getData("Place.PM_getList",place); 
		mv.addObject("resultData", resultData);// 데이터 가져옴
		
		String PM_SEATPLAN_YN = (String)resultData.get("PM_SEATPLAN_YN");
		
		if("Y".equals(PM_SEATPLAN_YN)){
			List<HashMap<String,Object>> seatMainList = Component.getList("Place.PSM_getList", place);
			
			if(seatMainList != null && seatMainList.size() > 0){
				
				JSONArray list = new JSONArray();
				System.out.println();
				for(HashMap<String,Object> seatMain : seatMainList){
					JSONObject obj = new JSONObject();
					obj.put("title", (String)seatMain.get("PSM_NAME"));
					obj.put("row", seatMain.get("PSM_ROW"));
					obj.put("col", seatMain.get("PSM_COL"));
					obj.put("top", seatMain.get("PSM_TOP"));
					obj.put("left", seatMain.get("PSM_LEFT"));
					JSONArray table = new JSONArray();
					String data = (String)seatMain.get("DATA");
					String rowList[] = data.split("\\|");
					for(String row : rowList){
						JSONArray colData = new JSONArray();
						String colList[] = row.split(",");
						for(String col : colList){
							colData.put(col);
						}
						table.put(colData);
					}
					obj.put("table", table);
					list.put(obj);
				}
				
				mv.addObject("seatGroups", list.toString());
			}
		}
		
		
		
		mv.addObject("mirrorPage", "/txap/program/placeList.do");
		mv.addObject("action", "Update");
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 할인정책관리 리스트
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/discount.do")
	@CheckActivityHistory(desc="할인정책관리 페이지 방문")
	public ModelAndView programDiscount(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/program/discount/pra_discount.adm");
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 할인정책관리 - Ajax
	 * @param req
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/txap/program/discount/pagingAjax.do")
	public ModelAndView programDiscountAjax(
				HttpServletRequest req
				, Common search
				, ApplicationDTO ApplicationDTO
			) throws Exception {
        ModelAndView mv  = new ModelAndView("/txap/program/discount/pra_discount_data");
       
        List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
       
        if(searchList != null){
            map.put("searchList", searchList);
        }
        PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Application.AD_getListCnt",map, search.getPageUnit(), 10);
        map.put("firstIndex", pageInfo.getFirstRecordIndex());
        map.put("lastIndex", pageInfo.getLastRecordIndex());
        map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
        mv.addObject("paginationInfo", pageInfo);
        //가저올데이터
        mv.addObject("resultList", Component.getList("Application.AD_getList", map));
        mv.addObject("search", search);
        return mv;
	}
	
	// 프로그램 관리 - 할인정책관리 엑셀
	@RequestMapping(value="/txap/program/discount/excelAjax.do")
	public Object programDiscountExcel(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/program/discount/pra_discount_excel");
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		if(searchList != null){
			map.put("searchList", searchList);
		}
		mv.addObject("resultList", Component.getList("Application.AD_getList", map));
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
	 * 프로그램 관리 - 할인정책관리 - 데이터 가져오기
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/txap/program/discount/dataAjax.do")
	@ResponseBody
	public Map programDiscountDelete(HttpServletRequest req
			, ApplicationDTO ApplicationDTO
			) throws Exception {
		
		ApplicationDTO.setAD_KEYNO(CommonService.getKeyno(ApplicationDTO.getAD_KEYNO(), "AD"));
		
		return Component.getData("Application.AD_getData", ApplicationDTO);
	}
	
	
	/**
	 * 프로그램 관리 - 할인정책관리 - 저장
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/discount/insert.do")
	@CheckActivityHistory(desc="할인정책 등록 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	public ModelAndView programDiscountInsert(HttpServletRequest req
			, ApplicationDTO ApplicationDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/discount.do");
		
		ApplicationDTO.setAD_KEYNO(CommonService.getTableKey("AD"));
		Component.createData("Application.AD_insertData", ApplicationDTO);
		
		
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 할인정책관리 - 수정
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/discount/update.do")
	@CheckActivityHistory(desc="할인정책 수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	public ModelAndView programDiscountUpdate(HttpServletRequest req
			,@ModelAttribute ApplicationDTO ApplicationDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/discount.do");
		
		Component.updateData("Application.AD_updateData", ApplicationDTO);
		
		return mv;
	}
	
	/**
	 * 프로그램 관리 - 할인정책관리 - 삭제
	 * @param req
	 * @param commandMap
	 * @param UserDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/program/discount/delete.do")
	@CheckActivityHistory(desc="할인정책 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	public ModelAndView programDiscountDelete(HttpServletRequest req
			, ApplicationDTO ApplicationDTO
			, @RequestParam("key") String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/program/discount.do");
		ApplicationDTO.setAD_KEYNO(CommonService.getKeyno(key, "AD"));
		Component.updateData("Application.AD_deleteData", ApplicationDTO);
		
		return mv;
	}
	
}
