package com.tx.admin.operation.slide.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.operation.slide.dto.SlideDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.page.PageAccess;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MainSlideController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/**
	 * 메인슬라이드 목록
	 * @param req
	 * @param MainSlide
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/slide.do")
	@CheckActivityHistory(desc="메인슬라이드 관리 페이지 방문")
	public ModelAndView SlideListView(HttpServletRequest req
			, @RequestParam(value="msg",defaultValue="", required=false) String msg
			, SlideDTO SlideDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/slide/pra_mainslide_listView.adm");
		
		if(!msg.equals("")){
			mv.addObject("msg",msg);
		}
		
		return mv;
	}
	
	/**
	 * 메인 슬라이드 관리 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/slide/pagingAjax.do")
	public ModelAndView SlideListViewPagingAjax(HttpServletRequest req
			, Common search
			, @RequestParam String MM_USE_YN
			) throws Exception {
		
		String type = "main";
		if("N".equals(MM_USE_YN)){
			type = "sub";
		}
		ModelAndView mv  = new ModelAndView("/txap/operation/slide/pra_mainslide_listView_"+type+"_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("MM_USE_YN", MM_USE_YN);
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Slide.MM_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("Slide.MM_getList", map));
		mv.addObject("search", search);
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date ();
		String sysdate = mSimpleDateFormat.format ( currentTime );
    	mv.addObject("sysdate", sysdate);
    	
    	mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		
		return mv;
		
		
	}
	
	/**
	 * 메인 슬라이드 관리 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/slide/excelAjax.do")
	public ModelAndView SlideListViewExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			, @RequestParam String MM_USE_YN
			) throws Exception {
		
		String type = "main";
		if("N".equals(MM_USE_YN)){
			type = "sub";
		}
		ModelAndView mv  = new ModelAndView("/txap/operation/slide/pra_mainslide_listView_"+type+"_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("MM_USE_YN", MM_USE_YN);
		
		mv.addObject("resultList", Component.getList("Slide.MM_getList", map));
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
	 * 메인슬라이드 등록화면
	 * @param req
	 * @param MainSlide
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/slide/insertView.do")
	@CheckActivityHistory(desc="메인 슬라이드 등록 페이지 방문")
	public ModelAndView mainslideinsertView(HttpServletRequest req
			,SlideDTO SlideDTO
			, @RequestParam(value="msg",defaultValue="") String msg
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/slide/pra_mainslide_insertView.adm");

		if(!msg.equals("")){
			mv.addObject("msg",msg);
		}
		
		//홈페이지 구분 리스트
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		HashMap<String, Object> data = Component.getData("Slide.MM_select", SlideDTO);
		
		mv.addObject("slide", data);
		
		
		mv.addObject("mirrorPage","/txap/operation/slide.do");
		return mv;
	}
	
	/**
	 * 메인슬라이드 등록
	 * @param req
	 * @param SlideDTO
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/mainPage/slide/insert.do")
	public ModelAndView slideInsert(HttpServletRequest req
			,SlideDTO SlideDTO
			,@RequestParam (value="file", required=false)	MultipartFile file
			,@RequestParam (value="resize", required=false)	  String resize
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/slide.do");
		SlideDTO.setMM_KEYNO(CommonService.getTableKey("MM"));
		
		if(file != null && !file.isEmpty()){
			FileSub FileSub = null;
			String FM_KEY = CommonService.getTableKey("FM");	
			if("Y".equals(resize)){
				FileSub = FileUploadTools.FileUpload(file, FM_KEY, SlideDTO.getMM_REGNM(),1920,500);
			}else{
				FileSub = FileUploadTools.FileUpload(file, FM_KEY, SlideDTO.getMM_REGNM(), false);
			}
			SlideDTO.setMM_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		
		Component.updateData("Slide.MM_levelUpdate2", SlideDTO);
		Component.createData("Slide.MM_insert", SlideDTO);
		
		return mv;
	}
	

	/**
	 * 메인슬라이드 수정
	 * @param req
	 * @param SlideDTO
	 * @param file
	 * @param resize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/mainPage/slide/update.do")
	public ModelAndView mainslideupdate(HttpServletRequest req
			,SlideDTO SlideDTO
			,@RequestParam (value="resize", required=false)	  String resize
			,@RequestParam (value="file", required=false) MultipartFile file
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/slide.do");
		
		if(file!=null && !file.isEmpty()){
			FileSub FileSub = null;
			
			if(SlideDTO.getMM_FS_KEYNO() == null || SlideDTO.getMM_FS_KEYNO().equals("")){
				String FM_KEY = CommonService.getTableKey("FM");	
				if("Y".equals(resize)){
					FileSub = FileUploadTools.FileUpload(file, FM_KEY, SlideDTO.getMM_REGNM(), 1080, 308);
				}else{
					FileSub = FileUploadTools.FileUpload(file, FM_KEY, SlideDTO.getMM_REGNM(), false);
				}
			}else{
				if("Y".equals(resize)){
					FileSub = FileUploadTools.imageChange(SlideDTO.getMM_FS_KEYNO(), file, SlideDTO.getMM_REGNM(),true);
				}else{
					FileSub = FileUploadTools.imageChange(SlideDTO.getMM_FS_KEYNO(), file, SlideDTO.getMM_REGNM(),false);
				}
			}
			
			SlideDTO.setMM_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		Component.updateData("Slide.MM_update", SlideDTO);
		return mv;
	}
	
	
	/**
	 * 슬라이드 순서 변경
	 * @param req
	 * @param SlideDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/slide/level/update.do")
	public ModelAndView SlideLevelUpdate(
			  HttpServletRequest req
			, @ModelAttribute SlideDTO SlideDTO
			)throws Exception{
		Component.updateData("Slide.MM_levelUpdate", SlideDTO);
		ModelAndView mv = new ModelAndView("redirect:/txap/operation/slide.do");
		return mv;
	}
	

	/**
	 * 슬라이드 삭제
	 * @param req
	 * @param SlideDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/slide/deleteAjax.do")
	@CheckActivityHistory(desc="슬라이드 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@ResponseBody
	public ModelAndView SlideDelete(SlideDTO SlideDTO) throws Exception{
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/slide.do");
	    Component.deleteData("Slide.MM_delete", SlideDTO); 
	    return mv;
	}
	
	
	/**
	 * 사용여부
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/slide/check.do")
	@Transactional
	public ModelAndView SlideCheck(SlideDTO SlideDTO) throws Exception {
	
		if(SlideDTO.getMM_USE_YN().equals("Y")){
			Component.updateData("Slide.MM_choiceY", SlideDTO);
		}else{
			Component.updateData("Slide.MM_choiceN", SlideDTO);
			Component.updateData("Slide.MM_choiceN2", SlideDTO);
		}
		
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/slide.do");
		return mv;
	}
	
	
	
}
