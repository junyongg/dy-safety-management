package com.tx.jcia.news.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.common.SNS.SNSInfo;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.page.PageAccess;
import com.tx.jcia.news.dto.NewsDTO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * @FileName: NewsController.java
 * @Project : cf
 * @Date : 2018. 05. 18.
 * @Author : 이혜주
 * @Version : 1.0
 */
@Controller
public class JciaNewsController {

	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;

	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	/**
	 * 뉴스레터 신청 처리
	 * @param NewsDTO
	 * @return
	 * @throws Exception  
	 */ 
	@Transactional
	@RequestMapping(value = "/jcia/news/newsInsert.do")
	@CheckActivityHistory(desc="뉴스레터 - 신청 처리")
	public ModelAndView newsInsert(HttpServletRequest req
			, Map<String, Object> commandMap
			, @ModelAttribute("news") NewsDTO NewsDTO
			, Model model
			, BindingResult bindingResult
			) throws Exception {
		ModelAndView mv = new ModelAndView();
		NewsDTO.setNL_KEYNO(CommonService.getTableKey("NL"));
		NewsDTO.setNL_IP(CommonService.getClientIP(req));
		
//		new NewsValidate().validate(NewsDTO, bindingResult); //validation을 수행한다.
//		beanValidator.validate(ExpertDTO, bindingResult);

//		if (bindingResult.hasErrors()) {
//			model.addAttribute("news", NewsDTO);
//		}
		
		Component.createData("News.NL_Insert", NewsDTO);
		mv.setViewName("redirect:/jcia/index.do");
		return mv;
	}

	/**
	 * 뉴스레터 페이지 방문
	 * @param NewsDTO
	 * @return
	 * @throws Exception  
	 */ 
	@RequestMapping(value="/jcia/information/newsletter.do")
	public ModelAndView newsletterList(HttpServletRequest req
			,@ModelAttribute NewsDTO NewsDTO
			,@ModelAttribute Menu Menu
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/jcia/news/prc_newsletter_listView");
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(NewsDTO.getPageIndex(),"News.NM_SELECT_CNT",NewsDTO, 10, 5);			
		NewsDTO.setFirstIndex(pageInfo.getFirstRecordIndex());
		NewsDTO.setLastIndex(pageInfo.getLastRecordIndex());
		NewsDTO.setRecordCountPerPage(pageInfo.getRecordCountPerPage());
		mv.addObject("paginationInfo", pageInfo);

		List<NewsDTO> NewsLetterList = Component.getList("News.NM_SELECT", NewsDTO);
		
		mv.addObject("NewsLetterList",NewsLetterList);
		
		return mv;
	}
	
	/**
	 * 뉴스레터 등록 페이지 방문
	 * @param NewsDTO
	 * @return
	 * @throws Exception  
	 */ 
	@RequestMapping(value="/jcia/information/newsletter/insertView.do")
	public ModelAndView newsletterInsertView(
			 HttpServletRequest req
			,HttpServletResponse res 
			,@ModelAttribute NewsDTO NewsDTO
			,@ModelAttribute Menu Menu
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/jcia/news/prc_news_insertView");
		
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		if(user == null){  // 비회원일시
			PrintWriter out = res.getWriter();
			res.setContentType("text/html; charset=UTF-8");
			res.setCharacterEncoding("UTF-8"); 
			out.println("<script language='javascript'>");
			out.println("alert('권한이 없습니다.'); history.go(-1);");
			out.println("</script>");
			out.flush();
			return null;
		}
		
		mv.addObject("Numbering", Component.getData("News.Numbering"));
		mv.addObject("mirrorPage","/jcia/information/newsletter.do");
		mv.addObject("action","insert");
		return mv;
	}
	
