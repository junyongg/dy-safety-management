package com.tx.admin.operation.popupzone.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.operation.popupzone.dto.CategoryDTO;
import com.tx.admin.operation.popupzone.dto.ListDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.file.FileManageTools;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.page.PageAccess;
import com.tx.common.security.password.MyPasswordEncoder;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class PopupZoneController {

	 
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/** 파일관리 툴 */
	@Autowired FileManageTools FileManageTools;
	
	/** 암호화 */
	@Autowired MyPasswordEncoder passwordEncoder;
	
	/**
	 * 카테고리 관리
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popupzone/category.do")
	@CheckActivityHistory(desc="카테고리 관리 페이지 방문")
	public ModelAndView categoryView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/popupzone/category/pra_popupzone_category_listView.adm");
		return mv;
	}
	
	/**
	 * 카테고리 관리 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popupzone/pagingAjax.do")
	public ModelAndView categoryViewPagingAjax(HttpServletRequest req,
			Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/popupzone/category/pra_popupzone_category_listview_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"Category.TCGM_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("Category.TCGM_getList", map));
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		mv.addObject("search", search);
		return mv;
	}
	
	
	@RequestMapping(value="/txap/operation/popupzone/insertView.do")
	@CheckActivityHistory(desc="카테고리 등록 페이지 방문")
	public ModelAndView categoryInsertView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/popupzone/category/pra_popupzone_category_insertView.adm");
		
		mv.addObject("homeDivList", CommonService.getHomeDivCode(false));
		mv.addObject("formDataList", Component.getListNoParam("Category.TCGM_getFormList"));
		mv.addObject("type","insert");
		mv.addObject("mirrorPage","/txap/operation/popupzone/category.do");
		return mv;
	}
	
	
	@RequestMapping(value = "/txap/operation/popupzone/insert.do")
	@CheckActivityHistory(desc="카테고리 등록 처리")
	@Transactional
	public ModelAndView categoryInsert(CategoryDTO CategoryDTO,  HttpServletRequest req)
			throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/operation/popupzone/category.do");
		
		CategoryDTO.setTCGM_KEYNO(CommonService.getTableKey("TCGM"));
		Component.createData("Category.TCGM_insert", CategoryDTO);

		return mv;
	}
	
	@RequestMapping(value="/txap/operation/popupzone/updateView.do")
	@CheckActivityHistory(desc="카테고리 수정/상세 페이지 방문")
	public ModelAndView categoryUpdateView(HttpServletRequest req
			, CategoryDTO CategoryDTO) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/popupzone/category/pra_popupzone_category_insertView.adm");
		
		mv.addObject("homeDivList", CommonService.getHomeDivCode(false));
		//데이터 가져오기
		mv.addObject("TCGM_DATA", Component.getData("Category.TCGM_getData", CategoryDTO));
		mv.addObject("formDataList", Component.getListNoParam("Category.TCGM_getFormList"));
		mv.addObject("mirrorPage","/txap/operation/popupzone/category.do");
		mv.addObject("type","update");
		return mv;
	}
	
	@RequestMapping(value = "/txap/operation/popupzone/update.do")
	@CheckActivityHistory(desc="카테고리 수정 처리")
	@Transactional
	public ModelAndView categoryUpdate(CategoryDTO CategoryDTO,  HttpServletRequest req)
			throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/operation/popupzone/category.do");
		
		Component.updateData("Category.TCGM_update", CategoryDTO);

		return mv;
	}
	
	@RequestMapping(value = "/txap/operation/popupzone/delete.do")
	@CheckActivityHistory(desc="카테고리 삭제 처리")
	@Transactional
	public ModelAndView MainMiniBoardDelete(CategoryDTO CategoryDTO,  HttpServletRequest req)
			throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/operation/popupzone/category.do");
		
		Component.createData("Category.TCGM_delete", CategoryDTO);

		return mv;
	}
	
	@RequestMapping(value = "/txap/operation/popupzone/createFileAjax.do")
	@ResponseBody
	@Transactional(rollbackFor=Exception.class)
	public boolean totCreateFile(HttpServletRequest req, CategoryDTO CategoryDTO)
			throws Exception {
		
		//데이터 가져오기
		List<CategoryDTO> categoryList = Component.getList("Category.TCGM_getData", CategoryDTO);
		
		boolean state = true;
		
		for(CategoryDTO dto : categoryList) {
			
			String fileName = "prp_category_" + dto.getTCGM_KEYNO().substring(dto.getTCGM_KEYNO().indexOf("_") + 1) + ".jsp";
			String filePath = propertiesService.getString("jspPath") + "publish/common/popupZone/";
			String data = SettingData.JSPDATA + dto.getTCGM_FORM();
			
			state = FileManageTools.create_File(filePath, fileName, data);
			
			filePath = filePath.substring(filePath.indexOf("publish/"));
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			//파일 내용 저장
			if(state) {
				map.put("fileName", fileName);
				map.put("filePath", filePath);
				map.put("TCGM_KEYNO", dto.getTCGM_KEYNO());
				Component.updateData("Category.TCGM_fileCreate", map);
			} else {
				break;
			}
			
		}
		
		return state;
		
	}
	
	
	
	
	/**
	 * 리스트 관리
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popupzone/list.do")
	@CheckActivityHistory(desc="카테고리 관리 페이지 방문")
	public ModelAndView listView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/popupzone/list/pra_popupzone_list_listView.adm");
		return mv;
	}
	
	/**
	 * 리스트 관리 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popupzone/list/pagingAjax.do")
	public ModelAndView listViewPagingAjax(HttpServletRequest req,
			Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/popupzone/list/pra_popupzone_list_listview_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		// SHOW_USING_YN 사용중인 리스트만 보기
		String SHOW_USING_YN = req.getParameter("SHOW_USING_YN");
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		if(SHOW_USING_YN != null) {
			map.put("SHOW_USING_YN", SHOW_USING_YN);			
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"List.TLM_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("List.TLM_getList", map));
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		mv.addObject("search", search);
		return mv;
	}
	
	/**
	 * 사용여부
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popupzone/list/check.do")
	@Transactional
	public ModelAndView listCheck(ListDTO ListDTO) throws Exception {
	
		Component.updateData("List.TLM_choiceYN", ListDTO);
		
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popupzone/list.do");
		return mv;
	}
	
	
	/**
	 * 리스트 삭제
	 * @param req
	 * @param ListDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popupzone/list/deleteAjax.do")
	@CheckActivityHistory(desc="리스트 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@ResponseBody
	public ModelAndView listDelete(ListDTO ListDTO) throws Exception{
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popupzone/list.do");
	    Component.deleteData("List.TLM_delete", ListDTO); 
	    return mv;
	}
	
	
	@RequestMapping(value="/txap/operation/popupzone/list/insertView.do")
	@CheckActivityHistory(desc="리스트 등록 페이지 방문")
	public ModelAndView listInsertView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/popupzone/list/pra_popupzone_list_insertView.adm");
		
		mv.addObject("categoryList", Component.getListNoParam("Category.TCGM_getFormList"));
		mv.addObject("type","insert");
		mv.addObject("mirrorPage","/txap/operation/popupzone/list.do");
		return mv;
	}
	
	/**
	 * 리스트 등록
	 * @param req
	 * @param ListDTO
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popupzone/list/insert.do")
	@Transactional
	public ModelAndView listInsert(HttpServletRequest req
			,ListDTO ListDTO
			,@RequestParam(value="file", required=false) MultipartFile file
			) throws Exception {
		ListDTO.setTLM_KEYNO(CommonService.getTableKey("TLM"));
		
		int width = ListDTO.getWIDTH();
		int height = ListDTO.getHEIGHT();
		
		if(file != null && !file.isEmpty()){
			FileSub FileSub = null;
			FileSub = FileUploadTools.FileUpload(file, CommonService.getTableKey("FM"), ListDTO.getTLM_REGNM(), width, height);
			ListDTO.setTLM_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		
		Component.createData("List.TLM_insert", ListDTO);
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popupzone/list.do");
		return mv;
	}
	
	
	@RequestMapping(value="/txap/operation/popupzone/list/categoryInfoAjax.do")
	@ResponseBody
	public Object categoryInfoAjax(HttpServletRequest req
			, CategoryDTO CategoryDTO
			) throws Exception {
		HashMap<String, String> data = Component.getData("Category.TCGM_getCategoryData", CategoryDTO);
		return data;
	}
	
	
	@RequestMapping(value="/txap/operation/popupzone/list/updateView.do")
	@CheckActivityHistory(desc="리스트 수정 페이지 방문")
	public ModelAndView listUpdateView(HttpServletRequest req
			, ListDTO ListDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/popupzone/list/pra_popupzone_list_insertView.adm");
		
		//데이터 가져오기
		mv.addObject("TLM_DATA", Component.getData("List.TLM_getData", ListDTO));
		mv.addObject("categoryList", Component.getListNoParam("Category.TCGM_getFormList"));
		mv.addObject("type","update");
		mv.addObject("mirrorPage","/txap/operation/popupzone/list.do");
		return mv;
	}
	
	/**
	 * 리스트 수정
	 * @param req
	 * @param ListDTO
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/popupzone/list/update.do")
	@Transactional
	public ModelAndView listUpdate(HttpServletRequest req
			,ListDTO ListDTO
			,@RequestParam(value="file", required=false) MultipartFile file
			) throws Exception {
		
		int width = ListDTO.getWIDTH();
		int height = ListDTO.getHEIGHT();
		
		if(file != null && !file.isEmpty()){
			FileSub FileSub = null;
			if(ListDTO.getTLM_FS_KEYNO() == null || ListDTO.getTLM_FS_KEYNO().equals("")){
				FileSub = FileUploadTools.FileUpload(file, CommonService.getTableKey("FM"), ListDTO.getTLM_REGNM(), width, height);
			}else{
				FileSub = FileUploadTools.imageChange(ListDTO.getTLM_FS_KEYNO(), req, ListDTO.getTLM_REGNM(), 1, true, width, height,true);
			}
			ListDTO.setTLM_FS_KEYNO(FileSub.getFS_KEYNO());
		}
		Component.updateData("List.TLM_update", ListDTO);
		
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popupzone/list.do");
		return mv;
	}
	
	@RequestMapping(value="/txap/operation/popupzone/list/delete.do")
	@CheckActivityHistory(desc="리스트 삭제 작업")
	public ModelAndView listDelete(HttpServletRequest req
			, ListDTO ListDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/popupzone/list.do");
		Component.deleteData("List.TLM_delete", ListDTO);
		return mv;
	}
	
	
	
}
