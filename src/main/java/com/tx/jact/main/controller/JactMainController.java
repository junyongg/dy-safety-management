package com.tx.jact.main.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.board.dto.BoardNotice;
import com.tx.admin.operation.slide.dto.SlideDTO;
import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;

@Controller
public class JactMainController {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;
	@RequestMapping(value = "/jact/intro.do")
	public ModelAndView intro(HttpServletRequest req) throws Exception{
		ModelAndView mv = new ModelAndView("/jact/main/prc_intro.notiles");
		
		return mv;	
	}
			
	@RequestMapping(value = "/jact/index.do")
	public ModelAndView main(HttpServletRequest req
			) throws Exception {
		ModelAndView mv = new ModelAndView("/publish/jact/prc_main");
		return mv;
	}
	
	
	@RequestMapping(value = "/common/popup.do")
	public ModelAndView popup(HttpServletRequest req
			) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/operation/popup/popup_view_ex");
		return mv;
	}
	
}
