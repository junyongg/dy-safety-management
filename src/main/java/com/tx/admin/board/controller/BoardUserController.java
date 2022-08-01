package com.tx.admin.board.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ibm.icu.util.Calendar;
import com.nhncorp.lucy.security.xss.XssFilter;
import com.tx.admin.board.dto.BoardColumn;
import com.tx.admin.board.dto.BoardColumnData;
import com.tx.admin.board.dto.BoardComment;
import com.tx.admin.board.dto.BoardNotice;
import com.tx.admin.board.dto.BoardType;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.operation.holiday.service.HolidayService;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.annotation.service.ActivityHistoryService;
import com.tx.common.common.CommandMap;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.mail.service.EmailService;
import com.tx.common.page.PageAccess;
import com.tx.common.security.password.MyPasswordEncoder;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardUserController {

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

	/** 페이지 처리 출 */
	@Autowired
	private PageAccess PageAccess;

	/** 휴일 관리 */
	@Autowired
	private HolidayService HolidayService;

	/** email **/
	@Autowired
	private EmailService EmailService;

	/** 활동기록 서비스 */
	@Autowired
	private ActivityHistoryService ActivityHistoryService;

	@RequestMapping(value = "/{tiles}/Board/main/{keyno}/view.do")
	public ModelAndView BoardListView(HttpServletRequest req, @ModelAttribute Menu Menu, @PathVariable String keyno,
			@ModelAttribute BoardNotice BoardNotice
			, @RequestParam(value = "msg", required = false) String msg,
			@PathVariable String tiles, @RequestParam(value = "orderCondition", required = false) String orderCondition,
			@RequestParam(value = "Type_menu", required = false) String Type_menu,
			@RequestParam(value = "Conditional", required = false) String Conditional,
			@RequestParam(value = "SearchKeywordss", required = false) String SearchKeywordss,
			@RequestParam(value = "selected_views", defaultValue = "eight") String selected_views) throws Exception {

		ModelAndView mv = new ModelAndView();
		String jspName = CommonService.getJspName(tiles, "/board/data/prc_board_data_listView");
		if (jspName == null) {
			return mv;
		} else {
			mv.setViewName(jspName);
		}

		Menu.setMN_KEYNO(CommonService.getKeyno(keyno, "MN"));
		BoardNotice.setBN_MN_KEYNO(Menu.getMN_KEYNO());
		BoardNotice.setSearchKeyword(BoardNotice.getSearchKeyword().trim());

		BoardType BoardType = Component.getData("BoardType.BT_getData_pramMenukey", Menu.getMN_KEYNO());
		if (Type_menu == null) {
			Type_menu = "list";
		}
		int cnt = 8;

		mv.addObject("BoardType", BoardType);

		String NumberingType = Component.getData("BoardType.BT_getBT_KEYNO", Menu.getMN_KEYNO());

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("NumberingType", NumberingType);
		map.put("BT_DEL_COMMENT_YN", BoardType.getBT_DEL_COMMENT_YN());
		map.put("BT_REPLY_YN", BoardType.getBT_REPLY_YN());
		map.put("BT_DEL_LISTVIEW_YN", BoardType.getBT_DEL_LISTVIEW_YN());
		map.put("BN_MN_KEYNO", BoardNotice.getBN_MN_KEYNO());
		map.put("BT_SHOW_MINE_YN", BoardType.getBT_SHOW_MINE_YN());
		
		map.put("orderCondition", orderCondition);
		
		if(SearchKeywordss == null) {
			SearchKeywordss = "nosearch";
		}
		
		if(SearchKeywordss.equals("nosearch") ) {
			map.put("searchKeyword", BoardNotice.getSearchKeyword());
			map.put("searchCondition", BoardNotice.getSearchCondition());
		}else {
			map.put("searchKeyword",SearchKeywordss);
			map.put("searchCondition","BL_0000000100");
			BoardNotice.setSearchKeyword("");
			BoardNotice.setSearchCondition("");
		}
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		// 관리자 검증
		if (user != null) {
			String isAdmin = (String) user.get("isAdmin");
			System.out.println("관리자확인 :: " + isAdmin);
			String UI_KEYNO = user.get("UI_KEYNO") + "";
			map.put("isAdmin", isAdmin);
			map.put("UI_KEYNO", UI_KEYNO);
		} else {
			map.put("isAdmin", "N");
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(BoardNotice.getPageIndex(),
				"BoardNotice.BN_getUserDataCount", map, BoardType.getBT_PAGEUNIT(), BoardType.getBT_PAGESIZE());
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		map.put("pageIndex", pageInfo.getCurrentPageNo());
		mv.addObject("paginationInfo", pageInfo);

		List<HashMap<String, Object>> BoardNoticeDataList = Component.getList("BoardNotice.BN_getUserDataList", map);
		mv.addObject("BoardNoticeDataList", BoardNoticeDataList);

		List<String> bnkeyList = new ArrayList<String>();
		for (HashMap<String, Object> notice : BoardNoticeDataList) {
			bnkeyList.add(notice.get("BN_KEYNO").toString());
		}

		Map<String, Object> data = new HashMap<String, Object>();
		data.put("MN_KEYNO", Menu.getMN_KEYNO());
		data.put("bnkeyList", bnkeyList.size() > 0 ? bnkeyList : null);

		mv.addObject("BoardColumnList", Component.getList("BoardColumn.BL_getviewList", Menu.getMN_KEYNO()));
		List<BoardColumnData> BoardColumnDataList = Component.getList("BoardColumnData.BD_getDataListWithPaging", data);

		mv.addObject("BoardColumnDataList", setCodeColumnData(BoardColumnDataList));

		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		mv.addObject("Menu", Menu);
		mv.addObject("mirrorPage", Menu.getMN_URL());
		mv.addObject("msg", msg);
		mv.addObject("orderCondition", orderCondition);
		mv.addObject("BOARD_TYPE", Type_menu);
		mv.addObject("selected_views", selected_views);
		
		mv.addObject("SearchKeywordss",SearchKeywordss);
		
		if (BoardType.getBT_HTML_YN().equals("Y")) {
			mv.addObject("BoardHtml", Component.getData("BoardHtml.BIH_getData_pramMenukey_use", Menu.getMN_KEYNO()));
		}
		mv.addObject("BoardNotice", BoardNotice);

		return mv;
	}

	/**
	 * 유저 게시판 등록 페이지
	 * 
	 * @param BT_KEYNO,
	 *            menu
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/BoardData/insertView.do")
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView BoardDataInsertView(@ModelAttribute BoardType BoardType,
			@ModelAttribute BoardColumn BoardColumn, BoardNotice BoardNotice, @ModelAttribute Menu Menu,
			HttpServletRequest req, @PathVariable String tiles) throws Exception {

		ModelAndView mv = new ModelAndView();
		String jspName = CommonService.getJspName(tiles, "/board/data/prc_board_data_insertView");
		if (jspName == null) {
			return mv;
		} else {
			mv.setViewName(jspName);
		}

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

		mv.addObject("Menu", Menu);
		if (BoardNotice.getBN_KEYNO() != null && !BoardNotice.getBN_KEYNO().equals("")) {
			mv.addObject("BoardNotice", Component.getData("BoardNotice.BN_getData", BoardNotice.getBN_KEYNO()));
		}

		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		
		if(Menu.getMN_URL().equals("/jact/open/hire.do")) {
			mv.addObject("HireList",Component.getList("BoardNotice.hireSelect",BoardNotice));
		}
		mv.addObject("BoardHtml", Component.getData("BoardHtml.BIH_getData_pramMenukey_use", Menu.getMN_KEYNO()));
		mv.addObject("mirrorPage", Menu.getMN_URL());
		mv.addObject("action", "insert");

		
		
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "insertView", mv);

		return mv;
	}

	/**
	 * 유저 게시판 등록
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/BoardData/insert.do")
	@Transactional
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView BoardDataInsert(BoardType BoardType, BoardColumn BoardColumn, BoardColumnData BoardColumnData,
			BoardNotice BoardNotice, Menu Menu,
			@RequestParam(value = "BD_BL_KEYNO", required = false) String[] BD_BL_KEYNO,
			@RequestParam(value = "linkinsert", required = false, defaultValue="A") String linkinsert,
			@RequestParam(value = "BD_BL_TYPE", required = false) String[] BD_BL_TYPE
			// ,@RequestParam (value="BD_DATA", required=false) String [] BD_DATA
			, MultipartFile thumbnail, @RequestParam(value = "FM_KEYNO", required = false) String FM_KEYNO,
			HttpServletRequest req) throws Exception {
		
		if(linkinsert.equals("Y")) {
			thumbnail = null;
			FM_KEYNO = null;
		}
		
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		ModelAndView mv = new ModelAndView("redirect:" + Menu.getMN_URL());

		// 쉼표 별로 배열쪼개짐 문제 임시처리
		String[] BD_DATA = req.getParameterValues("BD_DATA");

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
					BoardNotice.getBN_KEYNO(), "게시판 썸네일 이미지", BoardNotice.getBN_REGNM(), 1, thumbnail_width,
					thumbnail_height, true);
			BoardNotice.setBN_THUMBNAIL(FileSub.getFS_KEYNO());
		}
		if (FM_KEYNO != null) {
			BoardNotice.setBN_FM_KEYNO(FM_KEYNO);
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
				if(linkinsert.equals("N")) {
					BoardColumnData.setBD_DATA("");
				}
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

		// 이메일
		if (BoardType.getBT_EMAIL_YN() != null && BoardType.getBT_EMAIL_YN().equals("Y")) {
			String menuName = Menu.getMN_NAME();
			String boardName = BoardNotice.getBN_TITLE();
			int boardKey = Integer.parseInt(CommonService.setKeyno(BoardNotice.getBN_KEYNO()));
			String email = BoardType.getBT_EMAIL_ADDRESS();
			EmailService.sendBoardEmail(menuName, "등록", boardName, boardKey, email, req);
		}

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "insert", mv);

		return mv;
	}

	/**
	 * 유저 게시판 상세보기
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/{keyno}/detailView.do")
	@Transactional
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView BoardDataDetailView(@ModelAttribute BoardType BoardType,
			@ModelAttribute BoardNotice BoardNotice, @ModelAttribute Menu Menu,
			@ModelAttribute FileSub FileSub, HttpServletRequest req, @PathVariable String keyno,
			@RequestParam(value = "BN_PWD", defaultValue = "") String BN_PWD, @PathVariable String tiles,
			@RequestParam(value = "auth", defaultValue = "") String auth) throws Exception {
		BoardNotice.setBN_KEYNO(CommonService.getKeyno(keyno, "BN"));
		BoardNotice = Component.getData("BoardNotice.BN_getData", BoardNotice.getBN_KEYNO());
		Menu.setMN_KEYNO(BoardNotice.getBN_MN_KEYNO());
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		Menu.getMN_BT_KEYNO();
		BoardType = Component.getData("BoardType.BT_getData_pramMenukey", BoardNotice.getBN_MN_KEYNO());

		ModelAndView mv = new ModelAndView();
		String jspName = CommonService.getJspName(tiles, "/board/data/prc_board_data_detailView");
		if (jspName == null) {
			return mv;
		} else {
			mv.setViewName(jspName);
		}

		if (!auth.equals("Y")) { // auth 값이 Y가 아니면 비밀글 인증함
			// 비밀글일시 본인이거나 관리자만 볼수있음
			if (BoardType.getBT_SECRET_YN().equals("Y") && BoardNotice.getBN_SECRET_YN() != null
					&& BoardNotice.getBN_SECRET_YN().equals("Y") && BN_PWD.equals("")) {
				@SuppressWarnings("unchecked")
				Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
				if (user == null) { // 비회원일시
					boolean checkPwd = passwordEncoder.matches(BN_PWD, BoardNotice.getBN_PWD());
					if (!checkPwd) { // 비밀번호 틀리면
						mv.setViewName("/error/board_secret");
						return mv;
					}
				} else {
					String UI_KEYNO = (String) user.get("UI_KEYNO");
					String isAdmin = (String) user.get("isAdmin");
					if (isAdmin.equals("N") && !UI_KEYNO.equals(BoardNotice.getBN_REGNM())
							&& !UI_KEYNO.equals(BoardNotice.getWRITE_ID())) {// 비밀글 답변비밀글 읽을수 있게 처리
						mv.setViewName("/error/board_secret");
						return mv;
					}

				}

			}
		}

		mv.addObject("mirrorPage", Menu.getMN_URL());

		// xss filter
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		if(BoardNotice.getBN_CONTENTS() == null) {
			BoardNotice.setBN_CONTENTS("  ");
		}
		String content = BoardNotice.getBN_CONTENTS().replace("<o:p>", "");
		content = content.replace("</o:p>", "");
		if (BoardType.getBT_XSS_YN().equals("Y")) {
			BoardNotice.setBN_CONTENTS(filter.doFilter(content));
		} else {
			BoardNotice.setBN_CONTENTS(content);
		}

		// Page Data
		mv.addObject("BoardNotice", BoardNotice);
		mv.addObject("BoardType", BoardType);

		mv.addObject("BoardColumnList", Component.getList("BoardColumn.BL_getviewList", Menu.getMN_KEYNO()));
		List<BoardColumnData> BoardColumnDataList = Component.getList("BoardColumnData.BD_getList",
				BoardNotice.getBN_KEYNO());
		mv.addObject("BoardColumnDataList", setCodeColumnData(BoardColumnDataList));

		mv.addObject("FileSub", Component.getList("File.AFS_FileSelectFileSub", BoardNotice.getBN_FM_KEYNO()));

		int BOARD_NUMBER = BoardNotice.getBOARD_NUMBER();
		Map<String, Object> board = new HashMap<String, Object>();
		board.put("BN_KEYNO", BoardNotice.getBN_KEYNO());
		board.put("BOARD_NUMBER", BOARD_NUMBER);	
		
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		
		boardPrevAndNext(mv, BOARD_NUMBER, board, user);

		
		
		Pattern SCRIPTS = Pattern.compile("<script([^'\"]|\"[^\"]*\"|'[^']*')*?</script>", Pattern.DOTALL);
		Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
		Pattern TAGS = Pattern.compile("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>");
		Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
		Pattern WHITESPACE = Pattern.compile("\\s\\s+");

		Matcher m;

		m = SCRIPTS.matcher(content);
		content = m.replaceAll("");

		m = STYLE.matcher(content);
		content = m.replaceAll("");

		m = TAGS.matcher(content);
		content = m.replaceAll("");

		m = ENTITY_REFS.matcher(content);
		content = m.replaceAll("");

		m = WHITESPACE.matcher(content);
		content = m.replaceAll(" ");
		if (content.length() > 200) {
			content = content.substring(0, 200);
		}

		// 조회수 처리 2020-06-12 세션 추가
		if (req.getSession().getAttribute(BoardNotice.getBN_KEYNO()) == null) {
			Component.updateData("BoardNotice.BN_addHits", BoardNotice);
			req.getSession().setAttribute(BoardNotice.getBN_KEYNO(), 'y');
		}
		String currentPosition = (String) req.getSession().getAttribute("currentPosition");
		if (currentPosition != null) {
			mv.addObject("currentPosition", currentPosition);
			req.getSession().removeAttribute("currentPosition");
		}

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "detail", mv);

		return mv;
	}

	
	private void boardPrevAndNext(ModelAndView mv, int BOARD_NUMBER, Map<String, Object> board, Map<String, Object> user) {
		if(user != null) {//로그인 상태일때
			//System.out.println("유저 널아님");
			//유저키 저장
			board.put("user_key", (String) user.get("UI_KEYNO"));
			String isAdmin = (String) user.get("isAdmin");
			if (isAdmin.equals("Y")) {//관리자는 기존 로직을 그대로 사용한다.
				//System.out.println("관리자임");
				board.put("BOARD_NUMBER", BOARD_NUMBER - 1);
				mv.addObject("prevBoardNotice", Component.getData("BoardNotice.BN_getPrevNext", board));
				board.put("BOARD_NUMBER", BOARD_NUMBER + 1);
				mv.addObject("nextBoardNotice", Component.getData("BoardNotice.BN_getPrevNext", board));
				
				return;
			}
		}
		
		//관리자 아닐때  ( 유저정보있으면 자기글 포함 없으면 비밀글 안가져오게)
		BoardNotice boardnumberDto = Component.getData("BoardNotice.BN_getNowBOARD_NUMBER", board);	
		//System.out.println("비빌글  제외한후에 boardnumber 가져왔다"+ boardnumberDto.getBOARD_NUMBER());
		board.put("BOARD_NUMBER", boardnumberDto.getBOARD_NUMBER()+1);
		
		mv.addObject("nextBoardNotice", Component.getData("BoardNotice.BN_getNext", board));
		board.put("BOARD_NUMBER", boardnumberDto.getBOARD_NUMBER()-1);
		mv.addObject("prevBoardNotice", Component.getData("BoardNotice.BN_getPrev", board));
		//System.out.println("관리자 아닐때 처리됨");
	}

	
	
	/**
	 * 코드값을 코드이름으로 변경하는 처리
	 * 
	 * @param BoardColumnDataList
	 * @return
	 */
	private List<BoardColumnData> setCodeColumnData(List<BoardColumnData> BoardColumnDataList) {
		// TODO Auto-generated method stub
		for (BoardColumnData b : BoardColumnDataList) {
			if(b.getBD_DATA() != null && !b.getBD_DATA().equals("")) {
				b.setBD_DATA(b.getBD_DATA().trim());
				
				if ((b.getBD_BL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_CHECK_CODE)
								|| b.getBD_BL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_RADIO_CODE)
								|| b.getBD_BL_TYPE().equals(SettingData.BOARD_COLUMN_TYPE_SELECT_CODE))) {
					Map<String, Object> typeList = new HashMap<String, Object>();
					String typeArray[] = b.getBD_DATA().split("\\|");
					typeList.put("typeArray", typeArray);
					b.setBD_DATA((String) Component.getData("Code.SC_getNameList", typeList));
				}
			}
			
			
			
		}

		return BoardColumnDataList;
	}

	/**
	 * 비회원 비밀번호 체크
	 * 
	 * @param BoardNotice
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/checkPwdAjax.do")
	@ResponseBody
	public boolean BoardCheckPwdAjax(BoardNotice BoardNotice) throws Exception {

		BoardNotice notice = Component.getData("BoardNotice.BN_getData",
				CommonService.getKeyno(BoardNotice.getBN_KEYNO(), "BN"));

		boolean match = passwordEncoder.matches(BoardNotice.getBN_PWD(), notice.getBN_PWD());

		return match;
	}

	/**
	 * 유저 수정 페이지
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/updateView.do")
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView BoardDataUpdateView(@ModelAttribute BoardType BoardType,
			@ModelAttribute BoardColumn BoardColumn, @ModelAttribute BoardNotice BoardNotice, @ModelAttribute Menu Menu,
			@RequestParam(value = "bnkey", defaultValue = "") String bnkey, HttpServletRequest req,
			@PathVariable String tiles) throws Exception {

		
		ModelAndView mv = new ModelAndView();
		String jspName = CommonService.getJspName(tiles, "/board/data/prc_board_data_insertView");
		if (jspName == null) {
			return mv;
		} else {
			mv.setViewName(jspName);
		}

		if (!bnkey.equals("")) {
			BoardNotice.setBN_KEYNO(CommonService.getKeyno(bnkey, "BN"));
		}

		BoardNotice = Component.getData("BoardNotice.BN_getData", BoardNotice.getBN_KEYNO());
		mv.addObject("BoardNotice", BoardNotice);
		mv.addObject("FileSub", Component.getList("File.AFS_FileSelectPutMainkey", BoardNotice.getBN_FM_KEYNO()));
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

		if(Menu.getMN_KEYNO().equals("MN_0000001510")) {
			mv.addObject("HireList",Component.getList("BoardNotice.hireSelect",BoardNotice));
		}
		FileSub FileSub = new FileSub();
		FileSub.setFS_KEYNO(BoardNotice.getBN_THUMBNAIL());
		mv.addObject("File", Component.getData("File.AFS_SubFileDetailselect", FileSub));

		Menu.setMN_KEYNO(BoardNotice.getBN_MN_KEYNO());
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		mv.addObject("mirrorPage", Menu.getMN_URL());
		mv.addObject("action", "update");

		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "updateView", mv);

		return mv;
	}

	@RequestMapping(value = "/{tiles}/BoardData/update.do")
	@Transactional
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView BoardDataUpdate(@ModelAttribute BoardType BoardType, @ModelAttribute BoardColumn BoardColumn,
			@ModelAttribute BoardColumnData BoardColumnData, @ModelAttribute BoardNotice BoardNotice,
			@RequestParam(value = "BD_BL_KEYNO", required = false) String[] BD_BL_KEYNO,
			@RequestParam(value = "BD_BL_TYPE", required = false) String[] BD_BL_TYPE
			// ,@RequestParam (value="BD_DATA", required=false) String [] BD_DATA
			, @RequestParam(value = "BD_KEYNO", required = false) String[] BD_KEYNO, MultipartFile thumbnail,
			@RequestParam(value = "linkinsert", required = false, defaultValue="A") String linkinsert,
			@ModelAttribute Menu Menu, String FM_KEYNO, HttpServletRequest req, @PathVariable String tiles)
			throws Exception {
		
		if(linkinsert.equals("Y")) {
			Component.deleteData("File.AFSM_FileDeleteFileSub",FM_KEYNO);
			thumbnail = null;
		}
		
		
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		ModelAndView mv = new ModelAndView("redirect:" + Menu.getMN_URL());

		// 쉼표 별로 배열쪼개짐 문제 처리
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
						BoardNotice.getBN_KEYNO(), "게시판 썸네일 이미지", BoardNotice.getBN_MODNM(), 1, thumbnail_width,
						thumbnail_height, true);
			} else {
				FileSub = FileUploadTools.imageChange(BoardNotice.getBN_THUMBNAIL(), req, BoardNotice.getBN_MODNM(), 1,
						true, thumbnail_width, thumbnail_height, true);
			}
			BoardNotice.setBN_THUMBNAIL(FileSub.getFS_KEYNO());

		}
		BoardNotice.setBN_FM_KEYNO(FM_KEYNO);
		if(linkinsert.equals("Y")) {
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
		// 이메일
		if (BoardType.getBT_EMAIL_YN() != null && BoardType.getBT_EMAIL_YN().equals("Y")) {
			String menuName = Menu.getMN_NAME();
			String boardName = BoardNotice.getBN_TITLE();
			int boardKey = Integer.parseInt(CommonService.setKeyno(BoardNotice.getBN_KEYNO()));
			String email = BoardType.getBT_EMAIL_ADDRESS();
			EmailService.sendBoardEmail(menuName, "수정", boardName, boardKey, email, req);
		}

		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "update", mv);

		return mv;
	}

	/**
	 * 유저 게시판 글 삭제
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/delete.do")
	@Transactional
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView BoardDataDelete(@ModelAttribute BoardNotice BoardNotice, @ModelAttribute Menu Menu,
			HttpServletRequest req, @PathVariable String tiles,
			@RequestParam(value = "bnkey", defaultValue = "") String bnkey) throws Exception {

		if (!bnkey.equals("")) {
			BoardNotice.setBN_KEYNO(CommonService.getKeyno(bnkey, "BN"));
		}

		Menu.setMN_KEYNO(BoardNotice.getBN_MN_KEYNO());
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		ModelAndView mv = new ModelAndView("redirect:" + Menu.getMN_URL());

		BoardType BoardType = Component.getData("BoardType.BT_getData_pramMenukey", Menu.getMN_KEYNO());
		// 삭제정책(L:논리삭제, P: 물리삭제)
		if(BoardType.getBT_DEL_POLICY() == null || BoardType.getBT_DEL_POLICY() == "") {
			BoardType.setBT_DEL_POLICY("P");
		}
		if (BoardType.getBT_DEL_POLICY().equals("L")) {
			BoardNotice.setBN_DEL_YN("Y");
			Component.updateData("BoardNotice.BN_stateModify", BoardNotice);
		} else {
			Component.deleteData("BoardNotice.BN_delete", BoardNotice);
		}

		// 활동기록
		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "delete", mv);

		return mv;
	}

	/**
	 * 게시물 이동 화면
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/{key}/moveView.do")
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView boardDataMoveView(HttpServletRequest req, BoardType BoardType, BoardNotice BoardNotice,
			Menu Menu, @PathVariable String tiles, @PathVariable String key) throws Exception {

		ModelAndView mv = new ModelAndView();
		String jspName = CommonService.getJspName(tiles, "/board/data/prc_board_data_updateView");
		if (jspName == null) {
			return mv;
		} else {
			mv.setViewName(jspName);
		}

		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);
		// 관리자 검증
		if (user == null) {
			mv.setViewName("redirect:" + Menu.getMN_URL());
			return mv;
		} else {
			String isAdmin = user.get("isAdmin") + "";
			if (!isAdmin.equals("Y")) {
				mv.setViewName("redirect:" + Menu.getMN_URL());
				return mv;
			}
		}
		BoardNotice.setBN_KEYNO(CommonService.getKeyno(key, "BN"));
		BoardNotice = Component.getData("BoardNotice.BN_getData", BoardNotice.getBN_KEYNO());
		mv.addObject("BoardNotice", BoardNotice);
		mv.addObject("BoardType", Component.getData("BoardType.BT_getData", BoardType.getBT_KEYNO()));
		mv.addObject("boardList", Component.getList("Menu.AMN_getBoardTypeList_menu", Menu.getMN_HOMEDIV_C()));

		mv.addObject("tiles", tiles);
		mv.addObject("mirrorPage", Menu.getMN_URL());

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
	@RequestMapping(value = "/{tiles}/Board/moveCheckAjax.do")
	@ResponseBody
	public int adminBoardmoveCheckAjax(HttpServletRequest req, @ModelAttribute BoardNotice BoardNotice)
			throws Exception {

		BoardNotice.setBN_KEYNO(CommonService.getKeyno(BoardNotice.getBN_KEYNO(), "BN"));
		return Component.getCount("BoardNotice.BN_moveCheck", BoardNotice);
	}

	/**
	 * 유저 이동 페이지
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/moveView2.do")
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView BoardDataMoveView2(@ModelAttribute BoardType BoardType, @ModelAttribute BoardColumn BoardColumn,
			@ModelAttribute BoardNotice BoardNotice, @ModelAttribute Menu Menu, HttpServletRequest req,
			@PathVariable String tiles) throws Exception {

		ModelAndView mv = new ModelAndView();
		String jspName = CommonService.getJspName(tiles, "/board/data/prc_board_data_insertView");
		if (jspName == null) {
			return mv;
		} else {
			mv.setViewName(jspName);
		}

		/*
		 * if(!bnkey.equals("")){ BoardNotice.setBN_KEYNO(CommonService.getKeyno(bnkey,
		 * "BN")); }
		 */

		// 이동할 메뉴 게시판 메뉴 정보
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);

		String move_memo = BoardNotice.getBN_MOVE_MEMO();

		BoardNotice = Component.getData("BoardNotice.BN_getData", BoardNotice.getBN_KEYNO());
		BoardNotice.setBN_MOVE_MEMO(move_memo);

		mv.addObject("BoardNotice", BoardNotice);
		mv.addObject("FileSub", Component.getList("File.AFS_FileSelectPutMainkey", BoardNotice.getBN_FM_KEYNO()));
		mv.addObject("BoardType", Component.getData("BoardType.BT_getData_pramMenukey", Menu.getMN_KEYNO()));
		mv.addObject("PreBoardType",
				Component.getData("BoardType.BT_getData_pramMenukey", BoardNotice.getBN_MN_KEYNO()));
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

		mv.addObject("mirrorPage", Menu.getMN_URL());
		mv.addObject("action", "move");

		ActivityHistoryService.setDescBoardAction(Menu, BoardNotice, "moveView", mv);

		return mv;
	}

	/**
	 * 게시물 이동
	 * 
	 * @param req
	 * @param BoardNotice
	 * @param BoardType
	 * @param Menu
	 * @param tiles
	 * @return
	 * @throws Exception
	 */
	// cf쪽만 작업
	@RequestMapping(value = "/{tiles}/Board/data/move.do")
	@CheckActivityHistory(type = "hashmap")
	@Transactional
	public ModelAndView boardDataMove(@ModelAttribute BoardType BoardType, @ModelAttribute BoardColumn BoardColumn,
			@ModelAttribute BoardColumnData BoardColumnData, @ModelAttribute BoardNotice BoardNotice,
			@RequestParam(value = "BD_BL_KEYNO", required = false) String[] BD_BL_KEYNO,
			@RequestParam(value = "BD_BL_TYPE", required = false) String[] BD_BL_TYPE, @PathVariable String tiles,
			@RequestParam(value = "BD_KEYNO", required = false) String[] BD_KEYNO, @ModelAttribute Menu Menu,

			MultipartFile thumbnail, String FM_KEYNO, HttpServletRequest req) throws Exception {
		String key = CommonService.setKeyno(BoardNotice.getBN_KEYNO());
		ModelAndView mv = new ModelAndView("redirect:/" + tiles + "/Board/" + key + "/detailView.do");

		// 이동할 메뉴 게시판 메뉴 정보
		Menu = Component.getData("Menu.AMN_getMenuByKey", Menu);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("BN_KEYNO", BoardNotice.getBN_KEYNO());
		map.put("MN_KEYNO", Menu.getMN_KEYNO());
		map.put("BT_KEYNO", Menu.getMN_BT_KEYNO());
		Component.updateData("BoardNotice.BN_moveBoard", map);

		// 기존 컬럼 데이터 삭제 처리
		Component.deleteData("BoardColumnData.BD_delete", map);

		// 기존 히스토리 삭제 처리
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
						BoardNotice.getBN_KEYNO(), "게시판 썸네일 이미지", BoardNotice.getBN_MODNM(), 1, thumbnail_width,
						thumbnail_height, true);
			} else {
				FileSub = FileUploadTools.imageChange(BoardNotice.getBN_THUMBNAIL(), req, BoardNotice.getBN_MODNM(), 1,
						true, thumbnail_width, thumbnail_height, true);
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
	 * 게시물 이동
	 * 
	 * @param req
	 * @param BoardNotice
	 * @param BoardType
	 * @param Menu
	 * @param tiles
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/move.do")
	@CheckActivityHistory(type = "hashmap")
	public ModelAndView boardDataMove(HttpServletRequest req, BoardNotice BoardNotice, BoardType BoardType, Menu Menu,
			@PathVariable String tiles) throws Exception {
		String key = CommonService.setKeyno(BoardNotice.getBN_KEYNO());
		ModelAndView mv = new ModelAndView("redirect:/" + tiles + "/Board/" + key + "/detailView.do");

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
	}

	/**
	 * 유저 댓글 리스트
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/comment/listAjax.do")
	public ModelAndView CommentList(@ModelAttribute BoardComment BoardComment,
			@RequestParam(value = "BT_DEL_COMMENT_YN", required = false) String BT_DEL_COMMENT_YN,
			HttpServletRequest req, @PathVariable String tiles) throws Exception {

		ModelAndView mv = new ModelAndView();
		String jspName = CommonService.getJspName(tiles, "/board/data/detailView/prc_board_data_detailView_reply_ajax");
		if (jspName == null) {
			return mv;
		} else {
			mv.setViewName(jspName);
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("BC_BN_KEYNO", BoardComment.getBC_BN_KEYNO());
		map.put("DEL_COMMENT_YN", BT_DEL_COMMENT_YN);

		PaginationInfo pageInfo = PageAccess.getPagInfo(BoardComment.getPageIndex(), "BoardComment.BC_getListCnt", map,
				SettingData.BOARD_REPLY_RECORD_COUNT_PER_PAGE);
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("BT_DEL_COMMENT_YN", BT_DEL_COMMENT_YN);

		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		map.put("pageIndex", pageInfo.getCurrentPageNo());

		mv.addObject("BoardCommentList", Component.getList("BoardComment.BC_getList", map));

		return mv;
	}

	/**
	 * 유저 댓글 등록
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/comment/insertAjax.do")
	@Transactional
	@ResponseBody
	public boolean CommentInsert(@ModelAttribute BoardComment BoardComment, HttpServletRequest req) throws Exception {

		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		BoardComment.setBC_KEYNO(CommonService.getTableKey("BC"));
		if (BoardComment.getBC_MAINKEY().equals("")) {
			BoardComment.setBC_MAINKEY(BoardComment.getBC_KEYNO());
			BoardComment.setBC_ROOTKEY(BoardComment.getBC_KEYNO());
		} else {
			BoardComment.setBC_MAINKEY(CommonService.getKeyno(BoardComment.getBC_MAINKEY(), "BC"));
			BoardComment.setBC_ROOTKEY(CommonService.getKeyno(BoardComment.getBC_ROOTKEY(), "BC"));
		}
		BoardComment.setBC_BN_KEYNO(BoardComment.getBC_BN_KEYNO());
		BoardComment.setBC_CONTENTS(BoardComment.getBC_CONTENTS());
		BoardComment.setBC_REGNM((String) user.get("UI_KEYNO"));

		Component.createData("BoardComment.BC_insert", BoardComment);

		return true;
	}

	/**
	 * 유저 댓글 수정
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/comment/updateAjax.do")
	@Transactional
	@ResponseBody
	public void CommentUpdate(@ModelAttribute BoardComment BoardComment, HttpServletRequest req) throws Exception {

		BoardComment.setBC_KEYNO(CommonService.getKeyno(BoardComment.getBC_KEYNO(), "BC"));

		Component.updateData("BoardComment.BC_update", BoardComment);

	}

	/**
	 * 유저 댓글 삭제
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/comment/deleteAjax.do")
	@Transactional
	@ResponseBody
	public void CommentDlelte(@ModelAttribute BoardComment BoardComment, HttpServletRequest req) throws Exception {

		BoardComment.setBC_KEYNO(CommonService.getKeyno(BoardComment.getBC_KEYNO(), "BC"));
		Component.updateData("BoardComment.BC_delete", BoardComment);

	}

	/**
	 * 유저 댓글 좋아요
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/comment/likeUpdateAjax.do")
	@Transactional
	@ResponseBody
	public void CommentLikeUpdate(@ModelAttribute BoardComment BoardComment, HttpServletRequest req) throws Exception {
		String BC_KEYNO = CommonService.getKeyno(BoardComment.getBC_KEYNO(), "BC");
		// 세션당 1번만 가능
		if (req.getSession().getAttribute(BC_KEYNO) == null) {
			Component.updateData("BoardComment.BC_likeUp", BC_KEYNO);
			req.getSession().setAttribute(BC_KEYNO, 'y');
		}
	}

	/**
	 * 유저 댓글 싫어요
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/{tiles}/Board/comment/dislikeUpdateAjax.do")
	@Transactional
	@ResponseBody
	public void CommentDisLikeUpdate(@ModelAttribute BoardComment BoardComment, HttpServletRequest req)
			throws Exception {
		String BC_KEYNO = CommonService.getKeyno(BoardComment.getBC_KEYNO(), "BC");
		// 세션당 1번만 가능
		if (req.getSession().getAttribute(BC_KEYNO) == null) {
			Component.updateData("BoardComment.BC_dislikeUp", BC_KEYNO);
			req.getSession().setAttribute(BC_KEYNO, 'y');
		}
	}

	@RequestMapping(value = "/{tiles}/BoardData/updateView/listAjax.do")
	@ResponseBody
	public List<BoardColumn> columnDatalist(@ModelAttribute BoardColumnData BoardColumnData, HttpServletRequest req)
			throws Exception {
		return Component.getList("BoardColumnData.BD_getList", BoardColumnData.getBD_BN_KEYNO());
	}

	/**
	 * 게시판 데이터 ajax로 가져오기 캘린더형에서 사용중
	 */
	@RequestMapping(value = "/{tiles}/Board/main/viewAjax.do")
	@ResponseBody
	public Map<String, Object> BoardListViewAjax(HttpServletRequest req, @RequestParam Map<String, Object> map)
			throws Exception {

		if (map.get("start") != null) {
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
			String start = dayTime.format(new Date(Long.parseLong((String) map.get("start")) * 1000));
			String end = dayTime.format(new Date(Long.parseLong((String) map.get("end")) * 1000));

			// System.out.println(map.get("MN_KEYNO"));
			map.put("BN_STDT", start);
			map.put("BN_ENDT", end);
		}

		String STDT = (String) map.get("BN_STDT");
		String ENDT = (String) map.get("BN_ENDT");

		Map<String, Object> data = new HashMap<String, Object>();

		data.put("MN_KEYNO", map.get("MN_KEYNO"));
		data.put("BOARD_COLUMN_TYPE_TITLE", SettingData.BOARD_COLUMN_TYPE_TITLE);
		// data.put("BOARD_COLUMN_TYPE_CALENDAR",
		// SettingData.BOARD_COLUMN_TYPE_CALENDAR);
		data.put("BOARD_COLUMN_TYPE_CALENDAR_START", SettingData.BOARD_COLUMN_TYPE_CALENDAR_START);
		data.put("BOARD_COLUMN_TYPE_CALENDAR_END", SettingData.BOARD_COLUMN_TYPE_CALENDAR_END);
		// 제목,시작,종료일 BL_KEYNO 가져옴
		List<Map<String, Object>> result = Component.getList("BoardNotice.BN_getBLkeys", data);
		for (Map<String, Object> r : result) {
			String TYPE = (String) r.get("TYPE");
			switch (TYPE) {
			case "TITLE":
				map.put("NAME_BL_KEYNO", r.get("BL_KEYNO"));
				break;
			case "STDT":
				map.put("STDT_BL_KEYNO", r.get("BL_KEYNO"));
				break;
			case "ENDT":
				map.put("ENDT_BL_KEYNO", r.get("BL_KEYNO"));
				break;
			default:
				break;
			}
		}

		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("eventList", Component.getList("BoardNotice.BN_getUserDataListCalendar", map));
		returnMap.put("holidayList", HolidayService.getHolidays(STDT, ENDT));

		return returnMap;
	}

	@RequestMapping(value = "/jact/RSSView.do")
	public ModelAndView RSS(@RequestParam(value = "MN_KEYNO") String mn_key, HttpServletRequest req, Menu Menu)
			throws Exception {

		ModelAndView mv = new ModelAndView("/jact/board/data/test.none");
		mv.addObject("BoardColumnList", Component.getList("BoardColumn.BL_getviewList", mn_key));

		return mv;
	}

	// /**
	// * 게시판 리스트 데이터 ajax로 가져오기
	// * 메인 캘린더에서 사용
	// */
	// @RequestMapping(value="/home/Board/main/DetaiList/viewAjax.do")
	// @ResponseBody
	// public List<HashMap<String, Object>>
	// BoardDetailListView2Ajax(HttpServletRequest req
	// ,@RequestParam(value="keyList", required=false) String keyList
	// ) throws Exception {
	// List<HashMap<String, Object>> resultList = new ArrayList<>();
	// HashMap<String,Object> map = new HashMap<String,Object>();
	// List<HashMap<String, Object>> list = new ArrayList<>();
	// keyList = keyList.substring(5);
	// if(keyList != null && !keyList.equals("")){
	// String[] key = keyList.replace("lc-key-", "").replaceAll(" ",
	// ",").split(",");
	// for(int i=0; i<key.length; i++){
	// HashMap<String, Object> data = new HashMap<>();
	// data.put("key", Component.getKeyno(key[i], "BN"));
	// list.add(data);
	// }
	// map.put("keys", list);
	// map.put("startDate", SettingData.BOARD_COLUMN_TYPE_CALENDAR_START);
	// map.put("endDate", SettingData.BOARD_COLUMN_TYPE_CALENDAR_END);
	// resultList = Component.getList("BoardNotice.getMainCalenderDetail", map);
	// }
	//
	// return resultList;
	// }

}
