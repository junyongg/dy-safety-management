package com.tx.admin.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.plexus.util.StringUtils;
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
import com.tx.admin.board.dto.BoardColumn;
import com.tx.admin.board.dto.BoardColumnData;
import com.tx.admin.board.dto.BoardComment;
import com.tx.admin.board.dto.BoardHtml;
import com.tx.admin.board.dto.BoardNotice;
import com.tx.admin.board.dto.BoardType;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.annotation.service.ActivityHistoryService;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.page.PageAccess;
import com.tx.common.security.password.MyPasswordEncoder;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;
	@Autowired
	CommonService CommonService;

	/** 파일업로드 툴 */
	@Autowired
	private FileUploadTools FileUploadTools;

	/** 암호화 */
	@Autowired
	MyPasswordEncoder passwordEncoder;

	/** 활동기록 서비스 */
	@Autowired
	private ActivityHistoryService ActivityHistoryService;

	/** 페이지 처리 출 */
	@Autowired
	private PageAccess PageAccess;

	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * 게시물 관리 - 게시물
	 * 
	 * @param BoardType
	 * @param HireUserDTO
	 * @param Menu
	 * @param req
	 * @param HOME_MN_KEYNO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/dataView.do")
	@CheckActivityHistory(desc = "게시물 페이지 방문")
	public ModelAndView BoardDataListView(HttpServletRequest req,
			@RequestParam(value = "MN_KEYNO", required = false) String MN_KEYNO) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_listView.adm");

		if (StringUtils.isNotEmpty(MN_KEYNO)) {
			mv.addObject("BoardColumnList", Component.getList("BoardColumn.BL_getviewList2", MN_KEYNO));
			Menu Menu = new Menu();
			Menu.setMN_KEYNO(MN_KEYNO);
			Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
			mv.addObject("Menu", Menu);
			if (Menu != null) {
				mv.addObject("BoardType", Component.getData("BoardType.BT_getData", Menu.getMN_BT_KEYNO()));
			}

		}

		mv.addObject("homeDivList", CommonService.getHomeDivCode(false));

		return mv;
	}

	/**
	 * 게시물 관리 - 게시물 - 페이징 ajax
	 * 
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/dataView/pagingAjax.do")
	public ModelAndView BoardDataListViewPagingAjax(HttpServletRequest req, Common search,
			@RequestParam(value = "MN_KEYNO", required = false) String MN_KEYNO) throws Exception {

		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_listView_data");

		List<HashMap<String, Object>> searchList = Component.getSearchList(req);

		Map<String, Object> map = CommonService.ConverObjectToMap(search);
		map.put("MN_KEYNO", MN_KEYNO);
		if (searchList != null) {
			map.put("searchList", searchList);
		}

		map.put("BOARD_COLUMN_TYPE_CHECK", SettingData.BOARD_COLUMN_TYPE_CHECK);
		map.put("BOARD_COLUMN_TYPE_CHECK_CODE", SettingData.BOARD_COLUMN_TYPE_CHECK_CODE);
		map.put("BOARD_COLUMN_TYPE_RADIO_CODE", SettingData.BOARD_COLUMN_TYPE_RADIO_CODE);
		map.put("BOARD_COLUMN_TYPE_SELECT_CODE", SettingData.BOARD_COLUMN_TYPE_SELECT_CODE);

		List<BoardColumn> BoardColumnList = Component.getList("BoardColumn.BL_getviewList2", MN_KEYNO);
		map.put("BoardColumnList", BoardColumnList);

		String NumberingType = Component.getData("BoardType.BT_getBT_KEYNO", MN_KEYNO);
		map.put("NumberingType", NumberingType);
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(), "BoardNotice.BN_getDataListCnt", map,search.getPageUnit(), 10);
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());

		mv.addObject("paginationInfo", pageInfo);
		
		mv.addObject("resultList", Component.getList("BoardNotice.BN_getDataList", map));
		mv.addObject("BoardColumnList", BoardColumnList);
		mv.addObject("search", search);
		return mv;

	}

	/**
	 * 게시물 관리 - 게시물 - excel ajax
	 * 
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/dataView/excelAjax.do")
	public Object BoardDataListViewExcelAjax(HttpServletRequest req, HttpServletResponse res, Common search,
			@RequestParam(value = "MN_KEYNO", required = false) String MN_KEYNO,
			@RequestParam(value = "MN_NAME", required = false) String MN_NAME) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_listView_excel");

		List<HashMap<String, Object>> searchList = Component.getSearchList(req);

		Map<String, Object> map = CommonService.ConverObjectToMap(search);
		map.put("MN_KEYNO", MN_KEYNO);
		if (searchList != null) {
			map.put("searchList", searchList);
		}

		map.put("BOARD_COLUMN_TYPE_CHECK", SettingData.BOARD_COLUMN_TYPE_CHECK);
		map.put("BOARD_COLUMN_TYPE_CHECK_CODE", SettingData.BOARD_COLUMN_TYPE_CHECK_CODE);
		map.put("BOARD_COLUMN_TYPE_RADIO_CODE", SettingData.BOARD_COLUMN_TYPE_RADIO_CODE);
		map.put("BOARD_COLUMN_TYPE_SELECT_CODE", SettingData.BOARD_COLUMN_TYPE_SELECT_CODE);

		List<BoardColumn> BoardColumnList = Component.getList("BoardColumn.BL_getviewList2", MN_KEYNO);
		map.put("BoardColumnList", BoardColumnList);

		mv.addObject("resultList", Component.getList("BoardNotice.BN_getDataList", map));
		mv.addObject("BoardColumnList", BoardColumnList);
		mv.addObject("search", search);
		mv.addObject("MN_NAME", MN_NAME);

		try {

			Cookie cookie = new Cookie("fileDownload", "true");
			cookie.setPath("/");
			res.addCookie(cookie);

		} catch (Exception e) {
			System.out.println("쿠키 에러 :: " + e.getMessage());
		}
		return mv;

	}

	/**
	 * 메뉴 비동기 현재 유저의 쓰기 권한이 있는 게시판만 return 시킴
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/data/main/menu/selectAjax.do")
	@ResponseBody
	public List<Map<String, Object>> selectAjax(HttpServletRequest req, @ModelAttribute Menu Menu) throws Exception {
		List<Map<String, Object>> list = Component.getList("Menu.AMN_getBoardTypeList_menu", Menu);
		@SuppressWarnings({ "unchecked", "rawtypes" })
		Map user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		String userAuth[] = ((String) user.get("UIA_NAME")).split(",");
		boolean write = true;
		for (int i = 0; i < list.size(); i++) {
			write = false;
			String authList = (String) list.get(i).get("AUTHLIST");
			if (authList != null) {
				for (String auth : userAuth) {
					if (authList.contains(auth)) {
						write = true;
						break;
					}
				}
			} else {
				write = true;
			}

			if (!write) {
				list.remove(i--);
			}

		}

		return list;
	}

	@RequestMapping(value = "/txap/Board/data/insertView.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	public ModelAndView BoardDataInsertView(@ModelAttribute BoardType BoardType,
			@ModelAttribute BoardColumn BoardColumn, BoardNotice BoardNotice, @ModelAttribute Menu Menu,
			HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_insertView.adm");

		// 파일 확장자
		String fileExt = propertiesService.getString("FileExt");

		mv.addObject("BoardType", Component.getData("BoardType.BT_getData", BoardType.getBT_KEYNO()));
		List<BoardColumn> columnList = Component.getList("BoardColumn.BL_getList", BoardType.getBT_KEYNO());
		mv.addObject("BoardColumnList", columnList);

		// 컬럼 타입이 셀렉트(코드),라디오(코드),체크박스(코드) 일 경우 관련 코드값 셋팅
		List<BoardColumn> typeList = new ArrayList<BoardColumn>();
		for (BoardColumn c : columnList) {
			if (c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_CHECK_CODE)
					|| c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_RADIO_CODE)
					|| c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_SELECT_CODE))
				typeList.add(c);
		}
		if (typeList.size() > 0) {
			Map<String, Object> list = new HashMap<String, Object>();
			list.put("typeList", typeList);
			mv.addObject("BoardColumnCodeList", Component.getList("BoardColumn.BL_getCodeWidthColumn", list));
		}
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		mv.addObject("Menu", Menu);
		if (BoardNotice.getBN_KEYNO() != null && !BoardNotice.getBN_KEYNO().equals("")) {
			mv.addObject("BoardNotice", Component.getData("BoardNotice.BN_getDataAdmin", BoardNotice.getBN_KEYNO()));
		}
		mv.addObject("mirrorPage", "/txap/Board/dataView.do");
		mv.addObject("action", "insert");

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "insertView", mv);

		mv.addObject("fileExt", fileExt);
		return mv;
	}

	@RequestMapping(value = "/txap/Board/data/insert.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardDataInsert(BoardType BoardType, BoardColumn BoardColumn, BoardColumnData BoardColumnData,
			BoardNotice BoardNotice, @RequestParam(value = "BD_BL_KEYNO", required = false) String[] BD_BL_KEYNO,
			@RequestParam(value = "BD_BL_TYPE", required = false) String[] BD_BL_TYPE
//			,@RequestParam (value="BD_DATA", required=false)	  String [] BD_DATA
			, MultipartFile thumbnail, @RequestParam(value = "FM_KEYNO", required = false) String FM_KEYNO,
			@RequestParam(value = "upload_name", required = false) String upload_name, HttpServletRequest req)
			throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/dataView.do?MN_KEYNO=" + BoardNotice.getBN_MN_KEYNO());

		// 쉼표 별로 배열쪼개짐 문제 임시처리
		String[] BD_DATA = req.getParameterValues("BD_DATA");

		Menu Menu = new Menu();
		Menu.setMN_KEYNO(BoardNotice.getBN_MN_KEYNO());
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);

		BoardNotice.setBN_KEYNO(CommonService.getTableKey("BN"));
		BoardColumnData.setBD_BN_KEYNO(BoardNotice.getBN_KEYNO());
		BoardColumnData.setBD_MN_KEYNO(BoardNotice.getBN_MN_KEYNO());
		if (BoardNotice.getBN_SECRET_YN() == null || BoardNotice.getBN_SECRET_YN().equals("")) {
			BoardNotice.setBN_SECRET_YN("N");
		}
		if (thumbnail != null && !thumbnail.isEmpty()) {
			int thumbnail_width = BoardType.getBT_THUMBNAIL_WIDTH();
			int thumbnail_height = BoardType.getBT_THUMBNAIL_HEIGHT();
			FileSub FileSub = FileUploadTools.resizeFileUpload(req, CommonService.getTableKey("FM"),
			BoardNotice.getBN_KEYNO(), "게시판 썸네일 이미지", BoardNotice.getBN_REGNM(),1,thumbnail_width,thumbnail_height, true);
			BoardNotice.setBN_THUMBNAIL(FileSub.getFS_KEYNO());
		}
		if (FM_KEYNO != null) {
			BoardNotice.setBN_FM_KEYNO(FM_KEYNO);
		}
		if (upload_name != null && !upload_name.equals("")) {
			FileSub FileSub = FileUploadTools.FileUploadWithDefaultThumb(req, CommonService.getTableKey("FM"),
					BoardNotice.getBN_REGNM());
			BoardNotice.setBN_FM_KEYNO(FileSub.getFS_FM_KEYNO());
		}
		for (int i = 0; i < BD_BL_KEYNO.length; i++) {
			BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
			BoardColumnData.setBD_BL_KEYNO(BD_BL_KEYNO[i]);
			if (BD_BL_TYPE[i].equals(SettingData.BOARD_COLUMN_TYPE_TITLE)) { // 제목일경우
				BoardNotice.setBN_TITLE(BD_DATA[i]);
				BoardColumnData.setBD_DATA(BD_DATA[i]);
			} else if (BD_BL_TYPE[i].equals(SettingData.BOARD_COLUMN_TYPE_PWD)) {
				BoardColumnData.setBD_DATA(passwordEncoder.encode(BD_DATA[i]));
			} else {
				BoardColumnData.setBD_DATA(BD_DATA[i]);
			}
			BoardColumnData.setBD_BL_TYPE(BD_BL_TYPE[i]);
			Component.createData("BoardColumnData.BD_insert", BoardColumnData);
		}

		if (BoardNotice.getBN_PWD() != null && !BoardNotice.getBN_PWD().equals("")) { // 비회원 비밀번호
			BoardNotice.setBN_PWD(passwordEncoder.encode(BoardNotice.getBN_PWD()));
		}

		if (BoardNotice.getBN_MAINKEY().equals("")) { // 게시믈 등록시
			BoardNotice.setBN_MAINKEY(BoardNotice.getBN_KEYNO());
			BoardNotice.setBN_SEQ(1);
			BoardNotice.setBN_DEPTH(0);
		} else { // 답글일시
			BoardNotice.setBN_SEQ(BoardNotice.getBN_SEQ() + 1);
			BoardNotice.setBN_DEPTH(BoardNotice.getBN_DEPTH() + 1);
			Component.updateData("BoardNotice.BN_updateSeq", BoardNotice);
		}

		Component.createData("BoardNotice.BN_insert", BoardNotice);

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "insert", mv);

		return mv;
	}

	/**
	 * 관리자 게시물 상세화면
	 * 
	 * @param BoardType
	 * @param BoardColumn
	 * @param BoardNotice
	 * @param BoardComment
	 * @param Menu
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/data/detailView.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	public ModelAndView BoardDataDetailView(@ModelAttribute BoardType BoardType,
			@ModelAttribute BoardColumn BoardColumn, @ModelAttribute BoardNotice BoardNotice, BoardComment BoardComment,
			@ModelAttribute Menu Menu, HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_detailView.adm");

		BoardNotice = Component.getData("BoardNotice.BN_getDataAdmin", BoardNotice.getBN_KEYNO());

		if (BoardNotice.getBN_CONTENTS() != null && !BoardNotice.getBN_CONTENTS().equals("")) {
			// xss filter
			XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
			String content = BoardNotice.getBN_CONTENTS().replace("<o:p>", "");
			content = content.replace("</o:p>", "");
//	    content = content.replaceAll("\r\n", "<br>");

			BoardNotice.setBN_CONTENTS(filter.doFilter(content));
		}

		mv.addObject("BoardNotice", BoardNotice);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("DEL_COMMENT_YN", BoardType.getBT_DEL_COMMENT_YN());
		map.put("BC_BN_KEYNO", BoardNotice.getBN_KEYNO());
		map.put("recordCountPerPage", BoardNotice.getRecordCountPerPage());
		map.put("firstIndex", BoardNotice.getFirstIndex());
		mv.addObject("BoardCommentList", Component.getList("BoardComment.BC_getList",map));
		List<BoardColumnData> BoardColumnDataList = Component.getList("BoardColumnData.BD_getList", BoardNotice.getBN_KEYNO());
		
		//코드값을 코드이름으로 변경하는 처리
		for(BoardColumnData b : BoardColumnDataList){
			if(b.getBD_DATA() != null && !b.getBD_DATA().equals("") &&
					( b.getBD_BL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_CHECK_CODE) ||
					b.getBD_BL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_RADIO_CODE) ||
					b.getBD_BL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_SELECT_CODE) ) ){
				Map<String,Object> typeList = new HashMap<String,Object>();
				String typeArray[] = b.getBD_DATA().split("\\|");
				typeList.put("typeArray", typeArray);
				b.setBD_DATA((String) Component.getData("Code.SC_getNameList", typeList));
			}
		}
		mv.addObject("BoardColumnDataList", BoardColumnDataList);
		mv.addObject("BoardColumnList", Component.getList("BoardColumn.BL_getviewList", BoardNotice.getBN_MN_KEYNO()));
		mv.addObject("FileSub", Component.getList("File.AFS_FileSelectFileSub", BoardNotice.getBN_FM_KEYNO()));
		mv.addObject("BoardReplyList", Component.getList("BoardNotice.BN_getReplyList", BoardNotice));
		// 게시판 기능 사용 여부
		mv.addObject("BoardType", Component.getData("BoardType.BT_getData_pramMenukey", BoardNotice.getBN_MN_KEYNO()));

		mv.addObject("BoardNoticeHistoryList", Component.getList("BoardNotice.BNH_getList", BoardNotice.getBN_KEYNO()));

		mv.addObject("mirrorPage", "/txap/Board/dataView.do");
		
		Menu.setMN_KEYNO(BoardNotice.getBN_MN_KEYNO());
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		mv.addObject("Menu", Menu);

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "detail", mv);

		return mv;
	}

	/**
	 * 게시물 상세화면 - 코멘트 - 페이징 ajax
	 * 
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/data/detailView/comment/pagingAjax.do")
	public ModelAndView boardTypeViewPagingAjax(HttpServletRequest req, Common search, @RequestParam String BC_BN_KEYNO)
			throws Exception {

		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_detailView_comment_data");

		List<HashMap<String, Object>> searchList = Component.getSearchList(req);

		Map<String, Object> map = CommonService.ConverObjectToMap(search);

		if (searchList != null) {
			map.put("searchList", searchList);
		}
		map.put("BC_BN_KEYNO", BC_BN_KEYNO);

		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(), "BoardComment.BC_getDataListCnt", map,
				search.getPageUnit(), 10);

		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());

		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("BoardComment.BC_getDataList", map));
		mv.addObject("search", search);
		return mv;

	}

	/**
	 * 게시물 상세화면 - 코멘트 - excel ajax
	 * 
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/data/detailView/comment/excelAjax.do")
	public ModelAndView boardTypeViewExcelAjax(HttpServletRequest req, HttpServletResponse res, Common search,
			@RequestParam String BC_BN_KEYNO) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_detailView_comment_excel");

		List<HashMap<String, Object>> searchList = Component.getSearchList(req);

		Map<String, Object> map = CommonService.ConverObjectToMap(search);

		if (searchList != null) {
			map.put("searchList", searchList);
		}
		map.put("BC_BN_KEYNO", BC_BN_KEYNO);

		mv.addObject("resultList", Component.getList("BoardComment.BC_getDataList", map));
		mv.addObject("search", search);

		try {

			Cookie cookie = new Cookie("fileDownload", "true");
			cookie.setPath("/");
			res.addCookie(cookie);

		} catch (Exception e) {
			System.out.println("쿠키 에러 :: " + e.getMessage());
		}
		return mv;

	}

	@RequestMapping(value = "/txap/Board/data/updateView.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	public ModelAndView BoardDataUpdateView(@ModelAttribute BoardType BoardType,
			@ModelAttribute BoardColumn BoardColumn, @ModelAttribute BoardNotice BoardNotice, @ModelAttribute Menu Menu,
			HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_insertView.adm");

		// 파일 확장자
		String fileExt = propertiesService.getString("FileExt");

		BoardNotice = Component.getData("BoardNotice.BN_getDataAdmin", BoardNotice.getBN_KEYNO());
		mv.addObject("BoardNotice", BoardNotice);
		mv.addObject("FileSub", Component.getList("File.AFS_FileSelectFileSub", BoardNotice.getBN_FM_KEYNO()));
		mv.addObject("BoardType", Component.getData("BoardType.BT_getData_pramMenukey", Menu.getMN_KEYNO()));
		List<BoardColumn> columnList = Component.getList("BoardColumn.BL_getList", BoardType.getBT_KEYNO());
		mv.addObject("BoardColumnList", columnList);

		// 컬럼 타입이 셀렉트(코드),라디오(코드),체크박스(코드) 일 경우 관련 코드값 셋팅
		List<BoardColumn> typeList = new ArrayList<BoardColumn>();
		for (BoardColumn c : columnList) {
			if (c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_CHECK_CODE)
					|| c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_RADIO_CODE)
					|| c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_SELECT_CODE))
				typeList.add(c);
		}
		if (typeList.size() > 0) {
			Map<String, Object> list = new HashMap<String, Object>();
			list.put("typeList", typeList);
			mv.addObject("BoardColumnCodeList", Component.getList("BoardColumn.BL_getCodeWidthColumn", list));
		}
		mv.addObject("Menu", Menu);

		FileSub FileSub = new FileSub();
		FileSub.setFS_KEYNO(BoardNotice.getBN_THUMBNAIL());
		mv.addObject("File", Component.getData("File.AFS_SubFileDetailselect", FileSub));
		mv.addObject("mirrorPage", "/txap/Board/dataView.do");
		mv.addObject("action", "update");

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "updateView", mv);
		mv.addObject("fileExt", fileExt);
		return mv;
	}

	@RequestMapping(value = "/txap/Board/data/update.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardDataUpdate(@ModelAttribute BoardType BoardType, @ModelAttribute BoardColumn BoardColumn,
			@ModelAttribute BoardColumnData BoardColumnData, @ModelAttribute BoardNotice BoardNotice,
			@RequestParam(value = "BD_BL_KEYNO", required = false) String[] BD_BL_KEYNO,
			@RequestParam(value = "BD_BL_TYPE", required = false) String[] BD_BL_TYPE
//			,@RequestParam (value="BD_DATA", required=false)	  String [] BD_DATA
			, @RequestParam(value = "BD_KEYNO", required = false) String[] BD_KEYNO, @ModelAttribute Menu Menu,
			@RequestParam(value = "linkinsert", required = false, defaultValue="A") String linkinsert,
			MultipartFile thumbnail, String FM_KEYNO, HttpServletRequest req) throws Exception {
		
		if(linkinsert.equals("Y")) {
//			Component.deleteData("File.AFSM_FileDeleteFileSub",FM_KEYNO);
//			Component.deleteData("File.AFM_FileDeleteFileSub",FM_KEYNO);
			thumbnail = null;
		}
		
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/dataView.do?MN_KEYNO=" + BoardNotice.getBN_MN_KEYNO());
		
		// 쉼표 별로 배열쪼개짐 문제 임시처리
		String[] BD_DATA = req.getParameterValues("BD_DATA");

		BoardColumnData.setBD_BN_KEYNO(BoardNotice.getBN_KEYNO());
		BoardColumnData.setBD_MN_KEYNO(BoardNotice.getBN_MN_KEYNO());

		if (BoardNotice.getBN_SECRET_YN() == null || BoardNotice.getBN_SECRET_YN().equals("")) {
			BoardNotice.setBN_SECRET_YN("N");
		}

		if (thumbnail != null && !thumbnail.isEmpty()) {

			FileSub FileSub = null;
			int thumbnail_width = BoardType.getBT_THUMBNAIL_WIDTH();
			int thumbnail_height = BoardType.getBT_THUMBNAIL_HEIGHT();

			if (BoardNotice.getBN_THUMBNAIL().equals("")) {
				FileSub = FileUploadTools.resizeFileUpload(req, CommonService.getTableKey("FM"),
						BoardNotice.getBN_KEYNO(), "게시판 썸네일 이미지", BoardNotice.getBN_MODNM(), 1,thumbnail_width,thumbnail_height, true);
			}else{
				FileSub = FileUploadTools.imageChange(BoardNotice.getBN_THUMBNAIL(), req, BoardNotice.getBN_MODNM(), 1,true,thumbnail_width,thumbnail_height,true);
			}
			BoardNotice.setBN_THUMBNAIL(FileSub.getFS_KEYNO());

		}
		BoardNotice.setBN_FM_KEYNO(FM_KEYNO);
		if(linkinsert.equals("Y")) {
//			Component.deleteData("File.AFSM_FileDeleteFileSub",BoardNotice.getBN_THUMBNAIL());
//			Component.deleteData("File.AFM_FileDeleteFileSub",BoardNotice.getBN_THUMBNAIL());
			BoardNotice.setBN_FM_KEYNO("");
			BoardNotice.setBN_THUMBNAIL("");
		}
		
		for (int i = 0; i < BD_BL_KEYNO.length; i++) {
			if (BD_KEYNO[i] == null || BD_KEYNO[i].equals("")) {
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BL_KEYNO(BD_BL_KEYNO[i]);
				if (BD_BL_TYPE[i].equals(SettingData.BOARD_COLUMN_TYPE_TITLE)) { // 제목일경우
					BoardNotice.setBN_TITLE(BD_DATA[i]);
					BoardColumnData.setBD_DATA(BD_DATA[i]);
				} else if (BD_BL_TYPE[i].equals(SettingData.BOARD_COLUMN_TYPE_PWD)) {
					BoardColumnData.setBD_DATA(passwordEncoder.encode(BD_DATA[i]));
				} else {
					BoardColumnData.setBD_DATA(BD_DATA[i]);
					if(linkinsert.equals("N")) {
						BoardColumnData.setBD_DATA("");
					}
				}
				BoardColumnData.setBD_BL_TYPE(BD_BL_TYPE[i]);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
			} else {
				if (BD_BL_TYPE[i].equals(SettingData.BOARD_COLUMN_TYPE_TITLE)) { // 제목일경우
					BoardNotice.setBN_TITLE(BD_DATA[i]);
					BoardColumnData.setBD_DATA(BD_DATA[i]);
				} else if (BD_BL_TYPE[i].equals(SettingData.BOARD_COLUMN_TYPE_PWD)) {
					BoardColumnData.setBD_DATA(passwordEncoder.encode(BD_DATA[i]));
				} else {
					BoardColumnData.setBD_DATA(BD_DATA[i]);
					if(linkinsert.equals("N")) {
						BoardColumnData.setBD_DATA("");
					}
				}
				BoardColumnData.setBD_KEYNO(BD_KEYNO[i]);
				Component.createData("BoardColumnData.BD_update", BoardColumnData);
			}
		}
		BoardNotice.setBNH_KEYNO(CommonService.getTableKey("BNH"));
		Component.createData("BoardNotice.BNH_insert", BoardNotice);
		BoardColumnData.setBDH_BNH_KEYNO(BoardNotice.getBNH_KEYNO());
		Component.createData("BoardColumnData.BDH_insert", BoardColumnData);

		Component.updateData("BoardNotice.BN_update", BoardNotice);

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "update", mv);

		return mv;
	}

	@RequestMapping(value = "/txap/Board/data/updateView/listAjax.do")
	@ResponseBody
	public List<BoardColumn> columnDatalist(@ModelAttribute BoardColumnData BoardColumnData, HttpServletRequest req)
			throws Exception {
		return Component.getList("BoardColumnData.BD_getList", BoardColumnData.getBD_BN_KEYNO());
	}

	@RequestMapping(value = "/txap/Board/data/state.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardDataDelete(@ModelAttribute BoardNotice BoardNotice, HttpServletRequest req)
			throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/dataView.do?MN_KEYNO=" + BoardNotice.getBN_MN_KEYNO());
		Menu Menu = new Menu();
		Menu.setMN_KEYNO(BoardNotice.getBN_MN_KEYNO());
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		
		BoardType BoardType = Component.getData("BoardType.BT_getData_pramMenukey",Menu.getMN_KEYNO());
		// 삭제정책(L:논리삭제, P: 물리삭제)
		if(BoardType.getBT_DEL_POLICY().equals("L")) {
			Component.updateData("BoardNotice.BN_stateModify", BoardNotice);
		} else {
			Component.deleteData("BoardNotice.BN_delete", BoardNotice);
		}
		
		String type = "";
		if ("Y".equals(BoardNotice.getBN_DEL_YN())) {
			type = "delete";
		} else if ("N".equals(BoardNotice.getBN_DEL_YN())) {
			type = "recovery";
		} else if ("Y".equals(BoardNotice.getBN_USE_YN())) {
			type = "show";
		} else {
			type = "hide";
		}
		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, type, mv);

		return mv;
	}

	/**
	 * 관리자 게시물 이동 화면
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/moveView.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	public ModelAndView boardDataMoveView(HttpServletRequest req, BoardType BoardType, BoardNotice BoardNotice,
			Menu Menu) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_moveView.adm");
		Menu.setMN_KEYNO(BoardNotice.getBN_MN_KEYNO());
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		mv.addObject("BoardNotice", Component.getData("BoardNotice.BN_getData", BoardNotice.getBN_KEYNO()));
		mv.addObject("BoardType", Component.getData("BoardType.BT_getData", BoardType.getBT_KEYNO()));
		mv.addObject("boardList", Component.getList("Menu.AMN_getBoardTypeList_menu", Menu.getMN_HOMEDIV_C()));

		mv.addObject("mirrorPage", "/txap/Board/dataView.do");

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "moveView", mv);
		return mv;
	}

	/**
	 * 관리자 게시물 이동 체크
	 * 
	 * @param req
	 * @param BoardNotice
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/moveCheckAjax.do")
	@ResponseBody
	public int adminBoardmoveCheckAjax(HttpServletRequest req, @ModelAttribute BoardNotice BoardNotice)
			throws Exception {

		return Component.getCount("BoardNotice.BN_moveCheck", BoardNotice);
	}
	
	
	@RequestMapping(value = "/txap/Board/moveView2.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	public ModelAndView BoardDataMoveView2(@ModelAttribute BoardType BoardType,
			@ModelAttribute BoardColumn BoardColumn, @ModelAttribute BoardNotice BoardNotice, @ModelAttribute Menu Menu,
			HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/data/pra_board_data_insertView.adm");

		// 파일 확장자
		String fileExt = propertiesService.getString("FileExt");
		
		// 이동할 메뉴 게시판 메뉴 정보
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		
		String move_memo = BoardNotice.getBN_MOVE_MEMO();

		BoardNotice = Component.getData("BoardNotice.BN_getDataAdmin", BoardNotice.getBN_KEYNO());
		BoardNotice.setBN_MOVE_MEMO(move_memo);
		
		mv.addObject("BoardNotice", BoardNotice);
		mv.addObject("FileSub", Component.getList("File.AFS_FileSelectFileSub", BoardNotice.getBN_FM_KEYNO()));
		mv.addObject("BoardType", Component.getData("BoardType.BT_getData_pramMenukey", Menu.getMN_KEYNO()));
		mv.addObject("PreBoardType", Component.getData("BoardType.BT_getData_pramMenukey", BoardNotice.getBN_MN_KEYNO()));
		mv.addObject("PreBoardColumnData", Component.getList("BoardColumnData.BD_getList", BoardNotice.getBN_KEYNO()));
		
		List<BoardColumn> columnList = Component.getList("BoardColumn.BL_getList", Menu.getMN_BT_KEYNO());
		mv.addObject("BoardColumnList", columnList);

		// 컬럼 타입이 셀렉트(코드),라디오(코드),체크박스(코드) 일 경우 관련 코드값 셋팅
		List<BoardColumn> typeList = new ArrayList<BoardColumn>();
		for (BoardColumn c : columnList) {
			if (c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_CHECK_CODE)
					|| c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_RADIO_CODE)
					|| c.getBL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_SELECT_CODE))
				typeList.add(c);
		}
		if (typeList.size() > 0) {
			Map<String, Object> list = new HashMap<String, Object>();
			list.put("typeList", typeList);
			mv.addObject("BoardColumnCodeList", Component.getList("BoardColumn.BL_getCodeWidthColumn", list));
		}
		mv.addObject("Menu", Menu);
		

		FileSub FileSub = new FileSub();
		FileSub.setFS_KEYNO(BoardNotice.getBN_THUMBNAIL());
		mv.addObject("File", Component.getData("File.AFS_SubFileDetailselect", FileSub));
		mv.addObject("mirrorPage", "/txap/Board/dataView.do");
		mv.addObject("action", "move");

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "moveView", mv);
		mv.addObject("fileExt", fileExt);
		return mv;
	}
	
	
	

	/**
	 * 관리자 게시물 이동
	 * 
	 * @param req
	 * @param BoardNotice
	 * @param BoardType
	 * @param Menu
	 * @param tiles
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping(value = "/txap/Board/move.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView boardDataMove(HttpServletRequest req, BoardNotice BoardNotice, BoardType BoardType, Menu Menu)
			throws Exception {
		ModelAndView mv = new ModelAndView(
				"redirect:/txap/Board/data/detailView.do?BN_KEYNO=" + BoardNotice.getBN_KEYNO());

		// 이동할 메뉴 게시판 메뉴 정보
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("BN_KEYNO", BoardNotice.getBN_KEYNO());
		map.put("MN_KEYNO", Menu.getMN_KEYNO());
		map.put("BT_KEYNO", Menu.getMN_BT_KEYNO());
		Component.updateData("BoardNotice.BN_moveBoard", map);

		if (BoardType.getBT_KEYNO().equals(Menu.getMN_BT_KEYNO())) { // 게시판 타입이 같을 경우
			Component.updateData("BoardColumnData.BL_moveBoard", map);
		} else { // 다를경우 컬럼 데이터는 제목만 이동
			Component.updateData("BoardColumnData.BL_moveBoard2", map);
		}

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "move", mv);

		return mv;
	}*/
	
	
	@RequestMapping(value = "/txap/Board/data/move.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView boardDataMove(@ModelAttribute BoardType BoardType, @ModelAttribute BoardColumn BoardColumn,
			@ModelAttribute BoardColumnData BoardColumnData, @ModelAttribute BoardNotice BoardNotice,
			@RequestParam(value = "BD_BL_KEYNO", required = false) String[] BD_BL_KEYNO,
			@RequestParam(value = "BD_BL_TYPE", required = false) String[] BD_BL_TYPE
			, @RequestParam(value = "BD_KEYNO", required = false) String[] BD_KEYNO, @ModelAttribute Menu Menu,
			MultipartFile thumbnail, String FM_KEYNO, HttpServletRequest req) throws Exception {

		ModelAndView mv = new ModelAndView(
				"redirect:/txap/Board/data/detailView.do?BN_KEYNO=" + BoardNotice.getBN_KEYNO());

		// 이동할 메뉴 게시판 메뉴 정보
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("BN_KEYNO", BoardNotice.getBN_KEYNO());
		map.put("MN_KEYNO", Menu.getMN_KEYNO());
		map.put("BT_KEYNO", Menu.getMN_BT_KEYNO());
		Component.updateData("BoardNotice.BN_moveBoard", map);

		//기존 컬럼 데이터 삭제 처리
		Component.deleteData("BoardColumnData.BD_delete", map);
		
		//기존 히스토리 삭제 처리
		Component.deleteData("BoardNotice.BNH_delete", map);
		Component.deleteData("BoardColumnData.BDH_delete", map);
		
		// 쉼표 별로 배열쪼개짐 문제 임시처리
		String[] BD_DATA = req.getParameterValues("BD_DATA");

		BoardColumnData.setBD_BN_KEYNO(BoardNotice.getBN_KEYNO());
		BoardColumnData.setBD_MN_KEYNO(BoardNotice.getBN_MN_KEYNO());

		if (BoardNotice.getBN_SECRET_YN() == null || BoardNotice.getBN_SECRET_YN().equals("")) {
			BoardNotice.setBN_SECRET_YN("N");
		}
		

		if (thumbnail != null && !thumbnail.isEmpty()) {

			FileSub FileSub = null;
			int thumbnail_width = BoardType.getBT_THUMBNAIL_WIDTH();
			int thumbnail_height = BoardType.getBT_THUMBNAIL_HEIGHT();

			if (BoardNotice.getBN_THUMBNAIL().equals("")) {
				FileSub = FileUploadTools.resizeFileUpload(req, CommonService.getTableKey("FM"),
						BoardNotice.getBN_KEYNO(), "게시판 썸네일 이미지", BoardNotice.getBN_MODNM(), 1,thumbnail_width,thumbnail_height, true);
			}else{
				FileSub = FileUploadTools.imageChange(BoardNotice.getBN_THUMBNAIL(), req, BoardNotice.getBN_MODNM(), 1,true,thumbnail_width,thumbnail_height,true);
			}
			BoardNotice.setBN_THUMBNAIL(FileSub.getFS_KEYNO());

		}
		BoardNotice.setBN_FM_KEYNO(FM_KEYNO);
		for (int i = 0; i < BD_BL_KEYNO.length; i++) {
			BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
			BoardColumnData.setBD_BL_KEYNO(BD_BL_KEYNO[i]);
			if (BD_BL_TYPE[i].equals(SettingData.BOARD_COLUMN_TYPE_TITLE)) { // 제목일경우
				BoardNotice.setBN_TITLE(BD_DATA[i]);
				BoardColumnData.setBD_DATA(BD_DATA[i]);
			} else if (BD_BL_TYPE[i].equals(SettingData.BOARD_COLUMN_TYPE_PWD)) {
				BoardColumnData.setBD_DATA(passwordEncoder.encode(BD_DATA[i]));
			} else {
				BoardColumnData.setBD_DATA(BD_DATA[i]);
			}
			BoardColumnData.setBD_BL_TYPE(BD_BL_TYPE[i]);
			Component.createData("BoardColumnData.BD_insert", BoardColumnData);
		}

		// 이동으로 인한 데이터 수정
		Component.updateData("BoardNotice.BN_update", BoardNotice);

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "move", mv);

		return mv;
	}
	
	

	/**
	 * 관리자 게시판 등록 페이지
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/data/reply/insertView.do")
	public ModelAndView ReplyInsertView(@RequestParam(value = "BN_KEYNO", required = false) String BN_KEYNO,
			HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/reply/pra_board_reply_insertView.adm");

		mv.addObject("BN_KEYNO", BN_KEYNO);

		return mv;
	}

	/**
	 * 관리자 댓글 삭제
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/data/comment/deleteAjax.do")
	@CheckActivityHistory(desc = "관리자 댓글 삭제 처리 작업 ", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public void CommentDlelte(@ModelAttribute BoardComment BoardComment, HttpServletRequest req) throws Exception {

		Component.updateData("BoardComment.BC_delete", BoardComment);

	}

	@RequestMapping(value = "/txap/Board/data/html/insertView.do")
	@CheckActivityHistory(desc = "게시물 소개 HTML 등록  페이지 방문")
	public ModelAndView BoardHtmlInsertView(HttpServletRequest req, @ModelAttribute Menu Menu,
			@ModelAttribute BoardHtml BoardHtml, @ModelAttribute BoardType BoardType) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/board/html/pra_board_html_insertView.adm");
		mv.addObject("Menu", Menu);
		mv.addObject("BoardType", BoardType);
		mv.addObject("BoardHtml", Component.getData("BoardHtml.BIH_getData_pramMenukey", Menu.getMN_KEYNO()));
		mv.addObject("mirrorPage", "/txap/Board/dataView.do");

		return mv;
	}

	@RequestMapping(value = "/txap/Board/data/html/insert.do")
	@CheckActivityHistory(desc = "게시물 소개 HTML 등록  작업", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardHtmlInsert(@ModelAttribute BoardHtml BoardHtml, HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/dataView.do?MN_KEYNO=" + BoardHtml.getBIH_MN_KEYNO());
		BoardHtml.setBIH_KEYNO(CommonService.getTableKey("BIH"));
		Component.createData("BoardHtml.BIH_insert", BoardHtml);
		
		HashMap<String, Object> modimap = new HashMap<>();
		modimap.put("MODNM", BoardHtml.getBIH_REGNM());
		modimap.put("MN_KEYNO", BoardHtml.getBIH_MN_KEYNO());
		Component.updateData("Menu.change_MenuModifyTime", modimap);
		return mv;
	}

	@RequestMapping(value = "/txap/Board/data/html/update.do")
	@CheckActivityHistory(desc = "게시물 소개 HTML 수정 작업", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardHtmlUpdate(@ModelAttribute BoardHtml BoardHtml, HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/dataView.do?MN_KEYNO=" + BoardHtml.getBIH_MN_KEYNO());
		Component.createData("BoardHtml.BIH_update", BoardHtml);
		
		HashMap<String, Object> modimap = new HashMap<>();
		modimap.put("MODNM", BoardHtml.getBIH_REGNM());
		modimap.put("MN_KEYNO", BoardHtml.getBIH_MN_KEYNO());
		Component.updateData("Menu.change_MenuModifyTime", modimap);
		return mv;
	}

	@RequestMapping(value = "/txap/Board/data/html/delete.do")
	@CheckActivityHistory(desc = "게시물 소개 HTML 삭제 작업", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView BoardHtmlDelete(@ModelAttribute BoardHtml BoardHtml, HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/dataView.do?MN_KEYNO=" + BoardHtml.getBIH_MN_KEYNO());
		Component.createData("BoardHtml.BIH_use_update", BoardHtml);
		return mv;
	}

	@RequestMapping(value = "/txap/Board/data/detailView/compareAjax.do")
	@ResponseBody
	public Map<String, Object> compareAjax(@ModelAttribute BoardColumnData BoardColumnData,
			@ModelAttribute BoardNotice BoardNotice, HttpServletRequest req,
			@RequestParam(value = "COMPARE", required = false) String COMPARE) throws Exception {

		BoardNotice.setBN_COMPARE(COMPARE);
		BoardColumnData.setBD_COMPARE(COMPARE);

		Map<String, Object> map = new HashMap<String, Object>();
		BoardColumnData.setBDH_BNH_KEYNO(BoardNotice.getBNH_KEYNO());
		BoardColumnData.setBD_BN_KEYNO(BoardNotice.getBN_KEYNO());
		List<BoardColumnData> BoardColumnDataList = Component.getList("BoardColumnData.BDH_compareData",
				BoardColumnData);
		String bd_keyno = "";
		bd_keyno = BoardColumnDataList.get(0).getBD_KEYNO();
		int cnt = 1;
		List<BoardColumnData> BoardColmnDataCompare1 = new ArrayList<>();
		List<BoardColumnData> BoardColmnDataCompare2 = new ArrayList<>();
		for (int i = 0; i < BoardColumnDataList.size(); i++) {
			if (i != 0 && bd_keyno.equals(BoardColumnDataList.get(i).getBD_KEYNO())) {
				cnt++;
			}
			if (cnt == 1) {
				BoardColmnDataCompare1.add(BoardColumnDataList.get(i));
			} else if (cnt == 2) {
				BoardColmnDataCompare2.add(BoardColumnDataList.get(i));
			}
		}

		map.put("BoardNoticeCompare", Component.getList("BoardNotice.BNH_compareData", BoardNotice));
		map.put("BoardColmnDataCompare1", BoardColmnDataCompare1);
		map.put("BoardColmnDataCompare2", BoardColmnDataCompare2);
		return map;
	}

	/**
	 * 게시물 히스토리 내용보기
	 * 
	 * @param MVD_KEYNO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/Board/data/detailView/historyContents.do")
	public String CreateHTML_DetailViewIframe(Model model, @ModelAttribute BoardNotice BoardNotice) throws Exception {

		BoardNotice = Component.getData("BoardNotice.BNH_getContents", BoardNotice.getBNH_KEYNO());

		// xss filter
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");

		model.addAttribute("contents", filter.doFilter(BoardNotice.getBNH_BN_CONTENTS()));
		return "/txap/homepage/page/pra_page_detailView_iframe";
	}

	@RequestMapping(value = "/txap/Board/data/restore.do")
	@CheckActivityHistory(desc = "게시물 복원 처리 작업", homeDiv = SettingData.HOMEDIV_ADMIN)
	@Transactional
	public ModelAndView restore(@ModelAttribute BoardColumnData BoardColumnData,
			@ModelAttribute BoardNotice BoardNotice,
			@RequestParam(value = "bnh_keyno", required = false) String bnh_keyno,
			@RequestParam(value = "bn_keyno", required = false) String bn_keyno, HttpServletRequest req)
			throws Exception {
		BoardNotice.setBN_KEYNO(bn_keyno);
		ModelAndView mv = new ModelAndView("redirect:/txap/Board/data/detailView.do?BN_KEYNO=" + bn_keyno);

		BoardNotice.setBNH_KEYNO(CommonService.getTableKey("BNH"));
		Component.createData("BoardNotice.BNH_insert", BoardNotice);
		BoardColumnData.setBDH_BNH_KEYNO(BoardNotice.getBNH_KEYNO());
		BoardColumnData.setBD_BN_KEYNO(BoardNotice.getBN_KEYNO());
		Component.createData("BoardColumnData.BDH_insert", BoardColumnData);

		BoardNotice.setBNH_KEYNO(bnh_keyno);
		BoardColumnData.setBDH_BNH_KEYNO(bnh_keyno);
		Component.createData("BoardNotice.BN_restore_update", BoardNotice);
		Component.createData("BoardColumnData.BL_restore_update", BoardColumnData);
		return mv;
	}

}