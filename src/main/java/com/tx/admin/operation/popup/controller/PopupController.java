package com.tx.admin.operation.popup.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.nhncorp.lucy.security.xss.XssFilter;
import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.homepage.menu.service.AdminMenuService;
import com.tx.admin.operation.popup.dto.PopupDTO;
import com.tx.admin.operation.popup.dto.Popup_subDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.page.PageAccess;
import com.uwyn.jhighlight.fastutil.Hash;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 
 * @FileName: PopupController.java
 * @Project : popup
 * @Date    : 2017. 02. 10. 
 * @Author  : 양석기	
 * @Version : 1.0
 */
@Controller
public class PopupController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/** 메뉴리스트 서비스 */
	@Autowired private AdminMenuService AdminMenuService;
	
	/**
	 * 팝업관리
	 * @param commandMap
	 * @param msg
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popup.do")
	@CheckActivityHistory(desc="팝업 관리 페이지 방문")
	public ModelAndView popupMain(Map<String,Object> commandMap
			, @RequestParam(value="msg",defaultValue="", required=false) String msg
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/popup/pra_popup_listView.adm");
		
		if(!msg.equals("")){
			mv.addObject("msg",msg);
		}
		
		return mv;
	}
	
	/**
	 * 팝업관리 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popup/pagingAjax.do")
	public ModelAndView boardTypeViewPagingAjax(HttpServletRequest req
			, Common search
			, @RequestParam String PI_CHECK
			) throws Exception {
		
		String type = "main";
		ModelAndView mv  = new ModelAndView("/txap/operation/popup/pra_popup_listView_"+type+"_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("PI_CHECK", PI_CHECK);
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Popup.PI_getListCnt_1",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("Popup.PI_getList_1", map));
		mv.addObject("search", search);
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date ();
		String sysdate = mSimpleDateFormat.format ( currentTime );
    	mv.addObject("sysdate", sysdate);
    	
    	mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		return mv;
		
	}
	
	
	/**
	 * 팝업관리 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popup/excelAjax.do")
	public ModelAndView boardTypeViewExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			, @RequestParam String PI_CHECK
			) throws Exception {
		
		String type = "main";
		ModelAndView mv  = new ModelAndView("/txap/operation/popup/pra_popup_listView_"+type+"_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
//		map.put("PI_CHECK", PI_CHECK);
		
		mv.addObject("resultList", Component.getList("Popup.PI_getList_1", map));
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
	
	
//	/**
//	 * 팝업 순서 변경
//	 * @param req
//	 * @param Popup
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/txap/operation/popup/level/update.do")
//	@Transactional
//	@CheckActivityHistory(desc="팝업 순서 변경 작업")
//	public ModelAndView PopupLevelUpdate(
//			  HttpServletRequest req
//			, @ModelAttribute PopupDTO PopupDTO
//			)throws Exception{
//		PopupDTO.setPI_HOME_KEY((String) Component.getData("Menu.getHomeKey", PopupDTO.getPI_MN_KEYNO()));
//		Component.updateData("Popup.PI_levelUpdate", PopupDTO);
//		ModelAndView mv = new ModelAndView("redirect:/txap/operation/popup.do");
//		return mv;
//	}
	
	//팝업 추가
	@RequestMapping(value="/txap/operation/popup/insertView.do")
	@CheckActivityHistory(desc="팝업 추가 등록 페이지 방문")
	public ModelAndView popupAdd(HttpServletRequest req
			, PopupDTO PopupDTO
			, @RequestParam(value="msg",defaultValue="") String msg
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/popup/pra_popup_insertView.adm");
		if(!msg.equals("")){
			mv.addObject("msg",msg);
		}
		//홈페이지 구분 리스트
		HashMap<String, Object> data = Component.getData("Popup.PI_select", PopupDTO);
		List<Object> data2 = Component.getList("Popup.PI_select_one",PopupDTO.getPI_KEYNO());
		 
		//xss filter
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		
		if(data != null) {
            if(data.get("PI_CONTENTS") != null && !data.get("PI_CONTENTS").equals("")){
                data.put("PI_CONTENTS", filter.doFilter(data.get("PI_CONTENTS").toString()));
            }
		}
		mv.addObject("popup", data);
		mv.addObject("popup1", data2);
		mv.addObject("mirrorPage", "/txap/operation/popup.do");
		
		return mv;
	}
	
	
	//팝업 수정
	@RequestMapping(value="/txap/operation/popup/update.do")
	@CheckActivityHistory(desc="팝업 수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView popupEdit(HttpServletRequest req
         ,@ModelAttribute PopupDTO PopupDTO
         ,@RequestParam(value="fileW", required=false) MultipartFile fileW
		 ,@RequestParam(value="fileA", required=false) MultipartFile fileA
		 ,@RequestParam(value="resize", defaultValue="N") String resize
		 ,@RequestParam(value="MN_MENU_TITLE") List MN_MENU_TITLE
		 ,@RequestParam(value="MN_SUB_TITLE") List MN_SUB_TITLE
		 ,Popup_subDTO Popup_subDTO 
			) throws Exception {	
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popup.do?&msg=update");
//		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popup/insertView.do?PI_KEYNO="+PopupDTO.getPI_KEYNO()+"&msg=1");
		
		int width = 0;
		int height = 0;
		PopupDTO.setPI_RESIZE_CHECK(resize);
		if(PopupDTO.getPI_DIVISION().equals("W")){
			width = Integer.parseInt(PopupDTO.getPI_WIDTH());
			height = Integer.parseInt(PopupDTO.getPI_HEIGHT());
		}else if(PopupDTO.getPI_DIVISION().equals("B")){
			width = SettingData.DEFAULT_IMG_POPUP_WIDTH;
			height = SettingData.DEFAULT_IMG_POPUP_HEIGHT;
		}
		
		MultipartFile file = null;
		
		if(fileW != null && !fileW.isEmpty()){
			file = fileW;
		}else if(fileA != null && !fileA.isEmpty()){
			file = fileA;
		}
		
		if(file != null){
			@SuppressWarnings("unchecked")
			Map<String, Object> map = (Map<String, Object>) req.getSession().getAttribute("userInfo");
			FileSub FileSub = null;
			
			if(PopupDTO.getPI_FS_KEYNO() == null || PopupDTO.getPI_FS_KEYNO().equals("")){
				String FM_KEY = CommonService.getTableKey("FM");	
				if("Y".equals(resize)){
					FileSub = FileUploadTools.FileUpload(file, FM_KEY, (String)map.get("UI_KEYNO"),width,height);
				}else{
					FileSub = FileUploadTools.FileUpload(file, FM_KEY, (String)map.get("UI_KEYNO"), false);
				}
			}else{
				FileSub = FileUploadTools.imageChange(PopupDTO.getPI_FS_KEYNO(), file, (String)map.get("UI_KEYNO"),"Y".equals(resize));
			}
			PopupDTO.setPI_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		//팝업 서브에 삭제후 다시 추가
		//삭제
		Component.deleteData("SUB_POPUP_DELETE",PopupDTO);	
		//추가
		for(int i=0; i < MN_MENU_TITLE.size();i++) {
			PopupDTO.setPI_HOME_KEY((String) MN_MENU_TITLE.get(i));
			Popup_subDTO.setPC_PI_KEYNO(PopupDTO.getPI_KEYNO());
			Popup_subDTO.setPC_MAINKEY((String)MN_MENU_TITLE.get(i));
			if(MN_SUB_TITLE.get(i).equals("A")) {
				PopupDTO.setPI_MN_TYPE("A");
				
				Popup_subDTO.setPC_PI_MN_TYPE("A");
				Popup_subDTO.setPC_SUBKEY(MN_MENU_TITLE.get(i).toString());
			}else {
				PopupDTO.setPI_MN_TYPE("N");
				
				Popup_subDTO.setPC_PI_MN_TYPE("N");
				Popup_subDTO.setPC_SUBKEY(MN_SUB_TITLE.get(i).toString());
			}
			Component.createData("Popup.PC_insert", Popup_subDTO);
		}
		// 메인 새로 갱신
		Component.updateData("Popup.PI_update", PopupDTO);			
		return mv;
	}
	
	//팝업 등록
	@RequestMapping(value="/txap/operation/popup/insert.do")
	@CheckActivityHistory(desc="팝업 등록 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView popupSave(@RequestParam Map<String,Object> commandMap
			,@ModelAttribute PopupDTO PopupDTO
			,HttpServletRequest req
			,@ModelAttribute Popup_subDTO Popup_subDTO
			,@RequestParam(value="fileW", required=false) MultipartFile fileW
			,@RequestParam(value="fileA", required=false) MultipartFile fileA
			,@RequestParam(value="resize", defaultValue="Ninsert") String resize
			,@RequestParam(value="MN_MENU_TITLE") List MN_MENU_TITLE
			,@RequestParam(value="MN_SUB_TITLE") List MN_SUB_TITLE
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popup.do?&msg=insert");
		int width = 0;
		int height = 0;
		PopupDTO.setPI_RESIZE_CHECK(resize);
		PopupDTO.setPI_CHECK("Y");
	
		if(PopupDTO.getPI_DIVISION().equals("W")){
			PopupDTO.setPI_TOP_LOC(PopupDTO.getPI_TOP_LOC().equals("")? "10" : PopupDTO.getPI_TOP_LOC());    //상단 위치
			PopupDTO.setPI_LEFT_LOC(PopupDTO.getPI_LEFT_LOC().equals("")? "10" : PopupDTO.getPI_LEFT_LOC()); //왼쪽 위치
			PopupDTO.setPI_WIDTH(PopupDTO.getPI_WIDTH().equals("")? "300" : PopupDTO.getPI_WIDTH()); 		 //팝업 너비
			PopupDTO.setPI_HEIGHT(PopupDTO.getPI_HEIGHT().equals("")? "300" : PopupDTO.getPI_HEIGHT());      //팝업 높이		
			
			width = Integer.parseInt(PopupDTO.getPI_WIDTH());
			height = Integer.parseInt(PopupDTO.getPI_HEIGHT());
			
		}else if(PopupDTO.getPI_DIVISION().equals("B")){
			width = SettingData.DEFAULT_IMG_POPUP_WIDTH;
			height = SettingData.DEFAULT_IMG_POPUP_HEIGHT;
		}
		
		MultipartFile file = null;
		
		if(fileW != null && !fileW.isEmpty()){
			file = fileW;
		}else if(fileA != null && !fileA.isEmpty()){
			file = fileA;
		}
		
		if(file != null){
			String FM_KEY = CommonService.getTableKey("FM");	
			@SuppressWarnings("unchecked")
			Map<String, Object> map = (Map<String, Object>) req.getSession().getAttribute("userInfo");
			FileSub FileSub = null;
			
			if("Y".equals(resize)){
				FileSub = FileUploadTools.FileUpload(file, FM_KEY, (String)map.get("UI_KEYNO"),width,height);
			}else{
				FileSub = FileUploadTools.FileUpload(file, FM_KEY, (String)map.get("UI_KEYNO"), false);
			}
			
			PopupDTO.setPI_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		String PI_KEY_SUB = "";
		String PI_KEY = CommonService.getTableKey("PI");
		PopupDTO.setPI_KEYNO(PI_KEY);
		
		
		for(int i=0; i < MN_MENU_TITLE.size();i++) {
			PopupDTO.setPI_HOME_KEY((String) MN_MENU_TITLE.get(i));
			
			if(i==0) {
				PI_KEY_SUB =  PI_KEY;
			}
			
			Popup_subDTO.setPC_PI_KEYNO(PI_KEY_SUB);
			Popup_subDTO.setPC_MAINKEY((String)MN_MENU_TITLE.get(i));
			if(MN_SUB_TITLE.get(i).equals("A")) {
				PopupDTO.setPI_MN_TYPE("A");
				
				Popup_subDTO.setPC_PI_MN_TYPE("A");
				Popup_subDTO.setPC_SUBKEY(MN_MENU_TITLE.get(i).toString());
			}else {
				PopupDTO.setPI_MN_TYPE("N");
				
				Popup_subDTO.setPC_PI_MN_TYPE("N");
				Popup_subDTO.setPC_SUBKEY(MN_SUB_TITLE.get(i).toString());
			}
			Component.createData("Popup.PC_insert", Popup_subDTO);
		}
		Component.createData("Popup.PI_insert",PopupDTO);
		
		return mv;
	}
	
	/**
	 * 메뉴 리스트
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/txap/operation/popup/menu/listAjax.do")
	@ResponseBody
	public HashMap<String, Object> MenuManagerSubList(Model model,Menu Menu) throws Exception{ 
		
		HashMap<String, Object> map = new HashMap<>();
		List list= Component.getList("Menu.AMN_getUserMenuListByHOMEDIV3",Menu);
		map.put("list", list);
		
		return map;
	}
	
	
	//팝업 삭제
	@RequestMapping(value="/txap/operation/popup/deleteAjax.do")
	@CheckActivityHistory(desc="팝업 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@ResponseBody
	public ModelAndView popupDelete(PopupDTO PopupDTO) throws Exception{
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popup.do");
	    Component.deleteData("Popup.PI_delete", PopupDTO); 
	    return mv;
	}
	/**
	 * 사용여부
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popup/check.do")
	@Transactional
	public ModelAndView popupCheck(PopupDTO PopupDTO) throws Exception {
		
		if(PopupDTO.getPI_CHECK().equals("Y")){
			Component.updateData("Popup.PI_choiceY", PopupDTO);
		}else{
			Component.updateData("Popup.PI_choiceN", PopupDTO);
		}
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popup.do");
		return mv;
	}
	
	/**
	 * 
	 * 팝업 추가시 메뉴리스트 불러오기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popup/popup_menuListAjax.do")
	@ResponseBody
	public ModelAndView popup_menuListAjax(HttpServletRequest req
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/popup/pra_popup_menuList");
		
		//홈페이지 구분 리스트
		List<HomeManager> homeManagerList = CommonService.getHomeDivCode(false);
		
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		HashMap<String,Object> temp = null;
		for(HomeManager homeManager : homeManagerList){
			
			temp = new HashMap<String,Object>();
			
			temp.put("homeManager", homeManager);
			temp.put("menuList", AdminMenuService.getMenuList(homeManager,null));
			
			resultList.add(temp);
		}
		
		mv.addObject("resultList", resultList);
		
		return mv;
	}
	/**
	 * 메인에서 메뉴리스트 불러오기
	 * @param req
	 * @param mn_keyno
	 * @param name
	 * @param search_sub
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popup/popup_menuList_mainAjax.do")
	@ResponseBody
	public ModelAndView popup_menuList_mainAjax(HttpServletRequest req
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/popup/pra_popup_menuList_main");
		
		//홈페이지 구분 리스트
		List<HomeManager> homeManagerList = CommonService.getHomeDivCode(false);
		
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		HashMap<String,Object> temp = null;
		for(HomeManager homeManager : homeManagerList){
			
			temp = new HashMap<String,Object>();
			
			temp.put("homeManager", homeManager);
			temp.put("menuList", AdminMenuService.getMenuList(homeManager,null));
			
			resultList.add(temp);
		}
		
		mv.addObject("resultList", resultList);
		
		return mv;
	}
	
	
	
	/**
	 * 메뉴팝업 관리에서 메뉴클릭시 팝업 내용 띄우기 위한 소스
	 * @param req
	 * @param Main_text
	 * @param Main_value
	 * @param Sub_text
	 * @param Sub_value
	 * @param type_b
	 * @param search_sub
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popup/popup_list_subAjax.do")
	public ModelAndView popup_list_subAjax(
			HttpServletRequest req
			,@RequestParam (value="Sub_value", required=false) String Sub_value
			,@RequestParam (value="type_b", required=false) String type_b
			, Common search_sub
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/popup/pra_popup_listView_main_data_sub");
		
		List<HashMap<String,Object>> searchList_sub = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search_sub);
		
		if(searchList_sub != null){
			map.put("searchList", searchList_sub);
		}
		
		map.put("Sub_value", Sub_value);
		map.put("type_b", type_b);
		
		PaginationInfo pageInfo_sub = PageAccess.getPagInfo(search_sub.getPageIndex(),"Popup.PI_getListCnt_sub",map, search_sub.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo_sub.getFirstRecordIndex());
		map.put("lastIndex", pageInfo_sub.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo_sub.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo_sub);
		mv.addObject("resultList_sub", Component.getList("Popup.PI_getList_sub", map));
		mv.addObject("search_sub", search_sub);
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date ();
		String sysdate = mSimpleDateFormat.format ( currentTime );
    	mv.addObject("sysdate_sub", sysdate);
    	
    	mv.addObject("homeDivList_sub", CommonService.getHomeDivCode(true));
    	return mv;
	}
}