	/**
	 * 뉴스레터 등록/수정 처리
	 * @param req
	 * @param commandMap
	 * @param NewsDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/jcia/information/newsletter/Insert.do")
	@CheckActivityHistory(desc="뉴스레터 등록/수정 처리")
	@Transactional
	public ModelAndView newsletterInsert(
			  HttpServletRequest req
			, @ModelAttribute NewsDTO NewsDTO
			, @RequestParam(value="listfile",required = false) MultipartFile listfile
			, @RequestParam(value="type",required = false) String type
			) throws Exception {
		ModelAndView mv  = new ModelAndView();
		
		String REGNM = NewsDTO.getNM_REGNM();
		
		//리스트 이미지 저장
		if(listfile != null && !listfile.isEmpty()){
			String FM_KEYNO = CommonService.getTableKey("FM");
			FileSub sub = null;
			sub = FileUploadTools.FileUpload(listfile, FM_KEYNO, REGNM, true);
			NewsDTO.setNM_FS_KEYNO(sub.getFS_KEYNO());
		}
		
		if("N".equals(type)){
			NewsDTO.setNM_KEYNO(CommonService.getTableKey("NM"));
			Component.createData("News.NM_Insert", NewsDTO);
		}else if("U".equals(type)){
			NewsDTO.setNM_KEYNO(CommonService.getKeyno(NewsDTO.getNM_KEYNO(), "NM"));
			Component.createData("News.NM_Update", NewsDTO);
		}
		
		mv.setViewName("redirect:/jcia/information/newsletter.do");
		return mv;
	}
	
	/**
	 * 뉴스레터 상세 페이지
	 * @param NewsDTO
	 * @return
	 * @throws Exception  
	 */ 
	@RequestMapping(value="/jcia/information/newsletter/{keyno}/detail.do")
	public ModelAndView newsletterView(HttpServletRequest req
			,@ModelAttribute NewsDTO NewsDTO
			,@PathVariable String keyno
			,@ModelAttribute SNSInfo SNSInfo
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/jcia/news/prc_newsletter_detailView");
		NewsDTO.setNM_KEYNO(CommonService.getKeyno(keyno, "NM"));
		Map<String,Object> map =Component.getData("News.NM_SELECT", NewsDTO);
		mv.addObject("resultData", map);
		
		//xss filter
	    String content = null;
	    content = NewsDTO.getNM_CONTENT();	    	
	    
		// SNS
		SNSInfo.setTITLE(NewsDTO.getNM_TITLE());
		/*String content = BoardNotice.getBN_CONTENTS();*/
		Pattern SCRIPTS = Pattern.compile("<script([^'\"]|\"[^\"]*\"|'[^']*')*?</script>",Pattern.DOTALL);
		Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);
		Pattern TAGS = Pattern.compile("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>");
//		Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
		Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
		Pattern WHITESPACE = Pattern.compile("\\s\\s+");

		Matcher m;
		if(content != null){
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
			if(content.length() > 200){
				content = content.substring(0,200);
			}
			SNSInfo.setDESC(content);
		}
		String path = NewsDTO.getIMG_PATH();
		if(path != null && !path.equals("")){
			SNSInfo.setIMG(path);
		}
		mv.addObject("SNSInfo", SNSInfo);
		
		
		// 조회수 처리  2017-06-12 세션 추가
		if(req.getSession().getAttribute(NewsDTO.getNM_KEYNO()) == null){
			Component.updateData("News.NM_addHits", NewsDTO);
			req.getSession().setAttribute(NewsDTO.getNM_KEYNO(), 'y');
		}
		String currentPosition = (String) req.getSession().getAttribute("currentPosition"); 
		if( currentPosition != null){
			mv.addObject("currentPosition",currentPosition);
			req.getSession().removeAttribute("currentPosition");
		}
		mv.addObject("pageType", "DetailPage");
		mv.addObject("mirrorPage", "/jcia/information/newsletter.do");
		return mv;
	}
	
	/**
	 * 뉴스레터 수정페이지
	 * @param req
	 * @param commandMap
	 * @param ApplicationDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/jcia/information/newsletter/newsUpdatePage.do")
	@CheckActivityHistory(desc="뉴스레터 수정 페이지 방문")
	public ModelAndView newsUpdatePage(
			  HttpServletRequest req
			, HttpServletResponse res
			, @ModelAttribute NewsDTO NewsDTO
			, @RequestParam(required=false, value="key") String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView();
		
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		if(user == null || key == null){  // 비회원일시
			PrintWriter out = res.getWriter();
			res.setContentType("text/html; charset=UTF-8");
			res.setCharacterEncoding("UTF-8"); 
			out.println("<script language='javascript'>");
			out.println("alert('권한이 없습니다.'); history.go(-1);");
			out.println("</script>");
			out.flush();
			return null;
		}
		
		
		NewsDTO.setNM_KEYNO(CommonService.getKeyno(key, "NM"));
		mv.addObject("resultData", Component.getData("News.NM_SELECT", NewsDTO));
		mv.addObject("mirrorPage", "/jcia/information/newsletter.do");
		mv.addObject("action", "update");
		mv.setViewName("/jcia/news/prc_news_insertView");
	
		return mv;
	}
	
	/**
	 * 뉴스레터 삭제하기
	 * @param req
	 * @param commandMap
	 * @param ApplicationDTO
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/jcia/information/newsletter/newsDelete.do")
	public ModelAndView newsDelete(
			HttpServletRequest req
			, @ModelAttribute NewsDTO NewsDTO
			, @RequestParam(required=true, value="key") String key
			) throws Exception {
		ModelAndView mv  = new ModelAndView();
		NewsDTO.setNM_KEYNO(CommonService.getKeyno(key, "NM"));
		Component.updateData("News.NewsLetterDelete", NewsDTO);
		mv.setViewName("redirect:/jcia/information/newsletter.do");
		
		return mv;
	}
}
