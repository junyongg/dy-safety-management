package com.tx.map.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.file.dto.FileSub;
import com.tx.common.page.PageAccess;
import com.tx.common.security.aes.AES256Cipher;
import com.tx.map.dto.MapDTO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import javaxt.utils.Array;

import com.tx.common.component.CommonService;
@Controller
public class MapController {
	
	@Autowired
	ComponentService Component;
	
	@Autowired CommonService CommonService;
	
	@Autowired private PageAccess PageAccess;
	
	@RequestMapping(value="/map/prc_MapMain.do")
	public ModelAndView MapMain(
			@RequestParam(value="area",defaultValue="0")String area
			) {
		ModelAndView mv = new ModelAndView("/map/prc_MapMain.map");
		
		return mv;
	}
	
	@RequestMapping(value="/map/prc_map.do")
	public ModelAndView testMap(
			@RequestParam(value="area",defaultValue="all")String area
			,@RequestParam(value="type",defaultValue="all")String type
			) {
		ModelAndView mv = new ModelAndView("/map/prc_map.map");
		String url = "all"	;
		if(area.equals("영광")) {url="younGwang";}
		else if(area.equals("장성")) {url="jangsung";}
		else if(area.equals("담양")) {url="damyang";}
		else if(area.equals("곡성")) {url="gucksung";}
		else if(area.equals("구례")) {url="gure";}
		else if(area.equals("광양")) {url="gangyong";}
		else if(area.equals("여수")) {url="yeosu";}
		else if(area.equals("순천")) {url="sunchun";}
		else if(area.equals("고흥")) {url="goheong";}
		else if(area.equals("보성")) {url="bosung";}
		else if(area.equals("화순")) {url="hwasun";}
		else if(area.equals("나주")) {url="naju";}
		else if(area.equals("장흥")) {url="jangheong";}
		else if(area.equals("영광")) {url="youngam";}
		else if(area.equals("광진")) {url="gangjin";}
		else if(area.equals("해남")) {url="henam";}
		else if(area.equals("진도")) {url="jindo";}
		else if(area.equals("완도")) {url="yundo";}
		else if(area.equals("신안")) {url="sinan";}
		else if(area.equals("목포")) {url="mokpo";}
		else if(area.equals("무안")) {url="muan";}
		else if(area.equals("함평")) {url="hampung";}
		else {
			url = "all"	;
		}
		
		MapDTO map = new MapDTO();
		
		map.setMMA_AREA(area);
		map.setMMS_TYPE(type);
		
		mv.addObject("marker",Component.getList("mapSub.MarkData",map));
		
		mv.addObject("url",url+".geojson");
		mv.addObject("area",area);
		mv.addObject("type",type);
		return mv;
	}
	
	@RequestMapping(value="/MarkerInsert.do")
	public ModelAndView MarkerInsert(
			@RequestParam(value="area",defaultValue="0")String area
			) {
		ModelAndView mv = new ModelAndView("/map/prc_map_insertTest.map");
		String url = "all"	;
		if(area.equals("영광")) {url="younGwang";}
		else if(area.equals("장성")) {url="jangsung";}
		else if(area.equals("담양")) {url="damyang";}
		else if(area.equals("곡성")) {url="gucksung";}
		else if(area.equals("구례")) {url="gure";}
		else if(area.equals("광양")) {url="gangyong";}
		else if(area.equals("여수")) {url="yeosu";}
		else if(area.equals("순천")) {url="sunchun";}
		else if(area.equals("고흥")) {url="goheong";}
		else if(area.equals("보성")) {url="bosung";}
		else if(area.equals("화순")) {url="hwasun";}
		else if(area.equals("나주")) {url="naju";}
		else if(area.equals("장흥")) {url="jangheong";}
		else if(area.equals("영광")) {url="youngam";}
		else if(area.equals("광진")) {url="gangjin";}
		else if(area.equals("해남")) {url="henam";}
		else if(area.equals("진도")) {url="jindo";}
		else if(area.equals("완도")) {url="yundo";}
		else if(area.equals("신안")) {url="sinan";}
		else if(area.equals("목포")) {url="mokpo";}
		else if(area.equals("무안")) {url="muan";}
		else if(area.equals("함평")) {url="hampung";}
		else {
			url = "all"	;
		}
		
		mv.addObject("marker",Component.getListNoParam("map.MarkData"));
		
		mv.addObject("url",url+".geojson");
		mv.addObject("area",area);
		
		return mv;
	} 
	
