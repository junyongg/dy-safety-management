package com.tx.jact.search.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.board.dto.BoardNotice;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.page.PageAccess;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 */
@Controller
public class jactSearchController {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;

	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/**
	 * 통합검색
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/{tiles}/use/search.do")
	public ModelAndView cfUseSearch(HttpServletRequest req
			, Common search
			, Menu Menu
			, BoardNotice BoardNotice
			, @RequestParam(value="select_menu",required=false) String select_menu
			, @PathVariable String tiles
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/"+tiles+"/search/prc_search");
		
		if(Menu.getUpanddown() == null || Menu.getUpanddown() == "") {
			Menu.setUpanddown("down");
			BoardNotice.setUpanddown("down");
		}
		
		if(Menu.getUpanddown().equals("up")) {
			BoardNotice.setUpanddown("up");
		}else {
			BoardNotice.setUpanddown("down");
		}
		
		if(select_menu == null) {
			select_menu = "all";
		}
		mv.addObject("select_menu",select_menu);
		if(search.getSearchKeyword().equals("")){ // 검색어가 없을시 그냥 리턴처리
			return mv;
		}
		
		search.setSearchKeyword(search.getSearchKeyword().trim());
		Menu.setSearchKeyword(search.getSearchKeyword().trim());
		BoardNotice.setSearchKeyword(search.getSearchKeyword().trim());
		
		search.setSearchKeywordArr(search.getSearchKeyword().split(" "));
		Menu.setSearchKeywordArr(search.getSearchKeywordArr());
		BoardNotice.setSearchKeywordArr(search.getSearchKeywordArr());
		
		if(search.getSearchCondition() != null && !search.getSearchCondition().equals("")){
			
			String date[] = getDateScope(search.getSearchCondition());
			if(date != null){
				search.setSearchBeginDate(date[0]);
				search.setSearchEndDate(date[1]);
				Menu.setSearchBeginDate(date[0]);
				Menu.setSearchEndDate(date[1]);
				BoardNotice.setSearchBeginDate(date[0]);
				BoardNotice.setSearchEndDate(date[1]);
			}
		}
		//메뉴
		mv.addObject("search",search);
		Menu.setMN_HOMEDIV_C(SettingData.HOMEDIV_JACT);
		Menu.setMN_HOMEDIV_C2(SettingData.HOMEDIV_CULTURE);
		Menu.setMN_USE_YN("Y");
		Menu.setMN_DEL_YN("N");
		
		PaginationInfo menuPageInfo = PageAccess.getPagInfo(Menu.getPageIndex(),"search.MN_getMenuListCnt",Menu, 5,5);
		Menu.setFirstIndex(0);
		Menu.setRecordCountPerPage(3);
		mv.addObject("menuPaginationInfo", menuPageInfo);
		mv.addObject("keyword2",Menu.getKeyword2());
		
		
		List<Map<String,Object>> menuSearchList = Component.getList("search.MN_getMenuList", Menu);
		for(Map<String,Object> m : menuSearchList){
			m.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",m.get("MN_KEYNO")));
			//페이지 관리에서 관리하는 메뉴라면 본문 내용 셋팅
//			if(m.get("MVD_DATA") != null){
//				String mvd_data = m.get("MVD_DATA") + "";
//				mvd_data = getText(mvd_data,search.getSearchKeywordArr());
//				m.put("MVD_DATA", mvd_data);
//			}
		}
		mv.addObject("menuSearchList", menuSearchList );
		
		//페이지
		PaginationInfo PageInfo = PageAccess.getPagInfo(Menu.getPageIndex(),"search.PG_getListCNT",Menu, 5,5);
		Menu.setFirstIndex(0);
		Menu.setRecordCountPerPage(3);
		mv.addObject("PaginationInfo", PageInfo);
		
		List<Map<String,Object>> PageSearchList = Component.getList("search.PG_getList", Menu);
		for(Map<String,Object> p : PageSearchList){
			p.put("PG_MN_MAINNAMES", Component.getData("search.MN_getMainNames",p.get("MN_KEYNO")));
			//페이지 관리에서 관리하는 메뉴라면 본문 내용 셋팅
			if(p.get("MVD_DATA") != null){
				String mvd_data = p.get("MVD_DATA") + "";
				mvd_data = getText(mvd_data,search.getSearchKeywordArr());
				p.put("MVD_DATA", mvd_data);
			}
		}
		mv.addObject("PageSearchList", PageSearchList );
		
		
		
		//게시판 
		BoardNotice.setKeyword2(Menu.getKeyword2());
		BoardNotice.setBN_MN_KEYNO(SettingData.HOMEDIV_JACT);
		BoardNotice.setBN_MN_KEYNO2(SettingData.HOMEDIV_CULTURE);
		
		PaginationInfo boardPageInfo = PageAccess.getPagInfo(BoardNotice.getPageIndex(),"search.BN_getCnt",BoardNotice, 5,5);
		BoardNotice.setFirstIndex(0);
		BoardNotice.setRecordCountPerPage(3);
		mv.addObject("boardPaginationInfo", boardPageInfo);
		
		List<Map<String,Object>> boardSearchList = Component.getList("search.BN_getList", BoardNotice);
		for(Map<String,Object> b : boardSearchList){
			b.put("BD_MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("BN_MN_KEYNO")));
			if(b.get("BN_CONTENTS") != null){
				String BN_CONTENTS = b.get("BN_CONTENTS") + "";
				BN_CONTENTS = getText(BN_CONTENTS,search.getSearchKeywordArr());
				b.put("BN_CONTENTS", BN_CONTENTS);
			}
		}
		mv.addObject("boardSearchList", boardSearchList );
		
		
		//자료
		PaginationInfo filePageInfo = PageAccess.getPagInfo(BoardNotice.getPageIndex(),"search.FS_getCnt",BoardNotice, 5,5);
		BoardNotice.setFirstIndex(0);
		BoardNotice.setRecordCountPerPage(3);
		mv.addObject("filePaginationInfo", filePageInfo);
		
		List<Map<String,Object>> fileSearchList = Component.getList("search.FS_getList", BoardNotice);
		for(Map<String,Object> b : fileSearchList){
			b.put("FS_MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("BN_MN_KEYNO")));
		}
		mv.addObject("fileSearchList", fileSearchList );
		
		//정확도순
		mv.addObject("OrderCondition",BoardNotice.getOrderCondition());
		mv.addObject("Updown",Menu.getUpanddown());
		
		
		return mv;
	}
	
	
	/**
	 * html 에서 태그 제거 + 글자 자르기 + 하이라이트 표시 ( 키워드를 <font class="searchKeyword"></font>로 감쌈)
	 * @param content
	 * @param searchKeywardArr 
	 * @return
	 */
	private String getText(String content, String[] searchKeywardArr) {
        content = content.replaceAll("<!--.*-->","");

		Pattern SCRIPTS = Pattern.compile("<script([^'\"]|\"[^\"]*\"|'[^']*')*?</script>",Pattern.DOTALL);
		Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);
		Pattern TAGS = Pattern.compile("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>");
//		Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
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
		
