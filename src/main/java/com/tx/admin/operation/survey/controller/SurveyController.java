package com.tx.admin.operation.survey.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.operation.survey.dto.SmDTO;
import com.tx.admin.operation.survey.dto.SqDTO;
import com.tx.admin.operation.survey.dto.SrmDTO;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.page.PageAccess;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class SurveyController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/**
	 * 관리자 설문관리 목록 페이지
	 * @param 
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey.do")
	public ModelAndView SurveyListView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/survey/pra_survey_listView.adm");
		
		return mv;
	}
	
	/**
	 * 관리자 설문관리 목록 페이지 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/survey/pagingAjax.do")
	public ModelAndView SurveyListViewPagingAjax(HttpServletRequest req,
			Common search
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/survey/pra_survey_listView_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"survey.SM_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("survey.SM_getList", map));
		mv.addObject("search", search);
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		return mv;
		
		
	}
	
	
	/**
	 * 관리자 설문관리 목록 페이지 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/survey/excelAjax.do")
	public ModelAndView SurveyListViewExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/survey/pra_survey_listView_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		mv.addObject("resultList", Component.getList("survey.SM_getList", map));
		mv.addObject("search", search);
		
		try {
            
			Cookie cookie = new Cookie("fileDownload", "true");
	        cookie.setPath("/");
	        res.addCookie(cookie);
            
        } catch (Exception e) {
            System.out.println("쿠키 에러 :: "+e.getMessage());
        }
		return mv;
		
	}
	
	
	/**
	 * 관리자 설문관리 등록 페이지
	 * @param 
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/insertView.do")
	public ModelAndView SurveyInsertView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/survey/pra_survey_insertView.adm");
		mv.addObject("mirrorPage","/txap/operation/survey.do");
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		return mv;
	}
	
	/**
	 * 관리자 설문관리 등록
	 * @param SmDTO, SQ_QUESTION[], SQ_ST_TYPE [], SQ_OPTION_DATA []
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/insert.do")
	@Transactional
	public ModelAndView SurveyInsert(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			,@RequestParam(value="SQ_QUESTION",required = false) String SQ_QUESTION []
			,@RequestParam(value="SQ_ST_TYPE",required = false) String SQ_ST_TYPE []
			,@RequestParam(value="SQ_OPTION_DATA",required = false) String SQ_OPTION_DATA []
			) throws Exception{
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/survey.do");
		
		// 설문 관리 등록
		SmDTO.setSM_KEYNO(CommonService.getTableKey("SM"));
		Component.createData("survey.SM_insert", SmDTO);
		
		// 설문 문항 등록
		SqDTO SqDTO = new SqDTO();
		for(int i = 0; i<SQ_QUESTION.length; i++){
			SqDTO.setSQ_KEYNO(CommonService.getTableKey("SQ"));
			SqDTO.setSQ_SM_KEYNO(SmDTO.getSM_KEYNO());
			SqDTO.setSQ_ALIGN(Integer.toString(i+1));
			SqDTO.setSQ_NUM(Integer.toString(i+1));
			SqDTO.setSQ_ST_TYPE(SQ_ST_TYPE[i]);
			SqDTO.setSQ_QUESTION(SQ_QUESTION[i]);
			Component.createData("survey.SQ_insert", SqDTO);
			
			// 설문 옵션 등록
			if(!SQ_ST_TYPE[i].equals("T")){
				String data[] = SQ_OPTION_DATA[i].split("/");
				for(int j = 0; j<data.length; j++){
					String option[] = data[j].split("_");
					SqDTO.setSQO_KEYNO(CommonService.getTableKey("SQO"));
					SqDTO.setSQO_SQ_KEYNO(SqDTO.getSQ_KEYNO());
					SqDTO.setSQO_NUM(Integer.toString(j+1));
					SqDTO.setSQO_OPTION(option[0]);
					if(SmDTO.getSM_CNT_TYPE().equals("S")){
						SqDTO.setSQO_VALUE(option[1]);
					}else if(SmDTO.getSM_CNT_TYPE().equals("H")){
						SqDTO.setSQO_VALUE("1");
					}
					Component.createData("survey.SQO_insert", SqDTO);
				}
			}
		}		
		return mv;
	}
	
	/**
	 * 관리자 설문 상세보기
	 * @param SM_KEYNO
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/detailView.do")
	public ModelAndView SurveyDetailView(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			,@ModelAttribute SqDTO SqDTO
			) throws Exception{
		ModelAndView mv  = new ModelAndView("/txap/operation/survey/pra_survey_detailView.adm");
		
		// 설문지 정보 불러오기
		HashMap<String, Object> SmMap = Component.getData("survey.SM_selectBySmkey", SmDTO.getSM_KEYNO());
		mv.addObject("SmDTO", SmMap);
		
		// 설문지 문항 목록 불러오기
		List<SqDTO> sqList = Component.getList("survey.SQ_getListBySmkey", SmDTO);
		mv.addObject("SQ", sqList);
		
		// 설문지 보기 목록 불러오기
		List<SqDTO> sqoList = Component.getList("survey.SQO_getListBySqkey", SmDTO);
		mv.addObject("SQO", sqoList);
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		mv.addObject("mirrorPage","/txap/operation/survey.do");
		return mv;
	}
	

	/**
	 * 관리자 설문 보기 삭제하기
	 * @param  SQO_KEYNO
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/sm/delete.do")
	public ModelAndView SurveySmDelete(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			) throws Exception{
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/survey.do");
		
		Component.updateData("survey.SM_delete", SmDTO);
		
		return mv;
	}
	
	/**
	 * 관리자 설문 관리 수정
	 * @param SM_KEYNO
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/update.do")
	@Transactional
	public ModelAndView SurveySMUpdate(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			,@ModelAttribute SqDTO SqDTO
			, @RequestParam(value="deleteColumnKeys") String deleteColumnKeys
			, @RequestParam(value="deleteBogiKeys") String deleteBogiKeys
			) throws Exception{
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/survey.do");
		
		//설문 보기 삭제
		if(!deleteBogiKeys.equals("")){ // 키값이 넘어올 경우
			String keys[] = deleteBogiKeys.split(",");
			for (int i = 0; i < keys.length; i++) {
				Component.updateData("survey.SQO_delete", keys[i]);
			}
		}
		
		//설문 문항 삭제
		if(!deleteColumnKeys.equals("")){ // 키값이 넘어올 경우
			String keys[] = deleteColumnKeys.split(",");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keys", keys);
			Component.updateData("survey.SQ_delete", map);
			
			for (int i = 0; i < keys.length; i++) {
				Component.updateData("survey.SQO_delete2", keys[i]);
			}
		}
		
		Component.updateData("survey.SM_update", SmDTO);
		
		return mv;
	}
	
	
	/**
	 * 관리자 설문 관리 수정
	 * @param SM_KEYNO
	 * @return
	 * @throws Exception  
	 *//*
	@RequestMapping(value="/txap/operation/survey/update.do")
	@Transactional
	public ModelAndView SurveySMUpdate(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			, @RequestParam(value="deleteColumnKeys") String deleteColumnKeys
			) throws Exception{
		ModelAndView mv  = new ModelAndView("redirect:/txap/operation/survey.do");
		
		
		//설문 문항 삭제
		if(!deleteColumnKeys.equals("")){ // 키값이 넘어올 경우
			String keys[] = deleteColumnKeys.split(",");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keys", keys);
			Component.updateData("survey.SQ_delete", map);
		}
		
		
		
		Component.updateData( "survey.SM_update", SmDTO);
		
		return mv;
	}
	
*/			
	/**
	 * 관리자 설문 문항, 보기 수정하기
	 * @param  SQ_KEYNO, SQO_KEYNO
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/sq/updataAjax.do")
	@ResponseBody
	@Transactional
	public void SurveySQUpdate(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			,@ModelAttribute SqDTO SqDTO
			,@RequestParam(value="SQ_OPTION_DATA",required = false) String SQ_OPTION_DATA
			) throws Exception{
		
		Component.updateData("survey.SQ_update", SqDTO);
		
		if(!SQ_OPTION_DATA.isEmpty() && !SQ_OPTION_DATA.equals("")){
			String data[] = SQ_OPTION_DATA.split("/");
			for(int i = 0; i<data.length; i++){
				String option[] = data[i].split(":");
				
				SqDTO.setSQO_NUM(Integer.toString(i+1));
				if(option[0].isEmpty() || option[0].equals("undefined")){
					SqDTO.setSQO_SQ_KEYNO(SqDTO.getSQ_KEYNO());
					SqDTO.setSQO_KEYNO(CommonService.getTableKey("SQO"));
					SqDTO.setSQO_OPTION(option[1]);
					SqDTO.setSQO_VALUE(option[2]);
					Component.updateData("survey.SQO_insert", SqDTO);
				}else{
					SqDTO.setSQO_KEYNO(option[0]);
					SqDTO.setSQO_OPTION(option[1]);
					SqDTO.setSQO_VALUE(option[2]);
					Component.updateData("survey.SQO_update", SqDTO);
				}
			}
		}
	}
	
	
	/**
	 * 관리자 설문 보기 삭제하기
	 * @param  SQO_KEYNO
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/sqo/deleteAjax.do")
	@ResponseBody
	@Transactional
	public void SurveySQODelete(HttpServletRequest req
			,@ModelAttribute SqDTO SqDTO
			) throws Exception{
		
		Component.updateData("survey.SQO_delete", SqDTO);
		
	}
	
	/**
	 * 관리자 설문 문항 추가 입력
	 * @param SqDTO
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/sq/insertAjax.do")
	@ResponseBody
	@Transactional
	public void SurveySQAddInsert(HttpServletRequest req
			,@ModelAttribute SqDTO SqDTO
			,@RequestParam(value="SQ_OPTION_DATA",required = false) String SQ_OPTION_DATA
			) throws Exception{
		
		SqDTO.setSQ_KEYNO(CommonService.getTableKey("SQ"));
		Component.updateData("survey.SQ_insert", SqDTO);
		
		if(!SqDTO.getSQ_ST_TYPE().equals("T")){
			String data[] = SQ_OPTION_DATA.split("/");
			for(int i = 0; i<data.length; i++){
				String option[] = data[i].split(":");
				SqDTO.setSQO_NUM(Integer.toString(i+1));
				SqDTO.setSQO_SQ_KEYNO(SqDTO.getSQ_KEYNO());
				SqDTO.setSQO_KEYNO(CommonService.getTableKey("SQO"));
				SqDTO.setSQO_OPTION(option[1]);
				SqDTO.setSQO_VALUE(option[2]);
				Component.updateData("survey.SQO_insert", SqDTO);
			}
		}
	}
	
	
	/**
	 * 관리자 설문결과 상세 페이지
	 * @param 
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/result/detailView.do")
	public ModelAndView SurveyResultDetailView(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			,@ModelAttribute SqDTO SqDTO
			,@ModelAttribute SrmDTO SrmDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/survey/result/pra_survey_result_detailView.adm");
		
		// 설문지 정보 불러오기
		HashMap<String, Object> SmMap = Component.getData("survey.SM_selectBySmkey", SmDTO.getSM_KEYNO());
		mv.addObject("SmDTO", SmMap);
		
		// 설문지 문항 목록 불러오기
		List<HashMap<String, Object>> sqList = Component.getList("survey.SQ_getListBySmkey", SmDTO);
		mv.addObject("sq_list", sqList);
		
		// 객관식 설문 보기,결과
		List<SqDTO> srmList_op = Component.getList("surveyRe.SRD_selectResultBySmkey_op", SmDTO);
		mv.addObject("srmList_op", srmList_op);
		
		// 주관식 설문 결과
		List<SrmDTO> srmList_an = Component.getList("surveyRe.SRD_selectResultBySmkey_an", SmDTO);
		mv.addObject("srmList_an", srmList_an);
		
		mv.addObject("mirrorPage","/txap/operation/survey.do");
		return mv;
	}
	
	
	/**
	 * 관리자 설문결과 상세 페이지 - 페이징 ajax
	 * @param req
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/survey/result/detailView/pagingAjax.do")
	public ModelAndView SurveyResultDetailViewPagingAjax(HttpServletRequest req,
			Common search
			, @RequestParam String SM_KEYNO
			, @RequestParam String SM_IDYN
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/operation/survey/result/pra_survey_result_detailView_data");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("SM_KEYNO", SM_KEYNO);
		map.put("SM_IDYN", SM_IDYN);
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"surveyRe.SRM_getListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		mv.addObject("resultList", Component.getList("surveyRe.SRM_getList", map));
		mv.addObject("search", search);
		mv.addObject("SM_IDYN", SM_IDYN);
		return mv;
		
		
	}
	
	
	/**
	 * 관리자 설문결과 상세 페이지 - excel ajax
	 * @param req
	 * @param res
	 * @param search
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/operation/survey/result/detailView/excelAjax.do")
	public ModelAndView SurveyResultDetailViewExcelAjax(HttpServletRequest req
			, HttpServletResponse res
			, Common search
			, @RequestParam String SM_KEYNO
			, @RequestParam String SM_IDYN
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/survey/result/pra_survey_result_detailView_excel");
		
		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		map.put("SM_KEYNO", SM_KEYNO);
		map.put("SM_IDYN", SM_IDYN);
		
		mv.addObject("resultList", Component.getList("surveyRe.SRM_getList", map));
		mv.addObject("search", search);
		mv.addObject("SM_IDYN", SM_IDYN);
		
		try {
            
			Cookie cookie = new Cookie("fileDownload", "true");
	        cookie.setPath("/");
	        res.addCookie(cookie);
            
        } catch (Exception e) {
            System.out.println("쿠키 에러 :: "+e.getMessage());
        }
		return mv;
		
	}
	
	/**
	 * 관리자 설문결과 엑셀 다운
	 * @param 
	 * @return
	 * @throws Exception  
	 */
	@RequestMapping(value="/txap/operation/survey/result/detailExcel.do")
	public ModelAndView SurveyResultDetailExcel(HttpServletRequest req
			,@ModelAttribute SmDTO SmDTO
			,@ModelAttribute SqDTO SqDTO
			,@ModelAttribute SrmDTO SrmDTO
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/survey/pra_survey_result_excel");
		
		// 설문지 정보 불러오기
		HashMap<String, Object> SmMap = Component.getData("survey.SM_selectBySmkey", SmDTO.getSM_KEYNO());
		mv.addObject("SmDTO", SmMap);
		
		// 설문지 문항 목록 불러오기
		List<HashMap<String, Object>> sqList = Component.getList("survey.SQ_getListBySmkey", SmDTO);
		// 설문 리스트
		List<HashMap<String, Object>> srm_List = Component.getList("surveyRe.SRM_selectBySmkey", SmDTO);
		
		mv.addObject("sq_list", sqList);
		
		List<HashMap<String, Object>> srmList = new ArrayList<HashMap<String, Object>>();

		StringBuilder bulder = new StringBuilder();
		
		// 응답자 리스트
		if(srm_List != null && srm_List.size()>0){
			for(int i=0; i< srm_List.size();  i++){
				SrmDTO.setSRM_SM_KEYNO((String)srm_List.get(i).get("SRM_SM_KEYNO"));
				SrmDTO.setSRM_KEYNO((String)srm_List.get(i).get("SRM_KEYNO"));
				srmList = Component.getList("surveyRe.GET_RESULTDATA", SrmDTO);
				bulder.append("<tr class='dataTr'><td>"+(String)srm_List.get(i).get("SRM_IP")+"</td>"); 
				bulder.append("<td>"+srm_List.get(i).get("SRM_REGDT").toString().substring(0, 19)+"</td>"); 
				if(srmList != null && srmList.size()>0){
					for (int j = 0; j < srmList.size(); j++) {
						bulder.append("<td>"+(String)srmList.get(j).get("RESULTDATA")+"</td>"); 
					}
				}
				bulder.append("</tr>");
			}
		}
		bulder.toString();
		
		mv.addObject("title", SmMap.get("SM_TITLE"));
		mv.addObject("resultData", bulder.toString());
		return mv;
	}
	
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/txap/operation/survey/result/dataAjax.do")
	@ResponseBody
	public List SurveyResultDataAjax(HttpServletRequest req
			,@ModelAttribute SrmDTO SrmDTO
			) throws Exception{
		
		
		return Component.getList("surveyRe.SRD_getList22", SrmDTO);
		
	}
	
	

}
