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
 * @Project : demo
 * @Date    : 2017. 02. 06. 
 * @Author  : 이재령	
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
		
		ModelAndView mv  = new ModelAndView("/txap/pra_main.adm");
		List<UserDTO> memberlist = Component.getListNoParam("member.UI_selectAdminMain");
		for(UserDTO user : memberlist){
			user.decode();
		}
		
		Cookie[] cookies = req.getCookies();
		String cookie_check = "0";
		
		for(Cookie cookie: cookies) {
			if("main".equals(cookie.getName())) {
				cookie_check = "1";
			}
		}
		if(cookie_check.equals("0")) {
			Cookie c1 = new Cookie("main", URLEncoder.encode("1,2,3,4,5"));
			c1.setMaxAge(60*60*24);
			c1.setPath("/");
			res.addCookie(c1);
		}
		
		mv.addObject("memberlist",memberlist);
		mv.addObject("boardlist",Component.getListNoParam("BoardNotice.BN_getListAdminMain"));
		
		mv.addObject("resultList",Component.getListNoParam("Satisfaction.Pr_TPS_getList"));
		mv.addObject("resultListcnt",Component.getData("Satisfaction.TPS_getListCnt"));
		
		mv.addObject("keywordList",Component.getListNoParam("keyword.Pr_SK_getDataList"));
		mv.addObject("keywordListcnt",Component.getData("keyword.SK_getDataListCnt"));
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
	
//	통계부분 관리자 페이지를 위한 ajax처리 
	@ResponseBody
	@RequestMapping("/txap/main/pr_pagingAjax.do")
	public Object pr_ajaxsearchV(
			HttpServletRequest req
			, LogDTO log
			) throws Exception {
		
//		log.setHOME_DIV("0");
		List<LogDTO> list = Component.getList("Log.Pr_AH_selectPageCount", log);
		
		int total = 0;
		if(list !=null && list.size()>0){
			
			for(int i=0; i<list.size(); i++){
				total += list.get(i).getCOUNT();
			}
			
			for(int i=0; i<list.size(); i++){ //평균
				list.get(i).setNo(i+1);
				float a = list.get(i).getCOUNT() / (float)total * 100;
				a *= 100;
				int ii =   (int) a;
				a = (float) (ii* 0.01);
				list.get(i).setPersent(a);
			}
		}
		
		StringBuilder bulder = new StringBuilder();
		
		log = null;
		int totalCnt = 0;
		float totalPercent = 0;
		 if(list.size()>0){
			 for(int i=0; i< list.size();  i++){
				 log = list.get(i);
				 bulder.append("<tr><td>")
				 		.append(log.getNo())
				 		.append("</td><td>")
				 		.append(log.getMN_HOMEDIV_NAME())
				 		.append("</td>")
				 		.append("<td>" + log.getMN_NAME()) 
				 		.append("</td><td><div class='visitor_bar chart'><span class='bar' data-number='")
				 		.append(log.getPersent())
				 		.append("'></span></div>")
				 		.append("</td><td>")
				 		.append(log.getCOUNT())
				 		.append("</td><td>")
				 		.append(log.getPersent())
				 		.append("</td></tr>");
				 totalCnt += log.getCOUNT();
				 totalPercent += log.getPersent();
			 } 
		 }
		 bulder.append("<tr class='footTr'><td colspan='4' class='footTd'>")
			.append("총합</td><td>")
		 	.append(totalCnt)
	 		.append("<td>")
	 		.append(Math.round(totalPercent*100)/100.0)
	 		.append("</td></tr>");
		
		return bulder.toString();
	}
}