		String firstEllipsis = "···"; 
		String lastEllipsis = "···"; 
		
		int length = content.length(); // 검색 내용 길이
		int start = length, end = 0;
		
		for(String keyword : searchKeywardArr){
			if(content.contains(keyword) && content.indexOf(keyword) < start){ // 모든 키워드를 포문 돌려서 가장 먼저 나오는 키워드의 시작 인덱스를 구함
				start = content.indexOf(keyword);  // 검색된 키워드 첫 index
				end  = start + keyword.length();   // 검색된 키워드 끝 index
			}
		}
		
		if(start < length){ // 키워드가 존재할시
			int first = 0,last = 0;
			if(length - end < 150){ //검색된 키워드 뒤로 글자가 부족할경우 앞에 글을 좀더 길게 자름
				first = start - 150 - (150 - (length - end));
				if(first < 0){
					first = 0;
					firstEllipsis = "";
				}
				last = length;
				lastEllipsis = "";
			}else if (start < 150){ //검색된 키워드 앞으로 글자가 부족할 경우 뒤에서 글을 좀더 길게 자름
				first = 0;
				firstEllipsis = "";
				last = end + 150 + (150 - start);
				if(last > length){
					last = length;
					lastEllipsis = "";
				}
			}else{
				first = start - 150 ;
				last = end + 150;
			}
			
			
			content = firstEllipsis +  content.substring(first, last) + lastEllipsis;
		}else if(length > 300){
			content = content.substring(0, 300) + lastEllipsis;
		}
		
