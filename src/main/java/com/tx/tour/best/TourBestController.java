package com.tx.tour.best;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

/**
 * 
 * @FileName: TourBestController.java
 * @Project : tour
 * @Date    : 2019. 03. 14. 
 * @Author  : 이혜주	
 * @Version : 1.0
 */
@Controller
public class TourBestController {

	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/**
	 * 관광명소 소개페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/tour/sights/best/index.do")
	@CheckActivityHistory(desc="관광명소 소개페이지 방문")
	public ModelAndView tourBest() throws Exception {
		ModelAndView mv  = new ModelAndView("/tour/tour/index/prc_tour_best");
		
		return mv;
	}
	
}
