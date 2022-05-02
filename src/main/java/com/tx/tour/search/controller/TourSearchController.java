package com.tx.tour.search.controller;

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
import com.tx.admin.function.keyword.service.impl.KeywordServiceImpl;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.page.PageAccess;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * @FileName: SearchController.java
 * @Project : tour
 * @Date    : 2017. 06. 12. 
 * @Author  : 이재령	
 * @Version : 1.0
 */
@Controller
public class TourSearchController {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;

	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/** 키워드 서비스 */
	@Autowired private KeywordServiceImpl KeywordService;
	
	/**
	 * 통합검색
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/tour/search.do")
	public ModelAndView cfUseSearch(HttpServletRequest req
			, Common search
			, Menu Menu
			, BoardNotice BoardNotice
			, @RequestParam(value="detail",required=false) String detail) throws Exception {
		ModelAndView mv  = new ModelAndView("/tour/search/prc_search");
		
		if(detail != null){
			mv.addObject("detail",detail);
		}
		
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
		
		//웹페이지
		mv.addObject("search",search);
		
		Menu.setMN_HOMEDIV_C(SettingData.HOMEDIV_TOUR);
		Menu.setMN_USE_YN("Y");
		Menu.setMN_DEL_YN("N");
		
		PaginationInfo webPageInfo = PageAccess.getPagInfo(Menu.getPageIndex(),"search.MN_getWebMenuListCnt",Menu, 5,5);
		Menu.setFirstIndex(0);
		Menu.setRecordCountPerPage(4);
		mv.addObject("webPaginationInfo", webPageInfo);
		
		List<Map<String,Object>> webSearchList = Component.getList("search.MN_getWebMenuList", Menu);
		for(Map<String,Object> m : webSearchList){
			m.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",m.get("MN_KEYNO")));
			//페이지 관리에서 관리하는 메뉴라면 본문 내용 셋팅
			if(m.get("MVD_DATA") != null){
				String mvd_data = m.get("MVD_DATA") + "";
				mvd_data = getText(mvd_data,search.getSearchKeywordArr());
				m.put("MVD_DATA", mvd_data);
			}
		}
		mv.addObject("webSearchList", webSearchList );
		
		//게시판
		BoardNotice.setBN_MN_KEYNO(SettingData.HOMEDIV_TOUR);
		
		PaginationInfo boardPageInfo = PageAccess.getPagInfo(BoardNotice.getPageIndex(),"search.BN_getCnt",BoardNotice, 5,5);
		BoardNotice.setFirstIndex(0);
		BoardNotice.setRecordCountPerPage(4);
		mv.addObject("boardPaginationInfo", boardPageInfo);
		
		List<Map<String,Object>> boardSearchList = Component.getList("search.BN_getList", BoardNotice);
		for(Map<String,Object> b : boardSearchList){
			b.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("BN_MN_KEYNO")));
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
		BoardNotice.setRecordCountPerPage(4);
		mv.addObject("filePaginationInfo", filePageInfo);
		
		List<Map<String,Object>> fileSearchList = Component.getList("search.FS_getList", BoardNotice);
		for(Map<String,Object> b : fileSearchList){
			b.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("BN_MN_KEYNO")));
			if(b.get("FS_ORINM") != null){
				String FS_ORINM = b.get("FS_ORINM") + "";
				FS_ORINM = getText(FS_ORINM,search.getSearchKeywordArr());
				b.put("FS_ORINM", FS_ORINM);
			}
		}
		mv.addObject("fileSearchList", fileSearchList );
		
		if(search.getSearchKeyword() != null && !search.getSearchKeyword().equals("")){
			KeywordService.checkKeyword(search.getSearchKeyword(), req);
		}
		
		//문화관광
		PaginationInfo tourPageInfo = PageAccess.getPagInfo(Menu.getPageIndex(),"search.MN_getTourMenuListCnt",Menu, 5,5);
		Menu.setFirstIndex(0);
		Menu.setRecordCountPerPage(4);
		mv.addObject("tourPaginationInfo", tourPageInfo);
		
		List<Map<String,Object>> tourSearchList = Component.getList("search.MN_getTourMenuList", Menu);
		for(Map<String,Object> b : tourSearchList){
			b.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("MN_KEYNO")));
			if(b.get("TC_CONTENTS") != null){
				String TC_CONTENTS = b.get("TC_CONTENTS") + "";
				TC_CONTENTS = getText(TC_CONTENTS,search.getSearchKeywordArr());
				b.put("TC_CONTENTS", TC_CONTENTS);
			}
		}
		mv.addObject("tourSearchList", tourSearchList );
		
		if(search.getSearchKeyword() != null && !search.getSearchKeyword().equals("")){
			KeywordService.checkKeyword(search.getSearchKeyword(), req);
		}
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
				content = content.replaceAll(keyword, "<span class=\"spe\">"+keyword+"</span>");
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

	@RequestMapping(value="/tour/search/{type}/dataAjax.do")
	public ModelAndView cfUseSearchAjax(Common search
			, Menu Menu
			, BoardNotice BoardNotice
			,@PathVariable String type) throws Exception {
		ModelAndView mv  = new ModelAndView("/tour/search/prc_search_ajax");
		
		mv.addObject("type",type);
		search.setSearchKeyword(search.getSearchKeyword().trim());
		Menu.setSearchKeyword(search.getSearchKeyword().trim());
		BoardNotice.setSearchKeyword(search.getSearchKeyword().trim());
		
		search.setSearchKeywordArr(search.getSearchKeyword().split(" "));
		Menu.setSearchKeywordArr(search.getSearchKeywordArr());
		BoardNotice.setSearchKeywordArr(search.getSearchKeywordArr());
		switch (type) {
		case "web":
			Menu.setSearchKeywordArr(Menu.getSearchKeyword().split(" "));
			if(search.getSearchCondition() != null && !search.getSearchCondition().equals("")){
				String date[] = getDateScope(search.getSearchCondition());
				if(date != null){
					Menu.setSearchBeginDate(date[0]);
					Menu.setSearchEndDate(date[1]);
				}
			}
			//메뉴
			Menu.setMN_HOMEDIV_C(SettingData.HOMEDIV_TOUR);
			Menu.setMN_USE_YN("Y");
			Menu.setMN_DEL_YN("N");
			
			PaginationInfo webPageInfo = PageAccess.getPagInfo(Menu.getPageIndex(),"search.MN_getWebMenuListCnt",Menu, 5,5);
			Menu.setFirstIndex(webPageInfo.getFirstRecordIndex());
			Menu.setLastIndex(webPageInfo.getLastRecordIndex());
			Menu.setRecordCountPerPage(webPageInfo.getRecordCountPerPage());
			Menu.setPageIndex(webPageInfo.getCurrentPageNo());
			mv.addObject("webPaginationInfo", webPageInfo);
			
			List<Map<String,Object>> webSearchList = Component.getList("search.MN_getWebMenuList", Menu);
			for(Map<String,Object> m : webSearchList){
				m.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",m.get("MN_KEYNO")));
				//페이지 관리에서 관리하는 메뉴라면 본문 내용 셋팅
				if(m.get("MVD_DATA") != null){
					String mvd_data = m.get("MVD_DATA") + "";
					mvd_data = getText(mvd_data,search.getSearchKeywordArr());
					m.put("MVD_DATA", mvd_data);
				}
			}
			mv.addObject("webSearchList", webSearchList );
			break;
		case "board":
			BoardNotice.setBN_MN_KEYNO(SettingData.HOMEDIV_TOUR);
			
			BoardNotice.setSearchKeywordArr(BoardNotice.getSearchKeyword().split(" "));
			if(search.getSearchCondition() != null && !search.getSearchCondition().equals("")){
				String date[] = getDateScope(search.getSearchCondition());
				if(date != null){
					BoardNotice.setSearchBeginDate(date[0]);
					BoardNotice.setSearchEndDate(date[1]);
				}
			}
			//게시판
			PaginationInfo boardPageInfo = PageAccess.getPagInfo(BoardNotice.getPageIndex(),"search.BN_getCnt",BoardNotice, 5,5);
			BoardNotice.setFirstIndex(boardPageInfo.getFirstRecordIndex());
			BoardNotice.setLastIndex(boardPageInfo.getLastRecordIndex());
			BoardNotice.setRecordCountPerPage(boardPageInfo.getRecordCountPerPage());
			BoardNotice.setPageIndex(boardPageInfo.getCurrentPageNo());
			mv.addObject("boardPaginationInfo", boardPageInfo);
			
			List<Map<String,Object>> boardSearchList = Component.getList("search.BN_getList", BoardNotice);
			for(Map<String,Object> b : boardSearchList){
				b.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("BN_MN_KEYNO")));
				if(b.get("BN_CONTENTS") != null){
					String BN_CONTENTS = b.get("BN_CONTENTS") + "";
					BN_CONTENTS = getText(BN_CONTENTS,search.getSearchKeywordArr());
					b.put("BN_CONTENTS", BN_CONTENTS);
				}
			}
			mv.addObject("boardSearchList", boardSearchList );
			break;
		case "file":
			BoardNotice.setBN_MN_KEYNO(SettingData.HOMEDIV_TOUR);
			BoardNotice.setSearchKeywordArr(BoardNotice.getSearchKeyword().split(" "));
			if(search.getSearchCondition() != null && !search.getSearchCondition().equals("")){
				String date[] = getDateScope(search.getSearchCondition());
				if(date != null){
					BoardNotice.setSearchBeginDate(date[0]);
					BoardNotice.setSearchEndDate(date[1]);
				}
			}
			//자료
			PaginationInfo filePageInfo = PageAccess.getPagInfo(BoardNotice.getPageIndex(),"search.FS_getCnt",BoardNotice, 5,5);
			BoardNotice.setFirstIndex(filePageInfo.getFirstRecordIndex());
			BoardNotice.setLastIndex(filePageInfo.getLastRecordIndex());
			BoardNotice.setRecordCountPerPage(filePageInfo.getRecordCountPerPage());
			BoardNotice.setPageIndex(filePageInfo.getCurrentPageNo());
			mv.addObject("filePaginationInfo", filePageInfo);
			
			List<Map<String,Object>> fileSearchList = Component.getList("search.FS_getList", BoardNotice);
			for(Map<String,Object> b : fileSearchList){
				b.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("BN_MN_KEYNO")));
			}
			mv.addObject("fileSearchList", fileSearchList );
		case "tour":
			Menu.setMN_HOMEDIV_C(SettingData.HOMEDIV_TOUR);
			Menu.setMN_USE_YN("Y");
			Menu.setMN_DEL_YN("N");
			//문화관광
			PaginationInfo tourPageInfo = PageAccess.getPagInfo(Menu.getPageIndex(),"search.MN_getTourMenuListCnt",Menu, 5,5);
			Menu.setFirstIndex(tourPageInfo.getFirstRecordIndex());
			Menu.setLastIndex(tourPageInfo.getLastRecordIndex());
			Menu.setRecordCountPerPage(tourPageInfo.getRecordCountPerPage());
			Menu.setPageIndex(tourPageInfo.getCurrentPageNo());
			mv.addObject("tourPaginationInfo", tourPageInfo);
			
			List<Map<String,Object>> tourSearchList = Component.getList("search.MN_getTourMenuList", Menu);
			for(Map<String,Object> b : tourSearchList){
				b.put("MN_MAINNAMES", Component.getData("search.MN_getMainNames",b.get("MN_KEYNO")));
				if(b.get("TC_CONTENTS") != null){
					String TC_CONTENTS = b.get("TC_CONTENTS") + "";
					TC_CONTENTS = getText(TC_CONTENTS,search.getSearchKeywordArr());
					b.put("TC_CONTENTS", TC_CONTENTS);
				}
			}
			mv.addObject("tourSearchList", tourSearchList );
		default:
			break;
		}
		
		
		return mv;
	}

	
}