		for(String keyword : searchKeywardArr){
			if(content.contains(keyword)){ 
				content = content.replaceAll(keyword, "<font class=\"searchKeyword\">"+keyword+"</font>");
			}
		}
		
		
		
		return content;

	}



	
	
	/**
	 * 날짜 리턴
	 * @param searchCondition
	 * @return
	 */
	private String[] getDateScope(String searchCondition) {
		// TODO Auto-generated method stub
		String date[] = new String[2];
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    /*cal.add(Calendar.DATE, 2);
	    cal.add(Calendar.MONTH, 2);*/
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");


		switch (searchCondition) {
		case "day":
			date[1] =  df.format(cal.getTime());
			date[0] =  df.format(cal.getTime());
			break;
		case "week":
			date[1] =  df.format(cal.getTime());
			cal.add(Calendar.DATE, -7);
			date[0] =  df.format(cal.getTime());
			break;
		case "month":
			date[1] =  df.format(cal.getTime());
			cal.add(Calendar.MONTH, -1);
			date[0] =  df.format(cal.getTime());
			break;
		case "year":
			date[1] =  df.format(cal.getTime());
			cal.add(Calendar.YEAR, -1);
			date[0] =  df.format(cal.getTime());
			break;
		case "all":
		case "etc":
			return null;
		default:
			break;
		}
		
		return date;
	}

	@RequestMapping(value="/{tiles}/search/{type}/dataAjax.do")
	public ModelAndView cfUseSearchAjax(Common search
			, Menu Menu
			, BoardNotice BoardNotice
			,@PathVariable String type
			,@PathVariable String tiles
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/"+tiles+"/search/prc_search_ajax");
		
		mv.addObject("type",type);
		search.setSearchKeyword(search.getSearchKeyword().trim());
		Menu.setSearchKeyword(search.getSearchKeyword().trim());
		BoardNotice.setSearchKeyword(search.getSearchKeyword().trim());
		
		search.setSearchKeywordArr(search.getSearchKeyword().split(" "));
		Menu.setSearchKeywordArr(search.getSearchKeywordArr());
		BoardNotice.setSearchKeywordArr(search.getSearchKeywordArr());
		switch (type) {
		case "menu":
			Menu.setSearchKeywordArr(Menu.getSearchKeyword().split(" "));
			if(search.getSearchCondition() != null && !search.getSearchCondition().equals("")){
				String date[] = getDateScope(search.getSearchCondition());
				if(date != null){
					Menu.setSearchBeginDate(date[0]);
					Menu.setSearchEndDate(date[1]);
				}
			}
			//메뉴
			Menu.setMN_HOMEDIV_C("MN_0000001486");
			Menu.setMN_HOMEDIV_C2(SettingData.HOMEDIV_CULTURE);
			Menu.setMN_USE_YN("Y");
			Menu.setMN_DEL_YN("N");
			
			PaginationInfo menuPageInfo = PageAccess.getPagInfo(Menu.getPageIndex(),"search.MN_getMenuListCnt",Menu, 5,5);
			Menu.setFirstIndex(menuPageInfo.getFirstRecordIndex());
			Menu.setLastIndex(menuPageInfo.getLastRecordIndex());
			Menu.setRecordCountPerPage(menuPageInfo.getRecordCountPerPage());
			Menu.setPageIndex(menuPageInfo.getCurrentPageNo());
			mv.addObject("menuPaginationInfo", menuPageInfo);
			
			List<Map<String,Object>> menuSearchList = Component.getList("search.MN_getMenuList", Menu);
			for(Map<String,Object> m : menuSearchList){
				m.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",m.get("MN_KEYNO")));
//				//페이지 관리에서 관리하는 메뉴라면 본문 내용 셋팅
//				if(m.get("MM_NAME") != null){
//					String mvd_data = m.get("MM_NAME") + "";
//					mvd_data = getText(mvd_data,search.getSearchKeywordArr());
//					m.put("MM_NAME", mvd_data);
//				}
			}
			mv.addObject("menuSearchList", menuSearchList );
			break;
			
		case "page":
			Menu.setSearchKeywordArr(Menu.getSearchKeyword().split(" "));
			if(search.getSearchCondition() != null && !search.getSearchCondition().equals("")){
				String date[] = getDateScope(search.getSearchCondition());
				if(date != null){
					Menu.setSearchBeginDate(date[0]);
					Menu.setSearchEndDate(date[1]);
				}
			}
			//메뉴
			Menu.setMN_HOMEDIV_C("MN_0000001486");
			Menu.setMN_HOMEDIV_C2(SettingData.HOMEDIV_CULTURE);
			Menu.setMN_USE_YN("Y");
			Menu.setMN_DEL_YN("N");
			
			PaginationInfo PageInfo = PageAccess.getPagInfo(Menu.getPageIndex(),"search.PG_getListCNT",Menu, 5,5);
			Menu.setFirstIndex(PageInfo.getFirstRecordIndex());
			Menu.setLastIndex(PageInfo.getLastRecordIndex());
			Menu.setRecordCountPerPage(PageInfo.getRecordCountPerPage());
			Menu.setPageIndex(PageInfo.getCurrentPageNo());
			mv.addObject("PaginationInfo", PageInfo);
			
			List<Map<String,Object>> PageSearchList = Component.getList("search.PG_getList", Menu);

			for(Map<String,Object> p : PageSearchList){
				p.put("PG_MN_MAINNAMES", Component.getData("search.MN_getMainNames",p.get("MN_KEYNO")));
				//페이지 관리에서 관리하는 메뉴라면 본문 내용 셋팅
				if(p.get("MVD_DATA") != null){
					String mvd_data = p.get("MVD_DATA") + "";
					mvd_data = getText(mvd_data,search.getSearchKeywordArr());
					p.put("MVD_DATA", mvd_data);
				}
			}
			mv.addObject("PageSearchList", PageSearchList );
			break;	
			
		
		case "board":
			BoardNotice.setBN_MN_KEYNO(SettingData.HOMEDIV_JACT);
			BoardNotice.setBN_MN_KEYNO2(SettingData.HOMEDIV_CULTURE);
			BoardNotice.setSearchKeywordArr(BoardNotice.getSearchKeyword().split(" "));
			//게시판
			PaginationInfo boardPageInfo = PageAccess.getPagInfo(BoardNotice.getPageIndex(),"search.BN_getCnt",BoardNotice, 5,5);
			BoardNotice.setFirstIndex(boardPageInfo.getFirstRecordIndex());
			BoardNotice.setLastIndex(boardPageInfo.getLastRecordIndex());
			BoardNotice.setRecordCountPerPage(boardPageInfo.getRecordCountPerPage());
			BoardNotice.setPageIndex(boardPageInfo.getCurrentPageNo());
			mv.addObject("boardPaginationInfo", boardPageInfo);
			
			List<Map<String,Object>> boardSearchList = Component.getList("search.BN_getList", BoardNotice);
			for(Map<String,Object> b : boardSearchList){
				b.put("BD_MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("BN_MN_KEYNO")));
				if(b.get("BN_CONTENTS") != null){
					String BN_CONTENTS = b.get("BN_CONTENTS") + "";
					BN_CONTENTS = getText(BN_CONTENTS,search.getSearchKeywordArr());
					b.put("BN_CONTENTS", BN_CONTENTS);
				}
			}
			mv.addObject("boardSearchList", boardSearchList );
			break;
		case "file":
			BoardNotice.setSearchKeywordArr(BoardNotice.getSearchKeyword().split(" "));
			//자료
			PaginationInfo filePageInfo = PageAccess.getPagInfo(BoardNotice.getPageIndex(),"search.FS_getCnt",BoardNotice, 5,5);
			BoardNotice.setFirstIndex(filePageInfo.getFirstRecordIndex());
			BoardNotice.setLastIndex(filePageInfo.getLastRecordIndex());
			BoardNotice.setRecordCountPerPage(filePageInfo.getRecordCountPerPage());
			BoardNotice.setPageIndex(filePageInfo.getCurrentPageNo());
			mv.addObject("filePaginationInfo", filePageInfo);
			
			List<Map<String,Object>> fileSearchList = Component.getList("search.FS_getList", BoardNotice);
			for(Map<String,Object> b : fileSearchList){
				b.put("FS_MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("BN_MN_KEYNO")));
			}
			mv.addObject("fileSearchList", fileSearchList );
		default:
			break;
		}
		
		
		return mv;
	}

	
}