	@RequestMapping(value="/insertMarkerAjax.do")
	@ResponseBody
	public void insertMarkerAjax(
			@RequestParam(value="area",defaultValue="0")String area,
			@RequestParam(value="xLocation",defaultValue="")String xLocation,
			@RequestParam(value="yLocation",defaultValue="")String yLocation,
			@RequestParam(value="text",required=false)String text,
			@RequestParam(value="img",required=false)String img
			) {
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("xLocation", xLocation);
		map.put("yLocation", yLocation);
		map.put("mapText", text);
		map.put("mapImg", img);
		map.put("mapType", area);
		
		Component.createData("map.MarkerInsert", map);
	}
	
	@RequestMapping(value="/detailAjax.do")
	@ResponseBody
	public ModelAndView detailAjax(
			HttpServletRequest req
			,@RequestParam(value="xlocation")String x
			,@RequestParam(value="ylocation")String y
			,@RequestParam(value="type")String t
			,@RequestParam(value="number",defaultValue="1")String number
			)throws Exception {
		ModelAndView mv = new ModelAndView("/map/ajax/prc_map_detailAjax.notiles");
		
		String domain = CommonService.checkUrl(req);
		
		MapDTO map = new MapDTO();
		map.setMMA_X_LOCATION(x);
		map.setMMA_Y_LOCATION(y);

		map.setMMS_TYPE("기타");
		mv.addObject("Cnt1" ,Component.getCount("map.MMA_Pra_getDataCnt",map));
		map.setMMS_TYPE("벽화");
		mv.addObject("Cnt2" ,Component.getCount("map.MMA_Pra_getDataCnt",map));
		map.setMMS_TYPE("설치");
		mv.addObject("Cnt3" ,Component.getCount("map.MMA_Pra_getDataCnt",map));
		
		//상세페이지 구분하기 위한 처음 처리  
		if("all".equals(t)) {
			t = "벽화";
		}
		map.setMMS_TYPE(t);
		map.setNumber(number);
		
		MapDTO MapData = Component.getData("map.MMA_Pra_getData",map);
		//전체 갯수
		int Allnum = Component.getCount("map.MMA_Pra_getDataCnt",map);
		
		
		mv.addObject("domain",domain);
		mv.addObject("xlocation",x);
		mv.addObject("ylocation",y);
		mv.addObject("resultData",MapData);
		mv.addObject("Numbering",number);
		mv.addObject("Allnum",Allnum);
		mv.addObject("type",t);
		
		return mv;
	}
	/**
	 * 
	 * @param 1번 상세페이지에서 내용 변경
	 * @param 
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/SubdetailAjax.do")
	@ResponseBody
	public ModelAndView SubdetailAjax(
			@RequestParam(value="xlocation") String x
			,@RequestParam(value="ylocation") String y
			,@RequestParam(value="type",required=false) String t
			,@RequestParam(value="number",defaultValue="1")String number
			) {
		ModelAndView mv = new ModelAndView("/map/ajax/SubdetailAjax.notiles");
		
		MapDTO map = new MapDTO();
		map.setMMA_X_LOCATION(x);
		map.setMMA_Y_LOCATION(y);
		map.setMMS_TYPE(t);
		map.setNumber(number);
		
		//전체 갯수
		int Allnum = Component.getCount("map.MMA_Pra_getDataCnt",map);
		mv.addObject("Allnum",Allnum);
		
		MapDTO MapData = Component.getData("map.MMA_Pra_getData",map);
		
		if(MapData != null) {
			List<FileSub> fileList = Component.getList("File.AFS_FileSelectPutMainkey", MapData.getMMS_FM_KEYNO());
			mv.addObject("SubFileSubList",fileList);
			String link =  MapData.getMMA_LINK().substring(MapData.getMMA_LINK().indexOf("?v=")+3,MapData.getMMA_LINK().length());
			mv.addObject("youtubeLink",link);
		}
		  
		mv.addObject("SubresultData",MapData);
		mv.addObject("type",t);
		
		return mv;
	}
	
	@RequestMapping(value="/detailAjax2.do")
	@ResponseBody
	public ModelAndView detailAjax2(
			@RequestParam(value="key")String key
			,@RequestParam(value="number",defaultValue="1")String number
			,HttpServletRequest req
			) throws Exception {
		ModelAndView mv = new ModelAndView("/map/ajax/prc_map_detailAjax2.notiles");
		
		String domain = CommonService.checkUrl(req);
		mv.addObject("domain",domain);
		
		MapDTO map = new MapDTO();
		map.setMMS_KEYNO(key);
		
		map = Component.getData("mapSub.MMS_Pra_getData",map);
		
		//전체 갯수
		int Allnum = Component.getCount("map.MMA_Pra_getDataCnt",map);
		mv.addObject("Allnum",Allnum);
		
		MapDTO map2 = new MapDTO();
		map2.setMMA_X_LOCATION(map.getMMA_X_LOCATION());
		map2.setMMA_Y_LOCATION(map.getMMA_Y_LOCATION());
		
		map2.setMMS_TYPE("기타");
		mv.addObject("Cnt1" ,Component.getCount("map.MMA_Pra_getDataCnt",map2));
		map2.setMMS_TYPE("벽화");
		mv.addObject("Cnt2" ,Component.getCount("map.MMA_Pra_getDataCnt",map2));
		map2.setMMS_TYPE("설치");
		mv.addObject("Cnt3" ,Component.getCount("map.MMA_Pra_getDataCnt",map2));
		
		
		mv.addObject("resultData",map);
		mv.addObject("type",map.getMMS_TYPE());
		
		return mv;
	}
	
	
	/**
	 * 
	 * @param 1번 상세페이지에서 내용 변경
	 * @param 
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/SubdetailAjax2.do")
	@ResponseBody
	public ModelAndView SubdetailAjax2(
			@RequestParam(value="xlocation") String x
			,@RequestParam(value="ylocation") String y
			,@RequestParam(value="type",required=false) String t
			,@RequestParam(value="number",defaultValue="1")String number
			) {
		ModelAndView mv = new ModelAndView("/map/ajax/SubdetailAjax2.notiles");
		
		MapDTO map = new MapDTO();
		map.setMMA_X_LOCATION(x);
		map.setMMA_Y_LOCATION(y);
		map.setMMS_TYPE(t);
		map.setNumber(number);
		
		//전체 갯수
		int Allnum = Component.getCount("map.MMA_Pra_getDataCnt",map);
		mv.addObject("Allnum",Allnum);
		
		MapDTO MapData = Component.getData("map.MMA_Pra_getData",map);
		
		if(MapData != null) {
			List<FileSub> fileList = Component.getList("File.AFS_FileSelectPutMainkey", MapData.getMMS_FM_KEYNO());
			mv.addObject("SubFileSubList",fileList);
		}
		
		mv.addObject("SubresultData",MapData);
		mv.addObject("type",t);
		
		return mv;
	}
	
	//---------------------------------관리자 페이지 -------------------------------------------------
	
	@RequestMapping(value = "/txap/map/map.do")
	public ModelAndView mapAdmin(
			HttpServletRequest req
			, @RequestParam(value="key", required=false) String key
			) throws Exception{
		ModelAndView mv = new ModelAndView("/txap/map/pra_map.adm");

		String number = "";
		
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(req);
        if(null != inputFlashMap) {
            key = (String) inputFlashMap.get("key");
            number = (String) inputFlashMap.get("pageIndex");
        }
		
        mv.addObject("key", key);
        
		return mv;
	}
	
	@RequestMapping(value = "/txap/map/pagingAjax.do")
	public ModelAndView mapAjax(
			HttpServletRequest req
			, Common search
			) throws Exception{
		ModelAndView mv = new ModelAndView("/txap/map/pra_map_list");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"map.MMA_getDataListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		
		List<HashMap<String,Object>> resultList = Component.getList("map.MMA_getDataList", map); 
		mv.addObject("resultList", resultList);
		mv.addObject("search", search);
		
		return mv;
	}
	
	
	@RequestMapping(value = "/txap/map/dataAjax.do")
	@ResponseBody
	public ModelAndView StoreDataAjax(
			HttpServletRequest req
			, @RequestParam(value="key", required=false) String key
			) throws Exception{
		ModelAndView mv = new ModelAndView("/txap/map/pra_map_actionView");
		
		String action = "";
		
		MapDTO map = new MapDTO();
		map.setMMA_KEYNO(key);
		
		if(StringUtils.isNotEmpty(key)){
			HashMap<String,Object> resultData = Component.getData("map.MMA_Pra_getData2", map);
			mv.addObject("resultData", resultData);
			
			if(resultData != null) {
				if(resultData.containsKey("MMA_FM_KEYNO") && !resultData.get("MMA_FM_KEYNO").toString().equals("")){
					List<FileSub> imgList = new ArrayList<>();
					imgList = Component.getList("File.AFS_FileSelectPutMainkey",resultData.get("MMA_FM_KEYNO").toString());
					mv.addObject("FileSub", imgList);
				}
			}
			
			action = "update";
		}else {
			action = "insert";
		}
		
		//첨부파일 확장자
		String fileExt = "bmp,jpg,png,gif,jpeg";
		mv.addObject("FILES_EXT_DECODE", fileExt);
		mv.addObject("FILES_EXT_ENCODE", AES256Cipher.encode(fileExt));
		mv.addObject("action", action);
		
		return mv;
	}
	
	@RequestMapping(value= "/txap/map/mapAction.do")
	public ModelAndView Action(
		HttpServletRequest req
		, @RequestParam(value="action", defaultValue="") String action
		, @RequestParam(value = "FM_KEYNO", required = false) String FM_KEYNO
		, @RequestParam(value = "pageIndex", required = false) String pageIndex
		, MapDTO map
		, RedirectAttributes redirectAttributes
			) throws Exception {
		ModelAndView mv = new ModelAndView();
		if(action != null) {
			if(action.equals("insert")) {
				Component.createData("map.MMA_Insert", map);
				redirectAttributes.addFlashAttribute("key",map.getMMA_KEYNO());
			}else if(action.equals("update")) {
				Component.updateData("map.MMA_Update", map);
				redirectAttributes.addFlashAttribute("key",map.getMMA_KEYNO());
			}else if(action.equals("delete")){
				Component.updateData("map.MMA_DELETE", map);
			}
		}
		mv.setViewName("redirect:/txap/map/map.do");
		return mv;
	}
	
	/**
	 *체크된거 삭제하기
	 */
	@RequestMapping(value = "/txap/map/checkDelete.do")
	@Transactional
	@ResponseBody
	public void checkDelete(
				HttpServletRequest req
				, RedirectAttributes redirectAttributes
			) throws Exception{
		
		String[] KeyList = req.getParameterValues("keylist");
		
		Component.deleteData("map.MMA_AllDelete", CommonService.createMap("KeyList", KeyList));
		
	}
	
	
	
