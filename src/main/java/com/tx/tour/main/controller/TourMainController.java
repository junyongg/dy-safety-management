package com.tx.tour.main.controller;

import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.operation.slide.dto.SlideDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;

/**
 * 
 * @FileName: TourMainController.java
 * @Project : tour
 * @Date : 2019. 02. 28.
 * @Author : 이재령
 * @Version : 1.0
 */
@Controller
public class TourMainController {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;

	@RequestMapping(value = "/tour/index.do")
	@CheckActivityHistory(desc="웹 메인 페이지 방문")
	public ModelAndView main(HttpServletRequest req
			, Map<String, Object> commandMap
			, @ModelAttribute SlideDTO SlideDTO
			, @RequestParam(value = "msg", defaultValue = "") String msg) throws Exception {
		ModelAndView mv = new ModelAndView("/tour/main/prc_main");
		SlideDTO.setMM_MN_KEYNO(SettingData.HOMEDIV_TOUR);
		
		SlideDTO.setMM_LOCATION("H");
		mv.addObject("HighSlide", Component.getList("Slide.get_slideList", SlideDTO));
		SlideDTO.setMM_LOCATION("L");
		mv.addObject("LowSlide", Component.getList("Slide.get_slideList", SlideDTO));
		mv.addObject("msg", URLDecoder.decode(msg, "UTF-8")); // 현재 회원인증후 메세지
	

		return mv;
	}

	
}
