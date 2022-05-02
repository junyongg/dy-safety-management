package com.tx.tour.function.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

/**
 * 
 * @FileName: TourFunctionController.java
 * @Project : tour
 * @Date    : 2019. 02. 28. 
 * @Author  : 이재령	
 * @Version : 1.0
 */
@Controller
public class TourFunctionController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	
	/**
	 * 사이트맵
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/tour/use/sitemap.do")
	@CheckActivityHistory(desc="사이트맵 방문")
	public ModelAndView cfUseSitemap() throws Exception {
		ModelAndView mv  = new ModelAndView("/tour/use/prc_sitemap");
		
		Menu menu = new Menu(SettingData.HOMEDIV_TOUR); 
		mv.addObject("sitemap", Component.getList("Menu.AMN_getUserMenuListByHOMEDIV", menu));
		
		return mv;
	}
	
		
	
}
