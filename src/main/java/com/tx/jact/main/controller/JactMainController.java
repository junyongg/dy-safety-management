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
			, Map<String, Object> commandMap
			, @RequestParam(value = "msg", defaultValue = "") String msg
			, @ModelAttribute BoardNotice BoardNotice
			, SlideDTO slideDto
			) throws Exception {
		ModelAndView mv = new ModelAndView("/jact/main/prc_main");
		//메인 슬라이드 가져오기
		slideDto.setMM_MN_KEYNO(SettingData.HOMEDIV_JACT);
		slideDto.setMM_LOCATION("H");
		String BM_MN_KEYNO = SettingData.HOMEDIV_JACT;
		mv.addObject("slide", Component.getList("Slide.get_slideList",slideDto));
		mv.addObject("banner", Component.getList("Banner.BM_selectmain",BM_MN_KEYNO));
		mv.addObject("movie", Component.getList("MainMovie.MM_selectmain",BM_MN_KEYNO));
		
		
		mv.addObject("msg", URLDecoder.decode(msg, "UTF-8")); // 현재 회원인증후 메세지
		return mv;
	}
	
	@RequestMapping(value = "/culture/index.do")
	public ModelAndView culture_main(HttpServletRequest req
			, Map<String, Object> commandMap
			, @RequestParam(value = "msg", defaultValue = "") String msg
			, @ModelAttribute BoardNotice BoardNotice
			, SlideDTO slideDto
			) throws Exception {
		ModelAndView mv = new ModelAndView("/culture/main/prc_main");
		//메인 슬라이드 가져오기
		slideDto.setMM_MN_KEYNO(SettingData.HOMEDIV_CULTURE);
		slideDto.setMM_LOCATION("H");
		String BM_MN_KEYNO = SettingData.HOMEDIV_CULTURE;
		mv.addObject("slide", Component.getList("Slide.get_slideList",slideDto));
		mv.addObject("banner", Component.getList("Banner.BM_selectmain",BM_MN_KEYNO));
		
		mv.addObject("msg", URLDecoder.decode(msg, "UTF-8")); // 현재 회원인증후 메세지
		return mv;
	}
	
	
	@RequestMapping(value = "/common/popup.do")
	public ModelAndView popup(HttpServletRequest req
			) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/operation/popup/popup_view_ex");
		return mv;
	}
	
}
