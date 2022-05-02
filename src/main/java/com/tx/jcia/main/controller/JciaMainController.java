package com.tx.jcia.main.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.board.dto.BoardNotice;
import com.tx.common.component.ComponentService;

/**
 * 
 * @FileName: MainController.java
 * @Project : cf
 * @Date : 2018. 05. 25.
 * @Author : 이혜주
 * @Version : 1.0
 */
@Controller
public class JciaMainController {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;

	@RequestMapping(value = "/jcia/index.do")
	public ModelAndView main(HttpServletRequest req
			, Map<String, Object> commandMap
			, @RequestParam(value = "msg", defaultValue = "") String msg
			, @ModelAttribute BoardNotice BoardNotice
			) throws Exception {
		ModelAndView mv = new ModelAndView("/jcia/main/prc_main");
		
		mv.addObject("msg", URLDecoder.decode(msg, "UTF-8")); // 현재 회원인증후 메세지
		return mv;
	}
	
	/** 배너 이미지  */
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "/jcia/bannerAjax.do")
	public List bannerAjax(
			HttpServletRequest req
			) throws Exception {
		List<HashMap<String, Object>> BannerList = new ArrayList<>();
		BannerList = Component.getListNoParam("MainBanner.BM_getList");
		
		return BannerList;
	}
	
	/**
	 * 사이트맵
	 * */
	@RequestMapping(value = "/jcia/sitemap.do")
	public ModelAndView Sitemap() throws Exception {
		ModelAndView mv = new ModelAndView("/jcia/main/sitemap");
		return mv;
	}
	
	@RequestMapping(value = "/jcia/test/testPage.do")
	public ModelAndView main() throws Exception {
		ModelAndView mv = new ModelAndView("/jcia/temp/temp");
		
		return mv;
	}
	
}
