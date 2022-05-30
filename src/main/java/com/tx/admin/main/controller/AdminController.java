package com.tx.admin.main.controller;

import java.net.URI;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.member.dto.UserDTO;
import com.tx.admin.statistics.dto.LogDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

/**
 * 
 * @FileName: AdminController.java
 * @Version : 1.0
 */
@Controller
public class AdminController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	
	@RequestMapping(value="/txap/index.do")
	@CheckActivityHistory(desc="관리자 메인 페이지 방문")
	public ModelAndView userForm(HttpServletRequest req, Map<String,Object> commandMap,UserDTO UserDTO,LogDTO log
			,HttpServletResponse res
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("redirect:/txap/homepage/menu.do");

		return mv;
	}
	
	/**
	 * 에러 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/error.do")
	@CheckActivityHistory(desc="에러  페이지 방문")
	public ModelAndView error(HttpServletRequest req) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/error/error");
		
		try {
			String refererURI = new URI(req.getHeader("referer")).getPath();
			System.out.println("에러 ::/error.do:: referer :: " + refererURI);
			String tiles[] = refererURI.split("/");
			mv.addObject("tiles", tiles[1]);
		}catch(Exception e){
			System.out.println("에러 ::/error.do:: " + e.getMessage()+" :: " + CommonService.getClientIP(req));
		}
		return mv;
	}
	
}
