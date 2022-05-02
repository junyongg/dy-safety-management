package com.tx.admin.tour.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.tour.dto.TourDTO;


/**
 * TourService
 * @author 이재령
 * @version 1.0
 * @since 2019-02-21
 */
public interface TourService {

	
	/**
	 * 관광정보 등록
	 * @param req
	 * @param tour
	 * @param REGNM
	 * @throws Exception
	 */
	public void insertTourInfo(HttpServletRequest req, TourDTO tour, String REGNM) throws Exception;
	
	/**
	 * 관광정보 수정
	 * @param req
	 * @param tour
	 * @param REGNM
	 * @throws Exception
	 */
	public void updateTourInfo(HttpServletRequest req, TourDTO tour, String REGNM, String TIM_FM_KEYNO) throws Exception;

	/**
	 * 관광정보 폼 데이터 가져오기
	 * @param mv 
	 * @param categoryName
	 * @param tour
	 * @return
	 * @throws Exception
	 */
	public String getTourInfoFormData(ModelAndView mv, String categoryName, TourDTO tour) throws Exception;
	
	/**
	 * 관광정보 페이징 데이터 가져오기
	 * @param mv
	 * @param tourInfo
	 * @param isPaging
	 * @return
	 * @throws Exception
	 */
	public String getTourInfoPagingData(ModelAndView mv, String tourInfo, boolean isPaging) throws Exception;

	
    	
} 