	//----------------------------------------------------서브 ----------------------------------------------
	
	
	@RequestMapping(value = "/txap/map/mapSub.do")
	public ModelAndView MapSub(
			HttpServletRequest req
			, @RequestParam(value="key", required=false) String key
			) throws Exception{
		ModelAndView mv = new ModelAndView("/txap/map/sub/pra_map_Sub.adm");

		String number = "";
		
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(req);
        if(null != inputFlashMap) {
            key = (String) inputFlashMap.get("key");
            number = (String) inputFlashMap.get("pageIndex");
        }
		
        mv.addObject("key", key);
        
		return mv;
	}
	
	@RequestMapping(value = "/txap/map/sub/pagingAjax.do")
	public ModelAndView mapSubAjax(
			HttpServletRequest req
			, Common search
			) throws Exception{
		ModelAndView mv = new ModelAndView("/txap/map/sub/pra_map_list_Sub");

		List<HashMap<String,Object>> searchList = Component.getSearchList(req);
		
		Map<String,Object> map = CommonService.ConverObjectToMap(search);
		
		if(searchList != null){
			map.put("searchList", searchList);
		}
		
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(),"mapSub.MMS_getDataListCnt",map, search.getPageUnit(), 10);
		
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		
		List<HashMap<String,Object>> resultList = Component.getList("mapSub.MMS_getDataList", map); 
		mv.addObject("resultList", resultList);
		mv.addObject("search", search);
		
