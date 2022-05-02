package com.tx.admin.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.board.dto.BoardColumn;
import com.tx.admin.board.dto.BoardType;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.page.PageAccess;
import com.tx.common.security.password.MyPasswordEncoder;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardTypeController {

	 
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	
	/** 암호화 */
	@Autowired MyPasswordEncoder passwordEncoder;
	
	/**
	 * 게시판 타입관리
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/Board/typeView.do")
	@CheckActivityHistory(desc="게시판 타입관리 페이지 방문")
	public ModelAndView boardTypeView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/board/type/pra_board_type_listView.adm");
		return mv;
	}
	
	/**
	 * 게시판 타입관리 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/Board/typeView/pagingAjax.do")
	public ModelAndView boardTypeViewPagingAjax(HttpServletRequest req,
			Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/board/type/pra_board_type_listview_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"BoardType.BT_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("BoardType.BT_getList", map));
		mv.addObject("search", search);
		return mv;
		
		
	}
	
	
	/**
	 * 게시판 타입관리 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/Board/typeView/excelAjax.do")
	public ModelAndView boardTypeViewExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/board/type/pra_board_type_listview_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		mv.addObject("resultList", Component.getList("BoardType.BT_getList", map));
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
	
	@RequestMapping(value="/txap/Board/type/insertView.do")
	@CheckActivityHistory(desc="게시판타입등록 페이지 방문")
	public ModelAndView BoardInsertView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/board/type/pra_board_type_insertView.adm");
		
		//코드 AC 게시판 형태 ex)리스트형, 갤러리형
		mv.addObject("Code", Component.getList("Code.ASC_GetList", "AC"));
		mv.addObject("ColumnType", Component.getList("Code.ASC_GetList", "AJ"));
		mv.addObject("MainCodeList", Component.getListNoParam("Code.AMC_GetList"));
		mv.addObject("mirrorPage","/txap/Board/typeView.do");
		return mv;
	}
	
	
	@RequestMapping(value="/txap/Board/type/insert.do")
	@CheckActivityHistory(desc="게시판타입등록 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardInsert(@ModelAttribute BoardType BoardType
			,@RequestParam(value="BL_COLUMN_LEVEL",required = false) String BL_COLUMN_LEVEL []
			,@RequestParam(value="BL_COLUMN_NAME",required = false) String BL_COLUMN_NAME []
			,@RequestParam(value="BL_LISTVIEW_YN",required = false) String BL_LISTVIEW_YN []
			,@RequestParam(value="BL_OPTION_DATA",required = false) String BL_OPTION_DATA []
			,@RequestParam(value="BL_VALIDATE",required = false) String BL_VALIDATE []
			,@RequestParam(value="BL_TYPE",required = false) String BL_TYPE []
			,@ModelAttribute BoardColumn boardcolumn
			,HttpServletRequest req
			) throws Exception {
		
		
		BoardType.setBT_KEYNO(CommonService.getTableKey("BT"));
		Component.createData("BoardType.BT_insert", BoardType); 
		
		BoardColumn BoardColumn = new BoardColumn();
		BoardColumn.setBL_BT_KEYNO(BoardType.getBT_KEYNO());
		
		
		if(BL_COLUMN_LEVEL.length==1){
			boardcolumn.setBL_KEYNO(CommonService.getTableKey("BL"));
			boardcolumn.setBL_BT_KEYNO(BoardType.getBT_KEYNO());
			Component.createData("BoardColumn.BL_insert", boardcolumn);
		}else{
			for(int i = 0; i < BL_COLUMN_LEVEL.length; i++){
				BoardColumn.setBL_KEYNO(CommonService.getTableKey("BL"));
				BoardColumn.setBL_COLUMN_LEVEL(BL_COLUMN_LEVEL[i]);
				BoardColumn.setBL_COLUMN_NAME(BL_COLUMN_NAME[i]);
				BoardColumn.setBL_LISTVIEW_YN(BL_LISTVIEW_YN[i]);
				BoardColumn.setBL_OPTION_DATA(BL_OPTION_DATA[i]);
				BoardColumn.setBL_VALIDATE(BL_VALIDATE[i]);
				BoardColumn.setBL_TYPE(BL_TYPE[i]);
				Component.createData("BoardColumn.BL_insert", BoardColumn);
			}
		}
		
		ModelAndView mv  = new ModelAndView("redirect:/txap/Board/typeView.do");
		return mv;
	}
	
	@RequestMapping(value="/txap/Board/type/updateView.do")
	@CheckActivityHistory(desc="게시판타입수정 페이지 방문")
	public ModelAndView BoardUpdateView(@ModelAttribute BoardType BoardType
			,@ModelAttribute BoardColumn BoardColumn
			,HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/board/type/pra_board_type_updateView.adm");
		
		//코드 AC 게시판 형태 ex)리스트형, 갤러리형
		mv.addObject("BoardType",Component.getData("BoardType.BT_getData", BoardType.getBT_KEYNO()));
		mv.addObject("Code", Component.getList("Code.ASC_GetList", "AC"));
		mv.addObject("ColumnType", Component.getList("Code.ASC_GetList", "AJ"));
		mv.addObject("MainCodeList", Component.getListNoParam("Code.AMC_GetList"));
		mv.addObject("BoardColumnList",Component.getList("BoardColumn.BL_getList", BoardType.getBT_KEYNO()));
		mv.addObject("mirrorPage","/txap/Board/typeView.do");
		return mv;
	}
	
	
	@RequestMapping(value="/txap/Board/type/update.do")
	@CheckActivityHistory(desc="게시판타입수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardUpdate(@ModelAttribute BoardType BoardType
			,@RequestParam(value="BL_KEYNO",required = false) String BL_KEYNO []
			,@RequestParam(value="BL_COLUMN_LEVEL",required = false) String BL_COLUMN_LEVEL []
			,@RequestParam(value="BL_COLUMN_NAME",required = false) String BL_COLUMN_NAME []
			,@RequestParam(value="BL_VALIDATE",required = false) String BL_VALIDATE []
			,@RequestParam(value="BL_LISTVIEW_YN",required = false) String BL_LISTVIEW_YN []
			,@RequestParam(value="BL_OPTION_DATA",required = false) String BL_OPTION_DATA []
			,@RequestParam(value="BL_TYPE",required = false) String BL_TYPE []
			,@RequestParam(value="delete_bl_keyno",required = false) String delete_bl_keyno []
			,@ModelAttribute BoardColumn boardcolumn
			,HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/Board/typeView.do");
		Component.createData("BoardType.BT_update", BoardType);
		
		BoardColumn BoardColumn = new BoardColumn();
		BoardColumn.setBL_BT_KEYNO(BoardType.getBT_KEYNO());
		if(delete_bl_keyno != null){
			for(int i = 0; i < delete_bl_keyno.length; i++){
				Component.deleteData("BoardColumn.BL_delete", delete_bl_keyno[i]);
			}
		}
		if(BL_COLUMN_LEVEL.length==1){
			boardcolumn.setBL_BT_KEYNO(BoardType.getBT_KEYNO());
			if(boardcolumn.getBL_KEYNO()==null || boardcolumn.getBL_KEYNO().equals("")){
				boardcolumn.setBL_KEYNO(CommonService.getTableKey("BL"));
				Component.createData("BoardColumn.BL_insert", boardcolumn);
			}else{
				Component.updateData("BoardColumn.BL_update", boardcolumn);
			}
		}else{
			for(int i = 0; i < BL_COLUMN_LEVEL.length; i++){
				BoardColumn.setBL_KEYNO(BL_KEYNO[i]);
				BoardColumn.setBL_COLUMN_LEVEL(BL_COLUMN_LEVEL[i]);
				BoardColumn.setBL_COLUMN_NAME(BL_COLUMN_NAME[i]);
				BoardColumn.setBL_VALIDATE(BL_VALIDATE[i]);
				BoardColumn.setBL_LISTVIEW_YN(BL_LISTVIEW_YN[i]);
				BoardColumn.setBL_OPTION_DATA(BL_OPTION_DATA[i]);
				BoardColumn.setBL_TYPE(BL_TYPE[i]);
				if(BoardColumn.getBL_KEYNO()==null || BoardColumn.getBL_KEYNO().equals("")){
					BoardColumn.setBL_KEYNO(CommonService.getTableKey("BL"));
					Component.createData("BoardColumn.BL_insert", BoardColumn);
				}else{
					Component.updateData("BoardColumn.BL_update", BoardColumn);
				}
			}
		}
		return mv;
	}
	
	@RequestMapping(value = "/txap/Board/type/updateView/listAjax.do")
	@ResponseBody
	public List<BoardColumn> columnlist(
			@ModelAttribute BoardColumn BoardColumn,HttpServletRequest req
		)throws Exception{
		return Component.getList("BoardColumn.BL_getList", BoardColumn.getBL_BT_KEYNO());
	}
	
	/**
	 * 게시판 타입 삭제
	 * @param BoardType
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/Board/type/delete.do")
	@CheckActivityHistory(desc="게시판타입삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardDelete(@ModelAttribute BoardType BoardType
			,HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/txap/Board/typeView.do");
		Component.updateData("BoardType.BT_delete", BoardType);
		
		return mv;
	}
}
