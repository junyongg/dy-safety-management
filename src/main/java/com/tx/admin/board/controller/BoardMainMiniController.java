package com.tx.admin.board.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ibm.icu.text.SimpleDateFormat;
import com.tx.admin.board.dto.BoardColumn;
import com.tx.admin.board.dto.BoardMainMini;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.homepage.resource.dto.ResourcesDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.file.FileManageTools;
import com.tx.common.page.PageAccess;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardMainMiniController {

	 
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** 파일관리 툴 */
	@Autowired FileManageTools FileManageTools;
	
	/**
	 * 메인미니게시판 관리
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/Board/MainMiniBoard.do")
	@CheckActivityHistory(desc="메인미니게시판 관리 페이지 방문")
	public ModelAndView MainMiniBoardView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/board/mainmini/pra_board_mainmini_listView.adm");
		return mv;
	}
	
	/**
	 * 메인미니게시판 관리 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/Board/MainMiniBoardView/pagingAjax.do")
	public ModelAndView MainMiniBoardViewPagingAjax(HttpServletRequest req,
			Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/board/mainmini/pra_board_mainmini_listview_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"BoardMainMini.BMM_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("BoardMainMini.BMM_getList", map));
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		mv.addObject("search", search);
		return mv;
	}
	
	@RequestMapping(value="/txap/Board/MainMiniBoard/insertView.do")
	@CheckActivityHistory(desc="미니게시판 등록 페이지 방문")
	public ModelAndView MainMiniBoardInsertView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/board/mainmini/pra_board_mainmini_insertView.adm");
		
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		mv.addObject("formDataList", Component.getListNoParam("BoardMainMini.BMM_getFormList"));
		mv.addObject("type","insert");
		mv.addObject("mirrorPage","/txap/Board/MainMiniBoard.do");
		return mv;
	}
	
	@RequestMapping(value="/txap/Board/MainMiniBoard/updateView.do")
	@CheckActivityHistory(desc="미니게시판 수정/상세 페이지 방문")
	public ModelAndView MainMiniBoardUpdateView(HttpServletRequest req
			, BoardMainMini BoardMainMini) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/board/mainmini/pra_board_mainmini_insertView.adm");
		
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		//데이터 가져오기
		mv.addObject("BMM_DATA", Component.getData("BoardMainMini.BMM_getData", BoardMainMini));
		mv.addObject("formDataList", Component.getListNoParam("BoardMainMini.BMM_getFormList"));
		mv.addObject("mirrorPage","/txap/Board/MainMiniBoard.do");
		mv.addObject("type","update");
		return mv;
	}
	
	@RequestMapping(value = "/txap/Board/MainMiniBoard/update.do")
	@CheckActivityHistory(desc="미니게시판 수정 처리")
	@Transactional
	public ModelAndView MainMiniBoardUpdate(BoardMainMini BoardMainMini,  HttpServletRequest req)
			throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/MainMiniBoard.do");
		
		Component.updateData("BoardMainMini.BMM_update", BoardMainMini);
		
		BoardMainMini = Component.getData("BoardMainMini.BMM_getData", BoardMainMini);
		
		String fileName = "prp_" + BoardMainMini.getKEYNO() + ".jsp";
		String filePath = propertiesService.getString("jspPath") + "publish" + BoardMainMini.getBMM_MN_HOMEDIV_URL() + "/miniBoard/";
		String data = SettingData.JSPDATA + BoardMainMini.getBMM_FORM();
		
		FileManageTools.create_File(filePath, fileName, data);

		return mv;
	}
	
	@RequestMapping(value = "/txap/Board/MainMiniBoard/delete.do")
	@CheckActivityHistory(desc="미니게시판 삭제 처리")
	@Transactional
	public ModelAndView MainMiniBoardDelete(BoardMainMini BoardMainMini,  HttpServletRequest req)
			throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/MainMiniBoard.do");
		
		Component.createData("BoardMainMini.BMM_delete", BoardMainMini);

		return mv;
	}
	
	
	/**
	 * 게시판 선택 시 게시판에 해당 되는 컬럼 데이터 불러오기
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/MainMiniBoard/board/selectAjax.do")
	@ResponseBody
	public List<HashMap<String,Object>> selectAjax(HttpServletRequest req, @ModelAttribute Menu Menu) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("MN_KEYNO", Menu.getMN_KEYNO());
		map.put("DATABASE", propertiesService.getString("databaseName"));
		
		List<HashMap<String,Object>> list = Component.getList("BoardMainMini.BoardColumn_List", map);
		
		return list;
	}
	
	@RequestMapping(value = "/txap/Board/MainMiniBoard/insert.do")
	@CheckActivityHistory(desc="미니게시판 등록 처리")
	@Transactional
	public ModelAndView MainMiniBoardInsert(BoardMainMini BoardMainMini,  HttpServletRequest req)
			throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/MainMiniBoard.do");
		
		BoardMainMini.setBMM_KEYNO(CommonService.getTableKey("BMM"));
		Component.createData("BoardMainMini.BMM_insert", BoardMainMini);
		
		BoardMainMini = Component.getData("BoardMainMini.BMM_getData", BoardMainMini);
		
		String fileName = "prp_" + BoardMainMini.getKEYNO() + ".jsp";
		String filePath = propertiesService.getString("jspPath") + "publish" + BoardMainMini.getBMM_MN_HOMEDIV_URL() + "/miniBoard/";
		String data = SettingData.JSPDATA + BoardMainMini.getBMM_FORM();
		
		FileManageTools.create_File(filePath, fileName, data);

		return mv;
	}
	
	@RequestMapping(value = "/txap/Board/MainMiniBoard/publishAjax.do")
	@ResponseBody
	@CheckActivityHistory(desc="미니게시판 파일 배포 처리")
	@Transactional
	public boolean publishFile(BoardMainMini BoardMainMini, HttpServletRequest req)
			throws Exception {
		
		boolean state = true;
		
		//데이터 가져오기
		List<BoardMainMini> list = Component.getList("BoardMainMini.BMM_getData", BoardMainMini);
		
		if(list.size() > 0){
			for (BoardMainMini dto: list) {
				String fileName = "prp_" + dto.getBMM_KEYNO() + ".jsp";
				String filePath = propertiesService.getString("jspPath") + "publish" + dto.getBMM_MN_HOMEDIV_URL() + "/miniBoard/";
				String data = SettingData.JSPDATA + dto.getBMM_FORM();
				
				state = FileManageTools.create_File(filePath, fileName, data);
				
				if(!state){
					break;
				}
			}
		}
		
		return state;
		
	}
	
}