		return mv;
	}
	
	
	@RequestMapping(value = "/txap/map/dataAjaxSub.do")
	@ResponseBody
	public ModelAndView SubDataAjax(
			HttpServletRequest req
			, @RequestParam(value="key", required=false) String key
			) throws Exception{
		ModelAndView mv = new ModelAndView("/txap/map/sub/pra_map_actionView_Sub");
		
		String action = "";
		
		MapDTO map = new MapDTO();
		map.setMMS_KEYNO(key);
		
		List<MapDTO> MainList  = Component.getListNoParam("mapSub.MMS_MMA_getTitle");
		
		
		
		if(StringUtils.isNotEmpty(key)){
			map = Component.getData("mapSub.MMS_Pra_getData", map);
			mv.addObject("resultData", map);
			
			if(StringUtils.isNotEmpty(map.getMMS_FM_KEYNO()) && ! map.getMMS_FM_KEYNO().equals("")){
				List<FileSub> imgList = new ArrayList<>();
				imgList = Component.getList("File.AFS_FileSelectPutMainkey",map.getMMS_FM_KEYNO());
				mv.addObject("FileSub", imgList);
			}
			
			action = "update";
		}else {
			action = "insert";
		}
		
		//첨부파일 확장자
		String fileExt = "bmp,jpg,png,gif,jpeg";
		mv.addObject("FILES_EXT_DECODE", fileExt);
		mv.addObject("FILES_EXT_ENCODE", AES256Cipher.encode(fileExt));
		mv.addObject("action", action);
		mv.addObject("MainList", MainList);
		
		return mv;
	}
	
	@RequestMapping(value= "/txap/map/mapSubAction.do")
	public ModelAndView SubAction(
		HttpServletRequest req
		, @RequestParam(value="action", defaultValue="") String action
		, @RequestParam(value = "FM_KEYNO", required = false) String FM_KEYNO
		, @RequestParam(value = "pageIndex", required = false) String pageIndex
		, MapDTO map
		, RedirectAttributes redirectAttributes
			) throws Exception {
		ModelAndView mv = new ModelAndView();
		if(action != null) {
			if(action.equals("insert")) {
				Component.createData("mapSub.MMS_Insert", map);
				redirectAttributes.addFlashAttribute("key",map.getMMS_KEYNO());
			}else if(action.equals("update")) {
				Component.updateData("mapSub.MMS_Update", map);
				redirectAttributes.addFlashAttribute("key",map.getMMS_KEYNO());
			}else if(action.equals("delete")){
				Component.updateData("mapSub.MMS_DELETE", map);
			}
		}
		mv.setViewName("redirect:/txap/map/mapSub.do");
		return mv;
	}
	
	/**
	 *체크된거 삭제하기
	 */
	@RequestMapping(value = "/txap/map/checkDeleteSub.do")
	@Transactional
	@ResponseBody
	public void SubcheckDelete(
				HttpServletRequest req
				, RedirectAttributes redirectAttributes
			) throws Exception{
		
		String[] KeyList = req.getParameterValues("keylist");
		
		Component.deleteData("mapSub.MMS_AllDelete", CommonService.createMap("KeyList", KeyList));
		
	}
}
