package com.tx.cf.function.controller;


import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.operation.survey.dto.SmDTO;
import com.tx.admin.operation.survey.dto.SqDTO;
import com.tx.admin.operation.survey.dto.SrmDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

@Controller
public class SurveyUserController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/**
	 * 유저 설문 목록 페이지
	 * @param SM_KEYNO
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/cf/function/servey.do")
	@CheckActivityHistory(desc="유저 설문 목록 페이지 방문")
	public ModelAndView userSurveyListView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/function/prc_survey_listView");
		
		mv.addObject("SmDTOList", Component.getListNoParam("survey.SM_selectUser"));
		return mv;
	}
	
	/**
	 * 유저 설문 상세 페이지
	 * @param SM_KEYNO
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/cf/function/servey/detailView.do")
	@CheckActivityHistory(desc="유저 설문 상세 페이지 방문")
	public ModelAndView userSurveyDetailView(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			,@ModelAttribute SqDTO SqDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/function/prc_survey_detailView");
		
		// 설문지 정보 불러오기
		HashMap<String, Object> SmMap = Component.getData("survey.SM_selectBySmkey", SmDTO.getSM_KEYNO());
		mv.addObject("SmDTO", SmMap);
		
		// 설문지 문항 목록 불러오기
		List<SqDTO> sqList = Component.getList("survey.SQ_getListBySmkey", SmDTO);
		mv.addObject("sq_list", sqList);
		
		// 설문지 보기 목록 불러오기
		List<SqDTO> sqoList = Component.getList("survey.SQO_getListBySqkey", SmDTO);
		mv.addObject("sqo_list", sqoList);
		mv.addObject("mirrorPage", "/cf/function/servey.do");
		return mv;
	}
	
	/**
	 * 유저 설문결과 입력
	 * @param SqDTO
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/cf/function/servey/insert.do")
	@CheckActivityHistory(desc="유저 설문결과 등록 작업")
	public ModelAndView userSurveyResultInsert(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			,@ModelAttribute SrmDTO SrmDTO
			,@RequestParam (value="SQ_KEYNO", required=false)	  String [] SQ_KEYNO
			,@RequestParam (value="SQ_ST_TYPE", required=false)	  String [] SQ_ST_TYPE
			,@RequestParam (value="SQ_OPTION_DATA", required=false)	  String [] SQ_OPTION_DATA
			) throws Exception {
		ModelAndView mv  = new ModelAndView("redirect:/cf/function/servey.do");
		
				SrmDTO.setSRM_KEYNO(CommonService.getTableKey("SRM"));
				SrmDTO.setSRM_SM_KEYNO(SmDTO.getSM_KEYNO());
				if(SmDTO.getSM_IDYN().equals("Y")){
					@SuppressWarnings({ "unchecked", "rawtypes" })
					Map user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
					if(user != null){
						SrmDTO.setSRM_REGNM((String)user.get("UI_KEYNO"));
					}
				}
				
				SrmDTO.setSRM_IP(CommonService.getClientIP(req));
				
				Component.updateData("surveyRe.SRM_insert", SrmDTO);
				Component.updateData("survey.SM_countPenel", SmDTO);
				
				for(int i=0; i<SQ_KEYNO.length;  i++){
					SrmDTO.setSRD_KEYNO(CommonService.getTableKey("SRD"));
					SrmDTO.setSRD_SM_KEYNO(SmDTO.getSM_KEYNO());
					SrmDTO.setSRD_SRM_KEYNO(SrmDTO.getSRM_KEYNO());
					SrmDTO.setSRD_SQ_KEYNO(SQ_KEYNO[i]);
					
					if(SQ_ST_TYPE[i].equals("T")){
						SrmDTO.setSRD_DATA(SQ_OPTION_DATA[i]);
					}else if(SQ_ST_TYPE[i].equals("C")){
						String[] data = SQ_OPTION_DATA[i].split(",");
						String[] Key = new String[data.length];
						String[] Val = new String[data.length];
						for (int j = 0; j < data.length; j++) {
							String[] Sub_data = data[j].split(":");
							Key[j] = Sub_data[0];
							Val[j] = Sub_data[1];
						}
						SrmDTO.setSRD_SQO_KEYNO(Arrays.toString(Key).replaceAll("[\\[\\]]", "").replaceAll(",", "|"));
						SrmDTO.setSRD_SQO_VALUE(Arrays.toString(Val).replaceAll("[\\[\\]]", "").replaceAll(",", "|"));
					}else if(SQ_ST_TYPE[i].equals("R")){
						String[] data = SQ_OPTION_DATA[i].split(":");
						SrmDTO.setSRD_SQO_KEYNO(data[0]);
						SrmDTO.setSRD_SQO_VALUE(data[1]);
					}
					Component.updateData("surveyRe.SRD_insert", SrmDTO);
					SrmDTO.setSRD_DATA(null);
					SrmDTO.setSRD_SQO_KEYNO(null);
					SrmDTO.setSRD_SQO_VALUE(null);
			}
		
		return mv;
	}	
	

}
