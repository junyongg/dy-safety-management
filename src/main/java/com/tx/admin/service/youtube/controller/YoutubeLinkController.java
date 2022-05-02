package com.tx.admin.service.youtube.controller;

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

import com.tx.admin.operation.banner.dto.BannerDTO;
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
public class YoutubeLinkController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/**
	 * 메인배너 목록
	 * @param req
	 * @param MainSlide
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube.do")
	@CheckActivityHistory(desc="메인영상 관리 페이지 방문")
	public ModelAndView BannerListView(HttpServletRequest req
			, @RequestParam(value="msg",defaultValue="", required=false) String msg
			, BannerDTO BannerDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/mainMovie/pra_mainyoutube_listView.adm");
		
		if(!msg.equals("")){
			mv.addObject("msg",msg);
		}
		
		return mv;
	}
	
	/**
	 * 배너관리 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube/pagingAjax.do")
	public ModelAndView BannerListViewPagingAjax(HttpServletRequest req
			, Common search
			, @RequestParam String BM_USE_YN
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/mainMovie/pra_mainyoutube_listView_main_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("BM_USE_YN", BM_USE_YN);
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"MainMovie.MM_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("MainMovie.MM_getList", map));
		mv.addObject("search", search);
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date ();
		String sysdate = mSimpleDateFormat.format ( currentTime );
    	mv.addObject("sysdate", sysdate);
    	
    	mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		
		return mv;
		
		
	}
	
	/**
	 * 배너관리 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube/excelAjax.do")
	public ModelAndView BannerListViewExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			, @RequestParam String BM_USE_YN
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/mainMovie/pra_mainyoutube_listView_main_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("BM_USE_YN", BM_USE_YN);
		
		mv.addObject("resultList", Component.getList("MainMovie.MM_getList", map));
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
	 * 메인배너 등록화면
	 * @param req
	 * @param BannerDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube/insertView.do")
	@CheckActivityHistory(desc="메인영상 등록 페이지 방문")
	public ModelAndView mainBannerInsertView(HttpServletRequest req
			,BannerDTO BannerDTO
			, @RequestParam(value="msg",defaultValue="") String msg
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/mainMovie/pra_mainyoutube_insertView.adm");
		
		if(!msg.equals("")){
			mv.addObject("msg",msg);
		}
		
		//홈페이지 구분 리스트
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		HashMap<String, Object> data = Component.getData("Banner.BM_select", BannerDTO);
		
		mv.addObject("banner", data);
		
		mv.addObject("mirrorPage","/txap/operation/mainYoutube.do");
		return mv;
	}
	
	/**
	 * 메인배너 등록
	 * @param req
	 * @param BannerDTO
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube/insert.do")
	@Transactional
	public ModelAndView bannerInsert(HttpServletRequest req
			,BannerDTO BannerDTO
			,@RequestParam(value="file", required=false) MultipartFile file
			) throws Exception {
		BannerDTO.setBM_KEYNO(CommonService.getTableKey("BM"));
		
		if(file != null && !file.isEmpty()){
			FileSub FileSub = null;
			FileSub = FileUploadTools.FileUpload(file, CommonService.getTableKey("FM"), BannerDTO.getBM_REGNM(),false);
			BannerDTO.setBM_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		
		Component.updateData("Banner.BM_levelUpdate2", BannerDTO);
		Component.createData("Banner.BM_insert", BannerDTO);
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/mainYoutube.do");
		return mv;
	}
	
	/**
	 * 메인배너 수정
	 * @param req
	 * @param MainSlide
	 * @param MM_THUMBTEXT
	 * @param filecnt
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube/update.do")
	public ModelAndView mainBannerupdate(HttpServletRequest req
			,BannerDTO BannerDTO
			,@RequestParam (value="file", required=false)   MultipartFile file
			) throws Exception {
		
		if(file!=null && !file.isEmpty()){
			FileSub FileSub = null;
			if(BannerDTO.getBM_FS_KEYNO() == null || BannerDTO.getBM_FS_KEYNO().equals("")){
				FileSub = FileUploadTools.FileUpload(file, CommonService.getTableKey("FM"), BannerDTO.getBM_REGNM(), false);
			}else{
				FileSub = FileUploadTools.imageChange(BannerDTO.getBM_FS_KEYNO(), req, BannerDTO.getBM_REGNM(), 1, true, 134, 34,true);
			}
			BannerDTO.setBM_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		Component.updateData("Banner.BM_update", BannerDTO);
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/mainYoutube.do");
		
		return mv;
	}
	
	

	/**
	 * 배너 순서 변경
	 * @param req
	 * @param BannerDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube/level/update.do")
	public ModelAndView BannerLevelUpdate(
			  HttpServletRequest req
			, @ModelAttribute BannerDTO BannerDTO
			)throws Exception{
		Component.updateData("Banner.BM_levelUpdate", BannerDTO);
		ModelAndView mv = new ModelAndView("redirect:/txap/operation/mainYoutube.do");
		return mv;
	}
	

	/**
	 * 배너 삭제
	 * @param req
	 * @param BannerDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube/deleteAjax.do")
	@CheckActivityHistory(desc="배너 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@ResponseBody
	public ModelAndView bannerDelete(BannerDTO BannerDTO) throws Exception{
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/mainYoutube.do");
	    Component.deleteData("Banner.BM_delete", BannerDTO); 
	    return mv;
	}
	
	
	 /**
	 * 사용여부
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/mainYoutube/check.do")
	@Transactional
	public ModelAndView bannerCheck(BannerDTO BannerDTO) throws Exception {
	
		if(BannerDTO.getBM_USE_YN().equals("Y")){
			Component.updateData("Banner.BM_choiceY", BannerDTO);
		}else{
			Component.updateData("Banner.BM_choiceN", BannerDTO);
			Component.updateData("Banner.BM_choiceN2", BannerDTO);
		}
		
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/mainYoutube.do");
		return mv;
	}
	
	/* public File getThumbnail(File source, File thumbnail) throws IOException, JCodecException {
		 
		  System.out.println("extracting thumbnail from video");
		  int frameNumber = 0;
		    
		  Picture picture = FrameGrab.getFrameFromFile(source, frameNumber);
		 
		  BufferedImage bufferedImage = AWTUtil.toBufferedImage(picture);
		  ImageIO.write(bufferedImage, "png", thumbnail);
		  return thumbnail; 
	}*/
	 
}
